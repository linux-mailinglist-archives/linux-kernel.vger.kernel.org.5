Return-Path: <linux-kernel+bounces-149792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2088A95E6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746691F22382
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD3D15B15F;
	Thu, 18 Apr 2024 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="FVFsBQeB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a2zP58PE"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B015B0E6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432195; cv=none; b=NEEygHFyzcBs2hriLPZfUgUGVySXhvB1R4RzlxzKffbqhvUkTwg7JAHRrpOqKAqfA2i+y+X3FDiAJ6im3lTxMpEQ27Ap42DuXJ06ZZn4bjVHJxAN3/YbgpMUEfBPJ9h6yldL+vh/FNbwXTeUKy2D1KmcKIixkXRA/ms1vd31TBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432195; c=relaxed/simple;
	bh=8HGexJrybZEHpIio4dXK/CudntV0afWOeeqQfNDkObI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctDaoschXr7nLfk8RIGJ0Cj+Bb3Lv+PTXaHA04nkHrSUztYyc9aS7AG1Jb8uF+ZATS+Zp4dQaLFNZv2FuWkfLuezA1eF76Nyq5MFjyc1tZv6mbTMaIppL5Gxfjvvqxrw2ajur0vh02UM3Ob214cQy1EVCYaaS3logLWRZaDcr4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=FVFsBQeB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a2zP58PE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3138011400A9;
	Thu, 18 Apr 2024 05:23:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 18 Apr 2024 05:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713432193; x=
	1713518593; bh=DgVOO4gkzo7BMM1oFmZX8/8L34/igUNIkQzx5ftmcfo=; b=F
	VFsBQeB6ZQaHU673x+hn8TaGJt53D/1Vxi+3gU1/qb6tjgqAwgrBTLlFJDLImdwu
	bAzzlh3+oP2g68hW+noydkfIlbseVJ1AEXer2TovTr5LN56YtPLalLykTtEA+wAv
	PlPjf2jURG5lHzv2eSSQ82HPLAvXPMnWLOC7hC8DtWk6lGeEiLnyWCkOYemRu3xD
	UfKSKwpFI37cYnHNxm1fnDfEmWxA5EnICRCQJJmNTTZQ+h+/KqhE095CCQF9s6e1
	aydkMNMQWD8zCKliM5/98zAehGgYjGzbmSAuIIivDQlb5f/TmlYS5YdOUrfKMms2
	3sEVt6xADTywY6UmfvX1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713432193; x=
	1713518593; bh=DgVOO4gkzo7BMM1oFmZX8/8L34/igUNIkQzx5ftmcfo=; b=a
	2zP58PE0X2ui611h8bdp4nYG3nCce5BwCO5hDsp3ikS8alTu1nYRKQmxlX3bQXoL
	1jdqvLUy+0H4rXLFO/lYJNUPz/OeUZbdDsW6CfQ6NS66rmHBKlcX3Wl8g4PvMEMG
	dE+BWltqW0RrFWVsjUOOQIRsRv+qPCJLFMYYTB4xu/jxjuxviHJAMEU0B4MNEw0j
	Zi48/CWQg7m6FOBdXTT7K9YT18W2McSS82LVOWRjeK/oo3XuL7GgElBIurnfUSnp
	ct1TLRMxhfPYkst8ZUHe5MczqdrOOwHZQolNncsDeFC2ZoWc98Y+0AzwIxwb9C9r
	iDt0Kz+v1i2qAwXqE0nZg==
X-ME-Sender: <xms:gOYgZu0MGDSnvORIZKOGhS9vVf2R03zU4Ne_pfkS6miA_a4mQzupNA>
    <xme:gOYgZhGLTILtHdFcdYkMJMi0MVqXehKew9HJ9P4OWHW4ZD2INg54h2zqLccFHJGNE
    7frJIsyLSsxH1qrq5E>
X-ME-Received: <xmr:gOYgZm7UlCjp1wmWyb8uxhzVRcTVVATe_cBHA7q3a0GlZ9nemUZwLNsaEH7GPdMQavtjEhmvy6sXDQ-JxKmxJVPfNxsnwlqLkkskagay2vLjoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:geYgZv2yhHyisEDsY8O5T4DA9mX5Np7Fz-1gaUERNPl1xyiNBt1Pbw>
    <xmx:geYgZhFIz-AEt14D1SFXHfeh2LPUGAOuykU3IOCLkrCEPTMVw3h3zg>
    <xmx:geYgZo-Rk6HYc6OBbrPwoSnpzzBdGvBZdbvZVRq5roYkxugREy3zeA>
    <xmx:geYgZmkFDQXckMFfMZ9p0iuuJKZatLCXInbE_35NJOpEZg0LdL9XAw>
    <xmx:geYgZmTmum4sGwasQz6aCC3KI6fz-uOsqTOnv-beu1JZJ88O5PnoCC4F>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 05:23:12 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/13] firewire: ohci: replace hard-coded values with inline functions for asynchronous packet header
