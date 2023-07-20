Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC24A75B058
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjGTNrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGTNrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:47:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7541986
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:47:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689860839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AXu+4A6x1MU4/HvlWN0Fog/HegGVLdmneX1fhl65FaA=;
        b=AFasVauAu1cCBEo0jcaEzmfsIej5h319IxftWVvuRS5NAI9Tifwjy9m9laET8EUXPZbrkm
        T2lMjJoRaytmFvw48u7vrIWapndF9lb2SJIXGXo45VlV7XITaveIGnqqEeiI9yIpV/gblF
        P09Srx1DibFVgEOwo+yPSHB8lRkAl7XjtcET5IDkwaHsGvoUBxl8XfJ4GCGs6p/kuBrCQw
        PnMq4fd6jF67DopkGGTpVMOzqsdmGbaWv0n3P4Zt0xnBMmnYVN06MOsQ82nzrhKR5E7/M6
        mIceIEeH2OEmSKAxLKBA7ToRYKqiN1lQlLMwlHeRfbxP8NVE8BA/En92hDORZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689860839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AXu+4A6x1MU4/HvlWN0Fog/HegGVLdmneX1fhl65FaA=;
        b=QkPWBNz2SGQDC4iqPIQcnY8SNHgMuhigEfL3sbB7eyD3n4Fcv8ZG396HiX95yfQ/GU4B4W
        8jQDxBDNrPQd15BA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch 00/58] x86/apic: Decrapification and static calls
In-Reply-To: <20230720131316.GD3569127@hirez.programming.kicks-ass.net>
References: <20230717223049.327865981@linutronix.de>
 <502aa1d5-97a0-7787-1d9c-486f351fe9c5@free.fr>
 <20230720131316.GD3569127@hirez.programming.kicks-ass.net>
Date:   Thu, 20 Jul 2023 15:47:19 +0200
Message-ID: <87y1ja3daw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20 2023 at 15:13, Peter Zijlstra wrote:
> On Thu, Jul 20, 2023 at 02:43:55PM +0200, Marc Gonzalez wrote:
>> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts cpuid aperfmperf pni dtes64 monitor ds_cpl vmx tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm tpr_shadow vnmi flexpriority vpid dtherm
>> vmx flags	: vnmi flexpriority tsc_offset vtpr vapic
>> bugs		:
>> bogomips	: 2400.76
>> clflush size	: 64
>> cache_alignment	: 64
>> address sizes	: 32 bits physical, 48 bits virtual
>> power management:
>
> But that's a 64bit chip, no? lm, cx16

The fun is that this is one of those chips which are per technical
specification not supporting long mode. They advertise long mode in
CPUID and it actually works. There are quite a few ATOM models out there
which have the same "feature".

Thansk,

        tglx
