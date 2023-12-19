Return-Path: <linux-kernel+bounces-5363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBAE8189E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D370283E46
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1211D53E;
	Tue, 19 Dec 2023 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hfing/oj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17984208DB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18750C433CD;
	Tue, 19 Dec 2023 14:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702996003;
	bh=1FNF60890FZe8kxMt43p7UTvcMY3fweSq4axrM1JM2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hfing/oj/AUYnlR4VJ/5gSwjFWNUg8N3PIlxVFK3CIXnc8hwRNNmNy/L+aGBvYA5e
	 2Oqig9mHjPMBybV3uklsjzh0PRaHxuvUmjt2lG0hGnPOtIYcyDCyK3jjMMgdeR28xB
	 mO0+zN8luSltnDKZrhQBFM4jMKfyFIe+mmbpNP7M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: kabel@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] moxtet: mark moxtet_bus_type as const
Date: Tue, 19 Dec 2023 15:26:39 +0100
Message-ID: <2023121939-written-guru-db83@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023121937-pants-heroics-17c1@gregkh>
References: <2023121937-pants-heroics-17c1@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Lines: 25
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=1FNF60890FZe8kxMt43p7UTvcMY3fweSq4axrM1JM2U=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmNK+TXsV142/79UYHNLdanX3fb8On0hh3dorzttBPDK /0r4d9fdsSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEQs8wLNgiuES/MezcBDuO Kn3DnXV1k70eOzPM98u5+DhA4PPTyzyXtjMKmb3esWO9BAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the moxtet_bus_type to be a constant structure as well, placing it
into read-only memory which can not be modified at runtime.

Cc: "Marek Behún" <kabel@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/moxtet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 5eb0fe73ddc4..5e71b4c29992 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -102,7 +102,7 @@ static int moxtet_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
-static struct bus_type moxtet_bus_type = {
+static const struct bus_type moxtet_bus_type = {
 	.name		= "moxtet",
 	.dev_groups	= moxtet_dev_groups,
 	.match		= moxtet_match,
-- 
2.43.0


