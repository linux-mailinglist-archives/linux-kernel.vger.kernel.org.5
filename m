Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DF67FFBD9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjK3T5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjK3T5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:57:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FFEDD;
        Thu, 30 Nov 2023 11:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B08XMDqMVQFuzS5fqGkuj4q8o3TKhsehevn/O9gt1Ss=; b=AKehrCzGEVM+APDHfKjJJpsnFH
        GUkIx7U3jBwnuYVtLnzQv+bAFeNzkKnw8DQdiCS2M1dY7QIyVfvuaMkyjZf/j/j6HuRLFluoZtOOi
        2tb6c8aTxEftKgaoqmKwoFs2V+pdQTfynC0fenHwfRq085QvsJYEPyL7lDJ9TzyOGi1DlQlCAcDX4
        /yDz6g4RAKaOtosELWxbYssXlL4bjA7UYEvPiA1UCocWyVGxDR2SO6UFQVaVwpQOdo+5MFBI16nab
        HfVmDU1zzT70Mv17KQKaBf6EE+YJynv7ezg+GrfUKowlGL/Zd/0TjpFP2LIzZx35DcSzPXHjuoqJG
        9eytLF5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8nAM-00EoF8-QI; Thu, 30 Nov 2023 19:57:42 +0000
Date:   Thu, 30 Nov 2023 19:57:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v8 1/6] list_lru: allows explicit memcg and NUMA node
 selection
Message-ID: <ZWjpNr3ZzvU4TDC8@casper.infradead.org>
References: <20231130194023.4102148-1-nphamcs@gmail.com>
 <20231130194023.4102148-2-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130194023.4102148-2-nphamcs@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:40:18AM -0800, Nhat Pham wrote:
> This patch changes list_lru interface so that the caller must explicitly
> specify numa node and memcg when adding and removing objects. The old
> list_lru_add() and list_lru_del() are renamed to list_lru_add_obj() and
> list_lru_del_obj(), respectively.

Wouldn't it be better to add list_lru_add_memcg() and
list_lru_del_memcg() and have:

+bool list_lru_del(struct list_lru *lru, struct list_head *item)
+{
+	int nid = page_to_nid(virt_to_page(item));
+	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
+		mem_cgroup_from_slab_obj(item) : NULL;
+
+	return list_lru_del_memcg(lru, item, nid, memcg);
+}

Seems like _most_ callers will want the original versions and only
a few will want the explicit memcg/nid versions.  No?

