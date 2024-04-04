Return-Path: <linux-kernel+bounces-132132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E94689900F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95321F25568
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20FF13C3DB;
	Thu,  4 Apr 2024 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhOkxfcu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DC513BC3B;
	Thu,  4 Apr 2024 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265798; cv=none; b=Vw/SlF9Aw5rbfCqrd/CQPv2XLdq6wJDXajR12TbJmJslQnluTJpXHenxk322+H4sK47t5WK4X7rOAd3qH8NJy8f2syVt6fzLg4K5OpkA7Ee8C8HGjG9T1tjd65CO2VPbLqRhj6DmpEmjvqw9+psw8rR+DV2y0+V7bvX89gAkaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265798; c=relaxed/simple;
	bh=t+/It7T5HPrpIhbaGRNtSL8Bttm77qOefVOqCt5n7ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3nM1penDePIri2KxL+ojpmreltlHh/c7AtHGne5J7uRplsrPIP4AnVK/Q1a02YQrdcZ35ugNxuISoJ+7LSlE1IvbfgnGgR0JPVy8GA+BSkQ7sjdawUbBgGXev4GqiKSmyeJfeHv/sFlQb9oKALOUihMa7RsN2yym8X7nCuvMhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhOkxfcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E03C433A6;
	Thu,  4 Apr 2024 21:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265797;
	bh=t+/It7T5HPrpIhbaGRNtSL8Bttm77qOefVOqCt5n7ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhOkxfcuR+UF5xwzBn8ks94pWGj6HIcrpL5eNYtMzUxivjYGdQoAKeTyNjpcOB4ae
	 I+pqZXM2t7+aukZap14xldlbW/RQKkrnb/elCoCIEnyqyLwTffyGNiXHqqNMdex03H
	 EjmahsKiWRl+7JQywTnZXEixf0YJmmjtX/fNY6q3RGGNNNMfJayT2dkpuouGooxUsP
	 piYjPTAkjdZRh0yc1/+yWEBzieqP4zpCAS9djXtL7qqf6udWA/vLJN2ODt5exU1UdA
	 ifivwF+Vwt1KO2tsVlwFT/eaW1ojoMc8Q2xd31E8HxRejSQLBNDnEsXwf2luXFE6Ui
	 oRt0Fa9Fwn7AQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [RESEND PATCH] arm64: defconfig: build ath12k as a module
Date: Thu,  4 Apr 2024 16:22:47 -0500
Message-ID: <171226578696.615813.5026299521033701255.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325085756.13843-1-brgl@bgdev.pl>
References: <20240325085756.13843-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 25 Mar 2024 09:57:56 +0100, Bartosz Golaszewski wrote:
> Qualcomm sm8550-qrd and sm8650-qrd boards have ath12k modules as part of
> their on-board WCN7850 WLAN/BT packages. Enable the relevant driver in
> defconfig.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: build ath12k as a module
      commit: 7b3ecb64f9ae7ceb0fe0a0cafc3eb2a91326c054

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

