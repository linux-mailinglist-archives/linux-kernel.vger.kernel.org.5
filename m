Return-Path: <linux-kernel+bounces-107434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5860187FC70
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892D61C22319
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25507CF03;
	Tue, 19 Mar 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="veDQULAd"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB67B3F6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845853; cv=none; b=ICmMS74YSuau+CI1mKNhG24ifAFHYVoA+GzoBJPlwP1ufQl528WEOjMKePvOgQ0+6z/kvsokTq8eMMGj7BOxIqrE8+py/2JmEbFwezx3vWibIAdyE/kqfetitrjlslc8GY53EcKTIOxRXsMxao4ih2G1JvAQTxISHhoL+mrSwsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845853; c=relaxed/simple;
	bh=oXXw/gvNDIJo+p7Uev78+xvyPYbmSnlXcb4iuAFBVEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLM13SV2sFlmYrUvWnQxPoUpuIJeIuUK7pIFwAx0xqNmEcbjgnaxSudVPTfrINQs1BfVR1Qvvu9pDRx6Y3EUYgYnjShxydNeLbWkLJ0YMil8vg2eKmjzc94wf1AJ9noW2AyzOQIj6UHlJVQ0oapbYL+TrgLRyQmE8Hn5JbsXCHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=veDQULAd; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60fff981e2aso32472257b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710845850; x=1711450650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yaXfKEvmsikpUYVhti7jBf+oIo1Ef/uGnjoHrgljhJg=;
        b=veDQULAdNOtVZIGkn18eWwa14pr66xdlRGkEsaoNPtUK5AfQKezy0fhHsQz8hB0Haf
         S/DLrdYzvLevzVUVBxTNG+0FWBc9R+0+xZgbfGVp6+XGlRw8tM4Fvv5n+GN0kp4AXKI+
         /Tj0V1bD4pGRqooP44qDuSDbWVcNa5J3XnYmAqrdM5cfdpjfMBxWxgq6lh1qM41IShGA
         8M96BRbxps3CfZ28gQ2+u4esPaKrJ/cLF6qiK8LyqyAhhKoag2ho/niY/2+Gh6k8X4r5
         Ja+U6YW+Nsm3eb2kxBRlGq1O2jiOiilG7w9WD0B3GiIa/TkdtEMbFwCzQcLmsmaUfaqB
         glfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710845850; x=1711450650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaXfKEvmsikpUYVhti7jBf+oIo1Ef/uGnjoHrgljhJg=;
        b=XhbzSbdADs8K40Fsp1MNk5Aa8HnwaYJoz5YW8wokx5jeIdtQWE4ijZXdfukFoamMUs
         T7HMnq13huBCz+noL4N6cDKxVRLKfnt7XihJ/tdAF1WkeJk3r0tiNDOPcoKQU38gcoO7
         DyGPL72xeKpo9jI5wfX+ex6gMZOCfyUkvmqJzF8yl1sQUUF4v3ZA7iZFXWKRhka5L0Ei
         LxVyDvMCtjy+JdnBN9gTN72RjH2T9oTi4rPtVm0J7JPtYh49L98oI7DhyFMPJTUCvAK0
         j3/3/+umFww1SbATU2Jhi04h1n/GxjA6/dS1x1d9kaIS/nSXWPuS1ZJBh18FHKFUlors
         trsw==
X-Forwarded-Encrypted: i=1; AJvYcCXj9fwv44VJiJTDLxeTIloull88kgRWHpMcDh3LoCK3jVxQx/QrFpDCg9vziRV4M28pul8zkFIFUO91rgRxCoPrmYvukA0g1KQBOfy4
X-Gm-Message-State: AOJu0Yzrxt+T9Hhl7Lz3qVzpjA3hvVxYxZ/B+a9uIo2iR65keDs8JLDC
	Z4hSMlSWixW0QAQpQMAIUkNZgSIu2pWaQMU+A/VXC7zoUlm4+KR6k9oxN4Smd3awGHopo44ZdLE
	rt8acdkYOsOM1Qvt8y4ClmYl+QQOf8aikdGEbGA==
X-Google-Smtp-Source: AGHT+IGqi7COQGg1nW1AorqoS0U2xxr33c95l/mHdFskUkowuQYfRthNAvwW4wT0aiSIUmSn5fPJUdBVgYXW4Pfrs+8=
X-Received: by 2002:a0d:c242:0:b0:609:e2c1:15d9 with SMTP id
 e63-20020a0dc242000000b00609e2c115d9mr12866447ywd.30.1710845850724; Tue, 19
 Mar 2024 03:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org>
 <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-4-926d7a4ccd80@linaro.org>
In-Reply-To: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-4-926d7a4ccd80@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Mar 2024 12:57:19 +0200
Message-ID: <CAA8EJprURpSEMkZKb1__bMhcXkKr-xyRzxFo0bOH=oiGYOSc_w@mail.gmail.com>
Subject: Re: [PATCH 4/7] phy: qcom: qmp-pcie: register PHY AUX clock for
 SM8[456]50 4x2 PCIe PHY
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 12:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock,
> enable this second clock by setting the proper 20MHz hardware rate in
> the Gen4x2 SM8[456]50 aux_clock_rate config fields.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

