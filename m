Return-Path: <linux-kernel+bounces-149794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8353C8A95EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E651C20D54
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A007015B987;
	Thu, 18 Apr 2024 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="jIfi2izG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CQtNw2JW"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9BF15B540
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432198; cv=none; b=s6aKR/hY0ejH/Rt3oquzikAHFovMcuuSdxvN9Qx0SM13awU7NvsUECRDFhf3noKSndtOLOBnf64Y4CcsiCEMjq52Xlq90bc7wJ0zvqixldSdBR9oZX1UV7yINwvunpg7JXUXRpFE/QZShaaOTs4ZdnSQ6TEw5Ap3CvsGUFUSPEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432198; c=relaxed/simple;
	bh=BMhHOcQY8g+TwTPW7002AhR/TKwJYegmVfbGlf5Apxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aa5A0NJFbnZdI+Gh44X2zMQ99LSuENslM3MR1rtegaD08O/cFIq6QzyDmWalqi+EzcyuYmdFeeZJgYhebXt00TpojllvKUrYc3LCM44tYODUb0VBBcVa5zZmYKLTZSJ3g24+b4Hx4H+676ND64Po5GQjZuZkZiYhcZwqEswJnKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=jIfi2izG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CQtNw2JW; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id E48D413800E3;
	Thu, 18 Apr 2024 05:23:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 18 Apr 2024 05:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713432195; x=
	1713518595; bh=Ch3r5I1OGhaN3NR2WiBicVL9fQRlnB4kPOlrYiq9EzM=; b=j
	Ifi2izG+opErxtlq1kluCFRTNVBuYqAC40jjFxOnCEDDt4IdTfhSzn4vk1OnW5Wu
	3vANSvwVG0ZO/rRQrp8KWt5QbHegA6fxaMnDMJys4eBlVqUR9lw3o1K+VIFpEusn
	wyENXjZ61/Jx1UPMtU2mLjUUXkpZkuUYxCw9ihWWLjTk85nDun66UmndiWx0wn2O
	1EajbgscrEQPfd0dvwruPLQtX3WHcslbv+KBgSIA4DGjwz3yVM4ECmMSVvab8Z98
	91gOKG8F8RSTnN8wmwbduJ4oXlWiqtGpQvmPZflmLO/cI+1ovH80szUiNHR/RqPX
	S96BhMji75d4+h0hIknSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713432195; x=
	1713518595; bh=Ch3r5I1OGhaN3NR2WiBicVL9fQRlnB4kPOlrYiq9EzM=; b=C
	QtNw2JW3dtmdRsqoy1e8ZQCk2xc8fRE2YwYT87hScjLP64ZGLpWmNai61iibqmgF
	p/vdTBd2az7MHorz9ZMP9SxJTPNKN57qMNBXVyeknF0byqTgeSLUfCDglCMsTISG
	EEvPhCQqmSk8OTorLTZlsy/osAAXpqVo+84he/PuB9XSwF1pIXy4Y725xFU8eJai
	g/x2rniFkOV/Q8yWhSrRUk/6+JTn3ABDb9jjHbUVagxST7BA5S+YDwUEjK/PTe+0
	0pjgTAXGWG6RRWGRDdeNNFsNEYJEGq8R0S4mumXFK3UGH+HZ9zcYIy8eR8lr89AI
	A/+A1HGMLcwqDEHqhBq9Q==
X-ME-Sender: <xms:g-YgZvzeZ3feDVMruq6qQ-v5c76KeNuRsAoy54yLS2RhZW_Z8JiTPg>
    <xme:g-YgZnR11ola8A6MAcULSze7eBuUOMQeTpwGR6dfbI87d6tysz8HmuvnR_cjB5gwJ
    UJnhkPDvSBIrfIv3Vs>
X-ME-Received: <xmr:g-YgZpWSJjTV0uYvjEM0XMSdooyN8nfJy_Hl-FgstEhILM49A2sQ6axY5W_ngvMU8KdW_aM4ZsgRrc-CZ8QpUpiQBEFRSFoCwai_sOrd_BsSTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:g-YgZpizXXhS_YT_2sVU4Zp2w0CXNjgwykzLebNUpCKZhiu8lmlQkw>
    <xmx:g-YgZhDMowu0GqsOhCoWr9SVquRPBrzi48DaUomJa9iIAQTcJFF2Ww>
    <xmx:g-YgZiLfup3x_uI3al_Y_Nsy4vjxy1jMrZEBLRTyhQjYVmtzk7AJpA>
    <xmx:g-YgZgAf_67DwJ3uY6VunhyFf6qiWsDD8FgS3bT1LvohZh30f__DkA>
    <xmx:g-YgZkNL9mb4-ClTtml4aQoOmfsQAt-mZt4f2_pzWSXIq_mzZZiXjFpc>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 05:23:14 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/13] firewire: core: obsolete tcode check macros with inline functions
