Return-Path: <linux-kernel+bounces-100345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B2A8795FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9CF1C21D27
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DD67AE6C;
	Tue, 12 Mar 2024 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG4TwGYy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F03678286;
	Tue, 12 Mar 2024 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253452; cv=none; b=DcuJkG6SgXYI13YRmN4YKja8o1tHpKeplgp7WIkWLuw1vROADVYL9XeukdLlVvG0mgY6LAYvAFsUoYNJu/nhGQSLKtIxufI/vvW1Pr21dKwE8Z+Q9Esotj7ThFcNq3C4awQJcsy8+vWQp6yiCN8Wk8CCbheC8R2YorB+trDKBvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253452; c=relaxed/simple;
	bh=qpr3oDr5denGURn+3TLpW0eVsEAWpGD6RfS4albEsBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooAEr5gvcUhLnodgSc08Q9aN1pR+vXrLb4fTCq63iAJQw+tx4cjantRwgOp0cbHKcfiJFsF80XzVpTMvzk9V7oY4kNaybeTGfM+xZDgZm4fYWZjivKPe7/SbIp/sNo27mQR9RkS5cemMKkTHJ2i/iyjKU5pXNojLRthnj3RPM0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG4TwGYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B519EC433F1;
	Tue, 12 Mar 2024 14:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710253451;
	bh=qpr3oDr5denGURn+3TLpW0eVsEAWpGD6RfS4albEsBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gG4TwGYyOAJNWY3JrsgJRCsHgbB4CJ7VnI46zq3sEoMoeXjtYfna6hEM67zCPXI4Z
	 UZeaOaU2zyGISvFxdri98/FssO/Vu4v52BaYLlLf6oKttIeolEUDvNFxinvvkN1dAu
	 Nqm3wgKMvEIiMVp1YIWaZk5k+kPFYOn2k7tG2EwCXSAXoPtC9EQD0onVSfKJNk/O4j
	 gocIj5rJzoE0z/xXMA7PAYnfkpnY1JiNBAoirLlrjERtizhn93REUYYpcmf8mrvbfg
	 tsVhkEkz/Ff05dQoKH4nokHVQabLDcyNdYaUUqtreFWAa/Naykn7e+zEgVvVtpX0+U
	 uq2l1H0Z3ihUg==
From: legion@kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	kbd@lists.linux.dev,
	linux-api@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3 0/2] VT: Add ability to get font requirements
Date: Tue, 12 Mar 2024 15:23:56 +0100
Message-ID: <cover.1710252966.git.legion@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1708960303.git.legion@kernel.org>
References: <cover.1708960303.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Gladkov <legion@kernel.org>

We now have KD_FONT_OP_SET_TALL, but in fact such large fonts cannot be
loaded. No console driver supports tall fonts. Unfortunately, userspace
cannot distinguish the lack of support in the driver from errors in the
font itself. In all cases, EINVAL will be returned.

This patchset adds a separate ioctl to obtain the font parameters
supported by the console driver.

v3:
* Added the use of the in_range macro.
* Squashed the commits that add ioctl to console divers.

v2:
* Instead of the KDFONTOP extension, a new ioctl has been added to
  obtain font information.

---

Alexey Gladkov (2):
  VT: Add KDFONTINFO ioctl
  VT: Allow to get max font width and height

 drivers/tty/vt/vt.c                 | 24 ++++++++++++++++++++++++
 drivers/tty/vt/vt_ioctl.c           | 13 +++++++++++++
 drivers/video/console/newport_con.c | 21 +++++++++++++++++----
 drivers/video/console/sticon.c      | 25 +++++++++++++++++++++++--
 drivers/video/console/vgacon.c      | 21 ++++++++++++++++++++-
 drivers/video/fbdev/core/fbcon.c    | 22 +++++++++++++++++++++-
 include/linux/console.h             |  2 ++
 include/linux/vt_kern.h             |  1 +
 include/uapi/linux/kd.h             | 13 ++++++++++++-
 9 files changed, 133 insertions(+), 9 deletions(-)

-- 
2.44.0


