Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AA176CF1C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjHBNqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjHBNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:46:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD92B2;
        Wed,  2 Aug 2023 06:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v/HxkH+MwMRJoj9XZVDChrBs6s8fFrJtnhjR+r44FxE=; b=NvyUM+JBp/xq4xJaZzCRS3wJli
        mqSKGYiwuXzI4hGj5B/wNO/D6eUOoeGGtDm2PjC7kqJhopmih6pDZMTNw2l+aE/fe7CU95j2Y8s+X
        jA5q982D9O78ksrjMOMXyLRKbQDpTHe2dhvm+GJ6oOOJ1QNKhPseT8jw0wBjtkhw/cYhsnRpSNK+U
        atChSXzNjxzUh24Wxn0ffoOTJRsgnAgui4vdHbXDRcsymaX7BRI4JUXElE5tJdKWlIgViOByPmnUN
        c6fIPpqud3CUKEGLWhH+hDo/naZGAaR+xJzf1a1hyP97rnXrdbfesxBcRvgmFKjvJ7lQGIGQD7Oyy
        ACgpUsHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRCAr-00FGsh-7W; Wed, 02 Aug 2023 13:46:01 +0000
Date:   Wed, 2 Aug 2023 14:46:01 +0100
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
        linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v4 1/2] mm: Remove kmem_valid_obj()
Message-ID: <ZMpeGSDX2sVUf8gT@casper.infradead.org>
References: <20230802130918.1132-1-thunder.leizhen@huaweicloud.com>
 <20230802130918.1132-2-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802130918.1132-2-thunder.leizhen@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 09:09:17PM +0800, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Function kmem_dump_obj() will splat if passed a pointer to a non-slab
> object. So no one will call it directly. It is always necessary to call
> kmem_valid_obj() first to determine whether the passed pointer to a
> valid slab object. Then merging kmem_valid_obj() into kmem_dump_obj()
> will make the code more concise. So convert kmem_dump_obj() to work the
> same way as vmalloc_dump_obj(). After this, no one calls kmem_valid_obj()
> anymore, and it can be safely removed.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
