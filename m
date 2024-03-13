Return-Path: <linux-kernel+bounces-102238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D859F87AFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CB51C2623D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D3A7A701;
	Wed, 13 Mar 2024 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gSLH53Zu"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A3612FC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349917; cv=none; b=t0Hw4HhJByyU41UZvH7rMp+z/3AsWH4O91kEQVTgSPM8VL+JygY98JNNrywiCVp1newnvBBquZ259eTGHOPrXi/OS454QmoKxPhUop+WzGpTCqRWUv057WkHk7HMTzlEhnCma1L5rcOp1j9ZAE96F7KVC4syjNIBUQLxUz9szIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349917; c=relaxed/simple;
	bh=yxoN1G+uMZp38YC1jCCVFNGNRYjvjcKz2fKoJoCswhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GI1U+xnCqCW0rYrrULf52bKtYNlBmNAIpiA0AlER+pyOUPFxIFBzWV/ukAHYEmMx6StcXRvkyTO0L71/RrchFvVL/Rz90ho9g23tabB2VzfwAcSUECW7wFtLaVqM6KDtMhs7JsR9YaG7A2dp/ST4ULC17W7z0tlT/XpweuWbwtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gSLH53Zu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-413385f1a0dso514185e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710349913; x=1710954713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfCyEn4BBkDtIZTeeb4WXSUMa8UuweDcHmhz18/rnUY=;
        b=gSLH53Zuf44lWqdRb6iA7fAwPJb93ikqPpRNFOPpYfvooXiydYnU+odaOlRyO42z6u
         VXotUZw8YSGf6fcHH6+NQ7MX58v2AMxhatFk4F/eFXsYlS50Xk5RhDNN2rGQuaCnuMUa
         7YifQyaqQs6KJfmP8+OKSAHjcHg8uoq0QdKQnfhnIt4goBeNoKKf92fO4n5O7XnzDuSP
         4DpQisXF63e9RiSfAGbfJG98E2cGKIVJ4Ikw++1/+DL/U5RQ1Ht77cNgLT9OWfHUCxkt
         yvu7t2IdNmeLpZJVWzthSlAVsSTgSl+zUezXUkoUuX5KJhsGLxUU35m+CRGs1DRoFR2P
         U9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710349913; x=1710954713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfCyEn4BBkDtIZTeeb4WXSUMa8UuweDcHmhz18/rnUY=;
        b=E1/2wAVgc31lwP2BJHi5ZuMObM4EIYOARQw3t7CL+0tmh/b+8BbqHaqCNmPP/qn+Mu
         x8mrYkTO54hqrGboz7NCeEL5Ua7Cvn0caX93lCjKsR62tWY4b5eqQ/l5CvJUfYq1e5xR
         SEA1t9QBXwdkIDH3HGHrhT9iZMpdmaWkk2axgctJivv4dq+ScIcrWGLQ82h1v3HhsnS9
         yMWJnUGQZgBPm/q21ORALHkQ+htITKVzF431zYhzb0RBQJsTrCjt/Jj3pf2+iHBKbAim
         fwalysRCGf4DDnSig76Rw+rXw5Ur5YkJrJTHU3qnzDKOMHd02+LTz2BPeND5fjoTGHP4
         28RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjRHDpqyWZtFOdvfs54AbLQoqo+q9EJ6bJlci+yODJxXGiMFDgGiaZVK5Ym03OXSwCOJXyPv+coYWRNYWSL9nVfqY67XzmRJxTOjrV
X-Gm-Message-State: AOJu0Yz9+PzMEiKd9BYdRix9JOD+4Yo4CCNy9jn73jNeV3Tvv2rRcsvi
	/WiiOI0jTUo7jjZp5REAqqNCwfDMrk72gWRLm5Fi+3IvqFVptjd7FbStpB/daoY=
X-Google-Smtp-Source: AGHT+IFz1KXw55V676KHOL/rzoBQjJ9Rihc/CWALu4Z7kIN17vZX/My8C/6xcsm62UiChBonG2y1pw==
X-Received: by 2002:a05:600c:450c:b0:413:1285:6e40 with SMTP id t12-20020a05600c450c00b0041312856e40mr442329wmo.20.1710349912671;
        Wed, 13 Mar 2024 10:11:52 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id ay23-20020a05600c1e1700b00412ff941abasm2920026wmb.21.2024.03.13.10.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 10:11:52 -0700 (PDT)
Message-ID: <ef4da1f6-d3c5-4484-8df5-1a04df4453a0@baylibre.com>
Date: Wed, 13 Mar 2024 18:11:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] ASoC: codecs: mt6357: add MT6357 codec
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nicolas Belin <nbelin@baylibre.com>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <20240226-audio-i350-v1-12-4fa1cea1667f@baylibre.com>
 <9891855d-2284-42e4-9d3a-35ba406540e8@sirena.org.uk>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <9891855d-2284-42e4-9d3a-35ba406540e8@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/02/2024 17:09, Mark Brown wrote:
>> index 000000000000..13e95c227114
>> --- /dev/null
>> +++ b/sound/soc/codecs/mt6357.c
>> @@ -0,0 +1,1805 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * MT6357 ALSA SoC audio codec driver
>> + *
> Please use a C++ comment for the whole comment to make it clearer that
> this is intentional.

If I do that, the checkpatch raise a warning:

WARNING: Improper SPDX comment style for 
'sound/soc/mediatek/mt8365/mt8365-afe-clk.c', please use '//' instead
#22: FILE: sound/soc/mediatek/mt8365/mt8365-afe-clk.c:1:
+/* SPDX-License-Identifier: GPL-2.0

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#22: FILE: sound/soc/mediatek/mt8365/mt8365-afe-clk.c:1:
+/* SPDX-License-Identifier: GPL-2.0

even if I put:
/* SPDX-License-Identifier: GPL-2.0 */

IMO, the checkpatch tool should be fixed/update first.

-- 
Regards,
Alexandre

