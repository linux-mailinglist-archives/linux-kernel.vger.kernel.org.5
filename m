Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DB577A125
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 18:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjHLQrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 12:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHLQrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 12:47:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D98C10CE
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 09:47:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691858824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nspaD/uAmIWqNM731GIkjfMBXb2W0vpGEj8uGwGUdNk=;
        b=dAspbu7fkTiZy8mkk/hQcMLLijsuSeLlS24Ofa0FMqsosQ35Fm4qm4PLk+tmHEvfGUUGtj
        qRNvynvADnaijxuBe5oKITazfMhLI6XXZVp190kOzBSnHVCGg/qxs/MAUVG0LG3xQ0E09z
        99yWSinRHDq2Oekb2Z56bqCBy/ZM+KtcCEgpkkTAEeYU1x40vO6/yowYCxCsGhUZ6IcM/Q
        2h2du/mQTK02wFvx/fio5+qoLHVY0xMKUW78nL4xEoWFusQQaaddWenXKYd89R/kc+gHNZ
        M15Mt5lIr8TC+AjcehKpB1/Xfce11HAkT7xlWGiNoywB4VTqfL6hBHJDzYby/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691858824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nspaD/uAmIWqNM731GIkjfMBXb2W0vpGEj8uGwGUdNk=;
        b=enuHe9Nkm8guDvrG8wABmkDODNY49y7A5XRqEhEZ8r54ovyk5pQ1NX1aNHgNbgE6UG4fGP
        dNzyjQRmwiCtwJDA==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 28/30] x86/microcode: Handle "offline" CPUs correctly
In-Reply-To: <874jl5j4y2.ffs@tglx>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.562016788@linutronix.de>
 <20230810204605.GF212435@hirez.programming.kicks-ass.net>
 <874jl5j4y2.ffs@tglx>
Date:   Sat, 12 Aug 2023 18:47:03 +0200
Message-ID: <875y5kgqd4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11 2023 at 11:36, Thomas Gleixner wrote:
> On Thu, Aug 10 2023 at 22:46, Peter Zijlstra wrote:
> OTOH, it's not really required. Right now we mandate that _all_ present
> cores have at least one sibling online. For simplicity (and practical
> reasons - think "nosmt") we require the "primary" thread to be online.
>
> Microcode is strict per core, no matter how many threads are there. We
> would not need any of this mess if Intel would have synchronized the
> threads on microcode update like AMD does. This is coming with future
> CPUs which advertise "uniform" update with a scope ranging from core,
> package to systemwide.

Which still requires the "offline" CPU treatment as the siblings are not
allowed to sit in MWAIT or HLT. So this whole NMI exercise is bound to
stay.

Thanks,

        tglx

