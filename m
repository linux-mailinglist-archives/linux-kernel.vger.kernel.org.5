Return-Path: <linux-kernel+bounces-50612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEFF847B9F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE538B293BA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D25E83A14;
	Fri,  2 Feb 2024 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxpcyCjD"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188E97CF3F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909754; cv=none; b=cEf/8+/WT6MjVoukbpWh732KL8xp+6nNsc1W2Vp/SS0iIew1XKxw2tPnqOdd16J23hAuM2JPPkSVUdIsHqYhm7vlQlIwIOAKwEZOOfXzFs1Xz00abdHlPh7u9GDq7EBVvEdlagNikyQ6KYhVfyjMwr94bNxPjWZhsTVutvDYKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909754; c=relaxed/simple;
	bh=U2UsdGa3SMPcpfNa9wt1pFgLrogW3ZWFGuyc/JxmGtI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M65+OMckomCR4Gvf+eUNgjW7HyevKnv0lN2V2MaG2fM1eXehnvoyuxEw4wM9Flhb8ZcTwV2um5oYU2/u9ykmK6jx44C1NPtuJDbc8rApl7QofUN/9yFyl6tEXKOXxyg6drDDvSooq6kRJ9d/QIhRIZe0dsFPW92iNbIu1+Eya74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QxpcyCjD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so107627f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 13:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706909751; x=1707514551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1ZLpW27TrE7rpACPr2operCMjm03U8jbEe8JMN1ark=;
        b=QxpcyCjDCEeaLVGVexkAMb4CGEquP0h4fKNaE5ayr51JXmShPyM08EBgnst/4nEXOO
         CaAIgOo0wf3cER2GTgi/czRATWVjnNqDwgCN/Ne9wDLXwPw40/9+lNV6CKDYcjkt42Q/
         /0/uGRtrveWRTsHewZiAUxdz0ocm+3My/1dYBkEGC9l6Gg5i1gPlhGLPLoe859kad98P
         bbBDvfVU+SNGOvSNL5zQGbWRo6jjpcAQTScbQVzBf+6OPCxswu6gDBVO5JiTpLEJ0sgG
         q9dGy2gPVM+wm80azXwO+GtKCMs+2FXmif4ye/zxDWzoABXortHJ2x83VNMD2C6LOWwk
         R1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706909751; x=1707514551;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1ZLpW27TrE7rpACPr2operCMjm03U8jbEe8JMN1ark=;
        b=r6CVWQE0rCfrjZ0YPWlgQur6g6WGQt+1i7ShvkHxcZwFOXst3b03CD2ZNwjhE5WhJh
         AI6ZaeNwidfCU1FDr7qZ8qQRDuD6MZ98KPOdxCpySEgfFp1+6uKY3qMp0s0LWz6Q4aFe
         DqPkAXalFAMn7S6LGrvsDSZDcy7PNxr8XSArUzQaLeiSO8cSy3QoS6bxSmpUbV/YzZhG
         dQrzWVGd1JWnsUDT8T9wSfXaSVPdSyXj9yea9Kygaa4uSno2Ff4A+Brpljfxck2sWYDa
         Nx1v7cPP4uYw1rYWzieKvTQ+T8FEJzBHz/4y38i1FgvB3byWsgUo/5D9fOoBWUMhCISw
         cIWQ==
X-Gm-Message-State: AOJu0YysIQHwpuFhMwiBxql92hgjki4rkOFtR8Cf+935gkmPvw1WYv90
	0fOpZjIxyjJdpyAf1AXbZ9yR1yiTYMVRkjvGPlDygAYXjPmJ58HzeCkV/GLH4bU=
X-Google-Smtp-Source: AGHT+IFf1mA/6YenzqdlJr6uw7LUW9L8fxC5+4TIZ3fWpdsXNtQ8p9zpUCySF0cAYE+7umcVPdDeJw==
X-Received: by 2002:a5d:64c1:0:b0:33b:187c:fcee with SMTP id f1-20020a5d64c1000000b0033b187cfceemr3812356wri.29.1706909751236;
        Fri, 02 Feb 2024 13:35:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUyamDcaqCP9ah/qd/K0aYUKo6fJHVfZJBS+KCqVnHKrWp8g+gSpzoIJml6pkX04CnKx1ikshesz6EtNJnuKJY9eNXret7FP8gRAwawoUcLuynFYuslxuTFcRZM2kUSnHuSS7gbFBRVYLLw705boCPfJKCv2D92ru2vUY+PlVgsZRAMr2AYl2NDrbovD3Dlz8g7S7+TKshBldLavbXYMc8tjPDbg94krEj9FJeTGzANGG8NRa+9QzTOLmeG7iDoKxsVS4qKld98UyJZKv07fCeG6rC+dy1Tm6LC62yRmA08+LAuqNwqbfR/hPJWHQpESLWiHLwbUxB26BM2mrCf7qI05e9GY1MYCCAh4JCkfRDrVmyTSLjbHrfNLpSzZ8+h0u1Szf70
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600000d100b0033af350fb88sm2687201wrx.25.2024.02.02.13.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 13:35:50 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jianhua Lu <lujianhua000@gmail.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240201-topic-3623_fix-v1-1-86ee6f20876e@linaro.org>
References: <20240201-topic-3623_fix-v1-1-86ee6f20876e@linaro.org>
Subject: Re: [PATCH] drm/panel: novatek-nt36523: Set prepare_prev_first
Message-Id: <170690975036.3073109.5398600795989490527.b4-ty@linaro.org>
Date: Fri, 02 Feb 2024 22:35:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Thu, 01 Feb 2024 23:17:40 +0100, Konrad Dybcio wrote:
> The .prepare callback contains the init sequence, so the DSI host *must*
> be enabled at that point. Set the prepare_prev_first flag to ensure that.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: novatek-nt36523: Set prepare_prev_first
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=d543d1b6086b18f8d8b4b26bcdf86566382a3d35

-- 
Neil


