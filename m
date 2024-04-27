Return-Path: <linux-kernel+bounces-161142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196268B4791
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A789B21912
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BDD128369;
	Sat, 27 Apr 2024 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omtzQzad"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDEA3D3AC;
	Sat, 27 Apr 2024 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714246466; cv=none; b=LuVtlld000QKx79F9XQBZRDTw3b9rWcBCUi65p53udin4hUvJRwS49RFv2m8Qt6LsbsBy5qeGVOCtXNkar6PAN0NMlZUsPDpHCKld1TDePeNVieetOMXNil7NCv1AW+5jkfRSpXRFIKkalriV/NNSL9dY2zc4R6RjyWu8Jus2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714246466; c=relaxed/simple;
	bh=8QpGSOATKy0mZ3CqJRHUpIrNKpK5PWlAUJ17CEr9nuo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ue2p9SoRGfNIro4aZxlfPgs/HzY6cm3V3GoOqkYkxGbQMSoTCed54O+R9lf5IzrE92D3myfZM9CofZ/Ten7v7nPy7cuXZuQNR9ZPKmOlFw6Q5bTd7OpA0qJgtjZWuBpkIgOcR/z5lcvw8KPwzzygQXjgZD8oaId83pCCS8Rdzf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omtzQzad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B48C116B1;
	Sat, 27 Apr 2024 19:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714246466;
	bh=8QpGSOATKy0mZ3CqJRHUpIrNKpK5PWlAUJ17CEr9nuo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=omtzQzadf8HCIm2Vbzt5admy7gikNQhNZHzvNbFU3rYHJsZKyOwO5Iy6h+kO3p7T1
	 jCc6VYq0vXOTj1e0pTIN9u+X38cwbsaBh4pGFB7yGSrPkKjk07fMOHReNUYc182nEB
	 z8tZq2+BGjf/gwsDbQLRfNeWCNQ/2LNZTUGnSkQfhdwOY3TlhzaCOTaZ8dW5AnHZce
	 SLaVwpu/e0NmuN3+bOd6Rny7bx5jm6gOkwIYIvSjRt54g6HjXaD4q3PJvYv61gc06b
	 PdmJK04Aq8KOU+8Nwf0+wPvjQy2AQBIEUPBufVzVE+wLOdZUNhqdPYm+KFvT7J4ZLf
	 Gdjo2ue8P7dDA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v8 0/3] clk: qcom: clk-rcg2: introduce support for multiple conf for same freq
Date: Sat, 27 Apr 2024 14:34:15 -0500
Message-ID: <171424646113.1448451.4939131897098085505.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220221724.3822-1-ansuelsmth@gmail.com>
References: <20231220221724.3822-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 20 Dec 2023 23:17:21 +0100, Christian Marangi wrote:
> This small series fix a current problem with ipq8074 where the 2 uniphy
> port doesn't work in some corner case with some clk configuration. The
> port to correctly work require a specific frequency, using the wrong one
> results in the port not transmitting data.
> 
> With the current code with a requested freq of 125MHz, the frequency is
> set to 105MHz. This is caused by the fact that there are 2 different
> configuration to set 125MHz and it's always selected the first one that
> results in 105MHz.
> 
> [...]

Applied, thanks!

[1/3] clk: qcom: clk-rcg: introduce support for multiple conf for same freq
      commit: d06b1043644a1831ab141bbee2669002bba15b0f
[2/3] clk: qcom: clk-rcg2: add support for rcg2 freq multi ops
      commit: 89da22456af0762477d8c1345fdd17961b3ada80
[3/3] clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf
      commit: e88f03230dc07aa3293b6aeb078bd27370bb2594

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

