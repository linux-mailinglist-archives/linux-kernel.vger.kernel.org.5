Return-Path: <linux-kernel+bounces-164519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE508B7E94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090431C223B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD0F1802BE;
	Tue, 30 Apr 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GiO893wX"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1873817BB20
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498282; cv=none; b=Xa4ki2B5Yc3uS4/6uGxz6+i3igKdzJLC2YnRQrUbMlOHFU7J8k4FPzBC6rCuRftUxkQc/8EMfGLTCDC0nEugvL+ChZdoBqsFpIgr/qjZyhNZR8txUjW8N+f0cNk//wTw8EiGpN7UCupCptpc1sGd/Mz0mAirU6XXFVqXwa3cN7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498282; c=relaxed/simple;
	bh=qQKyT5QD+ByzejxspNegdQ7GnL9z6+nOWConQ9wVkS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJURlq7hUW1h0/6A/8WVUl2WHMl0j44ymCkkpdiapwCnIvP6tI1GVEVPl4ds38gvQP4NiStWl6Q5yPlkqUn8pPk5kwY4bqbyB9KVLxf8MQz9tzH0Rlbd4u9MhgKoYuOUSf70mAm1zpkmm6CFs2Eh2B/dOS3V9nHcsL7/ZITorgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GiO893wX; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de59daab3f3so5453989276.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714498280; x=1715103080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JwxAddIORoDjZb7vE3h0utwtl3KaibdVVn/7aWOhkk=;
        b=GiO893wXFnZeq7XEKFst5y+s6IyFaAvp909oBOutSzj4XleDibFBzEp7AAFa4bWX77
         l46NC3cK8tQqlElG3LeWGaRfSi+Bh93YtNC1GP9v1mTpda8o/SqvF8cy0s7CFej8r7TX
         KmpDLibm9jg/fI0B76LxYX0xS2QWH8EoeWMb/TTTfPQaSId7+RGHf5dvrrvaukj3PL0k
         7ZFuUuU6F6jIasHo6P+PbRE0dFUU06p/dV4h4jjI/Crg7lTKHR8Vu8aVvhRvdRajMsuT
         Ph5qumVCxrCF2K8kvBsuwk/if/dxbAvrkA40URjVhdEXL5A139NQDpbhlx41NLt7ODCa
         M/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498280; x=1715103080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JwxAddIORoDjZb7vE3h0utwtl3KaibdVVn/7aWOhkk=;
        b=QlwZnpLSGc3Btkcl3BGEoR5dy4gs0xah6udMtH7/XYdFanAL4uLOrEJJfG7+oPDGQB
         C86VGB8F/Mi3wlL/C44vlEjeQxBJoOeDOxe3JAZbYa94GRbtvHNM8TlCSsdkQtWMUsm6
         1XjThP+rmBHPRrSLeiKxl382sKRTW+4/qBFKEPVEC292Xwgtu62a7qWK5FRYbok5ZG6i
         gM8IMMGuQN2peaWXCdnY05aBxx8GTD7Ne/DUn3C8vbUCryz7FYDb67IuJw1lyT5H3Mi3
         dn1fN11evFIrmPUyfqrk7UmchUrlULdbYjSwCFWqoZkObTjXbIsKbmF+TF2BAJQAuQh0
         ghHg==
X-Forwarded-Encrypted: i=1; AJvYcCWFzC7Z9gr2cf7EuaRA8F5AX1gWwsGYnpU9LkV2SwWB1ESuusONSV5MqT2eri2tR9fCx3jhMOdXDHTQVJu79cmts4mYL42XoaJ6I+vB
X-Gm-Message-State: AOJu0YwzGCwJ75o6Kve8kcBeYdrCLA9TkNXTYZKnkJW+MnRbwpOarN2I
	Dzuu2Q1Opb2Kp3/z7SXYO4tkHcG+KuVY2lm5nhH8ZoP6hdLOYcxhIUOdhA3YLsva/R3nRXzjtKh
	dx22ipNT5n3oSU5XH0YKEBseKiNgObaPbt3Zp
X-Google-Smtp-Source: AGHT+IH2ACVPK5qhzjkvkzWZ+/A/LHh7HwsvSaGNnO5heFlYlzrgW2SD/J0T7ULwesjC0XZnvnmzP0ce7Okt0fZZF+I=
X-Received: by 2002:a05:6902:2491:b0:de6:d7f:2a37 with SMTP id
 ds17-20020a056902249100b00de60d7f2a37mr262373ybb.6.1714498279865; Tue, 30 Apr
 2024 10:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430060612.2171650-1-shakeel.butt@linux.dev> <20240430060612.2171650-6-shakeel.butt@linux.dev>
In-Reply-To: <20240430060612.2171650-6-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 30 Apr 2024 10:31:07 -0700
Message-ID: <CABdmKX2wN1+jftf6FbZUvN+wqA6_hVMRk8Va8TDoExjU1r2q9g@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] memcg: cleanup __mod_memcg_lruvec_state
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> There are no memcg specific stats for NR_SHMEM_PMDMAPPED and
> NR_FILE_PMDMAPPED. Let's remove them.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Reviewed-by: T.J. Mercier <tjmercier@google.com>


> ---
> Changes since v2:
> - N/A
>
>  mm/memcontrol.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f424c5b2ba9b..df94abc0088f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1008,8 +1008,6 @@ static void __mod_memcg_lruvec_state(struct lruvec =
*lruvec,
>                 case NR_ANON_MAPPED:
>                 case NR_FILE_MAPPED:
>                 case NR_ANON_THPS:
> -               case NR_SHMEM_PMDMAPPED:
> -               case NR_FILE_PMDMAPPED:
>                         if (WARN_ON_ONCE(!in_task()))
>                                 pr_warn("stat item index: %d\n", idx);
>                         break;
> --
> 2.43.0
>

