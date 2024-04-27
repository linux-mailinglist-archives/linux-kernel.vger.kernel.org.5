Return-Path: <linux-kernel+bounces-160843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918708B4373
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 03:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1680E282D82
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946AB2E852;
	Sat, 27 Apr 2024 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8T9ZS3C"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D363A9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714181069; cv=none; b=qnwLAZdBMNm11A11rKEYDFa5SkDUF8hdFPnx5mkeTpI/5GENTN3FVAYU+wtaeuhrey1o07EO99uBIsHS+0JbU56WViZh92hQWolQWA+qMWwYax4vrotvH33bs741i9tT7OI/wzSgPT1tBtMSJYv/KXTE+qU4wCyFkdCDq21Ny04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714181069; c=relaxed/simple;
	bh=QPOrYGhIxzwlhZ4E7M894ekrxNFr3zBjHzoW3zvscoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+ZQxHW8z2+OUGUQePRPEb0HQKuu5DVfkToxVIH+P/TBWPKuHVecQCjPbh/Z/pY84/CpBTmMKSPHYIleK6Rgcqm5zRzxjT5GRI79yqU6GRRkEvcB6AdfCjMsipXBRPINsiEYn3YS+tCVHabkwYS+cSKrHKREuuEuk6uXI5LDkAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8T9ZS3C; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a55bf737cecso331444166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 18:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714181067; x=1714785867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPOrYGhIxzwlhZ4E7M894ekrxNFr3zBjHzoW3zvscoY=;
        b=C8T9ZS3Ct/Hd4xlQZCWUeD7F8vfukZs/O+31jJl+3WY66d3BpI0N+1roqnqYoPtFHG
         oYz/ViScrl+U5SqBVpZjr7SKgnYRrL254tVuw9cJUYnBCIYO7ikWwP7Cby8kmXoLxp7F
         320lgec1a2SNfQA6BWacLWhaKyAxcsCPMBeEj+opiQBEKy3aIALE8nEykWTzwchAH+KU
         7LWfV5+ZB416sDxaqoqD2w+KKPudHWxaFpnPUkZtIASu19GZJmCka39Dbo5mfkDQ8cuk
         Olo/nsuzu7tSiMoTiNGTD2Bj5i3Fp0U+6K6Iu8WWesfaSLE2UlzDNm9HhODkb752FFEQ
         Qftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714181067; x=1714785867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPOrYGhIxzwlhZ4E7M894ekrxNFr3zBjHzoW3zvscoY=;
        b=PM1QqC5t1EiWYixZinTOTyxd37tPoJH7Ihl9zR4yOklboCrEAxQTZ8yq3igftP5zGF
         m1M+lp6y+k7zk9+CNMl4EvulJheE2GLXxmqwrIMY6+DGfOg+FzTtsjtooJoPK4DFnEaX
         BWe/qWYCIwvQLX7HOuFcDgGRZxGE9gjFYH5EVc1YM5xlmR0uic3AXHS9FhcGcsuQwxRU
         hTTGXRe1/O74jyBy+RATsNDGlKcb2qkQ9wj7UzGifAR4px30+CE0iT7Sp+09eORIwRX3
         ovVwBeKga7eHuVOYY9RGiIpaT4goJxD6+VDGNcrgoylxm7m7LWswh0v95WdTOW2j+0iI
         v5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK02Bmi0Ai4nrYzP+gXzpxpp5DLw0/OOsSi05mBNjJVN0uAvMgeZsPHIgGOQeU1+K/C4KTzCwTcT7ytwJVFXQjcLVBYVhNRHG9etpL
X-Gm-Message-State: AOJu0Yx658i9lXPhjv5RgXvMWaMDYzJ0cH6ndY+fTx1yDGrIZk3wy9kB
	aCF2mdDIpcCH2FAX4SZ8hCi3RKLBgwBnOJ2ffPHrieOmYWZ5H7jKIODKJgvEwsSItzt8ID9B1BG
	n+JfAGOA8VSVz813koVJLXUOqmoZXFVFE6r9K
X-Google-Smtp-Source: AGHT+IHMHh3vDt9Vf++CgWt0Tj2F+IjHbZYoX2LXqXK7v5vHl6VOAm9u1APSfc5GnEQiuUn2FQVDtaZWsgiqfa6p218=
X-Received: by 2002:a17:906:ff52:b0:a58:8864:b3e9 with SMTP id
 zo18-20020a170906ff5200b00a588864b3e9mr2896185ejb.30.1714181066484; Fri, 26
 Apr 2024 18:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427003733.3898961-1-shakeel.butt@linux.dev> <20240427003733.3898961-3-shakeel.butt@linux.dev>
In-Reply-To: <20240427003733.3898961-3-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 26 Apr 2024 18:23:50 -0700
Message-ID: <CAJD7tkYULhoexWe-wCbOJ9uH7ES5bksCNp7G2-YGV6c03-0_JQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] memcg: dynamically allocate lruvec_stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:37=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> To decouple the dependency of lruvec_stats on NR_VM_NODE_STAT_ITEMS, we
> need to dynamically allocate lruvec_stats in the mem_cgroup_per_node
> structure. Also move the definition of lruvec_stats_percpu and
> lruvec_stats and related functions to the memcontrol.c to facilitate
> later patches. No functional changes in the patch.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

