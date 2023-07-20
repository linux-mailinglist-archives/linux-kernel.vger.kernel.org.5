Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B598B75AF64
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGTNNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjGTNN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:13:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD41211B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=07bM1b1/PpDYq7VZxIZQoYvaB4W/LvKhF6bRGCUsDVg=; b=XVGHc0Q5DNyklbMAxmyo7iyiEY
        PQywqx6XNH792ds5qKfNXyh2hFxrfF7ItdxIbvqQq86W+Mgn9VKyoWoyGX9CkjWiqOT/IXi2kpLmp
        klRtcfSFyOUVvdqe+0dfO8V16fVGw0nSabqDWi4UhisuRzW1K5HY3RJhZ8eH+uMsQ8wsfQX2KXqJW
        XjG0LNZ6TaIQpmQxvhZyVlBJZNHzYBTHOJCTZoYqoZpt5vdy338vooPpX639DzbPmAA3d1hLPLHf2
        CQa3n1Y9r83+vbbeKXj/Jwy2h/wNDgtlSX8pBPp8/v2Yx9SFtzyqTKK6O1rF8zt4XXE+Sazgd5Uj3
        5fQOsAZQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMTT4-00Fbrm-1A;
        Thu, 20 Jul 2023 13:13:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B26C130020C;
        Thu, 20 Jul 2023 15:13:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 87D7F25F2B0C2; Thu, 20 Jul 2023 15:13:16 +0200 (CEST)
Date:   Thu, 20 Jul 2023 15:13:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch 00/58] x86/apic: Decrapification and static calls
Message-ID: <20230720131316.GD3569127@hirez.programming.kicks-ass.net>
References: <20230717223049.327865981@linutronix.de>
 <502aa1d5-97a0-7787-1d9c-486f351fe9c5@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <502aa1d5-97a0-7787-1d9c-486f351fe9c5@free.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 02:43:55PM +0200, Marc Gonzalez wrote:
> On 18/07/2023 01:14, Thomas Gleixner wrote:

> > Ideally we remove 32bit support altogether. I know the answer... :(
> 
> Hello Thomas,
> 
> For what it's worth, there are a few millions of these in the field:
> 
> # cat /proc/cpuinfo
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 28
> model name	: Intel(R) Atom(TM) CPU CE4150   @ 1.20GHz
> stepping	: 10
> microcode	: 0x106
> cpu MHz		: 1199.885
> cache size	: 512 KB
> physical id	: 0
> siblings	: 2
> core id		: 0
> cpu cores	: 1
> apicid		: 0
> initial apicid	: 0
> fdiv_bug	: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 10
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts cpuid aperfmperf pni dtes64 monitor ds_cpl vmx tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm tpr_shadow vnmi flexpriority vpid dtherm
> vmx flags	: vnmi flexpriority tsc_offset vtpr vapic
> bugs		:
> bogomips	: 2400.76
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 32 bits physical, 48 bits virtual
> power management:

But that's a 64bit chip, no? lm, cx16
