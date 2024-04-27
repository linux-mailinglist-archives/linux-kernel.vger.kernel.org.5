Return-Path: <linux-kernel+bounces-161145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF768B4798
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57AEF1F21974
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF353145FE2;
	Sat, 27 Apr 2024 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0t8HVB5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319EB144D37;
	Sat, 27 Apr 2024 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714246468; cv=none; b=PxTP3x+e14qc2KJ1wEPiFRMcQyoLrrPm0pICO+RzEiT+M8jqoFmhcF8ZjW3jxtnpK5Wu24KFCJNzLBDpmUFUoNgnyS5UmXFCp1hS+gblCOWsn7PrBCJzOuPLd9i8KDfRKH52uyjTZZxABUDyLaGFHBixe2GaevWE5pF9v5Mh6gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714246468; c=relaxed/simple;
	bh=ojOLVLQdFckmVre0tt4xgD6bgpmgSeIHiv7uT3UvGZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daN2UCJoojAWrFISuySVu9XEicFtdXVVfUllvz6VM9CcQt+xuAEjgwNLHWKT5tX6dFFuBv944g/Nu/dubYJXcavreah38imLDlWvpoWB8gmUHRugZUl4swEwiNOVzNxGwW8KH3B7DKG3bygXNgHBWK4HGNDXd1WDBDfKN+a8DM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0t8HVB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF92C4AF0E;
	Sat, 27 Apr 2024 19:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714246468;
	bh=ojOLVLQdFckmVre0tt4xgD6bgpmgSeIHiv7uT3UvGZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0t8HVB5UZrBEv6aegouN+92Z7LLK1cBR2YzCOLTTi7XfU+uf8DmF72eRNKmCUXpN
	 VBIAa1OUZflz03yVGKIcsNm/7/AgMRCY+yuTv0VXk2XqTqXbnTz1zKgzsEJMqU1S/n
	 ZtyfeEg6Tzgds47+AS8yAc/ud8UlkyXJMcpojbTt5MTVpzsKuwXJ3+QVlfTJ3Im6Rf
	 agxLxBBQuTsViXDJCt4KwmI8w4QvahRumazGi5cz9QnxQoKAR9EqIZ8erBAApWLaBQ
	 gx0DYx3GHWIg/Qu7DgBb7uIloce084PbsqZPp4YPy8lGuyWNXdl89eazRVFz1Wii46
	 FTmsIm1AqFeCg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: apss-ipq-pll: fix PLL rate for IPQ5018
Date: Sat, 27 Apr 2024 14:34:17 -0500
Message-ID: <171424646116.1448451.15211012312345668956.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326-fix-ipq5018-apss-pll-rate-v1-1-82ab31c9da7e@gmail.com>
References: <20240326-fix-ipq5018-apss-pll-rate-v1-1-82ab31c9da7e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 26 Mar 2024 14:34:11 +0100, Gabor Juhos wrote:
> According to ipq5018.dtsi, the maximum supported rate by the
> CPU is 1.008 GHz on the IPQ5018 platform, however the current
> configuration of the PLL results in 1.2 GHz rate.
> 
> Change the 'L' value in the PLL configuration to limit the
> rate to 1.008 GHz. The downstream kernel also uses the same
> value [1]. Also add a comment to indicate the desired
> frequency.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: apss-ipq-pll: fix PLL rate for IPQ5018
      commit: f58edff0331fa18bbaaade3ae675f547c0245224

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

