Return-Path: <linux-kernel+bounces-93106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783DB872B1B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED61EB23922
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DAA12E1CF;
	Tue,  5 Mar 2024 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rcHm0lOD"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0699812D753
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 23:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681684; cv=none; b=ZjL1XAHE7R/rx4h6nFBR1TR6dk+MFM0O8SMECp0Xe5rNxcuSoV5mb6Ueww4ikAKLeCYuR+eYyZpmItBE8a5vKzUXVVbLqj773qmqmGzbxzhO8gvP/8o46E9ZXbwMyNofRo2UJpP48qWLPBeRznRB+pgSndS+Bp1J/vKVMNCiP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681684; c=relaxed/simple;
	bh=MCTI5WU0q/OjSWo0DYnEwQ71Bx+4NnviT+l0Jn0Vwtw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D8NH/ZOo2F7QYIxjdxWguY7U21dt4aLXAh/Ec8xAV308XekJm3brM08pot81HuLa0JuSquOVIMBWzck7VkV6qGfK/IZ/ZWZ55qTj+y/g7e53K9NS6VIpNzMgqruQpsa5kJOePg5Fl1M/V+98iWq/86W0lYyn/7ObcQNQ7xecSnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rcHm0lOD; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so8250300276.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 15:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709681682; x=1710286482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xf2dq5GdDyi4s4WmIv33iVv6HbbqbNsFgxWnhqrXlo=;
        b=rcHm0lODl3Xe6qAaVQRO42Ws3xVfyYPFO7PNs0ASoo33BZFJHstOSnUWpe1FplxvMh
         dmFQ4KNP06yw1bJ/PEKcsYJP3HBNDtiYxuXoU2xnYeUmRvhWm0agTlRbVtdnj7I99BXY
         ngZhNTGFqzDu4v/gV2ehRjCUhhx5cDUba9XIbk6k9JkS1Rjo2wWaTkvH6M52OozTOvIj
         n7d8GC86lxPHyb/EOC+v6mwMyfQp8NjNOKdgZeWlK0QfT54D6ZTlUkWCStN/RPUtQ41r
         AQkb9eYUhkEnH/8U5kROraM/EAlVf6M4IMi0BGyIxk+lWVHQAuHug8gTwHsHhosNMi6Q
         df6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709681682; x=1710286482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xf2dq5GdDyi4s4WmIv33iVv6HbbqbNsFgxWnhqrXlo=;
        b=sO65BxuGuMm2FCbSzvHzKk71GsTevx1t/BTG1p4v7EvAYwm+9kyF7tKdnF97UuVqSC
         sTopGKambnGAosbheywiGQOtvACq48PrM6r7JNcwuW347H3LZOEow3vu2ZnWP0CbIOjq
         ylCPaSZLWypOCNFVPDJ+/Fx8RL32Kq7UvxTfehNGfWuDJFF32aWMk5NUXQKN5MlkBUOZ
         eqmtEwfUApkYEVN+Pg9hJ+LD8WyfDyhcPyVm1xM2q87mxV+zo2MKOjLLSBr8a3IsZWFP
         CYnCYJiX8iSiWyS3/2DG3O3LbdyLQmh+MDaNkAJ/giwf1CMux9/z9/9A/BnAC67jhS+M
         tXTw==
X-Forwarded-Encrypted: i=1; AJvYcCWVv6+sA829QB4yCe2/MRnHKZK3pppvFChd2kAeWSMu+81WvPJ/9tyNS+RlCnly2bkpDYJCxTe7m1/GxigWTIbD+iM+SWZkpBJrTnhv
X-Gm-Message-State: AOJu0YxyWhKWrsN94Sc6Jj0ZbqCLrmJUmQnpR/67144mQkimYtNJh0rx
	9e9oS7M4UZfLIOUe1S1JRbUdJQvZ1WvHJLf8tZuIsqPJpAhONAosxTJjE7VKnuslNy0fyYykNSm
	2cRNz1rUYohnuxkfS9IVXtg==
X-Google-Smtp-Source: AGHT+IGjXP7xV9ruZsbeD4aaELcTYAXgic0nA0Hrjs4+Y+HNFaz12SX4X0SEt6kHvtfxKoyr/JXIYEI4l6ExCkDDYA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:2fc1:0:b0:dc6:ebd4:cca2 with SMTP
 id v184-20020a252fc1000000b00dc6ebd4cca2mr457031ybv.11.1709681682039; Tue, 05
 Mar 2024 15:34:42 -0800 (PST)
Date: Tue, 05 Mar 2024 23:34:36 +0000
In-Reply-To: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709681680; l=2052;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=MCTI5WU0q/OjSWo0DYnEwQ71Bx+4NnviT+l0Jn0Vwtw=; b=rnmRj8jm3GgjTZnumlpPOaOkMDVx4IdzWrhmcsZBaHHv305Z07EM4eMErQjpOQbvDLsSNgotZ
 fSo9MlyGZrDCLxYGXzFNWqNQYlSPCU1xKVTxKIi/dth8EzpyrB/5tvE
X-Mailer: b4 0.12.3
Message-ID: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-1-5b78a13ff984@google.com>
Subject: [PATCH v3 1/7] scsi: mpi3mr: replace deprecated strncpy with assignments
From: Justin Stitt <justinstitt@google.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, Ariel Elior <aelior@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Don Brace <don.brace@microchip.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, MPT-FusionLinux.pdl@broadcom.com, 
	netdev@vger.kernel.org, storagedev@microchip.com, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Really, there's no bug with the current code. Let's just ditch strncpy()
all together.

We can just copy the const strings instead of reserving room on the
stack.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
changes from v1->v2:
* use const char* assignments rather than strscpy (thanks Finn+Kees)
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 528f19f782f2..da0710cdac1d 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -3676,7 +3676,7 @@ static const struct {
  * mpi3mr_print_ioc_info - Display controller information
  * @mrioc: Adapter instance reference
  *
- * Display controller personalit, capability, supported
+ * Display controller personality, capability, supported
  * protocols etc.
  *
  * Return: Nothing
@@ -3685,20 +3685,20 @@ static void
 mpi3mr_print_ioc_info(struct mpi3mr_ioc *mrioc)
 {
 	int i = 0, bytes_written = 0;
-	char personality[16];
+	const char *personality;
 	char protocol[50] = {0};
 	char capabilities[100] = {0};
 	struct mpi3mr_compimg_ver *fwver = &mrioc->facts.fw_ver;
 
 	switch (mrioc->facts.personality) {
 	case MPI3_IOCFACTS_FLAGS_PERSONALITY_EHBA:
-		strncpy(personality, "Enhanced HBA", sizeof(personality));
+		personality = "Enhanced HBA";
 		break;
 	case MPI3_IOCFACTS_FLAGS_PERSONALITY_RAID_DDR:
-		strncpy(personality, "RAID", sizeof(personality));
+		personality = "RAID";
 		break;
 	default:
-		strncpy(personality, "Unknown", sizeof(personality));
+		personality = "Unknown";
 		break;
 	}
 

-- 
2.44.0.278.ge034bb2e1d-goog


