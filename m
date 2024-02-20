Return-Path: <linux-kernel+bounces-73798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA2785CBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB361F22D23
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340C3154434;
	Tue, 20 Feb 2024 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PqcTSfZM"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BA1152E1A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470173; cv=none; b=MfbI1krxx5hvxTZ9UdbQG71jklI4Qjn5cxtFcEObvLT2ih0L6rmJbsk9KwcZkXWHGMuxlPwSmQf2LNU825xKqpskspbQb26NtGOf6+5HKD8amdptd7svoOi+cPAV7sryNSvx8gzSRGVZkeYWw7PG7Tcmve2Peo65lKwMNWSZZ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470173; c=relaxed/simple;
	bh=m46fDwrVuliqkw7A1TrIi7G/05Wqw+0w13j26+q3lUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Do5q1Kgme0Umdj9utMszDgEa/2YK6wuo3D/JJ7UrjDVnffY+PZVZKjdUTMQF7lOTzEUNjL2v1Oe+DEjfPqD2YKHJPlqNgDkdiofLjVGhyoaAcskcFe/gnBVd5FS43PEuCePNnEvB3ieRqHpXFcnc9zyRI0tDvDeH1NK/l7wbBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PqcTSfZM; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc742543119so4844105276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708470171; x=1709074971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h3xcc/5DqDQe+adCv6bnvAUmiBqc6BygI5OchyBvkgA=;
        b=PqcTSfZMCkfaHR6TSluKZw7tUFffVKCkyh4I9mr4o7V/vb/7DQUF4rLpPLnU2HXmf/
         JDYKWWbhb1Ht0mO2JTSKWFJO6HiVYphH5AKUDwQaEoVwP4PIZbb6SBDXlGjZ9QKH9pcR
         UBRqWUtS3wbbcXKCjVuOlpnOjTK2iwtoe2ml3xlSggt5BwFyqPoFQ6UWyCMpkT/S4jK6
         5BtTSDFZ07ElwyLxjxWYHvd4a6mF+vtVFKjbvnfT56uokOY+znXJuXxI+nudGtsg6cEX
         W3Uwhi/zA2XNOc/TRScFUfJaLU0Ver+HyK+IQKF+2610x8pDe/gasLP+KUS7SDOxVYsd
         l0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708470171; x=1709074971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3xcc/5DqDQe+adCv6bnvAUmiBqc6BygI5OchyBvkgA=;
        b=PuTaA4SQ1WnfGZvoqqOin4LmFk90KvfrEhlcs16MyGOytFftTkzJPwqCk6KWj3vU4X
         5rdCczbeoykgK73uFAHZQiIqQa/dVngotfW5xXdt2+WnNCHUx2tnfNtS4CErSSfAFbvY
         guEaVicMel3H5Bgi77UxmNzp7Z7Ae4uI39+oODQ5TMVyjBJKnqTwNp+N0K6fEx09CEAa
         CzEJTQBtkn/7X7rNhc2ZnS4zA30a2Z7XsxD4KhVFPnlpUgvs4tCDl2cZUGZx6lyr2kVy
         HXfnfrUMi4FE165S7TuYIazmB/k/+/zHQ7TGaDstsc4SOUZVrihSfpUlL+V4Od4f6oTg
         fAqw==
X-Forwarded-Encrypted: i=1; AJvYcCU+6jwmyqkepw85q5675EGXvu6m8FlfZWT3a9E5sK5uE13ciyDpHzBUVMtdFYXL8nHZc+mGbVM3WeCI+H78U9jETgyQd5J3bd+AUx7F
X-Gm-Message-State: AOJu0Yyiwj/70nJ4NZIlBONna5ADKVCIrnmlVoRyX3AM7SA/sSXcUA+V
	Tq8r4PNchDQvpFGWzdprTuJK7fDKTfT4z3LNCt43eJxzC7T5VG0LzQKv29y9bGkEMX4J1gyUA8t
	nGp6HjdvH/bgdsNgjvWfGI00Mtkz2d1HOJMJT4A==
X-Google-Smtp-Source: AGHT+IGOx/zC8gPSOJQuDPkSkd1nf4N2mE7xnUIZOVlkbUscpDxNFS5fOG+JiLkWkR6HldqnK+FvO6CDi/U96xWLW4E=
X-Received: by 2002:a25:ab08:0:b0:dcc:ca51:c2e1 with SMTP id
 u8-20020a25ab08000000b00dccca51c2e1mr13283832ybi.2.1708470170970; Tue, 20 Feb
 2024 15:02:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-x1e80100-display-refactor-connector-v1-0-86c0e1ebd5ec@linaro.org>
 <20240221-x1e80100-display-refactor-connector-v1-3-86c0e1ebd5ec@linaro.org>
In-Reply-To: <20240221-x1e80100-display-refactor-connector-v1-3-86c0e1ebd5ec@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 21 Feb 2024 01:02:39 +0200
Message-ID: <CAA8EJpqSw5N5=Ki9Y7n5Dr2Ytxboa4u_d+a02Wicp=QpCNyiUA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] drm/msm/dp: Add support for the X1E80100
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

On Wed, 21 Feb 2024 at 00:50, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Add the X1E80100 DP descs and compatible. This platform will be using
> a single compatible for both eDP and DP mode. The actual mode will
> be set in devicetree via is-edp flag.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

