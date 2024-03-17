Return-Path: <linux-kernel+bounces-105468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EE387DE72
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7883B1F214B6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B78D1CF89;
	Sun, 17 Mar 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuxCTcSw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49A1CD2A;
	Sun, 17 Mar 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692846; cv=none; b=NRuX+ghaPSv73z/MzOQPY326/hexk6ndvuollRvwt0oFcRx9z0Jp74wNi+kz4T4SKg/iTK7SJ2CP3sDkUD2KKKh6ReZmWW/o60DJCch71TppWJcPEWh0nlfGRLFbWX4Lsat6KWyN/jO10EP/hvQheNT1QtqIj/IMMPzG8XfpDiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692846; c=relaxed/simple;
	bh=/sMe+0qb19ZKYZJ2RQShEwagtkA6NxLUpEjBWbZDHVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkD5yc9QN8pBHGtCWPMYohYq0FkVQi7EOG9xfkt5aAPICiww6BYedIabV25RaOxZXOD2mRdwbWfMzNVAt7VCq2m7XUpXjVo+SaX3eTf1HzyAOlTxbI0VAu1C7jIVDeRiprXmHIl+xBFdMmMkzaDxAKAiTRxTuxF5KWBr59veQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuxCTcSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFBAC43399;
	Sun, 17 Mar 2024 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692846;
	bh=/sMe+0qb19ZKYZJ2RQShEwagtkA6NxLUpEjBWbZDHVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nuxCTcSwdHSKoPzO08uyzDdixIUJpcGVuKh7EhhtzM7tda4HhedOs+7SJevGiW0kx
	 yfrwowq2BI1tyqFTEvTIBC0ZaXfJuvlTOzd44Is1jbZQdyPQ3ZO+wYX/0RphNuwB5l
	 wgI5+yl+2KeG/H1uYLQvmP39lWBE63n5GFViJhNUWWJH8C7GWa08wlpkGros3IXy45
	 L2SxR8yq2owzB/Lh+MyqoAW/ZchpLYDzIl/Y6MEpmX2F+efTwGQ/+nnuJ8RRw0H/8C
	 7/OtTicETfxh6mf8Muf34VYbc6Ew94qJHBd6raURTmRJ1E9vlmsP58o1FfmO6Fm/0B
	 45v8CA199RGog==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom_scm: disable clocks if qcom_scm_bw_enable() fails
Date: Sun, 17 Mar 2024 11:27:17 -0500
Message-ID: <171069283518.134123.12387132556718627972.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com>
References: <20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 04 Mar 2024 14:14:53 +0100, Gabor Juhos wrote:
> There are several functions which are calling qcom_scm_bw_enable()
> then returns immediately if the call fails and leaves the clocks
> enabled.
> 
> Change the code of these functions to disable clocks when the
> qcom_scm_bw_enable() call fails. This also fixes a possible dma
> buffer leak in the qcom_scm_pas_init_image() function.
> 
> [...]

Applied, thanks!

[1/1] firmware: qcom_scm: disable clocks if qcom_scm_bw_enable() fails
      commit: 0c50b7fcf2773b4853e83fc15aba1a196ba95966

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

