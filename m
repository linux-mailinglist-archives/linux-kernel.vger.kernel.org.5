Return-Path: <linux-kernel+bounces-40263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFB783DD59
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2CB8B221E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E71CF9C;
	Fri, 26 Jan 2024 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJrIz5eH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBF31CF8C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282534; cv=none; b=qFEkPetqBlAi+nEUX9YOL4ikqnl7Uen/JoiQf/LHiyYnmTmVwsYcAQgzk9gzLCrkBs8GRplRyOrk+2EsBEv3rHr84Kn7e9Rpx7t94017Qu0aNue0xUmYSRKNcxfuY57YwvUs+wJgWalnn3nV5/NOhwvzBCHvj4dMBRyJvy3E6SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282534; c=relaxed/simple;
	bh=t2n7KNUGUzU77BEBqmOYRjm+oIuzJQkeDhTNCAq4zx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2bEjvRcTtqacHt5UO+C50ZJo1266EDmbanzgbHNoYadu8CFGiafXzU5VOfFDy7QBgRejZRjFEQ5CXMQ55/0fEUlul0z0oLPTxxWzKXZuxCktaqBvZ12bHIeOj5IkvMM2L6RwLr5SANUZ3C3BenjvLFGw6a4jnfI5v4NnfIT7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJrIz5eH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706282531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IkTbDdKErsrbqQMEDhGqK5ts3+kvxqXuzsHApeWI9Ig=;
	b=TJrIz5eH8b+4S+nHm5AFqEO3AMvlyEllvsEuedDz8zXHJE0u79bO5ntAYpJfHpFwzugfxk
	HlZ44Wdg0GRgaAuqccKd07ENCjXT1qyOtlh4xGqjF2H+zFmMzWMwi9bwSii7XlX2kMHvUi
	OJpIs/oFhfHbVmvDzRdTn7keudj28rs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-GWKs3CcOOo2QEATqxHWtQg-1; Fri,
 26 Jan 2024 10:22:08 -0500
X-MC-Unique: GWKs3CcOOo2QEATqxHWtQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D0743C025D9;
	Fri, 26 Jan 2024 15:22:07 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.45.224.66])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6571EC15E61;
	Fri, 26 Jan 2024 15:22:04 +0000 (UTC)
From: Daniel Vacek <neelx@redhat.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Brendan Cunningham <bcunningham@cornelisnetworks.com>,
	Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
Cc: Daniel Vacek <neelx@redhat.com>,
	stable@vger.kernel.org,
	Mats Kronberg <kronberg@nsc.liu.se>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] IB/hfi1: Fix sdma.h tx->num_descs off-by-one error (take two)
Date: Fri, 26 Jan 2024 16:21:23 +0100
Message-ID: <20240126152125.869509-1-neelx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Unfortunately the commit `fd8958efe877` introduced another error
causing the `descs` array to overflow. This reults in further crashes
easily reproducible by `sendmsg` system call.

