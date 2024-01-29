Return-Path: <linux-kernel+bounces-42988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775468409BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193951F23682
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432A0153BD8;
	Mon, 29 Jan 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGfEJkf5"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996DE153BCD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541619; cv=none; b=e+Ma4/opdtmEog9T9OtW1P8jLnEGg5YVw0wUZt0E/J/j9+lycP5HD/QMK8dFP9C25gi+sXNraAXsNrTzw68MYAiIgbbyFevgLEd8kJ3GA+Q8eEZrjK2cCxrToEroMJ5SBCjdQUuJpbB+HuIT4bcdFIri96D1KQWok9TwxwKGR+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541619; c=relaxed/simple;
	bh=mU6e8uETmKPJ2827KqRKhqi6FjqcNSn7r6FAsSfjeWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGVfRf4iMvdMgvDcF4eiZ7U1Gfq7ZN1pT/R4sTFAPl7O05d7sYdrhpbRsAPhGcPf8s0uCj2gXAzPHuJ3ixcJYqEDj+fH1yt6X91HCZuXarZUCNsXJphjO8IjShea+QEAIHmo8JmzI1csc3OuyVo29PSvJFWhIqvsLDOF6yQBXEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pGfEJkf5; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc68150f46fso916648276.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706541615; x=1707146415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HM4oKJKjaECYklXiQu+oSrVSN78CLNrHNPBMMaAeH+4=;
        b=pGfEJkf5c2ftFG2ZZ0u28kbFvmZnzbn/tBpWlCHDogxAOpzOeZK/hXpCkUffOsfjvI
         FY+SGWkQHGGNFO/TVnm4oNXxgMP1wZmEQ0MRfhj+EbFeU7TpdRc7z+Kx4es2TSPrxzxF
         hhcXoVuI4Kvv1ZFDRsowXtaccnC4stHGIaU+GbeMXArjQhrOMr2NxtupBSBjEb/4wiJj
         +lSfGncVWu+tyX//o9TrR5lMzPGzXkcCOaT0za9KGyZ/NDCR6S/2R0PegWMUX5U/JUhm
         uGTHcWK8yKDWVrO9dVaImKkBqtnCCxM5q4c0YR0FptTjLuaUbfxoq/ctI4GfhxHnKCzX
         mjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706541615; x=1707146415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HM4oKJKjaECYklXiQu+oSrVSN78CLNrHNPBMMaAeH+4=;
        b=SRTPCDYn69g2p51XBpIBmDQ8s8+VajpO6OzlyG9d3NEYN+/0EtmBITxu4eb7HDmuKh
         Ysu3xA1ti2IA3+vYL1fc11iqb1XC+ZkwngdPNhqeMyxBr8k8VNSgWMc+QtPC49ta7S/w
         I72JYT5P8eQheir779cZ4tPm0dgTIXbLnVp2r+HON9lSJTmYW3Wf7oBzBIp8hGies7fB
         mBzRP8Bm4xaNHQP0+OSWoqGbybEkRUMXxDwBYJ6ak4SRpEWwA/3jRKS96VTR9Vyw0fJM
         3IlurTv1uI6sWfZUKjSJV1lug4CCj2q/2wKmo62+XOY0bcYWZVoezu6f93D/LfGwmFML
         V8Eg==
X-Gm-Message-State: AOJu0YxnPfEHHvHy9l3x/8V/5L8tA6NhOih8K4U0oluOU4AjzUVoc4MZ
	O6m+zO+VP9ZfKSM1V6n8feD/M0tZTjtIB/Ro62W2g2Lhz/ZZZDYNTSJm4HBO03YulHm3df03Idd
	ID979K8M2fySv3pnOysZiFVVLZVKUJifcX/SWCA==
X-Google-Smtp-Source: AGHT+IH/kSP17UuZbT0esTyo8sAM9ro7kxiy0XA20jRmTGGdm4q9oJTvHL7EujRbD/wQpB+sQQrHiodPITjmHdSrDkg=
X-Received: by 2002:a05:6902:2681:b0:dc2:2654:513e with SMTP id
 dx1-20020a056902268100b00dc22654513emr4555425ybb.53.1706541615698; Mon, 29
 Jan 2024 07:20:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129-x1e80100-remoteproc-v1-0-15d21ef58a4b@linaro.org> <20240129-x1e80100-remoteproc-v1-2-15d21ef58a4b@linaro.org>
In-Reply-To: <20240129-x1e80100-remoteproc-v1-2-15d21ef58a4b@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Jan 2024 17:20:04 +0200
Message-ID: <CAA8EJpo0Bmu-=KHhEiFAJXC7CwxoWpT2FB+Y0aSiskkfz_1EUg@mail.gmail.com>
Subject: Re: [PATCH 2/3] remoteproc: qcom_q6v5_pas: Add support for X1E80100 ADSP/CDSP
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sibi Sankar <quic_sibis@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 15:35, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> From: Sibi Sankar <quic_sibis@quicinc.com>
>
> Add support for PIL loading on ADSP and CDSP on X1E80100 SoCs.
>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 41 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

