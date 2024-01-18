Return-Path: <linux-kernel+bounces-30453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD1F831EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D803F28C0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BC52D615;
	Thu, 18 Jan 2024 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JK6bXBKq"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0ED2D609
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600894; cv=none; b=bgw12XS8LWqslvw1uwxJ5gzBCqH9vWEPcWsf+pNNSdzFgJHkWUUoe3AOh3JV1rFop3OuCQ/aryZvSuuhpp+UkH9Be4sj3EHvY06RvPOuAkgyN2exnmOjyrrgPaKG7OqBNCLpTBSnyFgtyzRvZKm7evREEO0jiRaA8NQS+UnHydY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600894; c=relaxed/simple;
	bh=uqEn4FO9fz2oMQ6KrNER0vp9V3traJzwrSg/mntc0uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyksV3H0IbQT3Qbb7kSN6iedlN5xOvXmVpGG4Jl41F22p01FqUiwEr/piuMuYA3pVSL9jpp3ITclhFeYGeTtbpb3EIqsj0vZyFcwMxwjGVdH0LndND30bAmcLfhMmeUKhOiskH0/aba+GzJVtf/7iWwJ9ik1/0qqS+Owp6nuA8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JK6bXBKq; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bee8858a8aso302171639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705600892; x=1706205692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gql2dWnZ2ERl3+pU3WuNWOTW7xdtLV2bCUv96eyfuAk=;
        b=JK6bXBKqdTYdYgXA29cmhnhPGadtw1zH9oopNgSkALilZAzzAX1u1jq146IJnZHs2k
         Nq9QX8Upoj9NbEoHiZDG9Il7aor3ZDzdjFMTwLScJM0bdUBdW+jzlCIV1df0S67TkjUD
         2oT+AMxnYys2KD8UlblAhxkm2jMJ2dSwBXhwqQT4WUBr+W6qlIkJHHnIM3WRELIkrtN5
         N9CdJevYfAqNKJXHp9Amx/xXZJvIV/WBe4ltyCylJAPNcJp96E0LHDWHxwtpbq+Ldn3d
         SIKYJHqGIiLZS0FITxp2iQUQp75jfjy2zpRdzSugm15Wu/LUItCkf5hcZkbyBk30qBKw
         YOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600892; x=1706205692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gql2dWnZ2ERl3+pU3WuNWOTW7xdtLV2bCUv96eyfuAk=;
        b=UJlUy9nHgScw+sj0g1WmjlfVFlLA291odpY6IcNCOPDjX14pY6MhI8YgBOyWSQO9fD
         /RFiIBBAazGXxkRAf0uTaYdD2WrB7T4rax/MHhCRH5hzdQF2WNpxTVJOeS3ezffRm/Ib
         KwlmMlBjHfg7A4tfhON5utu7g1WWABMP6AE6xEdr/niimHmk2Gk7ZDA2UTYtnzGC04Hk
         XeJMWWovExMUwxwxIMT7YsjzWLroY7AUeH/b/zspCGoIAIVdO2HhFIxiNgehgKkyMQoZ
         Ken6ZbovPwd0ago5G1wWUAY7pVtd2YlHKdeqS+rKsLMrV+0+HvJONLNpZIRWQgaMa2j2
         WzDA==
X-Gm-Message-State: AOJu0YwVat+BvYzwZMXXLfdMenILNFuK/+z4Hf6AhHug9EJN67ogqB1B
	CsxfCHTTfE8A0CmV+OYxGRRnj8FnarEZlwdkV/LBXiLHFRcyRnFPF9Wklw3AOG7N0adtGWX21Ty
	qR2NCUCrxWAvpmljZn6cwZezO4JI=
X-Google-Smtp-Source: AGHT+IED1f6HXEGeea8vx+OGzr4gyatb/CWIwGNnoi/Xh0FaSKDxmWyMlt4nzquEg6fDC8fIfqdIqEAMAswTwKcZqsE=
X-Received: by 2002:a6b:c8d8:0:b0:7bf:42d7:f4b with SMTP id
 y207-20020a6bc8d8000000b007bf42d70f4bmr1321080iof.6.1705600892417; Thu, 18
 Jan 2024 10:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
In-Reply-To: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 18 Jan 2024 10:01:21 -0800
Message-ID: <CAKEwX=PB0=-ecJwv1=JgnmRJJdPw5f0jnRp7jwusVG9pd=C5sA@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
To: Chris Li <chrisl@kernel.org>
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
>
> Moving the zswap entry to xarray enable read side
> take read RCU lock only.
>
> The first patch adds the xarray alongside the RB tree.
> There is some debug check asserting the xarray agrees with
> the RB tree results.
>
> The second patch removes the zwap RB tree.
>
> I expect to merge the zswap rb tree spin lock with the xarray
> lock in the follow up changes.
>
> I can surely use some help in reviewing and testing.
>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
> Chris Li (2):
>       mm: zswap.c: add xarray tree to zswap

While I think it is pretty neat to keep the rbtree around to check if
the results agree during development stages, in the final version
please squash the patches. One patch is enough :)

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

