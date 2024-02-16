Return-Path: <linux-kernel+bounces-69462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9583E8589DF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D0428A8C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C4E14A08B;
	Fri, 16 Feb 2024 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdiLqUui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F6F148FF3;
	Fri, 16 Feb 2024 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125051; cv=none; b=tUr2KGaVtDpCi8vGLMWvhfToAuPYWpInbss9KBXVOUnQtsqBkLZgTFJuN2JpHPXPUbVJG1BVVzdyi0zNXT41h5jhv/d75LtfgPC2GPPKy4/T1uak9OVnQZDy8nAM2mC+QbRCKW8u99M1fIq+ZcvwbIMRM6cwzwgtbN0xg4e4k3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125051; c=relaxed/simple;
	bh=dGawVXcSV1O5i0Z5xx1Zsy9tfEYeBIHEqLwyt7Of+gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVVMh8JUGCJ7/WCxU1PouyhS4cgBeS/Hx+Y1Hfpi/QDnx0GvN5CZBxwptznxNRJtg2MwlxFvDFQS2nKyLUrLWROwZcDcVeXZmNoY2ChVULZwe/cczUP1US9r+genL9oTRAgmWjlheqXNSbjex9UPSM5laBkB1K2yWaNLDVTIhPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdiLqUui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B62C43394;
	Fri, 16 Feb 2024 23:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125051;
	bh=dGawVXcSV1O5i0Z5xx1Zsy9tfEYeBIHEqLwyt7Of+gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jdiLqUuiO1z/slsnoO9Kaneqo7cLaBHxgbMVDl3ucsQoNq8ezv9zahRiddQpnm7xc
	 ey5UKgfuegmjiRapVNaDHITdeqdH/DjTeTnif/IuJXtJ6BouoLR9LG0DXPoRSB+6Cg
	 xxJIJXIZ8cjX0bofwDdy8Dk19APdbatjocQMVQsCxq97qnedwBwj6X1TXcsglB7/h8
	 qNcYzV0Hdhhmpz2Xw5KRGLoHPo236cHp3OO/O4BXEA4dqkjUBU5aGfE55pZxwhSelE
	 miqEWVIoIoMzY5HXxnEEoiyZGGBUwMdTxDFu/XerMZidKsH+NjicnU5xqwH/KEdfVM
	 /ijOWdoXTcozA==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v7 0/2] Get rid of some magic writes in drivers/clk/qcom
Date: Fri, 16 Feb 2024 17:10:36 -0600
Message-ID: <170812504012.18043.14148381886202155733.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212-topic-clk_branch_en-v7-0-5b79eb7278b2@linaro.org>
References: <20240212-topic-clk_branch_en-v7-0-5b79eb7278b2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 12 Feb 2024 17:10:45 +0100, Konrad Dybcio wrote:
> Changes in v7:
> - Separate out this cleanup part from the RPM/IS_CRITICAL part of the
>   original series
> - Unwrap the regmap_update_bits call in patch 1 (Bjorn)
> - Rebase (take x1e drivers into account in patch 2)
> 
> Extracted from:
> https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org
> 
> [...]

Applied, thanks!

[1/2] clk: qcom: branch: Add a helper for setting the enable bit
      commit: a58009dc6ff13b4285a3c058762f5aa1f77508ee
[2/2] clk: qcom: Use qcom_branch_set_clk_en()
      commit: d09ec6f9877798a2a66c9d5de524b419e2c064bb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

