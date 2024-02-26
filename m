Return-Path: <linux-kernel+bounces-82135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD85867FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA112931DA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4388F12F37A;
	Mon, 26 Feb 2024 18:24:06 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C559412EBF6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971845; cv=none; b=tJToVHzAUmNSwTMhDFvbggaMO1e6Dr9ypw/w58KOKJ4F0E98VQnE9+wxOcXbM9+UG7w/x/y2Wn2jbxZxjvpCRHy5FHoxXXirqi/q8xexWpAYyaZbHymcgLtanM8n02ZhbVDzebPQ9QYqUIsiiKSEyfMw3zbZysyvc3FpWiHVci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971845; c=relaxed/simple;
	bh=EVA7p+p/jssTufLGPq3W6nEZjpm7PKdjlJhX2FVWTAg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HARhO7fuw7oDngRfJCjlOP+hUbVcFb18bp/Se29koZMjydntNifYlapJK5ca8kGHSgcMYb8olUKTPSHO9GDDd0kvOdyyuNlHj04Zs8Xb8cjeAXsF24y4KkZHzv316W1BXbq10K5Vj9loMleawd2NE2QER9kKxtTZTKUSFJVJ4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1refdl-0003fF-06;
	Mon, 26 Feb 2024 18:23:49 +0000
Date: Mon, 26 Feb 2024 18:23:42 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Daniel Golle <daniel@makrotopia.org>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: ubi: fix NVMEM over UBI volumes on 32-bit systems
Message-ID: <186fa96ae25f7033ff8b6f0f7fcfb1e602f556fc.1708971705.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A compiler warning related to sizeof(int) != 8 when calling do_div()
is triggered when building on 32-bit platforms.
Address this by using integer types having a well-defined size where
appropriate.

Fixes: 3ce485803da1 ("mtd: ubi: provide NVMEM layer over UBI volumes")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/nvmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/nvmem.c b/drivers/mtd/ubi/nvmem.c
index b7a93c495d172..5820a170d2512 100644
--- a/drivers/mtd/ubi/nvmem.c
+++ b/drivers/mtd/ubi/nvmem.c
@@ -23,14 +23,17 @@ struct ubi_nvmem {
 static int ubi_nvmem_reg_read(void *priv, unsigned int from,
 			      void *val, size_t bytes)
 {
-	int err = 0, lnum = from, offs, bytes_left = bytes, to_read;
+	uint32_t bytes_left, offs, to_read;
 	struct ubi_nvmem *unv = priv;
 	struct ubi_volume_desc *desc;
+	uint64_t lnum = from;
+	int err = 0;
 
 	desc = ubi_open_volume(unv->ubi_num, unv->vol_id, UBI_READONLY);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
+	bytes_left = bytes;
 	offs = do_div(lnum, unv->usable_leb_size);
 	while (bytes_left) {
 		to_read = unv->usable_leb_size - offs;
-- 
2.44.0


