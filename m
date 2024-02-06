Return-Path: <linux-kernel+bounces-55231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD1484B962
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3309F28F734
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1111413698F;
	Tue,  6 Feb 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qc6amC4l"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FAE135A4F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232869; cv=none; b=OKxFMGu6BEO31UNQVCdYDBgwUElzgH3eL+FPByFEy7LrId0TrWOJu9R7Qf/9dC92uKpvUcjVkNacpgAKwN787PuhY/83TOJDoD33RExmJyVI1vAJrYW3scosPbxxwfeCHkl2nN0sYog6eaS7XMEO+tkL/t/HVuvS8Q0Y/HhG3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232869; c=relaxed/simple;
	bh=E8NxgONPBxV07nXx5YDR5cJtzDFHPnUMmdFelx3obm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2rPOvXzamXjGaWxqdq2xAWRc3cUUsZnl+8akg+zsJoVPyQNexFYEGXiT50Fg+hCeGWeeSJvNh6qcd7RBVRyFz0yw5b3DzUhQgro1URhe26tODXuODJK4D2zWQ79hUK9/rJgrvSBQ3pXeP9MZpaR8sIyMCVZ8sO4X/iHqGvSj8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qc6amC4l; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0a0873404so37945681fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707232865; x=1707837665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIc4mpHkEyVhvzKbl3/CXTyhjyWRujcUA5n7Ow/N8Kc=;
        b=qc6amC4lYobYcwACki78wAa17PG3xDLXJKNoMhgu2Zuqio5iuFOQKmPQw3ziVPM8r4
         am/cjbym4NVHadoN8MUhzcrkil5VfEiPqKGWkdCtvt3JuTj1MTZoYVO7Xad82SJZZuAk
         pNduDsWfyaHzAWhpqC4J4oyHaEaotj8aWGOao57b5+ia09MXntGQNuLSszSxVBQKoBsM
         AujN6qKO1dTd9uLqaHtXGtr34MKYkNqX7WM248Un+omgZ2V9+O2Lhe08H3jwquQ7xWEs
         rPyiq8yW/oLlu2i60s90yvd4sjsgTEvJHfjbGwLTSPFc8RmtaNJDDmuvSfnTsmtPvTkE
         fWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232865; x=1707837665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIc4mpHkEyVhvzKbl3/CXTyhjyWRujcUA5n7Ow/N8Kc=;
        b=cELESTY5LDE1wOR5wCn0h8SbLFee7j81x8vSJMcm1te3W0+3TO3xsdcH/VkZi8sOwR
         U2rjmyPNxgTA+4U0G8zdLKiYHcSryjOfVHXBNYuwkHwd3QNdSQ+JjYTnhubMSRWyc9UW
         D/NF8U7nzorrw8/g5PuRciF1nfn3J23jbYFjGLmDG+c5t7XyKgYecB0VlVDOCPwMn2nr
         gzxBOGRzoFq0Feo0/sgXFGI70DQgXsesDybk/Xr2o3CLtNxMTqhMUbS+A8+ELFR6Owrg
         QOopGKbXX8iOyJKu4IPgSRzOMxRzsh3rxIZVfQdVD0o9bRU7VQtgg7peEmavSHixNagy
         Nivw==
X-Gm-Message-State: AOJu0Yxqai4sZeGFJFcO2SogDtmyf9MaCO55mGeii97dN5coytEm8J+4
	53QPbC+a377/9V5ktoJPvjMB6/7ozRsPlDPQujX95OztWvt/aGK6zvOlTcqD5to=
X-Google-Smtp-Source: AGHT+IH6B9hxtB51OAbCk+OHsZztqp+0HCBvlYX0qY5/9gpcQGkhT3ZpT3m/XchRQjfWgcgI6+PF/g==
X-Received: by 2002:a2e:b24d:0:b0:2d0:908e:d825 with SMTP id n13-20020a2eb24d000000b002d0908ed825mr2135508ljm.21.1707232864903;
        Tue, 06 Feb 2024 07:21:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVzh2Ov2RC+YTsegCX0tzyIx3Lk6zKPQmeoT6oJ0BC1fRsrm0SsQBPV4G5d8jurnLVezvqIF0LxGaRRFkCFI6iVG7PryI+Fx5Oe9TfkG+BkF7qENEvsMcFd/Q1Xu5i6TEFk9m+ctOVtJ4C2UH//Ks/72ACsYssXDlbe8POsU4ku5swiJNOSS/SyLFcYEDlYSYiTtxZe4xgM59SlWwvKr2Geqojgb0jzz7f5bo7szkiMAUE2a36mnV6xHu8Hy8gbe1SRimKUMiOGO+dK6cV5NktlO4d5oAkXeV1fdDpQiBVe0LqysNOUyBTcTvKIH94M7GHJSyoMg63UjPR/ycon8igVEoL77TUZ/p4TAs7tLyD6Gdb1eoTC9+iSsX45I5B/nYCNucFr1SaFgoUJVTY7rYPRQQNmJbFu1rSlFQ==
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id p8-20020a056402074800b0056022d78141sm1124432edy.56.2024.02.06.07.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 07:21:04 -0800 (PST)
Message-ID: <07c825c7-5036-4b9a-946d-eaaaeb4c050b@baylibre.com>
Date: Tue, 6 Feb 2024 16:21:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] drm/mediatek: dsi: Compress of_device_id entries
 and add sentinel
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunkuang.hu@kernel.org
Cc: fshao@chromium.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
 <20240206120748.136610-9-angelogioacchino.delregno@collabora.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240206120748.136610-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 06/02/2024 13:07, AngeloGioacchino Del Regno wrote:
> All entries fit in 82 columns, which is acceptable: compress all of
> the mtk_dsi_of_match[] entries to a single line for each.
> 
> While at it, also add the usual sentinel comment to the last entry.

-- 
Regards,
Alexandre

