Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F227C7805
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442704AbjJLUnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbjJLUnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:43:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F40DC0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:43:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7388FC433C8;
        Thu, 12 Oct 2023 20:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697143429;
        bh=1qxJg5+j9FJGAfywTfM++up5rCZnKv8AEAHUzemY4yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rnhjuxLAXn08gU7SSWiaXeSQ/z40RDPINScZOQUn+20Z9DUUmXFf/THtAab3m3nmf
         r37qxmYeB8UeoMrO4ljLr/FHX/xrjZJhNZ8hT84NxmkZ0WYbF2xDS5pYLowofABtSF
         NTcxbMXDsuyLND8FICU3XacuSAFv+r8gFj9yOkIM6Ndt5neWKvwdw/waAm09SBssWu
         54T6n4a3noGyYlAW1S2OZ6ZP/fTN2NUkiYgVh/H+SxGG5E/tlFOqhS1It0qkOZLGou
         OR59fXT0SypmpJzz3lwfXT3fox3vvR+MjBZNAEstoeGxwPx1BXlYMEyCRN9X6Y9A2/
         QD06Tsc1gDbcg==
Date:   Thu, 12 Oct 2023 13:43:47 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de, bp@alien8.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <20231012204347.4aei5jr64fsv2iv5@treble>
References: <20231010103028.4192223-1-leitao@debian.org>
 <ZSca08rnmZfkONEH@gmail.com>
 <ZSfucR6docdnLznb@gmail.com>
 <20231012170548.o5vi4kgpvpjyld7s@treble>
 <ZShALJDaxJ9VJvek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZShALJDaxJ9VJvek@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 08:51:24PM +0200, Ingo Molnar wrote:
> > Another way to avoid ifdeffery:
> > 
> > static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
> > 	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;
> 
> I think we could make it a simple:
> 
> 	static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init = IS_ENABLED(CONFIG_MITIGATION_RETBLEED);
> 
> Because RETBLEED_CMD_AUTO && RETBLEED_CMD_OFF maps naturally to 1 and 0. 
> Maybe add a comment to the enum to maintain this property in the future 
> too.

Hm, that both obfuscates the default and makes it fragile.  The fact
that it would need a comment to try to prevent breaking it in the future
is a clue that maybe we shouldn't do it ;-)

-- 
Josh
