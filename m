Return-Path: <linux-kernel+bounces-51766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AD6848F10
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC12528328B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4CD22615;
	Sun,  4 Feb 2024 15:58:31 +0000 (UTC)
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4655B225DA
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062310; cv=none; b=VJtVr/74a0wJLgE+KwKLQiGkfL+DkFJS2kxcOmtzF27KvgQtDGYF2Iz3E4ck54/0iBtUjuEygerhy+EoCe8KO+Uk5lofw1AGzVsG0XqlQtrx3DtwahwQx6KSPHRvrD1f5Uf5JFTmL4R0VzarNMAX+Nzx+jkQ6RnpFhX+VZnjaIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062310; c=relaxed/simple;
	bh=ALsEQC4oH3o3JFLcLHmjtQLZFxFagvtdIAtWyTHCwsU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h6X1AegyfHXp8/VmNaG97jITIpZ7drq50aESay0GaItwTu2yTa3ZGkVJ6syv5MTssd0NdRsxrYg8zBnr555ysFVcM9UVJVxy2GOc/rK0fzeEUe4jdBwxkK8/ZNHHeh91l0PITuLMbmLoG/NT1YSlmBmXkl6PpVnHXFkN2cxyyik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 4939EA02C1;
	Sun,  4 Feb 2024 16:58:26 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18gu54NFlpsa; Sun,  4 Feb 2024 16:58:26 +0100 (CET)
Received: from begin (aamiens-653-1-111-57.w83-192.abo.wanadoo.fr [83.192.234.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 2901FA02C0;
	Sun,  4 Feb 2024 16:58:26 +0100 (CET)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1rWesz-0000000ERmW-3Sj8;
	Sun, 04 Feb 2024 16:58:25 +0100
Date: Sun, 4 Feb 2024 16:58:25 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH] speakup: Add /dev/synthu device
Message-ID: <20240204155825.ditstifsbqndnce3@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	speakup@linux-speakup.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)

/dev/synth has always been 8bit, but applications nowadays mostly
expect to be using utf-8 encoding.  This adds /dev/synthu to be able
to synthesize non-latin1 characters.  This however remains limited
to 16bit unicode like the rest of speakup.  Any odd input or input
beyond 16bit is just discarded.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: linux-6.4/drivers/accessibility/speakup/devsynth.c
===================================================================
--- linux-6.4.orig/drivers/accessibility/speakup/devsynth.c
+++ linux-6.4/drivers/accessibility/speakup/devsynth.c
@@ -7,9 +7,10 @@
 #include "speakup.h"
 #include "spk_priv.h"
 
-static int misc_registered;
+static int synth_registered, synthu_registered;
 static int dev_opened;
 
