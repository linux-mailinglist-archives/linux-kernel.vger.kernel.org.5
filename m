Return-Path: <linux-kernel+bounces-107311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583D787FAE4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B41B5B217A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73917CF29;
	Tue, 19 Mar 2024 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2TsQOCc"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B94C548F9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841077; cv=none; b=olVXOmVD8ZfcpC+lhefLavzxguJ3WXT1p/U2OhrT+96UQ/Mg3DHAQZGj7/g7Ze+T7UmFKnyjM1q8hLTiRaYExspEZtIyjsGAWMaAPDQylqr7aSa72ube+F5V9Y9KgWsSGxZzyDPV3bQ5v/xJabokR7JXXJCFh15zP6nXPIDQ9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841077; c=relaxed/simple;
	bh=NYqDOjc4VvlYMBZCPVKTsoR8LL5jTNNjdP6ZtbU+Yik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W61wGp7UHKOrFDTOvRtBIqCd1YDJ569seyqtaa+gteEC51Z+xoF9pN5lpAkkX/RV7voPCOpXUJrXSy7nSM0a2i/IjBerzYRmzwODWUFEo6N9LATSppVOBn76XeBi2uAKq8op+HkhlRHjMyPw3rK1dw6JO1Ki4FG9Zi4oVyaEsL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D2TsQOCc; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so4735127276.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710841074; x=1711445874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qrcvve1Iyn2xTwuhx9XNZ3GNMgVq51TYECbcvo0tzmU=;
        b=D2TsQOCccc6qlq2EKHKHkAYWNp4L8Lyh+XLjJFcsMxRMCW1s2s+MU6hzfcS6eM2yCs
         ZS2jbDTpINaPKHIFF6cg62aW03scB/GCqsU5xOub3egTn3pu28IFdcCqqkno+sT/adqU
         48RQlMvYt/lxXt/wR9WN1nRQEGdbjB600ykk26JnWZL2097lXTB/ToZFB2KRCO/4yuiD
         7oSWlMlmcRGkZ43uq2cwtzi82l7yGnorJK7rdG5kTadP5Y6CZISWkLzSLpGcPYnQsVvu
         PHjZMv2wwq6W+KphfQIGZ4guBUPWvpgz/9vqSmoKcoJ4UG/z7HGnBi8NMc7udeEDsXKQ
         Mm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841074; x=1711445874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrcvve1Iyn2xTwuhx9XNZ3GNMgVq51TYECbcvo0tzmU=;
        b=cXLgSnrmwKzDM/yVHVsv98Ni+QYrIesatQFvNCAc0Tx3c7XPhuj+Bpr5w8kgYq/CVF
         QBFqLPZFnLYKQh9PkB50wxlZwL7qm2JMsDWvGR2b5DVV/ql6LsnjiXOAsw4ifGmRjyyQ
         jRnvebasAwecVPMrFriGnj74heTz7gRLjw/hPFkooImNGKXoy2ToAXpzEKnus12SHAt/
         88JC30B3m+rEQTpOeluzZ8eSjyU794QDZNeOflvHvA9LUT6Zm4x1MoBrWHyRmvcIqd9w
         uRGXT5EcnEjx3Po6xgqdRCvuSLIxdwMxt+9pAS0r/gcsEMmCww83pGg6k63esjECYqpJ
         TK5A==
X-Forwarded-Encrypted: i=1; AJvYcCVUdH9V++6w7wlTUPOafn/fnRqYxtjIrHBRj78nTXMqbillNEmZ5CzbvdFSb47/0FVX7Z5ZgKAnJlNQI/pwLhEq/4hIrIeoq2C6px0E
X-Gm-Message-State: AOJu0Yz59EwGJFRZqnacdfDncuPuXNUsHeVRmdd8OmqPgKNhsXdSa7xp
	EszhEnQdtRwAxXYopPCgVFUFOG1LjLPdD/iXhtGWPHco9YBPJeF5jxJRSdyZy3hIUwXCJkfQxg3
	dk3STTcPRAcpdjfLb2II+zZNZxgjyhJVXLo+f3w==
X-Google-Smtp-Source: AGHT+IEjBNpw3ThkU3XrQNHH4xXZJm+TlabCx/A85tg6nsSrtiJltqJOY+O9RuAlTQao9NiQiRx91/ZqpNe8JkwaKpE=
X-Received: by 2002:a5b:6c7:0:b0:dc6:2e29:4262 with SMTP id
 r7-20020a5b06c7000000b00dc62e294262mr11631059ybq.58.1710841074354; Tue, 19
 Mar 2024 02:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319091020.15137-1-quic_kbajaj@quicinc.com>
In-Reply-To: <20240319091020.15137-1-quic_kbajaj@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Mar 2024 11:37:43 +0200
Message-ID: <CAA8EJppnDspUVf_feZnH2w6RY+8PDJ4CiKyDs5yxy7uofCPGCw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add devicetree support of USB for QDU/QRU1000
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 11:10, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> This series adds devicetree nodes to support interconnects and usb for qdu/qru1000.
> This is based on previously sent driver series[1].
> [1]
> https://lore.kernel.org/linux-arm-msm/20240319090729.14674-1-quic_kbajaj@quicinc.com/
>
> ------
> Changes in v2:
> * Changes qmpphy node name
> * Changes dr_mode to otg and added USB-B port USB role switch
> * Dropped maximum-speed property from usb dwc3 node
> * Link to v1: https://lore.kernel.org/linux-arm-msm/20240311120859.18489-1-quic_kbajaj@quicinc.com/

Same comment, please version your patches properly.

>
> Komal Bajaj (3):
>   arm64: dts: qcom: qdu1000: Add USB3 and PHY support
>   arm64: dts: qcom: qdu1000-idp: enable USB nodes
>   arm64: dts: qcom: qru1000-idp: enable USB nodes
>
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts |  65 +++++++++++
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi    | 133 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qru1000-idp.dts |  65 +++++++++++
>  3 files changed, 263 insertions(+)
>
> --
> 2.42.0
>
>


--
With best wishes
Dmitry

