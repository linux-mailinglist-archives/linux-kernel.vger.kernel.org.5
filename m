Return-Path: <linux-kernel+bounces-72327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B74DD85B205
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747A4284079
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4808F56B98;
	Tue, 20 Feb 2024 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iTJsI8WT"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7601056B91
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708404866; cv=none; b=pVyHZQTl1ohpji9TQrwnJS9oe2V+u42WSRSlbDaLgMUY4qju5J4h6qqWIcpVHOGt+JglraSf6PnC6Jb8cOFVqvu++Jj5oRUpnpQOMJ8YN6xqFC4rBGAJxgTjIjtnliNTmfKW/Exh+7wqIMsIdWfWYvUqEMp5on2TwLYzj1iw9qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708404866; c=relaxed/simple;
	bh=XdiGLnXdU3YDm54S5y3LvaT82CJoIBmZQypvBDwelXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCERpAzYt4dyf2+ROgGVPt+F4kVJwiCoUyfFagQ7yR6VZnhsH/o0kUTr5NNMyZns9JqT0U1A/XT0bFroBcHd5VHkAr8W5dOwiCqeJ6ZYAJ9BGPAauCypgaSeKkFjCkbbuODM+1ez5+TSi49YfW+kLfFJJtoIzn25PuamDDbyKqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iTJsI8WT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e435542d41so906738b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708404825; x=1709009625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nULdIlN8P9GOzg8tQ8IrvCNklX5cp+cB0/VEr6sZ/CQ=;
        b=iTJsI8WT4lRwMK7ZTuBsTRb4HGgSDiapsPoD8O6DeuNzRWY8weiq77eRLTDuxcHeN/
         N0/MZhgcsQmQuDrnLAPjxqH8T7UID+xtbwDkbUMEH1g4EXDu9G/weL1BFeSdf5H2Hxf1
         b+F6bZYh4ENQuGPfGYfKMQfrXigKIqZutNDEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708404825; x=1709009625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nULdIlN8P9GOzg8tQ8IrvCNklX5cp+cB0/VEr6sZ/CQ=;
        b=M30ym6EUh7lZB4ZmQ+MnKdaxGZyI4hS459aQVoBzDpacXXa7rHw3ZnXVLVpmL6mFsm
         xmmXgwNcrGpJ1yFY0e4K5g/4oaLqUzfRQFKk3xns+WI4y46FoqU0kYi35Run47IpI00F
         BX8Mrn39gZmNMc0QcQ2qmQn/FEElA9njzrVTtKoN75d+YvpMNyF3VrCLPbBPLjwAosWC
         ddSZFCmuUFVoHeJrv/YNqf3jklGy7JSIJRUsVUCusqOObbmWSHqu3lwNzFRu8Un3lM/Y
         Ho036NJzZQkgr44Dn7n/FBInunH22xQ18BvcO7EnBHACTT1c9rA4X5sjOyLi6/yGgf+i
         M0XA==
X-Forwarded-Encrypted: i=1; AJvYcCWHmpOXca7ggGoALINajArRL6hMo3II85gh14oCL/H53nhT0KiDeAEg6S5QMBLlIYxrjQxW8jjtc9s0inZWzSSFr+KQMirDV4SdLKrv
X-Gm-Message-State: AOJu0YwaZZd0nnC4V6SoZD1E2az+CuYNXYEF0FnfqvE1OAkQ4odRyvBp
	3S7YRiwzYpBIWMcJvmVcgxbygmdOHu0tQkyJ7n0GrGsjatpCuSbCiUHhuDStDw==
X-Google-Smtp-Source: AGHT+IEPS7YHVDe6gBmn5CNxWFUgHa6I5LA5SRd20TI6EvIhsIWjGxQOkqIHP9/dMAPmjEeXgU068A==
X-Received: by 2002:a05:6a20:9c93:b0:1a0:931c:a152 with SMTP id mj19-20020a056a209c9300b001a0931ca152mr7233613pzb.21.1708404824846;
        Mon, 19 Feb 2024 20:53:44 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:8998:e92c:64ca:f09f])
        by smtp.gmail.com with ESMTPSA id d9-20020a17090ad3c900b002998dbcf570sm3875963pjw.8.2024.02.19.20.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 20:53:44 -0800 (PST)
Date: Tue, 20 Feb 2024 13:53:40 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, nphamcs@gmail.com,
	yosryahmed@google.com, Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, hannes@cmpxchg.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/zsmalloc: remove migrate_write_lock_nested()
Message-ID: <20240220045340.GE11472@google.com>
References: <20240219-b4-szmalloc-migrate-v1-0-34cd49c6545b@bytedance.com>
 <20240219-b4-szmalloc-migrate-v1-2-34cd49c6545b@bytedance.com>
 <20240220044825.GD11472@google.com>
 <4f3c6c96-3bea-4369-a2de-e3c559505bba@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f3c6c96-3bea-4369-a2de-e3c559505bba@bytedance.com>

On (24/02/20 12:51), Chengming Zhou wrote:
> On 2024/2/20 12:48, Sergey Senozhatsky wrote:
> > On (24/02/19 13:33), Chengming Zhou wrote:
> >>  static void migrate_write_unlock(struct zspage *zspage)
> >>  {
> >>  	write_unlock(&zspage->lock);
> >> @@ -2003,19 +1997,17 @@ static unsigned long __zs_compact(struct zs_pool *pool,
> >>  			dst_zspage = isolate_dst_zspage(class);
> >>  			if (!dst_zspage)
> >>  				break;
> >> -			migrate_write_lock(dst_zspage);
> >>  		}
> >>  
> >>  		src_zspage = isolate_src_zspage(class);
> >>  		if (!src_zspage)
> >>  			break;
> >>  
> >> -		migrate_write_lock_nested(src_zspage);
> >> -
> >> +		migrate_write_lock(src_zspage);
> >>  		migrate_zspage(pool, src_zspage, dst_zspage);
> >> -		fg = putback_zspage(class, src_zspage);
> >>  		migrate_write_unlock(src_zspage);
> >>  
> >> +		fg = putback_zspage(class, src_zspage);
> > 
> > Hmm. Lockless putback doesn't look right to me. We modify critical
> > zspage fileds in putback_zspage().
> 
> Which I think is protected by pool->lock, right? We already held it.

Not really. We have, for example, the following patterns:

	get_zspage_mapping()
	spin_lock(&pool->lock)

