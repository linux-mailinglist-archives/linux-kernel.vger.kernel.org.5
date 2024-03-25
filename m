Return-Path: <linux-kernel+bounces-116995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A0188A5EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727AC1F62CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DADE13119E;
	Mon, 25 Mar 2024 12:25:28 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4345686629;
	Mon, 25 Mar 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369527; cv=none; b=rNPu89y/Rtegi4gQCNI9iDUzV/E0gm1xHPPyhNiOIKKtO90hcvW3yWx/6+eFjdFRnee4o3AuIRncLhAkkueAz5HHK1RH4f3ZvlRM7eFXxabbMEznGnz03iI9tantcP7cNEc7ZJzNfKCtNnqXLWTd4gouqQXzvdl3/FU1r+4aoDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369527; c=relaxed/simple;
	bh=DIV35aPPM2JtoPQYCmeHAZJnh/zGHOjH9qYHQpBaVLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EtkPpehpjkLEM0vhcD2ZxaQ/GFe6Xmxv7r0/LRwrnr83HD6llIGjt8uTQWSBMjzqoQ7BaGIXo7iu4/qCx7pogvStb7rVDDsTvRicCg0Q53PLaciJF8fUSNrP1ZBbBGgVZml2JmE7LtrwvYzE06gOFWjzG/xUp/HP47oVMCPYd6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.236.245])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4V3Bw956nrzySJ;
	Mon, 25 Mar 2024 15:25:13 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] scsi: 53c700: call NCR_700_internal_bus_reset() unconditionally
Date: Mon, 25 Mar 2024 15:24:18 +0300
Message-Id: <20240325122418.27693-1-adiupina@astralinux.ru>
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
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgrucffihhuphhinhgruceorgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeduleetfeehffekueeuffektefgudfgffeutdefudfghedvieffheehleeuieehteenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudejjedrvdefiedrvdegheenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdqfedtvdeiledtrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepuddtrddujeejrddvfeeirddvgeehmeeghedtudegpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplfgrmhgvshdruehothhtohhmlhgvhiesjfgrnhhsvghnrfgrrhhtnhgvrhhshhhiphdrtghomhdprhgtphhtthhopegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruhdprhgtphhtthhopehmrghrthhinhdrphgvthgvrhhsvghnsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhstghsihesvhhgvg
 hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrgh
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12535435, Updated: 2024-Mar-25 10:47:37 UTC]

It is necessary to include the SCp check inside the branch
and call NCR_700_internal_bus_reset() unconditionally.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 87fd912d3ba3 ("Add NULL check for SCp in process_script_interrupt()")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
The patch makes a change to commit 87fd912d3ba3, which I 
created earlier. It became clear that it is necessary to 
call NCR_700_internal_bus_reset() in this condition branch 
for any value of SCp. Sorry for the incorrect previous patch.
 drivers/scsi/53c700.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index e4fe7fc8dfcb..1a422264160d 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -1067,15 +1067,17 @@ process_script_interrupt(__u32 dsps, __u32 dsp, struct scsi_cmnd *SCp,
 			//}
 			NCR_700_scsi_done(hostdata, SCp, hostdata->status[0]);
 		}
-	} else if ((dsps & 0xfffff0f0) == A_UNEXPECTED_PHASE && SCp) {
-		__u8 i = (dsps & 0xf00) >> 8;
-
-		scmd_printk(KERN_ERR, SCp, "UNEXPECTED PHASE %s (%s)\n",
-		       NCR_700_phase[i],
-		       sbcl_to_string(NCR_700_readb(host, SBCL_REG)));
-		scmd_printk(KERN_ERR, SCp, "         len = %d, cmd =",
-			SCp->cmd_len);
-		scsi_print_command(SCp);
+	} else if ((dsps & 0xfffff0f0) == A_UNEXPECTED_PHASE) {
+		if (SCp) {
+			__u8 i = (dsps & 0xf00) >> 8;
+
+			scmd_printk(KERN_ERR, SCp, "UNEXPECTED PHASE %s (%s)\n",
+				NCR_700_phase[i],
+				sbcl_to_string(NCR_700_readb(host, SBCL_REG)));
+			scmd_printk(KERN_ERR, SCp, "         len = %d, cmd =",
+				SCp->cmd_len);
+			scsi_print_command(SCp);
+		}
 
 		NCR_700_internal_bus_reset(host);
 	} else if((dsps & 0xfffff000) == A_FATAL) {
-- 
2.30.2


