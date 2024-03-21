Return-Path: <linux-kernel+bounces-110593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463C788610F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FE4282C37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B79E58AC0;
	Thu, 21 Mar 2024 19:34:19 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377BC132C37;
	Thu, 21 Mar 2024 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049658; cv=none; b=MTIRbaIyGguKAZ5EZFxDNsHbz1lx3nvwhZYllMR4edrXciTEv0yIwXmmNxqtGU/AKgF7hezkBWXi436Yog91lCGiOx0PpNlCa75MiiHirYJHAXR0vjP7ZSLN8dCPGEmZ6aEwKuar84OVOdvQJzYykxJWrCIW+ENO8wDqf5QMPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049658; c=relaxed/simple;
	bh=riNJOLS1PDkHeYFfgxlyU2hpU4+11KYkJC8sj8wJoVw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBnRT1fSOg6UQFuQwR6lXwuJ9EDf6VqJr6afi62135KFoDK7KzdcMkO7W+gnkci/9dneScer+LWGqUmQ5p+vSA+4SOg+J3nKPQKl2zOB8+Ec4Q4sOtN88uZBlubNfRorSpLpa/UwfRaV5epfS0UpQrXyGMHOqdWAMJNCcRNcvRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rnOAj-0000Ex-2q;
	Thu, 21 Mar 2024 19:33:54 +0000
Date: Thu, 21 Mar 2024 19:33:49 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Daniel Golle <daniel@makrotopia.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>, Hannes Reinecke <hare@suse.de>,
	Christian Loehle <CLoehle@hyperstone.com>,
	Bean Huo <beanhuo@micron.com>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 3/8] block: add new genhd flag GENHD_FL_NVMEM
Message-ID: <89abd9ab93783da0e8934ebc03d66559f78f6060.1711048433.git.daniel@makrotopia.org>
References: <cover.1711048433.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1711048433.git.daniel@makrotopia.org>

Add new flag to destinguish block devices which may act as an NVMEM
provider.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 include/linux/blkdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c3e8f7cf96be9..f2c4f280d7619 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -81,11 +81,13 @@ struct partition_meta_info {
  * ``GENHD_FL_NO_PART``: partition support is disabled.  The kernel will not
  * scan for partitions from add_disk, and users can't add partitions manually.
  *
+ * ``GENHD_FL_NVMEM``: the block device should be considered as NVMEM provider.
  */
 enum {
 	GENHD_FL_REMOVABLE			= 1 << 0,
 	GENHD_FL_HIDDEN				= 1 << 1,
 	GENHD_FL_NO_PART			= 1 << 2,
+	GENHD_FL_NVMEM				= 1 << 3,
 };
 
 enum {
-- 
2.44.0

