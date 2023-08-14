Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E76877BBD2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjHNOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjHNOgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:36:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C72AE9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rTdmtiV1Cy1Cv3JBCyT4qVPnn3R20+Z8COZxq98CBEc=; b=cjhIzm6M0e37Nxfs7vGb8wa0oO
        X1XEC2MOLNLHAu0wXrzfVIM27rpuZVxgXOIRdMctLowAwCRPnPjUpzWBTO6MmMozmRngIoJ+gUCcP
        H3/d3loxqjPNxxuWr2jh3j7ew1o4ZlBZF8YQFaA9DmM4C+oBAafWQFOxPcmXbLVssgTEBoifzvlpy
        ntDjxBNYbk9FNLQm011wTqRT4fwJbheiYFtwMKVPQ2h8jeaZ5B5RX7e61K2rzA5dg7xHW22UhJfeU
        dAfDdD3X8jEeCv+19NF54wbezqufzR13Kj1mZk3sAYb8mPudZHGPDPLtyQl5RQ/R7+kAmhAP9HKaR
        8Tshb5VQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVYgB-00Aesp-1B;
        Mon, 14 Aug 2023 14:36:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 423CB300137;
        Mon, 14 Aug 2023 16:36:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AD81202C2247; Mon, 14 Aug 2023 16:36:18 +0200 (CEST)
Date:   Mon, 14 Aug 2023 16:36:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [patch V4 00/41] x86/cpu: Rework the topology evaluation
Message-ID: <20230814143618.GM776869@hirez.programming.kicks-ass.net>
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814085006.593997112@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 10:53:33AM +0200, Thomas Gleixner wrote:
> Hi!
> 
> This is the follow up to V3:
> 
>   https://lore.kernel.org/lkml/20230802101635.459108805@linutronix.de
> 
> which addresses the review feedback.
> 
> TLDR:
> 
> This reworks the way how topology information is evaluated via CPUID
> in preparation for a larger topology management overhaul to address
> shortcomings of the current code vs. hybrid systems and systems which make
> use of the extended topology domains in leaf 0x1f. Aside of that it's an
> overdue spring cleaning to get rid of accumulated layers of duct tape and
> haywire.
> 

Given how often you had me reboot the adl thing ;-)

Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
