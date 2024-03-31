Return-Path: <linux-kernel+bounces-126077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C64A58931C5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D5B1F211D8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC493144D26;
	Sun, 31 Mar 2024 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Ry8cIYfK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rLQySQS2"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8B8286AC
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711893046; cv=none; b=VydDizrLJ75/7NagesiqMfwzEgi2bdDYVNogHnRijfLIx8fwBSTIN7RNYL0iQcPJSfwS3kmOkBls/qfCoE8q3MNG/CE62+14iv9q/5qdaXFwp58231Kry+ivSLqxiMpO27FUOPS2zv2xB70fwn6UVN3965+pzTD27A+XGs9eNm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711893046; c=relaxed/simple;
	bh=UGSq3lIkcfGQqu+sPW8JmoBRoaKiAZeVnrYw41WlCbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMoZ6FKFMZ054d1kGa9VAxpvfnrygSfcpL7J3Ok5l9frKhWsG4NVZxXF/RSvz7IHfngzkYMNV5rDsWKxW0TYrlaJEt55fIOIHKd8fjmEWZ47LLqPLnaQdF9atHp79Kn7d8aHaa51PTnLD0jHlq3UU2DdBP/3aEuIby9bcHNE024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Ry8cIYfK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rLQySQS2; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id AB3261C000A9;
	Sun, 31 Mar 2024 09:50:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sun, 31 Mar 2024 09:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1711893042; x=1711979442; bh=yK+9hUHpQM
	jdH5ZDxuuzhiGbvrbNehCv3hrwmuexcDM=; b=Ry8cIYfKdPpCVrSINlyAqbDxpq
	VyguBdMvHeR+QT8pREaXyyT4hP3aIh4FmWle0RiPD3jtTCxcXy8PZFGGOcIiS5BT
	RBOkZ2kLScQAccvD2UC2n4GiWppLwUxoBjnYNz0OZdBaq4vrB38/kGY+r1fXRr29
	RSLmy32Xh3BtCCRRGWBLpp8Y+XvNgeh7PzrdAGX26wXgnnfI13T+99Owqu6C2McY
	00u0DsYJNuBmGEl+5hfMb0My3pmAEBFgZVLPSlUWJBOlprD+neqrZbkrv7zivozp
	BsXVBfVv5fkohMYWDIKAaBmA7NkmhWHqC1qq5nAyXHghk3gZ9rGR8F68H1xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711893042; x=1711979442; bh=yK+9hUHpQMjdH5ZDxuuzhiGbvrbN
	ehCv3hrwmuexcDM=; b=rLQySQS2V4o5wna7fxTvcfjXwNLead+PfZ5GEaK6V6Wy
	mUmma0QSCDU0eH449z6O2YqQL9RulclMFIA4+4IGEbmQBLUMoANEYJydE/dEFThn
	40dYhkUIdMPH7mH2xUFHasNbmA0LFe4IJ1g/sjQsAwiStVM2/H7ZDiqqaHOAHlOJ
	l87wZoomaTjp/rko98y6iRouaSX18AhXXXjszZpZW6Xo7vDabBOAZu1UdnlLOmq2
	dsFupi1ktUQWIb8UMN1ehJhxcd9EadOwKSo9OrRyoxHMxEZ0GtJgYmd7jjBDFGXQ
	Irw5ZjfCotIPVzmD0GigdZnY+L/R/2RjdWn3ucDHtg==
X-ME-Sender: <xms:MWoJZs2YjAOGd5t4EQ1-UqW-WJxJXuT6qppJMvGhjQLp3EN0sbAWIg>
    <xme:MWoJZnFZF7_hXiqmqgEaHubAA8B6wRTDPVN7Gse24nkyWgz-KOxg_9VjuKCO0vSao
    vPURxyvXDHwP7uLEQI>
X-ME-Received: <xmr:MWoJZk7z2MBQXOawDRS1iHIRFp1fcXLvFW7_b-J57IkvWZNQIu95LV2bMQcmkrEm-9xusv7HYFFVuaS6DKYg3ytaBzigvmr5IBtsJYGtS9WH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvkedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:MWoJZl0Ywzt1VYBS_QzgnjlzMG61rs2qcrFzhtq40rBa7smuaLmi-g>
    <xmx:MmoJZvGx9BF85uXY0N6FPbQvqdfNtFcMm1f2Q4QffD_DWxWMEKQBLg>
    <xmx:MmoJZu_lIAbNEilAQZxoLqQ44gw_lpDE7hRcwHi9vMAqZwIu3DRALg>
    <xmx:MmoJZkkyiNd4_sxPDkK6fEL0_g2-ootSVq-eHwkUVu4v-zC0SwVhMQ>
    <xmx:MmoJZnB6QMvlQ4TQ1Rw5tJeY9ZjyMW8NPCmRu_kAnXRb0oqYpb3ao57dltE>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Mar 2024 09:50:40 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] firewire: ohci: obsolete usage of legacy API for IRQ request and MSI
Date: Sun, 31 Mar 2024 22:50:33 +0900
Message-ID: <20240331135037.191479-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The pair of pci_enable_msi() and pci_disable_msi() is deprecated
nowadays, while it is still used in 1394 OHCI driver in FireWire
subsystem. This series of changes is to use modern API sets for the
driver.


Takashi Sakamoto (4):
  Revert "firewire: ohci: use devres for requested IRQ"
  firewire: ohci: replace request_irq() with request_threaded_irq()
  firewire: ohci: obsolete usage of deprecated API for MSI
  firewire: ohci: use pci_irq_vector() to retrieve allocated interrupt
    line

 drivers/firewire/ohci.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

-- 
2.43.0


