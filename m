Return-Path: <linux-kernel+bounces-71155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F1885A170
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B528A28369B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84692C19D;
	Mon, 19 Feb 2024 10:54:12 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304F28DDA
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340052; cv=none; b=mlzuUWAnO7zPWmUrNkSeDeaygV1jvo2YvQko392sPWUlUXGAVYomNN3QGweccP5dildIknG7DmNvFwYhp2Q5+VqPMTI0Y95tLFE16AnCbqTIk6llrSypUtsnEIv67YsFMbl7btVmJ39ntnDKK83UDiffzS/+9YnWpdJO6U7+lqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340052; c=relaxed/simple;
	bh=v1tv+Hn2MMckB7tibXPo04tWJVN+P3e6WQ1r4106PQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iHfCpFad0jPITK1jmZpCkE1/9doooXdrQhOsIGYMIFERL27q5FivuzRA46dqdJpTO0wvJfw+N192BhHI7Oc9H/SYOgUc/WTQLemHWUrIFYpbaLiew1BDEO3ak9fQJeG9g9Aw/76/qefTc9mFxZB5dHGDKeoQU7VVFy/BQPnI3tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id E59C22F20256; Mon, 19 Feb 2024 10:54:06 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 2C3B22F20253;
	Mon, 19 Feb 2024 10:54:05 +0000 (UTC)
From: kovalev@altlinux.org
To: linux-kernel@vger.kernel.org
Cc: keescook@chromium.org,
	gregkh@linuxfoundation.org,
	bryantan@vmware.com,
	vdasa@vmware.com,
	pv-drivers@vmware.com,
	arnd@arndb.de,
	harshit.m.mogalapalli@oracle.com,
	nickel@altlinux.org,
	oficerovas@altlinux.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org
Subject: [PATCH] VMCI: Fix possible memcpy() run-time warning in vmci_datagram_invoke_guest_handler()
Date: Mon, 19 Feb 2024 13:53:15 +0300
Message-Id: <20240219105315.76955-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

The changes are similar to those given in the commit 19b070fefd0d
("VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()").

Fix filling of the msg and msg_payload in dg_info struct, which prevents a
possible "detected field-spanning write" of memcpy warning that is issued
by the tracking mechanism __fortify_memcpy_chk.

Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/misc/vmw_vmci/vmci_datagram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmci/vmci_datagram.c
index d1d8224c8800c4..a0ad1f3a69f7e9 100644
--- a/drivers/misc/vmw_vmci/vmci_datagram.c
+++ b/drivers/misc/vmw_vmci/vmci_datagram.c
@@ -378,7 +378,8 @@ int vmci_datagram_invoke_guest_handler(struct vmci_datagram *dg)
 
 		dg_info->in_dg_host_queue = false;
 		dg_info->entry = dst_entry;
-		memcpy(&dg_info->msg, dg, VMCI_DG_SIZE(dg));
+		dg_info->msg = *dg;
+		memcpy(&dg_info->msg_payload, dg + 1, dg->payload_size);
 
 		INIT_WORK(&dg_info->work, dg_delayed_dispatch);
 		schedule_work(&dg_info->work);
-- 
2.33.8


