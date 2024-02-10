Return-Path: <linux-kernel+bounces-60385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A2F850445
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A2C286F03
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973A23D54F;
	Sat, 10 Feb 2024 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="D1YXoRzk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L6pK3QoM"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D388D31758
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707565712; cv=none; b=L2ODpAmlu1JZiyjNQAhOE2VMVaafrO008bjpQUDQjZL0MRyRGSTaaBl0+AsIErC7JcptVAbDrFLZpIjnHo/YblaHi6OVyz9+FHhcbMVAcVb7U9SGphn9OPBVnasFTMQsVZDjy+B80qIiQ0yMLc7mg1jAgyS+IhIBD0YlRkpDMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707565712; c=relaxed/simple;
	bh=MihVoYtGwvarY1NAUWe7UAGDAEyvfsWWdAHm9oZYTCo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t2g0KEf0B9+mDPvai3cvHmVhBCcmxDLWxo8ExSCg2F13/aQdDzrdouYnqar19mhy/kgKH1/HPogqEdgYxwEESga95OlCmmtK2rE/1V0rYxqbsLK4t/XzQrgWxPYX6oRQaOiiYMZxHvQVHwnrLAmg0fM9bBX687q8Wxm2hkN7Cl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=D1YXoRzk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L6pK3QoM; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id B8A5D3200A3D;
	Sat, 10 Feb 2024 06:48:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 10 Feb 2024 06:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1707565708; x=1707652108; bh=eKK04+8zCGmPQxy8HfiqK
	sP7A3QJ6HFTmqFJcvAA4qk=; b=D1YXoRzklCSV6Eq/eBei74Kv8gUeFysppehbc
	/QxwxThiiH0TBCdp/90LmwUYL8BOAkfm48L3gODU/XWfsHvxVwIEhINzIq5mfweX
	wCYEwTB3W9LLVXgIAC/4E7WtyoBcNBAAPAahATbwTv3Qg8pTGN4KE1Ky3PNFzUki
	FL7wiXr63GdB9hvgfMgModfDbr1LDb89P68E1Yq6cwD3b854Wu03rCKqGWmcNL8p
	Z+QxM4XUON12wQ95C4WjjAzT0EsrAkHwSt6EqtPlakA7DMBrfsO05bO6hsVhwn9A
	/bgO+QdDoeYUPOjZtUsDWw+UGoqHRseS1LXiNfczqQZ/ALhgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1707565708; x=1707652108; bh=eKK04+8zCGmPQxy8HfiqKsP7A3QJ6HFTmqF
	JcvAA4qk=; b=L6pK3QoM/jvT0d2aRHvNKxCnmMOUImvFUISE8MovWihQgc4tO/w
	jT3D6WXK+AAycpvDtgzuyn1XayEPIx0VSqStASvGodKG2jXOn92/5ybcAnJLF3IC
	Xjn2phpvdVrQaRbUevVZLdBPqIMihEZqvmoeIx7Yj9o2WeKSJpVDXRFpVP+0EDTU
	phmMfRz8vDahEpxbNtw5jPhlIbLn85xbSqD7S+44HGLcs8t9BF1RS2PfYUSRxIEA
	3E9R1INhZkgU1JmW135PmVaBTmU51u6Sr2EfSaw5VXbIojLw8EeGNP+LKlanXfvR
	8aSsVat0I3Ad24vK03QeOXQmH4FQG3SMuRQ==
X-ME-Sender: <xms:jGLHZVB0PANQ7rBNR0rLgj4qg7ZxVnUarAlvXlqdiekzoI1aTp1MxA>
    <xme:jGLHZTiC85IxNjcOHphC8GS96vOeI2F5GMta0pdHHF94diBOJ0tDBowKLAbk6y2il
    ojcWtPKgG-EknjYo8I>
X-ME-Received: <xmr:jGLHZQkaresjGGdrnSJZeSqOWWUVTvGhtAgAOqgGSSoieQdb67_vJ0aTEdtmSHUDOgYX5Yifm69FNiYQTADFCk7YTIth2Bia6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdelgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepteefieetfeevge
    dvgfegffehteeljeekkeelueegfffftdfgtdetteekvedvvdfgnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:jGLHZfyXR_GmavMme6O3yioAvZpBvzdpJuAvkfuilRx1TDIdDzVKtQ>
    <xmx:jGLHZaTim-6n--v4SU1LF5_6Lc0EkiadIvU-h-tR-zmAHBTeQow7Lg>
    <xmx:jGLHZSZ0FU7mUJmTi6UWJK2y5SZ_0bZ9GWEMTlWIceb7HSdm-bekFQ>
    <xmx:jGLHZT4PFmeRK3niFrMXRoPkB-hNCmlVZ1_BoVhhCFX2LbtnbNDZMg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Feb 2024 06:48:27 -0500 (EST)
Date: Sat, 10 Feb 2024 20:48:23 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] firewire fixes for v6.8-rc4
Message-ID: <20240210114823.GA114914@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.8-rc4

for you to fetch changes up to 7ed4380009e96d9e9c605e12822e987b35b05648:

  firewire: core: send bus reset promptly on gap count error (2024-02-07 08:20:02 +0900)

----------------------------------------------------------------
firewire-fixes-6.8-rc4

This pull request includes the change to accelerate the device detection
step in some cases.

In the self-identification step after bus-reset, all of nodes in the same
bus broadcast selfID packet including the value of gap count. The value is
related to the cable hops between nodes, and used to calculate the
subaction gap and the arbitration reset gap. When each node has the
different value of the gap count, the asynchronous communication between
them is unreliable, since an asynchronous transaction could be interrupted
by another asynchronous transaction before completion. The gap count
inconsistency can be resolved by several ways; e.g. the transfer of PHY
configuration packet and generation of bus-reset.

Current implementation of firewire stack can correctly detect the gap
count inconsistency, however the recovery action from the inconsistency
tends to be delayed after reading configuration ROM of root node. This
results in the long time to probe devices in some combinations of
hardware. In the pull request, the stack is changed to schedule the
action immediately as possible.

----------------------------------------------------------------
Takashi Sakamoto (1):
      firewire: core: send bus reset promptly on gap count error

 drivers/firewire/core-card.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)


Regards

Takashi Sakamoto

