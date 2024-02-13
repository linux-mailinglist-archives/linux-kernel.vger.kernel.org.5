Return-Path: <linux-kernel+bounces-63664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063CD8532F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0BA1F22D83
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091F25788A;
	Tue, 13 Feb 2024 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j26fZM4J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD758103;
	Tue, 13 Feb 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834150; cv=none; b=lluKPLielhSUMbkem6sp7OXyeF9rRhL7rcI22F5oo+rnNn9cryPhtstGYhU2EZtOB6M2sJConaCqZAsLKjkBMp+KlJFk8Sa5dDdGyIND0IGOjEuZkJ7Qko1ZKi4Mu5ddUJCgRti1/Nmwem8KAFvvfAId+87EiDFU10RoHqkqckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834150; c=relaxed/simple;
	bh=yqTyD/OjND337wp33t22PMtWJVzfs0J8AnORHF+7GG4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DbuUMgWFAAWNHEn7xJB+s90M4uqzhdNOIOAsvW9j/4/rpOqx1waspl8zJ2Y/wQUyMFxNebaImHxaUVjINm6kpaw0+cwA4kmDykpBHUNjAnl7fNNpEeFpkGvcj53nUWGec6/4hk7PD8Kct1AJ4vxvujZTCT2GoFnI9S5Mk/7ItYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j26fZM4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8057CC433C7;
	Tue, 13 Feb 2024 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707834149;
	bh=yqTyD/OjND337wp33t22PMtWJVzfs0J8AnORHF+7GG4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=j26fZM4JKyiZxhBok+sG84VvBt/MqBNn/AAUNCtYmbLqbII24bzx0mocMC/hifs26
	 MymKA4NA/GocKd74u3tAEK7Wo9LnGSc2NrCM5ikCaVbclHgMJYLXvK2yEfhVsqzKvV
	 0GDasPHFiXxHI9hYg2qlI2S85z6a82kZaKQKII1EvxtfTNoCMlNpv94hCVRoRhR12s
	 rxpE6evzJqiHsg9zZMDsGEefXZBAOQCeyIqtWGm5GzikcW8lRXVH9ncgTgcJECZCaE
	 PlamdIcJGZCTw1yV7lpCJ9+xs3FYwhkz1wGjrQklAGjP6wYJef1s6Yxq9rkzHWHsdy
	 B+jkLkhJftv4A==
From: Mark Brown <broonie@kernel.org>
To: James Schulman <james.schulman@cirrus.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>, 
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
References: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
Subject: Re: (subset) [PATCH 0/7] Xperia 1 V support
Message-Id: <170783414525.38232.9788370045735417740.b4-ty@kernel.org>
Date: Tue, 13 Feb 2024 14:22:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 12 Feb 2024 14:10:08 +0100, Konrad Dybcio wrote:
> DTS for the phone and some fly-by fixes
> 
> Patch 1 for Mark/sound
> Rest for qcom
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] dt-bindings: ASoC: cs35l45: Add interrupts
      commit: d0611f617d823a87f04186ad165e2990208c040b

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


