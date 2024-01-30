Return-Path: <linux-kernel+bounces-44348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D07842091
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419DB1F2BF32
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB0D60885;
	Tue, 30 Jan 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="P+3lV22C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dBO9EM4Y"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6057867
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609059; cv=none; b=MyilJukOesmzGJ969j2TN1/MyHjsCtGNo0SJtKVICJ5b62inaBVoHg+/eOKb/vGaU1ijCTAqCcjIy5mrg319Xj7F9elWV6z/PolmCZpg5DfwJTz6AMtEv33e2gqUtzgK2oFLWO5XP33MeFQFZjBFXDOzlXlKoK0srVRN4kxYdkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609059; c=relaxed/simple;
	bh=3w8BIDNYwmsOMQgds+zKKQvqmE+c39tBnyoZ0jKXAuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fPZ/gYKZeO2b4t6kwQ5TjKfjQ2phWa74452cxz1JN83KloV7lS7iFEBrrndLZkbJuTMrrtt/RF2TTvz7eIa1aKcugz307nEt9P97IzrP4vLbIUW4oE5gjoniRQL1Xk266YF/mlyRsuElWhkQFeSrrJzZi/rOSsYO0lKReVL/YWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=P+3lV22C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dBO9EM4Y; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 441433200B3B;
	Tue, 30 Jan 2024 05:04:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 30 Jan 2024 05:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1706609054; x=1706695454; bh=vkYxaFes1o
	ZgW4Bo/+u9h7Rx+x8nZ07dK3dg7jhwa6E=; b=P+3lV22CLGLfCDfpvDORyKC7Hc
	QoBR3AGzjqhAPXOKM28UfXvq7hR+uHFl5HUiKR97N9slT02UbDp2aWjDNsy+sBqE
	mNfBcjMmLEZxjnQWeCBL7L/iBDr3IkOpUQdtUDRiHumnLFaRjtx9N+hHtq/Xd+tp
	6uSGldMzuoZWkzKxk+/VfqXqC/7xcxx+f2tID4LNXDrOFjPh5IrB6GRvkzo7JHjw
	lNgAiZvE3yT18PcnUpyFiQ+0HxcCWf8LV1IkV2iN8CVMWyDK2UNBTebwcfA3TA9G
	qNMji/VDodSLSUF00aQa3+e4Chb571joenbA0ewd3PDaB4Z+pDDcLuSvbX/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706609054; x=1706695454; bh=vkYxaFes1oZgW4Bo/+u9h7Rx+x8n
	Z07dK3dg7jhwa6E=; b=dBO9EM4YWxLTID2Y2gGjFNZi5YJ/s/tWtZ+afCI5RhLP
	YAxoGO6bqgNb2uKsV0zaRnHL//DT+BWT9hmw1kablSuk54H6igXWodPP1fN+WoVc
	j/FeXrgjspA1wa0nX8kMVTFOtbPmmRB9pc3pIJzS8DxptowSnWXHTUU+o70YSMaK
	foXZhioTC/daH0BITGocVwVt5+Sxm1xRXTWaY7HRxdsx0u0PoIQ55TM+AdypnnmI
	9E+Sk/3QN8su/dS3i8JPgfWBACQGO10FpTpCzBeI6Pijkw43HwXNuzRCIKcswpPK
	EC0gXoEFjOXR0/kC35ZM10d02nuab0MFt3pu6U0EDg==
X-ME-Sender: <xms:nsm4ZQ2KvezJle_DV1wnbtNS0X828sTDVWclf3iblOOLRtFmKn3Rdg>
    <xme:nsm4ZbGRregntRQjEhM2HBcZ9obCYGE5nzMdtGlU5TWQ-426THhSnDoqL2HwrCW27
    Fb8W5ZakwmJmVswcBg>
X-ME-Received: <xmr:nsm4ZY5mWMe1gxKjBoWc2CKG3buiY5cIG8ZAHCtlVc5mZ49441uFtti--KVnML9RCDAfxrRUzYPXNVAd8uzddiiK07asUxzd_Cjdp44PHo62>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtiedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeukeegvefgie
    ehfefhtdethfevjefghfeileehffefgedugeeigfduhfekgeehueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgpdgrrhgthhhivhgvrdhorhhgpddufeelgehtrgdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:nsm4ZZ2qkkB5vbHucH_cT4PcnDwwn-v1C2pE4Cl495yUv6JPk4Jwig>
    <xmx:nsm4ZTF3u-6yPlSZB0DewHpeLt-2UBc-vBWHoo1bI8_rBVlWNqcYfQ>
    <xmx:nsm4ZS9i-vIq869PDhPNBzR3SAx0kKtP0BgYRvdCJkLpCOWfFvsVgA>
    <xmx:nsm4ZZOM57Hq8kVZ_8P_nHbMk5kSQ_z-ecBHkocf1Ba3R3c7SAu_vw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jan 2024 05:04:13 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com
Subject: [PATCH 0/2] firewire: core: optimization for the quirk of Sony DVMC-DA1
Date: Tue, 30 Jan 2024 19:04:07 +0900
Message-Id: <20240130100409.30128-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A quirk was reported that Sony DVMC-DA1 has a quirk in its configuration
ROM[1]. It has the legacy layout of configuration ROM[2] with the quirk
that the descriptor leaf entry locates just after the vendor directory
entry in its root directory. It is not the layout in the documentation
since the usual descriptor leaf entry locates just after the vendor
immediate entry. Current implementation of firewire-core fail to pick up
the content of descriptor leaf for vendor name. 

This series of changes is to optimize for the quirk, including a slight
correction of documentation for the relevant kernel API. The changes
are written to be accepted to the release candidates of v6.8 so that
they don't conflict to the changes in for-next branch[3], thus they
do not necessarily have a good look.

[1] https://lore.kernel.org/lkml/20240126011705.GA22564@workstation.local/
[2] Configuration ROM for AV/C Devices 1.0 (1394 Trading Association, Dec
2000, TA Document 1999027)
https://web.archive.org/web/20210216003030/http://1394ta.org/wp-content/uploads/2015/07/1999027.pdf
[3] https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git/log/?h=for-next

Takashi Sakamoto (2):
  firewire: core: correct documentation of fw_csr_string() kernel API
  firewire: core: search descriptor leaf just after vendor directory
    entry in root directory

 drivers/firewire/core-device.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

-- 
2.40.1


