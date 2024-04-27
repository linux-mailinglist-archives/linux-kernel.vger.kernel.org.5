Return-Path: <linux-kernel+bounces-161146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3155F8B479D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6B21F21926
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842ED14883C;
	Sat, 27 Apr 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mql6uhlY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC84C1465B1;
	Sat, 27 Apr 2024 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714246469; cv=none; b=QTFGQVy/SFPHHev/eicbC1uWpWfgb7/f+CDZCvnnOSk9NYtcWWYe6QISIj28uY142TosLAGdgKTaVYwAlNeCZW5nZEfWTQbMQw5Y/yWe46RlIvabmhh8wXcI8qXrEdxj1vqPDyqWQpLZhENyk1vL/XZkpFTCwJBwVgL3ghC8Q9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714246469; c=relaxed/simple;
	bh=rlQjRTzVlQOnffD0y2d64jwtxxZnjsOdYPn5WiRjU7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5prma6mBGvXKOHKvI/eNrvpmyQndXGKM/D3+fg++tFSsJhgk19HBoHd9aUPHfvQ+JWYeOC6rUPqvwbdzw01QI0D5twYAbkIjpL5hGqvmMAkT7TZOiC9K5Ewq61pVEsdF92zTqRBJW0YRPZTYZlGdFxjHWtl3No8CCeplQwRD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mql6uhlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42807C4AF0C;
	Sat, 27 Apr 2024 19:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714246469;
	bh=rlQjRTzVlQOnffD0y2d64jwtxxZnjsOdYPn5WiRjU7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mql6uhlYv9fDzBpeS+QKHPyhTUYvAuxZ6gg7iUavlKfe+Mo3rG/5iYaQzoC93fJyk
	 yFv2KEMpqodl4FNd1ljYvdhoemhxQVX4WcAcAr6zaV/TKT/Zf3p6nb+BJ3e4VU9TjX
	 mqRyESFg/dk1lDPa5cpZlHKvi3gvXwOJb7uzAHjng1VayVgDEx8QfIvbmyhpDTWyhX
	 OyaFfL26aDJoOFLYDwwnh4E++X0IP9LkWwUJiWwpIWLRPMy8OVBrvC1pS9/FZQNDoI
	 Wu8ZQ7cJ/b9Ht3n5y+oDkOjJ5L1w5duwdgc4dgIxKt9jQYglts2cWlX9v+VHhjhpFF
	 YodUrCWXtibrA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
	Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to fix boot failure
Date: Sat, 27 Apr 2024 14:34:18 -0500
Message-ID: <171424646118.1448451.8637792657591350088.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com>
References: <20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 15 Mar 2024 17:16:41 +0100, Gabor Juhos wrote:
> Booting v6.8 results in a hang on various IPQ5018 based boards.
> Investigating the problem showed that the hang happens when the
> clk_alpha_pll_stromer_plus_set_rate() function tries to write
> into the PLL_MODE register of the APSS PLL.
> 
> Checking the downstream code revealed that it uses [1] stromer
> specific operations for IPQ5018, whereas in the current code
> the stromer plus specific operations are used.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to fix boot failure
      commit: 5fce38e2a1a97900989d9fedebcf5a4dacdaee30

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

