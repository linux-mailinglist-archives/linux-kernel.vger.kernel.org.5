Return-Path: <linux-kernel+bounces-122317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D440088F510
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF5429A61F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438702557F;
	Thu, 28 Mar 2024 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUXjQP+L"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A92374E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591484; cv=none; b=ahPpc0777j/tq9L/lc6dI+IWkM4t1NcRj/btlOzlnbna/FckRdhW/83vSgnqULuF1D0mczA0mUxe+WFpBpZhXYPlOKmPIHW4I3WQMGiYqLZH0bIRAf2cGO+ihRp2VemTLrwtrnMI4Ulwtb2Gtx9SR9waCdp0FzT+qdd1cfLY8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591484; c=relaxed/simple;
	bh=3NCbbj5xn90X5G6VZSrG+N1VxEQLBUw9gr86k1oD+Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbDgfdpe7SglhtDDsJ+/3vxPsftm9URlDOwP9VX3AxSRSiVfrDFe23D+KHMKg0D3XTDt+5tLyEMcGvK1pqxLSvapUqXekOSPj7bXmcfY2BYDrjxEwV/IJ9VeYC3iY5GZc3/WWlE3MQZi/wZhxDjLLuOo/B8jSH/dW8Y+jQrBRnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DUXjQP+L; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc742543119so484768276.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711591481; x=1712196281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zVHYpylsglag6Wy+DEl6Bru/prW2puMn84s0N+Ry6ck=;
        b=DUXjQP+Ls3vOoqOaKyB52cJ580T17Gko/OKSsGvSik9/47k223kt7F/0SA5r4XU1E5
         XFq9H18A73JizTSqDdIUL/ycBbm93dShRwYVeNGVgg0exT008SDbdv3AI7pRl1yywS/b
         7t/HWyfk6nRxLePI9DK15eZbvMVbi7a8k50Qe4oAhdZGykPclO8jKE3eWXl5WSxOjCHk
         Q5dIh3VGl1E+z4mXQIfZ3uSUCptDR7XObrbJBxtWT2Tit10zmbdVB7pd/vvkh7/qZWYg
         R35+qGVG5+ISHTtLIIMa6NKE0gPvO3a//V1VxcOH9Vvva9So8WGkPV0xeKm/TmZQ8n08
         EpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711591481; x=1712196281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVHYpylsglag6Wy+DEl6Bru/prW2puMn84s0N+Ry6ck=;
        b=o/FG+vLSqgfw0W0KQeSNMP6O6irzN0jN7NJUMtwUEmguP407PuX2ev+mjPhsLvQziS
         10Zma/BOoRWprWhLaiZnXcxRie1lwLs7pZ4DloQisHbkf6giWj/iUf6nxmP6k+OZKs/m
         ELxETNyduzYXq2Q7ad0L1XvT22X87pDxtciUaMzcqmW2MK72rw3A32uQxk/Dnoos4MB6
         tqxYUVFDhB8oSVdIFzOg5eWgR/8v1AZ59RmD9x+k5nCNgdwWhbenSgYkZEa5hseOdq8s
         FsEcr1gdKpu67kZganbc2qvuioyD4B5T5gcxzHF6giR5dxtdYejle20ipDwvqiL2rjW9
         tI+w==
X-Forwarded-Encrypted: i=1; AJvYcCV9uQuBXB5HCTK7oxBofWS9rwImgjGSr6vnsNRhhztIta4soximEYyP3d6GwONJPikqf2oMSwzchsfkpJSormhT0WIbYOrpUT8nKtVM
X-Gm-Message-State: AOJu0Yya2Nwz+Ve+jCXruezkJ/DNBtT3prWHMtL1C3nw7ghNFvNK9Wy5
	b2nEXWgNJn0nI5TdWphxxbDHMj9/ohQEyvyOk4mP5pYpDOmIunRaC9YdayDKe6OMYgzD7TdU240
	0H1BvI6n5du4BfC5yazUx1eIQlh5pdB3JIvFs1Q==
X-Google-Smtp-Source: AGHT+IEMEOiNmzcjIVfyBISY6ypkR+BXUwbdoR9cHIRSmCxLurIKHkRfl7A6TXu7BDInNFcPCbJB2Xc3QPy2qSKrmZU=
X-Received: by 2002:a25:2f85:0:b0:dc7:43fe:e124 with SMTP id
 v127-20020a252f85000000b00dc743fee124mr1563313ybv.11.1711591481669; Wed, 27
 Mar 2024 19:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com> <20240326-rb3gen2-dp-connector-v2-5-a9f1bc32ecaf@quicinc.com>
In-Reply-To: <20240326-rb3gen2-dp-connector-v2-5-a9f1bc32ecaf@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 28 Mar 2024 04:04:30 +0200
Message-ID: <CAA8EJpo31gFHeOtL4ANEuuou56UuDGNqAPE3Df-0GXOuJBk+KA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: qcs6490-rb3gen2: Enable USB
 Type-C display
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 04:04, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> With the ADSP remoteproc loaded pmic_glink can be introduced and
> together with the redriver wired up to provide role and orientation
> switching signals as well as USB Type-C display on the RB3gen2.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-By: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 107 ++++++++++++++++++++++++++-
>  1 file changed, 106 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

