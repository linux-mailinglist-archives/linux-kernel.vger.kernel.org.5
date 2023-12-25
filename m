Return-Path: <linux-kernel+bounces-10943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 408E081DEF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 060FBB20D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93155CA7A;
	Mon, 25 Dec 2023 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="WecyzIm8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94057DDD6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:subject:message-id:mime-version;
  bh=dD0bUVWTY8SwBG2Vb0rtdcxWd/KeOad5hG/gzoZpvzM=;
  b=WecyzIm8FcbCLsH0G80Y7wNSYoCZtGGxVA09Gz5p0XC6rUpHSpPtYX6e
   zM/V8xYwP7s7Cw6DP+TRMdSMH0FPf34I84WP6uUJbKsiP49SFzg0J+Kl6
   Fdy8QoucjYgwikrOhrMNO4r1ppTQ+ddp3viNEICcYFMo9x+Y3hwPmwVxS
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,302,1695679200"; 
   d="scan'208";a="75310300"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 08:58:47 +0100
Date: Mon, 25 Dec 2023 08:58:46 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>, 
    Miquel Raynal <miquel.raynal@bootlin.com>, linux-kernel@vger.kernel.org, 
    oe-kbuild-all@lists.linux.dev
Subject: drivers/mtd/mtdcore.c:577:1-23: WARNING: Function "for_each_child_of_node"
 should have of_node_put() before break around line 594. (fwd)
Message-ID: <alpine.DEB.2.22.394.2312250857060.3331@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1931466063-1703491126=:3331"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1931466063-1703491126=:3331
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hello,

Actually, I think that the of_node_put on line 598 should move to line
594.  If the loop terminates normally, positions will be the loop header,
and it will not be apporpriate to call of node put on it.

julia

