Return-Path: <linux-kernel+bounces-29729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCDC831298
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3125E1C220D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4E4B65B;
	Thu, 18 Jan 2024 06:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ly0XfBQ2"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E222CB641
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705557749; cv=none; b=KJCHfrtZPpNsCd7aAflgaDbqs2BaUw/ufhbCsJ8TNs6NIrPG4BV6vzCTMxYt3tYoMcwJ29gEOmNfSanPkKEnQMSH3XPLYpXXM3EC0bzTGQYDRyPcbmwWacZPBUhDh6Sqa6q6rtDa2huVKOI6HTq4xQBqu+lvAgS04AIlcfly/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705557749; c=relaxed/simple;
	bh=u5RaG/b4PJwUTnZ4ynSVNBmNKKCbc+bIbPvRY2XtEzg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=EWHTiNezULjzTIj4ra8xsevxrbhhe86KI8TiHa3TPh9tCTlN0QIZKy8ifdLq1rQbBa6wC2EWfLeCaJLuqQGHn+iSZp48K/euxP95HNxC+P6maOxwksDsW2HPnnNgwVLCa88PWrmQZwGi1oO9fkWIQYum8b3HOgeDEt+FW5gsgho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ly0XfBQ2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2ac304e526so1174613466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705557746; x=1706162546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nGZnmxJ3pdqJ6wmKHxjoSZlS4o/scgVJ84X1tEAH1s=;
        b=Ly0XfBQ23Fhj0TGVr9IWC9zTGMyuAwRnc63/qpxHvop5SOIpup7rzbDR5rbtR4xUFM
         AEUu91f+DfIPBBWBxWyt/ZN3iPBFLzWEfxp+GGtajLQ8GwYnSzRzOo4mFM9vT/TYr8j1
         kjmO203b74+XtV4qOQCwnvVKqFoUwmQKWJNIHxHB7EsFm9l24ZRSuS12NglUia06ywfR
         UatGA30NaC6fLc0s7EdO/XubUbUwdFV19rOIkEr68zILaUwK7lw0AVFpIgMhMQ8DrnV4
         3/R4M/Z2rwXMUbkHI1ED/tVSKx1EaGSEkYt4hV7Fnn+CRDLoS+pSdpqmEmJCs1nvhSNT
         cqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705557746; x=1706162546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nGZnmxJ3pdqJ6wmKHxjoSZlS4o/scgVJ84X1tEAH1s=;
        b=PtOomfu27TRcAYFMP2IMcSr4N9JzAi7enr31XllyoH+td1/6kRc0hVg3Yk2RJ3WYva
         AlCVyCeQgoSaOgSfAhCnuEqNB+mazg8ILUqDGx4L0+oHE2TgjU84ZtSM/SvHMoQ2aH9r
         IcrSdFJd9pggyxoFgOaiYbE1Wf1lnA61D0qfIn8UTNrh5ga/N3mTv046aa6XuedCJR11
         Hgm6+7CgaxsNlMukSyBSOCn7kXb3GqE0fQ21Dkztiyk4jpt3k3gNPcBy0f1RRi4bdHxF
         zn2QAsG8ULyMOQdPMf3Y5itdJZ0I9smmQUGk9Gidd+6KYvXd/HW/sBrN7FDyJ1bkwEF1
         iUvA==
X-Gm-Message-State: AOJu0YzYocE3m5mzLQrRsce3fkGdVj+2tdRLHkBmzRuYrDc5ZsSBhZkM
	7qBBXMwjT6lnfkQIXng683EZTgv4/Rz/LxgU1cfg/MJWs1WJfe0TYNZU4/cYClSE4hgCAeilbj0
	V8s1+V8IM15rp79c7h++56tvpznQDhTy4jaXy
X-Google-Smtp-Source: AGHT+IElbfBnRmPumPhcTCydVvIUyicQ24usBsNFChB+mW2xoUWE6BD0Q0nCfme+EK+zG6f0T/PILhv2JAz0JmB3eaI=
X-Received: by 2002:a17:906:3797:b0:a2d:b4d3:b89a with SMTP id
 n23-20020a170906379700b00a2db4d3b89amr176271ejc.134.1705557746073; Wed, 17
 Jan 2024 22:02:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
In-Reply-To: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jan 2024 22:01:48 -0800
Message-ID: <CAJD7tkbQb5nAQdhHXELQsUWs8KhwnoOZ7C8Eu2o7tCYSKeY9Ug@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
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
Content-Transfer-Encoding: quoted-printable

That's a long CC list for sure :)

On Wed, Jan 17, 2024 at 7:06=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> The RB tree shows some contribution to the swap fault
> long tail latency due to two factors:
> 1) RB tree requires re-balance from time to time.
> 2) The zswap RB tree has a tree level spin lock protecting
> the tree access.
>
> The swap cache is using xarray. The break down the swap
> cache access does not have the similar long time as zswap
> RB tree.

I think the comparison to the swap cache may not be valid as the swap
cache has many trees per swapfile, while zswap has a single tree.

>
> Moving the zswap entry to xarray enable read side
> take read RCU lock only.

Nice.

>
> The first patch adds the xarray alongside the RB tree.
> There is some debug check asserting the xarray agrees with
> the RB tree results.
>
> The second patch removes the zwap RB tree.

The breakdown looks like something that would be a development step,
but for patch submission I think it makes more sense to have a single
patch replacing the rbtree with an xarray.

>
> I expect to merge the zswap rb tree spin lock with the xarray
> lock in the follow up changes.

Shouldn't this simply be changing uses of tree->lock to use
xa_{lock/unlock}? We also need to make sure we don't try to lock the
tree when operating on the xarray if the caller is already holding the
lock, but this seems to be straightforward enough to be done as part
of this patch or this series at least.

Am I missing something?

>
> I can surely use some help in reviewing and testing.
>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
> Chris Li (2):
>       mm: zswap.c: add xarray tree to zswap
>       mm: zswap.c: remove RB tree
>
>  mm/zswap.c | 120 ++++++++++++++++++++++++++++++-------------------------=
------
>  1 file changed, 59 insertions(+), 61 deletions(-)
> ---
> base-commit: d7ba3d7c3bf13e2faf419cce9e9bdfc3a1a50905
> change-id: 20240104-zswap-xarray-716260e541e3
>
> Best regards,
> --
> Chris Li <chrisl@kernel.org>
>

