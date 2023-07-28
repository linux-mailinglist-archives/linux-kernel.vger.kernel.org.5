Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4151767005
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbjG1PB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbjG1PBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:01:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6463A1FFF;
        Fri, 28 Jul 2023 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=YQEwVCk/QU3bHVm/xjs/XRiSx8q/Pm/h4nnL46SBa4o=; b=FLJlmaULzuA3XO/wxY3fL+7qc4
        6jJNGN8qoXgkNQDWNU++N80xhkRuQlEpp2e04LIkBH7s6l7pntwaDyLacpI6SYZBAZ9pGY2RadInU
        XDU1d88IuTr6VvX/0qKNjuEpVmgOhX0Erxif12EEaC3Q1F2GPdqjF3FfNNOuosLL/7LgNRwUr8anE
        u5aQScyCOCkaCMbHdj/EDHX9XyGv09Grt2P6ctaY03g1Gjy5hDKWkh0udHMh5BfG79Uo1zUZ1KkWC
        lVppaMc7IqWc7/dG8RohOuM2boCiqRt1k6shj/Erv7oqxrVJOKDBqpTrA7Ie3wdQP/KNItXw2IXbY
        E7YYn2uA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qPOxZ-008NVh-0N;
        Fri, 28 Jul 2023 15:00:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5EFD9308CCB;
        Fri, 28 Jul 2023 17:00:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1B2302C8FCA8E; Fri, 28 Jul 2023 17:00:51 +0200 (CEST)
Message-ID: <20230728145515.990749537@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Jul 2023 16:55:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     anna-maria@linutronix.de, rafael@kernel.org, tglx@linutronix.de,
        frederic@kernel.org, gautham.shenoy@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Subject: [RFC][PATCH 0/3] cpuidle,teo: Improve TEO tick decisions
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Wanted to send this yesterday, but my home server died and took everything
down :/

These patches are lightly tested but appear to behave as expected.

