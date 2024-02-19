Return-Path: <linux-kernel+bounces-71311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FA985A361
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE95283A89
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320C34CD5;
	Mon, 19 Feb 2024 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q23kRpUR"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C6D3308B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345852; cv=none; b=s+f3C1NQDmNiyA0rY2oNOH2yYVU1d9ID0J+3ntwdzPS1oyetUvwmW2KtHhNKjLe1KxkXAnk2E16+zErVaSNSOqmajTDVov7tax5G879iyXr7ZljjA1SbpBJYa0GVtI2EpE8bNUMTwd1OEhorPGbB8lLGNptq8QlfhRium/1Und0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345852; c=relaxed/simple;
	bh=jYqdRo7JdfE4U0A2ta4U0griZReR2eeNLABnAtTYPCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFxNDda1pbPNfjACyG6oMWZLDlOhziWczZfo2hwPDPOdWeIq36NhT1MJRB8yx4qUpbg4w7kRuz099nAvyEmZ/80kEnNWbyD70FNPnhaYkYgLW2J4VPNiDqFgWOk5uMWFXVau5zlV8KkEi01OOnnMFv420Yyw1a8akIGu+eIDESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q23kRpUR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512be87a0f3so179834e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708345848; x=1708950648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sp39V9/P58ZsOOZzf2qvTJrJfggpOrhkMb0iBsxVm0=;
        b=q23kRpURbNnT9Ctvpg4nch/qP6koNzvJ0lJhoDv6jRb0kNKNb+dVkg0OvCWsMaAbEu
         vpgl78qjAiFGGUECoNPaDdB4Y0h3Ia9k+Qy3Wcb6DaS5q9C+eT7Ys4ofGW5ayKNtLxEC
         QFPUgqrJIdGW+V3q+X4c1s8s4/rs7SCyqcvouh/7lWapOYgnOntnrIrNz0DyOrFuK+Bb
         je7/itAURVmIayJvB79UA3A8+YZuRxCK5JSNMhMLOpQxbacOZla/Q9f3hCbpRNdtJOBw
         eBnxtTe4kA7LslZGvnLLcNs0H6F6c7acj/YJGvMcnAnjXQKUW5C/SD7ZbevBZk2C/WNC
         ADNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708345848; x=1708950648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sp39V9/P58ZsOOZzf2qvTJrJfggpOrhkMb0iBsxVm0=;
        b=VOUVdEyprcQWR9l+4+4rHadQSoyL/PMH4LZjoxS7YY3olM1nTAW/In09uCpqZqGRnd
         L2a4knFaaAnxPCKWFa2tWdT8tbczdCd+RtmpDbvEvIYyLUHcXiFAauNTMJkTZ+oKhAEe
         3633iplimHvo+LrUfq5mlc7vYZrzk2VC6JK3IcOAn2mMxFIv4bdZSWf1BpWX4ZHEo4UR
         rR7VMYGRooR39JyCBO/PbrX0XAIJQRUwWmPT8VSCeYyEyEA952OHErpK0qzWkVvTU7PT
         1eb67H6egQwR6nULFcDip71z7eCrmpn9G/DwUJufiIagkepKONwydLonosxY/dffb4Ox
         8cgg==
X-Forwarded-Encrypted: i=1; AJvYcCXYh1v0PULheeTxvPkEWh36Lo6bg/TDFSgR2GQfGjA3dgVyTFfcJH44v8SnMgYzUGWZpMHxnyL/P5Wx8zltQPr9fu3hebnC9o6fWQNK
X-Gm-Message-State: AOJu0YwYZspeLCXA8/Mxc3qOT9vc3q9C99DRpUOI+mlMUi0IC6Hb8KrG
	aEPGIEv157lGX+SDzf1JQ0Rca1Y5H8g6VYVP6/frE0VG+o481tHkEnbnIUn9EsQ=
X-Google-Smtp-Source: AGHT+IFoZP6/ZG8y/H4k48B54cjghy50oBw/WDFb9BTk0tJ7f6x7I94swyk/24k8TDQUDaXjP0IOpA==
X-Received: by 2002:a05:6512:220d:b0:512:ac4c:abf7 with SMTP id h13-20020a056512220d00b00512ac4cabf7mr2834148lfu.65.1708345848701;
        Mon, 19 Feb 2024 04:30:48 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i6-20020ac25226000000b00512bde4cddfsm90466lfl.148.2024.02.19.04.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:30:48 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Stephen Boyd <swboyd@chromium.org>,
	Carl Vanderlip <quic_carlv@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v4 0/4] drm/msm: provide migration path from MDP5 to DPU driver
Date: Mon, 19 Feb 2024 14:30:35 +0200
Message-Id: <170834569501.2610898.9932991844381586058.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208-fd-migrate-mdp5-v4-0-945d08ef3fa8@linaro.org>
References: <20240208-fd-migrate-mdp5-v4-0-945d08ef3fa8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 08 Feb 2024 17:01:07 +0200, Dmitry Baryshkov wrote:
> Over the last several years the DPU driver has been actively developed,
> while the MDP5 is mostly in the maintenance mode. This results in some
> features being available only in the DPU driver. For example, bandwidth
> scaling, writeback support, properly supported bonded DSI aka dual DSI
> support, DSC (display stream compression).
> 
> All the pre-SDM845 platforms were originally supported by the MDP5
> driver only. However it is possible and easy to support some of the
> older SoCs in the DPU driver. For example in the v5.18 it got
> support for MSM8998.  This can not be considered as a proper migration,
> since there msm8998.dtsi didn't describe the display hardware
> beforehand. Instead new bindings were added, making MSM8998 just another
> display hardware to be supported by the DPU driver.
> 
> [...]

Applied, thanks!

[1/4] drm/msm/mdss: generate MDSS data for MDP5 platforms
      https://gitlab.freedesktop.org/lumag/msm/-/commit/d2570ee67a47
[2/4] drm/msm/dpu: support binding to the mdp5 devices
      https://gitlab.freedesktop.org/lumag/msm/-/commit/39b06ed6d4f3
[3/4] drm/msm: add a kernel param to select between MDP5 and DPU drivers
      https://gitlab.freedesktop.org/lumag/msm/-/commit/b8b123187035
[4/4] drm/msm/dpu: add support for SDM660 and SDM630 platforms
      https://gitlab.freedesktop.org/lumag/msm/-/commit/7204df5e7e68

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

