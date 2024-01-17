Return-Path: <linux-kernel+bounces-29325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C6830CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453471F26759
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6390C241E8;
	Wed, 17 Jan 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wK+MmexK"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FDC241E0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516682; cv=none; b=XIjr72HMssAnlMJ9SacF346gIUjMb+bLAGUqkYXOzs92sYv91hEreJC/rdgGkg6xLN5LIBciuvPeTCEY8gnAp3x62RCNUqYX1Qbo86wNIt3AEK0MMhay94QDrVA17tBrPIEYr2ox7H8QFQbp8+S/ONU9ustd9pfs+Ep00zo6W4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516682; c=relaxed/simple;
	bh=VogUs+O2o35Jw+1xeHOWy2fYvfe44E3rEqOp3jXLbb4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=SnJIEatu+YqZyYj9+uRZpGGPKxf2yGhGYOG2ytaTSZ2Ox79NfL9MEqPZoTJqpHT+OEubfjYPjYE4E+ZQTMgytr2wlPeH/GKVTEbw6Uw4cf8flbQg7mQQR5Xzr0Du8aj0MAHmeem2OICwM/eqHnFMFfiGyntYn73rxy4XWAPcK44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wK+MmexK; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-559cef15db5so2218535a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705516679; x=1706121479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZ9Ad+s6yBzRxVHJ5M4g9tE8/3/hZdNx+vJJrLg2cKg=;
        b=wK+MmexKS4/Qu7hz3S7Sf+FW8l8Ut0fSH3E9Jm3CP44J7d7GSxjXh4hy6QNHO+e5Dr
         stXd3pt5scPq8JYwPXiAHpo7TddBmC976db40gLx+qQ/tvVgdKFtpKsVtFg77Ly5Eq2J
         kt3LlVIPENzPLIxo3reB2sPA7Iqy92kK2rz5hnBfdxmZM4DLUWIDyVa4OHCTwtYM/1X2
         L9a30U82OQq7MeKAmaA0Vnqtve2IOV7uLpVjUbbAeCufwIF5GXcQu4aY/c+Y1qdaKF7v
         0oDoxWxR0L8bhabA1D+5N5kY9KiiGzVnCgoWwJilPjB30IToW4AiCslWoghoy9EcLTmo
         ww5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705516679; x=1706121479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZ9Ad+s6yBzRxVHJ5M4g9tE8/3/hZdNx+vJJrLg2cKg=;
        b=c18Zl35BGtCTp86ufSLpuHD9Cp55GSuxxbKn6WzecgVJ0OHVzg/n5hQ7gMDYLIWV6Q
         eojAMS2gTLzobcpA9PqSOA1kZz7En1m2n4UNWjLbiQ79U5bbcJqeu1xlQy9zfQi2x6PF
         RNk7M99kauWrk96HZbrNJ6/dKsb7tcC2NJs2Qm6ag5RG7FksS/PYhc/G+3FgRj0uW/+N
         ZsYuOqGc+osNJO0gAujr8aQgu2Vj+Q4Z1n07hSUd1nof4fuUAddBZ6wlRqozjEN9TCHF
         8R+61pyC3VAGJDbSGSVXWATWBqiXsRTZvqkCnVeTrsN2nBzJQczEPLhE3smHxuj6f99T
         cf0w==
X-Gm-Message-State: AOJu0Yya0WVIK6EXiChuZMs7R0DILVX7lzT7SOgKdX/C1OUrQe2hen5j
	fpPTBUfG4Nx1F+x/88bfhrbICeVF66n2nYG1NXc36z1Tv2NX438Det0hopxY3SL1M/wsZion5D5
	ptGFy+bUN0QYMoSe0k81SKH4Y9ece/NsgyKVt
X-Google-Smtp-Source: AGHT+IF73suJR78qAnn0Rg07XdqYVwiVVAHMHoi+OaeZ5QWjwxFYUUZ1aooiAz4S32/2Ug8YUcNTi/UVIEgmcjoSfIU=
X-Received: by 2002:a17:906:3c43:b0:a2d:bc66:6af9 with SMTP id
 i3-20020a1709063c4300b00a2dbc666af9mr1381942ejg.11.1705516679163; Wed, 17 Jan
 2024 10:37:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
In-Reply-To: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jan 2024 10:37:22 -0800
Message-ID: <CAJD7tkY7Xvjg37EEw2M=uRknphY0pf3ZVpyX2s2QyiJ=Axhihw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/zswap: optimize the scalability of zswap rb-tree
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, Chris Li <chriscli@google.com>, 
	Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 1:23=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> When testing the zswap performance by using kernel build -j32 in a tmpfs
> directory, I found the scalability of zswap rb-tree is not good, which
> is protected by the only spinlock. That would cause heavy lock contention
> if multiple tasks zswap_store/load concurrently.
>
> So a simple solution is to split the only one zswap rb-tree into multiple
> rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). This idea i=
s
> from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks=
").
>
> Although this method can't solve the spinlock contention completely, it
> can mitigate much of that contention. Below is the results of kernel buil=
d
> in tmpfs with zswap shrinker enabled:
>
>      linux-next  zswap-lock-optimize
> real 1m9.181s    1m3.820s
> user 17m44.036s  17m40.100s
> sys  7m37.297s   4m54.622s
>
> So there are clearly improvements. And it's complementary with the ongoin=
g
> zswap xarray conversion by Chris. Anyway, I think we can also merge this
> first, it's complementary IMHO. So I just refresh and resend this for
> further discussion.

The reason why I think we should wait for the xarray patch(es) is
there is a chance we may see less improvements from splitting the tree
if it was an xarray. If we merge this series first, there is no way to
know.

Chris, do you intend to send the xarray patch(es) anytime soon?

