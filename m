Return-Path: <linux-kernel+bounces-23861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46682B2E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7C51C2621A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DB050266;
	Thu, 11 Jan 2024 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="omZcBp3P";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="daFQmSRg"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93114F8B4;
	Thu, 11 Jan 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from alley.prg2.suse.org (unknown [10.100.208.146])
	by smtp-out1.suse.de (Postfix) with ESMTP id 17335220B5;
	Thu, 11 Jan 2024 16:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704990304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MMA7Jf2m2884PIJudPkb8VYRI5Ehzqro2oR8+njB8z4=;
	b=omZcBp3PMMiuePhg0CoAme0EZOLLnvHGorGhuiXqdUVzHueKRVJ1S2cm5yB0Os4jyw9+II
	XT72E5G0QG/k/0Z7BNYHJrPgzDdYruiO3660Q62T0cXLs0qG4FGl0aXYPRmUkNy9ciLr15
	98/z84jcsljzuhiBTTmPG8EpkqzFxdg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704990302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MMA7Jf2m2884PIJudPkb8VYRI5Ehzqro2oR8+njB8z4=;
	b=daFQmSRgfXmQ2xfQHqCLhVDEGrQjfY/3zISaoPq23AIbJc831A9PTJZFzLrNFKJaZT0gRf
	D12i9akvlzYmBsZoBrp0dT/6avOUJ2QMDNOOY+192RW2ZJqVSNknymCOZ09q4d4NuPmcxZ
	jEnjmMx1rP6nI6BUHA1jTxasaNOyiMU=
From: Petr Mladek <pmladek@suse.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Down <chris@chrisdown.name>,
	oe-kbuild-all@lists.linux.dev,
	Petr Mladek <pmladek@suse.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] scsi: core: Safe warning about bad dev info string
Date: Thu, 11 Jan 2024 17:24:19 +0100
Message-ID: <20240111162419.12406-1-pmladek@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

Both "model" and "strflags" are passed to "%s" even when one or both
are NULL.

It is safe because vsprintf() would detect the NULL pointer and print
"(null)". But it is a kernel-specific feature and compiler warns
about it:

<warning>
   In file included from include/linux/kernel.h:19,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from include/linux/blkdev.h:5,
                    from drivers/scsi/scsi_devinfo.c:3:
   drivers/scsi/scsi_devinfo.c: In function 'scsi_dev_info_list_add_str':
>> include/linux/printk.h:434:44: warning: '%s' directive argument is null [-Wformat-overflow=]
     434 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                            ^
   include/linux/printk.h:430:3: note: in definition of macro 'printk_index_wrap'
     430 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |   ^~~~~~~
   drivers/scsi/scsi_devinfo.c:551:4: note: in expansion of macro 'printk'
     551 |    printk(KERN_ERR "%s: bad dev info string '%s' '%s'"
         |    ^~~~~~
   drivers/scsi/scsi_devinfo.c:552:14: note: format string is defined here
     552 |           " '%s'\n", __func__, vendor, model,
         |              ^~
</warning>

Do not rely on the kernel specific behavior and print the message a safe way.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401112002.AOjwMNM0-lkp@intel.com/
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
Note: The patch is only compile tested.

 drivers/scsi/scsi_devinfo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index 3fcaf10a9dfe..ba7237e83863 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -551,9 +551,9 @@ static int scsi_dev_info_list_add_str(char *dev_list)
 		if (model)
 			strflags = strsep(&next, next_check);
 		if (!model || !strflags) {
-			printk(KERN_ERR "%s: bad dev info string '%s' '%s'"
-			       " '%s'\n", __func__, vendor, model,
-			       strflags);
+			pr_err("%s: bad dev info string '%s' '%s' '%s'\n",
+			       __func__, vendor, model ? model : "",
+			       strflags ? strflags : "");
 			res = -EINVAL;
 		} else
 			res = scsi_dev_info_list_add(0 /* compatible */, vendor,
-- 
2.43.0


