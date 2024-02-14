Return-Path: <linux-kernel+bounces-65759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C8B85513B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FF01F21B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5073612FB14;
	Wed, 14 Feb 2024 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvrEhMvu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDF112F5B6;
	Wed, 14 Feb 2024 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933492; cv=none; b=YFyS1O9BMTe9GTm8ZLwZmpdA8wxIUJE9P2zOGSb9yYUnTBC4rXEY/ezEhamW7z7n4YHIZzqfsu1fGMCZjrHT9YTrWS4gTxbCWQMFfT/eJYiWl1FSVT/e5NSO/1Iih/GDM7/Vp2ZaVJsmbpIru2OtjK47SaOT/YTcw8FD2B7yGlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933492; c=relaxed/simple;
	bh=OVdFZ2NgGzfZHrtkd+yxtrqdBPDwCSUB/L6vyyCfi9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPhDlkm4FWWDkAcMnbbVeEpv/mcUliLux/jukEnbKDGFBu8NQPTn6dzVqhhvzwiy4T0BS5TE3oNAL0kBZwfqMzSD7MgHcozIckDMk0hXj1rINGfAfbZdGBNvi4sqmrm+s3Nq6zgcF2pDtk+v4ulYw2RA2RSkjuKZITMBXt2hXYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvrEhMvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB71BC433C7;
	Wed, 14 Feb 2024 17:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933492;
	bh=OVdFZ2NgGzfZHrtkd+yxtrqdBPDwCSUB/L6vyyCfi9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvrEhMvuStQEIKgvYejGKWMZvyTRtk68ObKfZU9RDR+yG+JMBeLmNUvQMCAtFOuub
	 koPXTAflN1UuvNSo6arE9u0t0SUSXe8i9Jomb/rw3HwqHTV8M9UO4VAjTbBoQrWfVm
	 sZQn0k+djzBe+3o2pWDhw1FvZMJ3D09TTzNRQQcRidtOESsokozNdLwqv1oqcEHl4M
	 lyFz17nVwvJA1Ct/GYSz0o5y9fPnckSQiYCzFHSCA5y3LuvKfyvAwYkWR4/qiilDRq
	 0NXodwESj5hKskAVdzMEnarpQP5doqG8FdU0DGP5Uu0ZrfO2tCdZnszWnVNt6zStOR
	 4eeNcDr01O/vA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@quicinc.com,
	Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v3] soc: qcom: llcc: Check return value on Broadcast_OR reg read
Date: Wed, 14 Feb 2024 11:57:40 -0600
Message-ID: <170793345825.27225.14319593476051547796.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212183515.433873-1-quic_uchalich@quicinc.com>
References: <20240212183515.433873-1-quic_uchalich@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 12 Feb 2024 10:35:15 -0800, Unnathi Chalicheemala wrote:
> Commit c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
> introduced a new 4.1 if statement in llcc_update_act_ctrl() without
> considering that ret might be overwritten. So, add return value check
> after Broadcast_OR register read in llcc_update_act_ctrl().
> 
> 

Applied, thanks!

[1/1] soc: qcom: llcc: Check return value on Broadcast_OR reg read
      commit: ceeaddc19a90039861564d8e1078b778a8f95101

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

