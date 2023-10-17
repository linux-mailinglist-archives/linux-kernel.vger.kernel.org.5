Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227367CC426
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343638AbjJQNO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjJQNO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:14:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F1CEA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8fU76jL3XwMugPoWuiJp0vehmzP8csx8b1SF7Bd35mM=; b=mvI+vpVcDMxJKtRLXtiEPETSEI
        f3GgJT+T9FkK01c17an/AuT677JHslw/3wkmE/A9rkv2zwUzAc7aq3BgObWx/UCBUn4akJ204HCX9
        r+x3XXQREiXt/Fi7wqeI1g/KzaCueZHk/qy+CQLb5TZF/NOIaqLv9RSndiFyoKpHOIGzPBECAHaDs
        w8y1mbrXyF4/tsj9gZQUvJDD/F8PUzpPZZ8lld5Rhhw9RP5n5nw8/Rw/QCfB3Cn1Qz7C7YMZpqzgD
        iG0Cxf6cgmknhckmcvrQSLSoiddUd4eo6Meif8X0AuhZyJxBbGYn+r1aaiiO8yTDSnxxuaqGoNoEX
        +o2pk/LA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qsju8-0077PD-17;
        Tue, 17 Oct 2023 13:14:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 066F030047C; Tue, 17 Oct 2023 15:14:36 +0200 (CEST)
Date:   Tue, 17 Oct 2023 15:14:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Rong Tao <rtoax@foxmail.com>, elver@google.com, tglx@linutronix.de,
        Rong Tao <rongtao@cestc.cn>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] stop_machine: Avoid potential race behaviour of
 multi_stop_data::state
Message-ID: <20231017131435.GA1599@noisy.programming.kicks-ass.net>
References: <tencent_705C16DF25978ACAEBD1E83E228881901006@qq.com>
 <ZS5g6I-UtUnihToH@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS5g6I-UtUnihToH@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 11:24:40AM +0100, Mark Rutland wrote:

> That said, if we really want to avoid the non-atomic read, it's probably better
> to have multi_cpu_stop() pass curstate as a paramter to ack_state. That or fold
> ack_state() into multi_cpu_stop() and use curstate directly.

Right. Also, that smp_wmb() needs a comment. Or perhaps
smp_store_release().
