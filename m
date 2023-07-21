Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCBE75C2B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjGUJN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjGUJNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:13:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16A530D0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ro30CBN8LC5XIt131r8jKjIB6cHvKWYdS6kEe08cYWA=; b=E0DQycwwijDsxNyVQvLBmUONUw
        0jxL8WtP4mkXVUPjG9GNDVv3d9xReLlOs4mUzvhwIHm7synNVI5rgf6g1SVauhSv6yiJBrigBSo3a
        EoSMrF86EftMKESq2z79a+VRTA+0Vd05a/0iGHL54gMTqsy0tfUAFDX9MA5tUwWMPHxco5EtjuLlH
        OTnEW3hiR6jF93qsppYF5nw9D1USTu9qvF5RyDuj3hvgZO17PgBr9k3nUsO+F39w/GwERGpUVkvY8
        VCZzzWS+5r482YaujVz8bYhdX+XAiF5qvS5OsXfniZCKXmNWUW/RzYDuiVfzScpMdJRkgj3RBkJtK
        BPoadFPg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMmAG-00HXPQ-2I;
        Fri, 21 Jul 2023 09:13:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A578300274;
        Fri, 21 Jul 2023 11:11:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F021F30B493D8; Fri, 21 Jul 2023 11:11:06 +0200 (CEST)
Date:   Fri, 21 Jul 2023 11:11:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, luoben@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Adjust CFS loadbalance to adapt QEMU CPU
 topology.
Message-ID: <20230721091106.GD3630545@hirez.programming.kicks-ass.net>
References: <1689842053-5291-1-git-send-email-Kenan.Liu@linux.alibaba.com>
 <20230720085032.GB3569127@hirez.programming.kicks-ass.net>
 <6a70900a-649f-3a4d-2e47-61648bc95666@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a70900a-649f-3a4d-2e47-61648bc95666@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:58:50AM +0800, Kenan.Liu wrote:

> > > As the current kernel scheduler
> > > implementation, hyperthread with an even ID number will be picked up in a much
> > > higher probability during load-balancing and load-deploying.
> > How so?
> 
> 
> The SMT topology in qemu native x86 CPU model is (0,1),…,(n,n+1),…,
> but nomarlly seen SMT topo in physical machine is like (0,n),(1,n+1),…,
> n means the total core number of the machine.

That is only common on Intel hardware, AMD (and some Intel) will in fact
enumerate SMT like Qemu does.
