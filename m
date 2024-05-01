Return-Path: <linux-kernel+bounces-165114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE89F8B8841
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4711F2359A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29E651C5A;
	Wed,  1 May 2024 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Mdp18xET"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002E645;
	Wed,  1 May 2024 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714557063; cv=none; b=VOZnjUtxAF+FUZzEPAFQowypar7R2fcu9z2x+0AFZoJ7WrmTyyww5oCWpt59MjNyVqfNiepqRSRureIY7YlL1GcHQ2g0wHByv5OIDjAhNodcW7UpaZAvxpsO5Mn4y1yWQ+z/LeXqvHpsIO0IsFxQ9qJRhlTIVkTFf7lWBhyU1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714557063; c=relaxed/simple;
	bh=vvylw6nHMRwLM+9gl4nry8f4/NOWGRkQIZOZBNuzl2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXXMqJhdUICMi1E4Y5dri+7OnpT53GOFuzJaPSUqsnboDC9FtnFnyuOlRfbIZENMQU32pUo7ZFVKcDDpUZz36JlFRNet7MwxP83ESFIBMO7NlGfJqDdzAJDZJRBhmVLCdIdfw79wW3Fy552e0RrmTCWXGi8jczMSrI6u1XbJDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Mdp18xET; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 26TUsv4R8rs7M26TVswXrR; Wed, 01 May 2024 11:42:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714556525;
	bh=ihCvMaCJ1TBCxY0a/aMCQRyN7JfGY+w7nfdzuRre2yE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Mdp18xETnmsMenUVoZrWFluvlKQYzatXX8PVmttk5gqXUkGJmUVmf+27K08lRONih
	 9ne2w5Oayq4N1lE47ayVek3AW38LvPAJOLXIWWYkY+EDMZE73GlSxd/Nw7MmAWxiAg
	 dCUghnZwQQNw5ReWb71IeeyMvieGtgx/SscbK3vWze5VrVJN5pikTAaomrte2hYLsi
	 PXiqagxfo6Ct8TLy8cdScQtLj2iY3bfh1DYLAlNpQDw6Th+LBr/NWTePyEkHLDGrHj
	 2Rr8hA1kmhdaehLI2tp2iMN27/UW7xIqgqULiEvB759FZABwA7BMfk+a2JxNSid0Of
	 4omHN6Y0RK21Q==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 May 2024 11:42:05 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: multiplexer: Remove an unused field in struct mux
Date: Wed,  1 May 2024 11:41:54 +0200
Message-ID: <7bb04abdc2815caf090a6c9ecab2a51d837792a7.1714556499.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "struct mux", the 'indio_dev' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

It was added in the initial commit 7ba9df54b091 ("iio: multiplexer: new iio
category and iio-mux driver") but was never used.
---
 drivers/iio/multiplexer/iio-mux.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index edd8c69f6d2e..2953403bef53 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -30,7 +30,6 @@ struct mux {
 	int cached_state;
 	struct mux_control *control;
 	struct iio_channel *parent;
-	struct iio_dev *indio_dev;
 	struct iio_chan_spec *chan;
 	struct iio_chan_spec_ext_info *ext_info;
 	struct mux_child *child;
-- 
2.44.0


