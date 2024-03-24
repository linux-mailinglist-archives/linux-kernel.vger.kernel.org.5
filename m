Return-Path: <linux-kernel+bounces-112863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EEF887F28
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A755F1C210DF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFE81C692;
	Sun, 24 Mar 2024 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lZ/VvvsJ"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4338DFB
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711315504; cv=none; b=giWVN9H98I1VGuEc6lPgrAIAHeXBQm1d+KkE2+7x1enYmeGwfXfuRjdIoPlrCLLweTkTNnvhxtde5H9BW0he2aGaptrvk5xy0sVbJagBfbKfFH41htjlTvBpeAiFAxdqLiTXRFh+bqm322PNAjq2+kayQRMGPp5UUdPmr2aOe7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711315504; c=relaxed/simple;
	bh=cwb+YFRbwyYuw0AcWdz6CUnMjydvn4ln5n953mSo1/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kjz9FnXbKMaypNRNKUsSKexEwMXb0pKwmt1Pf8dbN+/fh/AqeMa+xMulc9tQf2kWbh2UvuQ01c5+EnG9FgL1iBnhSoropN2ICg3x3AWuibcodlWX4aYM6qBrRAyR7x6mHEnmXE+iIfANxohKUIT45WatPBjyuJGNZoK+21gyxNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lZ/VvvsJ; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c390030af2so2833049b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711315502; x=1711920302; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JAn6z6C6kAQCNocTNhwJGXaT3ktUI5cvq1m2gw2cMlM=;
        b=lZ/VvvsJDEAAuFKZ0gmOUfq4yqK30jwFLE+hnyJls6E1AF6tC/A2jSgIwp+7MT6Z0R
         1rsqtOhvFcYpC7pFneC0gDA2To1cToOjJGCK/FYo10p+WfvLC3h7aQE+pQKVjLcX8s5O
         fiBfUR/b08U4MK0n01nOlE+uXs8G1fyVfqxzYPReUbFYYTVcBywjwxwc98aPkJa2x01E
         k9Y+2mrvjZaT+aynXA9EfoFTRE1TZd27RIlTyBOn3lJNtxxbLfnqP4TwW1nUoIZ/l5Ak
         E6AYiOVmx4EQhZN2OBxRBLvFZkrASWExS3EUJvKkFlJHcr625cYLJd4Ux8ZNoAFMaE0G
         hkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711315502; x=1711920302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAn6z6C6kAQCNocTNhwJGXaT3ktUI5cvq1m2gw2cMlM=;
        b=tCp715HBeEFsoXVEgxRsUV5gd0rtEY9bCUqrH8Ze2vIiacSc1xf9rbxtsovbRO950Q
         I3hzrNR6fDVeYzTmQQhsgrtBbjdeoPghXV0vUeFlE7IhGgXvSKRWIhJOUu5ZhqVvLta3
         EJbi+hEAPJKU1GBUaE4CyXT4TUnp7WZGqEq5bGvo0+wFllV2DEhIiIJQC0gZ0vAyZJos
         flJqY13d6s/k9QFdlwLKX+gjWLmU3b+0w4IvKJvCUrL5JV2i2IZ+AVC56PWFBHzx/j8a
         dVmylM24rtx/CIC6JFkLnHa7vuRUz5lIidHTMyvnYga73FCE+t8l4g+l6cqAzrqM3pkT
         1d7A==
X-Forwarded-Encrypted: i=1; AJvYcCX6Mpu2114RH8oeNjb0m1Po2g9HfKkbSiLmFrRiCqtjGcLO5RapwKssM5uNWuiuBfG4nR4eGQWiH8OQXxtXtgILczYb1BwRQGIe81xs
X-Gm-Message-State: AOJu0YwgHRdfsiIGLPKxc1s56YU9OJqLXpiOUgwQwH6f26iVTDOH5KYd
	wY6DDDJPubSPVQKu22zodaNMHea7Bozegfg8hLZQswZaZcESgFpillBkp1w5Rrzi1gaahXCvhzQ
	a4B6zR98LjA71ZliKU4PpyvnEnHVXHQAJUic6Aw==
X-Google-Smtp-Source: AGHT+IFsASaAXYhy6wMEzFscwmoJiMkAf8XUTx8af2vr4btW+ENv9jYLPxo+baqJKEZ59gDPp1vL6Dvk7ZbPq+nVlgU=
X-Received: by 2002:a05:6808:2a43:b0:3c3:7edd:bf84 with SMTP id
 fa3-20020a0568082a4300b003c37eddbf84mr5754842oib.35.1711315501982; Sun, 24
 Mar 2024 14:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324-x1e80100-display-refactor-connector-v4-0-e0ebaea66a78@linaro.org>
 <20240324-x1e80100-display-refactor-connector-v4-1-e0ebaea66a78@linaro.org>
In-Reply-To: <20240324-x1e80100-display-refactor-connector-v4-1-e0ebaea66a78@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 24 Mar 2024 23:24:50 +0200
Message-ID: <CAA8EJppues54mPveOn7irCHYe+T4Fdv-=4ucLLpqq843NLBAfQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm/msm/dp: Add support for determining the eDP/DP
 mode from DT
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Johan Hovold <johan@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Mar 2024 at 20:57, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Instead of relying on different compatibles for eDP and DP, lookup
> the panel node in devicetree to figure out the connector type and
> then pass on that information to the PHY. External DP doesn't have
> a panel described in DT, therefore, assume it's eDP if panel node
> is present.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

