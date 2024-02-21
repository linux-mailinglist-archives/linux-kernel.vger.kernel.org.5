Return-Path: <linux-kernel+bounces-74690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BCE85D7BF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67741B22847
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592144F5FE;
	Wed, 21 Feb 2024 12:14:08 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39E33B794;
	Wed, 21 Feb 2024 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517647; cv=none; b=OOSm5q11P1djgUbh18Zlnv0jEyFm4Eg/rRGP1i77bRtHTguJmBFSmNn3rs6mkCSFwla0uSuKAHGXUq6cd9TnNXi+ME7uc762xjwq9oXetuILSrLQ4zlvY7fAq2k7t7nqnR9/1p60l4TJLX//okIEi4+oZCCM2ZgvaSN8LfNUk28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517647; c=relaxed/simple;
	bh=MqhbnS1NjXDY8Qh9eFNNfw3K5AIjRJ9BCE+okMQm6tI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TDRMKHXLBxEhbbinfjHjXF3YCe7yeeR/gMflUMI+qSgJaVbxkVzwBzj0Jf/chpMtEYhZlEhRKwwBH1NFlJu4Dbqe7o9197oVqXXaN9Iw+jMWenSJ2oBczSoxqftbQI6GlzyuDSN9vu1RNjhxsjpb6/DcjdjpUwh2vytDytZ6qsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.233.36])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Tfw1m5C1dzlVxB;
	Wed, 21 Feb 2024 15:04:44 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] Add NULL check for SCp in process_script_interrupt()
Date: Wed, 21 Feb 2024 15:04:14 +0300
Message-Id: <20240221120414.29192-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgrucffihhuphhinhgruceorgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeduleetfeehffekueeuffektefgudfgffeutdefudfghedvieffheehleeuieehteenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudejjedrvdeffedrfeeinecurfgrrhgrmhephhgvlhhopehrsghtrgdqmhhskhdqlhhtqdeftddvieeltddrrghsthhrrghlihhnuhigrdhruhdpihhnvghtpedutddrudejjedrvdeffedrfeeimeegvdeiudegpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplfgrmhgvshdruehothhtohhmlhgvhiesjfgrnhhsvghnrfgrrhhtnhgvrhhshhhiphdrtghomhdprhgtphhtthhopegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruhdprhgtphhtthhopehmrghrthhinhdrphgvthgvrhhsvghnsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhstghsihesvhhgvghrrd
 hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrgh
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12454253, Updated: 2024-Feb-21 10:21:39 UTC]

SCp is 3rd argument of process_script_interrupt()
(calls in drivers/scsi/53c700.c:1346 where SCp != NULL and
drivers/scsi/53c700.c:1672 where this condition is not guaranteed).
Before call process_script_interrupt() in drivers/scsi/53c700.c:1672
there is SCp = hostdata->cmd, wherein (type casts omitted)
hostdata = host->hostdata[0], host = dev_id,
dev_id - 2nd argument of NCR_700_intr().
NCR_700_intr() is used when calling request_irq() -> request_threaded_irq()
as the 2nd argument.
Last argument of call request_irq(..., NCR_700_intr, ... host) is host.
host = NCR_700_detect(), host->hostdata[0] = hostdata, hostdata->cmd = NULL.
So, there is possible NULL pointer dereference,
so add NULL check for SCp in process_script_interrupt() to avoid it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 drivers/scsi/53c700.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 857be0f3ae5b..54bcc5727fbb 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -1067,7 +1067,7 @@ process_script_interrupt(__u32 dsps, __u32 dsp, struct scsi_cmnd *SCp,
 			//}
 			NCR_700_scsi_done(hostdata, SCp, hostdata->status[0]);
 		}
-	} else if((dsps & 0xfffff0f0) == A_UNEXPECTED_PHASE) {
+	} else if ((dsps & 0xfffff0f0) == A_UNEXPECTED_PHASE && SCp) {
 		__u8 i = (dsps & 0xf00) >> 8;
 
 		scmd_printk(KERN_ERR, SCp, "UNEXPECTED PHASE %s (%s)\n",
-- 
2.30.2