[ 1080.836473] general protection fault, probably for non-canonical address 0x400300015528b00a: 0000 [#1] PREEMPT SMP PTI
[ 1080.869326] RIP: 0010:hfi1_ipoib_build_ib_tx_headers.constprop.0+0xe1/0x2b0 [hfi1]
--
[ 1080.974535] Call Trace:
[ 1080.976990]  <TASK>
[ 1081.021929]  hfi1_ipoib_send_dma_common+0x7a/0x2e0 [hfi1]
[ 1081.027364]  hfi1_ipoib_send_dma_list+0x62/0x270 [hfi1]
[ 1081.032633]  hfi1_ipoib_send+0x112/0x300 [hfi1]
[ 1081.042001]  ipoib_start_xmit+0x2a9/0x2d0 [ib_ipoib]
[ 1081.046978]  dev_hard_start_xmit+0xc4/0x210
--
[ 1081.148347]  __sys_sendmsg+0x59/0xa0

crash> ipoib_txreq 0xffff9cfeba229f00
struct ipoib_txreq {
  txreq = {
    list = {
      next = 0xffff9cfeba229f00,
      prev = 0xffff9cfeba229f00
    },
    descp = 0xffff9cfeba229f40,
    coalesce_buf = 0x0,
    wait = 0xffff9cfea4e69a48,
    complete = 0xffffffffc0fe0760 <hfi1_ipoib_sdma_complete>,
    packet_len = 0x46d,
    tlen = 0x0,
    num_desc = 0x0,
    desc_limit = 0x6,
    next_descq_idx = 0x45c,
    coalesce_idx = 0x0,
    flags = 0x0,
    descs = {{
        qw = {0x8024000120dffb00, 0x4}  # SDMA_DESC0_FIRST_DESC_FLAG (bit 63)
      }, {
        qw = {  0x3800014231b108, 0x4}
      }, {
        qw = { 0x310000e4ee0fcf0, 0x8}
      }, {
        qw = {  0x3000012e9f8000, 0x8}
      }, {
        qw = {  0x59000dfb9d0000, 0x8}
      }, {
        qw = {  0x78000e02e40000, 0x8}
      }}
  },
  sdma_hdr =  0x400300015528b000,  <<< invalid pointer in the tx request structure
  sdma_status = 0x0,                   SDMA_DESC0_LAST_DESC_FLAG (bit 62)
  complete = 0x0,
  priv = 0x0,
  txq = 0xffff9cfea4e69880,
  skb = 0xffff9d099809f400
}

With this patch the crashes are no longer reproducible and the machine is stable.

Note, the header file changes are just an unrelated clean-up while I was looking
around trying to find the bug.

Fixes: fd8958efe877 ("IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors")
Cc: stable@vger.kernel.org
Reported-by: Mats Kronberg <kronberg@nsc.liu.se>
Tested-by: Mats Kronberg <kronberg@nsc.liu.se>
Signed-off-by: Daniel Vacek <neelx@redhat.com>
---
 drivers/infiniband/hw/hfi1/sdma.c |  2 +-
 drivers/infiniband/hw/hfi1/sdma.h | 17 +++++++----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 6e5ac2023328a..b67d23b1f2862 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3158,7 +3158,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 {
 	int rval = 0;
 
-	if ((unlikely(tx->num_desc + 1 == tx->desc_limit))) {
+	if ((unlikely(tx->num_desc == tx->desc_limit))) {
 		rval = _extend_sdma_tx_descs(dd, tx);
 		if (rval) {
 			__sdma_txclean(dd, tx);
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index d77246b48434f..362815a8da267 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -639,13 +639,13 @@ static inline void sdma_txclean(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 static inline void _sdma_close_tx(struct hfi1_devdata *dd,
 				  struct sdma_txreq *tx)
 {
-	u16 last_desc = tx->num_desc - 1;
+	struct sdma_desc *desc = &tx->descp[tx->num_desc - 1];
 
-	tx->descp[last_desc].qw[0] |= SDMA_DESC0_LAST_DESC_FLAG;
-	tx->descp[last_desc].qw[1] |= dd->default_desc1;
+	desc->qw[0] |= SDMA_DESC0_LAST_DESC_FLAG;
+	desc->qw[1] |= dd->default_desc1;
 	if (tx->flags & SDMA_TXREQ_F_URGENT)
-		tx->descp[last_desc].qw[1] |= (SDMA_DESC1_HEAD_TO_HOST_FLAG |
-					       SDMA_DESC1_INT_REQ_FLAG);
+		desc->qw[1] |= (SDMA_DESC1_HEAD_TO_HOST_FLAG |
+				SDMA_DESC1_INT_REQ_FLAG);
 }
 
 static inline int _sdma_txadd_daddr(
@@ -670,13 +670,10 @@ static inline int _sdma_txadd_daddr(
 	tx->tlen -= len;
 	/* special cases for last */
 	if (!tx->tlen) {
-		if (tx->packet_len & (sizeof(u32) - 1)) {
+		if (tx->packet_len & (sizeof(u32) - 1))
 			rval = _pad_sdma_tx_descs(dd, tx);
-			if (rval)
-				return rval;
-		} else {
+		else
 			_sdma_close_tx(dd, tx);
-		}
 	}
 	return rval;
 }
-- 
2.43.0


