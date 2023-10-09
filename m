Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB94B7BE258
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376715AbjJIOSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjJIOSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:18:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36749D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R/xYt7LuoTIJFEU/NbrEF3ez7zUOXlYRJH/cRSvSwUk=; b=BtUeqwsZc3eE9fG63OiyMu11V0
        InoTFNpndJVXehKx3ScVlszPc/C1nOYdV4drsq5z4NkmEC6BUpSxQD/oa5G25cMlIgdnEdNc7oITZ
        EJ+/vwOWFC+ohDBOr/9eReLKjgUQGDep8xwu4wyKPK5OHcI5gI7Wx748dFNjqY0yuJX/rYcY/i4sA
        +JmbB+X71/+npwF0RoXynhSC+BM9gJ2KwBjjr42HcAYoJBs8ZomCtE899IhP4K8JZZ6TWURNLaDNI
        W2alVFRxKaydCH3JbF6Nn/ht6hK683X+F28ZqOLfWJgwEJUtZIJOIQ07e/CngbJBrhvZw9/yNYlAd
        QstJTiOw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qpr5m-00GI81-Cl; Mon, 09 Oct 2023 14:18:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB579300454; Mon,  9 Oct 2023 16:18:41 +0200 (CEST)
Date:   Mon, 9 Oct 2023 16:18:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     bsingharora@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] delayacct: convert task->delays to a object
Message-ID: <20231009141841.GF14330@noisy.programming.kicks-ass.net>
References: <cover.1696761522.git.chunguang.xu@shopee.com>
 <531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu@shopee.com>
 <20231008105801.GC6320@noisy.programming.kicks-ass.net>
 <5dba07eb-88f0-bf84-494e-b979f32ad44d@gmail.com>
 <20231009084341.GA14330@noisy.programming.kicks-ass.net>
 <b1258877-4d02-67d9-a2db-d510eadf8441@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1258877-4d02-67d9-a2db-d510eadf8441@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 07:38:58PM +0800, brookxu wrote:

> I found another question when I tried to allocate task_delay_info on demand,
> it is hard for us to
> 
> determine whether tsk->delays is NULL due to memory failure or delayacct
> disabled, if due to
> 
> memory failure I think we should not try to allocate it again, otherwise we
> may have performance
> 
> issues, such as following code. If we limit only try once, the code is very
> trick..

Yeah, I wouldn't worry about that. Not until it's shown to be a real
issue. First do the simple thing, only make it more complicated if
there's a real need.
