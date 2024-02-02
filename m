Return-Path: <linux-kernel+bounces-50661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED2C847C3B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF621F2A23D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F578062D;
	Fri,  2 Feb 2024 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pr5Es3o+"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBB315E5C0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912728; cv=none; b=bfNocw1EyZupJZQAXxF7dvkH50VYyZd4QqhmShgsuDPBy+hfv8VQS58KYyTUq+Qtlb4wSuRzlwPukTFWlb34GvonT2YOPlf/VcfD4TcpRCM1EAYQ/0+ulklVxB81BPUAiGME1E+Z+sN+AJawSbKkhEY9DFvlh4ThRW7JeVARlUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912728; c=relaxed/simple;
	bh=J/sn53AuQa/t9OBf4N+SZyv90hNss6ZsfiMdF+isiJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGAw1YiZmWje48+8mc7dOv8RqyBY+LtQ7dxdDvxIb9rFJyUmpWRGbaNwFmqgFqSr+LdURPueatF8J9t9iv874XfOfA8iNdbPXXQbymtlHMN7+VF6eHK48pfGRw9U5tD9ai3+p5Y9fgZZBC0amc6IEfoNRjDCbnYPWBuiUg9rxdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pr5Es3o+; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c029beb8efso30214439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 14:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706912725; x=1707517525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/sn53AuQa/t9OBf4N+SZyv90hNss6ZsfiMdF+isiJs=;
        b=Pr5Es3o+azN5JP7RVmjVllYuSWRw0UmneRO5PY+eMFzQqA1+7JWgbDh5qgJaQPNyaU
         KWPGmLYBSqE/FUbisMNnWKoHEWmJGcBnmyo6785jrE1yC60JWY6Uh2rOvQNSOLTgwUjV
         Udchf4/NIvKRZ3JYKcIBe1+xgCIYdnHnIcHitAuHRnIy6NHG12FRob08apKCybMeEZnl
         QCZO8urrO4k2S7t6CktPpuTLSCC0cNzLVWRLTAoKE5hhDUhxHi95af7NZXmFZGQ7DuWy
         RjKP04f8KB4dpXa+FZlB3db5zooPLbxWrzMa4KsOauch+tG/92+zXSD+PEfPPNjYAog+
         kiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706912725; x=1707517525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/sn53AuQa/t9OBf4N+SZyv90hNss6ZsfiMdF+isiJs=;
        b=MVHXb8mOwR8ZBqVedb57wypdi5yJkzVuZFb5pqin0MzOonTXUm8MNgK04GbQpFCXLl
         RBat0r+G+bXAfNn1z9tXs7lk2SUtgnx9jrcjCb4Zqiy56wqORnhYAhekPaujPz+ZRYOY
         cD698MVxy/HgKH5u2+44OJrDIVAFoqqdjktkI7XqyaOLoIrLxy1mMCS0jpjZrDu2qcht
         bZaXM8DboGVDDmBqD/ubaRvLSkDs2xSh6zcVlj6g2nH7i/ASQfnV4Q9WaE3jHKpvV7Cc
         dU3qaVZMRkaR9YrfRZORO/Z7XqUZdapLcyttFE7mJwfTX+HcmKid8l5BWCD4ZdpE6fVY
         jngw==
X-Gm-Message-State: AOJu0YzV7ceS/MvO5gt60ghot/WW/FmMxEjIoZa3JvD05yNtdceT1lRg
	Vuli0uZ/Gq2uG1n6iu/N+PAkBNSJdqmplQbsX/Bem+M3CLfCPH0ox4bWlSy6m+d7YQXdF18SF3B
	KI78eG9KwXHhyTRp0wfzzA+XJQqc=
X-Google-Smtp-Source: AGHT+IGIQEcSnN4WOsPE8VfG47SxfHEFhIbVVP3MmCPSZdm3OL/yV8NxwTHpQ/dbm9kyyj8EnSLmGgnSedjEW9GHo4Q=
X-Received: by 2002:a05:6602:2d8c:b0:7bf:e164:e4f1 with SMTP id
 k12-20020a0566022d8c00b007bfe164e4f1mr376788iow.2.1706912725540; Fri, 02 Feb
 2024 14:25:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-1-56ed496b6e55@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-1-56ed496b6e55@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 2 Feb 2024 14:25:14 -0800
Message-ID: <CAKEwX=O4v2nSUCZmwZrapvxyJvbvrXq0YNVvF_HsFUi-ZYxHyA@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm/zswap: add more comments in shrink_memcg_cb()
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:50=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Add more comments in shrink_memcg_cb() to describe the deref dance
> which is implemented to fix race problem between lru writeback and
> swapoff, and the reason why we rotate the entry at the beginning.
>
> Also fix the stale comments in zswap_writeback_entry(), and add
> more comments to state that we only deref the tree after we get
> the swapcache reference.
>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

