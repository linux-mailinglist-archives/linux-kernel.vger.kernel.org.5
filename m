Return-Path: <linux-kernel+bounces-107021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 082A587F6D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B6AB21A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56EC5FEE4;
	Tue, 19 Mar 2024 05:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="mDYhD3b4"
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88098446A9;
	Tue, 19 Mar 2024 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827155; cv=none; b=a+jAaJXXuVJE66LmpC0iNdoWIwEGMRaLOqiDuaSGyGeVhRHF4CDktRWJDgoWASgdVKwqi2SXUtFhJpqf4a9obzGI/1hQy85PBKQVK7JrJuHcVotvmb+lsvNvIsiMPXDseaaHC1HhgbNJyuP3w2JGVkv6idNwc+Aq7FhUbyMej88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827155; c=relaxed/simple;
	bh=6fB6x/UBUYYq8kyJETKjre6cGY5VsNv28Geya3dyAwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jmaUEEsaJtVP2AA3oxyjqP6gusodwYY2qaEbaN3I6adbMG8XnWU4pZe7jPbRnHCGus3lU4OsQGlaUzlJJYxtO61a9HTNRz2j5BvW0BNKlN6Z6w/C9YoTNXqDOwqANHPB6sVm5CI/DXx/ZPwQH7YnYLOgbdRbs5SdaVonGGDOW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=mDYhD3b4; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710827152; x=1742363152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6fB6x/UBUYYq8kyJETKjre6cGY5VsNv28Geya3dyAwQ=;
  b=mDYhD3b4UndaVNpXdfChJWdGI/m+V6C0/WIAuPux9E0yOVTKhC+22hoa
   0b6QLJM1k3DfTnob5/RCFCIbJTB6JfzFMRACK0kAUtKPni1aYBUnkvssv
   5yB4MKc3KunGdiGpoeIIs5xl7L2DTYFrtcot/E3GI6FPCTrTm2lQjbjdU
   H7mZj7IKbE/wciY4+3sVssMyIbhbK1W6hTsvbAyJOLAakpuTiXHtg6l90
   n6RUpeLg+nHkXybHc6Haj9KA3bipiEr1los8xEn01a1SFhtk3/0uPBMNJ
   33a3Y7IhQuPA2HYnKpNcSZhkCbB5QsTrjCeBXDbvG3FzL2S1zbEOaykdW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="154544111"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="154544111"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 14:45:42 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D4B53C21A4;
	Tue, 19 Mar 2024 14:45:40 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 057BAD9941;
	Tue, 19 Mar 2024 14:45:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9170B20098E1C;
	Tue, 19 Mar 2024 14:45:39 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 285FC1A006D;
	Tue, 19 Mar 2024 13:45:39 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org
Subject: [PATCH v4 4/4] HID: corsair,lenovo: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 13:45:27 +0800
Message-Id: <20240319054527.1581299-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240319054527.1581299-1-lizhijian@fujitsu.com>
References: <20240319054527.1581299-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28260.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28260.005
X-TMASE-Result: 10--3.944400-10.000000
X-TMASE-MatchedRID: xt1fvVgCaAwbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/0swHSFcVJ6C99T+uJIleRfDo
	fTpsyCK+KztDhRgoFQW4suX2uLJTkj56IjTnLR+m5x7uAXGEprcE5XPQnBzGXq8KsbROd9VSArq
	oIZrVn15fzUkBpc072vt0ykue8nm5wAPXhY/Un2J4CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyHEqm
	8QYBtMOvtYA/wO/s2MzEiH8IM90IKLFMXg7/eQvX46G2RhH3zln/pcicAOGM9aguNcU6KZvJlDI
	DZ8ipFpcq6BFct5ZpqQf7rb+j+lIW4wbpXTb5DJKKve1kh3RY37qSWrndbmQn0bOriG5BVc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() and scnprintf() will be converted as well if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: Jiri Kosina <jikos@kernel.org>
CC: Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: linux-input@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/hid/hid-corsair.c |  4 ++--
 drivers/hid/hid-lenovo.c  | 23 ++++++++++-------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 8c895c820b67..702f50e9841d 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -298,7 +298,7 @@ static ssize_t k90_show_macro_mode(struct device *dev,
 		goto out;
 	}
 
-	ret = snprintf(buf, PAGE_SIZE, "%s\n", macro_mode);
+	ret = sysfs_emit(buf, "%s\n", macro_mode);
 out:
 	kfree(data);
 
@@ -367,7 +367,7 @@ static ssize_t k90_show_current_profile(struct device *dev,
 		goto out;
 	}
 
-	ret = snprintf(buf, PAGE_SIZE, "%d\n", current_profile);
+	ret = sysfs_emit(buf, "%d\n", current_profile);
 out:
 	kfree(data);
 
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index f86c1ea83a03..e6b2ae68b8fb 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -555,7 +555,7 @@ static ssize_t attr_fn_lock_show(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data->fn_lock);
+	return sysfs_emit(buf, "%u\n", data->fn_lock);
 }
 
 static ssize_t attr_fn_lock_store(struct device *dev,
@@ -599,8 +599,7 @@ static ssize_t attr_sensitivity_show_cptkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		cptkbd_data->sensitivity);
+	return sysfs_emit(buf, "%u\n", cptkbd_data->sensitivity);
 }
 
 static ssize_t attr_sensitivity_store_cptkbd(struct device *dev,
@@ -628,8 +627,8 @@ static ssize_t attr_middleclick_workaround_show_cptkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		cptkbd_data->middleclick_workaround_cptkbd);
+	return sysfs_emit(buf, "%u\n",
+			  cptkbd_data->middleclick_workaround_cptkbd);
 }
 
 static ssize_t attr_middleclick_workaround_store_cptkbd(struct device *dev,
@@ -809,7 +808,7 @@ static ssize_t attr_press_to_select_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->press_to_select);
+	return sysfs_emit(buf, "%u\n", data_pointer->press_to_select);
 }
 
 static ssize_t attr_press_to_select_store_tpkbd(struct device *dev,
@@ -839,7 +838,7 @@ static ssize_t attr_dragging_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->dragging);
+	return sysfs_emit(buf, "%u\n", data_pointer->dragging);
 }
 
 static ssize_t attr_dragging_store_tpkbd(struct device *dev,
@@ -869,7 +868,7 @@ static ssize_t attr_release_to_select_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->release_to_select);
+	return sysfs_emit(buf, "%u\n", data_pointer->release_to_select);
 }
 
 static ssize_t attr_release_to_select_store_tpkbd(struct device *dev,
@@ -899,7 +898,7 @@ static ssize_t attr_select_right_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->select_right);
+	return sysfs_emit(buf, "%u\n", data_pointer->select_right);
 }
 
 static ssize_t attr_select_right_store_tpkbd(struct device *dev,
@@ -929,8 +928,7 @@ static ssize_t attr_sensitivity_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		data_pointer->sensitivity);
+	return sysfs_emit(buf, "%u\n", data_pointer->sensitivity);
 }
 
 static ssize_t attr_sensitivity_store_tpkbd(struct device *dev,
@@ -958,8 +956,7 @@ static ssize_t attr_press_speed_show_tpkbd(struct device *dev,
 	struct hid_device *hdev = to_hid_device(dev);
 	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		data_pointer->press_speed);
+	return sysfs_emit(buf, "%u\n", data_pointer->press_speed);
 }
 
 static ssize_t attr_press_speed_store_tpkbd(struct device *dev,
-- 
2.29.2


