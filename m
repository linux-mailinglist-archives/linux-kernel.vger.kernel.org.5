Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC0579ED8C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjIMPpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjIMPpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:45:22 -0400
Received: from smtp95.iad3b.emailsrvr.com (smtp95.iad3b.emailsrvr.com [146.20.161.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B330BC1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694619918;
        bh=4IAUrf6lnq5lby/Fcq5iZ8ny6EV1LhE/bubOL/S9VaI=;
        h=Date:Subject:To:From:From;
        b=PR81h69xV9+LqJ3ZE3UCruaClH027rEvaHObci9DmTVQxBOgaAADuhT23qoZwwL4Y
         zfDAa0lKneAKj7CT21YZkSJySHqMeCT2fCyJ1c6AfhNffU0B5in7Mz0/W0sPZTJvPm
         S+Ra2cWv2IusHsi2hR3X3o97ypwc7WHP2poIrwQ8=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp20.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 61D72A0122;
        Wed, 13 Sep 2023 11:45:17 -0400 (EDT)
Message-ID: <79be8582-2395-42c7-92ae-29d9e4c4c33b@mev.co.uk>
Date:   Wed, 13 Sep 2023 16:45:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] comedi: ni_mio_common: Conditionally use I/O port
 or MMIO
Content-Language: en-GB
To:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>
References: <20230913112032.90618-1-abbotti@mev.co.uk>
 <20230913112032.90618-10-abbotti@mev.co.uk>
 <ca073163-d947-42f4-b45a-3ea75ab2f7fc@app.fastmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <ca073163-d947-42f4-b45a-3ea75ab2f7fc@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 096e7432-50a0-4b29-8887-a3795ef0a10f-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 13:17, Arnd Bergmann wrote:
> On Wed, Sep 13, 2023, at 13:20, Ian Abbott wrote:
>> In a future patch, the port I/O functions (`inb()`, `outb()`, and
>> friends will only be declared in the `HAS_IOPORT` configuration option
>> is enabled.
>>
>> The "ni_mio_common.c" file contains calls to both port I/O functions and
>> memory-mapped I/O functions.  The file is `#include`d by "ni_atmio.c",
>> "ni_mio_cs.c", and "ni_pcimio.c" for the ni_atmio, ni_mio_cs, and
>> ni_pcimio modules, respectively.  Only "ni_pcimio.c" defines the
>> `PCIDMA` macro before including "ni_mio_common.c" and various bits of
>> code in "ni_mio_common.c" is conditionally compiled according to whether
>> that macro is defined or not.  Currently, the port I/O function calls
>> are compiled in regardless of whether the `PCIDMA` macro is defined or
>> not.  However, the fact is that the ni_atmio and ni_mio_cs modules will
>> never call the memory-mapped I/O functions, and the ni_pcimio module
>> will never call the port I/O functions.
>>
>> Calls to the port I/O and memory-mapped I/O functions is confined to the
>> `ni_writel()`, `ni_writew()`, `ni_writeb()`, `ni_readl()`, `ni_readw()`,
>> and `ni_readb()` functions which do a run-time test to decide whether to
>> call the port I/O functions or the memory-mapped I/O functions.
>> Conditionally compile two variants of the functions so they only call
>> the port I/O functions if the `PCIDMA` macro is undefined (for the
>> ni_atmio and ni_mio_cs modules), and only call the memory-mapped I/O
>> functions if the `PCIDMA` macro is defined (for the ni_pcimio module).
>>
>> Add a run-time check in the `ni_E_init()` function to return an error if
>> the comedi device has been set up to use port I/O if `PCIDMA` is
>> defined, or has been set up to use memory-mapped I/O if `PCIDMA` is not
>> defined.
>>
>> The changes make it possible to build the ni_pcimio module even if the
>> port I/O functions have not been declared.  (The ni_atmio and ni_mio_cs
>> modules do still require the port I/O functions to be declared.)
> 
> I think this all works, but there is probably a simpler way to
> achieve the same:
>   
>> +#ifdef PCIDMA
>> +
>>   static void ni_writel(struct comedi_device *dev, unsigned int data, int reg)
>>   {
>> -	if (dev->mmio)
>> -		writel(data, dev->mmio + reg);
>> -	else
>> -		outl(data, dev->iobase + reg);
>> +	writel(data, dev->mmio + reg);
>>   }
>>
>>
>> +#else /* PCIDMA */
>> +
>> +static void ni_writel(struct comedi_device *dev, unsigned int data, int reg)
>> +{
>> +	outl(data, dev->iobase + reg);
>> +}
> 
> We already have an abstraction for this using iowrite32(),
> which turns into either writel() or outl() depending on the
> argument, so you could just use pci_iomap() or ioport_map()
> to turn port numbers into tokens suitable for the common
> helper.
> 
>       Arnd

It would affect three modules, and there are similar changes that could 
be made to other modules, so I think I'll put that suggestion on hold 
for now.  I'd also like to get rid of the '#include "ni_mio_common.c"' 
nonsense at some point, but that's a big job!

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

