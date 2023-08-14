Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCB777C1D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjHNUxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjHNUxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00C61726
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:53:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C2ED64808
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEDCC433C7;
        Mon, 14 Aug 2023 20:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692046382;
        bh=XyBR3j4RRfgx19HWC6JTp88+g7mCXmQp42SAG0Yn0So=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XYqcAlAj3lPceyg0h96r/sd82AgFpuMeGtz+tYKH1MOQLy42ERVg3BBr01FEbsT+Y
         krRc/Lzhm2C9Lu5wx27YqkoPf/xSyVoy0fvxW66CLJjgAECnW08bA6rOMq2XK8WkX1
         4Cg1AGPfYyxJgT6zuFVg/P7PtRMto77HGYlBP1pc8HAwqrGdRjyhF5Fe6s4I3d2gh6
         KjWw2hlDJznTOFJwwDkZGTesc6NT6IY8F9o0vUnsfTBzzjq3bW/QLvTHpsSIqvIuFh
         wKQlnhJt9bofde8/qlxn5Nq/sk4Xek2CnYuIvU38HzN7xZldXmixAown3QFsJjEM81
         KNFsz8BsocduA==
Date:   Mon, 14 Aug 2023 13:53:00 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/srso: Disable the mitigation on unaffected
 configurations
Message-ID: <20230814205300.krikym7jeckehqik@treble>
References: <20230813104517.3346-1-bp@alien8.de>
 <1588ed00-be11-ff9d-e4c2-12db78cca06f@suse.com>
 <20230814200813.p5czl47zssuej7nv@treble>
 <20230814202545.GKZNqNybUnKv+xyrtP@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814202545.GKZNqNybUnKv+xyrtP@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 10:25:45PM +0200, Borislav Petkov wrote:
> On Mon, Aug 14, 2023 at 01:08:13PM -0700, Josh Poimboeuf wrote:
> > Tangentially, the 'cpu_smt_control == CPU_SMT_DISABLED' check is wrong,
> > as SMT could still get enabled at runtime and SRSO would be exposed.
> 
> Well, even if it gets exposed, I don't think we can safely enable the
> mitigation at runtime as alternatives have run already.

Right, I wasn't suggesting to enable the mitigation at runtime.  Rather,
enable the mitigation at boot time, if SMT is even possible.  That's
what we've done for other mitigations.  Better safe than sorry.

> I guess I could use CPU_SMT_FORCE_DISABLED here.

cpu_smt_possible() already does that.

> > Also is there a reason to re-use the hardware SRSO_NO bit
> 
> Not a hardware bit - this is set by software - it is only allocated in
> the CPUID leaf for easier interaction with guests.

2. ENUMERATION OF NEW CAPABILITIES
AMD is defining three new CPUID bits to assist with the enumeration of capabilities related to SRSO:
CPUID Fn8000_0021_EAX[29] (SRSO_NO) – If this bit is 1, it indicates the CPU is not subject to the SRSO
vulnerability.
CPUID Fn8000_0021_EAX[28] (IBPB_BRTYPE) – If this bit is 1, it indicates that MSR 49h (PRED_CMD) bit 0
(IBPB) flushes all branch type predictions from the CPU branch predictor.
CPUID Fn8000_0021_EAX[27] (SBPB)

> > rather than clear the bug bit? 
> 
> We don't clear the X86_BUGs. Ever. The logic is that if the CPU matches
> an affected CPU, that flag remains to show that it is potentially
> affected.

Hm, ok.  I thought that was the point of the vulnerabilities file.

> /sys/devices/system/cpu/vulnerabilities/ tells you what the actual state
> is.

Since technically the CPU is affected, I'm thinking it should say
"Mitigation: SMT disabled" or such, instead of "Not affected".

> > That seems cleaner, then you wouldn't need this hack:
> 
> Not a hack. This is just like the other "not affected" feature flags.

Hm?  You mean the *_NO ones that determine whether the BUG bits get set
in the first place?  How do they print "Not affected"?

-- 
Josh
