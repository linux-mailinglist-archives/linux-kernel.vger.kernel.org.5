Return-Path: <linux-kernel+bounces-133101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A91C899EDB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF705B2172C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F8016D9C1;
	Fri,  5 Apr 2024 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EpuP4K0V"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6016D4C5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325497; cv=none; b=gz9YfjVHg/8Xapczn5qY2ta2WnQIKUstObRYI7ONUp7Lw2imrBrx1Pzsy4+8P1Q49BXdW6a4Va0x8wNIut08fARn+tWmz7+CQoH3wKviYqcyDV0MzOp5ipvEXg4qWcdWrZZc20QVlKHAmWCiyI7/qTLcM/KiyPt6DefoI1NQGN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325497; c=relaxed/simple;
	bh=sqqgEu6lEH3lsouDnOTSlnsnADaGQFVT5jr/EVD56e8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QlaO9pTezcCbx9ldC5nUXezwwC/dm5aPelGN45Rd4LXKTCdojhWlpSKOKvP1TKS/HnzIIF4BLvwasXEVkyANK+6sOliqX9YpcSxxH07Y+YYNeARnRrSYA563pbAvLtOgLUdgm/72WTcHKFfgPOyLtEkYU3meNUvfpC19CkVDsKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EpuP4K0V; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712325494;
	bh=sqqgEu6lEH3lsouDnOTSlnsnADaGQFVT5jr/EVD56e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EpuP4K0VVVnXP5RJwSUsYUvswr0diIrWWZiXQ4o0+HTr0vwZWwJAG4r6kfexwXhn0
	 wUMCL8EbH1lJVcSvHbsg/2fZMzOLTw4zegmz+OUq8PeiR7ahvtqVNyQJB/wJsXHtHL
	 NdaUfZk/jhU2HhniGNVEOO2d1EwRTLFqXYeDBD3OW8vrkyeRifSwqB5aStGpElEEJg
	 EyQFO6/m517ou453WZf4JD82X8x8cR0v/Nm/JS52LGAyk6TOmgwUwQFhOz7uhTyhpN
	 fs/80Rt+pEeclMJ0YKqVxSmdMic+DuCSwxRlks/uOnAMIIJRIpKuc6voNP7msEeBqh
	 9v1jE7EZJU92g==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6949D37813DC;
	Fri,  5 Apr 2024 13:58:13 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: tglx@linutronix.de
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge Chromebooks
Date: Fri,  5 Apr 2024 15:58:37 +0200
Message-Id: <20240405135837.306376-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87ttkg7wvg.ffs@tglx>
References: <87ttkg7wvg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 4/5/24 15:38, Thomas Gleixner wrote:
> 
> Can you please boot a working kernel and provide the output of:
> 
> # rdmsr 0xc0011005
> 

Sure:

# rdmsr 0xc0011005
2fabbfff2fd3fbff

Thanks,

Laura

