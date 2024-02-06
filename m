Return-Path: <linux-kernel+bounces-55163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CC184B8B4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938891F260FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D513132C38;
	Tue,  6 Feb 2024 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M5HcTNXU"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C213248D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231483; cv=none; b=bKvYiToT+MwWM1Qk9y8YTDZb7vd3wtp2NKxhud2PdJOcCDFNhJTBuhJHn+ktud/8RM7KO3K7a7qVe9/WwmUVD/UVF8xyA29Dzu7AXxkqhXHqCjt1p06b7Q8Bwg2oLTOdNq4A9kCM7Re1oLAB+SEHBf/+gvSmmDA7pS+F1Q5cL3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231483; c=relaxed/simple;
	bh=gWADUEyg3uQn/Gq8Pzig8n0lFzdFAhq6eYfy4LPqtyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtEIAhh66Um70NOU34AzKYGGi8K4LV4/sor9EZtDcZ8OmsF+p2ScjXZcfCCu+wESn/q/j7hfAvk76I6A1BMkUAl4e2zmwCueKAdLOxbD0yobo5FIAHS3qa2uBbOzj88nXzmGjUl8GrU88qg7+gfmtVu+UcpWaZ9fcmHwTA8IZmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M5HcTNXU; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56061ad3d3dso1363025a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707231480; x=1707836280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCL4zV/fY4TbR6w8G33YGfXgioFiEYO2kvyU3dpfMUw=;
        b=M5HcTNXUjboDWjJ5EtBsMVgDNKmNoaFxvJsg+v/VfqoMLiu4qOu7RF2WtIaIxdnj5M
         5K+L/8UPh43F8I0JdvDyeCZcJ+pYpT44o94KBN7ZsZkk2wooEBtZhp+YZo8TMQt9LfpI
         wOmpXjBfydA1Ml62v5LxM3iJpDLv1N09w9rL5yDmrrVw8CCPK2gOdlz9tOprlO8F0FgX
         FYc9vLTvGoe1wEz9UOW5iwNUjecGPIG2orJGKdc4DhrLqMC5HMs4E9N8GgHhNTSbLmD4
         QlKCTS/lwXH4YiE7lvjkFuF8Qmf2FbLj24ESsvzk7oXmvIVi7F+bwKdsTWeyiwRWmW2k
         cSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231480; x=1707836280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCL4zV/fY4TbR6w8G33YGfXgioFiEYO2kvyU3dpfMUw=;
        b=jMn9AE2rqzAybtnXnhtz1sg7HIgzVWbcdDacyXeclmU58kKzPSgl5kL6zVn0U/fdJ3
         7W14Tud2+XRuBcmlIN/RRyu4DxXuBTrNnRBdgAys0KJaZB0LqxKgw+JYAaVxCiJyylNC
         92m9ewjQMONT+0dfYF/uLmk5afyHHPehcYrC/b0g33zUwMUAlYk1gqxGujGXNjVEXTYj
         KeCHgRG0Q4h/XODOENg4w6oSvM8VFs+SxRpA96H3k88utaPOtUBAomXl2tYHdhCczVjk
         yvrQDV2x2Z9gkt0r6vE/uwanA1ew+01KgLxnW9BWpcIyn9uUCRS8Vt9vSRaOW0IIsTf/
         Ny/Q==
X-Gm-Message-State: AOJu0Yx5Pu1emJJtjXvPJ0rGJdIGHDcRVYVu0YIiYHIHN22Oze7vL57O
	kz0z6rLFGvUVHvYYH9bbnt+K/M+CNc9NfaXEjxXzWE+Nfxc6sGq6p2M3Joj8cBI=
X-Google-Smtp-Source: AGHT+IE/xkMN+vq5s766SYdEh9U5SinilVRtC+iNa3NXit0ZGBcC6EM87J5PH4nbqf7jKMIRuG73mw==
X-Received: by 2002:a50:bac5:0:b0:560:bb98:6b7d with SMTP id x63-20020a50bac5000000b00560bb986b7dmr972125ede.10.1707231480008;
        Tue, 06 Feb 2024 06:58:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV2qU3BBiKmtKQKW+yzgCKFG+aWqLGGCGZ5OIYjaHTbPrBA4VcqyeA2tbkxDyqK6Uv8LGmGZPGVg/aF7sjjagiuwvo2enujdmA3klp0fgwUIN+gU1AzNmx4aroEb8uepPsd1ckdiGwcQLppJvKWeViTjAISYcxXJlRQNQobV1+h9N46OhD5XRfekGxm3mv6v+KkbSfEGnKXRve612YmHswTbkpE6Q8QEomA9mgR/4xdQh2ZQ/BypZUTAc3dypAI1dwEj/pjUdXaSZsxUqp3HXoriAHaLqyNWU7W8tr2n/zcCBqj87uGjm1hvswqATFsWZnCgOsQf/atT/OH4zWU+R0VND68NHY1JOs4JXbvrXFA1/20Bsofkh1KvYNu/bdPfyhikHRxpfWMAYDZ93zCfRYXOxRTclY7o89dMg==
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id cz6-20020a0564021ca600b0055d312732dbsm1120026edb.5.2024.02.06.06.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 06:57:59 -0800 (PST)
Message-ID: <74778dc1-1c36-4db8-9d5e-abdff9f8d8a5@baylibre.com>
Date: Tue, 6 Feb 2024 15:57:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] drm/mediatek: dsi: Cleanup functions
 mtk_dsi_ps_control{_vact}()
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunkuang.hu@kernel.org
Cc: fshao@chromium.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
 <20240206120748.136610-4-angelogioacchino.delregno@collabora.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240206120748.136610-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 06/02/2024 13:07, AngeloGioacchino Del Regno wrote:
> Function mtk_dsi_ps_control() is a subset of mtk_dsi_ps_control_vact():
> merge the two in one mtk_dsi_ps_control() function by adding one
> function parameter `config_vact` which, when true, writes the VACT
> related registers.

-- 
Regards,
Alexandre

