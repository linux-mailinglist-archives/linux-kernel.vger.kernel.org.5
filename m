Return-Path: <linux-kernel+bounces-128460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEB7895B1D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8617828662D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FB215AD8A;
	Tue,  2 Apr 2024 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4lAQWCO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8638D175A1;
	Tue,  2 Apr 2024 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080281; cv=none; b=BB9Eo8mNrMThiEsCp+iwn2sWgrY7HMkcd2ZhWd0LRWGloA0pnX8XriPc9uoImoAo0/v2QF577RKh6Ik5Gq020QJZ8rk+zjaGpBgp7A0/RC76seFq7yeNbGomnjoTdxeloEt2/UN+zqJm4y2ROB/Cgx19cTMYmE+8YGFcKx34bJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080281; c=relaxed/simple;
	bh=pbmjb20B1InrpmiwIan89p4AaKAD2iHVwkaPjFQm56M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCqWYqy6uLGci/6JTZZZDvYBqUlBRZgxARqA+RihY2ROOlSGU1ZbKCPHygOrVz8oXz5iH5ZbHdXXBmfL5m8Kd70Foc1kETfsRJ8TSDIv7vZQN5e3XMHK6EmIGPuSNkjEUN9TEzY6+8vNUiErtjVawpTFhuVSenrYpqYub1w75jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4lAQWCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6627CC43399;
	Tue,  2 Apr 2024 17:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712080280;
	bh=pbmjb20B1InrpmiwIan89p4AaKAD2iHVwkaPjFQm56M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i4lAQWCOpgw/0kB5CqskoMyMrSicQqcqLmj7z1KISVBlyIoEsH68NdanqtndCHE9F
	 /n3diSDDmwW76s0NROrTwRk70a0EM3JZ3Di6Y+KDVoa4bwv8QSne9V7KWkwO4zZeVt
	 QI6rCRDH+yl2ADHt9hx4tsLS9tXWwuPwhIjpR6QTwul0FmsfULkSVru+f8+sDFCTD8
	 J4iScOzBf0j33z6h7BOqeaQobfxzHdRaxSFw6YYNj2kKXToemm54WfTbjWTaLYthvD
	 HUDHxvOcgn+Z5x+Uje5nhFtCsOGCFLrssqmcSyKkH5KTd8s9SmhgTtNbN7iV3OJ1Um
	 0tU+Ok1B7kqgg==
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	kbd@lists.linux.dev,
	linux-api@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 0/3] VT: Add ability to get font requirements
Date: Tue,  2 Apr 2024 19:50:43 +0200
Message-ID: <cover.1712080158.git.legion@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <74ca50e0-61b1-4d4c-85dd-a5d920548c04@kernel.org>
References: <74ca50e0-61b1-4d4c-85dd-a5d920548c04@kernel.org>
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

v4:
* Rebased on v6.9-rc1 and conflicts have been fixed.
* Do not copy KDFONTINFO data from the userspace.
* Header include/uapi/linux/kd.h uses _IOC macros to define ioctls.

v3:
* Added the use of the in_range macro.
* Squashed the commits that add ioctl to console divers.

v2:
* Instead of the KDFONTOP extension, a new ioctl has been added to
  obtain font information.

Alexey Gladkov (3):
  VT: Use macros to define ioctls
  VT: Add KDFONTINFO ioctl
  VT: Allow to get max font width and height

 drivers/tty/vt/vt.c                 |  24 ++++++
 drivers/tty/vt/vt_ioctl.c           |  11 +++
 drivers/video/console/newport_con.c |  21 +++++-
 drivers/video/console/sticon.c      |  25 ++++++-
 drivers/video/console/vgacon.c      |  21 +++++-
 drivers/video/fbdev/core/fbcon.c    |  16 ++++
 include/linux/console.h             |   3 +
 include/linux/vt_kern.h             |   1 +
 include/uapi/linux/kd.h             | 109 ++++++++++++++++------------
 9 files changed, 176 insertions(+), 55 deletions(-)

-- 
2.44.0


