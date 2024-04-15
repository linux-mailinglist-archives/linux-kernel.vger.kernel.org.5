Return-Path: <linux-kernel+bounces-144694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E05688A4950
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B5B1F23F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE652C694;
	Mon, 15 Apr 2024 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="d+fC/07i"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75A525774
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167198; cv=none; b=NcRouaKiwF7+LGrcNVU4D4n/kdbjceRkcCziNyudQ5Xm0G30AINWHlTvER8DGi6l0iA20Y2ifdr5/JuTMNqvsUZt92/zgqbDXi207BuwIQA+HvE1CQr75PkmucfnucZlbGeb/zY4FH2SdmCl8nYM+GjPgYQCKHvKfPUX8J5halU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167198; c=relaxed/simple;
	bh=1e7u3kV5t8LwM2pKr/aFtdJMPxDYedtqAYxa8UclZ+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUr0Ir3dFqdEjvthfiUj4S+97W4KXFuoJf69yxk1VE+RMct+xa//NbX4yyE6BlXaEOESxrWbBELamSkGYJdWRM+Y7wVo5VM+Kq8WvZt5w7xB/UFtnJ7qqJ49V84CFfjJOuo+PEkAjs0ZyASXYJ7nkXnJ3ln6QA1VVMXhcXKpHbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=d+fC/07i; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso3244182a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713167195; x=1713771995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+hd/NyG+znuJ0wUqzTHeG03XRCxC4P7dgrjDN13bJMs=;
        b=d+fC/07ijvp4tUT2ha2l79Xw1uVfVVfWaVqVyZb9E8K+Lb/93tSv3jfrHuxN9ykVbB
         pVO9REOTPYydCuiKmq5a6JZqGkwTVC9BkHuwA/R5fo6u38LHNDaGtTWhI2eqS9syk9wp
         4JKqMZxHoiBZEVM0CX4cd0utuerVVRe4Hhg3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713167195; x=1713771995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hd/NyG+znuJ0wUqzTHeG03XRCxC4P7dgrjDN13bJMs=;
        b=hoHmCsu6h9a3HraXY8l4pkgcfEpY3Zu6Png2Rk5nFhboATlu9+k5GxmyiPPIC8DqGn
         W982wSlzvTur6KIKHeCwIhC0AFhjUatK/R7vjCvzZG6iQWvJZSNzzOzogk4+q3CO/BKI
         DUvU+YQMt6j2XW4dxHdHHWQ/6Fp9aBQDI2geX7IX14OpnBjUi/IOQuThjGDpyhrfd5Cw
         5s9L15naHgAgFOZ5S7yn4C/1SnwuuaW53WsX/89H2So687iip83r2Ras4WxS1JTivESn
         3jo1UVyjpCeyxSoU6X+OB71T8nFL1c3kKB/nmmY8YsuV/IOs5O5DDZy4DtSk9j5Vc1QD
         4hXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvnknqEc/BG5iVUmGHrW1T9chl5qDCTrRrqkOP3xlJKwCP+rBptDuj+r2XaZL68yyZ783p3t5ux2Zk4SDHn4XqT9hUa5B0LeryJtvb
X-Gm-Message-State: AOJu0YwNUIdW1uWdUUQhpN8HhCIsFLQj5E4EjuRo37BR8W0Mii4CJO6V
	ZtMnFtSkSoIfPW8/7xl9OiJ+LMSALGcNkAZBTS+9Pd+46chUdhg0n6CrrzwqFaPN66ImWHaG3qM
	hz7FBkwD7hI489N/bcMzb3hvGbAscMRAE6WozBQFqot6h1keU
X-Google-Smtp-Source: AGHT+IH1sV3/Lh9lsnk6xorjzsimUfkG07CF39wxzp7zosnFjYQ1oyb3rqO8DAp/9chMJsDnb2vBAWH0bCweun+HFpU=
X-Received: by 2002:a17:907:944b:b0:a52:3525:33d5 with SMTP id
 dl11-20020a170907944b00b00a52352533d5mr6923543ejc.11.1713167194792; Mon, 15
 Apr 2024 00:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414003434.2659-1-danny@orbstack.dev>
In-Reply-To: <20240414003434.2659-1-danny@orbstack.dev>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 15 Apr 2024 09:46:23 +0200
Message-ID: <CAJfpegvhym5UUBpsn2CMZ_duv3Ook6JDHF=h5A7Hz4dY1jU9PQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix leaked ENOSYS error on first statx call
To: Danny Lin <danny@orbstack.dev>
Cc: stable@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Apr 2024 at 02:34, Danny Lin <danny@orbstack.dev> wrote:
>
> FUSE attempts to detect server support for statx by trying it once and
> setting no_statx=1 if it fails with ENOSYS, but consider the following
> scenario:
>
> - Userspace (e.g. sh) calls stat() on a file
>   * succeeds
> - Userspace (e.g. lsd) calls statx(BTIME) on the same file
>   - request_mask = STATX_BASIC_STATS | STATX_BTIME
>   - first pass: sync=true due to differing cache_mask
>   - statx fails and returns ENOSYS
>   - set no_statx and retry
>   - retry sets mask = STATX_BASIC_STATS
>   - now mask == cache_mask; sync=false (time_before: still valid)
>   - so we take the "else if (stat)" path
>   - "err" is still ENOSYS from the failed statx call
>
> Fix this by zeroing "err" before retrying the failed call.

Thanks, applied.

Miklos

