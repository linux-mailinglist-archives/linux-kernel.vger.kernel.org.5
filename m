Return-Path: <linux-kernel+bounces-6508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B668199C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E1A280ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F29171DC;
	Wed, 20 Dec 2023 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C1PRSMih"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07606168CF;
	Wed, 20 Dec 2023 07:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBE5C433C9;
	Wed, 20 Dec 2023 07:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703058083;
	bh=eicNkkHSvbTuvKDaD0uy33eDZQ21rFcTjG+07eDtb24=;
	h=From:To:Cc:Subject:Date:From;
	b=C1PRSMihdU16ZQCKm3Os+pG4tQUmTaCzgOgApklcMglhb2QBLv1qzrSihzFFlLRFD
	 Z0sJtaxJQHMHTLrHFvVEvm72DtefS/fO8R1Xdrk07PRQ9fCcGfYMpZ4P1PoBEpvF0P
	 x/uUI8jCks/Cs1g/lwsznRtF/OL0Ev7qKbGFBXA8=
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
Subject: [PATCH v2] iucv: make iucv_bus const
Date: Wed, 20 Dec 2023 08:41:18 +0100
Message-ID: <2023122017-shelf-cadet-309c@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 58
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=eicNkkHSvbTuvKDaD0uy33eDZQ21rFcTjG+07eDtb24=; b=owGbwMvMwCRo6H6F97bub03G02pJDKlNs+YKRC5Sdahf1nZgq3vOe3uvU7ne7ksnn4/Zers4T K/f9PrljlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIgy0M88Nidga+3sl0acWR dx6zhDbH3xaz9mRYcOpe7JuZy3encuQxL3voL83qdvrrXgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the iucv_bus variable to be a constant structure as well, placing
it into read-only memory which can not be modified at runtime.

Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org
Acked-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: add Alexandra ack
    fix typo in subject line as pointed out by Niklas

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


