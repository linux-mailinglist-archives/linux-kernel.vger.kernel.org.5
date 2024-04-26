Return-Path: <linux-kernel+bounces-160140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27228B39BE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B98B224A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70645148827;
	Fri, 26 Apr 2024 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LB+moF2O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B613C9A3;
	Fri, 26 Apr 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141353; cv=none; b=JcsyhaRC2H4dBfOBLk612gSCwb0UjiN3uKNhIlvPxI62+Ug9vapuyTnf/E6XrO+ewDSnBGIQSvvUTRs+Y1GAKae6exzN4HDTgkq/r1sXoGS729VXzRj01Zihu6acdE82rkXioUrk+VOtFVeN7sidTu2xyEX8nW9Rr7Ki0zY8/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141353; c=relaxed/simple;
	bh=72gFvp0DwRczPGZuwgNgleOFrpUh/ds20Oxc0IkrtYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qrz5Uqd+Y7EEsPsiO+oBVmJEo91+HCX1rh72lkHRVG8/Gj5grsSK00Y3+fNrQpkZi369ovuxPJEkDyhA70pDSQ0u+dJYV13OsAsNMGhOECbMF992ZuFxe9R6LJpux6ubGQsf/xsGlxRgVM1KTZugeBh12oFIBI4S7V3C8emxSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LB+moF2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9619C113CD;
	Fri, 26 Apr 2024 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714141353;
	bh=72gFvp0DwRczPGZuwgNgleOFrpUh/ds20Oxc0IkrtYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LB+moF2OxuTR5eLpixlC7mmsHJKqMiEMGEEKb//1OxrnsontHk5wzCbjCIvi/Icsc
	 WXlregAH8Ulg45vCj4DM8C9oJDazkH79yLY0GVJpEkH9G4Ys5PozmvjFoern9c/fXx
	 jllT9GUzpw1/bHUlUVjfDGSEawBn5/tMOIO5Q7yCq2/U4EMveZFS4cDtuyxn0lFkJj
	 d+P+ANQ1gHncWd05ouTqGcn7rBs7x1lJ0DXw8npGly8sMm2YHq7t51A23IUkaERyQm
	 0ntfyEk/SPdOJFvxxgSwRO1sa1nQi680su+mkKce84juokc4cMLSNMsqkbTVLyIgHH
	 o8XZxDjiAeC0Q==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240426064030.2305343-1-yung-chuan.liao@linux.intel.com>
References: <20240426064030.2305343-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH RESEND 0/2] soundwire: intel_ace2x: fix wakeup handling
 for LunarLake
Message-Id: <171414135031.113434.7941158841147200591.b4-ty@kernel.org>
Date: Fri, 26 Apr 2024 19:52:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 26 Apr 2024 06:40:28 +0000, Bard Liao wrote:
> For LunarLake, the SoundWire in-band wake detection is reported with
> the HDAudio WAKE_EN/WAKE_STS registers.
> 
> Pierre-Louis Bossart (2):
>   soundwire: intel_ace2x: fix wakeup handling
>   soundwire: intel_ace2x: simplify check_wake()
> 
> [...]

Applied, thanks!

[1/2] soundwire: intel_ace2x: fix wakeup handling
      commit: 79e7123c078d8f6e9e674d96f541ba696b2c156c
[2/2] soundwire: intel_ace2x: simplify check_wake()
      commit: a36ec5f7625d923212f7b869f7870616b15f20a2

Best regards,
-- 
~Vinod



