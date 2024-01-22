Return-Path: <linux-kernel+bounces-33713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BCF836D98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A6C1F287C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DB858214;
	Mon, 22 Jan 2024 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjVar1uF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB93858134
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941852; cv=none; b=r4OCiJzCDyJhjPI9gsttpH07d+Kky/gaGc/Orep/SeOxKWTSYJOTPhKxOFRbEqySxyiwim+Gkcsj7sOVaP4FqigwH5R9S0mGEFeyBKFmx4hb5NrRJu4IMc6zqm8Nh9AU65Me+0KgtObsUkyqCVCGJAOGQovYb8spkGnUUVpJK+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941852; c=relaxed/simple;
	bh=TW/AN33h2oTcesoDKGns8E03o0QAbOXHGZZP55YuaO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgEAR5fm7KnuNIDgC+Ci8gtoawDymvPS1aD6YKdezI+v35vc0UjkVXE9i3gQk9sjDUl80MpZ2B+q4Iwr3oLQlFD0v6JMaVvlI9FpOfkhvLNk2rtMq4L+loSJNZgzrgkmylX72KYVLa2lylnaFxeBWpFcKNeNakDZIWaBcWQIomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjVar1uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71659C433C7;
	Mon, 22 Jan 2024 16:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705941852;
	bh=TW/AN33h2oTcesoDKGns8E03o0QAbOXHGZZP55YuaO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjVar1uFmKpt5+lIXqzXknpmFH8UWaIxF+e+ahlZpm1bGIckUNJl0dMaFjBz2Bpja
	 E5jM8xEUnRGR7G4jxUUQBVwJM1lqHZhN+uKYBdfnu8z6ls7Yw3oAiX8Z376C6zoo3v
	 +OoSCMAV4aN52a31JIrnN65xfvarfznlkneqc52XAbxGtJ5+/m3pcqwZvOgBKWEdFE
	 9nniraj69VpqFgc9RURQPmAv3ER7/7dp5zyhiFPL1hm770sKaLhpkmzrNU7ON1Y40S
	 D9MooXFwHdpMuN2juxkmZY/uE2LlTgJ+DJac5JarpNJxJHmMsXQlva0mCPLFI5gC23
	 PQ4byDDeIqdSg==
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: microchip: Fix POLARFIRE_SOC_SYS_CTRL input prompt
Date: Mon, 22 Jan 2024 16:43:49 +0000
Message-ID: <20240122-subtitle-luminance-517a0bd92582@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <607c5ba8b95b1a11b6dc532223e9d7abcc2c20e4.1705935812.git.geert+renesas@glider.be>
References:  <607c5ba8b95b1a11b6dc532223e9d7abcc2c20e4.1705935812.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=350; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=UjseNzGXO9922yEWb8pAmj23ZPXNexQeybrnoHVRzPY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnrZrtUf2fedNDmxsQPeSryXUnnvmz826lwWN9nFvcxm bVXPJzXdZSwMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAifG8YfvS4myrGbamXWM3D 99bgmRej4HqLvAPfP23u3cPnc+otIyPDEtf9IbuLK3aevfUgb7H73pQ+H4tGrbLgCkuz0sU/+Qw 5AQ==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 22 Jan 2024 16:04:14 +0100, Geert Uytterhoeven wrote:
> The symbol's prompt should be a one-line description, instead of just
> duplicating the symbol name.
> 
> 

Applied to riscv-soc-fixes, thanks!

[1/1] soc: microchip: Fix POLARFIRE_SOC_SYS_CTRL input prompt
      https://git.kernel.org/conor/c/6dd9a236042e

Thanks,
Conor.

