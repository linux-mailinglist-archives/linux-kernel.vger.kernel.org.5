Return-Path: <linux-kernel+bounces-92955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D530872892
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C931F2C748
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBCC12BF2E;
	Tue,  5 Mar 2024 20:24:09 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4665112BE8C;
	Tue,  5 Mar 2024 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670248; cv=none; b=LD/qTgf/E8iwv+E+ZLHFRD4ZxL7lQjYL93JkdqcyJ2o31s3yKOEiw044S+QSHNaEhpBHOSnNUGBghCpyeL6qFbTtzahn5KB6NMCNwze4tBNKos21eXnyh6ZURijPKBuv4HD8zySAiz1OF8gDtljX7hxjzZl4I/I6j/X6y4nsXAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670248; c=relaxed/simple;
	bh=2Quus8bwOAvZ26pD2KZKwCchqWnTAr6TMdGV+yLI5KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kz7IKQ1C/5iRjfqkaFF9CZhF1Ha+kvySQ+qha55NDIMVxvMBSwr4/VaEMxchLhX6x+nqgze/kL6fDjqYF/Kkr2nQWZxKM8+y1uSRXK4SH1KSWvv/OgxSxHwYBCV7S82ZD2slVP/qFbXjNVhGrpozMLHrKHD3N+vOrsEf4jM2x5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rhbKG-0001ND-2V;
	Tue, 05 Mar 2024 20:23:48 +0000
Date: Tue, 5 Mar 2024 20:23:44 +0000
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
Subject: [RFC PATCH v2 3/8] block: add new genhd flag GENHD_FL_NVMEM
Message-ID: <a8dcca3839aa4109e22806bc53257604e0560291.1709667858.git.daniel@makrotopia.org>
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

Add new flag to destinguish block devices which may act as an NVMEM
provider.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 include/linux/blkdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 715c9201008a6..03e4b1fd5060d 100644
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

