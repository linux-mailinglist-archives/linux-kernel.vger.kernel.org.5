Return-Path: <linux-kernel+bounces-66175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DAB855821
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB73F1F23099
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42089818;
	Thu, 15 Feb 2024 00:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iI5dPF/H"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CCC391
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955687; cv=none; b=L2fgyrN8gdV0Yk1yUoRm0lNOHefGAc03Pgyokh1XON18HboCV59kRM4MbtipE7HkZq/9MMUrbJYXcupYSneu3d7LkuYtsP4FCTh/L/pNfDTl+lJjzrNjlZfKBT4E3H1byro1anVuqGBMyCZJSfHasphZF1YUxe0vn2m3TMGEGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955687; c=relaxed/simple;
	bh=MXm7+NJ1npnE1n0F4jgnhA9YQZg7N1sx7Rye2amVgf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7G2TTmBBm9w8sYYydT8wOVmB8gwj9uIT5I0wBwcwmdqsQXpY/NlAdm+jQj3Jn9m75ygylPgm4xMGQsUmKiq/u3G1v66j/SBM3rhTpeanTpPYEKXpSqqvFcyz2ZU4HJIDtNJdJUIlfPeRbJoQxQC5apAnWQrTx0uFETrY0GK5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iI5dPF/H; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c0471954faso247679b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707955684; x=1708560484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xk1V2GeLZIB0eK1Atb00UHsPHWh3K6myT0Efv9rtx7M=;
        b=iI5dPF/HSjGS+h0IkgezGQjrujzUJ+FIXkwRZY+4trK7l2UqAWEnkNdgjSnKQivrah
         AYA/1BIiysMZhUzX4uLmc2WL9VOSJiA/1qpFFFZ40YStdnYq7gb3sYfw1VlQJrq6E/Vo
         Bpmwb9TiW6gYDCgSZ/wwowYHEAbooHr1ArGVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707955684; x=1708560484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xk1V2GeLZIB0eK1Atb00UHsPHWh3K6myT0Efv9rtx7M=;
        b=E38ci8QY7BH722OFdhEuDa50rUcuPfV9RC/Y6WZQY4wvg3rAc0GZSxfZ6U8vUn87ne
         6YA2g/8j7xfAbaftmPGiyP3E6AcTR0IUvftOAUNoVL3SL2XuYfwIBUq0POwhMg60chCQ
         Jpy70gLtT0KoQQF+3nebzOMWbWBct7UToLM0VSApIiPPpNom72W2vpB0w5/AZ43lihAk
         sUdZVzM3vhQeNH6gmPkuJgg/TLP+mUcil+fs9/N9f+11XG6xoaYJVT3HCMyhXJhEvxro
         QipzyCv86py9praG0OgHvn4F/EETKsrIWo1ZMyF8emoRcqxDCAgUSaWPnhmNrfi5fj3A
         F+QQ==
X-Gm-Message-State: AOJu0Yz+dgZqmm3aLajpw1Buwu8IPLkfITvlTgFs3QrZ6JUzZ4TAcy4C
	TUmHZ6G50+5wNEOe/gZPuV9NCKdnoo0IM+xtYrAeBT0FTSIbjOSxuod01S5EHvnvs90CAD7x78P
	Vyw==
X-Google-Smtp-Source: AGHT+IFEv5AreGUl0qs62KnOYzdEhLJrc3sNJRq5ufUSWwoxqO1SZ1oENLinLTCH2NnrkBM8Gp/2pQ==
X-Received: by 2002:a05:6808:2182:b0:3c1:3661:d37 with SMTP id be2-20020a056808218200b003c136610d37mr399215oib.38.1707955684095;
        Wed, 14 Feb 2024 16:08:04 -0800 (PST)
Received: from kramasub2.cros.corp.google.com ([100.107.108.189])
        by smtp.gmail.com with ESMTPSA id r6-20020ac85206000000b0042c71ca69b4sm54981qtn.11.2024.02.14.16.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 16:08:03 -0800 (PST)
From: Karthikeyan Ramasubramanian <kramasub@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>
Cc: Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	Sven van Ashbrook <svenva@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	stable@vger.kernel.org,
	Curtis Malainey <cujomalainey@chromium.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Subject: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case
Date: Wed, 14 Feb 2024 17:07:25 -0700
Message-ID: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before 9d8e536 ("ALSA: memalloc: Try dma_alloc_noncontiguous() at first")
the alsa non-contiguous allocator always called the alsa fallback
allocator in the non-iommu case. This allocated non-contig memory
consisting of progressively smaller contiguous chunks. Allocation was
fast due to the OR-ing in of __GFP_NORETRY.

After 9d8e536 ("ALSA: memalloc: Try dma_alloc_noncontiguous() at first")
the code tries the dma non-contig allocator first, then falls back to
the alsa fallback allocator. In the non-iommu case, the former supports
only a single contiguous chunk.

We have observed experimentally that under heavy memory fragmentation,
allocating a large-ish contiguous chunk with __GFP_RETRY_MAYFAIL
triggers an indefinite hang in the dma non-contig allocator. This has
high-impact, as an occurrence will trigger a device reboot, resulting in
loss of user state.

Fix the non-iommu path by letting dma_alloc_noncontiguous() fail quickly
so it does not get stuck looking for that elusive large contiguous chunk,
in which case we will fall back to the alsa fallback allocator.

Note that the iommu dma non-contiguous allocator is not affected. While
assembling an array of pages, it tries consecutively smaller contiguous
allocations, and lets higher-order chunk allocations fail quickly.

Suggested-by: Sven van Ashbrook <svenva@chromium.org>
Suggested-by: Brian Geffon <bgeffon@google.com>
Fixes: 9d8e536d36e7 ("ALSA: memalloc: Try dma_alloc_noncontiguous() at first")
Cc: stable@vger.kernel.org
Cc: Sven van Ashbrook <svenva@chromium.org>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Curtis Malainey <cujomalainey@chromium.org>
Signed-off-by: Karthikeyan Ramasubramanian <kramasub@chromium.org>
---

 sound/core/memalloc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index f901504b5afc1..5f6526a0d731c 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -540,13 +540,18 @@ static void *snd_dma_noncontig_alloc(struct snd_dma_buffer *dmab, size_t size)
 {
 	struct sg_table *sgt;
 	void *p;
+	gfp_t gfp_flags = DEFAULT_GFP;
 
 #ifdef CONFIG_SND_DMA_SGBUF
 	if (cpu_feature_enabled(X86_FEATURE_XENPV))
 		return snd_dma_sg_fallback_alloc(dmab, size);
+
+	/* Non-IOMMU case: prevent allocator from searching forever */
+	if (!get_dma_ops(dmab->dev.dev))
+		gfp_flags |= __GFP_NORETRY;
 #endif
 	sgt = dma_alloc_noncontiguous(dmab->dev.dev, size, dmab->dev.dir,
-				      DEFAULT_GFP, 0);
+				      gfp_flags, 0);
 #ifdef CONFIG_SND_DMA_SGBUF
 	if (!sgt && !get_dma_ops(dmab->dev.dev))
 		return snd_dma_sg_fallback_alloc(dmab, size);
-- 
2.43.0.687.g38aa6559b0-goog


