Return-Path: <linux-kernel+bounces-149801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2CF8A95FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8B31C20D73
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2020F15E7FF;
	Thu, 18 Apr 2024 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="CuDOMn5q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wtn1C5B3"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E8515B0F4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432208; cv=none; b=uifAZO6KKFYbTe7R2V8XYy7hGvsHX/iwJ96XIf/Om7vCZ1btaD6/y483BlO3YMCOR2Fa88PdQJ2/nVAC0kYSwoHTlH0vxFB3iqHnl3OGVIHXMw6GIC6Rlq35n9da1yp3riZcFQMuUPqxooRpQMhQS/z1lfjNL191xTezFRLQ6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432208; c=relaxed/simple;
	bh=vcrT1TYwKnqYJ5PZxNHW/N9+G0t6gtyJtgQOMM2ZuAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wj+ttnB0f5al/lkULWj/IaagydgATbRz276c6ylT1JFxJpU+zEWfGQcpGOKLxZV6OVzNNivFEmXWGANT/kQNK0RHjzZ98QjmZL5HyPy7fgRY6X8VJCIdtB+YOL1DrGP7ZiIzNX6gA0ROYNpZPGq72taA3bmujYAtLnpeCz5h1Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=CuDOMn5q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wtn1C5B3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 99CD61140156;
	Thu, 18 Apr 2024 05:23:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 18 Apr 2024 05:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713432205; x=
	1713518605; bh=EOlC4Zi0Zmvr/N4ssp9EJZk79C5SCm6pNZw7lzj8X9g=; b=C
	uDOMn5qNjXJaOklHhGGbmujk5dfKMhifgd44/yrcg2WTgKNNFRzdrsnhV9azaRd2
	r/T8AutERuXyOWlLVTC26yWNBl8b8dcuWrD0eET9heq3lwwPFDcAoU9kL2tUOd45
	adARqMLJ3tAwTe8VJ+eM66JL5+6rEGKRSIlpRcrXTULUUlldBqQSjIFZSPmuszBP
	hx2f3DK0qqms+x9Wv0WN1R5OP2T0cRV+VWOlHw3QajVWHWsqfUdVUykRcBmu1mwk
	koRy/ox8pCzBi8xaCWiNXaID3QOqUallBWxa2yACqI4Jhb3a5Q+vlEhdGk0sAGbV
	Qd+NNNVYIAKzPwjjcEx5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713432205; x=
	1713518605; bh=EOlC4Zi0Zmvr/N4ssp9EJZk79C5SCm6pNZw7lzj8X9g=; b=W
	tn1C5B3va83kDpDyYKnT0eFWvZaxQZOik5FvHxfcHiio9BtLa09tRgr5idJsavUR
	bUED4wWjxFzvpIO9V06NyQuTNppgBTjEH+5D80GV6X84PTHPNiuhnbTOb8sKjbes
	ldeDujR1jpoeZxVUXBsJHx0sUK7WiPgjsiBeV7mmjhziEoQ/qVcLSCclArAQM9YG
	u2gPyaBHF+J7lKW1vypf1KVWSjav+7VuuLGXRvxCA5zGqQTTG6K0FqfCT9qhY6TS
	AkJYz9p0Jw4wxLuczxkhV/L5r7pSYPH1t+TRP+ESHzdaUL7jHQAxSC+4pAcK7SlW
	fS7P3RQRCP4BsbNGs94tA==
X-ME-Sender: <xms:jeYgZho45otOSuA8ROFSxeMDM8x0aE-rmaCgx2KfYFgN-TXaaH-dfA>
    <xme:jeYgZjpbW_NwOIVSV9izhtcPvIYDfGlBSYKlOgzXp8TnpnBRMybIaVrIALtWglKxp
    kwFuSipGnPzKzQgouo>
X-ME-Received: <xmr:jeYgZuNLtA7X1FigDX5fS7wKr3UV3-98O6UnjlwDEAZJNsiPZqfydZ0tUrLdSTcvjg3wDyDAvbLD67QXf3VWbDj8TYZ1_j2WmcMOLAuRxW3_DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:jeYgZs6tGVO-1jbkrWKf75uv7S1-2f2ipPvkjD1nyVElVSczAhrXsg>
    <xmx:jeYgZg7ZQY5Esg3Tp3ZzMJFY2fWNrdEOgHkEPj1c206mqU7cZzWyuA>
    <xmx:jeYgZkib2ngTycPh9cYvCDHEgX-_xHVwKqA733tY8TVSdmR21F8zIw>
    <xmx:jeYgZi5flOUyJ5WDwZXP5CFQHK2QVGToQREzH1TP9JPZ7tukdip8aA>
    <xmx:jeYgZgG6HQry5RoWQxArsnCE7qu5QX0jx047_DlMejerq4tPwEf2Kbeb>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 05:23:24 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 13/13] firewire: core: add tracepoints events for asynchronous outbound response
