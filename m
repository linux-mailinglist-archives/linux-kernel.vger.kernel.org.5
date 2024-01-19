Return-Path: <linux-kernel+bounces-30768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76762832426
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96221C22660
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDA54A0A;
	Fri, 19 Jan 2024 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWy5mspU"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2A3C28
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705641268; cv=none; b=tXnsx+6NNF4+GR6dPzOUhAlvUcWHZ3HxgGPUCx7Wo0XsP3s8TDp31cok/FVmfUra/R89EC9UqxI84tIRLxw9QzlSrr2H32sCWpYYx9HMSW4cPvvsiYK+yeTh5mEmn0Ytr0MR6bcfRVnM8gWD9+eRomznAl0eP5iszwC2kX+KeM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705641268; c=relaxed/simple;
	bh=KDI43KBdy/+D0GsNm71MlYxAwhaV4JknyCQGlxwh4I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yph8AMnBjUoQWXy+ld/793WKcmJ8AFqmQF90GF/e8Pp0Q2tD1hL0+8deF0tGWQwhYVixT3b/aa60yE/s5CNO+ZxrMDJMzX0IFnzouZ7Z52qm0Svdh4uCG4iFyAcU64YsGqihmuwKaHRT8mJrQF3dKST5KtyQPMGI1a6M+k0OUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oWy5mspU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d99980b2e0so426124b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 21:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705641266; x=1706246066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp3wjd4I+zVM5cxe6a7l/i+C674LfaWl8nrY3usedYE=;
        b=oWy5mspU6YPrjA1IIfl5XxtwtvHqYer7K1KQKl63BlJ35HCO6QF8I2xOWK5IUZn7VZ
         8Uf4EawUXRNYHmmb2izi5ZBSitSX3w3FLw0+3hPnNKs2o1+UQVsNOm9ftsJ7gOS4b7Vm
         dcmoSS7V4sY0rUkmvTn7JZ3LcDHkHz86ogKHWATG7BORlDaH9mD5RrdyJ4Kldz3L2tGm
         yt2c02bN5gN89TUOTQzXOrPw6OJtE3fi1ufzmiu2O2xmIgUwd8o9Cyeax2MzCGRJytK5
         s5Chch2Y/sxW3b+eZWfjOq9G47hVlirvHuhtSBm2+CNxoAskXW5ecyUV2QW6Kd9k3QY9
         TtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705641266; x=1706246066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wp3wjd4I+zVM5cxe6a7l/i+C674LfaWl8nrY3usedYE=;
        b=axE/7TyrFq0CFOtmwij5eGoH4j/XMhsg52ppPu1ivHpRTSVob1KV0V6SMvlA2VbcdL
         Xggt/+0j+J/gq/kbV6I8z8mG/LMlxW0v4ufMb+14CMQCpLlZYPALm0vAnXiYJtO/kvwe
         6O+w0mer+4/iDJ+b5PNa6mq84oexdFj5JBibv93yq7NpV9t73HTJMoyHHvWAmZaBSVnA
         dQpsj0eUNcYjJWk0pMR2zlYCGcSR83S13FV3utWXv0u12TLRB9ju5L6Ohz35u9ya6OiB
         Xwednmt2ZnVWl5PPVl9pmqZV22KVqX1Q39QlIznrkreXyefc93ZO0qD6mKxcDVAgDJRa
         Hqdw==
X-Gm-Message-State: AOJu0YxrnxF/VAuWop3T0a+Zrk85Whi//ir/eP8LG+Bk/0P2bLnTDrfn
	0fcGdgvEqKRs10pUMsVxA8s9w4saBA8/uYGTOF5uqKqeA2uSVNHy5di8b23HoYQXrTI3fRpRsXO
	Xqd/owie6Ud4hkMlwkphJxtwn7th9dV3vAMd9
X-Google-Smtp-Source: AGHT+IEBqp9/5YJugFJacZWPpA3Hwk7qBhdjQ0F3H3c8Hz8ipPEPg0B0bEzZOC0YK0BSCY4x09tssRrGjcbUV+zf75M=
X-Received: by 2002:a05:6a20:1441:b0:19a:57e9:905f with SMTP id
 a1-20020a056a20144100b0019a57e9905fmr2190743pzi.8.1705641266412; Thu, 18 Jan
 2024 21:14:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org> <CAKEwX=PB0=-ecJwv1=JgnmRJJdPw5f0jnRp7jwusVG9pd=C5sA@mail.gmail.com>
In-Reply-To: <CAKEwX=PB0=-ecJwv1=JgnmRJJdPw5f0jnRp7jwusVG9pd=C5sA@mail.gmail.com>
From: Chris Li <chriscli@google.com>
Date: Thu, 18 Jan 2024 21:14:14 -0800
Message-ID: <CAF8kJuP_ViuB08=uUWv-dM=FrofsYNuPY8hJQ7Ps5o7j5vzfWQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, =?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
	Chun-Tse Shao <ctshao@google.com>, =?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Brain Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 10:01=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Wed, Jan 17, 2024 at 7:06=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > The RB tree shows some contribution to the swap fault
> > long tail latency due to two factors:
> > 1) RB tree requires re-balance from time to time.
> > 2) The zswap RB tree has a tree level spin lock protecting
> > the tree access.
> >
> > The swap cache is using xarray. The break down the swap
> > cache access does not have the similar long time as zswap
> > RB tree.
> >
> > Moving the zswap entry to xarray enable read side
> > take read RCU lock only.
> >
> > The first patch adds the xarray alongside the RB tree.
> > There is some debug check asserting the xarray agrees with
> > the RB tree results.
> >
> > The second patch removes the zwap RB tree.
> >
> > I expect to merge the zswap rb tree spin lock with the xarray
> > lock in the follow up changes.
> >
> > I can surely use some help in reviewing and testing.
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > ---
> > Chris Li (2):
> >       mm: zswap.c: add xarray tree to zswap
>
> While I think it is pretty neat to keep the rbtree around to check if
> the results agree during development stages, in the final version
> please squash the patches. One patch is enough :)

Ack.

Chris

