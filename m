Return-Path: <linux-kernel+bounces-161144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E345C8B4795
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CBC1C20C1A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A40E145340;
	Sat, 27 Apr 2024 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jicme8nW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83516143860;
	Sat, 27 Apr 2024 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714246467; cv=none; b=cMRBP1EiN2uXS0EFPzq1V0pWwqHFXvsQOnNNEciLJwNUsK1hAsK0YtlwqsiyWlZT5cP4wYc2t6oJ6yyQAcYx6dvInuwBJTpf2oCbZuX4nzeEuCFgE9le+jU0fB7bQuSaDHHVKhRObLjgKscnDtXzmKxoe0N94AuBW1ngMV23pK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714246467; c=relaxed/simple;
	bh=8iVoAC1qCYImhMA9YuY0ERgdl4jwsChEMTlNu/0MrQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNhjwzngEQH94BHMzYd+Z4l2d7AFwtOIvTUw+Ac5Yxg3qM2zes+PRLlvU9xCfrhUQvbgBnbFPeNXymJcmp9Mz5lzK2OTwYr3JpTORjbdjV6svOrWUKyaf/2dHYAXR8/KjsyrfLPEcGd4yDnDNsQ/hjCj4rvZ+75/7Z5rYco5uiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jicme8nW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE84C113CE;
	Sat, 27 Apr 2024 19:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714246467;
	bh=8iVoAC1qCYImhMA9YuY0ERgdl4jwsChEMTlNu/0MrQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jicme8nWgm/BfwPxJ1GfzE+LuqTcLU355KFxmdw0fc8f+IO/GDo/ix6AhSqwFySAz
	 Ui+lVEuGkydX7EbSl4ZZprk/ojIcSEHVmn8WlOk47G8baw4S0QdVMMhQlAbnFVKISf
	 NBtP8SNqJkpT3fb8eV0F15lci3kkndXcscgP5Rd56t1Onr7u1oRlKAbrvq/vCJ0b5W
	 7gzxyEnHB3uy9jtrgnAESFr0wrj64tDY9qP2/N8VnT+vDD83z8P4d7J5LhOkY6Paqj
	 gTruo9OJbbuJ02EsqdKlenrPb6PeqgPRZ7My8zRZWqJJeqmMhJkGNpYwLgbAtiPZf+
	 b5dt1LeSkCoNg==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2 0/4] clk: qcom: dispcc: fix DisplayPort link clocks
Date: Sat, 27 Apr 2024 14:34:16 -0500
Message-ID: <171424646120.1448451.8800126789996663688.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424-dispcc-dp-clocks-v2-0-b44038f3fa96@linaro.org>
References: <20240424-dispcc-dp-clocks-v2-0-b44038f3fa96@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 24 Apr 2024 04:39:28 +0300, Dmitry Baryshkov wrote:
> On several Qualcomm platforms DisplayPort link clocks used incorrect
> frequency tables. Drop frequency tables and use clk_byte2_ops instead of
> clk_rcg2_ops.
> 
> Note, this was tested on SM8450 only and then extended to other
> platforms.
> 
> [...]

Applied, thanks!

[1/4] clk: qcom: dispcc-sm8450: fix DisplayPort clocks
      commit: e801038a02ce1e8c652a0b668dd233a4ee48aeb7
[2/4] clk: qcom: dispcc-sm6350: fix DisplayPort clocks
      commit: 1113501cfb46d5c0eb960f0a8a9f6c0f91dc6fb6
[3/4] clk: qcom: dispcc-sm8550: fix DisplayPort clocks
      commit: e90b5139da8465a15c3820b4b67ca9468dce93b4
[4/4] clk: qcom: dispcc-sm8650: fix DisplayPort clocks
      commit: 615a292ee4d51303246278f3fa33cc38700fe00e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

