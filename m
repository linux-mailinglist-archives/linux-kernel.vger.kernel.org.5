Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938897BFFDA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjJJO6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjJJO6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:58:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2514AAF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=cWcJ6w7POfv7sCUBrmIpDvnagdGjD70oQgT03BbPqeQ=; b=ieKVLBYHiRjMpETBOyz60EGT0o
        QJWkOI+2O8r3aq8MKPC6KLodWkXT82MJP0N768qYFTB32n6ETsbgR9uUrz1sBjMGdIFweLA6DjJn4
        d7dsEaIrNC4kDh3J5DBXf7yS0sAoqKYyBK/NVQjcqwdgGxIoR12qhVPhRKb9gXrmVLB0kcDz2KneH
        GvJwjlPG32iIpfKWC7EUK1FroC/XsJmCxZFKrdzVdCTevqtsO/2hAUTc6xURsjEfl2pk2meJyJtmd
        7Zsp6MTiAET8k6J7psSkGm79XWVbOBQCTsO2zwfvn3RY0tE9LF9Citu0DUIkktTQL6SUiaOI0TRMD
        hEmJzQ4A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqEB8-00Gvjp-11;
        Tue, 10 Oct 2023 14:57:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C623300392; Tue, 10 Oct 2023 16:57:47 +0200 (CEST)
Date:   Tue, 10 Oct 2023 16:57:47 +0200
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
Message-ID: <20231010145747.GQ377@noisy.programming.kicks-ass.net>
References: <20230927033431.12406-1-kuyo.chang@mediatek.com>
 <20230927080850.GB21824@noisy.programming.kicks-ass.net>
 <b9def8f3d9426bc158b302f4474b6e643b46d206.camel@mediatek.com>
 <20230929102135.GD6282@noisy.programming.kicks-ass.net>
 <8ad1b617a1040ce4cc56a5d04e8219b5313a9a6e.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ad1b617a1040ce4cc56a5d04e8219b5313a9a6e.camel@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 02:40:22PM +0000, Kuyo Chang (張建文) wrote:
> On Fri, 2023-09-29 at 12:21 +0200, Peter Zijlstra wrote:
> >  	 
> >  On Wed, Sep 27, 2023 at 03:57:35PM +0000, Kuyo Chang (張建文) wrote:
> > 
> > > This issue occurs at CPU hotplug/set_affinity stress test.
> > > The reproduce ratio is very low(about once a week).
> > 
> > I'm assuming you're running an arm64 kernel with preempt_full=y (the
> > default for arm64).
> > 
> > Could you please test the below?
> > 
> 
> It is running good so far(more than a week)on hotplug/set affinity
> stress test. I will keep it testing and report back if it happens
> again.

OK, I suppose I should look at writing a coherent Changelog for this
then...
