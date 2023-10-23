Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873A87D3E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjJWRu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJWRuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:50:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5325BB0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:50:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698083449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFDzA2QEalhxvXe370eegaxHA4DWJLoYrZh26DZTVTA=;
        b=Ei2PYBp6yPsN2JN9ThNoVFo2Nkvmb+FdWEJNeoh90+t/SAWS7BIt1C+PYW37WNGn1z6IYv
        aSYcvGQ8S7JxVkLviVx8Cw0qTyOPyZ3NsbCBUAvDENw/Qt9mlgfA4PKAYfqV2x6PMT/9m4
        H3f9bygebYr5QuVjpaK5gq3YjYyvHjTcsF11FgNAHhcMUrUePBBRrlQ9M2G0+DAivpcQe7
        SNfIsgycOi9jX07N+AKBvFurjRcOuiMeXTltzxR/WqIyjtVDLGHfaIV5QaZs0HCDodkFAW
        /xojhZRGrK6YuSMzo9QvEiWmQCb4zsJfvEVqmmq18uGLUMsGQz2DPYa6qL4xLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698083449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFDzA2QEalhxvXe370eegaxHA4DWJLoYrZh26DZTVTA=;
        b=vUnmD1tcluHbDPPPIakdBiOyMx/2QK9myts7JOvCE1BlR3cSmqYAnzBWBtIBT3X+RlKNUl
        ZL07B6lzrCkDJ7DA==
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: PIC probing code from e179f6914152 failing
In-Reply-To: <08889426-e8e7-491b-bcc6-fd001bad3269@amd.com>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx> <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
 <87ttqhcotn.ffs@tglx> <08889426-e8e7-491b-bcc6-fd001bad3269@amd.com>
Date:   Mon, 23 Oct 2023 19:50:48 +0200
Message-ID: <87lebtcjnr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23 2023 at 11:17, Mario Limonciello wrote:
> On 10/23/2023 10:59, Thomas Gleixner wrote:
>>> IOW NULL pic case has IORESOURCE_DISABLED / IORESOURCE_UNSET
>> 
>> So the real question is WHY are the DISABLED/UNSET flags not set in the
>> PIC case?

Do you have an answer for this?
 
>>> NULL case:
>>> handler:  handle_edge_irq
>>> dstate:   0x3740c208
>>>               IRQ_TYPE_LEVEL_LOW
>>>
>>> PIC case:
>>> handler:  handle_fasteoi_irq
>>> dstate:   0x3740e208
>>>               IRQ_TYPE_LEVEL_LOW
>>>               IRQD_LEVEL
>>>
>>> I guess something related to the callpath for mp_register_handler().
>> 
>> Guessing is not helpful.
>> 
>> There is a difference in how the allocation info is set up when legacy
>> PIC is enabled, but that does not explain the above resource flag
>> difference.
>
> I did a pile of printks and that's how I realized it's because of the 
> missing call to mp_register_handler() which is dependent upon what 
> appeared to me to be a superfluous number of legacy IRQs check (patch 1 
> in my solution).

What exactly is superfluous about these legacy checks?

Thanks,

        tglx
