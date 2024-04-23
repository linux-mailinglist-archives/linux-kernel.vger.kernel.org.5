Return-Path: <linux-kernel+bounces-155849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4018AF7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4283B22444
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFD6142636;
	Tue, 23 Apr 2024 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ntqkJfPK"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799341C687
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713903961; cv=none; b=A/xJ2tvSHrc/rYMz5dB/6O+DTDNF5dOqtLkiTZG0nlVds5GL86hdtypkLrLJJz7u/RN94MGs1cYqMbzs5DMo4zwSV0JqVOwTHmk/f5NCjYkGQi3/Xjnz6A8CpAOr7aXsmiWFX0qh7gHmPdQqHvZbDbxNIkPZUKw/s41mjmIJg4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713903961; c=relaxed/simple;
	bh=mVN4QTxRncoFspcOfajOTu25xYOyAK9fT8THCDI2+yo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=neTkCKVJD8pRlkl/95hSuEmPh9bhXzD9hBu9pNKK9cBJnOVVTeBc52EKhSnYHDSr0+yVC3qu4kHBNY9Q9dsYuN6dgfBrWhbWkSBG30NHrcop5n20K4kNUZ1JBF7YhodwJD9On1SkO7aAwCADNe63g83oO95+nWnCgcHIrgFQz7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ntqkJfPK; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a4ff147030so7613575a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713903959; x=1714508759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q5jHQxcUdXp+dPIr3rm5L14wko30Jw0n6PWHbtrT/PM=;
        b=ntqkJfPKB6pLaQfT/MTEyodfasL5Ly7Q4Qzxm/QvjIGw8Zrm3jzvBu2Cxb8t3+GtlE
         QyrJsyDXGNOMCgMmRAuZ/tKgkeXAwVprLsaA1tvExGnuX6CK1PpltHHrNsMR/PZ1pcIs
         qot3QBguDiH0h9Jjka2F9OTul6cKWjiVT0sK4zpXohVBXUClDHTWAY2Za2g3lOXEqN/E
         HbILLLmCXOfxPWmtIWIwb4XFgS2cz7KSCNGAlgM2uqfEKhpRVHYzbFYc8ns3xLpZ5muP
         fGp14QU2Qsi9g15Gans9PRyq+iK7IbDOLiQBmqqF36ULQmDOP1+0xP5ufj+czOlYT/Md
         4FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713903959; x=1714508759;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5jHQxcUdXp+dPIr3rm5L14wko30Jw0n6PWHbtrT/PM=;
        b=fNb6qkAHkjT91Q04IPPHywEm2GwzpRZ4/FZtza3OkIMeahrP80OfjNtJ2aGuDBFv46
         7/uQ+IL8QXwdphRQi6EhSOBYti3fs398tluxanhFrmO+ongVh/AP5AqLvUkfQ363osrN
         8HenMDnBe1zSXT9gPZmzdATC28rECKSS/n+kTS6ommtOJu3zj+nwS7IhR8axEPubkyi/
         XW2sr3eEn6k0HWDwX1ALYY0/caJkUGUeysVKAWjuvdgfdEFRg96WN9nF+9rx3+z0q5ur
         Gpe5FRWjOlDtlUkOHGFJoiBPJAgPv33j082gvIxTAJ472fxQ9OdAvwwaChlHXR1xlDTg
         /JvA==
X-Forwarded-Encrypted: i=1; AJvYcCXBXRwSBAA7phUJ+LN0QJ7YNe+6oCTAgSIJs2ySwMl4jSYOqcZbSLPLqmHBDZbz3xtKNv0taZJ9CzBmDaIbL6y2CRUkaDWJSg7x0+J0
X-Gm-Message-State: AOJu0Yw8zf+5r2yYyR8vEENOn2kOGSw+3BRfMGngkgnN+xF4br456iBB
	fTz54GDB+Mt71SiegHmSdhFYgUam+6JScfXUkuI3Z8a6RmWUE/nxxDSrQTh/cDSF/D9wF+SCahg
	+nDKRTnQ8btpmnQ==
X-Google-Smtp-Source: AGHT+IFSwYF7KVY14eFqT9xqEPyFY3dW4hnO21Aieew4SoQwwj26IVFV/FKcEY+uLqJatQ7GWmqG2DBXk1RDeHY=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a17:90a:77c6:b0:2ae:f76e:2473 with SMTP
 id e6-20020a17090a77c600b002aef76e2473mr2111pjs.2.1713903958621; Tue, 23 Apr
 2024 13:25:58 -0700 (PDT)
Date: Tue, 23 Apr 2024 20:25:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=rdbabiera@google.com;
 h=from:subject; bh=mVN4QTxRncoFspcOfajOTu25xYOyAK9fT8THCDI2+yo=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDGkakl6c68+oBdb6FqwJ3KNp8uWHdY1PxUPbmG3nbT/7n
 Hp2cO2FjlIWBjEOBlkxRRZd/zyDG1dSt8zhrDGGmcPKBDKEgYtTACZy2I3hf1zg5KLWpMXCkbw/
 As/Y+6aZFt247zd3iSJXv9dMH/ef7IwMx7+JfPhjouictfR457uLDscmuOx5ZJyh/mjBVNVPPGG 93AA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423202546.3374218-2-rdbabiera@google.com>
Subject: [PATCH v1] usb: typec: tcpm: queue correct sop type in tcpm_queue_vdm_unlocked
From: RD Babiera <rdbabiera@google.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: badhri@google.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	RD Babiera <rdbabiera@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

tcpm_queue_vdm_unlocked queues VDMs over SOP regardless of input
parameter tx_sop_type. Fix tcpm_queue_vdm() call.

Fixes: 7e7877c55eb1 ("usb: typec: tcpm: add alt mode enter/exit/vdm support for sop'")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
Patch applies starting at 6.9 tree.
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index c26fb70c3ec6..3f38e7c7d13f 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1565,7 +1565,7 @@ static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
 				    const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
 {
 	mutex_lock(&port->lock);
-	tcpm_queue_vdm(port, header, data, cnt, TCPC_TX_SOP);
+	tcpm_queue_vdm(port, header, data, cnt, tx_sop_type);
 	mutex_unlock(&port->lock);
 }
 

base-commit: 684e9f5f97eb4b7831298ffad140d5c1d426ff27
-- 
2.44.0.769.g3c40516874-goog


