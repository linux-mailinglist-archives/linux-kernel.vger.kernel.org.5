Return-Path: <linux-kernel+bounces-63686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1069A853348
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6B71C2284E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340015A7B7;
	Tue, 13 Feb 2024 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X4+MRCjR"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2BD58121
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834991; cv=none; b=FS5jxw/V8Vlx30l9xkBaTx5o0tt4tJFtW01nbUBVrM6QEX2zAR8FdXp42IdElyXWF87sbVRBmIPQ8aDHTvqWAU/ybKfX+yi91SixNDYyv/cUp+cxXCk15206OZLbrBSZtMpAfilpJeM9GUYTGA6XBP6OHcdKjQtXWmMqLjX8IRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834991; c=relaxed/simple;
	bh=G3u3Fj+XVuIDMGnnwZ/Mf59zPbT/jm0NzHnpO7uiiEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f0qCYKjNbUu+I2PevTet9lEP58cl0SspJVLE5ETEFZQ89xKHMz3fePLbF+0nrRTKvk8iOqkXFZIuvWt5YRMcqlBsylyKUnW2OHVGidWIr4uxOxjAlAbk9j2TQwWJwJ6bnIks2MWoaTNkKt5OXmwnYnfJLCKwIgD9bokn6o9fmZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X4+MRCjR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so6152811a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707834988; x=1708439788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwSTu8c9+qn7K/wj1Yj/0NOW4PVVyZ52gG9hFp6sXb4=;
        b=X4+MRCjRuIfq4DYi+Pq6T9R8u1OZydSz2DehCsqC7pt89JJgPSRzNd0MTa4XLV5C3X
         s+gKb82vAUL36ZpAfw12m/Vpg6v8nCjPvUvGdqOEpD+99pLH+7951YXfwCr54/hKZU+1
         9XUD4Ndk/doohG3O5PWNKxXDuEVPXg68waxQEGmrVdky9FP+dmoLtTQM5RTY23IRiZHJ
         1/UYpjlNcBUWw0CNENJhScJEZv5+XeL2qC59/K0ShSJLwrcMkqEiGHk+xCxzRKBCB0pV
         kD3U8Gn1GWYMFMYqeG8JQSKAwGiw0dqWeHPoyr637koDo9RhDwF+RNZjpY9SuTt2p4ug
         2HXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834988; x=1708439788;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwSTu8c9+qn7K/wj1Yj/0NOW4PVVyZ52gG9hFp6sXb4=;
        b=DgpQJzu0VB+TO+EJOdWd50xDQb/q0dMXSn4mCtGTkDZXdX2rkmZ5kLieoQ6RTMWi3j
         U4MlVXu+KlgfDwDCKOrS/P+r0Iog8yxrc1sw8ehLq67pz4ArYYScg+oJny9awVi5xkj8
         g173lYZbeBfqeh3VqajlQEqfQNRptCBw9HqtHHBNxc+faReK/2MQh53eS8n+vOgNlvcT
         M7B/1myb5MAN/Jl3aAESZKFBMM0kM+k/84b8aInlkqe8nr3MSGVUktm0ogKHgXp81eMO
         hkKFIfr8cBC9codFt1L8XgEib25tDQvNQCTPM1wZzO1nbTii73jAPbFwy9Qn4fjwbvo6
         Yt0g==
X-Gm-Message-State: AOJu0Yxig1D9yRqRY/Y+oXZEGUcYs8gfHHUTMiCaWYOfNM/lscsKW3uh
	oVtbrgxDym7OUxOTTgEKyCc6l2NPwcR9m4QF6UXZ8oRUg9XNb3qk5fljKu6EnAI=
X-Google-Smtp-Source: AGHT+IHyHB8+V0ex2KGnCGWHx2WLq8vEbnal2ITlQNjq3J21S86EHHwC/7phG+WC3CHeAwZNB/t1aA==
X-Received: by 2002:a05:6402:31a1:b0:561:8918:9f5d with SMTP id dj1-20020a05640231a100b0056189189f5dmr5613758edb.20.1707834987982;
        Tue, 13 Feb 2024 06:36:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXg13xPEGFVWMYvqH44/VdTQLrKxPXlhHGHNZ5XQjfSYTplx8peZ1KfqNcaIA5Iwl8OsJ/l9ZncWjcPbpkWKsah6sqzAuX6hGPFEZxc78H+3sC/5WmbtPvCVwAZVz3X0Nfp3GCWIgmX88Y6trfce5Wwi8eOKgEy7rCii2wR027nVxlV5IWyPI1Ta2jmk1NNsEUfurXc1nK4Acv+RiCtwU650PxrQV0Ea/WQmwBWYvs8Vknx2AQo6uo73K20BNUmkz3qftZxOKWAm+0xhZoblSGFlo=
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id j1-20020a50ed01000000b00560ecb22d49sm3688362eds.84.2024.02.13.06.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:36:27 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 William-tw Lin <william-tw.lin@mediatek.com>
In-Reply-To: <20240130095656.3712469-1-wenst@chromium.org>
References: <20240130095656.3712469-1-wenst@chromium.org>
Subject: Re: (subset) [PATCH 0/3] soc: mediatek: mtk-socinfo: Fixes and
 cleanup
Message-Id: <170783498706.33763.10510416022837379654.b4-ty@linaro.org>
Date: Tue, 13 Feb 2024 14:36:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Tue, 30 Jan 2024 17:56:50 +0800, Chen-Yu Tsai wrote:
> The new mtk-socinfo driver has a double put of the nvmem device used to
> read the socinfo data. While fixing it, I rewrote the read function to
> make better use of the device node and device relationship.
> 
> Patch 1 rewrites the cell read function in the mtk-socinfo so that no
> resource leaks happen, and device lookup is more efficient.
> 
> [...]

Applied, thanks!

[3/3] nvmem: mtk-efuse: Drop NVMEM device name
      commit: eadaa6f9aaf682b1840bf08a8320907de4e32d50

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


