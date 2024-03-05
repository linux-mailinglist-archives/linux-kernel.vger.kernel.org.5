Return-Path: <linux-kernel+bounces-91453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E47F8711B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF636282B39
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC4317EF;
	Tue,  5 Mar 2024 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvyPTQ5Z"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE49EC2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598494; cv=none; b=dD+MOorTuJfmJJMlSWdASCnB9q+rx7is8BaQPCxNRlbqydJeMkJqsq69yfZB+GMKCZ7whr4tlBU4YcCQ+g0v584P8HvgN/2sNS/6EKVDCjuFqbv6sdUrZ13TmOZNDluhR9BsCZkLNJqfgb20KR5ECbvdHeGpxYybvVOCkhkojNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598494; c=relaxed/simple;
	bh=4AjwDlHx3YycEF4tI7pNTUo4oAM3+zIFAtp1wah21RI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yil5OPhtwmWs+CULuAqHZaQOTfcE18SBOS0o37C/peqVb0jQ0gTX5XdwdsPYBFuV8yKEBJGBhgsWLrB2X1dyXt7VxB1hGXpyLo/LTl4A8764lSAp6iylykE8Pyql3gVs1PN1qXhhJiXo+Q8QK18gzHJghnq7BAE7gftq7DOljuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lvyPTQ5Z; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d2505352e6so64892041fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 16:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709598491; x=1710203291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgihA/j9MMe4W3y4lHJTNEdOriPRYiwOGRsjM+J9mKU=;
        b=lvyPTQ5ZbZXaGZvDLqAFKF0spichesYx7frXozgQSKM88zU+21JFcLVq0zxJhnBlKO
         d4bCn/kOhn7bKCL/oUm975hzFBf9V3JcxG56HUVl+7vnUUCPtua2aYy7K6g0+Z/x1vst
         MPPhPclxXnHqxvUkMtHKaz5qZKFxbz3vxeCbGqpLII0E6Zdd7+0/3Nq06XSrMMmPypW5
         yBrzmRPIS9ZlC0aEvkIrmuBo3o3uzL7TeqiyRSQT8CfUOYjgm+spU2NDH/JPTg6MHk/X
         xN6ulElgzibyMjNn0kkTSI6FvNLdy8W7CF+w6HnSvm2FxIN4w+m1Hpz07a9p7ysmcIQO
         L92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709598491; x=1710203291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgihA/j9MMe4W3y4lHJTNEdOriPRYiwOGRsjM+J9mKU=;
        b=RSTW8wuzGhZqGgvqTBVtZ1+lgICHVrhIeUL0USTRO9ffrI3bSrp60HRmE8YKmheCfK
         L4VgcdBMCMlH2+4hc3ViYlTlbfv3OESHs28HEZuvN9do09hzUszcaqEiyBQBhw9aQ312
         2LY/0ZRYLZJhDY41LOieuG5DNc8vO52n+qWJNHYqSDTzwZmRsxqBvyK+jrvO35PC4PZt
         7dtUN5EpYP9DuTfSzUQMI+IiRAijaPEJEqx3483bQTngwd8Zd5Q2i1cWv+m0gXhaR6R9
         8aRx7ozpCSfvAD4ymhj0kWnEzzpUDjBOllP0Hh/F2kUCjTfJD0Dfgs4OJDlUZ5MDIokW
         ZTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3eDzaVwbvds8xy8Bp1V9GC5syce3Hv8wCJMrfzatqMPt4tBAMeP21p77/QaeOJGpRrMe4JzTXPE+1lLtmWd+R/jIh6MkEob0ognH7
X-Gm-Message-State: AOJu0YzsE0c/TbMu+0199TnYza4EdWofGpMA/rC1d2x3ZeqIXQIkI142
	QOaqdvCxtYkD/RgkSDZDeVQ/DcOOgCMEOesrLSaAr9/yHKMJj2hbesyaF34gG3s=
X-Google-Smtp-Source: AGHT+IFDZK6sfIEdXRUKSjRI7ZdugsypJRMtPgYmqMfgXbm1nTdG+dB8phMOK0N67CVLvFXHeQOFIw==
X-Received: by 2002:a05:6512:282c:b0:513:2c50:9644 with SMTP id cf44-20020a056512282c00b005132c509644mr257056lfb.12.1709598490724;
        Mon, 04 Mar 2024 16:28:10 -0800 (PST)
Received: from umbar.lan (dzyjmhybhls-s--zn36gy-3.rev.dnainternet.fi. [2001:14ba:a00e:a300:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id s15-20020ac2464f000000b005133d11b261sm1149416lfo.92.2024.03.04.16.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:28:10 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Steev Klimaszewski <steev@kali.org>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] drm/msm/dpu: debug commit_done timeouts
Date: Tue,  5 Mar 2024 02:28:08 +0200
Message-Id: <170959846405.1203069.5519628464509979288.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226-fd-dpu-debug-timeout-v4-0-51eec83dde23@linaro.org>
References: <20240226-fd-dpu-debug-timeout-v4-0-51eec83dde23@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 26 Feb 2024 04:27:58 +0200, Dmitry Baryshkov wrote:
> In order to debug commit_done timeouts ([1]) display the sticky bits of
> the CTL_FLUSH register and capture the devcore dump when the first such
> timeout occurs.
> 
> [1] https://gitlab.freedesktop.org/drm/msm/-/issues/33
> 
> 
> [...]

Applied, thanks!

[1/3] drm/msm/dpu: make "vblank timeout" more useful
      https://gitlab.freedesktop.org/lumag/msm/-/commit/f1d0b196ff2e
[2/3] drm/msm/dpu: split dpu_encoder_wait_for_event into two functions
      https://gitlab.freedesktop.org/lumag/msm/-/commit/d72a3d35b7ef
[3/3] drm/msm/dpu: capture snapshot on the first commit_done timeout
      https://gitlab.freedesktop.org/lumag/msm/-/commit/4be445f5b6b6

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

