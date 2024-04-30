Return-Path: <linux-kernel+bounces-164514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2BA8B7E77
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FE01F232E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E163B1802A0;
	Tue, 30 Apr 2024 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mVVy+BxT"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2B176FD8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498187; cv=none; b=BAMa7JFAQxFEugZYNIdpmc2E6ZQkf6+xAVmGfbNAljBRdHkdspQZ2GNtVJ1dyfttBtTxJGbrBIc0BbHWY+EstLppRh8VBO9MM5Eo1HTSkqMAgm24Ul1PA169/Adu4T6IcLAv8KJI5W/2vfnMI+WBw0Vbhb7/DlQ8UJykASZeaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498187; c=relaxed/simple;
	bh=waRJmlXpww4gRy2/4m/erFV1EQJ2qoky0UQIAVqbfJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfGb2Tq6Et7qYqb0zd5OeGlVC1WnWLeEmWGTe4cCnO7VIxKBxUXOMGQO/M5bBnE3uf4yayx6BjOre3CahEPXPY7XZ99vIIwzAbFdMfRuogBFW0aClKYOkRS/9Bxwqu9v9fUGa2wgbvTp7AD653cXAwHD2N2nGBs4lWa2WbiZZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVVy+BxT; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de462979e00so6710687276.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714498184; x=1715102984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waRJmlXpww4gRy2/4m/erFV1EQJ2qoky0UQIAVqbfJQ=;
        b=mVVy+BxTb1Fx6UjV5GADslbcGJSktGE+TGJY2JFGr+aGp2qYJ8z+QHECT89W1nI2FS
         H39vPHzp1bDHXs8HY+qhWiprZGG8G5h46o3PGT6aK0z1h7RmNw2ncvaqetTGgFrkMeK6
         9m0Wq4v3B5g5GltEQSlxb1onpABcZiQm/7MjES5kjV1z2rlXJASDUdRc6QhyMJKFAau/
         J+ycej30U9aBE1hy5+xbkfinUadOZnLrkasyXbCKpOGBeXUYVHN1nGM+nVAJA47wJ24S
         EMwEosN93oiMGdxonuhhViSbpKoaOL8ZBvSi288yRERvb0ctl2iXzr+TCL+wH7relStk
         s6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498184; x=1715102984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waRJmlXpww4gRy2/4m/erFV1EQJ2qoky0UQIAVqbfJQ=;
        b=B9VwT+0FgAYgwBz8MKBHSLXMQVXpCEg6WY0G1LYxOygSF7kDV1mQxXAe5FSQ7I/3SA
         cxg2jwaLzZB1Lz4jiJYaM/Kn07Zy5L/jHpEUYO28rEseXigMPRsR+lqFHlPtkDEe+68r
         bPg56tMfWf8THfg37y08v7VjxovUBgMHNFFBjMjE+oOERrBetPK9y6Oi6nCjrNhht0CE
         HwzPuN+3lIFUXQujhrXBg54Fxuy2nqDBsTGqBobfqIa2Kl8+gyqOVfBX4Wh7ks8LIt85
         vgCsqi0hLtK8ktvPYnnLxldaYo7xxOakkLC3OnhjsRpAbRl+6+fNSl3f7uPCtd5q2cNy
         IrOA==
X-Forwarded-Encrypted: i=1; AJvYcCV57zewi69SnJLj10tVr7Tshn+XsFDXpSmnxkNM5KLiLC6jQR9WTcdiRGaM7GM6yDN0InWxjuqQw49DygZnJNgIsGnmss9fPN1yuRny
X-Gm-Message-State: AOJu0YxuDefdkxVbqekjqI1nHLBwBBLOpE8orlovk2YVZfm6BxGAFBz5
	V1+AuQNER6JbZwZEy2JaazaaVwsPDiANqMJPzLUUbEfIHXjQCeMVuZK9nk4P9UefDKgP9wmI4ax
	pt7QlanlL7Um/YSU9XRsj2OgokD0nvjnk+F5q
X-Google-Smtp-Source: AGHT+IFEbKssEBrFh29DeidkPGkq3blyW/LtaVXFVB5LQXZ1wDrLZHMYyQYErwfKtG6uxuk7CbiF2YOEw3kiNQUO0Gg=
X-Received: by 2002:a05:6902:52c:b0:dcd:4d96:741f with SMTP id
 y12-20020a056902052c00b00dcd4d96741fmr262733ybs.10.1714498184458; Tue, 30 Apr
 2024 10:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430060612.2171650-1-shakeel.butt@linux.dev>
 <20240430060612.2171650-2-shakeel.butt@linux.dev> <CAJD7tkYZZZ2raUyJKkLWVYvwb0G7Zi5Xz1t=BT7ih9wpyrThbw@mail.gmail.com>
In-Reply-To: <CAJD7tkYZZZ2raUyJKkLWVYvwb0G7Zi5Xz1t=BT7ih9wpyrThbw@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 30 Apr 2024 10:29:31 -0700
Message-ID: <CABdmKX2dF2jQLBeU8n5FYU8U88QUGSAk2jQviX6H3Y61rHE9BQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] memcg: reduce memory size of mem_cgroup_events_index
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 1:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Apr 29, 2024 at 11:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linux=
dev> wrote:
> >
> > mem_cgroup_events_index is a translation table to get the right index o=
f
> > the memcg relevant entry for the general vm_event_item. At the moment,
> > it is defined as integer array. However on a typical system the max
> > entry of vm_event_item (NR_VM_EVENT_ITEMS) is 113, so we don't need to
> > use int as storage type of the array. For now just use int8_t as type
> > and add a BUILD_BUG_ON() and will switch to short once NR_VM_EVENT_ITEM=
S
> > touches 127.
> >
> > Another benefit of this change is that the translation table fits in 2
> > cachelines while previously it would require 8 cachelines (assuming 64
> > bytes cachesline).
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>
Reviewed-by: T.J. Mercier <tjmercier@google.com>

