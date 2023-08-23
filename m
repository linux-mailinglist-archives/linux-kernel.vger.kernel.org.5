Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09A87863D8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 01:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbjHWXCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 19:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbjHWXC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 19:02:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63FAE6A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:02:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BF2C621A7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151B1C433C8;
        Wed, 23 Aug 2023 23:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692831744;
        bh=WhX3zLWGYSRH2yPGhaYBMOCl/7AhpHMP0Lzuwzz0UdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qiM3D0H/zZdxxW/pxQT/vqg9OJKDh4C4BuD1yQUOTeK8qOk6wWODdpUffpphjGrwT
         4/2wbNvRoOt6haZV1PtK/np8hU+f2Ouqx/V3SmEPhtNoKbJfEXg+Lz/9rnwL1/12L3
         24LUtnfJrXqG4YjYH+qSqZioNaUNd2Rici5LwiN8Wr95dQrecADJjbvRhvuHM6Fl/Q
         mgU6gmyOb3e/Dv9tnD9yiSGrsJ3FPUs+0Vgbg5SKUQ1/Mp2Cd3TscFzSpyHLji3+xe
         GPv7IqXBWZYzhkpg1e3An3t50m67oyAgEV1cRptEZrkRO3hltYXGe3k38B3FZGyyDc
         K8YXiq5m914xw==
Date:   Wed, 23 Aug 2023 16:02:22 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 05/22] x86/srso: Fix SBPB enablement for mitigations=off
Message-ID: <20230823230222.a3eqe6h3qvzrrulz@treble>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <141c92f20ab46cf0c028e86b946134cd702d0ea5.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <141c92f20ab46cf0c028e86b946134cd702d0ea5.1692580085.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 06:19:02PM -0700, Josh Poimboeuf wrote:
> If the user has requested no mitigations with mitigations=off, use the
> lighter-weight SBPB instead of IBPB for other mitigations.
> 
> Note that even with mitigations=off, IBPB/SBPB may still be used for
> Spectre v2 user <-> user protection.  Whether that makes sense is a
> question for another day.
> 
> Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/kernel/cpu/bugs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 10499bcd4e39..ff5bfe8f0ee9 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2496,8 +2496,7 @@ static void __init srso_select_mitigation(void)
>  	pr_info("%s%s\n", srso_strings[srso_mitigation], (has_microcode ? "" : ", no microcode"));
>  
>  pred_cmd:
> -	if ((boot_cpu_has(X86_FEATURE_SRSO_NO) || srso_cmd == SRSO_CMD_OFF) &&
> -	     boot_cpu_has(X86_FEATURE_SBPB))
> +	if (boot_cpu_has(X86_FEATURE_SBPB) && srso_mitigation == SRSO_MITIGATION_NONE)
>  		x86_pred_cmd = PRED_CMD_SBPB;

Actually, I remembered this patch had another purpose.  On future HW, if
SRSO_NO is not set by the HW (which Boris said might be the case), and
the SRSO bug bit is not set, then SBPB needs to be set.

I may just get rid of this label altogether and just hard-code the
setting of x86_pred_cmd in the two places where it's needed.

-- 
Josh
