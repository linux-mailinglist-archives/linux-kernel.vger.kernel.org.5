Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E87E791597
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345946AbjIDKR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjIDKRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:17:25 -0400
X-Greylist: delayed 416 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Sep 2023 03:17:21 PDT
Received: from smtp96.ord1d.emailsrvr.com (smtp96.ord1d.emailsrvr.com [184.106.54.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739EFBD;
        Mon,  4 Sep 2023 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1693822225;
        bh=j5N50ZOaven0TtBbPbaqupFjo5/8G/SbgCKNAaTubJk=;
        h=Date:Subject:To:From:From;
        b=P5NLg8SdX3/jqP3cb0k9scIzf2qVBxnZMz7OcCEcSqs1VmgSo3078LqplVDwzYeD2
         foY5tRECPIK346kMeTJwPi+/nHDXf+7wgSaOdcyWkvpBOcA9y0gwDrUb9I2BAdw+U5
         DV0yoiZ/wxTqsoC083/VI0It29cj9w/++feXlkgA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp13.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 61F8DC008E;
        Mon,  4 Sep 2023 06:10:24 -0400 (EDT)
Message-ID: <f0e88ae3-d38e-40d1-900c-395ddc9c8231@mev.co.uk>
Date:   Mon, 4 Sep 2023 11:10:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: Fix driver module dependencies since HAS_IOPORT
 changes
To:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        stable@vger.kernel.org
References: <20230901192615.89591-1-abbotti@mev.co.uk>
 <33c2292b-08cb-44c7-9438-07d4060976ab@app.fastmail.com>
Content-Language: en-GB
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <33c2292b-08cb-44c7-9438-07d4060976ab@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: fc562194-64da-424b-94ba-e20d3275efaf-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2023 16:49, Arnd Bergmann wrote:
> On Fri, Sep 1, 2023, at 15:26, Ian Abbott wrote:
>> Commit b5c75b68b7de ("comedi: add HAS_IOPORT dependencies") changed the
>> "select" directives to "depend on" directives for several config
>> stanzas, but the options they depended on could not be selected,
>> breaking previously selected options.
> 
> Right, I think that correctly describes the regression, sorry I didn't
> catch that during the submission.
> 
>>   Change them back to "select"
>> directives and add "depends on HAS_IOPORT" to config entries for modules
>> that either use inb()/outb() and friends directly, or (recursively)
>> depend on modules that do so.
> 
> This also describes a correct solution to the problem, but from looking
> at your patch, I think it's not exactly what you do.
> 
>>
>>   config COMEDI_PCL711
>>   	tristate "Advantech PCL-711/711b and ADlink ACL-8112 ISA card support"
>> -	depends on HAS_IOPORT
>> -	depends on COMEDI_8254
>> +	select COMEDI_8254
> 
> If COMEDI_8254 depends on HAS_IOPORT, you must not drop the 'depends on'
> here, otherwise you get build failures from missing dependencies.
> 
> Same thing for a lot of the ones below. You should only change the
> select, but not remove the 'depends on HAS_IOPORT' in any of these,
> unless the entire Kconfig file already has this.

I assumed it was OK because it is only selectable if 'ISA' is selected 
and all the other ISA card drivers that use inb()/outb() and friends do 
not depend on 'HAS_IOPORT' either.

>> @@ -512,7 +500,7 @@ config COMEDI_NI_ATMIO16D
>>
>>   config COMEDI_NI_LABPC_ISA
>>   	tristate "NI Lab-PC and compatibles ISA support"
>> -	depends on COMEDI_NI_LABPC
>> +	select COMEDI_NI_LABPC
>>   	help
>>   	  Enable support for National Instruments Lab-PC and compatibles
>>   	  Lab-PC-1200, Lab-PC-1200AI, Lab-PC+.
> 
> I was confused a bit by this, as the changelog doesn't mention
> COMEDI_NI_LABPC, but I saw that this needs the same change
> recursively, same as COMEDI_DAS08.
> 
>> @@ -576,7 +564,7 @@ endif # COMEDI_ISA_DRIVERS
>>
>>   menuconfig COMEDI_PCI_DRIVERS
>>   	tristate "Comedi PCI drivers"
>> -	depends on PCI && HAS_IOPORT
>> +	depends on PCI
>>   	help
>>   	  Enable support for comedi PCI drivers.
>>
>> @@ -587,6 +575,7 @@ if COMEDI_PCI_DRIVERS
>>
>>   config COMEDI_8255_PCI
>>   	tristate "Generic PCI based 8255 digital i/o board support"
>> +	depends on HAS_IOPORT
>>   	select COMEDI_8255
>>   	help
>>   	  Enable support for PCI based 8255 digital i/o boards. This driver
> 
> This change looks unrelated to both your description and
> the bug, as you are just moving around the dependencies,
> though I might be missing something.

I'm just moving the 'HAS_IOPORT' dependency down from 
'COMEDI_PCI_DRIVERS' to its dependents.  Not all comedi PCI drivers use 
I/O ports, although some of the drivers that do not use I/O ports do 
depend on 'COMEDI_8254' and 'COMEDI_8255' which do depend on 'HAS_IOPORT'.

> If this addresses another problem for you, maybe split it out
> into a separate patch and describe why you move the dependencies.

I'm just correcting one patch with one patch, so don't really want to 
split it.  I could improve the patch description though.

> Are you trying to make sure that it's possible to build PCI
> IIO drivers that don't depend on HAS_IOPORT on targets that
> don't provide it?

Yes (well, PCI comedi drivers rather than IIO drivers).  I still need to 
do something about the PCI drivers that depend on COMEDI_8254 or 
COMEDI_8255 but don't actually use the I/O port functionality of the 
comedi_8254 and comedi_8255 modules, but that can be done in other patch 
that modifies the drivers.

> 
>> @@ -735,8 +738,8 @@ config COMEDI_ADL_PCI9111
>>
>>   config COMEDI_ADL_PCI9118
>>   	tristate "ADLink PCI-9118DG, PCI-9118HG, PCI-9118HR support"
>> +	depends on HAS_IOPORT
>>   	depends on HAS_DMA
>> -	depends on COMEDI_8254
>>   	help
>>   	  Enable support for ADlink PCI-9118DG, PCI-9118HG, PCI-9118HR cards
> 
> I don't see why you'd remove the 'depends on COMEDI_8254' here
> rather than turning it back into 'select' as it was originally.

Oops!  That's an error on my part.  Thanks for catching it!

> 
> It might be easier to revert the original patch, and then follow
> up with a fixed version.

Will any random config builds break in 6.5 stable if the original patch 
is reverted, or is the 'HAS_IOPORT' stuff still in preparation for 
future use?

> 
>        Arnd

Cheers,
Ian

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

