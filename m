Return-Path: <linux-kernel+bounces-34144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EB6837455
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F41B25824
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19594495C6;
	Mon, 22 Jan 2024 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkoPl5LS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6043E47F54;
	Mon, 22 Jan 2024 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956278; cv=none; b=gHCxStnricJIzckHk/wKBsBLfehP9srSXJlkLYp+dGhJwchclKxkI3c2GJiVkcWdfhfuPCz79lsTuaWGpeHeYCb6dWnDGzIKT+7m1rKedxYh1hNvWN0T/MNc3QOV8nN5iBedz1ZBNoJkW+PeyYEf0toN4LTn1zNQRUaGS+4ZL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956278; c=relaxed/simple;
	bh=JtLO0MlO8Tt8madrsAxXRurd5vGRKvFlm+BBGklUVJA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oYZksfzAFBNzI0ivPQiSIC4kGvpDkKb4W5QsIZaSniYFei1m+WJPv6Xj3vbYSA6IJfgaosKCvI+etle9RKKGgqDfRFPjtijyFtpTPU2qp3/zGzum+X6E+2GCvT4Zqh3PuwuU/J3LypmFBF6RyhvWFA+TY68WTw9bLt9goqeK2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkoPl5LS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0542C43394;
	Mon, 22 Jan 2024 20:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956277;
	bh=JtLO0MlO8Tt8madrsAxXRurd5vGRKvFlm+BBGklUVJA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tkoPl5LSY0xWL2R6sf7k2TjL8UqFl5s1Dv2r95mEs97/1UWfJm79jFKWRKdY/k7s7
	 nYAbYKQGwmqZ5fwiXjvUVvPEIDAhH3V/AK4vXj/4Jt4Wu/g18nP8uZV5XFtmWhpU9I
	 HVeUh5/ZePr5tqc6nkf/BH7eA8ACApu/6k6X1P+RunFs3QIeFCpZN8gp4EKu4ytzSo
	 upWhhb8ypokTAQhHKl3PDHx0FsfKeUrv4NBS8iIQDmmR2cNFQ+lAEhp1WhIPClV5Oj
	 esH+Z0nu13TNXyXOp90mKBJbMUWzjdTHvzLcT50DTz4OlF6/vfuJV7saxuKf2F6WvG
	 UGmMY+sgkBQIA==
From: Mark Brown <broonie@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240109-rpm_vreg_cleanup-v3-1-fa0201029f78@linaro.org>
References: <20240109-rpm_vreg_cleanup-v3-1-fa0201029f78@linaro.org>
Subject: Re: [PATCH v3] regulator: qcom_smd: Keep one rpm handle for all
 vregs
Message-Id: <170595627643.145638.11249590166441157779.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 20:44:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 09 Jan 2024 11:04:49 +0100, Konrad Dybcio wrote:
> For no apparent reason (as there's just one RPM per SoC), all vregs
> currently store a copy of a pointer to smd_rpm. Introduce a single,
> global one to save up on space in each definition.
> 
> bloat-o-meter reports a slight uptick:
> 
> Total: Before=44008, After=44080, chg +0.16%
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom_smd: Keep one rpm handle for all vregs
      commit: 5df3b41bd6b5432010d6d85e5aa7217bd8f6b0cb

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


