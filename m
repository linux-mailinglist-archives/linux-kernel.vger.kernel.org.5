Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607E0753E38
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbjGNO4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbjGNO4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:56:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDE6359F;
        Fri, 14 Jul 2023 07:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56D5461D43;
        Fri, 14 Jul 2023 14:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B6CC433C7;
        Fri, 14 Jul 2023 14:56:18 +0000 (UTC)
Date:   Fri, 14 Jul 2023 10:56:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
        Sandeep Dhavale <dhavale@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
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
Message-ID: <20230714105615.1ff9b8d2@gandalf.local.home>
In-Reply-To: <fccca41d-8a72-27cf-e589-409f54cd5811@linux.alibaba.com>
References: <20230713003201.GA469376@google.com>
        <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
        <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop>
        <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
        <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop>
        <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
        <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
        <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
        <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
        <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
        <7d433fac-a62d-4e81-b8e5-57cf5f2d1d55@paulmck-laptop>
        <058e7ee9-0380-eb1b-d9a8-b184cba6ed53@linux.alibaba.com>
        <CAEXW_YQCpUsPz24H4Mux6wOH1=RFRR-gsXLFTbJ37MgUJo3kCw@mail.gmail.com>
        <fccca41d-8a72-27cf-e589-409f54cd5811@linux.alibaba.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 21:51:16 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> >> we need to work on
> >> CONFIG_PREEMPT_COUNT=n (why not?), we could just always trigger a
> >> workqueue for this.
> >>  
> > 
> > So CONFIG_PREEMPT_COUNT=n users don't deserve good performance? ;-)  
> 
> I'm not sure if non-preemptible kernel users really care about
> such sensitive latencies, I don't know, my 2 cents.

CONFIG_PREEMPT_COUNT=n is for *performance* but not for *latency*. That is,
they care about the overall performance (batch processing) but not
interactive performance.

-- Steve
