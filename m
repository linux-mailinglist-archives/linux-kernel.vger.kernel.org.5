Return-Path: <linux-kernel+bounces-5505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AC2818B73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8C2286F67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33C31CAB6;
	Tue, 19 Dec 2023 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nut0wwAf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C77B1CF89;
	Tue, 19 Dec 2023 15:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED81C433C8;
	Tue, 19 Dec 2023 15:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703000588;
	bh=Ql8eGZzccquuIXGz4rdOVYKLAU9LfVk8VwDxLu7AhDs=;
	h=From:To:Cc:Subject:Date:From;
	b=Nut0wwAfIZ/1YFZTjEZLhk060n1eGRbTdh0jfp0jBfrqJyBp0Ul7GG7UDU8A7UwA5
	 UjQ3Sygqcq6jtCxNzaoBC4mgY/hE1cB5f7ZgZqXyguIRnixvwGgGxLWyfW+CmM4QAa
	 qEE4fnwYoj/tI62BWOwQGJo5BJ0sgV6RZcc/f0aE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: mika.westerberg@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	linux-usb@vger.kernel.org
Subject: [PATCH] thunderbolt: make tb_bus_type const
Date: Tue, 19 Dec 2023 16:43:05 +0100
Message-ID: <2023121904-utopia-broadcast-06d1@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 43
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=Ql8eGZzccquuIXGz4rdOVYKLAU9LfVk8VwDxLu7AhDs=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmNuzjz9PpUpdVOpS+WbT/w9uYV4/tNez6qsx5Q2sOrN 9n+39/CjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIZlWG+eHZTZclt22M5haf PJUtQ9xaed2cfoYFm79r7dW6csLfQ/Js7Nf4jLxzwar6AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the tb_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/domain.c | 2 +-
 include/linux/thunderbolt.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index ec7b5f65804e..9fb1a64f3300 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -307,7 +307,7 @@ static const struct attribute_group *domain_attr_groups[] = {
 	NULL,
 };
 
-struct bus_type tb_bus_type = {
+const struct bus_type tb_bus_type = {
 	.name = "thunderbolt",
 	.match = tb_service_match,
 	.probe = tb_service_probe,
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 6151c210d987..2c835e5c41f6 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -86,7 +86,7 @@ struct tb {
 	unsigned long privdata[];
 };
 
-extern struct bus_type tb_bus_type;
+extern const struct bus_type tb_bus_type;
 extern struct device_type tb_service_type;
 extern struct device_type tb_xdomain_type;
 
-- 
2.43.0


