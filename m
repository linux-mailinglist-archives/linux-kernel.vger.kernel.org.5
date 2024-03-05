Return-Path: <linux-kernel+bounces-92961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DC08728AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2EC1F2C7FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1437812881F;
	Tue,  5 Mar 2024 20:25:11 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30366128827;
	Tue,  5 Mar 2024 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670310; cv=none; b=ogALKf8LZCo7KOSlHJD5Ll1Mhzq3q9h7GptVcwt5KwjP+DkNSiblixy+pPVgl/Dj3bw1JqT86EadRCpeWkOoEw59B7C1bd0TdSfQA4Lbw9TazKIkgsGfHeVLZZD2cexqRsBYl4VsLgXNFeugCSSp8/h8Y4Tq2wujwVoVkyySifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670310; c=relaxed/simple;
	bh=eCjR4mfI+AWqQXtiUhJgIvBVLRaJmzjFD41b5wteOLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOQxzJ13L3u6Ctjztg8a5cgljYI6fbMWGK3C2aLg9joNSstBwurujTaiTyZ4xZmyv6Eg1U5UocAtrSI+lpKMyGEdXLCaFegLZ+6YPTNSW0fwx2Ofg60XQVCRs+Wt3AruFjURTQOMgLP03VOnQLXrcK40S59fEd+rAcsa1mf4arw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rhbLB-0001S5-24;
	Tue, 05 Mar 2024 20:24:45 +0000
Date: Tue, 5 Mar 2024 20:24:41 +0000
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
Subject: [RFC PATCH v2 8/8] mmc: block: set GENHD_FL_NVMEM
Message-ID: <9315d06c7b286af445ff32e4db2e7a8c1c2d6ea4.1709667858.git.daniel@makrotopia.org>
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

Set flag to consider MMC block devices as NVMEM providers.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mmc/core/block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index c3e9477743515..8cd0400c9887d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2514,6 +2514,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	md->disk->major	= MMC_BLOCK_MAJOR;
 	md->disk->minors = perdev_minors;
 	md->disk->first_minor = devidx * perdev_minors;
+	md->disk->flags = GENHD_FL_NVMEM;
 	md->disk->fops = &mmc_bdops;
 	md->disk->private_data = md;
 	md->parent = parent;
-- 
2.44.0

