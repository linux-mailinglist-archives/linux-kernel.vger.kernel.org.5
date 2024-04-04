Return-Path: <linux-kernel+bounces-131885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4371A898D27
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39F71F2899F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DDC12D74D;
	Thu,  4 Apr 2024 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S4rjRMve"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AD51F94D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712251476; cv=none; b=ceIkv2gXzm0BZ5eHRw9VnTfOiEHSjYC865K0d24eUfpEBJ6fKu2P9cvy8vKwSzh/HSOGz5Y8vojURGiLQq9AM+51eZOZMWpUS3oOwgzpSwk7y7W4fWA3+PG1wlBaVsWJsyqrv37pMZXjDGpOe7V3CY4VeyiJ2MXBhFp2NbHk2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712251476; c=relaxed/simple;
	bh=up5fuk8xK4e41JBROJGyt8Bvu3XgH6FwwTrNv1kqqBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prdtAeCOs4nscd6pdFvBhzRauk3akd+JzbA+H4LNFRbDHr8LVgsYNVaWHdYE5dshm9N3nWkh9dVrMi/wAYt284qXJa1y6OCGgoEOuVSNdurBU6quyy3d+IOhzLelitn9i8PB6leP1ACvj4tH5JDIcZPeePL3I5uT68qRb7IQX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S4rjRMve; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4156a29ff70so9287805e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 10:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712251470; x=1712856270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMRUN9l+VfoGtxFHya9Po4N9TdgcEu8Q1oy1tPF+5rA=;
        b=S4rjRMveapn9/At6UTh2qYxKdKGl9MvVUcO0nvTnJwGFdA3wzbmZDrNVBh3oFB6GoT
         VUKPuHU8+LHu4tW6LCu/WO4RbmIrlM80EmxMUaGkhu9b6AcUL+COQwI3L1lz+nX4PIvT
         sQHyT3t6YZwrsjj6ZZsLE0IpX3sAMNxWiViOX5Qw4RyLyQMveUEYWnfNa3yz10C0bQnE
         nALf/s+x4d7wJaCndpFHe7AkYggTM0+XowVZyM0hoo0l1bqmQzSkXp/zocVUq4xkSG/g
         /qw+iWIe+gQCF6kNVdpOhQ1HM4bFnqNhY2c5VGiIGruQU4iFdRwUc/jleagAiQdzO2Ag
         Q5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712251470; x=1712856270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMRUN9l+VfoGtxFHya9Po4N9TdgcEu8Q1oy1tPF+5rA=;
        b=WKkajYYyKmkbN57b+Jd56O9eXPC7rxlwnusCSJjcObpNbab8GdPrc2EZpmRFR8wiJB
         1wun3cKCqgCmA18B5Q0p0tqQJbtJpKQwzgW2TQJG1HqhNXcDJeBFy1H4+VwSezjQeWBP
         tZWYp+pzsC2b9uETQwN0Jpc9nS+Tldi93rCD4TLm2gyhPvtLsbJLOoQa1e1W56S563Ml
         FR8I+0zFu04xG8D1swnhQK9e0L2IyayX6kTEFlOJTCqtMuxCY4Rh4OwpNAPJdY5y+J/a
         JvDu/olt47oXQpXLrC7RZ1r0+uA+ZXi3xgnTesrXfQ3qV+Xr69p33DTmvsIjxJ6GAcB/
         i7UQ==
X-Gm-Message-State: AOJu0YzB8KQ0OyR8ZkyXzQDLsNDQpEfAPdcH7bwOOEqTDekz6kou73xK
	QntGjCay0gaHWybzHqgp9AfMrYKBsmJiZB6pJOYd0KDSKIlCkBlYsOTz89hmjzE=
X-Google-Smtp-Source: AGHT+IE4boo6HQ4hVEl/BrDpnnKeh7HMhmCrytjx3SWcfCIE5a1NSzUPtd7NSje/QG2KwonuZjfICA==
X-Received: by 2002:a05:600c:1715:b0:415:4a83:88f9 with SMTP id c21-20020a05600c171500b004154a8388f9mr2313387wmn.38.1712251470293;
        Thu, 04 Apr 2024 10:24:30 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id w16-20020a05600c475000b004162678e48asm3371560wmo.11.2024.04.04.10.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 10:24:29 -0700 (PDT)
Message-ID: <ec287dfd-846f-4175-a010-191022dbf444@baylibre.com>
Date: Thu, 4 Apr 2024 19:24:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: Add entry for MT8395AV/ZA
 Genio 1200
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 matthias.bgg@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, wenst@chromium.org, kernel@collabora.com
References: <20240404082056.93454-1-angelogioacchino.delregno@collabora.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240404082056.93454-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Great !

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 04/04/2024 10:20, AngeloGioacchino Del Regno wrote:
> Add an entry for the MT8395 SoC with commercial name Genio 1200.

-- 
Regards,
Alexandre

