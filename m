Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59EB77E8BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345268AbjHPS3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345514AbjHPS3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:29:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6619412C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03CA96649F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 18:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F76DC433C7;
        Wed, 16 Aug 2023 18:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692210582;
        bh=RGFy40LqyqVXhr2GAjk13ra/WdLLa4vI9Yi3XWkgKko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AF8rteB9kiNdsg6NGVRKKDaJzv/qcm406PKbGPkScyy7R+mjWon4QGS3c9N0uuFPv
         BwIQclctng/n5twC13WvaHCtcWBh1qjin0Mbq3sE0U5WxpoiXC4Wvwo3XWxih8lHho
         H0oGpkJETyPra3KTQVL0TJHl7JteMytb08EcReXGrLu+peccNx4UB9WnGssnWCxTRX
         4TPdeOXHvtKJCzjX4Ck/nzdZkcGTcDsmR2SmZ0aEuvKKuD9Qn6wKc4q3gey/KERpY1
         XOgs3t3TYmeW/nTr6/HwymnxG+fWblYn85gQU2ie6MrM3m3lFn9H9eOI2OiNhtX73b
         JwOmBI8nICSvg==
Date:   Wed, 16 Aug 2023 11:29:40 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/srso: Correct the mitigation status when SMT is
 disabled
Message-ID: <20230816182940.xw67h5xbilqpb5au@treble>
References: <20230814202545.GKZNqNybUnKv+xyrtP@fat_crate.local>
 <20230814205300.krikym7jeckehqik@treble>
 <20230814211727.GLZNqZ5+flxtyaDjMQ@fat_crate.local>
 <20230815095724.GBZNtMBPUJSEegviJN@fat_crate.local>
 <20230815195831.2opbgrznnpszaa32@treble>
 <20230815201753.GGZNvdcbPHXtEXn4As@fat_crate.local>
 <20230815212751.xhsyn7iwj2gwpuk5@treble>
 <20230816083057.GCZNyJQVARsxD3rNAm@fat_crate.local>
 <20230816160757.oegndrcnf2fvt7l3@treble>
 <20230816173531.GMZN0I40DEFE38Zxuz@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816173531.GMZN0I40DEFE38Zxuz@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 07:35:31PM +0200, Borislav Petkov wrote:
> On Wed, Aug 16, 2023 at 09:07:57AM -0700, Josh Poimboeuf wrote:
> > In this case srso_show_state() is never called, so the following code
> > can't run:
> > 
> > +	if (boot_cpu_has(X86_FEATURE_SRSO_NO)) {
> > +		if (sched_smt_active())
> > +			return sysfs_emit(buf, "Not affected\n");
> 
> Ofc it can. If something has set X86_FEATURE_SRSO_NO early, before the
> bug bits detection happens, then you get:
> 
> $ cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
> Not affected

No, if the bug bit isn't set then that comes from cpu_show_common():

static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
			       char *buf, unsigned int bug)
{
	if (!boot_cpu_has_bug(bug))
		return sysfs_emit(buf, "Not affected\n");

-- 
Josh
