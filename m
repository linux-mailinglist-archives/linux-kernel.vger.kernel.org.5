Return-Path: <linux-kernel+bounces-97795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8464876F7D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5697C282032
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 07:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EDE37162;
	Sat,  9 Mar 2024 07:19:38 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201736B0E;
	Sat,  9 Mar 2024 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709968778; cv=none; b=HtK9T8QfKfT/DAOnHPSvDZrTkzgi+GTgsXrFehfpg0S5EUe/IJuAhHotvbtHWWRifxNbhtn6NiQt35FP2guxMB1JBTg266OUyjn9ATU0DvOhiK2PiEf/lPOb6fJr6JnlwLzCIYf2+4z8ZkgiV21lu1qwsrhpFKpondBkdUX/7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709968778; c=relaxed/simple;
	bh=3CyRyZ9WzW5hOL+wfSuN7rPxEnE3boBAurj6cKcctkw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gWFRLAxBycg4YfPpjNH78QeTftqtOLrDP/8v1kv6Q5Sgp/u+mFhFiCxuZAw9Bw+ksmGchc1yL+/T+I3oomVbTZJWMO8PSTQHMy6dz7PJL5HxbDzNLVzjUv4TL1DW+vLbzaUfcjBWGRjsqMNRee64vTC1h7jFo+1MfX9oCNmrC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id FAB00000;
        Sat, 09 Mar 2024 15:18:00 +0800
Received: from localhost.localdomain (10.94.7.69) by
 jtjnmail201621.home.langchao.com (10.100.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 9 Mar 2024 15:18:00 +0800
From: Bo Liu <liubo03@inspur.com>
To: <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] usb: typec: stusb160x: convert to use maple tree register cache
Date: Sat, 9 Mar 2024 02:17:57 -0500
Message-ID: <20240309071757.3152-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201621.home.langchao.com (10.100.2.21)
tUid: 2024309151800ceddc6798699cfd02d6528d709fa673a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/usb/typec/stusb160x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
index 3ab118df1bd4..f3140fc04c12 100644
--- a/drivers/usb/typec/stusb160x.c
+++ b/drivers/usb/typec/stusb160x.c
@@ -234,7 +234,7 @@ static const struct regmap_config stusb1600_regmap_config = {
 	.readable_reg	= stusb160x_reg_readable,
 	.volatile_reg	= stusb160x_reg_volatile,
 	.precious_reg	= stusb160x_reg_precious,
-	.cache_type	= REGCACHE_RBTREE,
+	.cache_type	= REGCACHE_MAPLE,
 };
 
 static bool stusb160x_get_vconn(struct stusb160x *chip)
-- 
2.18.2


