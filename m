Return-Path: <linux-kernel+bounces-119307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA9E88C6DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46F21C3872F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BCF13C9A6;
	Tue, 26 Mar 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTuDa2Bq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E313C90A;
	Tue, 26 Mar 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466858; cv=none; b=R1yMGYpbWamlFxMGe7F+vn6ibHdbrwkCD3IPE/bKXz/5HQYbTUr5YjMFvAubts8l0Vazh/xc/TY+FCCSqosa4Z5IcmIV+DDPVp9u7CV6BZF0NJer3EwmhilvHajFn7mK2BiI19TuOagwC7KYXr7UEz809ssr4nVqJv8+553yH+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466858; c=relaxed/simple;
	bh=lv5bA0FZ5ZAVNsfhWNcrlt0nZyurirWCe8fm49gbPRw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MnXLEGDDK3GDXxKCnLvKHjHUp53b9UDdWTr2R2bxHOmpuJ3fhMyTRRCIObXlthWFVW3Z15cKLM24LVNZy+IN1YWdBGMu+6f7yaP6xU9YK7QlYfbgEcWz3K2+6JrQUIClFlQ5Y3Us+j6itL8Vb8fLBzCD00Vr7XJ7sUrySCPPeFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTuDa2Bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7106C43394;
	Tue, 26 Mar 2024 15:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711466858;
	bh=lv5bA0FZ5ZAVNsfhWNcrlt0nZyurirWCe8fm49gbPRw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CTuDa2BqxhIm3T80DmDW58q7Z+Hgm71qSDdBIsq5p2aLARE5wVAzS+H62tmaSAAQ9
	 ddaCDvQVN4MS55bQxmVLuLedaz0bs/HjO5JWMGMXnGDIBi4XWzNO39uux2eoOVYLm3
	 cPpQRpOBCVOLwU1fQIDav5r1ZtObb9rRJJu5AZPPaGI5RRLsJENYzihAdUbsjTmJA2
	 L6vZtlJmiBGcAhZ/LGg1q1sR+JnR9cxY4QVpTyBXzLlNI8WTop1zWbBsvz1AFpvEP4
	 kN8aeXBB3Au1aTZHtn3NeB80EgW2uaBbwpZrRsrw3qxXZPWkBswJy+owsjEjy/OV/o
	 fu+B/91NXYEpg==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev
In-Reply-To: <20240223015219.3618111-1-megi@xff.cz>
References: <20240223015219.3618111-1-megi@xff.cz>
Subject: Re: [PATCH v2 0/5] Add support for jack detection to codec present
 in A64 SoC
Message-Id: <171146685553.132239.7359071479425235403.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 15:27:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev

On Fri, 23 Feb 2024 02:52:10 +0100, Ondřej Jirman wrote:
> This series adds support for jack detection to this codec. I used
> and tested this on Pinephone. It works quite nicely. I tested it
> against Android headset mic button resistor specification.
> 
> The patches are improved and debugged version of the original
> ones from Arnaud Ferraris and Samuel Holland, imrpoved to better
> handle headset button presses and with more robust plug-in/out
> event debouncing.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] dt-bindings: sound: Add jack-type property to sun8i-a33-codec
      (no commit info)
[2/5] ASoC: sun50i-codec-analog: Move suspend/resume to set_bias_level
      commit: c0454d31e05062b1c7df7eef21855ba1f56c5158
[3/5] ASoC: sun8i-codec: Enable bus clock at STANDBY and higher bias
      commit: c556814b926c3f16fdca3d18cac793ccf0d14c44
[4/5] ASoC: sun50i-codec-analog: Enable jack detection on startup
      commit: d5961e43b28668088087befbf4f7a043bd0ae65c
[5/5] ASoC: sun8i-codec: Implement jack and accessory detection
      commit: 21fa98f4197bb3365dda1417708b318f403c13c1

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