Date: Thu, 18 Apr 2024 18:22:54 +0900
Message-ID: <20240418092303.19725-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418092303.19725-4-o-takashi@sakamocchi.jp>
References: <20240418092303.19725-1-o-takashi@sakamocchi.jp>
 <20240418092303.19725-2-o-takashi@sakamocchi.jp>
 <20240418092303.19725-3-o-takashi@sakamocchi.jp>
 <20240418092303.19725-4-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit replaces the hard-coded values with the common inline functions
to serialize and deserialize the header of asynchronous packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 5254cf5c2e58..4666d941a2ae 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -517,14 +517,14 @@ static const char *tcodes[] = {
 static void log_ar_at_event(struct fw_ohci *ohci,
 			    char dir, int speed, u32 *header, int evt)
 {
-	int tcode = header[0] >> 4 & 0xf;
+	int tcode = async_header_get_tcode(header);
 	char specific[12];
 
 	if (likely(!(param_debug & OHCI_PARAM_DEBUG_AT_AR)))
 		return;
 
 	if (unlikely(evt >= ARRAY_SIZE(evts)))
-			evt = 0x1f;
+		evt = 0x1f;
 
 	if (evt == OHCI1394_evt_bus_reset) {
 		ohci_notice(ohci, "A%c evt_bus_reset, generation %d\n",
@@ -539,7 +539,8 @@ static void log_ar_at_event(struct fw_ohci *ohci,
 		break;
 	case 0x1: case 0x5: case 0x7: case 0x9: case 0xb:
 		snprintf(specific, sizeof(specific), " %x,%x",
-			 header[3] >> 16, header[3] & 0xffff);
+			 async_header_get_data_length(header),
+			 async_header_get_extended_tcode(header));
 		break;
 	default:
 		specific[0] = '\0';
@@ -556,17 +557,17 @@ static void log_ar_at_event(struct fw_ohci *ohci,
 		break;
 	case 0x0: case 0x1: case 0x4: case 0x5: case 0x9:
 		ohci_notice(ohci,
-			    "A%c spd %x tl %02x, %04x -> %04x, %s, %s, %04x%08x%s\n",
-			    dir, speed, header[0] >> 10 & 0x3f,
-			    header[1] >> 16, header[0] >> 16, evts[evt],
-			    tcodes[tcode], header[1] & 0xffff, header[2], specific);
+			    "A%c spd %x tl %02x, %04x -> %04x, %s, %s, %012llx%s\n",
+			    dir, speed, async_header_get_tlabel(header),
+			    async_header_get_source(header), async_header_get_destination(header),
+			    evts[evt], tcodes[tcode], async_header_get_offset(header), specific);
 		break;
 	default:
 		ohci_notice(ohci,
 			    "A%c spd %x tl %02x, %04x -> %04x, %s, %s%s\n",
-			    dir, speed, header[0] >> 10 & 0x3f,
-			    header[1] >> 16, header[0] >> 16, evts[evt],
-			    tcodes[tcode], specific);
+			    dir, speed, async_header_get_tlabel(header),
+			    async_header_get_source(header), async_header_get_destination(header),
+			    evts[evt], tcodes[tcode], specific);
 	}
 }
 
@@ -854,7 +855,7 @@ static __le32 *handle_ar_packet(struct ar_context *ctx, __le32 *buffer)
 	p.header[1] = cond_le32_to_cpu(buffer[1]);
 	p.header[2] = cond_le32_to_cpu(buffer[2]);
 
-	tcode = (p.header[0] >> 4) & 0x0f;
+	tcode = async_header_get_tcode(p.header);
 	switch (tcode) {
 	case TCODE_WRITE_QUADLET_REQUEST:
 	case TCODE_READ_QUADLET_RESPONSE:
@@ -875,7 +876,7 @@ static __le32 *handle_ar_packet(struct ar_context *ctx, __le32 *buffer)
 	case TCODE_LOCK_RESPONSE:
 		p.header[3] = cond_le32_to_cpu(buffer[3]);
 		p.header_length = 16;
-		p.payload_length = p.header[3] >> 16;
+		p.payload_length = async_header_get_data_length(p.header);
 		if (p.payload_length > MAX_ASYNC_PAYLOAD) {
 			ar_context_abort(ctx, "invalid packet length");
 			return NULL;
@@ -912,8 +913,7 @@ static __le32 *handle_ar_packet(struct ar_context *ctx, __le32 *buffer)
 	 * Several controllers, notably from NEC and VIA, forget to
 	 * write ack_complete status at PHY packet reception.
 	 */
-	if (evt == OHCI1394_evt_no_status &&
-	    (p.header[0] & 0xff) == (OHCI1394_phy_tcode << 4))
+	if (evt == OHCI1394_evt_no_status && async_header_get_tcode(p.header) == OHCI1394_phy_tcode)
 		p.ack = ACK_COMPLETE;
 
 	/*
@@ -1354,7 +1354,7 @@ static int at_context_queue_packet(struct context *ctx,
 	 * accordingly.
 	 */
 
-	tcode = (packet->header[0] >> 4) & 0x0f;
+	tcode = async_header_get_tcode(packet->header);
 	header = (__le32 *) &d[1];
 	switch (tcode) {
 	case TCODE_WRITE_QUADLET_REQUEST:
-- 
2.43.0


