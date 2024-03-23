Return-Path: <linux-kernel+bounces-112254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF61688777B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AB81C20DF0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F3FD267;
	Sat, 23 Mar 2024 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dxrmS6g9"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7308F4E;
	Sat, 23 Mar 2024 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711181092; cv=none; b=WSCR+mcE4uDaQVGqCvauR00PwI0HDU2EgFIho6NVyvxZTu/K3VWbi5lkUT6mM2XExuUbpTGaH7vhIYk42sWK9Zy5gpVOxN5Pu024laPqOSt9pBQU8Wg2XGzIAUftmum7ECpPeLxhUwUjfN7iX0sY4Z2c/lGjjZ0IBUdx9nicfEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711181092; c=relaxed/simple;
	bh=LOzqZIJfq3GFDFYMFq76hbLnaXAucqVOGo9lZ9q+xnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GaBorfcIrREGr7Bc4PkjdOsZcSPxv5Nbhkz4N0CD/I9xNhpzL1zSO41qwHTO+v9FOqf75UBCDP9asgsYUWV74xc0ObriJS7n3vGqORCYd0DCqHDuL2T4x4GpUfeCb8YBLlo9IuYxZ0MLEFA4xwA5uw9WH29Jn/hUTGn/NBNPSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dxrmS6g9; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4sLPu
	xdZiClCXB1J1+1mjIh7A/SbM4HGp17P+htLANo=; b=dxrmS6g96dfWIY7y+f21z
	0br3Z1/bZVXl4IGz5SiCMg46a8UbjIrekITGNpMo/Jaoxw3uN61132PlcaQXVue3
	x+YVm67xP7aBJr+PpbHtsgLhlaytZvPANkDYna/za4xDnUwKGIYUAGyVAoAGEW81
	xA8F4dp4lTFcJza5XJmTHY=
Received: from localhost.localdomain (unknown [111.198.54.11])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDX_m7_jP5l6aBtAw--.18544S2;
	Sat, 23 Mar 2024 16:04:16 +0800 (CST)
From: LuMingYin <lumingyindetect@163.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	minhuadotchen@gmail.com,
	LuMingYin <lumingyindetect@163.com>
Subject: [PATCH] sound:Fix a memory leak related to variable data
Date: Sat, 23 Mar 2024 16:04:13 +0800
Message-Id: <20240323080413.641089-1-lumingyindetect@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_m7_jP5l6aBtAw--.18544S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1UKF4xJw1UGw4fAFWxtFb_yoW8Ww4fpF
	W3Kry3tF97Ww1IkFn7tr4kWF1fZa1xZayDGwsrKw1UJFy3Xr10va4SyryrArZYy3ySkr4r
	CF4jyrWfA39xAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTlksUUUUU=
X-CM-SenderInfo: poxpx0hj1l0vphwhu3i6rwjhhfrp/1tbiTwKq92XAlCzcmAAAsJ

In the file /linux/sound/core/control_compat.c, a pointer named 'data' is defined at line 82. This pointer allocates a block of dynamic memory using the 'kzalloc' function at line 85. When the if statement at line 86 returns false, it indicates successful allocation of the dynamic memory area pointed to by 'data'. However, when the if statement at line 90 returns true, the program returns at line 91. During this process, the dynamic memory area pointed to by 'data' is neither used as in the switch statement at line 108 nor deallocated, leading to a memory leak bug. The if statement at line 95 also has the same issue. This commit fixes this problem.

Signed-off-by: LuMingYin <lumingyindetect@163.com>
---
 sound/core/control_compat.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 934bb945e702..32113eb06f68 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -87,13 +87,19 @@ static int snd_ctl_elem_info_compat(struct snd_ctl_file *ctl,
 		return -ENOMEM;
 
 	/* copy id */
-	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)))
+	if (copy_from_user(&data->id, &data32->id, sizeof(data->id))){
+		kfree(data);
+		data = NULL;
 		return -EFAULT;
+	}
 	/* we need to copy the item index.
 	 * hope this doesn't break anything..
 	 */
-	if (get_user(data->value.enumerated.item, &data32->value.enumerated.item))
+	if (get_user(data->value.enumerated.item, &data32->value.enumerated.item)){
+		kfree(data);
+		data = NULL;
 		return -EFAULT;
+	}
 
 	err = snd_ctl_elem_info(ctl, data);
 	if (err < 0)
-- 
2.25.1


