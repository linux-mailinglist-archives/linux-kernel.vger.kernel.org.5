Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0AD7EBC62
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjKODnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjKODnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:43:41 -0500
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4778CF9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:43:37 -0800 (PST)
Date:   Tue, 14 Nov 2023 22:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700019815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oE/CSWurLiicfPY7jNcreLfS0lMiBahzo5OXWBs5BIY=;
        b=Mq49kvTsVZ0V53IicaOp2HFyphi71N9wKj5rj30kNo0qviqaqblrRsz9P5S+qJ/crR1dTE
        FzAvrf9AUZp2VpKO9wO+SCeg/qGaYSnRGsFGSCu7sPsIdTRfYPTLSgZM43R8VnH+v3UuWY
        MGOBwfZCFeJIIHtSutGt+iV4SQbyM0M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] bcachefs: Remove the unused variable journal_flags
Message-ID: <20231115034332.ccbluu73bx4ejn5c@moria.home.lan>
References: <20231115031329.31138-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115031329.31138-1-jiapeng.chong@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:13:29AM +0800, Jiapeng Chong wrote:
> Variable journal_flags is not effectively used, so delete it.
> 
> fs/bcachefs/btree_update_interior.c:1057:11: warning: variable 'journal_flags' set but not used.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7559
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/bcachefs/btree_update_interior.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/bcachefs/btree_update_interior.c b/fs/bcachefs/btree_update_interior.c
> index 9affcb22d9cb..18e5a75142e9 100644
> --- a/fs/bcachefs/btree_update_interior.c
> +++ b/fs/bcachefs/btree_update_interior.c
> @@ -1054,7 +1054,6 @@ bch2_btree_update_start(struct btree_trans *trans, struct btree_path *path,
>  	unsigned nr_nodes[2] = { 0, 0 };
>  	unsigned update_level = level;
>  	enum bch_watermark watermark = flags & BCH_WATERMARK_MASK;
> -	unsigned journal_flags = 0;
>  	int ret = 0;
>  	u32 restart_count = trans->restart_count;
>  
> @@ -1068,10 +1067,6 @@ bch2_btree_update_start(struct btree_trans *trans, struct btree_path *path,
>  	flags &= ~BCH_WATERMARK_MASK;
>  	flags |= watermark;
>  
> -	if (flags & BCH_TRANS_COMMIT_journal_reclaim)
> -		journal_flags |= JOURNAL_RES_GET_NONBLOCK;
> -	journal_flags |= watermark;
> -
>  	while (1) {
>  		nr_nodes[!!update_level] += 1 + split;
>  		update_level++;
> -- 
> 2.20.1.7.g153144c
> 

Yup, this is a leftover from deleting journal pre-reservations.
