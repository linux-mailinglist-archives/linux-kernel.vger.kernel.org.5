Return-Path: <linux-kernel+bounces-139848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 824478A0864
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD17281718
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B132E13CFA9;
	Thu, 11 Apr 2024 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrTyaeCk"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573813BAD2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816602; cv=none; b=GwePzGxcAvq1nL1uLizhWP6zI5W4PLslz4WVY+F/Vu0ryqj+Q7IvHvrnCC3TqGnTctoS/E18JkpgT+ubZSxXovgIZdF/YaeK6kOqKEMFp7i0MLfAV87TDbisaj93SblrObZKcklbd3jXnpcYSbxtt931Om4ZDoSpEPeKH2TWRpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816602; c=relaxed/simple;
	bh=79ROAcAUX+8wA61AEs3E+w08cIta/B3NPy8Fzt03bZ0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AElCp5znZzRTXQf0LRgHM5+r4gHaIlQpPE6N5lP+c6d91+s/bXbSB1vKAx/qX6I/7uDbeleuMaPFcpTy4M91DdAegSMn+W3bpxIftBJDpDMzFlJzvIPzx05YafbtocSoRPuvjOh4va5BdC+lS6e+WwJu32bapDHiogDpdarJ/tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KrTyaeCk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-346c5b83c6eso103656f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712816598; x=1713421398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLnJA47z8azdtWivfiw3NkDC9nYPcr/CXIl1SITNREU=;
        b=KrTyaeCk1ANxObz9I+HYazsTx7UeN+bEFuV3LRBEJqOg214OBBADi1bTUay3GN1zkk
         4w+2tjfUVR+PRLY4xQ85KTwAjBP7J2gv9yZ4U8jfpoTYR8Mfgj/WCvAGa77CIQB98RtC
         mcj+1IEHF9x6xvoCm3Vl4admAPPvlq5x+eHxRj58NxpA3R5TxZIaSW/VAuM3WsoJQlXm
         EZzJBsx0FxWgHEW18RGze+aCy3NRPWvi/MOMEPPq2Rfll5vvwifBg5zTdtdh4yFVapE/
         fgiCFoRkvk5sW/8X7LdUjK0z/9QljInkxRVxX26CMwPuUIsIkP2iYxyKzMT1Ezpy8o0N
         KSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712816598; x=1713421398;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLnJA47z8azdtWivfiw3NkDC9nYPcr/CXIl1SITNREU=;
        b=lG2botNLpXVh3ElcVdBKtNKuCOiiLJDHyROV+Icl7p3aPdLEsWhseGWnHvrBcNfVxQ
         Qrkc1frjgb1NxUHaRZKhHIYUbrlzkUNJiqmuFq5tr2/NHinE/AAl1FiL6tN2pmktLaIx
         OTjlXhfLs6B5Ik1MJc6gohjd8Q6fY5ZQ3b6u53t7/IkRhFssOL5+LijCgwZ7iug/DTAD
         SM3jYIyjB7B5kDn/WeE4tA6amGfzmUe4JruLcnJoM2LYd1dQq5rDqWhZ0Vb+hlgE2n0c
         /hJb9LmxZUn97dXwQur4QeBQUht/4MErA2TUwu9Ljqsm2q2xjkHtSaObCowSLkRVuziK
         vUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnKPkgsh29zaDrraTJWUVWETi8S4cpGnQjFDozbvYUQXc8GxiM5uXnsoodaMjHV9BAyAsedK8bo/ZSeabEvhVnJEsbe5Zs0emiVfz5
X-Gm-Message-State: AOJu0YxXKHrEQTK020kHv3ujX9LRCbpFEZCOLXVlQIt0bTR/W2njGwUZ
	q2mI75+pZ4zjFhMKzMtdCvTg0uTUaXE2cA1tGNXGJJARGYU+dpDQauFbFiqX4Vc=
X-Google-Smtp-Source: AGHT+IHYK0GC0YQ5Own4ljJ7YwxqbYW05iaBzbBI3E/Z+vVUtSD4qyMdwUhdsufUVcvveWcPuZOevQ==
X-Received: by 2002:a5d:628c:0:b0:343:ad7e:5bc5 with SMTP id k12-20020a5d628c000000b00343ad7e5bc5mr3139611wru.57.1712816598656;
        Wed, 10 Apr 2024 23:23:18 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id df10-20020a5d5b8a000000b003437799a373sm966959wrb.83.2024.04.10.23.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 23:23:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240409204615.83928-1-krzysztof.kozlowski@linaro.org>
References: <20240409204615.83928-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] memory: mtk-smi: fix module autoloading
Message-Id: <171281659758.5078.1440563785835747624.b4-ty@linaro.org>
Date: Thu, 11 Apr 2024 08:23:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 09 Apr 2024 22:46:15 +0200, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.
> 
> 

Applied, thanks!

[1/1] memory: mtk-smi: fix module autoloading
      https://git.kernel.org/krzk/linux-mem-ctrl/c/bf11908757eeab716536d16a32693b5dcd6990de

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