Date: Thu, 18 Apr 2024 18:22:56 +0900
Message-ID: <20240418092303.19725-7-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418092303.19725-6-o-takashi@sakamocchi.jp>
References: <20240418092303.19725-1-o-takashi@sakamocchi.jp>
 <20240418092303.19725-2-o-takashi@sakamocchi.jp>
 <20240418092303.19725-3-o-takashi@sakamocchi.jp>
 <20240418092303.19725-4-o-takashi@sakamocchi.jp>
 <20240418092303.19725-5-o-takashi@sakamocchi.jp>
 <20240418092303.19725-6-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit declares the helper functions to check tcode to obsolete
the functional macros.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c |  4 ++--
 drivers/firewire/core.h             | 21 ++++++++++++++-------
 drivers/firewire/ohci.c             |  6 +++---
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 01ce07f87452..24febc23c0c4 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -972,7 +972,7 @@ void fw_core_handle_request(struct fw_card *card, struct fw_packet *p)
 	if (p->ack != ACK_PENDING && p->ack != ACK_COMPLETE)
 		return;
 
-	if (TCODE_IS_LINK_INTERNAL(async_header_get_tcode(p->header))) {
+	if (tcode_is_link_internal(async_header_get_tcode(p->header))) {
 		fw_cdev_handle_phy_packet(card, p);
 		return;
 	}
@@ -1109,7 +1109,7 @@ static void handle_topology_map(struct fw_card *card, struct fw_request *request
 {
 	int start;
 
-	if (!TCODE_IS_READ_REQUEST(tcode)) {
+	if (!tcode_is_read_request(tcode)) {
 		fw_send_response(card, request, RCODE_TYPE_ERROR);
 		return;
 	}
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 95c10f3d2282..7c36d2628e37 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -225,13 +225,20 @@ static inline bool is_next_generation(int new_generation, int old_generation)
 
 #define TCODE_LINK_INTERNAL		0xe
 
-#define TCODE_IS_READ_REQUEST(tcode)	(((tcode) & ~1) == 4)
-#define TCODE_IS_BLOCK_PACKET(tcode)	(((tcode) &  1) != 0)
-#define TCODE_IS_LINK_INTERNAL(tcode)	((tcode) == TCODE_LINK_INTERNAL)
-#define TCODE_IS_REQUEST(tcode)		(((tcode) &  2) == 0)
-#define TCODE_IS_RESPONSE(tcode)	(((tcode) &  2) != 0)
-#define TCODE_HAS_REQUEST_DATA(tcode)	(((tcode) & 12) != 4)
-#define TCODE_HAS_RESPONSE_DATA(tcode)	(((tcode) & 12) != 0)
+static inline bool tcode_is_read_request(unsigned int tcode)
+{
+	return (tcode & ~1u) == 4u;
+}
+
+static inline bool tcode_is_block_packet(unsigned int tcode)
+{
+	return (tcode & 1u) != 0u;
+}
+
+static inline bool tcode_is_link_internal(unsigned int tcode)
+{
+	return (tcode == TCODE_LINK_INTERNAL);
+}
 
 #define LOCAL_BUS 0xffc0
 
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 85223a1c90a1..77f098fb9484 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1382,7 +1382,7 @@ static int at_context_queue_packet(struct context *ctx,
 					(packet->header[0] & 0xffff0000));
 		header[2] = cpu_to_le32(packet->header[2]);
 
-		if (TCODE_IS_BLOCK_PACKET(tcode))
+		if (tcode_is_block_packet(tcode))
 			header[3] = cpu_to_le32(packet->header[3]);
 		else
 			header[3] = (__force __le32) packet->header[3];
@@ -1568,7 +1568,7 @@ static void handle_local_rom(struct fw_ohci *ohci,
 	int tcode, length, i;
 
 	tcode = async_header_get_tcode(packet->header);
-	if (TCODE_IS_BLOCK_PACKET(tcode))
+	if (tcode_is_block_packet(tcode))
 		length = async_header_get_data_length(packet->header);
 	else
 		length = 4;
@@ -1577,7 +1577,7 @@ static void handle_local_rom(struct fw_ohci *ohci,
 	if (i + length > CONFIG_ROM_SIZE) {
 		fw_fill_response(&response, packet->header,
 				 RCODE_ADDRESS_ERROR, NULL, 0);
-	} else if (!TCODE_IS_READ_REQUEST(tcode)) {
+	} else if (!tcode_is_read_request(tcode)) {
 		fw_fill_response(&response, packet->header,
 				 RCODE_TYPE_ERROR, NULL, 0);
 	} else {
-- 
2.43.0


