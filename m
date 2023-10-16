Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CF97CAB01
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjJPOLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjJPOLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:11:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A29B;
        Mon, 16 Oct 2023 07:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=czV84VhOyQlJV3boH+4QfGzVmblLtaU2dw7F3ceDF1A=; b=AdtBRvrY0I7rDxLM3v6Xhb14vK
        pgYuVcXg9Fc97jR6r0nofizvmWPF7ePoe3c518Uiix2HWu8YOKh9+jkLQaO/SLHahQf9hf1ZKSo4Z
        QuYvPyeMoXlz130uNdkiG9okgrwfKPybajkRTryFhfDHVlpw3dKqhXBxpDtY3dTajR640O/16fDG3
        aLJonvWi/fNtdnYvbFHdHtt4UYGEZJtOJqsy8ySp5XydZXV4xycLu6wCZbsDaNolEcr1flKH9wbSB
        XuPeRhrD7TVuwT8XQo+8UEurGWyZSjnyj1siPNHt3Zd0d6YBjt1bPsDkY3leLRpkJ1zwGeAOmqiaZ
        mJdmezOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsOIT-006Str-8h; Mon, 16 Oct 2023 14:10:17 +0000
Date:   Mon, 16 Oct 2023 15:10:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mjguzik@gmail.com, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, peterz@infradead.org, oliver.sang@intel.com,
        mst@redhat.com, maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] maple_tree: Introduce interfaces __mt_dup() and
 mtree_dup()
Message-ID: <ZS1ESVpQ+vY0yDt4@casper.infradead.org>
References: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
 <20231016032226.59199-4-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016032226.59199-4-zhangpeng.00@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:22:19AM +0800, Peng Zhang wrote:
> +++ b/lib/maple_tree.c
> @@ -4,6 +4,10 @@
>   * Copyright (c) 2018-2022 Oracle Corporation
>   * Authors: Liam R. Howlett <Liam.Howlett@oracle.com>
>   *	    Matthew Wilcox <willy@infradead.org>
> + *
> + * Algorithm for duplicating Maple Tree
> + * Copyright (c) 2023 ByteDance
> + * Author: Peng Zhang <zhangpeng.00@bytedance.com>

You can't copyright an algorithm.  You can copyright the
_implementation_ of an algorithm.  You have a significant chunk of code
in this file, so adding your copyright is reasonable (although not
legally required, AIUI).  Just leave out this line:

+ * Algorithm for duplicating Maple Tree

> +/**
> + * __mt_dup(): Duplicate an entire maple tree
> + * @mt: The source maple tree
> + * @new: The new maple tree
> + * @gfp: The GFP_FLAGS to use for allocations
> + *
> + * This function duplicates a maple tree in Depth-First Search (DFS) pre-order
> + * traversal. It uses memcopy() to copy nodes in the source tree and allocate

memcpy()?

> +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
> +{
> +	int ret = 0;
> +	MA_STATE(mas, mt, 0, 0);
> +	MA_STATE(new_mas, new, 0, 0);
> +
> +	mas_dup_build(&mas, &new_mas, gfp);
> +
> +	if (unlikely(mas_is_err(&mas))) {
> +		ret = xa_err(mas.node);
> +		if (ret == -ENOMEM)
> +			mas_dup_free(&new_mas);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(__mt_dup);

Why does it need to be exported?

