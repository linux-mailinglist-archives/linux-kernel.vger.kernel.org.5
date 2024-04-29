Return-Path: <linux-kernel+bounces-161730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3B98B5040
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799421F221CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2751427E;
	Mon, 29 Apr 2024 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="JcCKgJa3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ru5TwtdQ"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518AB11C85
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365155; cv=none; b=PTatP+jYnXsPJTz4CE1+Xovh/ItPU3bbBlF4PNNqsNxf+yQiSnoUf3Wjoc+J2gnj9BO8o6GKcEfmK03pJWaL9cTqTD5mBO++ZlzlH6f+QE1CTbMoaDU/07g5nenUlBhdii/YVqTaGu3lqBoAsWMzaxtoS8hF4JAf6/VwkMf4Krc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365155; c=relaxed/simple;
	bh=9fSxC2qJw1bx+EvQewB7Hy3ziOti6WL2Y57bnLZiWS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siiTQGMomroF1/2XUq2LPOP8Cfj2ZtNpkeaLbCowDSg2AvwqYAP6IXnE1jwdBZLUPDYhh8lkOClup+kSVKC9L0b5AvkA3Xywq1NS/WsI0+dZaVpzJN/tov+0B7i7kzJZNG5h3omvxInsx/P/Euj3OWRGqLSjENN9GBz5hSLaSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=JcCKgJa3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ru5TwtdQ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5390211400A1;
	Mon, 29 Apr 2024 00:32:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 29 Apr 2024 00:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714365150; x=
	1714451550; bh=uAd9uG+pG3IVzb8Q4IOhm2kmGzAT+zLhAYTmas+8y24=; b=J
	cCKgJa3jLHNuASB5BfOfj9GwllUfEmWmccgqgXqpcPIE8/7GRXg+KqTZO9FMXXjd
	Uax0QiaQuOKrWT22Yk6N0QpkS5Io2QIs+y9iNT+HIJykZkHM3kEQkVNksTLp9t1W
	lW0stGL1r0de+A3T3JQYzXx8meww2GOZU3mosHujsRNb3FDBXTBY5jeHg5vgn6/c
	c/NcBs1D9yT8C7f7zEFHlHY5QFru48fCkssJVzWONyNxQVa+j6ahHQWaKCxodcfI
	BNyxgufjlU4f4PrQEbIFQJU7kVviiK8PNxkpvB9MDMIRJ2p0yq+WVW/RSk707oEp
	n9al8xDdhn5UYnJCBh6KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714365150; x=
	1714451550; bh=uAd9uG+pG3IVzb8Q4IOhm2kmGzAT+zLhAYTmas+8y24=; b=R
	u5TwtdQ1GXbD0aTFOWKhFX3afcfAx+pt7CwWZbyDg+egd9wXVXxPNl9k4fcuorgd
	kTw+D2hWYt5PUpwNbiXxmZ//sW7gYaCEyjeEX/pmS+2KX/3iNsBXlV8UQMz8F7l/
	WnCJ+KS9q4eZ8X53TJO1BZa7AggsS7PyAMQSiGNUB0/D+n5VcLDkGPQN0Oej9jEz
	BhECJk7v1a3AMx4aQlz8PUwEIvpomyPHU1C6LlPai4KftZfOVG0tt7w6NKluQ4AR
	fDvaHBdI866wo//dgoWRfVE5B13umi3eFDyfSRfd3kHajXW6Uy5iqBpyvKHrV8v4
	x5Ot5uoJyiNBklfAZO+tg==
X-ME-Sender: <xms:3iIvZiRa8JzJP4ExWPQ1rIT80i7_qUKWq3F_ODy1s5iFt1shLOHlwA>
    <xme:3iIvZnzVeFx1lKEIBf4_2o48XHCB3Gzt-sHcXpUj93cDFxDFl2b73vkuZ705jTwna
    m6bm570A7ZarjnzjtQ>
X-ME-Received: <xmr:3iIvZv2l8DwO3am49wVVhs5AbZGgMT1JkaG0pc-I3a9EUOfctO1Gb2AAeFrjMjo-4DsnVTN-VDH5mezdDFvb29Bwkdsjj-ruxl9mBVzektG9AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtledgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:3iIvZuBmt9cUF0C31x85mtgW8Zs9qUYr7JnYjCSv7V5drDBJBgSZEQ>
    <xmx:3iIvZrjRR_JTkZ7X2AccwziI5YBQdGHqcuUOcd8Ncie4xQz10ZKHfw>
    <xmx:3iIvZqo3hhUHJYxz-kzcGtaFZ8V9pyChSny34bbhooQK-kE2fbKv9A>
    <xmx:3iIvZugAfu9Unykt-I3i6OU-OrWIMXJVsgSjvhJW25jKG-9G3nW0cw>
    <xmx:3iIvZutd5irFlWFirqwD31Nj_IEmUlH3jtGUKYdBhaqvZuCpP4PIixL3>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 00:32:29 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] firewire: core: add tracepoints events for asynchronous outbound response
