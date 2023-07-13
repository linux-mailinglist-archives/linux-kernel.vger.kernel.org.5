Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD83751BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbjGMIhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjGMIgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:36:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D1D30E8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p+KC7YWiKB5Mk9GoOmWmh5rqXfFb9ab0DdlkQ/N8CfI=; b=n9HTMVi1MQoVYNyo+pYYEcYWVm
        PCJllK8dXF8/053ToDMmpLiQ3giHQNv7VUNsPXPorxhdjcAOACQWcO3BjPOhVGEMtGyUEPUO+8V6r
        DWh96+gYdGZMTKaDzVmZ/FjVFLSu+fFrPmRuOYL66vwmiC2fhb7zbEdG4YVtbMxakZtPuGGoIxqyM
        NnEapR51z4WWFhouispdGaiZrZgiikJ84anECV2u8UZwkAgYgzLXFDnsweYEW8Lh6z0PL/WtDQFwk
        IaXH2KEU+aFjFBilfEXVZ/81QeTAJ1aB0cIt5HDoLNp5UD1uAn44mjvvp7qrRlr4aux9gjG12NWea
        /2F+dzDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJri0-00HYlm-B6; Thu, 13 Jul 2023 08:29:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 413E6300222;
        Thu, 13 Jul 2023 10:29:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20154245CA116; Thu, 13 Jul 2023 10:29:55 +0200 (CEST)
Date:   Thu, 13 Jul 2023 10:29:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        gautham.shenoy@amd.com, kprateek.nayak@amd.com, aaron.lu@intel.com,
        clm@meta.com, tj@kernel.org, roman.gushchin@linux.dev,
        kernel-team@meta.com
Subject: Re: [PATCH v2 5/7] sched: Implement shared runqueue in CFS
Message-ID: <20230713082954.GE3139243@hirez.programming.kicks-ass.net>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-6-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710200342.358255-6-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:03:40PM -0500, David Vernet wrote:
> +struct shared_runq {
> +	struct list_head list;
> +	spinlock_t lock;

FWIW, this really needs to be raw_spinlock_t.

> +} ____cacheline_aligned;
