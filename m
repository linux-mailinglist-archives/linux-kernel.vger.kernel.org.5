Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFA47600C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 22:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGXU5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 16:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjGXU5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:57:30 -0400
X-Greylist: delayed 812 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Jul 2023 13:57:27 PDT
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C0610FD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:57:27 -0700 (PDT)
X-ASG-Debug-ID: 1690231433-1cf4391f2718a3f0001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id ckntnvKwGMAvM1j7; Mon, 24 Jul 2023 16:43:53 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=vEkIZa3trZFApyXz99Xah7C6lrxYHNxCiLNzQIDhMWs=;
        h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:Content-Language:
        MIME-Version:Date:Message-ID; b=TJgzCvxUcbSYTrmpYpWVwQOrCp+CPrbFkLQnnYppKgqSd
        m/DrIaLt5YEWsGABC6MjJ4p453KT3JLJu7OUMfQoMjkiPzswNpPHy/vKKjAm83lkCj6TprFA9kGie
        eemaYwGCuE/S2zS/g9DU5vBXvVbZuffEI135bHcV3zJaVt1X0=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 12730561; Mon, 24 Jul 2023 16:43:53 -0400
Message-ID: <b570f5fe-cb7c-863a-6ed9-f6774c219b88@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date:   Mon, 24 Jul 2023 16:43:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Willy Tarreau <w@1wt.eu>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Tony Battersby <tonyb@cybernetics.com>
Subject: [PATCH RFC] scsi {add,remove}-single-device and /proc/scsi/scsi
Content-Type: text/plain; charset=UTF-8
X-ASG-Orig-Subj: [PATCH RFC] scsi {add,remove}-single-device and /proc/scsi/scsi
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1690231433
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 0
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 4248
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to fix a bug in the parser for these commands:

echo "scsi add-single-device host channel id lun" > /proc/scsi/scsi
echo "scsi remove-single-device host channel id lun" > /proc/scsi/scsi

With the current parser, if you omit some of the fields (for example the
lun), then the kernel will usually fill in the missing parameters with a
0, but on rare occasion it might supply something else.  So my question
for linux-scsi is: does anyone rely on omitting some of the parameters
in the cmds above and expect the kernel to supply 0 for the missing
parameters (for example lun is often 0)?  If so, then I can make the
parser always supply a 0 for the missing parameters.  If not, then I can
make the parser return an error if there are paramters missing, on the
theory that guessing which device to add or remove is a bad idea.

Below is the patch to return an error for a missing parameter.  The
patch to use 0 instead of returning an error is similar but intead of
goto uses:

host    = (p < end) ? simple_strtoul(p, &p, 0) : 0;
channel = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
id      = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;
lun     = (p + 1 < end) ? simple_strtoul(p + 1, &p, 0) : 0;

---

From 4f8f3291b18fddb2cf75581a2a2cf847fd2896a7 Mon Sep 17 00:00:00 2001
From: Tony Battersby <tonyb@cybernetics.com>
Date: Fri, 21 Jul 2023 11:12:27 -0400
Subject: [PATCH] scsi: core: fix parsing of scsi {add,remove}-single-device

When parsing the "scsi add-single-device" and
"scsi remove-single-device" commands written to /proc/scsi/scsi, make
sure the parser doesn't skip over the NUL string terminator and read
past the end of the user-supplied string.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 drivers/scsi/scsi_proc.c | 48 +++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index 4a6eb1741be0..b27c8da83e62 100644
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
@@ -432,11 +436,22 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 	 */
 	if (!strncmp("scsi add-single-device", buffer, 22)) {
 		p = buffer + 23;
+		if (p >= end)
+			goto out;
 
 		host = simple_strtoul(p, &p, 0);
-		channel = simple_strtoul(p + 1, &p, 0);
-		id = simple_strtoul(p + 1, &p, 0);
-		lun = simple_strtoul(p + 1, &p, 0);
+		if (++p >= end)
+			goto out;
+
+		channel = simple_strtoul(p, &p, 0);
+		if (++p >= end)
+			goto out;
+
+		id = simple_strtoul(p, &p, 0);
+		if (++p >= end)
+			goto out;
+
+		lun = simple_strtoul(p, &p, 0);
 
 		err = scsi_add_single_device(host, channel, id, lun);
 
@@ -446,11 +461,22 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 	 */
 	} else if (!strncmp("scsi remove-single-device", buffer, 25)) {
 		p = buffer + 26;
+		if (p >= end)
+			goto out;
 
 		host = simple_strtoul(p, &p, 0);
-		channel = simple_strtoul(p + 1, &p, 0);
-		id = simple_strtoul(p + 1, &p, 0);
-		lun = simple_strtoul(p + 1, &p, 0);
+		if (++p >= end)
+			goto out;
+
+		channel = simple_strtoul(p, &p, 0);
+		if (++p >= end)
+			goto out;
+
+		id = simple_strtoul(p, &p, 0);
+		if (++p >= end)
+			goto out;
+
+		lun = simple_strtoul(p, &p, 0);
 
 		err = scsi_remove_single_device(host, channel, id, lun);
 	}
-- 
2.25.1

