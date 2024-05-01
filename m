Return-Path: <linux-kernel+bounces-165747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E8E8B9084
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D63B282B2B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9F21635CF;
	Wed,  1 May 2024 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIKNXPc5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81811635B8;
	Wed,  1 May 2024 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594860; cv=none; b=RWezOX22dbSJzgX6aQTKwtNBkEOMmYiCV89VVGrKVB3bSglGJTLHyN0UZzP8Du0faJZ2PhqBhkYo0dwoS1/aiyUfRqPXw0f/G0HU08Bk7c7FQbrRxUVkit0nNxG/JYsb3GgQsluwOqZGnJli9JiS2av3Im4zvQRVAa2kqazEtsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594860; c=relaxed/simple;
	bh=w6O2G7YKnMDnhaIfNdKszJTmuHApVeW5OQ3m8+R23qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JreyxeO3BYgv5QTLAHYDk5yOGQKV7u26hUpmQsY9HjYYfRhRyJskr4v5oUhf9J3YqUi8WDZp1zNP5Pvx1wUnsTTH+qW+YeDwrAaK9sqv0GXNc+Z6bA2YQQ0OO7G93s3HZVWTOi8s9XoUXIa0n8qILou2y6rNtFcqelBT+fhyHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIKNXPc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60EFC32789;
	Wed,  1 May 2024 20:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714594860;
	bh=w6O2G7YKnMDnhaIfNdKszJTmuHApVeW5OQ3m8+R23qE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jIKNXPc5x4HnYugSH9wCso9qS0xNQnY7sn14VH9omtrZIPXDu4KoB23C/6oo/2Bcl
	 dTGfdZ6LQCpW0AcAV+nPC1COXi78PgEuZRalY6cplWruZFl9kIhwDCKXACZeKFGYZ5
	 +0kA1Nvj9lwe1zsCY0DrdxmrDN1meILJWF7Qa9SCaRtA7uESLQkgKcX+yyqNviMhhZ
	 upab1e25JNc5Z2D1anJ33gYI3p1PspPsbBMOR8PP9556nQAViV31e7IC8DCT/6gw2n
	 YZ0Ot83YZO0jbaITmREyHWtTQ9gfnSO5fNpxrRaTlxMQIsKa/xbCgqeMoHETvtTRxS
	 XA7tuUf5f+dHQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH] soc: qcom: pmic_glink: Make client-lock non-sleeping
Date: Wed,  1 May 2024 15:20:50 -0500
Message-ID: <171459484209.41039.14363684332772839800.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430-pmic-glink-sleep-while-atomic-v1-1-88fb493e8545@quicinc.com>
References: <20240430-pmic-glink-sleep-while-atomic-v1-1-88fb493e8545@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 30 Apr 2024 20:38:57 -0700, Bjorn Andersson wrote:
> The recently introduced commit '635ce0db8956 ("soc: qcom: pmic_glink:
> don't traverse clients list without a lock")' ensured that the clients
> list is not modified while traversed.
> 
> But the callback is made from the GLINK IRQ handler and as such this
> mutual exclusion can not be provided by a (sleepable) mutex.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: pmic_glink: Make client-lock non-sleeping
      commit: 9329933699b32d467a99befa20415c4b2172389a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

