Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877F57AD56B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjIYKJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjIYKIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:08:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D4E10D0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y7E2bQ4BW1hdfSm1jmBqima+v3SGUmJwYC5NN1UQOGs=; b=BwDRgNfNuC128GwhOi5yLtjQFJ
        5iPjYYCJ3ixmHKGM/6B+7Innix6B5Yocgt73ouQKyvklSfFGIdhUt6q4iZ+tXqj7QeqDFbX9ZCRqA
        6Gv6Hl9cHTHJngWHbud9hY0ARV730WrmidC7Llj05Qu0fzJkAcCMmyXJHx+dnpHpegxJ/iWAfyT85
        FndGq+/Czwf8pWl9Lq88DNJ1FRVYlYBiNYdqxWJBr3ytQN6ACd6INvlblqzFADbmEVeOHMT4XQgsa
        5iVwombFguHPNRON890voSS+vKXDUU3sH0DUc/rYESAqYYocCompaJgrgA+ohkjQKbmNOG/m7/9Gj
        e9pZwXPw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qkiVh-001Z9v-28;
        Mon, 25 Sep 2023 10:08:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id C108E30027E; Mon, 25 Sep 2023 12:08:14 +0200 (CEST)
Date:   Mon, 25 Sep 2023 12:08:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, eagle.zhou@nxp.com,
        tao.jiang_2@nxp.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] wait: don't wake up freezable wait by freezing fake
 signal
Message-ID: <20230925100814.GA31921@noisy.programming.kicks-ass.net>
References: <20230822074547.8037-1-ming.qian@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822074547.8037-1-ming.qian@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 03:45:47PM +0800, Ming Qian wrote:
> kernel may try to wake up task with fake signal when freezing task,
> if the task is waiting event using wait_event_freezable,
> it's better to freeze the wait, instead of breaking it.
> 
> otherwise the caller may need to retry the wait,
> maybe like below code:
> 
> 	if (rc == -ERESTARTSYS && freezing(current)) {
> 		clear_thread_flag(TIF_SIGPENDING);
> 		goto again;
> 	}

I'm not sure I get it -- is there an actual problem, or are you trying
to optimize something?
