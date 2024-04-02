Return-Path: <linux-kernel+bounces-127734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E42F895027
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4005C1C22317
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE075EE97;
	Tue,  2 Apr 2024 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqqrE//5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D8640876;
	Tue,  2 Apr 2024 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054038; cv=none; b=M3++QXcxqVacBZ/Wk6/q7EzQ/h/ERILiY0HAPJH60Q7U21Q63TIIBbRxDflieGS4co5NDyytfjELUcpFiVyWKdKFx7qadySOzCipmDn98dX4cG13yJFo2JsTgMvH2nccZZiuuM7KEhrgT216gU3wtW1Ed/8KS0szweyYoT33FKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054038; c=relaxed/simple;
	bh=yQyyvLBf6qblD2zMLzpTiUQ5VLhVLtMWd/58b3xOqH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnMsOcgK79h4Iu8zNdboNoL6YLAFYQ3yEfXNvw+LCaiLIU7nn7O/lPDSe7udE7/7OMtXu6SG1PSrqtB7d1fbQ9j5lAxXn3Ibmn4KjH5ajEVgjVJF7R4LJ10oVwZhdhM1rYrKD6AQ8v5imaSf/IXgGcwNVBMFq3hAZyCdF9ECTV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqqrE//5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D805AC433F1;
	Tue,  2 Apr 2024 10:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712054037;
	bh=yQyyvLBf6qblD2zMLzpTiUQ5VLhVLtMWd/58b3xOqH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqqrE//5SJDwMvCp7dcysivY9PxZ3BLYjLA0F7XvCFrOolIJn+W5qpGVdVeLCm5BD
	 0dkdtB/G7edTOEdRoG595l19Q1F6CAt/oysQowWnyoApE0RalMaglp4GEhd6pKPeHX
	 Pcb0hOpU07Hn8Od0a8Uv6CFnS8p67uwJ0yusCVlgVzCyocrxxoW+P9QDJecLeXkJSf
	 GzzZTfHhMfZfwgOd86LXptC4U3zM3qEQbSSYyUCN9b56CBpnz7adFvYwzqykDzuXC1
	 c3VopP4P4Dzw/5W95ot/HH2Zxf7TKmbVuhNplVbr8Nr5SLEDYBEewa6d7hdVL37ReE
	 sMysE3HSW3/Ew==
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	kbd@lists.linux.dev,
	linux-api@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RESEND PATCH v3 0/2] VT: Add ability to get font requirements
Date: Tue,  2 Apr 2024 12:32:55 +0200
Message-ID: <cover.1712053848.git.legion@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710252966.git.legion@kernel.org>
References: <cover.1710252966.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


