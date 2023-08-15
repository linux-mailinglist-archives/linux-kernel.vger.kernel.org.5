Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8655577D51A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbjHOV2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbjHOV15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:27:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFB619A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:27:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9400D643C9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 21:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6E1C433C7;
        Tue, 15 Aug 2023 21:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692134873;
        bh=ZZDEcQyn5dlUdM05H92yE2d+GFcS0xdhRw8L9pzrQnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeAT4nBDG48Mb46evkZoy2Y5CXNY669h+MkxsO0PxKLGZ9S7fNSioAusZnI0fmo3+
         uVx60u8JFhN3WrNlpTwNqKKrZ8/+6MCd4RPYvLXwBK6AcJDddIrS7/sKzOvuCCR6bh
         r/G19AMh45sQKAnKC7lvspxdVRrsqNCfY8UPvIcQCQSIcXonbDTOv3gRN/2o6IDw+A
         UjCyju9vYS22IWgPX4HjWzfDt+UdxkGos1/cR+30/8J8vHYLtcVfUtBkuKwkURQ9+6
         DNgxB3duVFQTgggRUFrZ6CvYaaKiTcj7khd35WVtRpwc8tw6kggRxxp6hRwTT1YYag
         /jcixy22sDfBA==
Date:   Tue, 15 Aug 2023 14:27:51 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nikolay Borisov <nik.borisov@suse.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/srso: Correct the mitigation status when SMT is
 disabled
Message-ID: <20230815212751.xhsyn7iwj2gwpuk5@treble>
References: <20230813104517.3346-1-bp@alien8.de>
 <1588ed00-be11-ff9d-e4c2-12db78cca06f@suse.com>
 <20230814200813.p5czl47zssuej7nv@treble>
 <20230814202545.GKZNqNybUnKv+xyrtP@fat_crate.local>
 <20230814205300.krikym7jeckehqik@treble>
 <20230814211727.GLZNqZ5+flxtyaDjMQ@fat_crate.local>
 <20230815095724.GBZNtMBPUJSEegviJN@fat_crate.local>
 <20230815195831.2opbgrznnpszaa32@treble>
 <20230815201753.GGZNvdcbPHXtEXn4As@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230815201753.GGZNvdcbPHXtEXn4As@fat_crate.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 10:17:53PM +0200, Borislav Petkov wrote:
> On Tue, Aug 15, 2023 at 12:58:31PM -0700, Josh Poimboeuf wrote:
> > AFAICT, nowhere in the spec does it say the SRSO_NO bit won't get set by
> > future (fixed) HW.  In fact I'd expect it will, similar to other *_NO
> > flags.
> 
> I'm pretty sure it won't.
> 
> SRSO_NO is synthesized by the hypervisor *software*. Nothing else.

Citation needed.

> It is there so that you don't check microcode version in the guest which
> is nearly impossible anyway.
> 
> > Regardless, here SRSO_NO seems to mean two different things: "reported
> > safe by host (or HW)" and "not reported safe on Zen1/2 with SMT not
> > possible".
> 
> Huh?

Can you clarify what doesn't make sense?

> > Also, in this code, the SRSO_NO+SMT combo doesn't seem logically
> > possible, as srso_show_state() only gets called if X86_BUG_SRSO is set,
> > which only happens if SRSO_NO is not set by the HW/host in the first
> > place.  So here, if boot_cpu_has(X86_FEATURE_SRSO_NO), it means SRSO_NO
> > was manually set by srso_select_mitigation(), and SMT can't possibly be
> > enabled.
> 
> Have you considered the case where Linux would set SRSO_NO when booting
> on future hardware, which is fixed?
> 
> There SRSO_NO and SMT will very much be possible.

How is that relevant to my comment?  The bug bit still wouldn't get set
and srso_show_state() still wouldn't be called.

-- 
Josh
