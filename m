Return-Path: <linux-kernel+bounces-57654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEE484DBD4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA181C24EBE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9633374E1E;
	Thu,  8 Feb 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flkB5vKC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF3973197;
	Thu,  8 Feb 2024 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381935; cv=none; b=P5SIe56mslZgqf4RR5nwrJDU9Yk1J9q87rR60UE8q21T7MMvb5y4xU+TCseACIZnx+QIc8OcQYwFfoX+TNeDCljTXMMX4PZ4i26Ca1lP0E/+kisWZRrORX02sqxThLQsfUURFOl3zvRDO+cfvuPhSG1zKF7N1BGVRnG7VUHQZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381935; c=relaxed/simple;
	bh=QcWkvLbuXqKsmCSILThA1RfLwMeDripObvnvLFWiq34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDe2rypoyWtpnB06izoJQSLDq47rc6o3uHT2waOB85hlw/BcTJUUZnfYbeUp3EsQTDq0EUcNO5rxyjbhb5E1slsTIchW3Sazk6TiYqp9A765vXVJLh0DLs7RkcMVnVY7uDeFdKCMumFBfiXUhV5RtL7qjQX2wiJkpj5Ilpu9JNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flkB5vKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A257C433C7;
	Thu,  8 Feb 2024 08:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707381935;
	bh=QcWkvLbuXqKsmCSILThA1RfLwMeDripObvnvLFWiq34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=flkB5vKCBQYz/TpY0INSUaOZjllm7VrkDUbKFVgCIc3ASXj/qazrW94Yryh3JnsNX
	 NJlgNNRcRUnXProGsUi8C60pgUya/Fr+EbvRfWtqbhO2YHZE25gcmPGLdWv0WujarZ
	 cWbsO1A+1oAk30b0gsn/JJRxxxx7v+Ya+QMQQeTauB49jBXRvaud7rZaPGDH6v1Sm9
	 BshS6lbql3Lky3xkzhJ3qkII+o16i592ZP1lJ90hMoELZdsv6nOxN6LrniXK5qTPYr
	 QEA8Dul1ponHXK0/KmqqAqeurIbVE98UbjMLuIfEWXQG0CQZgxl22y8j+OgKOr8sY/
	 u8EUQhEi+CBGg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 08/10] scsi: aic7xxx: aicasm: Replace snprintf() with the safer scnprintf() variant
Date: Thu,  8 Feb 2024 08:44:20 +0000
Message-ID: <20240208084512.3803250-9-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240208084512.3803250-1-lee@kernel.org>
References: <20240208084512.3803250-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a general misunderstanding amongst engineers that {v}snprintf()
returns the length of the data *actually* encoded into the destination
array.  However, as per the C99 standard {v}snprintf() really returns
the length of the data that *would have been* written if there were
enough space for it.  This misunderstanding has led to buffer-overruns
in the past.  It's generally considered safer to use the {v}scnprintf()
variants in their place (or even sprintf() in simple cases).  So let's
do that.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: Hannes Reinecke <hare@suse.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/aic7xxx/aicasm/aicasm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm.c b/drivers/scsi/aic7xxx/aicasm/aicasm.c
index 8d995186e557a..bc758e78d3c06 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm.c
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm.c
@@ -331,7 +331,7 @@ back_patch()
 			if (cur_instr->patch_label->type != LABEL) {
 				char buf[255];
 
-				snprintf(buf, sizeof(buf),
+				scnprintf(buf, sizeof(buf),
 					 "Undefined label %s",
 					 cur_instr->patch_label->name);
 				stop(buf, EX_DATAERR);
-- 
2.43.0.594.gd9cf4e227d-goog