Date: Mon, 29 Apr 2024 13:32:18 +0900
Message-ID: <20240429043218.609398-6-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429043218.609398-1-o-takashi@sakamocchi.jp>
References: <20240429043218.609398-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a view of core transaction service, the asynchronous outbound response
consists of two stages; initiation and completion.

This commit adds a pair of events for the asynchronous outbound response.
The following example is for asynchronous write quadlet request as IEC
61883-1 FCP response to node 0xffc1.

async_response_outbound_initiate: \
  transaction=0xffff89fa08cf16c0 generation=4 scode=2 dst_id=0xffc1 \
  tlabel=25 tcode=2 src_id=0xffc0 rcode=0 \
  header={0xffc16420,0xffc00000,0x0,0x0} data={}
async_response_outbound_complete: \
  transaction=0xffff89fa08cf16c0 generation=4 scode=2 status=1 \
  timestamp=0x0000

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 23 ++++++++++++++++-------
 include/trace/events/firewire.h     | 24 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 8c13f996a938..0e49ebf52500 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -668,6 +668,9 @@ static void free_response_callback(struct fw_packet *packet,
 {
 	struct fw_request *request = container_of(packet, struct fw_request, response);
 
+	trace_async_response_outbound_complete((uintptr_t)request, packet->generation,
+					       packet->speed, status, packet->timestamp);
+
 	// Decrease the reference count since not at in-flight.
 	fw_request_put(request);
 
@@ -850,6 +853,9 @@ static struct fw_request *allocate_request(struct fw_card *card,
 void fw_send_response(struct fw_card *card,
 		      struct fw_request *request, int rcode)
 {
+	u32 *data = NULL;
+	unsigned int data_length = 0;
+
 	/* unified transaction or broadcast transaction: don't respond */
 	if (request->ack != ACK_PENDING ||
 	    HEADER_DESTINATION_IS_BROADCAST(request->request_header)) {
@@ -857,17 +863,20 @@ void fw_send_response(struct fw_card *card,
 		return;
 	}
 
-	if (rcode == RCODE_COMPLETE)
-		fw_fill_response(&request->response, request->request_header,
-				 rcode, request->data,
-				 fw_get_response_length(request));
-	else
-		fw_fill_response(&request->response, request->request_header,
-				 rcode, NULL, 0);
+	if (rcode == RCODE_COMPLETE) {
+		data = request->data;
+		data_length = fw_get_response_length(request);
+	}
+
+	fw_fill_response(&request->response, request->request_header, rcode, data, data_length);
 
 	// Increase the reference count so that the object is kept during in-flight.
 	fw_request_get(request);
 
+	trace_async_response_outbound_initiate((uintptr_t)request, request->response.generation,
+					       request->response.speed, request->response.header,
+					       data, data ? data_length / 4 : 0);
+
 	card->driver->send_response(card, &request->response);
 }
 EXPORT_SYMBOL(fw_send_response);
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index a30cebed119a..d4688e341837 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -174,6 +174,30 @@ DEFINE_EVENT_PRINT(async_inbound_template, async_request_inbound,
 	)
 );
 
+DEFINE_EVENT_PRINT(async_outbound_initiate_template, async_response_outbound_initiate,
+	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, const u32 *header, const u32 *data, unsigned int data_count),
+	TP_ARGS(transaction, generation, scode, header, data, data_count),
+	TP_printk(
+		"transaction=0x%llx generation=%u scode=%u dst_id=0x%04x tlabel=%u tcode=%u src_id=0x%04x rcode=%u header=%s data=%s",
+		__entry->transaction,
+		__entry->generation,
+		__entry->scode,
+		ASYNC_HEADER_GET_DESTINATION(__entry->header),
+		ASYNC_HEADER_GET_TLABEL(__entry->header),
+		ASYNC_HEADER_GET_TCODE(__entry->header),
+		ASYNC_HEADER_GET_SOURCE(__entry->header),
+		ASYNC_HEADER_GET_RCODE(__entry->header),
+		__print_array(__entry->header, ASYNC_HEADER_QUADLET_COUNT, QUADLET_SIZE),
+		__print_array(__get_dynamic_array(data),
+			      __get_dynamic_array_len(data) / QUADLET_SIZE, QUADLET_SIZE)
+	)
+);
+
+DEFINE_EVENT(async_outbound_complete_template, async_response_outbound_complete,
+	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp),
+	TP_ARGS(transaction, generation, scode, status, timestamp)
+);
+
 #undef ASYNC_HEADER_GET_DESTINATION
 #undef ASYNC_HEADER_GET_TLABEL
 #undef ASYNC_HEADER_GET_TCODE
-- 
2.43.0