+/* Latin1 version */
 static ssize_t speakup_file_write(struct file *fp, const char __user *buffer,
 				  size_t nbytes, loff_t *ppos)
 {
@@ -34,6 +35,97 @@ static ssize_t speakup_file_write(struct
 	return (ssize_t)nbytes;
 }
 
+/* UTF-8 version */
+static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
+				   size_t nbytes, loff_t *ppos)
+{
+	size_t count = nbytes, want;
+	const char __user *ptr = buffer;
+	size_t bytes;
+	unsigned long flags;
+	unsigned char buf[256];
+	u16 ubuf[256];
+	size_t in, in2, out;
+
+	if (!synth)
+		return -ENODEV;
+
+	want = 1;
+	while (count >= want) {
+		/* Copy some UTF-8 piece from userland */
+		bytes = min(count, sizeof(buf));
+		if (copy_from_user(buf, ptr, bytes))
+			return -EFAULT;
+
+		/* Convert to u16 */
+		for (in = 0, out = 0; in < bytes; in++) {
+			unsigned char c = buf[in];
+			int nbytes = 8 - fls(c ^ 0xff);
+			u32 value;
+
+			switch (nbytes) {
+			case 8: /* 0xff */
+			case 7: /* 0xfe */
+			case 1: /* 0x80 */
+				/* Invalid, drop */
+				goto drop;
+
+			case 0:
+				/* ASCII, copy */
+				ubuf[out++] = c;
+				continue;
+
+			default:
+				/* 2..6-byte UTF-8 */
+
+				if (bytes - in < nbytes) {
+					/* We don't have it all yet, stop here
+					 * and wait for the rest
+					 */
+					bytes = in;
+					want = nbytes;
+					continue;
+				}
+
+				/* First byte */
+				value = c & ((1u << (7 - nbytes)) - 1);
+
+				/* Other bytes */
+				for (in2 = 2; in2 <= nbytes; in2++) {
+					c = buf[in + 1];
+					if ((c & 0xc0) != 0x80)	{
+						/* Invalid, drop the head */
+						want = 1;
+						goto drop;
+					}
+					value = (value << 6) | (c & 0x3f);
+					in++;
+				}
+
+				if (value < 0x10000)
+					ubuf[out++] = value;
+				want = 1;
+				break;
+			}
+drop:
+		}
+
+		count -= bytes;
+		ptr += bytes;
+
+		/* And speak this up */
+		if (out) {
+			spin_lock_irqsave(&speakup_info.spinlock, flags);
+			for (in = 0; in < out; in++)
+				synth_buffer_add(ubuf[in]);
+			synth_start();
+			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+		}
+	}
+
+	return (ssize_t)(nbytes - count);
+}
+
 static ssize_t speakup_file_read(struct file *fp, char __user *buf,
 				 size_t nbytes, loff_t *ppos)
 {
@@ -62,31 +154,57 @@ static const struct file_operations synt
 	.release = speakup_file_release,
 };
 
+static const struct file_operations synthu_fops = {
+	.read = speakup_file_read,
+	.write = speakup_file_writeu,
+	.open = speakup_file_open,
+	.release = speakup_file_release,
+};
+
 static struct miscdevice synth_device = {
 	.minor = MISC_DYNAMIC_MINOR,
 	.name = "synth",
 	.fops = &synth_fops,
 };
 
+static struct miscdevice synthu_device = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "synthu",
+	.fops = &synthu_fops,
+};
+
 void speakup_register_devsynth(void)
 {
-	if (misc_registered != 0)
-		return;
-/* zero it so if register fails, deregister will not ref invalid ptrs */
-	if (misc_register(&synth_device)) {
-		pr_warn("Couldn't initialize miscdevice /dev/synth.\n");
-	} else {
-		pr_info("initialized device: /dev/synth, node (MAJOR %d, MINOR %d)\n",
-			MISC_MAJOR, synth_device.minor);
-		misc_registered = 1;
+	if (!synth_registered) {
+		if (misc_register(&synth_device)) {
+			pr_warn("Couldn't initialize miscdevice /dev/synth.\n");
+		} else {
+			pr_info("initialized device: /dev/synth, node (MAJOR %d, MINOR %d)\n",
+				MISC_MAJOR, synth_device.minor);
+			synth_registered = 1;
+		}
+	}
+	if (!synthu_registered) {
+		if (misc_register(&synthu_device)) {
+			pr_warn("Couldn't initialize miscdevice /dev/synthu.\n");
+		} else {
+			pr_info("initialized device: /dev/synthu, node (MAJOR %d, MINOR %d)\n",
+				MISC_MAJOR, synthu_device.minor);
+			synthu_registered = 1;
+		}
 	}
 }
 
 void speakup_unregister_devsynth(void)
 {
-	if (!misc_registered)
-		return;
-	pr_info("speakup: unregistering synth device /dev/synth\n");
-	misc_deregister(&synth_device);
-	misc_registered = 0;
+	if (synth_registered) {
+		pr_info("speakup: unregistering synth device /dev/synth\n");
+		misc_deregister(&synth_device);
+		synth_registered = 0;
+	}
+	if (synthu_registered) {
+		pr_info("speakup: unregistering synth device /dev/synthu\n");
+		misc_deregister(&synthu_device);
+		synthu_registered = 0;
+	}
 }

