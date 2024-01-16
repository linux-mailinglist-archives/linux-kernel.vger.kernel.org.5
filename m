Return-Path: <linux-kernel+bounces-28249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A2682FC21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A05B28E308
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2435224FA;
	Tue, 16 Jan 2024 20:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjOFhrbq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D649224E7;
	Tue, 16 Jan 2024 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437135; cv=none; b=KPVSFvCpKj5NSYSVZifhtyXsY6xnUZdExf20OEojWrVOaHEcs9ybeD/f4Bi4s7dv0B1B2yMl83f3cD9VhHLPJMgdGhvge+7I0TQcYHNmY6mOa4AoWBbpzwJhbeqBfg3a9Inu9eGgNUBb9H3cIdNm51yEXHy27JXHHAMFS+rSzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437135; c=relaxed/simple;
	bh=0gNuhgg77yxXDonAd8TaqH0VHZHjbXRDBmWe7QPHx4w=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=cYI4eXvxFpbtacd8KZqgHjOm+vz7eghjdeOEmVfxmwJxgDikGPPTtePbVBDBzBL/tN/jvQ72xzEigx4RSKTOOgkf0BuTJ9IB1BAO+Rk7KD2sLZ0uEpSDyDeBkSPx4TkyXFeW0JPXEc4gOaf86TPoweZ/6qMA30EJJJlbqeNNomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjOFhrbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAC0C433F1;
	Tue, 16 Jan 2024 20:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705437134;
	bh=0gNuhgg77yxXDonAd8TaqH0VHZHjbXRDBmWe7QPHx4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HjOFhrbqv0DoCJkjrlCoAB7fz/4ibnyb9//Y+6gWP43abhAV+FYMPB8l06SBOAAN1
	 qGLS91p1JfEmQUcOt1R/UqBBYbpSJwHaUDNrHorlGjD2XA+NsreiQs9qxRGn0jnh5a
	 26aztPnxE1i1NiyRYTzyRT91+w6vUYQnGV0FvOe074J0WQFOfG8NiOmrLDL5R1oMQl
	 9D4pMrcJHJuDxZu24ukl9dVooFe2v9+YI/2RNwne+7Nsz0Mnr+OjqGTlncFgFQzGvQ
	 VLHTAix+8mc6YuxYx2v6KLYu06fU0+lFxDTm4YvHGKB2yKoQ29eWf2Ykcwl5823vI+
	 ZLcM3fYLAhRzQ==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	linmiaohe@huawei.com,
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com
Subject: Re: [RFC PATCH 1/4] mm/vmscan: refactor reclaim_pages with reclaim_or_migrate_folios
Date: Tue, 16 Jan 2024 12:32:10 -0800
Message-Id: <20240116203210.52843-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115045253.1775-2-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Jan 2024 13:52:49 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Since we will introduce reclaim_pages like functions such as
> demote_pages and promote_pages, the most of the code can be shared.
> 
> This is a preparation patch that introduces reclaim_or_migrate_folios()
> to cover all the logics, but it provides a handler for the different
> actions.
> 
> No functional changes applied.
> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> ---
>  mm/vmscan.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bba207f41b14..7ca2396ccc3b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2107,15 +2107,16 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
>  	return nr_reclaimed;
>  }
>  
> -unsigned long reclaim_pages(struct list_head *folio_list)
> +static unsigned long reclaim_or_migrate_folios(struct list_head *folio_list,
> +		unsigned int (*handler)(struct list_head *, struct pglist_data *))

I'm not very sure if extending this function for general migration is the right
approach, since we have dedicated functions for the migration.

I'd like to hear others' opinions.

>  {
>  	int nid;
> -	unsigned int nr_reclaimed = 0;
> +	unsigned int nr_folios = 0;
>  	LIST_HEAD(node_folio_list);
>  	unsigned int noreclaim_flag;
>  
>  	if (list_empty(folio_list))
> -		return nr_reclaimed;
> +		return nr_folios;
>  
>  	noreclaim_flag = memalloc_noreclaim_save();
>  
> @@ -2129,15 +2130,20 @@ unsigned long reclaim_pages(struct list_head *folio_list)
>  			continue;
>  		}
>  
> -		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
> +		nr_folios += handler(&node_folio_list, NODE_DATA(nid));
>  		nid = folio_nid(lru_to_folio(folio_list));
>  	} while (!list_empty(folio_list));
>  
> -	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
> +	nr_folios += handler(&node_folio_list, NODE_DATA(nid));
>  
>  	memalloc_noreclaim_restore(noreclaim_flag);
>  
> -	return nr_reclaimed;
> +	return nr_folios;
> +}
> +
> +unsigned long reclaim_pages(struct list_head *folio_list)
> +{
> +	return reclaim_or_migrate_folios(folio_list, reclaim_folio_list);
>  }
>  
>  static unsigned long shrink_list(enum lru_list lru, unsigned long nr_to_scan,
> -- 
> 2.34.1

