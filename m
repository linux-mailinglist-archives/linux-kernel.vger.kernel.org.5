Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D09777ED02
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 00:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346872AbjHPWWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 18:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346881AbjHPWWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 18:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45341D1;
        Wed, 16 Aug 2023 15:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDEC267019;
        Wed, 16 Aug 2023 22:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED051C433C7;
        Wed, 16 Aug 2023 22:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692224552;
        bh=ItLslPf7bW8pM/0eFJzpwDrV/zwwM2HsGWCvnRv4mAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NatCkY2r/+7cEL/jWcTm8J0fpWEgv0TBkrSrICE/VnqVC/M+kp7JU7MxpWgB1r6TK
         kxc0bUBH1f5XzpWlRSQYAYKDzHSYDhdhk/NrMVNAPQCdq+Nvi8Vwv1gAYkJKa98Qct
         zn/4HR8fu3WQ4/lZF4RG2OPlhMdvSQ6TJRzQp3qwoDkWRFEzWaA7p2eOxWFVE30Fph
         GzLRqVUS6hObEDYqHip89kLk70zGEshGoUH/hdUfZk21OZQKTArmJTPNVJnSXs0JwH
         4l/xlHC1GR67iIUe9dKU187OrNw1BnZQYnQ/ocyUHyAY7ps9/oL/ekumck3ly0RjLy
         kzhOPqtJU1kZw==
Date:   Wed, 16 Aug 2023 15:22:30 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH] objtool/x86: Fixup frame-pointer vs rethunk
Message-ID: <20230816222230.ths3fs4qwklbhi47@treble>
References: <20230814121148.704502245@infradead.org>
 <169217251760.27769.15304146275480287222.tip-bot2@tip-bot2>
 <20230816115921.GH980931@hirez.programming.kicks-ass.net>
 <20230816203152.co5hgmo2epd6wvef@treble>
 <20230816220840.GB998718@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816220840.GB998718@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:08:40AM +0200, Peter Zijlstra wrote:
> On Wed, Aug 16, 2023 at 01:31:52PM -0700, Josh Poimboeuf wrote:
> > On Wed, Aug 16, 2023 at 01:59:21PM +0200, Peter Zijlstra wrote:
> > > Turns out I forgot to build with FRAME_POINTER=y, that still gives:
> > > 
> > > vmlinux.o: warning: objtool: srso_untrain_ret+0xd: call without frame pointer save/setup
> > > 
> > > the below seems to cure this.
> > 
> > LGTM
> 
> OK, with Changelog below.
> 
> ---
> Subject: objtool/x86: Fixup frame-pointer vs rethunk
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed, 16 Aug 2023 13:59:21 +0200
> 
> For stack-validation of a frame-pointer build, objtool validates that
> every CALL instructions is preceded by a frame-setup. The new SRSO
> return thunks violate this with their RSB stuffing trickery.
> 
> Extend the __fentry__ exception to also cover the embedded_insn case
> used for this. This cures:
> 
> vmlinux.o: warning: objtool: srso_untrain_ret+0xd: call without frame pointer save/setup
> 
> Fixes: 4ae68b26c3ab ("objtool/x86: Fix SRSO mess")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
