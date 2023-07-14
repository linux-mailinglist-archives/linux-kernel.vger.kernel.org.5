Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9B2754420
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGNVL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbjGNVLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:11:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB523A9C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7hPphsRyAiHyqjTvF36m7gtSF3Zvl71kzHrGyEJ0ZIo=; b=oZKzxN/UZM3UahawjbZfJFqjjX
        oeU/8L3Ql8FGPpjNNG2aue9k+pBvTXsMzRVy8XZ+l9fEYv6TOZGmTqBUfZtQ8E5zYkg5k8jUTPT1j
        956OYLvyU7lKYcqXVj3BwdjqbZWokWwfTM7RkXiHQ8lL/FvUfARtDaM5zVttwkCqt9LjFfNyQs4rn
        eOPII4rCBnGycZWgKHtrR1nWdyhYSuSU2OsW/KjGSWIYc3DzYtKp1ha3nMLsGAuqRtYWxkLxHgmPy
        hX1IRNwuTEzOnZQNA7GAfbmq/flrLPWawDLtiE1Xvt1L8Cq3yYXLoxni/gq6+R5MZrmW4Dy8hMc+l
        p1Ip3EVw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKQ4E-006Nay-0T;
        Fri, 14 Jul 2023 21:11:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C621E30023F;
        Fri, 14 Jul 2023 23:11:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B899821372899; Fri, 14 Jul 2023 23:11:09 +0200 (CEST)
Date:   Fri, 14 Jul 2023 23:11:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arjan van de Ven <arjan@linux.intel.com>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bruno Goncalves <bgoncalv@redhat.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
Message-ID: <20230714211109.GC3275140@hirez.programming.kicks-ass.net>
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
 <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
 <CA+QYu4qzJgiiU1qsjtWb9OU3=C=hb_c-Ag5Y4c=Xp_ObfGH=hg@mail.gmail.com>
 <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
 <20230711132553.GN3062772@hirez.programming.kicks-ass.net>
 <0837a34c-f66e-aa04-d4a7-b032d3dbab7a@intel.com>
 <b672c500-5f2f-d60c-84da-80269b8b420f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b672c500-5f2f-d60c-84da-80269b8b420f@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:39:53AM -0700, Arjan van de Ven wrote:
> On
> > I think you mean "revert"?
> > 
> > That can be done, but maybe it can be fixed instead?
> 
> this specific issue I will fix shortly (together with the RDMSR thing)

I still don't know why this needs to be in intel_idle.
