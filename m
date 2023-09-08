Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC2979879F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbjIHNMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIHNMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:12:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453B219B5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 06:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AdtzzDZ04a5DsK13L/ZQqO+LaO4hLz3EQLkHNNnVcSs=; b=bWWh8omZnBJEgS7l2UryxlPVc/
        PzcfabZxfY8B3dPYA91U3+9tH6TKuDprk6TWRSUEum3rUlk6reMv7f04P0BK6goDxLVjVhkC4V9GC
        z2MlKEi/agU4LKfQuNUwsZ2zMMVjgsy0KJdo8eSIsCMoKoHnF4ZnE2tvCkm7r44lkBvst0mTYq6w2
        fTw9IbYlC2XeyPrsvdrm2qG3F2SEl1PJ1iuOXIBuCrg+X25+pKgnsDe2KEl00QnhbdL0aae0pk2TH
        5Zat7FNO+5/Q6c67ptITlXz6F23sqMa4lIarZMKvdJYm7pwno85Hl9Z+5YbjL8zMG3R4bzxFov5E2
        jMz80ACg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qebH7-000HKj-8u; Fri, 08 Sep 2023 13:11:53 +0000
Date:   Fri, 8 Sep 2023 14:11:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 4/9] x86/clear_page: extend clear_page*() for
 multi-page clearing
Message-ID: <ZPsdmYIIqxqpowv+@casper.infradead.org>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-5-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830184958.2333078-5-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:49:53AM -0700, Ankur Arora wrote:
> -void clear_page_orig(void *page);
> -void clear_page_rep(void *page);
> -void clear_page_erms(void *page);
> +void clear_pages_orig(void *page, unsigned int length);
> +void clear_pages_rep(void *page, unsigned int length);
> +void clear_pages_erms(void *page, unsigned int length);

Maybe make this size_t so we know it's a byte count rather than being
some other unit of length?

