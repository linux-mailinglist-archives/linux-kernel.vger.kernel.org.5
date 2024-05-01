Return-Path: <linux-kernel+bounces-164891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6948B8491
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BCC4B2224F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42052E822;
	Wed,  1 May 2024 04:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SoZqnvTU"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB2922F19
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 04:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536197; cv=none; b=k8P8FMfsrAnJGsR+J4Wn2FqCBZo9RkcTA6ALnnLkNd/PDLZUD9c9WeiJtGUYIaVcZqQm6eP7YRlLI+RrJ51pTDEKqDYWFlpM9AnGOU3796GTc/L3sd+Lb30VblI39bXJO8dr4wgAh/x9NXXfLaFph+jbNeRlXuDyw1x/YYusa8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536197; c=relaxed/simple;
	bh=0+M3w/Rwyk4DELz4Y5UB8syWUFAjVBlsGq8zhTnbPhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOcy23gYT/udDzBWPn5SK8uMTEb4m81afRadjXYyOiKWP8Aq/rsJOth3Qw4SH9QBA6v3uoaeoT/b5wvKHNeA+3M7fPniZaINSQSidUy+MBqcn4RpuPl6e3eOuvlUzkJUrFh33b6HZs5c2+XOHMiwUe7LhxfI9Lati3tbLzf5wH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SoZqnvTU; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de46da8ced2so7356549276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714536193; x=1715140993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9DhpvDZ5jjadT8noMpFkM2fayukKhN/HBsuXQwKC1aE=;
        b=SoZqnvTUIiYNfv7DcSmd5Ks5kDM/M4mpMFJx5eZnb9LO+Xv/6a/lTUYRjMICg5pzgZ
         UhNAQI4SOAB7BMTCW6mRa7bBWZlozoUOZRm5tA7DiUeU1xycoNshtzW+V2BIa4Fta210
         pcmMJiHP2mE6EtOgoDPafB97aqoc3JfejIlNYOZW2j5I1LZCP5pTTyTRc0SbfoWMQBkm
         igpwtzZJjc7T312rV4oDxzeRVSdP+44jl74OyosEm4vSFo3+3sTFyodStkPORN6J9bRi
         78CeObMJH2E72jnhnO/cxklQaEAzmXAlSbNTmRXh4VZoGRqzrrUmqQb6g0liyldivUeb
         EQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536193; x=1715140993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DhpvDZ5jjadT8noMpFkM2fayukKhN/HBsuXQwKC1aE=;
        b=tO/RBt1D0PtZBRUtEBj5eziivghqO3D2EX/t7nqt9xdo/VkYZ7zb+O6P0J9i5DmRMe
         +WgBIQsksXUiBfumWSI/1GSbbNt2gO+MpvtQz1qcIlzQJceL2qZ8XYEz9p7yEQQpHphw
         8/0GRofi3yWCubf9B6LLe8EP744x56g5WukC9qR3VlVgB07D4Laa5xgsH9udRd4CnB+B
         m+KPqq0t5FeSJacnp2c9ZD6z08Br2WdiBOShSUKzryEgNuOhSv9huXLMZ77v1qSEaBrX
         ZMpISMtwi2f0fF8iQCwFQj7q37hFVIPTvnmbealCwKPAT8CRBX78+G0Vxyit0QLGJ4Ol
         +msQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTl8ICN+UP4PxeRGO/RmE/UFE9b12b9k+YapuFDhjbnFS69/0FdqA1xRam0t3FydrkQLrb1ninOJpOFpBHC0UW+mqVGfS11fuxlLe3
X-Gm-Message-State: AOJu0Yxy7fM1v6M6q2y/yKDR325nxx9wsu/3HO/Xh+MO36AWzNEkEJ/8
	pK797mXvwWdf6uUCz1SrRJF9R41URp4tfem2Tb852P6a42jkRQeEIMFRE2k0jzfhr74wsJzBQgp
	RVkoYB3KwxIOttyqzKYkuqZ3q/8u8cv6fdHes6A==
X-Google-Smtp-Source: AGHT+IEGmYS844ras2vuIxsxIBNOQ1+l1V9qZ5I70U0Evly0QhJPSvITaLgH0CkbsmoeSFaLZQ0T85hDGtcJVIBKVCU=
X-Received: by 2002:a25:bcc5:0:b0:de6:1245:c3d5 with SMTP id
 l5-20020a25bcc5000000b00de61245c3d5mr1472680ybm.60.1714536193411; Tue, 30 Apr
 2024 21:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430-pmic-glink-sleep-while-atomic-v1-1-88fb493e8545@quicinc.com>
In-Reply-To: <20240430-pmic-glink-sleep-while-atomic-v1-1-88fb493e8545@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 1 May 2024 07:03:02 +0300
Message-ID: <CAA8EJpqRp2-V4-zTX=52yoC8oJN4kgXb0cQJw-c08rQnfpycmw@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: pmic_glink: Make client-lock non-sleeping
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Mukesh Ojha <quic_mojha@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 May 2024 at 06:33, Bjorn Andersson <andersson@kernel.org> wrote:
>
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
>
> The recently introduced commit '635ce0db8956 ("soc: qcom: pmic_glink:
> don't traverse clients list without a lock")' ensured that the clients
> list is not modified while traversed.
>
> But the callback is made from the GLINK IRQ handler and as such this
> mutual exclusion can not be provided by a (sleepable) mutex.
>
> Replace the mutex with a spinlock.
>
> Fixes: 635ce0db8956 ("soc: qcom: pmic_glink: don't traverse clients list without a lock")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/soc/qcom/pmic_glink.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

