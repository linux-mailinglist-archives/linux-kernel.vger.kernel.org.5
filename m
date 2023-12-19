Return-Path: <linux-kernel+bounces-5452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15482818AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C801F264D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD61A1CF83;
	Tue, 19 Dec 2023 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mWqQFs03"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C681CA81;
	Tue, 19 Dec 2023 15:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D26C433CB;
	Tue, 19 Dec 2023 15:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702998476;
	bh=76IMDa35Ejr4DS8JJBlGFBxWrx3Os8GLF+gs9kZW9II=;
	h=From:To:Cc:Subject:Date:From;
	b=mWqQFs03BZuMAl/JfgCocD6vFVETom5/non6pqxKgM1JS/XadCHFlz5/Qb8WHNc5j
	 L8QuaMjlk9oz5so+qnZNtaMITMWoBwpAPNzfHMMdAGYrneIp3gptGhqJXPbOx+jb93
	 lIkdL8V6cqaRYqe1pSVGivwPoFpFrqlvYj6VgCP8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: wintera@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] icuv: make iucv_bus const
Date: Tue, 19 Dec 2023 16:07:51 +0100
Message-ID: <2023121950-prankster-stomp-a1aa@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 55
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=76IMDa35Ejr4DS8JJBlGFBxWrx3Os8GLF+gs9kZW9II=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmNG4/HvBFNfNNYMSvisnXSm9asi+9m/cg+P+OQ56Jjh gpTtood74hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJfPzBsGDRhXQ1p/bOowui i6ec9JsaYt0tU80wT2lq6J8rhWaHXmptFXrN8IqDt2jFIgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the iucv_bus variable to be a constant structure as well, placing
it into read-only memory which can not be modified at runtime.

Cc: Alexandra Winter <wintera@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/iucv/iucv.h | 4 ++--
 net/iucv/iucv.c         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/iucv/iucv.h b/include/net/iucv/iucv.h
index f9e88401d7da..8b2055d64a6b 100644
--- a/include/net/iucv/iucv.h
+++ b/include/net/iucv/iucv.h
@@ -80,7 +80,7 @@ struct iucv_array {
 	u32 length;
 } __attribute__ ((aligned (8)));
 
-extern struct bus_type iucv_bus;
+extern const struct bus_type iucv_bus;
 extern struct device *iucv_root;
 
 /*
@@ -489,7 +489,7 @@ struct iucv_interface {
 	int (*path_sever)(struct iucv_path *path, u8 userdata[16]);
 	int (*iucv_register)(struct iucv_handler *handler, int smp);
 	void (*iucv_unregister)(struct iucv_handler *handler, int smp);
-	struct bus_type *bus;
+	const struct bus_type *bus;
 	struct device *root;
 };
 
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 0ed6e34d6edd..6334f64f04d5 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -67,7 +67,7 @@ static int iucv_bus_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
-struct bus_type iucv_bus = {
+const struct bus_type iucv_bus = {
 	.name = "iucv",
 	.match = iucv_bus_match,
 };
-- 
2.43.0


