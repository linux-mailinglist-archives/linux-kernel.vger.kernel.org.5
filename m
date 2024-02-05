Return-Path: <linux-kernel+bounces-52473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6ED8498A5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306EA1F233BC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF9418B09;
	Mon,  5 Feb 2024 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSN0VSbc"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80918633
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131955; cv=none; b=leWXNd0MctR8GBzh51mmEVBfxjPwgzlJFiQp32jXbTNwzsytrt7oGd98NGmEYxwIY9z+pHrox0/Ik9fkbX7NSMp1DEvx29R5F7sPiIuN9SJOYtYn8dqxZ4nXjY0WuTsB5Tnq15eLn1N1pGtI7YXSmkQVfa7o4izekCm21uzTMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131955; c=relaxed/simple;
	bh=5MCsgVAhYjZF5DQlYNglpcngRZCJMZnVgamHWL2nswI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MxRw4F9frSdYJVmPF9hExT9pTfBmtevH0yjgwJdJaHwkweo5zLgNPZKjlQKFuSdEwwtgumMX8wU0b8vZ/gBCHOGkCqdsbAeiYfyjjFOT3kuIvrp6nJb4aA4caE6Z7HrNt+DbwLfqrkhQ3X+/2pMfRRGlI9DSCjp0gLAhhvU3xb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nSN0VSbc; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5101cd91017so5529506e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 03:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707131952; x=1707736752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7yB1JwfdtlK8Nr5qoTQPOBteK5POkJ98NXnn48et6s=;
        b=nSN0VSbc2LFte/j/NOLEry+V8hKIrkqk1k8X7wNgYemPh6Li0muSHbJO4dcyMCgd5A
         ZuF2d0zwKA1WX8R9AssOU7DDPo1aw8lGSttko/5iYkg3nwR6eOOHSekkd0ib/skLWcYK
         XVo7hziRZNx0CfJkwdWV59nt0ueh6wjeZnyshRfnCe4EjeXIyM4LQOuQe6HvMhqDdwMF
         5Tgaf7i+ECnK7X5+8O/lLBpKc7yyD37I/G4jOaNEhGkG0kYYQAL+d0Maj0NKYHJo1AHE
         U8/K4RhGndkLoji+84t8EuLzDnc5T2DBwq0htHFC5jbK8PuC0ouXR9g5i8zPOFtcS8ZL
         C7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707131952; x=1707736752;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7yB1JwfdtlK8Nr5qoTQPOBteK5POkJ98NXnn48et6s=;
        b=quB2kRn/NSG35E7YkONpojUszDj7ImC7/oDJCy6XOst9kYfNJmLyz2eOsO3exb3KBx
         ka9Ps7/DZaFQmAyReep0nG/dUOjV+9k+KVnjR5UR8UsuCIs3ejt7kKhwnrObdYh2vpy4
         c9GJwGvQVCSx6lW1M64nWIiHyHvIsL+zzq6YMnhrVJUvWJTAvwtTnAj33p75U6oEB7bY
         jrw1Itlprlk+eFGfifyNnNpUQGaeTIgFz6PpBThRpZylV1hhufSIEpJZ9BWsdVsS+jjB
         nhI/PyHvS1paSvSTaqroPNe+AZRFOJtAIlinTShvbnhqhrrIIFXhpUb7sjgd967I3Y7c
         nyyQ==
X-Gm-Message-State: AOJu0YyPUPD97BWavAHRBj6bVcQC+qnsq4Dlx8Xcf7KkDwlCVZNjhtV0
	g9OdJxU9rwKUBudFt5ul84KkuinlAu5vCzzHDuTb59wG/2QUR5Rf0ot5qscrwlU=
X-Google-Smtp-Source: AGHT+IGmpBP0glxG1tsmzenDxuUuyUPzw/SIACwk0mD30y+FIBS0Wk3T//ZjdFnFjHVnZpfsweRWZQ==
X-Received: by 2002:a05:6512:943:b0:511:21a0:474b with SMTP id u3-20020a056512094300b0051121a0474bmr7803752lft.12.1707131951827;
        Mon, 05 Feb 2024 03:19:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWxVTGH8pChxHZ4vl2f+aPHH7RzJxdurH7WMsCH1opa4J7u2nIfGV33GmJOtgXSR7v1kugim2uChWBvly4fJffli2KzGUikkoymRHTuwMexSWMSOWjZ9MPSTAuUzlM8cfAnF8YFxN54DP1iUB167cLxxEKjcl/AVDjqZYDtMg+JBYBVRj5sTPc4grxdWeXVoL7zNv080ZMa66Mh/EehTvEbIwXN4Vso6eqwMyjbTNSZhTzC5YVWIItnOiCtSuQ5uzWRTiEFf2SAAcnvi6eprj3khwI4m4VFVGPDL7h1Y8fDCE1GYCQJFfrhkutZmT3njw/0qSLWKsZBUw==
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id i24-20020a05600c481800b0040efb503d58sm8177158wmo.28.2024.02.05.03.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 03:19:11 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: quic_abhinavk@quicinc.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240202-visionox-r66451-prev-first-v1-1-c267dc889284@quicinc.com>
References: <20240202-visionox-r66451-prev-first-v1-1-c267dc889284@quicinc.com>
Subject: Re: [PATCH] drm/panel: visionox-r66451: Set prepare_prev_first
 flag
Message-Id: <170713195081.1366121.15304766185356655476.b4-ty@linaro.org>
Date: Mon, 05 Feb 2024 12:19:10 +0100
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

On Fri, 02 Feb 2024 13:50:21 -0800, Jessica Zhang wrote:
> The DSI host needs to be enabled for the panel to be initialized in
> prepare(). Ensure this happens by setting prepare_prev_first.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: visionox-r66451: Set prepare_prev_first flag
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=bb3bc3eac316b7c388733e625cc2343131b69dee

-- 
Neil


