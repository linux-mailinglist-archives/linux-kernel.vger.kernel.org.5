Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1653779171E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349865AbjIDMcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242403AbjIDMcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:32:13 -0400
X-Greylist: delayed 549 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Sep 2023 05:32:09 PDT
Received: from smtp117.iad3a.emailsrvr.com (smtp117.iad3a.emailsrvr.com [173.203.187.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A191AD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1693830179;
        bh=jx3Lu5Uup9dS6lw8CJ9Fiebmv4UH0r5QnnML+oyKcAE=;
        h=Date:Subject:From:To:From;
        b=vEzQXb4txhcSJRd41GZcVR3mduKRkX0oCM5qrdtTIjP6+UXY1HwyV3jGs1PQl1ESr
         e8ItodCg+z4QyNLjQdzw51H7ST5oqMKfzh/H8d8vE4c7K/t+dVqmPaOqFrlt7aIPk7
         Kic8j+vHiL3xQE9mO30Oh+SokHhZ7yhMTit9m5ZM=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp31.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 6D28D247A0;
        Mon,  4 Sep 2023 08:22:58 -0400 (EDT)
Message-ID: <191d21d7-e760-4b8d-a79f-8943329f7148@mev.co.uk>
Date:   Mon, 4 Sep 2023 13:22:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: Fix driver module dependencies since HAS_IOPORT
 changes
Content-Language: en-GB
From:   Ian Abbott <abbotti@mev.co.uk>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        stable@vger.kernel.org
References: <20230901192615.89591-1-abbotti@mev.co.uk>
 <33c2292b-08cb-44c7-9438-07d4060976ab@app.fastmail.com>
 <f0e88ae3-d38e-40d1-900c-395ddc9c8231@mev.co.uk>
 <65d620b2644e2d60b041815fa4bb544a818ae55a.camel@linux.ibm.com>
 <ab5baa69-ae3c-4973-8563-670395a3c976@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <ab5baa69-ae3c-4973-8563-670395a3c976@mev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Classification-ID: 906ab009-f130-4589-b21d-a670785a998c-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 13:01, Ian Abbott wrote:
> On 04/09/2023 12:23, Niklas Schnelle wrote:
>> On Mon, 2023-09-04 at 11:10 +0100, Ian Abbott wrote:
>>> On 03/09/2023 16:49, Arnd Bergmann wrote:
>>>> On Fri, Sep 1, 2023, at 15:26, Ian Abbott wrote:
>>>>> Commit b5c75b68b7de ("comedi: add HAS_IOPORT dependencies") changed 
>>>>> the
>>>>> "select" directives to "depend on" directives for several config
>>>>> stanzas, but the options they depended on could not be selected,
>>>>> breaking previously selected options.
>>>>
>> ---8<---
>>>>> @@ -735,8 +738,8 @@ config COMEDI_ADL_PCI9111
>>>>>
>>>>>    config COMEDI_ADL_PCI9118
>>>>>        tristate "ADLink PCI-9118DG, PCI-9118HG, PCI-9118HR support"
>>>>> +    depends on HAS_IOPORT
>>>>>        depends on HAS_DMA
>>>>> -    depends on COMEDI_8254
>>>>>        help
>>>>>          Enable support for ADlink PCI-9118DG, PCI-9118HG, 
>>>>> PCI-9118HR cards
>>>>
>>>> I don't see why you'd remove the 'depends on COMEDI_8254' here
>>>> rather than turning it back into 'select' as it was originally.
>>>
>>> Oops!  That's an error on my part.  Thanks for catching it!
>>>
>>>>
>>>> It might be easier to revert the original patch, and then follow
>>>> up with a fixed version.
>>>
>>> Will any random config builds break in 6.5 stable if the original patch
>>> is reverted, or is the 'HAS_IOPORT' stuff still in preparation for
>>> future use?
>>>
>>
>> The patch that finally compile-time disables I/O port accesses as well
>> as a few others are still not merged. I was away for a few weeks and
>> also still have a few todos. I also and found a few things needed for
>> new changes. So no a revert will not break compiles or anything like
>> that.
> 
> Thanks for the confirmation.  Will it be safe to assume that anything 
> that selects ISA will also select HAS_IOPORT?  That is trivially the 
> case for arch/{alpha,arm,x86}; arch/mips explicitly selects HAS_IOPORT 
> if ISA is selected; arch/powerpc explicitly selects HAS_IOPORT if PCI is 
> selected and it is only possible to configure ISA if PPC_CHRP is 
> configured which selects FORCE_PCI and therefore selects PCI and 
> therefore selects HAS_IOPORT; arch/um does not select HAS_IOPORT and 
> although it has a 'config ISA', nothing appears to select it.  None of 
> the remaining arch/* have 'select ISA'.

Another quick question: Will dummy versions of request_region(), 
request_muxed_region() and release_region() (and the devm variants) 
exist in the future even if HAS_IOPORT is not selected?  If so, I guess 
any drivers that only use inb()/outb() and friends on successfully 
requested regions can safely replace inb()/outb() and friends with 
conditionally compiled wrappers.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

