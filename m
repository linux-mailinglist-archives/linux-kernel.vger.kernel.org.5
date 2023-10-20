Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0272F7D0DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376883AbjJTKsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377048AbjJTKsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:48:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA59D6E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NOMxNjx/SxB8UpPHiNmBQL1h4GVdvBvOWMoxgfnZlss=; b=BEHCascZlP8ujBRyAuz7WErWKe
        gU4S9pTQFjOfzHOc97vbGEB9ta6UuyZVEedijgX/axDNbYJTl36SbbKZDREClX5mZRkxf6+dxQgKh
        hARm4vPxmUfInzN5sVCcGWs166AVnEv+4WWdTrsTUCH4fFny5zqAhFNjkPV9cvYI46qzeTSz1Qwan
        7/jfUfeixISde6Gckxx5RoSr2XdBE9KIsllfT9CP3TJK56vOuKeMiAFl/VpWpGs8fAt9BJ2uUfWt1
        ZSuY1QuaMY5I/nKIC4Jr105/zTvfiVphzgYjV9b38OotCv0uVD+gO/8/uhT9XdutrTPjoOgepz3v5
        QObTjvPQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qtn2w-00Axcb-2T;
        Fri, 20 Oct 2023 10:48:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7028A300392; Fri, 20 Oct 2023 12:48:02 +0200 (CEST)
Date:   Fri, 20 Oct 2023 12:48:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Rong Tao <rtoax@foxmail.com>, elver@google.com,
        linux-kernel@vger.kernel.org, rongtao@cestc.cn, tglx@linutronix.de
Subject: Re: [PATCH v2] stop_machine: Avoid potential non-atomic read of
 multi_stop_data::state
Message-ID: <20231020104802.GB33965@noisy.programming.kicks-ass.net>
References: <tencent_4CD220721A6C0B39670D5D52AAE4BD2A8F0A@qq.com>
 <ZTJVKbJWqyx2e8Su@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTJVKbJWqyx2e8Su@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 11:23:37AM +0100, Mark Rutland wrote:

> > And replace smp_wmb()+WRITE_ONCE() with smp_store_release().
> 
> This is also fine, but feels like a logically separate change.

Agreed, and please take this opportunity to write a comment with the
barrier.
