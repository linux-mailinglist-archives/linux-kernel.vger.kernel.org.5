Return-Path: <linux-kernel+bounces-149002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76AA8A8A56
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62969281BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF024172BC4;
	Wed, 17 Apr 2024 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLgKguZ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186ED3AC01;
	Wed, 17 Apr 2024 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375519; cv=none; b=bQGud8V2EWccGd7xLy2Zqut9Ia4w9Ne3/KLlUX5f15hz+bNhYV4pBSep+VF3Of9avPy8bnGSy2SMAJPsrg6ZUrOA5NTFJNNx62f0Tg+dhQ+z3UbsTKdjQSqXitkAcp7A9tCERD01s6eSgaIqWQ7kPxU8R21xccUOoVHcEbkJeME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375519; c=relaxed/simple;
	bh=SmhAnxg6YLplDFHBEYB/c369CXI3faSrG7oPNm5pMUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuhefWobdIw/Hgqz0ioIBMp+DHDLTRR8GfyP7G+UzMuYm8wdpP0BqMXAehuJFaai3po7IAFM7A94F62lFyV4DfTTeHJp1p5dI12Yq9n1CFTdzm+3/u+jpDtwuFor5ByMe1Yc3RYpKgQi2OVInjisg6diTrpnlpu/Dpnt9GeDCVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLgKguZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC50C072AA;
	Wed, 17 Apr 2024 17:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713375518;
	bh=SmhAnxg6YLplDFHBEYB/c369CXI3faSrG7oPNm5pMUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uLgKguZ1lyP10YWtLiTwvvlzsBQYjclez+r5UogT9wGijmDUVnUKshsT3q1WTpQue
	 divLUth1If41UIe8Zus3pDxeGRRpkv43/ZXZiH8FAJh9QrFtgWAX/SoKffMRD87z4F
	 mMDRNF6pFccc7bwAQY2Y4kk6GLZ+TusrLCSkQHsOPfZDOMVAp0vhnrfG+ICKHuk9ot
	 kt0nDv5aCGRbaxNV7fmvjpmq+JcB012bSfPLLepz/Th2LtlV+eYF5U72f+ievmXts9
	 JbyIWjNkvVAaNZ6ILifmNwtBGvgGxe//cFxw9npBSI/BxYoQyxgiTCP04gWHwa2r3V
	 h0BfioPXwothA==
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	kbd@lists.linux.dev,
	linux-api@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v5 0/3] VT: Add ability to get font requirements
Date: Wed, 17 Apr 2024 19:37:34 +0200
Message-ID: <cover.1713375378.git.legion@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712080158.git.legion@kernel.org>
References: <cover.1712080158.git.legion@kernel.org>
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

v5:
* Use data types that are compatible with the uapi structure.
* Use _IOR to define a new ioctl as required for new ioctls.

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
 drivers/tty/vt/vt_ioctl.c           |  13 ++++
 drivers/video/console/newport_con.c |  21 +++++-
 drivers/video/console/sticon.c      |  25 ++++++-
 drivers/video/console/vgacon.c      |  21 +++++-
 drivers/video/fbdev/core/fbcon.c    |  16 ++++
 include/linux/console.h             |   3 +
 include/linux/vt_kern.h             |   1 +
 include/uapi/linux/kd.h             | 110 ++++++++++++++++------------
 9 files changed, 180 insertions(+), 54 deletions(-)

-- 
2.44.0


