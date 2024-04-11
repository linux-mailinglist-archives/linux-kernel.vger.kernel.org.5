Return-Path: <linux-kernel+bounces-139847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B368A0863
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3172A1C223D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF9C13CAAC;
	Thu, 11 Apr 2024 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJHdqYT3"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7BB13CA86
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816600; cv=none; b=ATQDio90ZzE29te+LDZB46QepgBq8fpoHuY07oLqrAFASju/6Tnsbo5Ucb56NA8KLZSPt0gC+KqAHQtqCZ49gJSkRxKUBKG3pymYdD8JKuqvr2PpwANUmoofxQOWX8Nbe5korwy0mSzvBh5IAiloZC4spIA8Z6tjMuuvjcvrhIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816600; c=relaxed/simple;
	bh=CHa9nCNYOyaBvxZUXSfet8PtllPUBmwsccxmSz1COCA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uJRTcNp4A0Fl0swux3O4Vy0kuuKYb96DUmiBxB6dFfVB2yoYDvqq7vVkMTp3s5FMRF98z1lyAzQk2hAml/AJ80nEKnobUW2DykpNMCQcz5WaK57DFc1sGKiGigXpjUd2L5F2NeHp3O9lvu06U+rnr1xJgabymNLNBcDM1+w7pwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dJHdqYT3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-416c4767b07so11637125e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712816597; x=1713421397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLvISqXZdmyt5yqlSO/DtcSNYWtKPVUGBM9Iv21ubj4=;
        b=dJHdqYT3QSTKDy4WQ/tLhS+koBBlSkHjSNLr/SZa0aTMtNRQPaWyNsqYL1bIlOhGGI
         LjXAnsTAzig9WzrrxS3hll9FsxYE2cv8sJEsg6ijepsxaANOQE5FOI5hX8hai5JBx+Us
         u6gqEhHGercjEMr4/EDn867+Sv176qdImvpJ+fr3qDFpuc5yWj3AaFDAkm02/tHLdDwm
         +IMkwmbJojgDJOcvZXBgG24wBqtsNUUOXEMXJnQ1bjdhrFl4Jk0tvlUpMxsZ6uglrkXA
         DpU1uJ22kla1qxemjLcprk/W42iaktdpe0gg273MfM98zgpHB3WQQ8qNN/k0+RUJuQCg
         wX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712816597; x=1713421397;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLvISqXZdmyt5yqlSO/DtcSNYWtKPVUGBM9Iv21ubj4=;
        b=GWcFjrdmfOf7kcIu+O0OPhS+6S7Z4v1cyCDF947tpsFQtgzs7V2+ke/gq7ZAv0RqDm
         jnkEdvIhnKHy57pUpgL1RdItQFjDuTiYlPg0oKwhW29s/YR9FbYxKwOrZ5pKp1X2oJ/6
         +tiG/qDpYQpwzQa9hhuFk3aJf86gyKHyfU1fJCKPtfg3+6Jp8bzkhuVNh2N42OwWpgtE
         ZIghzTv4Kd4k8eaDs1wKMgbUx8Eji0cPOmRwB/gOiCOa6UIqQHLPFS+B+/Gn3/t6Wigs
         nD8SEO3hN8ZNm72XClLPYI79TsJqJoBx2tdkR8vRb/5tkr56p8/b/Ink0j6atiBNph2J
         cemA==
X-Forwarded-Encrypted: i=1; AJvYcCXmAIgL3sCR794tuaJMC07RQ+iLOXIN+gIsyXuTZPRcgjPkpFt8Wyypv486frjrRBAdRUl40zpKkcpjgWZK44lNqP3DLJKYVLKpWfZu
X-Gm-Message-State: AOJu0YzpnKA5xBDlwJJQuDJSg/QdiZe57eT5bsRSaRZn8wU0Lbxomsnt
	8EhWU1WV8JHWGGqN7Mxeb/IzcTd+eqsoRHS+PoheD72rZmdoo5zzDjV5816lizw=
X-Google-Smtp-Source: AGHT+IGqBs+09bOJDUOpTx8VFtBaFOEXG6AWuU63KdW/rUn2cvWjCDy84KxnNxoh+C5ejNZ2emzkqA==
X-Received: by 2002:a5d:6e05:0:b0:346:858c:b92a with SMTP id h5-20020a5d6e05000000b00346858cb92amr2242402wrz.0.1712816597441;
        Wed, 10 Apr 2024 23:23:17 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id df10-20020a5d5b8a000000b003437799a373sm966959wrb.83.2024.04.10.23.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 23:23:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20240410170241.248626-1-krzk@kernel.org>
References: <20240410170241.248626-1-krzk@kernel.org>
Subject: Re: [PATCH] memory: brcmstb_memc: fix module autoloading
Message-Id: <171281659643.5078.15100003832981441469.b4-ty@linaro.org>
Date: Thu, 11 Apr 2024 08:23:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 10 Apr 2024 19:02:41 +0200, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.
> 
> 

Applied, thanks!

[1/1] memory: brcmstb_memc: fix module autoloading
      https://git.kernel.org/krzk/linux-mem-ctrl/c/7a40c60c8acb71eb2b5196b0e675ba9e58af1b69

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


