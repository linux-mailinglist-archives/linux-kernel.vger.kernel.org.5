Return-Path: <linux-kernel+bounces-78693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0181E861771
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C37288A63
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4203085C41;
	Fri, 23 Feb 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3ud/zyp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77D31272A9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704896; cv=none; b=ACXG/+zgveWO6TorVf5XjbRZItn4WClX/BlUML2IyfpbN5QCgTyXfrST9rk2r+91lpYyLAK2Ho6qSsJvOszuizkxopocGY7BjHS5n8tkyv8yTw1ICn6ERyIehQW+H3rRstAUgzWkx6T3AOxlllvyQH/G9l95JbDSdY43/023V5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704896; c=relaxed/simple;
	bh=+sWCvZILJutfbfh6f2UzLobm37ypkAWLN+5d6c36Pk4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s5QzJVpGbHyL1Xg09nW55PztCGxfe7mLvat5bLA0myj9VYe3PJhWvQD6yEpn4dPqce0nXDNZ4VXm/DyF8UL4v02sp44V7un4yLVk8XHMvfqDI/c8a+k2I6gCivYH49tfBSgoUG96cyY6TcFat0XcmUv0fnlg0D4w0BHA2Shjs38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3ud/zyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63887C433F1;
	Fri, 23 Feb 2024 16:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704896;
	bh=+sWCvZILJutfbfh6f2UzLobm37ypkAWLN+5d6c36Pk4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h3ud/zypJ0UvhjYnwcyJN81KiSlL/YpYhE+VYdtAD68AyV492dHGsCw9Jlz/PQ33H
	 NKGH8v6MUbNcHdU4vg/4YUSp2wp6KzC1aT3AsiRj+peE6luu1lJCzmtjjMlZ76kNFh
	 TJuAu6BX0ubG4x3Vo9iO7yO94Ey5Da2qOJ+Vzb4K7MEorDvO4MFSjA+B7/APqWkNAY
	 g4aht3VNfwJthSUeMKJ34yi6lEk0ATaeiOnLIUwUTi3Y/MJQ3Yu684Vnro+/la4cYY
	 qU27U38C0DRrNrLNGXmrV43ZPyGI6XaYc2X4o810vqb9bKW9aBBFV+7Cxk0S4HT+XM
	 ksK0FYUYhYuPQ==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Cc: Lee Jones <lee@kernel.org>
In-Reply-To: <20240217195615.1767907-1-megi@xff.cz>
References: <20240217195615.1767907-1-megi@xff.cz>
Subject: Re: (subset) [RESEND PATCH] mfd: rk8xx-core: Fix interrupt
 processing order for power key button
Message-Id: <170870489512.1733392.3193297224025743426.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 16:14:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Sat, 17 Feb 2024 20:56:13 +0100, Ondřej Jirman wrote:
> Process rise event last, to avoid stuck keys when multiple interrupts
> are coalesced. This can happen typically when resuming from suspend
> via power key press and holding the power button for a bit too short,
> so that RISE an FALL IRQ flags are set before any interrupt routine
> has a chance to run.
> 
> Input subsystem will interpret it as holding down a power key for
> a long time, which leads to unintended initiation of shutdown UI
> on some OSes.
> 
> [...]

Applied, thanks!

[1/1] mfd: rk8xx-core: Fix interrupt processing order for power key button
      commit: bda40bf667d8d26b157a69d821872b2ade59bfa4

--
Lee Jones [李琼斯]


