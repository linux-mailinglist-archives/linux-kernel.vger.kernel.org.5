Return-Path: <linux-kernel+bounces-2677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A46816068
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D218B21DB1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A9045C09;
	Sun, 17 Dec 2023 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gFDR1Tel"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FF931A76
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id EuD7r5CEpltw6EuD7r5Vo4; Sun, 17 Dec 2023 17:41:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702831310;
	bh=qZLyEZlQ9TBd/oPoWGgLrvvH3X2lVDoFqEcZrhT5j2A=;
	h=From:To:Cc:Subject:Date;
	b=gFDR1Tel9cmLkNoOvF6uv/bH4Pk7LxrArkaq3XmmGVtM15zEInb9n37wSfmPAYOQV
	 kkXe8QLSKSs48gsIQy1BV+6nP+arP7eEaXtEoNFmP42juv51L9twrC1moOo6RUTRfs
	 G6STODuIbU2+U/lV0bzujvYcUPLBZ3/7bqFIjZMlW0OQd+1fCQLCOPqDrThjr+CJe8
	 l4ic3virzVzwJIzHEy8b3h8e+ljqyy45u+pJeJk4Qft5anbsDIPwRGSMXd7yzJnYPx
	 f94s2tiH0MlPTI5suTu6qPI6TjSQEjg9pp0usjpXhcYLAbilelK2Wm4gSI9YDWtgT4
	 rdjcyX9Ryfu3w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Dec 2023 17:41:50 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: buffer: Use IIO_SEPARATE instead of a hard-coded 0
Date: Sun, 17 Dec 2023 17:41:45 +0100
Message-Id: <1d17f57423172fcb9d9797cfe7c8282f356049c2.1702831285.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use an explicit IIO_SEPARATE instead of 0 for the 'shared_by' parameter
when calling __iio_add_chan_devattr().

For some reason, commit 3704432fb1fd ("iio: refactor info mask and ext_info
attribute creation.") updated only 1 place out of 4.
Update the remaining ones now.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/industrialio-buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 09c41e9ccf87..b581a7e80566 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -616,7 +616,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 				     &iio_show_fixed_type,
 				     NULL,
 				     0,
-				     0,
+				     IIO_SEPARATE,
 				     &indio_dev->dev,
 				     buffer,
 				     &buffer->buffer_attr_list);
@@ -629,7 +629,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 					     &iio_scan_el_show,
 					     &iio_scan_el_store,
 					     chan->scan_index,
-					     0,
+					     IIO_SEPARATE,
 					     &indio_dev->dev,
 					     buffer,
 					     &buffer->buffer_attr_list);
@@ -639,7 +639,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 					     &iio_scan_el_ts_show,
 					     &iio_scan_el_ts_store,
 					     chan->scan_index,
-					     0,
+					     IIO_SEPARATE,
 					     &indio_dev->dev,
 					     buffer,
 					     &buffer->buffer_attr_list);
-- 
2.34.1


