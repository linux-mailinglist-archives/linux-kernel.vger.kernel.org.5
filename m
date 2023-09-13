Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32C779EC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbjIMPEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjIMPEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:04:51 -0400
Received: from smtp78.ord1d.emailsrvr.com (smtp78.ord1d.emailsrvr.com [184.106.54.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ADAB7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694617487;
        bh=4bwdRlYwViOI0nBRI454Bo6S2CTQzWufr4IawC2v0a8=;
        h=Date:Subject:To:From:From;
        b=lbK6aMRhFyQJ7xok5tNcARHqwdjOZZnmKcwnhLupVNFgn1KpMgrvI46e+aJACM0rs
         hHGkFMf5aJ8DaPSxFYCCL5sjaI67I8b42RJ0ozurRxQKLW3wTQsEmqGm2CuQmfml6z
         X0C2fbXN4tLjxjBghqV6rcbMZH9iRztHvKyRtLgs=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp10.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 9E2D3A010E;
        Wed, 13 Sep 2023 11:04:46 -0400 (EDT)
Message-ID: <d06e124e-ea95-469b-a606-1e55806f3df0@mev.co.uk>
Date:   Wed, 13 Sep 2023 16:04:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] comedi: 8255_pci: Conditionally remove devices that
 use port I/O
Content-Language: en-GB
To:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>
References: <20230913112032.90618-1-abbotti@mev.co.uk>
 <20230913112032.90618-6-abbotti@mev.co.uk>
 <51a9af18-a5e4-4cb1-9f95-491bf73d35f1@app.fastmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <51a9af18-a5e4-4cb1-9f95-491bf73d35f1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 59f652d5-e892-4e72-a71f-9fb9465481f5-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 13:03, Arnd Bergmann wrote:
> On Wed, Sep 13, 2023, at 13:20, Ian Abbott wrote:
>> In a future patch, the port I/O functions (`inb()`, `outb()`, and
>> friends will only be declared in the `HAS_IOPORT` configuration option
>> is enabled.
>>
>> The 8255_pci module supports PCI digital I/O devices from various
>> manufacturers that consist of one or more 8255 Programmable Peripheral
>> Interface chips (or equivalent hardware) to provide their digital I/O
>> ports.  Some of the devices use port I/O and some only use memory-mapped
>> I/O.
>>
>> Conditionally compile in support for the devices that need port I/O if
>> and only if the `CONFIG_HAS_PORTIO` macro is defined.  Change
>> `pci_8255_auto_attach()` to return an error if the device actually
>> requires port I/O (based on the PCI BAR resource flags) but the
>> `HAS_IOPORT` configuration is not enabled.
>>
>> Cc: Arnd Bergmann <arnd@kernel.org>
>> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
>> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
>> ---
>>   drivers/comedi/drivers/8255_pci.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/comedi/drivers/8255_pci.c
>> b/drivers/comedi/drivers/8255_pci.c
>> index 0fec048e3a53..4c4c0ef1db05 100644
>> --- a/drivers/comedi/drivers/8255_pci.c
>> +++ b/drivers/comedi/drivers/8255_pci.c
>> @@ -57,6 +57,7 @@
>>   #include <linux/comedi/comedi_8255.h>
>>
>>   enum pci_8255_boardid {
>> +#ifdef CONFIG_HAS_PORTIO
> 
> I think this is a typo: HAS_IOPORT vs HAS_PORTIO?
> 
>       Arnd

Oops!  Well-spotted.  Actually, this affects several of the patches!

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

