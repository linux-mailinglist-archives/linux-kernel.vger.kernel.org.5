Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663FE768079
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 18:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjG2QHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 12:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG2QHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 12:07:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A125735A5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 09:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kVw4LWVdll4tRDwniP1YfJ8EssxH9lR3jkgelS2E3rw=; b=BWuEoZ3zQJHxtH3J46b/qZ3PlB
        H+ujxYi1T8tVgAD9iyx6wrfrIRvJ0U7rwQmrmheiwcjfbOBDcvvjqOaEE9RTh5BIrOZuKBBY+37Md
        KM91qNVBRChyWPH1/WptMgZe1TLegUl31ArVB1ZMVKTppGoqrUGnsTqTFPmtM2SIOkJlgusG/yg+R
        ixoytglBcP7pqJ/9JGcbkQ/VXgrEpAvCPuNQhIkG+5PzFS8dFIMEbJ7TCcTl7KMtAPucBdjg82llU
        TMeI1d1jP/nyvl0nw390uNKH8mRdbeqq3BOKpyRQZCBgAP/9eZ5/MSwqy6pB3UG3VorH5inbw+9HK
        /YSAl12w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qPmTJ-009FHA-15;
        Sat, 29 Jul 2023 16:07:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE78E3006E2;
        Sat, 29 Jul 2023 18:07:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD2F620CC1F2C; Sat, 29 Jul 2023 18:07:12 +0200 (CEST)
Date:   Sat, 29 Jul 2023 18:07:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Tomlin <atomlin@atomlin.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, jiangshanlai@gmail.com
Subject: Re: [RFC PATCH 1/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <20230729160712.GA5697@hirez.programming.kicks-ass.net>
References: <20230729135334.566138-1-atomlin@atomlin.com>
 <20230729135334.566138-2-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729135334.566138-2-atomlin@atomlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 02:53:33PM +0100, Aaron Tomlin wrote:
> The Linux kernel does not provide a way to differentiate between a
> kworker and a rescue kworker for user-mode.
> From user-mode, one can establish if a task is a kworker by testing for
> PF_WQ_WORKER in a specified task's flags bit mask (or bitmap) via
> /proc/[PID]/stat. Indeed, one can examine /proc/[PID]/stack and search
> for the function namely "rescuer_thread". This is only available to the
> root user.
> 
> It can be useful to identify a rescue kworker since their CPU affinity
> cannot be modified and their initial CPU assignment can be safely ignored.
> Furthermore, a workqueue that was created with WQ_MEM_RECLAIM and
> WQ_SYSFS the cpumask file is not applicable to the rescue kworker.
> By design a rescue kworker should run anywhere.
> 
> This patch introduces PF_WQ_RESCUE_WORKER and ensures it is set and
> cleared appropriately.

Is the implication that PF_flags are considered ABI? We've been changing
them quite a bit over the years.

Also, while we have a few spare bits atm, we used to be nearly out for a
while, and I just don't think this is sane usage of them. We don't use
PF flags just for userspace.
