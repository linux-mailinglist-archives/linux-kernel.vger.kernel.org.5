Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7027B20F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjI1PTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjI1PTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:19:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4022AC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5hV9RHE2np4Q/chcyiz0z8ahVkd4d/jzh2cotT+E4Ik=; b=JBXepoFRBRKckRrMLqnelG5jyB
        iR1XVar5xlG5UqiTkMBAHBGTe1+MCdNP/ZUjQ3wKGsh2FBBtSC7lIxwPbMYljCoyfv0/MQQbmCSxc
        ZZzCk/Tfoc4NAtENKmajrceMBCdgwPzCWFlSQkwH0ts1yUJurcJSeDeO1wm2C5LfmF3DCihEDSybn
        gO8vuygiALgyNQgRvTWuCOhMxqM0poVeiq2NFCiM7kA+ptZt2JZ+EfPn4YJ8sxZoR59/0IP67wlKd
        GbTv7VDYcnz2nLOF1tv+dVuKlefK0NMbDLxskWOoaCUaYeY/5suC5YaxT5MTGKU+J7CWBZ5BpEooQ
        10bPzCRQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qlsnM-0057CY-0X;
        Thu, 28 Sep 2023 15:19:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46C453002E3; Thu, 28 Sep 2023 17:19:17 +0200 (CEST)
Date:   Thu, 28 Sep 2023 17:19:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kuyo Chang =?utf-8?B?KOW8teW7uuaWhyk=?= <Kuyo.Chang@mediatek.com>
Cc:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/1] sched/core: Fix stuck on completion for
 affine_move_task() when stopper disable
Message-ID: <20230928151917.GB29651@noisy.programming.kicks-ass.net>
References: <20230927033431.12406-1-kuyo.chang@mediatek.com>
 <20230927080850.GB21824@noisy.programming.kicks-ass.net>
 <b9def8f3d9426bc158b302f4474b6e643b46d206.camel@mediatek.com>
 <20230928151616.GD27245@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928151616.GD27245@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 05:16:16PM +0200, Peter Zijlstra wrote:

> AFAICT this is migrate_enable(), which acts on current, so how can the
> CPU that current runs on go away?

> Your patch has at least one very obvious resource leak.

Sorry those are not so, I ended up staring at the wrong
stop_one_cpu_nowait() :-/

Still, the rest is very much the case, if you can't describe the exact
race scenario, you can't be talking about a solution.
