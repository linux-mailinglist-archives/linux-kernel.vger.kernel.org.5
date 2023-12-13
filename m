Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00420810720
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbjLMBAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjLMBAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:00:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B6999
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:00:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEECDC433C8;
        Wed, 13 Dec 2023 01:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1702429249;
        bh=zX0Z6kTIbDGINhZlNOlk0Z2jkVLOUNmqX7j2bysydmI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XJnsKvWO0+QO80LJM5XIzpjavAEFaK23gF4aRbBGejzwSzWxTVMw1DiDRubaH/zhW
         DzjVneRMZuMJmYNN4xOxH5C+TyLebDQfGBp2lX4MuuRvggnGNEtGiYgOssQGCOlnvM
         ax4qJYr/NPXcas8bWv5/dAzJANm6aZ9WGRQm1j5s=
Date:   Tue, 12 Dec 2023 17:00:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com
Subject: Re: [PATCH] maple_tree: do not preallocate nodes for slot stores
Message-Id: <20231212170048.7c0afab9c0522c7de6067cd7@linux-foundation.org>
In-Reply-To: <ZXjJTM0pDksnslgo@casper.infradead.org>
References: <20231212194640.217966-1-sidhartha.kumar@oracle.com>
        <ZXjJTM0pDksnslgo@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 20:57:48 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Dec 12, 2023 at 11:46:40AM -0800, Sidhartha Kumar wrote:
> > +	/* Slot store, does not require additional nodes */
> > +	if ((node_size == mas->end) && ((!mt_in_rcu(mas->tree))
> > +		|| (wr_mas.offset_end - mas->offset == 1)))
> > +		return 0;
> 
> Should we refactor this into a mas_is_slot_store() predicate?
> 
> A few coding-style problems with it as it's currently written:
> 
> 1. The indentation on the second line is wrong.  It makes the
> continuation of the condition look like part of the statement.  Use
> extra whitespace to indent.  eg:
> 
> 	if ((node_size == mas->end) && ((!mt_in_rcu(mas->tree))
> 			|| (wr_mas.offset_end - mas->offset == 1)))
> 		return 0;
> 
> 2. The operator goes last on the line, not at the beginning of the
> continuation line.  ie:
> 
> 	if ((node_size == mas->end) && ((!mt_in_rcu(mas->tree)) ||
> 			(wr_mas.offset_end - mas->offset == 1)))
> 		return 0;
> 
> 3. You don't need parens around the !mt_in_rcu(mas->tree).  There's
> no ambiguity to solve here:
> 
> 	if ((node_size == mas->end) && (!mt_in_rcu(mas->tree) ||
> 			(wr_mas.offset_end - mas->offset == 1)))
> 		return 0;
> 
> But I'd write it as:
> 
> 	if ((node_size == mas->end) &&
> 	    (!mt_in_rcu(mas->tree) || (wr_mas.offset_end - mas->offset == 1)))
> 		return 0;
> 
> because then the whitespace matches how you're supposed to parse the
> condition, and so the next person to read this code will have an easier
> time of it.

Yup.  But I'd suggest going further:

	/* Slot store, does not require additional nodes */
	if (node_size == mas->end) {
		/* comment goes here */
		if (!mt_in_rcu(mas->tree))
			return 0;
		/* and here too */
		if (wr_mas.offset_end - mas->offset == 1)
			return 0;
	}

ie: create space to add those comments explaining the reason for each test.
