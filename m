Return-Path: <linux-kernel+bounces-57870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5788484DE80
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2380BB2F5B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DF63399F;
	Thu,  8 Feb 2024 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKfJoNlh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000D71DFE1;
	Thu,  8 Feb 2024 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388513; cv=none; b=KHvioOvz/8bv/VuVNLRKs6nZiuHA9tEGia7xRLbGwHsdqbEZZrksr76qpBgF9PuYY/y877VidslPC0nijcQcrJU4iyeaExNs69SMHWJXgDsQ+CuZZkeNHA3iknajquDHN1OcqsYggwHZvcUWTCVDpTKNt5EHcookYTmqsssVweM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388513; c=relaxed/simple;
	bh=0/YRNuXxZuldgKvPMxkRGmiUNw3aBOqxeqR1S9uQF6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=In3OgDreWXzzY76ts9bAYZF/xIGLo8GyiePeRo7SRaEzDD/YmT0IBmuAafikGED7IE0R0QjkX/n9HpBSVmBlsQHv3tTSn8I0xZoX1SozsRm5O5+IZS4vgI5Slxcl5bxbhCv/NAONtpNzN7ePVM68O0K8hq7bs8Jl2BKapRagY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKfJoNlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677AAC433F1;
	Thu,  8 Feb 2024 10:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707388512;
	bh=0/YRNuXxZuldgKvPMxkRGmiUNw3aBOqxeqR1S9uQF6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GKfJoNlhG3qi82SM3lHOL568A/rTjCfDxuu50jgDXdzpa7fiqU9TxMpmWkSYg0gzb
	 SuK5lDR0uBnkmhHkW4++pICqKFBVSsLD/k9MHhKtSNtSHmqjeYcGd1QuyzIXsCaC4k
	 GZ89XWlVft+XhdQhYRevc6iiYd5teL6dkgt6yTIkdlf8VIh7yamwP4iin2EoZdsqNI
	 n80wFKOrgdor2Gz8QHuvXr5ma2Fis5MEIoqS59VQ/cNCILvaITalu2UA3HpnLEN6+x
	 In5sjmWLYr/se5q8eFMalz9eJ5dBtcYBiknyZqt+1R4wTunFz3aSzqs0FLpU29Q6nF
	 fBniF7l+3lm4w==
From: Lee Jones <lee@kernel.org>
To: Flavio Suligoi <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Sean Young <sean@mess.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
In-Reply-To: <20240128154905.407302-1-sean@mess.org>
References: <20240128154905.407302-1-sean@mess.org>
Subject: Re: (subset) [PATCH] backlight: mp3309c: Use
 pwm_apply_might_sleep()
Message-Id: <170738851016.914450.4228723185612575654.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 10:35:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Sun, 28 Jan 2024 15:49:04 +0000, Sean Young wrote:
> pwm_apply_state() is deprecated since commit c748a6d77c06a ("pwm: Rename
> pwm_apply_state() to pwm_apply_might_sleep()"). This is the final user
> in the tree.
> 
> 

Applied, thanks!

[1/1] backlight: mp3309c: Use pwm_apply_might_sleep()
      commit: 7feb4ec8ec900daf29602bcdf7c04178c63205ac

--
Lee Jones [李琼斯]


