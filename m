Return-Path: <linux-kernel+bounces-68052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E210585755B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0242284B04
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F8E10A34;
	Fri, 16 Feb 2024 04:40:11 +0000 (UTC)
Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn [202.108.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4397476
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 04:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708058411; cv=none; b=J6B/vlyr3DrKD8Y60VfMTIqXKzHzHYCoCiNI0/W3H16+xyAYO+TKfIehmej+q/4Vs3Ymznm0Q3TeStO2nMKSqFYL2Hb0hrLZjJmyV4fInC6XBcCi2b+JwjB+iEYSib8MFS7gMwVqPnQ58YwV7n4GQP5272VjpxsFA0tYOB9ofVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708058411; c=relaxed/simple;
	bh=vDsdmX04xYR/ZsrLeCRVmexAxmdlflhNdPC7th2GmoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxLPvG9AAjzk+ecueqpejkSz+NQvUAj7MqZJGtde1SQrSvluqVSZcias10ZG0nDFTz6DS+WbStnk6TKe+MgKqGEJIA2gwDkl15aqmsdASvtVwNmhBU1d8k4DXalG5W3D0cphavOk11e+y/PBidS7nhfUfS3CcboHBbT/YD5QyOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.23) with ESMTP
	id 65CEE5DD00002E06; Fri, 16 Feb 2024 12:34:39 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7718657864875
X-SMAIL-UIID: 7211912AF5AB4416B16F9F67BA944DE9-20240216-123439-1
From: Hillf Danton <hdanton@sina.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Sven van Ashbrook <svenva@chromium.org>,
	Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-sound@vger.kernel.org,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case
Date: Fri, 16 Feb 2024 12:34:24 +0800
Message-ID: <20240216043426.1218-1-hdanton@sina.com>
In-Reply-To: <875xypk6d6.wl-tiwai@suse.de>
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid> <20240215034528.240-1-hdanton@sina.com> <87h6iaf7di.wl-tiwai@suse.de> <CAG-rBigFG-U-sKY77CvzghGzs+1Xm3YXzBF6N4ti0+h6UdAb8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Feb 2024 18:03:01 +0100 Takashi Iwai <tiwai@suse.de> wrote:
> 
> So it sounds like that we should go back for __GFP_NORETRY in general
> for non-zero order allocations, not only the call you changed, as
> __GFP_RETRY_MAYFAIL doesn't guarantee the stuck.
> 
> How about the changes like below?
> 
> +/* default GFP bits for our allocations */
> +static gfp_t default_gfp(size_t size)
> +{
> +	/* don't allocate intensively for high-order pages */
> +	if (size > PAGE_SIZE)
> +		return GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY;
> +	else
> +		return GFP_KERNEL | __GFP_NOWARN | __GFP_RETRY_MAYFAIL;
> +}

Looks like an overdose because both __GFP_NORETRY and __GFP_RETRY_MAYFAIL
are checked in __alloc_pages_slowpath().

--- x/sound/core/memalloc.c
+++ y/sound/core/memalloc.c
@@ -540,13 +540,20 @@ static void *snd_dma_noncontig_alloc(str
 {
 	struct sg_table *sgt;
 	void *p;
+	gfp_t gfp = DEFAULT_GFP;
 
 #ifdef CONFIG_SND_DMA_SGBUF
 	if (cpu_feature_enabled(X86_FEATURE_XENPV))
 		return snd_dma_sg_fallback_alloc(dmab, size);
+	/*
+	 * Given fallback, quit allocation in case of PAGE_ALLOC_COSTLY_ORDER with
+	 * lower orders handled by page allocator
+	 */
+	if (!get_dma_ops(dmab->dev.dev))
+		gfp &= ~__GFP_RETRY_MAYFAIL;
 #endif
-	sgt = dma_alloc_noncontiguous(dmab->dev.dev, size, dmab->dev.dir,
-				      DEFAULT_GFP, 0);
+	sgt = dma_alloc_noncontiguous(dmab->dev.dev, size, dmab->dev.dir, gfp, 0);
+
 #ifdef CONFIG_SND_DMA_SGBUF
 	if (!sgt && !get_dma_ops(dmab->dev.dev))
 		return snd_dma_sg_fallback_alloc(dmab, size);

