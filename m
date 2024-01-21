Return-Path: <linux-kernel+bounces-31996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1C783550E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B23B233B2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 09:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD15C364B9;
	Sun, 21 Jan 2024 09:56:32 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E71E497
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705830992; cv=none; b=b0wUB6Xsa6+MRpoTCeEx441fMUDku0FGYbWM7CgLO1jKuAodCjV3604Wrx0SCBYpyfsxPE7yrTPVxoomeG6a55YeWGL8+YsT8BimpRjshNhfQHxokhwcdJrI7Rso8Yfu5uHNT/LG13+/kZ18fEeVBLzjCe5nye5D50N9jO/fNu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705830992; c=relaxed/simple;
	bh=LUXkf4HBEF2S662S+V85kZbrzlmodKX7UJBgG76oifE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PRWsMvDXt+kO94greHteI51xH+VDcNKCkq4EcNnvsH8o1trdQepCqGOD5Dd0TNvzf8ImLvGhIJPZTWIOcNvi0yjTawN5Cgxu7/231ZcfTX5E7ZjReF2QcSFruq+uM8u+ooKdLL+m8S2H0+BcTkdsS+F2N6/JQsAB+aD9X2Cb39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.125])
	by sina.com (172.16.235.25) with ESMTP
	id 65ACEA3E000015B6; Sun, 21 Jan 2024 17:56:17 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 81253134210153
X-SMAIL-UIID: C909EB5828EA4A11A97D102167E10E39-20240121-175617-1
From: Hillf Danton <hdanton@sina.com>
To: Erico Nunes <nunes.erico@gmail.com>
Cc: Qiang Yu <yuq825@gmail.com>,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/6] drm/lima: handle spurious timeouts due to high irq latency
Date: Sun, 21 Jan 2024 17:56:04 +0800
Message-Id: <20240121095604.2368-1-hdanton@sina.com>
In-Reply-To: <20240117031212.1104034-5-nunes.erico@gmail.com>
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Jan 2024 04:12:10 +0100 Erico Nunes <nunes.erico@gmail.com>
>  
> @@ -401,9 +399,33 @@ static enum drm_gpu_sched_stat lima_sched_timedout_job(struct drm_sched_job *job
>  	struct lima_sched_pipe *pipe = to_lima_pipe(job->sched);
>  	struct lima_sched_task *task = to_lima_task(job);
>  	struct lima_device *ldev = pipe->ldev;
> +	struct lima_ip *ip = pipe->processor[0];
> +
> +	/*
> +	 * If the GPU managed to complete this jobs fence, the timeout is
> +	 * spurious. Bail out.
> +	 */
> +	if (dma_fence_is_signaled(task->done_fence)) {
> +		DRM_WARN("%s spurious timeout\n", lima_ip_name(ip));
> +		return DRM_GPU_SCHED_STAT_NOMINAL;
> +	}

Given 500ms in lima_sched_pipe_init(), no timeout is spurious by define,
and stop selling bandaid like this because you have options like locating
the reasons behind timeout.
> +
> +	/*
> +	 * Lima IRQ handler may take a long time to process an interrupt
> +	 * if there is another IRQ handler hogging the processing.
> +	 * In order to catch such cases and not report spurious Lima job
> +	 * timeouts, synchronize the IRQ handler and re-check the fence
> +	 * status.
> +	 */
> +	synchronize_irq(ip->irq);
> +
> +	if (dma_fence_is_signaled(task->done_fence)) {
> +		DRM_WARN("%s unexpectedly high interrupt latency\n", lima_ip_name(ip));
> +		return DRM_GPU_SCHED_STAT_NOMINAL;
> +	}
>  
>  	if (!pipe->error)
> -		DRM_ERROR("lima job timeout\n");
> +		DRM_ERROR("%s lima job timeout\n", lima_ip_name(ip));
>  
>  	drm_sched_stop(&pipe->base, &task->base);
>  

