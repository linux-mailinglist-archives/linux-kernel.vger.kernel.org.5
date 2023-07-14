Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C461B753E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbjGNPN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbjGNPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:13:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4162D4B;
        Fri, 14 Jul 2023 08:13:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2270361D43;
        Fri, 14 Jul 2023 15:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E96C433C7;
        Fri, 14 Jul 2023 15:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689347605;
        bh=/ms++gXmzcCxNeQJmcaIIDi2dWJOZMkl3ilZS245fbU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e9mTxiqT5SFcazYh/KzxJ9wXw+vBIuFDC8WF4/Okvoij7KXNzYOfm/RvZSWaTD8bk
         nUptLTKsO/05/Wh8tKRGkHihY0wSXI4vimazLsZU168iyWjdxaJCgDVoVz7LoYIY3L
         7q6/PMuoR0I5oCKZ6WQd4yNHt2rZptHITESUDPUYoc4wPjfNgejAa2ut6QoK115L8e
         5NyTlO5PXgsHtrE4ApKb00z4ugJQWbtVIM8acy9YeG4fuZVv0XV4v5ectSv7UzbUV3
         ahQMO2L7JTXmc9ldAL0BnrnNqXo9kYd/JsM8tAjwIE92XDtrbRzldP2YbHZt7qvSQn
         mXYFq2F+eWAMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 194ABCE0093; Fri, 14 Jul 2023 08:13:25 -0700 (PDT)
Date:   Fri, 14 Jul 2023 08:13:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
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
Message-ID: <41a364d7-9dfa-4cd6-95f0-63f09c3a84b6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
 <7d433fac-a62d-4e81-b8e5-57cf5f2d1d55@paulmck-laptop>
 <058e7ee9-0380-eb1b-d9a8-b184cba6ed53@linux.alibaba.com>
 <CAEXW_YQCpUsPz24H4Mux6wOH1=RFRR-gsXLFTbJ37MgUJo3kCw@mail.gmail.com>
 <fccca41d-8a72-27cf-e589-409f54cd5811@linux.alibaba.com>
 <20230714105615.1ff9b8d2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714105615.1ff9b8d2@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 10:56:15AM -0400, Steven Rostedt wrote:
> On Fri, 14 Jul 2023 21:51:16 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > >> we need to work on
> > >> CONFIG_PREEMPT_COUNT=n (why not?), we could just always trigger a
> > >> workqueue for this.
> > >>  
> > > 
> > > So CONFIG_PREEMPT_COUNT=n users don't deserve good performance? ;-)  
> > 
> > I'm not sure if non-preemptible kernel users really care about
> > such sensitive latencies, I don't know, my 2 cents.
> 
> CONFIG_PREEMPT_COUNT=n is for *performance* but not for *latency*. That is,
> they care about the overall performance (batch processing) but not
> interactive performance.

Users of CONFIG_PREEMPT_COUNT=n do care about latency, but normally not
in the sub-millisecond range.  If the February posting is representative
(no idea, myself), these latencies are in the tens of milliseconds.

So one question is "why not both?"

One way would be for the call chain to indicate when in atomic context,
and another would be use of SRCU, to Joel's earlier point.

							Thanx, Paul
