Return-Path: <linux-kernel+bounces-31523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE635832F76
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF8C1C23CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B420F5821D;
	Fri, 19 Jan 2024 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gv5X+/1S"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E5A58210
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705693104; cv=none; b=hfdSsaJklEMasoVBBjN8kxr+7FtQPt2Ggvx4Lp6N+WFBMWBFo11wyJ+lboIcVPHo27hHDQjjaIkoAo4O8XMaiuiSwFLLa5zrjwQZoTRzDuzSjZY2gVFZMoYoQvS7AStmVHdkiPZuuCDCgoeWiXbEdIbpZmQLbpZKNlkpSEKgLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705693104; c=relaxed/simple;
	bh=AGnn/MsX85yn8KUcF8f/JaW7Zm3qd9DTw9KnS3mXcVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BO5EhITBCZtwzA01yCG95cM8COi5pZ208kWDoHjWtdzuPunoJlIYEYD4VjVZpvdZIUqxnqbD9hzdHD+NClEfU5dPcw5GQNLPeI9YJ+ONCOotYG2ZSLK9hhCH5NkPJ0MbIeOEG2GhM8AKNxpTofy6OrrM1lj74VsfQxvs2AVbLl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gv5X+/1S; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28cc85e6b5so135588266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705693101; x=1706297901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AGnn/MsX85yn8KUcF8f/JaW7Zm3qd9DTw9KnS3mXcVo=;
        b=Gv5X+/1SCaht7WLtwMvc4olGOns624sfGppM41XmrM4zxh0MucE6k+RicnqjR8FHvn
         yw3cqD38qYN2M63biOTIpNCLnKf99Y9jDJa3MbBT9oMjUAsmCxiypuRz/V4uU/YLFLpO
         zxPVUDCByAw79ER4b0CH7lFugZBIsNerqWd5SdvJOzDKI9QNRMl8BLxEr2PIG9B9wpms
         7XPbXnK7H76fnzvqzREnNtd1r72IYBwn1cTfNF8CdXrBk5O7/ttMSVhomMIsf98kOffC
         m5M665vNGj6/IyvO/NAT1c5NvTR1UxS7iDGXwFNWApehh2K86MlYVpKwnVyW3aZDDiVC
         dK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705693101; x=1706297901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGnn/MsX85yn8KUcF8f/JaW7Zm3qd9DTw9KnS3mXcVo=;
        b=AwIrGvjBYAqJEZkyiljBppY9OHgTQWxTpc3d/qaPq8EOSVKIzH+KA0+z92hNGblg3x
         g1uOsHHzI4yu+B0iJ58Pr9MAIT5ATvW0+ftTpi3Ju98URhFWG5RmrW4gvt1FyggAszAD
         HSQLqKuJhUrHSdsrPnZrlQnBH9N+wTi/NSvEUoddjRlXu5bJz0Onn9NV53/14Di/I1mQ
         oBt1tZ/JfyyiGq+pwaW7NNK9a9rORKGop3SbK39CX9uaAYbLxC2nN/q4Rubrd6df1hZh
         snYOul+nieMwwSqrjYufgwhq9eskJ963105NMySRkmTGS1nU4872eBDf35CFpnWuc+H6
         BCvg==
X-Gm-Message-State: AOJu0YyiQr2YllkLx0A8eHXjiix7CEwKWZ+FmjYeLkXqGZHndq8m34PR
	hOCKf06I5WSD6wTbEeCDsdIL10p9DKwGJS+SPBmKJz9EP3esLK4HCmijz+MQsuT3YNQU2Pq9lKl
	fSQyugFUCkBO/T9wr5tVy63qVoiWnYTi2UmHu8IvCSD4W7yHKwEUa
X-Google-Smtp-Source: AGHT+IEm0cj7d1omhPy8sasgNGgbLNRFamkIaWEh9FIdgrBq2tERmIXGAL4g9duxW99951YVpZ2ru8DACmu/AwVhzLg=
X-Received: by 2002:a17:906:74f:b0:a2f:1588:d271 with SMTP id
 z15-20020a170906074f00b00a2f1588d271mr103336ejb.224.1705693100587; Fri, 19
 Jan 2024 11:38:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-2-6daa86c08fae@kernel.org> <CAJD7tkZF102x_8LKAX+sxAttgYD_LNT3cRqeOr7_euwPfNdCFA@mail.gmail.com>
 <CAJD7tkbFxfLxYPXHkSCq=1JsAinW9G+unyOadFY+Xfo-QTqNyA@mail.gmail.com> <CAF8kJuPXrkN3XRvpgf4t-afxU-JpcNGVKyoXXwiEXMypchaEGg@mail.gmail.com>
In-Reply-To: <CAF8kJuPXrkN3XRvpgf4t-afxU-JpcNGVKyoXXwiEXMypchaEGg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Jan 2024 11:37:44 -0800
Message-ID: <CAJD7tkYvxWPfKTQC_yEZaC5w+gefextWbH6bXMLjqCPiX0Tebw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap.c: remove RB tree
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, =?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
	Chun-Tse Shao <ctshao@google.com>, =?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

> > If this is doable, I think we can return xa_store(..) and keep the
> > logic in the caller. I think there's a chance
> > zswap_{search/insert/erase} may end up being very thin wrappers around
> > xa_{load/store/erase}, and we may be able to remove them completely.
> > Let's see how it goes.
> >
>
> See my other email about erasing an entry raced into a new entry. That
> is the part I am not certain.
> Anyway, when zswap adopte folio, then it might need to handle multi
> entry, we will be back to using the XAS API.

Handling large folios in zswap is a much larger topic that involves a
lot more than this xa_* vs. xas_* apis dispute. Let's not worry about
this for now.

