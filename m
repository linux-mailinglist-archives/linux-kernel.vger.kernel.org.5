Return-Path: <linux-kernel+bounces-160668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F868B40CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A78282D49
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507C323746;
	Fri, 26 Apr 2024 20:27:15 +0000 (UTC)
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6DD23754
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.114.0.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714163234; cv=none; b=nFC+p6wlKzAPYaDjyndUDUlSMBD6W4+NfNW/XLr1JfmWC0SFCVQErOTF0NebBE6vBeBHw8VudRKWoY6/ugmHhzvHeuTotZwxOQtjujss+0abGcjYVwn8+OHGTB8h6cR1qvrjaMVkLkYpJG85kQzKnL/0Z0LxvLrFQeuOooEa2lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714163234; c=relaxed/simple;
	bh=iEaBb4DHV5Ue0Lgl6VtgqjCO2H+50/f3AngYJFH/s/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iCvlekPm9uLneQ2qdHo3oSmtiw69aL3+ia8IYEmC1EdE//Vt0DU3UObsFmo4ntDrIVsnzy1lf7ZyQPx/O1S3U06Wpb89fodjGk/5CElS5R74US1muEa/wKiulMuu2e1OYuSWpAVSK5ZvkMt0zKqPpTco5lwpp1DaASxNRVg8djo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=202.114.0.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrACXmindDSxmcuN2BQ--.4299S2;
	Sat, 27 Apr 2024 04:26:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.12.177.116])
	by gateway (Coremail) with SMTP id _____wCXfy3cDSxmj3M5AQ--.35680S2;
	Sat, 27 Apr 2024 04:26:05 +0800 (CST)
From: Haoyang Liu <tttturtleruss@hust.edu.cn>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: hust-os-kernel-patches@googlegroups.com,
	Haoyang Liu <tttturtleruss@hust.edu.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware_loader: Replace simple_strtol() with kstrtoint()
Date: Sat, 27 Apr 2024 04:25:32 +0800
Message-Id: <20240426202532.27848-1-tttturtleruss@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrACXmindDSxmcuN2BQ--.4299S2
Authentication-Results: app1; spf=neutral smtp.mail=tttturtleruss@hust
	.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyrAFy5uF1DKw4kWry8Zrb_yoW8XryUpF
	17Kay5CF18G3WrGr47AF4Dua43Wr1xJFy5G3sxGwsavr17Arn7u34UKFya9F1rGFWkKry3
	Gr1DGFn5CFWUW3DanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmIb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
	z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kKe7AKxV
	WUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02
	F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Gr1j6F4UJwAv7VCjz48v1s
	IEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04
	k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
	wI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxUVkucDUUUU
X-CM-SenderInfo: rxsqjiqrssiko6kx23oohg3hdfq/1tbiAQkTAmYrskAIbgACsC

simple_strtol() is obsolete, use kstrtoint() instead.

Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/base/firmware_loader/sysfs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/sysfs.c b/drivers/base/firmware_loader/sysfs.c
index c9c93b47d9a5..4de1cb243bee 100644
--- a/drivers/base/firmware_loader/sysfs.c
+++ b/drivers/base/firmware_loader/sysfs.c
@@ -47,8 +47,12 @@ static ssize_t timeout_show(const struct class *class, const struct class_attrib
 static ssize_t timeout_store(const struct class *class, const struct class_attribute *attr,
 			     const char *buf, size_t count)
 {
-	int tmp_loading_timeout = simple_strtol(buf, NULL, 10);
+	int tmp_loading_timeout;
+	int res;
 
+	res = kstrtoint(buf, 10, &tmp_loading_timeout);
+	if (res < 0)
+		return res;
 	if (tmp_loading_timeout < 0)
 		tmp_loading_timeout = 0;
 
@@ -157,8 +161,12 @@ static ssize_t firmware_loading_store(struct device *dev,
 	struct fw_sysfs *fw_sysfs = to_fw_sysfs(dev);
 	struct fw_priv *fw_priv;
 	ssize_t written = count;
-	int loading = simple_strtol(buf, NULL, 10);
+	int loading;
+	int res;
 
+	res = kstrtoint(buf, 10, &loading);
+	if (res < 0)
+		return res;
 	mutex_lock(&fw_lock);
 	fw_priv = fw_sysfs->fw_priv;
 	if (fw_state_is_aborted(fw_priv) || fw_state_is_done(fw_priv))
-- 
2.25.1


