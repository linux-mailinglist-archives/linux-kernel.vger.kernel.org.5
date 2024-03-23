Return-Path: <linux-kernel+bounces-112277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBA78877C9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C931C20DDD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F32AF9FE;
	Sat, 23 Mar 2024 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YGijb2pN"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BDC611A;
	Sat, 23 Mar 2024 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711186138; cv=none; b=VvDiBxiWHu0e39Z1PvL+n0t3HuCgZI5wQfLCNuuoObTFwx39eaXlXbA1Oc7RrY6eZzHGOsKaLz4iqqaKXU5eEH4s3Ka/7xK7bhXHWVqLDnX4rSXmA7Zq2UpPajZ0RU4Uqqw7F3sSgu/1jN2y/wR+CJNb6b5RE5jshyPWhZxIIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711186138; c=relaxed/simple;
	bh=5lBIVgAM5E4mPhYWUorhznpmzPoNlqyWAgY/2lpzGj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=atV9YUY4u6hnAiFKIjrEfX3L5jS0YF99yrghXiwh13gVMSR4CepxUhLhZhG83M6QTasl/FmvISr/K4bGDgWvL6whlgaEfO5MyaSSFuIYeXvfVyqkFu5IblLYqIHHX7rtynvC9OHR25JNWnXLf1RR8a//I/w0mNgheU8b1ye799g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YGijb2pN; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CNVZw
	DrMkjyNbmfapeaXh+oqui44MB1SGQzuQiUxjpU=; b=YGijb2pNueRnbfDouJZCj
	LCOVCUsp5DKUHslMRNUijL/N4wMoeWke0OYzDTLPEGFJvI6B7gyE4XccEh9PPkd7
	YbMY0ex2i3p9aBIYeaMpnvV/xx/1dTsMabKlOfUJxgQekmpmIbL8cc0w84DGmTS9
	NO2yL9s0NsYeNUMbDgXpy4=
Received: from localhost.localdomain (unknown [111.198.54.11])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wD3P9B0oP5lJX1nBg--.18267S2;
	Sat, 23 Mar 2024 17:27:18 +0800 (CST)
From: LuMingYin <lumingyindetect@163.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	minhuadotchen@gmail.com,
	LuMingYin <lumingyindetect@163.com>
Subject: [PATCH] sound:Fix a memory leak in snd_ctl_elem_add_compat function
Date: Sat, 23 Mar 2024 17:27:12 +0800
Message-Id: <20240323092712.685675-1-lumingyindetect@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P9B0oP5lJX1nBg--.18267S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw17GF4fKw4UXr4fCF48WFg_yoW5Gw4rpF
	WfKrZxKrn7XrnIkFnxtF18WF1fZ397Ja1DWr4Dtw1rZay3Wr10va4rAryFvwsF9ryvkrWU
	Ca1jqFZa9wnIkFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTyIbUUUUU=
X-CM-SenderInfo: poxpx0hj1l0vphwhu3i6rwjhhfrp/xtbBoA+q92WXwXlQngAAs2

In the function snd_ctl_elem_add_compat defined in /linux/sound/core/control_compat.c, a pointer named data is declared. This pointer allocates a block of dynamic memory using the kzalloc function at line 354. When the if statement at line 355 returns false, it indicates successful allocation of the dynamic memory area pointed to by data. However, when the if statements at lines 359 or 362 are true, the program will not execute the snd_ctl_elem_add(file, data, replace); operation at line 389 and will return directly. During this process, the dynamic memory area pointed to by data is neither freed nor used, leading to a memory leak bug. This commit fixes the aforementioned memory leak issue.

Signed-off-by: LuMingYin <lumingyindetect@163.com>
---
 sound/core/control_compat.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 934bb945e702..685f88e2835a 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -357,29 +357,39 @@ static int snd_ctl_elem_add_compat(struct snd_ctl_file *file,
 
 	/* id, type, access, count */ \
 	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)) ||
-	    copy_from_user(&data->type, &data32->type, 3 * sizeof(u32)))
+	    copy_from_user(&data->type, &data32->type, 3 * sizeof(u32))){
+		kfree(data);
 		return -EFAULT;
-	if (get_user(data->owner, &data32->owner))
+		}
+	if (get_user(data->owner, &data32->owner)){
+		kfree(data);
 		return -EFAULT;
+	}
 	switch (data->type) {
 	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
 	case SNDRV_CTL_ELEM_TYPE_INTEGER:
 		if (get_user(data->value.integer.min, &data32->value.integer.min) ||
 		    get_user(data->value.integer.max, &data32->value.integer.max) ||
-		    get_user(data->value.integer.step, &data32->value.integer.step))
+		    get_user(data->value.integer.step, &data32->value.integer.step)){
+			kfree(data);
 			return -EFAULT;
+		}
 		break;
 	case SNDRV_CTL_ELEM_TYPE_INTEGER64:
 		if (copy_from_user(&data->value.integer64,
 				   &data32->value.integer64,
-				   sizeof(data->value.integer64)))
+				   sizeof(data->value.integer64))){
+			kfree(data);
 			return -EFAULT;
+		}
 		break;
 	case SNDRV_CTL_ELEM_TYPE_ENUMERATED:
 		if (copy_from_user(&data->value.enumerated,
 				   &data32->value.enumerated,
-				   sizeof(data->value.enumerated)))
+				   sizeof(data->value.enumerated))){
+			kfree(data);
 			return -EFAULT;
+		}
 		data->value.enumerated.names_ptr =
 			(uintptr_t)compat_ptr(data->value.enumerated.names_ptr);
 		break;
-- 
2.25.1