Date: Thu, 18 Apr 2024 18:23:03 +0900
Message-ID: <20240418092303.19725-14-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418092303.19725-13-o-takashi@sakamocchi.jp>
References: <20240418092303.19725-1-o-takashi@sakamocchi.jp>
 <20240418092303.19725-2-o-takashi@sakamocchi.jp>
 <20240418092303.19725-3-o-takashi@sakamocchi.jp>
 <20240418092303.19725-4-o-takashi@sakamocchi.jp>
 <20240418092303.19725-5-o-takashi@sakamocchi.jp>
 <20240418092303.19725-6-o-takashi@sakamocchi.jp>
 <20240418092303.19725-7-o-takashi@sakamocchi.jp>
 <20240418092303.19725-8-o-takashi@sakamocchi.jp>
 <20240418092303.19725-9-o-takashi@sakamocchi.jp>
 <20240418092303.19725-10-o-takashi@sakamocchi.jp>
 <20240418092303.19725-11-o-takashi@sakamocchi.jp>
 <20240418092303.19725-12-o-takashi@sakamocchi.jp>
 <20240418092303.19725-13-o-takashi@sakamocchi.jp>
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

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 21 ++++++---
 drivers/firewire/trace.h            | 68 +++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 1b972e95fe36..c963832d9824 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -667,6 +667,8 @@ static void free_response_callback(struct fw_packet *packet,
 {
 	struct fw_request *request = container_of(packet, struct fw_request, response);
 
+	trace_async_response_outbound_complete(card, request, packet);
+
 	// Decrease the reference count since not at in-flight.
 	fw_request_put(request);
 
@@ -849,6 +851,9 @@ static struct fw_request *allocate_request(struct fw_card *card,
 void fw_send_response(struct fw_card *card,
 		      struct fw_request *request, int rcode)
 {
+	u32 *data = NULL;
+	unsigned int data_length = 0;
+
 	/* unified transaction or broadcast transaction: don't respond */
 	if (request->ack != ACK_PENDING ||
 	    HEADER_DESTINATION_IS_BROADCAST(request->request_header)) {
@@ -856,17 +861,19 @@ void fw_send_response(struct fw_card *card,
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
 
+	trace_async_response_outbound_initiate(card, request, &request->response, data,
+					       data ? data_length / 4 : 0);
+
 	card->driver->send_response(card, &request->response);
 }
 EXPORT_SYMBOL(fw_send_response);
diff --git a/drivers/firewire/trace.h b/drivers/firewire/trace.h
index ba09eb720933..0109a70d3b02 100644
--- a/drivers/firewire/trace.h
+++ b/drivers/firewire/trace.h
@@ -190,6 +190,74 @@ TRACE_EVENT(async_request_inbound,
 	)
 )
 
+TRACE_EVENT(async_response_outbound_initiate,
+	TP_PROTO(const struct fw_card *card, const struct fw_request *request,
+		 const struct fw_packet *packet, const u32 *data, unsigned int data_count),
+	TP_ARGS(card, request, packet, data, data_count),
+	TP_STRUCT__entry(
+		__field(u64, transaction)
+		__field(u8, scode)
+		__field(u8, generation)
+		__field(u16, destination)
+		__field(u8, tlabel)
+		__field(u8, retry)
+		__field(u8, tcode)
+		__field(u8, priority)
+		__field(u16, source)
+		__field(u8, rcode)
+		__dynamic_array(u32, data, data_count)
+	),
+	TP_fast_assign(
+		__entry->transaction = (u64)request;
+		__entry->scode = packet->speed;
+		__entry->generation = packet->generation;
+		__entry->destination = async_header_get_destination(packet->header);
+		__entry->tlabel = async_header_get_tlabel(packet->header);
+		__entry->retry = async_header_get_retry(packet->header);
+		__entry->tcode = async_header_get_tcode(packet->header);
+		__entry->priority = async_header_get_priority(packet->header);
+		__entry->source = async_header_get_source(packet->header);
+		__entry->rcode = async_header_get_rcode(packet->header);
+		memcpy(__get_dynamic_array(data), data, __get_dynamic_array_len(data));
+	),
+	TP_printk(
+		"transaction=0x%llx scode=%u generation=%u dst_id=0x%04x tlabel=%u retry=%u tcode=%u priority=%u src_id=0x%04x rcode=%u data=%s",
+		__entry->transaction,
+		__entry->scode,
+		__entry->generation,
+		__entry->destination,
+		__entry->tlabel,
+		__entry->retry,
+		__entry->tcode,
+		__entry->priority,
+		__entry->source,
+		__entry->rcode,
+		__print_array(__get_dynamic_array(data), __get_dynamic_array_len(data), sizeof(u32))
+	)
+)
+
+TRACE_EVENT(async_response_outbound_complete,
+	TP_PROTO(const struct fw_card *card, const struct fw_request *request,
+		 const struct fw_packet *packet),
+	TP_ARGS(card, request, packet),
+	TP_STRUCT__entry(
+		__field(u64, transaction)
+		__field(u8, ack)
+		__field(u16, timestamp)
+	),
+	TP_fast_assign(
+		__entry->transaction = (u64)request;
+		__entry->ack = packet->ack;
+		__entry->timestamp = packet->timestamp;
+	),
+	TP_printk(
+		"transaction=0x%llx ack=%u timestamp=0x%04x",
+		__entry->transaction,
+		__entry->ack,
+		__entry->timestamp
+	)
+)
+
 #endif // _FIREWIRE_TRACE_EVENT_H
 
 #define TRACE_INCLUDE_PATH	.
-- 
2.43.0


