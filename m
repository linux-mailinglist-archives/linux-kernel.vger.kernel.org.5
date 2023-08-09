Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C417762A7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjHIOjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjHIOjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:39:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078431FD8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:39:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91E7063C42
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355A2C433C8;
        Wed,  9 Aug 2023 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691591960;
        bh=QRfIVjxokdqd4peipgWfyQom9z9hT/VPZ3KO+fx9HhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CuDwlQgxkZYXahCf5Dz+vrsi0Ho/5QzxE2Dnztl20VYeGDyDdA4hwDvmeRCU3BvHL
         fOLIjs9hWViSz02Sedcq+Is+W3rPfCdMXm41XsA33eS0weAEKeK+wbxrexD70ci5ke
         zxDeCBwYy1CsDBEdKCVk4fDYlPN8rkZ5xCzmIxO+me3pizYXHYqFFKwN11KBlV8D6e
         PuZpEBuO81Ot9Ct2n2gpAXYvRTac3AS5dsvGHRAXeXOy/XPISF0e4Cw7s5YACQN2+v
         kTTwv8kLXudXe/LzbJ2tAG6+PHyNIE1v2tyFogf6JI9MVeo4vP6Ns0ITTs4bV6uQEI
         vDmcE2kBthCjg==
Date:   Wed, 9 Aug 2023 10:39:16 -0400
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Andrew.Cooper3@citrix.com
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Message-ID: <20230809143916.6e6jod3zu2svnrl5@treble>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
 <20230809134233.d7hlutglk2j3f4w3@treble>
 <0ff5cabb-835f-2183-c8a5-5308e23e7f6f@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ff5cabb-835f-2183-c8a5-5308e23e7f6f@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:31:20PM +0100, Andrew.Cooper3@citrix.com wrote:
> On 09/08/2023 2:42 pm, Josh Poimboeuf wrote:
> > On Wed, Aug 09, 2023 at 09:12:24AM +0200, Peter Zijlstra wrote:
> >> +	if (boot_cpu_has_bug(X86_BUG_SRSO)) {
> >> +		has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) || cpu_has_ibpb_brtype_microcode();
> >> +		if (!has_microcode) {
> >> +			pr_warn("IBPB-extending microcode not applied!\n");
> >> +			pr_warn(RETBLEED_SRSO_NOTICE);
> >> +		} else {
> >> +			/*
> >> +			 * Enable the synthetic (even if in a real CPUID leaf)
> >> +			 * flags for guests.
> >> +			 */
> >> +			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
> >> +			setup_force_cpu_cap(X86_FEATURE_SBPB);
> >> +
> >> +			/*
> >> +			 * Zen1/2 with SMT off aren't vulnerable after the right
> >> +			 * IBPB microcode has been applied.
> >> +			 */
> >> +			if ((boot_cpu_data.x86 < 0x19) &&
> >> +			    (cpu_smt_control == CPU_SMT_DISABLED))
> >> +				setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
> > The rumor I heard was that SMT had to be disabled specifically by BIOS
> > for this condition to be true.  Can somebody from AMD confirm?
> 
> It's Complicated.
> 
> On Zen1/2, uarch constraints mitigate SRSO when the core is in 1T mode,
> where such an attack would succeed in 2T mode.  Specifically, it is
> believed that the SRSO infinite-call-loop can poison more than 16
> RSB/RAS/RAP entries, but can't poison 32 entries.
> 
> The RSB dynamically repartitions depending on the idleness of the
> sibling.  Therefore, offlining/parking the siblings should make you
> safe.  (Assuming you can handwave away the NMI hitting the parked thread
> case as outside of an attackers control.)
> 
> 
> In Xen, I decided that synthesizing SRSO_NO was only safe when SMT was
> disabled by firmware, because that's the only case where it can't cease
> being true later by admin action.
> 
> If it were just Xen's safety that mattered here it might be ok to allow
> the OS SMT=0 cases, but this bit needs to get into guests, you can't
> credibly tell the guest SRSO_NO and then make it unsafe at a later point.

Thanks for that explanation.  It sounds like we can use
!cpu_smt_possible() here.

-- 
Josh
