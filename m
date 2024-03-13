Return-Path: <linux-kernel+bounces-102350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A45DF87B10E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B34B1F26AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184CA60DC5;
	Wed, 13 Mar 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Ok5xKUZj"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7260DEB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353994; cv=none; b=PvJ6CbPRG1MyA18Rdza16VIMAxGhQWGmOLk0sTHGY3/GjTK5voLPisRTgd1eeKkHoO1+n95RhDOqFb++feRzvEZyMHQCWH999e+eL0UNglUu6LNiRjgVLKhNNM/U1cm37yCd6f8DVZLqlLurtKaTlPrfbI2pYHS6CC18O8Rnigw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353994; c=relaxed/simple;
	bh=cvQy2hdsjxT1Hk2jZWw0UxHUbPbNzQYuEGGLuOn84so=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=SW8k4h08H5wbe0+Cne5Eun8z2LPcie96jStlcNFN7QflcERxpgftvfPYBmcmg0cUBm+56oIsPLPsEvpZ/5VOAubNszdXz2F7ltxyghQ30czm8sMPWeyA6TgOfx+q47LD2WeAZ/U/qS/17uYSLZvQ1RpWd+Atjy/DwOPTOpkl0Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Ok5xKUZj; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1710353981;
	bh=cvQy2hdsjxT1Hk2jZWw0UxHUbPbNzQYuEGGLuOn84so=;
	h=From:Subject:Date:To:From;
	b=Ok5xKUZjipkuCzydzpUbDht4Apg58XFO0mXgZRk7K9cnES3ATTVwXxfmeLzsRc8xM
	 rBAu5L6iqEOJ9mMus4qCld6kQyRPYTrOXjxDPd5rP+WjMPIejHa8Fs8k9sEpmkB9NJ
	 VGOECH+Iw9q3wM1bCWTPKViYQM7YhIa8Am6r5AxE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] misc/pvpanic: shutdown event definition
Date: Wed, 13 Mar 2024 19:19:29 +0100
Message-Id: <20240313-pvpanic-shutdown-header-v1-0-7f1970d66366@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADHu8WUC/x3MTQqAIBBA4avErBvQJgq6SrQwnXI2JtofRHdPW
 n6L9x7InIQzDNUDiU/JsoUCXVdgvQkro7hiaFTTKtKE8YwmiMXsj91tV0DPxnHClrpZkaVeOwW
 ljokXuf/zOL3vB4f7nrlpAAAA
To: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710353980; l=1240;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=cvQy2hdsjxT1Hk2jZWw0UxHUbPbNzQYuEGGLuOn84so=;
 b=uzR8fB+3/FPiu663qkljyVpfNYocEBC5MVCTjtjH8by7JINODFWxIOl71sKqPvIRD1MuKq4vZ
 CP1uL3/EVYHDw1UVyDFfxYT+OX3mxmjRiE74cyEIsjbo0vhtUwyDUwm
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add the definitions for the new PVPANIC_SHUTDOWN event that was recently
specified by qemu.

This is only the event definition to get the series merged more easily
as that is a requirement to reimport the header into qemu.
Which is a requirement to start the hypervisor implementation.

Any chance this series could make it into the current merge window?
The headers are imported into qemu en bloc so it would make sense to
do it from some more stable base like an release candidate.

Patch 2 was split out from my previous pvpanic-shutdown series and
patch 1 is a preparation asked for by Greg.

For a discussion about where to place the definitions,
see the original series.

[0] https://lore.kernel.org/lkml/20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      misc/pvpanic: use bit macros
      misc/pvpanic: add shutdown event definition

 include/uapi/misc/pvpanic.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
---
base-commit: 61387b8dcf1dc0f30cf690956a48768a3fce1810
change-id: 20240313-pvpanic-shutdown-header-436b03c371d0

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


