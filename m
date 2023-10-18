Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0627CE1D3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbjJRPyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjJRPyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:54:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A96B11D;
        Wed, 18 Oct 2023 08:54:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AD7C433C8;
        Wed, 18 Oct 2023 15:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697644475;
        bh=hdWu9w9T9X5QRXTNPRbC3yaWlv73qKuEfQh/KXXiF5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C1FC/5ULuzHyEE/rrGoFBtf2NqdJDMWL0V8TeH3UKiYm8vIMl2M/B/3mKeA/XbWKJ
         wJJ/Ha7eZCZV9t+QgaZ+qDjnpG7cqEMXqoOjnPVyo0Zm2sev6qpGBfIxYuXfpnyq2O
         kwzpcGhS6UO8F6IV0cLH2ZbnND+CQ2lXJv+9wqgw/GSNSIl4Opzp1epJiSoLoudj7u
         WA38GtV45lbET3Ip9Bo0oFdvhCxMIqPHbDhf6ifxQqp1bvh+fYdS2+bQtP8aGnCmyW
         UW3fRaBzWb4d/JN4Wjq7tyZ89pfT6vbOK7SQmNvl2BwffqoGQsX4Vun1Xb7tpf0w0w
         oU3zP/VMn9Hzw==
Date:   Wed, 18 Oct 2023 08:54:33 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231018155433.z4auwckr5s27wnig@treble>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
 <ZS/f8DeEIWhBtBeb@gmail.com>
 <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 05:12:45PM +0200, Borislav Petkov wrote:
> On Wed, Oct 18, 2023 at 03:38:56PM +0200, Ingo Molnar wrote:
> > If then WARN_ONCE().
> 
> WARN_ONCE() is not enough considering that if this fires, it means we're
> not really properly protected against one of those RET-speculation
> things.
> 
> It needs to be warning constantly but then still allow booting. I.e,
> a ratelimited warn of sorts but I don't think we have that... yet.

I'm not sure a rate-limited WARN() would be a good thing.  Either the
user is regularly checking dmesg (most likely in some automated fashion)
or they're not.  If the latter, a rate-limited WARN() would wrap dmesg
pretty quickly.

-- 
Josh
