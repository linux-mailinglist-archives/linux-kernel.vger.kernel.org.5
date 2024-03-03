Return-Path: <linux-kernel+bounces-89887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDCA86F6E7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76092824D2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5175079DD2;
	Sun,  3 Mar 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgp6oR0f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE279DB5;
	Sun,  3 Mar 2024 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709495425; cv=none; b=C491nMHhgra9VVgHmVZm1aOGXrcSTnR0lhNrUFr3AfAfUxNJMxBwR/KqPwXGywwo18Uzkf5UEevOvaJ5/IVAIk0cbiPsBCIeKux86TVXo9Ke0JyGtMktVtQ1hB/bkLt7BrEOY7BshHxL0RmhtdMVYR5stXbR2mQn5De+S1sCUZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709495425; c=relaxed/simple;
	bh=iBwmipl1/hUhuGVHK7DoLKTJPzEyRbBjJNTKDMKdf3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mbc7mCYjiQOaUUTiiUBqYo7b+W2W9GCNq1Yg+B7gFlr0ePfTmi8YyrJwEVZruOrWFxj45opstMevxSnxC+xdHzcB21kCDqWaumEvWYpdsKiHRf9L6+KLY37zsyTw8tg58oh8Y+6OM7zYoPFU5r895HcunynJ9SrEbAtjjcDY6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgp6oR0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B12EC43390;
	Sun,  3 Mar 2024 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709495425;
	bh=iBwmipl1/hUhuGVHK7DoLKTJPzEyRbBjJNTKDMKdf3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgp6oR0f6qoUMm2JArOqNP4pvydYZAefJXdnWKl8XqqDd2KBhQNKpOJyg35KMqd4i
	 W43aVj85k7sAOpVZ7+rTVy2BcGDdk94PXh+8JKgudm95hvM9auiG4381d1emUsli/F
	 atyrrMMt1l/VVnm/GnqbDHhzFPUPpdDx4CAxRVXNo2FTVxp6gan9DPq2AM0wb57K/X
	 1UtciSXM3CT69U4sykcFBuPmw6+fehfznoy3bO2/XLkkbDynQuT210K1nNu/CzDX+D
	 BUGoud6zgVc15DdsCixoggBy7BVV9plivGlZOavLfGEL2DL9eed0IEE0or9gfN+kPJ
	 kAYeO807eDRsA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
	Devi Priya <quic_devipriy@quicinc.com>,
	Anusha Rao <quic_anusha@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Georgi Djakov <gdjakov@mm-sol.com>,
	Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] clk: qcom: fix frequency table termination in several drivers
Date: Sun,  3 Mar 2024 13:50:19 -0600
Message-ID: <170949540959.78121.7121935387305237731.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 29 Feb 2024 19:07:45 +0100, Gabor Juhos wrote:
> Add missing terminating entry to frequency table arrays in
> several drivers. There are separate independent patches for
> each affected driver.
> 
> The series is based on v6.8-rc6.
> 
> 
> [...]

Applied, thanks!

[1/7] clk: qcom: gcc-ipq5018: fix terminating of frequency table arrays
      commit: 90ad946fff70f312b8d23226afc38c13ddd88c4b
[2/7] clk: qcom: gcc-ipq6018: fix terminating of frequency table arrays
      commit: cdbc6e2d8108bc47895e5a901cfcaf799b00ca8d
[3/7] clk: qcom: gcc-ipq8074: fix terminating of frequency table arrays
      commit: 1040ef5ed95d6fd2628bad387d78a61633e09429
[4/7] clk: qcom: gcc-ipq9574: fix terminating of frequency table arrays
      commit: bd2b6395671d823caa38d8e4d752de2448ae61e1
[5/7] clk: qcom: camcc-sc8280xp: fix terminating of frequency table arrays
      commit: 6a3d70f7802a98e6c28a74f997a264118b9f50cd
[6/7] clk: qcom: mmcc-apq8084: fix terminating of frequency table arrays
      commit: a903cfd38d8dee7e754fb89fd1bebed99e28003d
[7/7] clk: qcom: mmcc-msm8974: fix terminating of frequency table arrays
      commit: e2c02a85bf53ae86d79b5fccf0a75ac0b78e0c96

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

