Return-Path: <linux-kernel+bounces-7371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F6581A6A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE3A2880C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12F5481BA;
	Wed, 20 Dec 2023 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="vow7rELA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from forward203a.mail.yandex.net (forward203a.mail.yandex.net [178.154.239.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B45481B8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward203a.mail.yandex.net (Yandex) with ESMTP id 09D8D6AC3E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:00:41 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:b826:0:640:9cf9:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTP id 33C48608ED;
	Wed, 20 Dec 2023 21:00:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id V0SA4sKOk8c0-cUCPWOTM;
	Wed, 20 Dec 2023 21:00:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1703095232; bh=rt7DqW1KMJBKQLbM5Mtmr4UQfewE0ExgpNcy5yW/lpw=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=vow7rELAc4BLVbif5tV/Es3AT1+ioQoW1kLvzdPV6Curh80WoC0DH0S7auxbW0+LA
	 DZ5cUf0oyB7s7fPnk5S/VNZAGvKHzmNw2b239fAzvUvJVRhrnEBX0MBTddk8bDIwft
	 RdmljvURiVli1TjDxhm9DjYoNBjTsg6X4YcHAWLY=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] regmap: fix kcalloc() arguments order
Date: Wed, 20 Dec 2023 20:58:19 +0300
Message-ID: <20231220175829.533700-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with gcc version 14.0.0 20231220 (experimental)
and W=1, I've noticed a bunch of four similar warnings like:

drivers/base/regmap/regmap-ram.c: In function '__regmap_init_ram':
drivers/base/regmap/regmap-ram.c:68:37: warning: 'kcalloc' sizes specified with
'sizeof' in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
   68 |         data->read = kcalloc(sizeof(bool), config->max_register + 1,
      |                                     ^~~~

Since 'n' and 'size' arguments of 'kcalloc()' are multiplied to
calculate the final size, their actual order doesn't affect the
result and so this is not a bug. But it's still worth to fix it.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/base/regmap/regmap-ram.c     | 4 ++--
 drivers/base/regmap/regmap-raw-ram.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-ram.c b/drivers/base/regmap/regmap-ram.c
index 85f34a5dee04..192d6b131dff 100644
--- a/drivers/base/regmap/regmap-ram.c
+++ b/drivers/base/regmap/regmap-ram.c
@@ -65,12 +65,12 @@ struct regmap *__regmap_init_ram(const struct regmap_config *config,
 		return ERR_PTR(-EINVAL);
 	}
 
-	data->read = kcalloc(sizeof(bool), config->max_register + 1,
+	data->read = kcalloc(config->max_register + 1, sizeof(bool),
 			     GFP_KERNEL);
 	if (!data->read)
 		return ERR_PTR(-ENOMEM);
 
-	data->written = kcalloc(sizeof(bool), config->max_register + 1,
+	data->written = kcalloc(config->max_register + 1, sizeof(bool),
 				GFP_KERNEL);
 	if (!data->written)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/base/regmap/regmap-raw-ram.c b/drivers/base/regmap/regmap-raw-ram.c
index c9b800885f3b..ecd33128f0c3 100644
--- a/drivers/base/regmap/regmap-raw-ram.c
+++ b/drivers/base/regmap/regmap-raw-ram.c
@@ -111,12 +111,12 @@ struct regmap *__regmap_init_raw_ram(const struct regmap_config *config,
 		return ERR_PTR(-EINVAL);
 	}
 
-	data->read = kcalloc(sizeof(bool), config->max_register + 1,
+	data->read = kcalloc(config->max_register + 1, sizeof(bool),
 			     GFP_KERNEL);
 	if (!data->read)
 		return ERR_PTR(-ENOMEM);
 
-	data->written = kcalloc(sizeof(bool), config->max_register + 1,
+	data->written = kcalloc(config->max_register + 1, sizeof(bool),
 				GFP_KERNEL);
 	if (!data->written)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0