---------- Forwarded message ----------
Date: Mon, 25 Dec 2023 05:23:49 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/mtd/mtdcore.c:577:1-23: WARNING: Function
    "for_each_child_of_node" should have of_node_put() before break around line
    594.

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: "Rafał Miłecki" <rafal@milecki.pl>
CC: Miquel Raynal <miquel.raynal@bootlin.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861deac3b092f37b2c5e6871732f3e11486f7082
commit: 2df11f00100d7278185a9dbefa20ba3f5d32401d mtd: core: try to find OF node for every MTD partition
date:   1 year, 2 months ago
:::::: branch date: 21 hours ago
:::::: commit date: 1 year, 2 months ago
config: loongarch-randconfig-r062-20231222 (https://download.01.org/0day-ci/archive/20231225/202312250546.ISzglvM2-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202312250546.ISzglvM2-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/mtd/mtdcore.c:577:1-23: WARNING: Function "for_each_child_of_node" should have of_node_put() before break around line 594.

vim +/for_each_child_of_node +577 drivers/mtd/mtdcore.c

c4dfa25ab307a2 Alban Bedel       2018-11-13  548
ad9b10d1eaada1 Christian Marangi 2022-06-22  549  static void mtd_check_of_node(struct mtd_info *mtd)
ad9b10d1eaada1 Christian Marangi 2022-06-22  550  {
ad9b10d1eaada1 Christian Marangi 2022-06-22  551  	struct device_node *partitions, *parent_dn, *mtd_dn = NULL;
ad9b10d1eaada1 Christian Marangi 2022-06-22  552  	const char *pname, *prefix = "partition-";
ad9b10d1eaada1 Christian Marangi 2022-06-22  553  	int plen, mtd_name_len, offset, prefix_len;
ad9b10d1eaada1 Christian Marangi 2022-06-22  554
ad9b10d1eaada1 Christian Marangi 2022-06-22  555  	/* Check if MTD already has a device node */
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  556  	if (mtd_get_of_node(mtd))
ad9b10d1eaada1 Christian Marangi 2022-06-22  557  		return;
ad9b10d1eaada1 Christian Marangi 2022-06-22  558
7ec4cdb321738d Tetsuo Handa      2022-07-25  559  	if (!mtd_is_partition(mtd))
7ec4cdb321738d Tetsuo Handa      2022-07-25  560  		return;
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  561
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  562  	parent_dn = of_node_get(mtd_get_of_node(mtd->parent));
ad9b10d1eaada1 Christian Marangi 2022-06-22  563  	if (!parent_dn)
ad9b10d1eaada1 Christian Marangi 2022-06-22  564  		return;
ad9b10d1eaada1 Christian Marangi 2022-06-22  565
2df11f00100d72 Rafał Miłecki     2022-10-04  566  	if (mtd_is_partition(mtd->parent))
2df11f00100d72 Rafał Miłecki     2022-10-04  567  		partitions = of_node_get(parent_dn);
2df11f00100d72 Rafał Miłecki     2022-10-04  568  	else
ad9b10d1eaada1 Christian Marangi 2022-06-22  569  		partitions = of_get_child_by_name(parent_dn, "partitions");
ad9b10d1eaada1 Christian Marangi 2022-06-22  570  	if (!partitions)
ad9b10d1eaada1 Christian Marangi 2022-06-22  571  		goto exit_parent;
ad9b10d1eaada1 Christian Marangi 2022-06-22  572
ad9b10d1eaada1 Christian Marangi 2022-06-22  573  	prefix_len = strlen(prefix);
ad9b10d1eaada1 Christian Marangi 2022-06-22  574  	mtd_name_len = strlen(mtd->name);
ad9b10d1eaada1 Christian Marangi 2022-06-22  575
ad9b10d1eaada1 Christian Marangi 2022-06-22  576  	/* Search if a partition is defined with the same name */
ad9b10d1eaada1 Christian Marangi 2022-06-22 @577  	for_each_child_of_node(partitions, mtd_dn) {
ad9b10d1eaada1 Christian Marangi 2022-06-22  578  		/* Skip partition with no/wrong prefix */
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  579  		if (!of_node_name_prefix(mtd_dn, prefix))
ad9b10d1eaada1 Christian Marangi 2022-06-22  580  			continue;
ad9b10d1eaada1 Christian Marangi 2022-06-22  581
ad9b10d1eaada1 Christian Marangi 2022-06-22  582  		/* Label have priority. Check that first */
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  583  		if (!of_property_read_string(mtd_dn, "label", &pname)) {
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  584  			offset = 0;
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  585  		} else {
c5f5d0cd40e3bc Rafał Miłecki     2022-10-04  586  			pname = mtd_dn->name;
ad9b10d1eaada1 Christian Marangi 2022-06-22  587  			offset = prefix_len;
ad9b10d1eaada1 Christian Marangi 2022-06-22  588  		}
ad9b10d1eaada1 Christian Marangi 2022-06-22  589
ad9b10d1eaada1 Christian Marangi 2022-06-22  590  		plen = strlen(pname) - offset;
ad9b10d1eaada1 Christian Marangi 2022-06-22  591  		if (plen == mtd_name_len &&
ad9b10d1eaada1 Christian Marangi 2022-06-22  592  		    !strncmp(mtd->name, pname + offset, plen)) {
2df11f00100d72 Rafał Miłecki     2022-10-04  593  			mtd_set_of_node(mtd, mtd_dn);
ad9b10d1eaada1 Christian Marangi 2022-06-22 @594  			break;
ad9b10d1eaada1 Christian Marangi 2022-06-22  595  		}
ad9b10d1eaada1 Christian Marangi 2022-06-22  596  	}
ad9b10d1eaada1 Christian Marangi 2022-06-22  597
ad9b10d1eaada1 Christian Marangi 2022-06-22  598  	of_node_put(partitions);
ad9b10d1eaada1 Christian Marangi 2022-06-22  599  exit_parent:
ad9b10d1eaada1 Christian Marangi 2022-06-22  600  	of_node_put(parent_dn);
ad9b10d1eaada1 Christian Marangi 2022-06-22  601  }
ad9b10d1eaada1 Christian Marangi 2022-06-22  602

:::::: The code at line 577 was first introduced by commit
:::::: ad9b10d1eaada169bd764abcab58f08538877e26 mtd: core: introduce of support for dynamic partitions

:::::: TO: Christian Marangi <ansuelsmth@gmail.com>
:::::: CC: Miquel Raynal <miquel.raynal@bootlin.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
--8323329-1931466063-1703491126=:3331--

