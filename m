Return-Path: <linux-kernel+bounces-134216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040F689AF19
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BEC628144B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A845C10A22;
	Sun,  7 Apr 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjvdKdRp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31E610795;
	Sun,  7 Apr 2024 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712474485; cv=none; b=X8pDz4tdRwenruakVsAi7GLKFLOK41vKO9Noz93Etxu23ANdwnzHeLvr4epRR9cJrmYNG9KrCGNngGz+FOGPe5KvwiwWUOU+YOkqT+Ue92N7VTc2Kw3xzM/Yxjjrn0Dc9Y8Qjb9q+9ImKl+JtLB2nCsoGEZnW724QTF3rgm4lp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712474485; c=relaxed/simple;
	bh=tph3+lKvTIUbkttbE7aDjD1u5DS+286zExnPJ//j268=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OBgfRoOj+Sn/nKa+vo+pKRsVwtq2Q9mcwnJlHGSJonnkCb5kWwbABDvKSIqa/O5gRCqPMKXOmcTpOJDwavs2hdivsxeY2aBbyZ0G9pAhZV9/OMW7lPdKuetJXj/ufm622VuJ9FDZz5aLbRbbhPBjH3dpOvj06Gh7bb9K8iyrexk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjvdKdRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9F4C433F1;
	Sun,  7 Apr 2024 07:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712474484;
	bh=tph3+lKvTIUbkttbE7aDjD1u5DS+286zExnPJ//j268=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FjvdKdRp9o11+I1IP+QEuRz/CEJ/x85LYg3c6XcRkkOo3ajs2FqLtpe3+lf8ife2L
	 Vuau5xPvgQGAwxikfPKfYXam4KoZMdPxGrO7cljirliaEuzu4IDkeShcTvpc8A/+MQ
	 q2YOdClUBeEu02fCSP479qwrJc/IVK3yyvdGgQ09tTyYMBDJMF+KUs3L622TFz3p0w
	 FOS2nHG79FrRiAnPX/Sg5ff8ICjOumEfHCZVaiBTxfik9JeYuBCertspTRWRARvaj7
	 2tLHYHu+3HYKgoyL6vBHE3sqb/7jvtfw2BQ+W2C1sjDDvUeqaxdTWgn9elzxQ0lJeF
	 1I5UZ0333rnSg==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240220-phy-qcom-m31-regulator-fix-v1-1-7675b4a916b3@gmail.com>
References: <20240220-phy-qcom-m31-regulator-fix-v1-1-7675b4a916b3@gmail.com>
Subject: Re: [PATCH] phy: qcom: m31: match requested regulator name with dt
 schema
Message-Id: <171247448113.375090.4211885215588548227.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 12:51:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 20 Feb 2024 20:13:47 +0100, Gabor Juhos wrote:
> According to the 'qcom,ipq5332-usb-hsphy.yaml' schema, the 5V
> supply regulator must be defined via the 'vdd-supply' property.
> The driver however requests for the 'vdda-phy' regulator which
> results in the following message when the driver is probed on
> a IPQ5018 based board with a device tree matching to the schema:
> 
>   qcom-m31usb-phy 5b000.phy: supply vdda-phy not found, using dummy regulator
>   qcom-m31usb-phy 5b000.phy: Registered M31 USB phy
> 
> [...]

Applied, thanks!

[1/1] phy: qcom: m31: match requested regulator name with dt schema
      commit: 47b3e2f3914ae5e8d9025d65ae5cffcbb54bc9c3

Best regards,
-- 
~Vinod



