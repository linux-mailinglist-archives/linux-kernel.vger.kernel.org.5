Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D34277FFE4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355356AbjHQV3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355363AbjHQV3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847ECE4F;
        Thu, 17 Aug 2023 14:29:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21CA5612C5;
        Thu, 17 Aug 2023 21:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EDAC433C7;
        Thu, 17 Aug 2023 21:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692307743;
        bh=pu3waJ+52jLBtjm+Y39NiJUqOKQayZwXXePPEArE9AI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bICRVqnJyHLg+jeIiGrFkILp8a3EgQ6LR/Dt7tfBr9FnkVOmruqqR20Ik6AyUcYou
         NN1KjzTugjI9u8cM3jT7vPXXHJEjSGfM/1rI11nxe3AQ4lGK/tChhDTY5doEghswcX
         uo0b60xX1T3lQZ4cJHO+HYH/O3Uc5L3MRNaOYlRQCICxu7zPnodWxLbE5+thHcDPFz
         lhrWUH9eyF6ZsOMC3F4kFnkNdk/2RNZIk4973l3R/Mq2+2i1oiyZr/1NOkH+c8i6VA
         HWIIfyE82aRBMpb7IZAZg6Elx4Pw1+cChvchrgaofzin51r2xt/rRchC/3jJCvfNnv
         aUZi459mGwywA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0ED4BCE0F13; Thu, 17 Aug 2023 14:29:03 -0700 (PDT)
Date:   Thu, 17 Aug 2023 14:29:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, keescook@chromium.org,
        elver@google.com, dvyukov@google.com, glider@google.com
Subject: Re: [BUG] missing return thunk: __ret+0x5/0x7e-__ret+0x0/0x7e: e9 f6
 ff ff ff
Message-ID: <90910ec0-3e78-4036-980f-1cc114caee2d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop>
 <4500f9ad-6ecf-60a6-637d-694619ce4c15@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4500f9ad-6ecf-60a6-637d-694619ce4c15@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:49:52PM +0300, Nikolay Borisov wrote:
> 
> 
> On 16.08.23 г. 20:54 ч., Paul E. McKenney wrote:
> > Hello!
> > 
> > I hit the splat at the end of this message in recent mainline, and has
> > appeared some time since v6.5-rc1.  Should I be worried?
> > 
> > Reproducer on a two-socket hyperthreaded 20-core-per-socket x86 system:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5m --torture refscale --kcsan --kconfig "CONFIG_NR_CPUS=40" --kmake-args "CC=clang" --bootargs "refscale.scale_type=typesafe_seqlock refscale.nreaders=40 refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot refscale.verbose_batched=5 torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=5"
> > 
> > This is from overnight testing that hit this only in the KCSAN runs.
> > The KASAN and non-debug runs had no trouble.
> > 
> > This commit added the warning long ago:
> > 
> > 65cdf0d623be ("x86/alternative: Report missing return thunk details")
> > 
> > Thoughts?
> > 
> > 							Thanx, Paul
> 
> Likely fixed by the following commit in tip/urgen :
> 4ae68b26c3ab5a82aa271e6e9fc9b1a06e1d6b40 [tip: x86/urgent] objtool/x86: Fix
> SRSO mess

Thank you!  Given the "urgent", I am guessing that this is going
upstream soon?

							Thanx, Paul
