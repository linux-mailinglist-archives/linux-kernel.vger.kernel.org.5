Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2616780111B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjLAQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLAQQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:16:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79720199D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:16:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6B6C433C8;
        Fri,  1 Dec 2023 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701447372;
        bh=YlEMUCQH+3T1yvOEG3nI8rm7boerLN9aqXrhBnxcKaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jBA0AQLjW90sAkd+I+zzy5Ui9ZMQJsFQl2hMAoP2tXCT2NJJvPybtW8LbmZQAJ5Rc
         QbrNEvnZNGn3v2gkQVZChPZX7UFq92mQBFqZPk7S6H9RwOAYT5qBm1GsktW0WZl/4C
         GNrX6RWZUfwt++VmH4J68HGqEQoPTZVmuPgnhcAN0gaqNyb24akJ1pF0AaIOsNKjtS
         eoB7OSUkCcc72OhCJw1PstwrrwSnwG7vbIkHdzAHoAWVzN/jajMsG5sqJyrV8vTU1w
         udFfgGd4gopKCiLslwthuNmuSNAgOXmBtrxhs936Bg4myRNxNU/RVE63BbIPFjFc95
         yHC0gzhqKGHdg==
Date:   Fri, 1 Dec 2023 09:16:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/Kconfig: Disable KASLR on debug builds
Message-ID: <20231201161610.GA2948377@dev-arch.thelio-3990X>
References: <20231130120552.6735-1-bp@alien8.de>
 <20231130181051.GA3357088@dev-arch.thelio-3990X>
 <20231130193428.GNZWjjxKJ38Ruh7puz@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130193428.GNZWjjxKJ38Ruh7puz@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 08:34:28PM +0100, Borislav Petkov wrote:
> On Thu, Nov 30, 2023 at 11:10:51AM -0700, Nathan Chancellor wrote:
> > I know Peter pointed out that there is a runtime switch for this, which
> > should make this patch obsolete but in case there is more reasons needed
> > for why this might be a bad idea,
> 
> Bad idea? Why?
> 
> Because they'd have EXPERT enabled and thus disable KASLR by accident
> this way?

Right, this is the diff of Fedora's configuration before and after this
change:

diff --git a/.config.old b/.config
index d5fe0c930725..d409b1738c0f 100644
--- a/.config.old
+++ b/.config
@@ -520,12 +520,8 @@ CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG=y
 CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION=y
 CONFIG_PHYSICAL_START=0x1000000
 CONFIG_RELOCATABLE=y
-CONFIG_RANDOMIZE_BASE=y
-CONFIG_X86_NEED_RELOCS=y
 CONFIG_PHYSICAL_ALIGN=0x1000000
 CONFIG_DYNAMIC_MEMORY_LAYOUT=y
-CONFIG_RANDOMIZE_MEMORY=y
-CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
 CONFIG_ADDRESS_MASKING=y
 CONFIG_HOTPLUG_CPU=y
 # CONFIG_COMPAT_VDSO is not set
