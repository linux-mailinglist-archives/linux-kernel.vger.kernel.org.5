Return-Path: <linux-kernel+bounces-79831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2635862749
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D12B280DFB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD7E481A5;
	Sat, 24 Feb 2024 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xFrxbTiv"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5194CB36
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708805803; cv=none; b=GGOnUMC8svTgRJEZ0odT37eRtX8GYNwUNGVtUncKAZV8Z/ItcYiBlI/3gBc3XRvlrr394G/e+Pj7FHN9KhbFeDu7PHwyJ0fzgfKTRiPWIceQj1RZjbeyVUnEVzgkqb5rpEarO4FQ1fUSWa1pjnwqrzQ5BKwjaFzOwvUCwAgN+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708805803; c=relaxed/simple;
	bh=58rI6Lh5A3zmVIcZXAoo36bnf+BziOp//zU0TJUV+lo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UnIbHbCcYxGtnYHBEmGBAppI9yFT+hMRrnRNRjIBlmzLUE/eu2yn8GJCHkZyQ6B0GmehhWi3JaCCZTYz3u78msG96fxterk75zQNZpbXg89p/fJymP7JZYAAcLZMqIFEzfKNF3tSCShTxiEDuklJrYACs2Ov78PJOUF60fjN9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xFrxbTiv; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cfcf509fbdso823367a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 12:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708805800; x=1709410600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox3kbDdE+VVlFfRSV4KRbxjd8Vtf638HvV83l5cQ8zw=;
        b=xFrxbTivycoPaFT57zcw1LA+QUnoPtUv24FCLXEbGcJsEjK5mm3uh7wFZ9ZdchyYav
         Aai2J+HrSGvM9bvupIJEQ4xR/e9B9kYQfA9dInE0wx1/VUeDEqZfiXXVQzu0N41wAONh
         EudoanuqZo0759HiKiL4R6i9b6a9qo4NPybPKkC2qLA/+72acRN2OP9MCKSvFoZohjle
         DlunLEZCALes3dbFaDzfxo0imo5szoI+g9lZaFdi9sRWKCY8edBhrtGF79ez8PvgI0Bi
         MCVnDZb9p0fFxix5LOzmiIWeYssGQGHMw0bBm/evEFLGNmG/lk75OVUJTo2Gt9hMN0BY
         GH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708805800; x=1709410600;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox3kbDdE+VVlFfRSV4KRbxjd8Vtf638HvV83l5cQ8zw=;
        b=G7iSAh2p6Cs3AYv581fvzigG4J5iv9rSw/noncc1FVj87VpbkIyzO/d3LEvnSjpz7B
         xr1ignS/o1uzdsgZfft90uqTpVpARxwnRe4w1Ey5o8QgS4fyaDi/dYKNQMJnzTa9SdYF
         mPocG5Cq9aS3raUzlQuyB1dIFX63LSniPuCrivWXdjiAUKjHLo9nlV+fckEAuOOiiU2J
         u9I7D+s4DT0yQwkt+vA+SeF8C66NrLKWVulTUKE6vdMacGNIji1jf8G/WT8uvMcRj0zq
         E2vLflVSS3au3gXRP3I6oPWLDfVq8Ni6oR9AJ90irlAvX+McxqdD+3JRjRd8UMnvX+5f
         dhdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzomeGD3nXtUG8DKKhT+4i5KD9GxBwAxz43G055nsPxdERvaGylj2HiWNmEM8fVavuM+1gYB12r9KeI5Q+YP6rd07PN1KFvgAwpYQH
X-Gm-Message-State: AOJu0Yy312IQAJbIuQduV2AxQXL3XzlmgYpf0Ms1n1Q8ePqR4E7uBmOk
	M8uLGPMhRW0DQxqZCWAKiGgl7b5PorX+AnZF006WzwT/MDZhJ467hwpwlAi1qVsmsDJEtqZOq49
	M
X-Google-Smtp-Source: AGHT+IHAqqPQV7N8XB40psZopiUBgLNcHzyDcaUPaIezq1Iy+VTdgSYeS2XJGE1v3VAia/J5jEvp2w==
X-Received: by 2002:a17:90a:5e08:b0:299:6b94:4165 with SMTP id w8-20020a17090a5e0800b002996b944165mr2478612pjf.3.1708805800372;
        Sat, 24 Feb 2024 12:16:40 -0800 (PST)
Received: from [127.0.0.1] ([2600:380:7472:2249:6d10:d981:9c6f:5d24])
        by smtp.gmail.com with ESMTPSA id n15-20020a17090ade8f00b002995e9aca72sm1598967pjv.29.2024.02.24.12.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 12:16:39 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: chengming.zhou@linux.dev
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, vbabka@suse.cz, roman.gushchin@linux.dev, 
 Xiongwei.Song@windriver.com, Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240224134646.829105-1-chengming.zhou@linux.dev>
References: <20240224134646.829105-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH] bdev: remove SLAB_MEM_SPREAD flag usage
Message-Id: <170880579918.88310.13620256646819841520.b4-ty@kernel.dk>
Date: Sat, 24 Feb 2024 13:16:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sat, 24 Feb 2024 13:46:46 +0000, chengming.zhou@linux.dev wrote:
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> 

Applied, thanks!

[1/1] bdev: remove SLAB_MEM_SPREAD flag usage
      commit: 82c6515d8a970f471eeb8a5ceeaa04c3e5e1b45c

Best regards,
-- 
Jens Axboe




