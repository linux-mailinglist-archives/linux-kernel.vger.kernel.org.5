Return-Path: <linux-kernel+bounces-50654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36964847C22
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2027288D84
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F9185923;
	Fri,  2 Feb 2024 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0QVDQ4N"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4095839FA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912260; cv=none; b=e0u7i1LzCrurjZ16X2x9r9b+1dvor2zPFDtzOYx7OWGhuV+qJuvYTTviDZ4S5SEKGxMZuwXiyCKRueAFLdwfkcfpFxxH9ZfZFDOwfMu/GQ70kSt0njeZjtOZsdNUm4whwyiMklpseES5ttlVN2WqteicINMMb3VqDu+CztwDsdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912260; c=relaxed/simple;
	bh=OmEmEuiItDGu8nZORsgc/8IQGeLxhZ0WgQHbE2mMm0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6LY69wNOSdS0MUy2TMlm4zVtiISR8SEup5ixfn/ylSUPD/UanADYqm8VM3F0IW/AvbBSiiKqDf5g67eOiqo0AxsG1Wvh0X/e+2BlKtO/ggBbItFnhdS/WGOaHD0dYrjI3E9PWxmLJxq8yHtsxg39p/PJtsepst3d+/KsNjfQT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I0QVDQ4N; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a37296534c5so69136766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 14:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706912257; x=1707517057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmEmEuiItDGu8nZORsgc/8IQGeLxhZ0WgQHbE2mMm0U=;
        b=I0QVDQ4N6tW1/MdoZlDw6MhYuTg6J7m0S4mHKDyl977CD6gZ+BZkmxwQPw1e2sPe8D
         j7captiGjz9WSsjZsn17KcFy9IVI8v3mI2c+GboBO1l/d4hZfZ4Wc9KSSbQPYR5ucxhM
         6xHH1D6YBR/p571pd9coXS0SiJrcnpxJXYsM6Yh1Zm56qj+Rk4vLbgjWxLdiHEg/K2ub
         hNs8AoROOsnVwvoC+EKrIJTGeKB9NFlp844PDKEjmO4vR7goVtj51kfmewHyetkZbJjh
         pGHzefPSpVuppnSHioV5IMNpoz7y8FpSKXzaXMjQFrSM9mxvDH2A057WsbBTwE9rXo5N
         VBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706912257; x=1707517057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmEmEuiItDGu8nZORsgc/8IQGeLxhZ0WgQHbE2mMm0U=;
        b=l+2h/N7noiXPfuwlhHQpkQPYPd/mQ1QFbUMtiUDxhDguTR/G1L+pJGpwHYwpCb2/sP
         +9eluvkfv2U+dbgpPL33PzHxHlGyUkTzR/KlSB/F1/gwt0yfTSPndQEPXD1aYjl/z9/e
         qOAkFhTl5ap/mNqYLu3Q83YTER8BGaqqSF9iLayXe7Ct9XkYB4pwkjaBMtDwBPpq+vZ+
         /qvEPp+A54rpw2WhQKrJMZeAhl5kDsAtYOkYAm983RXZ2ryOudLK+T24vybG0r5Lk4zJ
         NqaipYpPru+qdSX3nRuL+xRe25j04ZtWyAJjbmjyAZFUPaWgYloWa6Dz6Cgx2ArQyyQj
         i4Aw==
X-Gm-Message-State: AOJu0YyCs4HipP0i83Iw5MREC7H4IFTEgCA0GjRJqRHIkJg5bdHy7WCX
	apLX4e3rt6B+GzlY0SvH0PWi5VBLt47Xb812ZUs1sSzcX9eHZPmuZGBH941vD+4leAYaXLkqtw0
	JIpQs8VClkAV1JZz2mIQK6SJ0Xt5yJndcsVMF
X-Google-Smtp-Source: AGHT+IHuvbdxW0zAoKnULFmiDvyu5U4kV1ShscDlooT/WDYlEtrlBifsJY9Ywptb+Nc17yR5AkZm4GMeAlGgTpQWL28=
X-Received: by 2002:a17:906:e0b:b0:a36:73c0:d204 with SMTP id
 l11-20020a1709060e0b00b00a3673c0d204mr4889840eji.50.1706912256992; Fri, 02
 Feb 2024 14:17:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-4-56ed496b6e55@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-4-56ed496b6e55@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 2 Feb 2024 14:17:00 -0800
Message-ID: <CAJD7tkZ-h4Hu0Lq8YBx_0jpoG=d9s8M_V0DUnk930o5iCMbbJg@mail.gmail.com>
Subject: Re: [PATCH 4/6] mm/zswap: remove duplicate_entry debug value
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:50=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> cat /sys/kernel/debug/zswap/duplicate_entry
> 2086447
>
> When testing, the duplicate_entry value is very high, but no warning
> message in the kernel log. From the comment of duplicate_entry
> "Duplicate store was encountered (rare)", it seems something goes wrong.
>
> Actually it's incremented in the beginning of zswap_store(), which found
> its zswap entry has already on the tree. And this is a normal case,
> since the folio could leave zswap entry on the tree after swapin,
> later it's dirtied and swapout/zswap_store again, found its original
> zswap entry. (Maybe we can reuse it instead of invalidating it?)
>
> So duplicate_entry should be only incremented in the real bug case,
> which already have "WARN_ON(1)", it looks redundant to count bug case,
> so this patch just remove it.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

