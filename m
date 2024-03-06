Return-Path: <linux-kernel+bounces-94060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61438873941
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930781C223DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057AA1339A6;
	Wed,  6 Mar 2024 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PSkA855X"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1576131759
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735644; cv=none; b=bcLdtIdgAU7DX0ZWE7wCCtdhILAhLmYzA2mMW5B/6UL0xAEjFd7H5+BmXlKzEe0OZq7G6QGLwgYm9L7kfrrCkxf9GKK2F+T6Nh2yz2ss32zk3BVLdNpXcrknejqcVyaI0MdwmM+O6S4pmdCDTsZusO4hUrw3qvqvoPjcZCAr3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735644; c=relaxed/simple;
	bh=8tF4zD/DoI86F4TEW60dAFkd+rSLr7rAvtLQ/qAsILk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yqv6VuV1dWZ+M+Plb6Yur46xiaV0R64CXqOWjvmA4VZ+sI84aQAfu14ulFJQdZ+RFG56+BOhYjZhLV0Xb2+S68l45dXysxSxx0Hv7XMLyHE2VxNn4zJdzsJtk3tRzDP7BfPo3NNvwfmYtELuvATEaK0L2ODKDLc2+tKD//iZ0yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PSkA855X; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6098bf69909so8736237b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 06:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709735641; x=1710340441; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5tl54IW/dapOkOzvX7dqtIh+kMyPuZW30xDY6G/Oi0o=;
        b=PSkA855XL4A0GL67pXZ4S/KbAGXYnAg/I7O5FqXn1opXfPhgZD9Cw0WhPe4fIH28QH
         OcovXW42kkwbIVnKiJfTi7HGp8rwKZe1wSLeGjfsmjI51TYkYoMMYURZ8bI89b9xIC/K
         Y+IeHl3LwALxiI+7sUwRxnCUZu9H2tHjsBfEyfDCQAdbnhNI/SWEGEn0Am1eGrUjdN76
         er2VaoMSfL5FrpkPFCGmYYECSqE9wprniwDh2P0Ni+HzIpnLoSdrj44YfAzMz3VcroB0
         29Q25Ats+5+9ZjZ00/+i6X/mdzga4WnLtSJYTvuAhX4/ECUqT1Kot4NE5vX8Zu6xQHCq
         eqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709735641; x=1710340441;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tl54IW/dapOkOzvX7dqtIh+kMyPuZW30xDY6G/Oi0o=;
        b=hVDP0IOuQ53vrl6Hlw9ir0/ARaJhlQQ37bewduNniEhAax2RYO/Yuw2kI+CXDZul7h
         zQWnXmb/t+GdHhHDL0UcO0+vTDYF/Ij068FnHHc8y6C0ewxZF770VptJxKgfDhwlF9Cf
         jAnfz0FRUiLTow0MIPnqhxXgCSHgeENbLb4cjfYG7r0RB6ThGjsY8RtkpOdF/HneS/PC
         WMmiVE/K/m/5u9TPBT+p0vAP9A8gMZKsWjRi0X0rj+AjG/XPVKyWB+jC0xxjq2dMfnm/
         lYm2SgnvP1bT870Qm+4PVb+0uhGdBn1HiGYGkLHbaY++m+wfokppjsJfRDgXS0OLD+CV
         1zSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT0NgVOaRhAH0ZZ4rtVPu1sztt0fPOj7rr/WPJQjTLDJXdHbnjLqWAGwiEIfx02+LGfTN7tdGRnXbaP/hDNgNvxg8fJRX+60lPCiWC
X-Gm-Message-State: AOJu0YwfGCYtZFW0D4+hpGYdONXf/1A7WchA/M6m+ZmTnSbkNzafU/g0
	DdKLdDduCCs5dMGglCYAjTLX5aRDOohZNfB787synWyGlBTbW1G3TZKJhgDKxzRlLYEBZsboEWk
	9T29EVH7fwNF+m7nGS8BLh4DZt2q0QalIo9jKPQ==
X-Google-Smtp-Source: AGHT+IG4i73vV9M5abPrhNjNK5qY0fZKQ4WxRD7jBvhda00ztOvVyjpmvTLYxgEXds3PfBdMC0x8iFWhYyA8g+/tSyI=
X-Received: by 2002:a81:c809:0:b0:609:e710:3a32 with SMTP id
 n9-20020a81c809000000b00609e7103a32mr39066ywi.12.1709735641619; Wed, 06 Mar
 2024 06:34:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306140306.876188-1-amadeus@jmu.edu.cn> <20240306140306.876188-2-amadeus@jmu.edu.cn>
In-Reply-To: <20240306140306.876188-2-amadeus@jmu.edu.cn>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 6 Mar 2024 16:33:50 +0200
Message-ID: <CAA8EJpreeGWfstEKEFiHM_RJCZbYYdo0H=fY0GqPPtZM-7ZUhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: ipq6018: add 1.2GHz CPU Frequency
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 16:04, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>
> Some IPQ6000 SoCs have CPU frequencies up to 1.2GHz,
> so add this frequency.

How is it "some"? You are enabling this opp for all IPQ6000 SoC instances.

>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)



-- 
With best wishes
Dmitry

