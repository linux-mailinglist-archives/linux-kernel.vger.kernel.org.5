Return-Path: <linux-kernel+bounces-35605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB8C8393E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F9028439D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3B760ED7;
	Tue, 23 Jan 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="riQ4Ag1o"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E75260B94
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025425; cv=none; b=seJOFulYWKH2lDlHhgnu9XH+Eq0FEYVIe51dUvOJS9X/n//RyNGS5brNChcbjM7cNAs5c9RlM4wAjcjb41BHsPKXkbS+OUACqwiPpoh5YWG82MurxCetAdHBJmXNIVCCqXN2RmIEBvUxrnY/6Vt1HoeAv/9QMaJFwAwaT7HXzkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025425; c=relaxed/simple;
	bh=AaP24geF8IGRtSt63M/PXToa50MRD8//aI+xG8otgCI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SOxa95OZ1mramV1ttSc8U3bCt1v+LA5WHdFuQP6AdrZUeMjnR4F67sXcVJyHR6gUgahlgXO8d+XRjCeipbgoLrvLDXUOKwJLJ3/si49vDlVSwNf7UOzHP6yrOOcbdQWrqv1AiZIcQTl04pVChVPQ7vlp/ExGghcdTdpA+fqM1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=riQ4Ag1o; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so60106039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706025422; x=1706630222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llje3QQCcfIgLmjM+yLro18lUt9cBa2L6SktSvFiZZE=;
        b=riQ4Ag1oWtuepQpBUmQdkqOfJ9kIYFT7/tXbyijkBGIbCWPrDRA7K2OLtVNM0kxdiF
         QBDSpe6z2MS3mor2EgoTZPlUfypphYqd4XUL7j48dNnXN5ZsFW86JXzyJQiASAGjhJTV
         KgXQLmPUHGK/y6qlmjvqyImWf8HQ+S8V+u76J2jOtyrZV+3p8kAhCQetuoGivWOyL4b4
         vjg+aojAav4xvEFzHyaACIIg1NS/eU3Pnw9Xr/as9mTPO0kI5HE3X+qPdyZES6WRxn4Z
         SttdV85vjfsp6BWHzdIunc4Fh+pkQHNzB3RWfd01mldcg5AH/B/GRzxR2aNyEP/T372u
         bydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025422; x=1706630222;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llje3QQCcfIgLmjM+yLro18lUt9cBa2L6SktSvFiZZE=;
        b=BkCYD4vpqbFOT9Fe6EP8jl4ZgrR3Lo8qjNVsq9dSJ88H6bgN9NsAYUjRpecuSDe2rf
         +8NqbLyhM337yeReuEueBsqNDjY2mUHbTbKER94nVlWKIdgC+Yg8lf48popVjbMTxUKz
         CRt6yEfBRkYKlcuieX4oHjq1A51/JNiH2OoKwr2BrFdccUvUbo8iIQGuKlOV2B2rckY+
         RJfuROHxqqWk5NBuD3kdZbLxjJxAB1I/j+GX3gY1EYIdutg+zE2f0xdIC5fsuLyY3M/u
         OcVsY/a9OYV3i+WyP4cf+zCsZ8e/ts00jRJHbwXRX73J8jiD9rzzFFedawfPcxrQQ5Y/
         IL/A==
X-Gm-Message-State: AOJu0YzOiqsGuhPIuOQLEwhW/k9qnDZX9+WZRh/l+5l5ArCzpqV9K79J
	I16mWKE31QX1/78pFnrU+Tk6nD8DMxafOknklsRWBpjWkr3DqzoZdP2j8Jzsulw=
X-Google-Smtp-Source: AGHT+IHnzXr+yl4mKBgGkEQDebXz6TP1F2cEuykTezsEAK2jt26K38kM3gc4dxu/46xr6nynPv+mmg==
X-Received: by 2002:a05:6e02:1a25:b0:35f:b16d:cd64 with SMTP id g5-20020a056e021a2500b0035fb16dcd64mr10136211ile.0.1706025422600;
        Tue, 23 Jan 2024 07:57:02 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n6-20020a056e0208e600b0036193f4e5c4sm4680769ilt.25.2024.01.23.07.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:57:01 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Christian A. Ehrhardt" <lk@c--e.de>
Cc: syzbot+a532b03fdfee2c137666@syzkaller.appspotmail.com, 
 syzbot+63dec323ac56c28e644f@syzkaller.appspotmail.com, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>
In-Reply-To: <20240121202634.275068-1-lk@c--e.de>
References: <20240121202634.275068-1-lk@c--e.de>
Subject: Re: [PATCH] block: Fix WARNING in _copy_from_iter
Message-Id: <170602542154.1916499.2341274393906762651.b4-ty@kernel.dk>
Date: Tue, 23 Jan 2024 08:57:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sun, 21 Jan 2024 21:26:34 +0100, Christian A. Ehrhardt wrote:
> Syzkaller reports a warning in _copy_from_iter because an
> iov_iter is supposedly used in the wrong direction. The reason
> is that syzcaller managed to generate a request with
> a transfer direction of SG_DXFER_TO_FROM_DEV. This instructs
> the kernel to copy user buffers into the kernel, read into
> the copied buffers and then copy the data back to user space.
> 
> [...]

Applied, thanks!

[1/1] block: Fix WARNING in _copy_from_iter
      commit: 13f3956eb5681a4045a8dfdef48df5dc4d9f58a6

Best regards,
-- 
Jens Axboe




