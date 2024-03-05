Return-Path: <linux-kernel+bounces-92960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652008728A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C8A1F2C784
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428D212C809;
	Tue,  5 Mar 2024 20:24:54 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530AC12881F;
	Tue,  5 Mar 2024 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670293; cv=none; b=jEMfGIJvA1aXFmsPJ2PO5QbINHdgXklww9VdLD+yFgC3vaURMoCLnSJvH+FcNl0ALCpSEf/Boew4rCYeuaAh6+yU+knqoGuZ2IoYbnfGze5ymTlzVgZAqgKp+BmT/5mjOBNJPJPKSqgLiegKCsa8Fxv764KQiwbhYgMgHtxNsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670293; c=relaxed/simple;
	bh=YaB2y2wN9NfY5eb0MhPB3fO/s+7TOMJVq/CsEjdI+HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaQt1cS3wOgwF50qL+CpMinGWTD2TIl1f4nIL5UleMQHj9DuAuMu11vVA2AMJKCvBVzKVLqbHrqrlEgb7tozv/ZGZYqefXG//3HH/rO4J8azWw5KVy1XBJkeGtOVnR0IVLiS59UNDw2ZHnjxKTjZ56joJW+AdLdVh+FTUXvbg/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rhbKz-0001RH-1q;
	Tue, 05 Mar 2024 20:24:33 +0000
Date: Tue, 5 Mar 2024 20:24:29 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Daniel Golle <daniel@makrotopia.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Christian Brauner <brauner@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Damien Le Moal <dlemoal@kernel.org>, Min Li <min15.li@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Christian Loehle <CLoehle@hyperstone.com>,
	Avri Altman <avri.altman@wdc.com>, Bean Huo <beanhuo@micron.com>,
	Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Cc: Diping Zhang <diping.zhang@gl-inet.com>,
	Jianhui Zhao <zhaojh329@gmail.com>,
	Jieying Zeng <jieying.zeng@gl-inet.com>,
	Chad Monroe <chad.monroe@adtran.com>,
	Adam Fox <adam.fox@adtran.com>, John Crispin <john@phrozen.org>
Subject: [RFC PATCH v2 7/8] mmc: block: set fwnode of disk devices
Message-ID: <84aba89131f19c836ad0bc029bb74ea1d6f08d17.1709667858.git.daniel@makrotopia.org>
References: <cover.1709667858.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709667858.git.daniel@makrotopia.org>

Set fwnode of disk devices to 'block', 'boot0' and 'boot1' subnodes of
the mmc-card. This is done in preparation for having the eMMC act as
NVMEM provider.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mmc/core/block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index bd165cef2bbc3..c3e9477743515 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2461,6 +2461,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 					      int area_type,
 					      unsigned int part_type)
 {
+	struct fwnode_handle *fwnode;
 	struct mmc_blk_data *md;
 	int devidx, ret;
 	char cap_str[10];
@@ -2557,6 +2558,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 
 	blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
 
+	fwnode = device_get_named_child_node(subname ? md->parent->parent :
+						       md->parent,
+					     subname ? subname : "block");
+	if (fwnode)
+		device_set_node(disk_to_dev(md->disk), fwnode);
+
 	string_get_size((u64)size, 512, STRING_UNITS_2,
 			cap_str, sizeof(cap_str));
 	pr_info("%s: %s %s %s%s\n",
-- 
2.44.0

