Return-Path: <linux-kernel+bounces-6503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E1F8199B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F42F1F25254
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E59F2033E;
	Wed, 20 Dec 2023 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DoXcTtdv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D998320317;
	Wed, 20 Dec 2023 07:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A892C433C8;
	Wed, 20 Dec 2023 07:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703057937;
	bh=eNwCbKBc8bEaqjAy+qYjJj2OPZznDf1/3qGd2xNtjGs=;
	h=From:To:Cc:Subject:Date:From;
	b=DoXcTtdvuYY0UfYPC0jC70LKzoLYhj4f4tqaA68RIF4LjPI51PI7VxH1kJdK/sS6y
	 rvo0mMBwa97QA9f3KtmISGbwUyFPN0AqUbQ402lMizseWsh/VpB1C8/o/jmXzFmqCR
	 qiwCbVhIXrciUqKba85p/l8s64eR9vUvdpDgC6UI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: jikos@kernel.org,
	benjamin.tissoires@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-input@vger.kernel.org
Subject: [PATCH 1/3] HID: make hid_bus_type const
Date: Wed, 20 Dec 2023 08:38:46 +0100
Message-ID: <2023122045-pellet-eggbeater-8d2f@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 41
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=eNwCbKBc8bEaqjAy+qYjJj2OPZznDf1/3qGd2xNtjGs=; b=owGbwMvMwCRo6H6F97bub03G02pJDKlNs9h+TroyMfL7F87Fe1IWsEbOVXDm0gt9k5HFFPfMc tZ7QS7bjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjISVuGBau2BHx6Kz5vtaLJ yTqp/Wce+fXM+MEwv1hrc1Er7xMftVeXN8gLukhlqy/gAwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the hid_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-core.c | 2 +-
 include/linux/hid.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e0181218ad85..de7a477d6665 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2749,7 +2749,7 @@ static int hid_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-struct bus_type hid_bus_type = {
+const struct bus_type hid_bus_type = {
 	.name		= "hid",
 	.dev_groups	= hid_dev_groups,
 	.drv_groups	= hid_drv_groups,
diff --git a/include/linux/hid.h b/include/linux/hid.h
index bf43f3ff6664..7c26db874ff0 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -912,7 +912,7 @@ extern bool hid_ignore(struct hid_device *);
 extern int hid_add_device(struct hid_device *);
 extern void hid_destroy_device(struct hid_device *);
 
-extern struct bus_type hid_bus_type;
+extern const struct bus_type hid_bus_type;
 
 extern int __must_check __hid_register_driver(struct hid_driver *,
 		struct module *, const char *mod_name);
-- 
2.43.0


