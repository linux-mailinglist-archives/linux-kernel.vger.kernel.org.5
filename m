Return-Path: <linux-kernel+bounces-71527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BCE85A6AB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2F31C212A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A236381AA;
	Mon, 19 Feb 2024 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lGk0kNmg"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DECC37704
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354656; cv=none; b=YywQF3jTVGmHypkZ0PCcwczf70CUvRrG5ubPdXOVfoxPucnkDJvppP6LVtJ64DE/yNCMRrBdLmUjqAuRN/JQkEaue4S6q7mfE/eJTt9sSj870GavDHrz8WTzIUtdrWStFf9KV9xN52bGvo89k8YxbCNga1XU+XRwRvQEklVuydA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354656; c=relaxed/simple;
	bh=9Na3wL8jpMpPVnEcaEj/4baqNdNNRN6TgavHTXFRdNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FK5O8QFln5zy5RABPvPozknI4i188WkEPWxbw++psZkq45sOdUarxoexeoD0iZVdtbuqQETvPyzPSoUpvmrxMDHQIfEjru7e8pg/5yQnAHKAlW8XtRjLrTkmx4WIOPmPxFejojyjsB645vd7D48nY0rasYyeM/XJskEvljXZLFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lGk0kNmg; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60822b444c9so8071077b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708354654; x=1708959454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Szw+QTMnTAcQAZlNeYyyrJj6KbWZ+5DPKy/5tGrWbDo=;
        b=lGk0kNmg/HCwE8qj0FfX0zUNkQtmcJPtsHPfHE3hP1j8GVWuHsHZrY5nYfxr4/WfUv
         niH4xUAwp/aiGKd8ECXeBkF73xsEThstkzGwYcwPCxvNK/c5MgVMvl3I6stqGGZk4hir
         mZxvPMIhLLO+evQRa94UGcqjMsUBiz4jFAcg9Lyr36hDA2R0kplRxAe1BdRjVkTDmH1Z
         cEkeyinC1Qeuz0Wr3cs3Hy40A77LOSx1HjzdueBI+CotM1iHZ0PLcXSul8QE6PTR7iqt
         NZE0VRkum6DsDef6Q6JpSn9fiN7Q7svPZw7ZjAf1QhzuMhCRRpWI82NVDDx5GVmOs9sA
         jUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708354654; x=1708959454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Szw+QTMnTAcQAZlNeYyyrJj6KbWZ+5DPKy/5tGrWbDo=;
        b=DSAtnsAGS7UtjN609sVLvvL3uiS3YW4F4jVkctrut+xT0ghUZq3O8/fi8Uts/rFvMl
         8e5yhrHgp13Xxv3UCM4qos2SswHcJ9BbdjIKKNUIDwzHlctULcNjzN7kwShicMU3c8XX
         Ok8PLXSWxzw6KR27s5K4hpLQvuxSb7n3uQ0Y5mkQjPEIvgCFtWkYxnkUz0Z2pjmQu5QO
         o7yKb2zD6g3byjxx4ipzZmNENzGITkXHN47Vj5iejs6zwFjhn5c54dNXp8DJplWsXuNW
         STN0+2Ouo9J8Q6XRzVnZnNQImk8OZ+AAwhJRyKcq1ogCWhMqiZtswFT57nWFd9tkBehE
         ncmA==
X-Forwarded-Encrypted: i=1; AJvYcCXwYO97Zs/ucZhBt3TugEGKupW5aOrgd7nSqaUmVuWa60hPAUWqfFG3TSHMjOhJukB9GHLueyQ5Dk6Lpz0TnXZ9RQMnFI/UxinN+4Qp
X-Gm-Message-State: AOJu0YwcqWZL0WGttCwuu2p0W8/HlYOkEsU62ebQFKoa4f34odhyHdlo
	zF7rZ4fsW7p4ISFx9zFpWzidvRbZt/56ntKYVTPAJsXIuk6VvK2D/D01xW+3HviRPwSCh1ExCyL
	eDRo8JrhFGXxCFBGhf4f3rxYJbzIdUP/placx4g==
X-Google-Smtp-Source: AGHT+IFwS+iE/0NQYgsx7qVKwDMppWGjVew2/XzNi/ojh9QbxDe0oOmgCSu0UPBrXtjFjsGyUMyo5ZWdgudhKw5Ujrs=
X-Received: by 2002:a81:490e:0:b0:608:ba5:729d with SMTP id
 w14-20020a81490e000000b006080ba5729dmr6119664ywa.19.1708354653839; Mon, 19
 Feb 2024 06:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org> <20240219-topic-rb1_gpu-v1-7-d260fa854707@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v1-7-d260fa854707@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 16:57:23 +0200
Message-ID: <CAA8EJprpZxCV-3xkE0OuGg4jHrHcb=EPKCi_wSy5viP7jVwPvg@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: dts: qcom: qcm2290: Add GPU nodes
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 15:36, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Describe the GPU hardware on the QCM2290.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 154 ++++++++++++++++++++++++++++++++++
>  1 file changed, 154 insertions(+)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

