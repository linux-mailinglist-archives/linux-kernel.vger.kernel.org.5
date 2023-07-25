Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC40776218A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjGYShh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGYShf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:37:35 -0400
X-Greylist: delayed 614 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Jul 2023 11:37:34 PDT
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2695DE7E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:37:33 -0700 (PDT)
X-ASG-Debug-ID: 1690309638-1cf4391f27191450001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id AgqoKPh6mtqctUOz; Tue, 25 Jul 2023 14:27:18 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=sqgCX8jCizbiss5Ej3xSHSZPy6tYWsQXvnSrbIT7X1Y=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=bO01tCHXQGGiGrxrvNAh
        3EO4zOLDWGYl8YBummCO+KlHJVSp4Vl0pyZIyWp3FeTPFCzSN2k8eJCc1iY8ftsuljBCGXAAeDx1d
        qbr0EQvGHgzngU7fYwAAAG46jEEgN4ZsfXya+jXrx467mLwfmhhwLQtTZaZehtSQ7eNqNaz8Co=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 12732468; Tue, 25 Jul 2023 14:27:18 -0400
Message-ID: <9adfd67b-4327-9233-8e87-3fd5f3f7280b@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date:   Tue, 25 Jul 2023 14:27:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: SCSI: fix parsing of /proc/scsci/scsi file
Content-Language: en-US
X-ASG-Orig-Subj: Re: SCSI: fix parsing of /proc/scsci/scsi file
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Martin K Petersen <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.ibm.com>, Willy Tarreau <w@1wt.eu>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiu-dX+CGUnhsk3KfPbP1h-1kCmVoTV6FEETQmafGWdLQ@mail.gmail.com>
From:   Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <CAHk-=wiu-dX+CGUnhsk3KfPbP1h-1kCmVoTV6FEETQmafGWdLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1690309638
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 4589
X-Barracuda-BRTS-Status: 0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 13:30, Linus Torvalds wrote:
> This is the simplified version of the fix proposed by Tony Battersby
> for the horrid scsi /proc parsing code.
>
Something that I just thought of: the old parser could also skip over
NUL characters used as separators within the buffer that aren't at the
end of the buffer, as in: "host\0id\0channel\0lun".  If you want to
continue to allow that unlikely usage, then my patch comparing p to the
end pointer would work better.

From 61dc8daf4b6aa149882e425d58f68d50182222be Mon Sep 17 00:00:00 2001
From: Tony Battersby <tonyb@cybernetics.com>
Date: Mon, 24 Jul 2023 14:25:40 -0400
Subject: [PATCH] scsi: fix legacy /proc parsing buffer overflow

(lightly modified commit message mostly by Linus Torvalds)

The parsing code for /proc/scsi/scsi is disgusting and broken.  We
should have just used 'sscanf()' or something simple like that, but the
logic may actually predate our kernel sscanf library routine for all I
know.  It certainly predates both git and BK histories.

And we can't change it to be something sane like that now, because the
string matching at the start is done case-insensitively, and the
separator parsing between numbers isn't done at all, so *any* separator
will work, including a possible terminating NUL character.

This interface is root-only, and entirely for legacy use, so there is
absolutely no point in trying to tighten up the parsing.  Because any
separator has traditionally worked, it's entirely possible that people
have used random characters rather than the suggested space.

So don't bother to try to pretty it up, and let's just make a minimal
patch that can be back-ported and we can forget about this whole sorry
thing for another two decades.

Just make it at least not read past the end of the supplied data.

Link: https://lore.kernel.org/linux-scsi/b570f5fe-cb7c-863a-6ed9-f6774c219b88@cybernetics.com/
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin K Petersen <martin.petersen@oracle.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: stable@kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 drivers/scsi/scsi_proc.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index 4a6eb1741be0..41f23cd0bfb4 100644
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -406,7 +406,7 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 			       size_t length, loff_t *ppos)
 {
 	int host, channel, id, lun;
-	char *buffer, *p;
+	char *buffer, *end, *p;
 	int err;
 
 	if (!buf || length > PAGE_SIZE)
@@ -421,10 +421,14 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 		goto out;
 
 	err = -EINVAL;
-	if (length < PAGE_SIZE)
-		buffer[length] = '\0';
-	else if (buffer[PAGE_SIZE-1])
-		goto out;
+	if (length < PAGE_SIZE) {
+		end = buffer + length;
+		*end = '\0';
+	} else {
+		end = buffer + PAGE_SIZE - 1;
+		if (*end)
+			goto out;
+	}
 
 	/*
 	 * Usage: echo "scsi add-single-device 0 1 2 3" >/proc/scsi/scsi
@@ -433,10 +437,10 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 	if (!strncmp("scsi add-single-device", buffer, 22)) {
 		p = buffer + 23;
 
-		host = simple_strtoul(p, &p, 0);
-		channel = simple_strtoul(p + 1, &p, 0);
-		id = simple_strtoul(p + 1, &p, 0);
-		lun = simple_strtoul(p + 1, &p, 0);
+		host    = (p     < end) ? simple_strtoul(p, &p, 0) : 0;
+		channel = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		id      = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		lun     = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
 
 		err = scsi_add_single_device(host, channel, id, lun);
 
@@ -447,10 +451,10 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 	} else if (!strncmp("scsi remove-single-device", buffer, 25)) {
 		p = buffer + 26;
 
-		host = simple_strtoul(p, &p, 0);
-		channel = simple_strtoul(p + 1, &p, 0);
-		id = simple_strtoul(p + 1, &p, 0);
-		lun = simple_strtoul(p + 1, &p, 0);
+		host    = (p     < end) ? simple_strtoul(p, &p, 0) : 0;
+		channel = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		id      = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
+		lun     = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
 
 		err = scsi_remove_single_device(host, channel, id, lun);
 	}
-- 
2.25.1

