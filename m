Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0354754342
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbjGNTgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbjGNTgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:36:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC1612D;
        Fri, 14 Jul 2023 12:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3493C61DDB;
        Fri, 14 Jul 2023 19:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F33BC433C7;
        Fri, 14 Jul 2023 19:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689363370;
        bh=Cysarz/hhMo/bK+dPUbL3TWMzv7sx9BTXTOdSSRZeOw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ega7w8KgFJ16HD1GYoX1h4GiocZpQVQFvGcEGonZbz750+cvVJnS222Rs1NkYmeur
         FBlGhqgX+LkX6K1+6UT6Ynqb4157JHvh8IdnFy05pscRhGgf+h0vDoheEQjAPG6xGL
         1DeTwrWjuxaWJKnSrSX9v70q6KjMdeenBZxKanBPFnjuNk8u973+Z6IrexuiSj5N3H
         GsuJIC2hlA5j8tRu5QZSp/PxlVMMBIN0B28okP9XI4NnfjEzDsM5Lmhanpfr4kMCvR
         2nJkQvIk4LCEpZsjDK8H3AQAXnq7vygyZC3ndShkjhwx/uKDAtTObQSXew1oI61EF7
         EcQ/INrDH3TGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2DFB8CE009F; Fri, 14 Jul 2023 12:36:10 -0700 (PDT)
Date:   Fri, 14 Jul 2023 12:36:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sandeep Dhavale <dhavale@google.com>
Cc:     Alan Huang <mmpgouride@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <e8e1b75f-e631-4793-9130-472909264406@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
 <7d433fac-a62d-4e81-b8e5-57cf5f2d1d55@paulmck-laptop>
 <F160D7F8-57DC-4986-90A9-EB50F7C89891@gmail.com>
 <6E5326AD-9A5D-4570-906A-BDE8257B6F0C@gmail.com>
 <e8ee7006-c1d0-4c04-bd25-0f518fb6534b@paulmck-laptop>
 <D042B1CB-2ED4-4DF9-8CF5-5E455E7EAB73@gmail.com>
 <453bcbbd-94f4-46da-98f6-c9fa5f931231@paulmck-laptop>
 <CAB=BE-TC0s++t_5H6NjVVcpNvvvubtUpJhRxPsqq2p3ZgaFo9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=BE-TC0s++t_5H6NjVVcpNvvvubtUpJhRxPsqq2p3ZgaFo9A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:15:23PM -0700, Sandeep Dhavale wrote:
> >
> > Sandeep, thoughts?
> >
> I prefer to modify erofs check and contain the fix there as erofs
> cares about it and it's
> least invasive. For contexts where erofs cannot tell for sure, it will
> always schedule kworker
> (like CONFIG_PREEMPT_COUNT=n).
> 
> I will also do measurements to see if erofs should continue to check
> for context and
> what are the benefits.

At the end of the day, I guess it is Gao Xiang's and Chao Yu's decision.

							Thanx, Paul
