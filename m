Return-Path: <linux-kernel+bounces-60147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761FA8500BD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115E9289ECC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCA638F88;
	Fri,  9 Feb 2024 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXeEL+c5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D935681;
	Fri,  9 Feb 2024 23:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707521146; cv=none; b=o5ZvjxZY6IZzI0mJCP5R6xMOWrJ5yutZc8/ztQ0mN6CUpneL/RQ5JQcLZ9u6xjRVWgE2gTe7575qI/YrZ0BbfBA9x6KDbv+N0pHEDkzOncPzJVoTfWEcERq4BHqLdsmYmf2zTwKX3iefi/BibQf7dyDHHy7Dov6pOG1nbxyDkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707521146; c=relaxed/simple;
	bh=YjYh59NyNLxveT0n0gaRWjC/sGWqJ+ue3luZIoGiKRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maDPapL8jjBILLRtu5UQFd0BB4oz7qDCv2n4EtJYUQrKvVLHYFpgGauLAcvU5BrXymRxXyxiSnEWk9hdP8ZbxHm2w0TR/yfEgLCO5Yj1E3HFDMBRww3tzQeDiArA8pCt8qKchsUbJZzoeLFBThBWY9E92AZqqVtNpUeFIfQJuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXeEL+c5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7819C433F1;
	Fri,  9 Feb 2024 23:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707521145;
	bh=YjYh59NyNLxveT0n0gaRWjC/sGWqJ+ue3luZIoGiKRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXeEL+c5vf/2DhtylAwKH1BL0K9ClK7yeu2THpNuOc05fAePm+YMsYcDdWq0Z/TP8
	 2zMEexxPMuqEj2pZDV21BlFw6m0z77fnRcxWEuoX52Idul84eXrbugHG7M0mMecYon
	 6J7eCQsNUTUbY58XMJ30DFOj6IgFrN4dNEWM0dYcohtWUROGMl/3mjJ8ko+VzmTXFT
	 hZLgOhTC//PxtJvQIYxlbC6pjqWptx3+puBTIN4lcL9MdZ5KidX6hG+gv1n2McE0aM
	 vKzJinGmdgIPz1DGn3dHmy3zx+zXl1EGgbHGF+7+X79oUi2PebJ9LWZvPBTZn2FtKh
	 6PveylI/ptk4g==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: Re: (subset) [PATCH v3 0/6] usb: typec: qcom-pmic-typec: enable support for PMI632 PMIC
Date: Fri,  9 Feb 2024 17:25:41 -0600
Message-ID: <170752113829.579753.17045888138787272852.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130-pmi632-typec-v3-0-b05fe44f0a51@linaro.org>
References: <20240130-pmi632-typec-v3-0-b05fe44f0a51@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 30 Jan 2024 21:32:53 +0200, Dmitry Baryshkov wrote:
> The Qualcomm PMI632 PMIC (found on Qualcomm Robotics RB2 platform)
> doesn't support USB Power Delivery. However this PMIC still supports
> handling of the Type-C port (orientation detection, etc). Reuse exiting
> qcom-pmic-typec driver to support Type-C related functionality of this
> PMIC. Use this to enable USB-C connector support on the RB2 platform.
> 
> 
> [...]

Applied, thanks!

[4/6] arm64: dts: qcom: pmi632: define USB-C related blocks
      commit: f69b3e40f46e8cf568809eb05a2e07bfea45b672
[5/6] arm64: dts: qcom: sm6115: drop pipe clock selection
      commit: 7e3a1f6470f7243c81156d2ead60f87da1184225
[6/6] arm64: dts: qcom: qrb4210-rb2: enable USB-C port handling
      commit: a06a2f12f9e2fa9628a942efd916cf388b19c6ce

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

