Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7983377E608
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344506AbjHPQIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344613AbjHPQIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:08:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8C42715
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:08:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4DFF6222F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB542C433C9;
        Wed, 16 Aug 2023 16:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692202079;
        bh=BAWiaWHYTV+68J74mvFermbIes046SHmjojDedFVyVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mVonPNPU5EFfrDyUnAlUobgFjZrqGeQlTLKgij71XT/QhV3N6PQkg3leHmtazmTUy
         JMXEGmV0JTJrxoz3na8m0fjR1mLsjPmkrdwNznqHzFVjs6Q3dl2b3YI93CWiV9wYUJ
         8pox89bbuBTtFLNmWAkx5qiyAbS4H2Lp92GCtf2Y+22J+9kKQW2XaYyPT6VysPNrta
         z1bugKx3gCrEqxQj7GJch8kRrQ7RqXoqQdoaDySPZUS4JJEvDMRPgbDOHOExYpq7/E
         SITZdrTjSN6lWmh8AhLDEQe/ZLFIOLWnQtwv05fMaXW5JF6MdhuWdpSn96lDnP5Pcy
         +2tEiyT3Heo3A==
Date:   Wed, 16 Aug 2023 09:07:57 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/srso: Correct the mitigation status when SMT is
 disabled
Message-ID: <20230816160757.oegndrcnf2fvt7l3@treble>
References: <1588ed00-be11-ff9d-e4c2-12db78cca06f@suse.com>
 <20230814200813.p5czl47zssuej7nv@treble>
 <20230814202545.GKZNqNybUnKv+xyrtP@fat_crate.local>
 <20230814205300.krikym7jeckehqik@treble>
 <20230814211727.GLZNqZ5+flxtyaDjMQ@fat_crate.local>
 <20230815095724.GBZNtMBPUJSEegviJN@fat_crate.local>
 <20230815195831.2opbgrznnpszaa32@treble>
 <20230815201753.GGZNvdcbPHXtEXn4As@fat_crate.local>
 <20230815212751.xhsyn7iwj2gwpuk5@treble>
 <20230816083057.GCZNyJQVARsxD3rNAm@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816083057.GCZNyJQVARsxD3rNAm@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 10:30:57AM +0200, Borislav Petkov wrote:
> On Tue, Aug 15, 2023 at 02:27:51PM -0700, Josh Poimboeuf wrote:
> > How is that relevant to my comment?  The bug bit still wouldn't get set
> > and srso_show_state() still wouldn't be called.
> 
> Lemme explain how I see this working - it might help us get on the right
> track. And for comparison you can look at X86_FEATURE_BTC_NO too.
> 
> * Something has set X86_FEATURE_SRSO_NO - hw or sw doesn't matter
> - because the machine is not affected. X86_BUG_SRSO doesn't get set and
>   the mitigation detection is skipped. All good.

In this case srso_show_state() is never called, so the following code
can't run:

+	if (boot_cpu_has(X86_FEATURE_SRSO_NO)) {
+		if (sched_smt_active())
+			return sysfs_emit(buf, "Not affected\n");

> * Nothing has set X86_FEATURE_SRSO_NO, mitigation detection runs and
> find that the kernel runs on a Zen1/2 with SMT disabled - we set
> X86_FEATURE_SRSO_NO.

In this case SMT is disabled, so the following code still can't run:

+	if (boot_cpu_has(X86_FEATURE_SRSO_NO)) {
+		if (sched_smt_active())
+			return sysfs_emit(buf, "Not affected\n");


So the above code never runs.

See?

-- 
Josh
