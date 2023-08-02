Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E943576C3CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjHBD6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHBD6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:58:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD7B103;
        Tue,  1 Aug 2023 20:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1sxh7WBnvHVhsALDL7UYNMUiOC+6/e9sMU+u5Ot8mLc=; b=v/OfBmitMKXbq60FtWwAjeBzPD
        rHrouKtj7RhHZCdeJfVP87aaiq3a4NJoBF0hxzExrnEssr28/oU8mEXEW4Hs1C/AkDDqxxNrzwqLh
        tLq58oHhLkRLu0/KTfJfIJ30KY1Ip6O0z0KkdJ9948Y9knve/1zDrSJBUVhQvg6JR9iQe2Wpfi3IS
        RUjIfpbnSBORbjuT+4lHQQedW577OMpZWQLx9aCZ+ffNKBIFbRvJQ5cWhklc01w389Cmlt6ktxd+V
        9uq7t2DYYa5mR3LoyLaMuMRmlspok+w0dVi9cTk4UeJZdExtQ82vDxNZt4J1iSVQb8FH5/1Bx/SkJ
        ABFAu7Vg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qR2zn-00Ckt2-3N; Wed, 02 Aug 2023 03:57:59 +0000
Date:   Wed, 2 Aug 2023 04:57:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     thunder.leizhen@huaweicloud.com
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, openeuler <kernel@openeuler.org>
Subject: Re: [PATCH v3 1/2] mm: Provide empty function for kmem_dump_obj()
 when CONFIG_PRINTK=n
Message-ID: <ZMnUR61eFmO014EL@casper.infradead.org>
References: <20230802034518.1115-1-thunder.leizhen@huaweicloud.com>
 <20230802034518.1115-2-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802034518.1115-2-thunder.leizhen@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 11:45:16AM +0800, thunder.leizhen@huaweicloud.com wrote:
> +++ b/include/linux/slab.h
> @@ -246,6 +246,9 @@ size_t ksize(const void *objp);
>  #ifdef CONFIG_PRINTK
>  bool kmem_valid_obj(void *object);
>  void kmem_dump_obj(void *object);
> +#else
> +static inline bool kmem_valid_obj(void *object) { return false; }

That is very confusing.  kmem_valid_obj() looks like a function which
should exist regardless of CONFIG_PRINTK and to have it always return
false if CONFIG_PRINTK isn't set seems weird.

I see we have one caller of kmem_valid_obj() right now.  Which means it
shouldn't be an EXPORT_SYMBOL since that caller is not a module.

I think the right solution is to convert kmem_dump_obj() to
work the same way as vmalloc_dump_obj().  ie:

+++ b/mm/util.c
@@ -1057,11 +1057,8 @@ void mem_dump_obj(void *object)
 {
        const char *type;

-       if (kmem_valid_obj(object)) {
-               kmem_dump_obj(object);
+       if (kmem_dump_obj(object))
                return;
-       }
-
        if (vmalloc_dump_obj(object))
                return;

... with corresponding changes to eliminate kmem_valid_obj() as a
symbol.

