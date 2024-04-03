Return-Path: <linux-kernel+bounces-128877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803E0896167
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5201F2921F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D895182A0;
	Wed,  3 Apr 2024 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="Jiy5zPWJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RhXpz0ay"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55915AF1;
	Wed,  3 Apr 2024 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104181; cv=none; b=iNwveyJyqbxQ3yvmDNfJYAFeo5st+F3NZj+aVoO2284bYwMPHl0uPE0Bj75Nnzy/JDvLKRdz7FT/nCF1PE6vgNDWGZG2WMnQqaLXCwRFOCpYEmtQ+4T0mSGFqQ33cBbs/J2ukUVuA6/7PB0G3zrAlce7ZvJgAGLoRilj44JCGr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104181; c=relaxed/simple;
	bh=cShbs3bJuOgjEwM14fFKjZEJmbP8r0XOXpx8pQHoqog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAxaW8DAlW26BncgjrrbWpyFpZ80dzUw9qNA3mA5k1lAgBlB1lJlJmmB2uJvZH+r2xCbe4ppTPwLNx3kz52FXMlX87Pc+dFvQJlu0j4iwjPet9sWebYSo+QopheheoIoYLEmFyjBIJMeMZsqa5xsyEVfkB6k40iVErnDq1YzO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=Jiy5zPWJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RhXpz0ay; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0E4B213800DA;
	Tue,  2 Apr 2024 20:29:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 02 Apr 2024 20:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712104179;
	 x=1712190579; bh=o0/vJqpd9srucno4MRwmA+Fc6L50yGN5H7PaUAexeYc=; b=
	Jiy5zPWJIPmLNVBtBcbNJl3f1BuvglKIOFW0CU0KJl0TyVZ/pu2xqjoU5mG67son
	1XXowSHW8m5gFQ5FWkcdyFw4hc2OKJ5tC+m9nXWtbmk6lO/vdh24G84HkiuPiwmN
	TXvwtS5Nfbo8G6zLlngZ8BILwDnFQYHaUN1JRvu9D3WlNw6//x+Qs9NyvIY+aO++
	lBFNeYbqM+rt+7gL9/zjv9nxyTqC89XeD/+rLKShBEExAWc8YmLoC3FZTL2JQQ6Q
	PRBDGuCR7CdZEmVObogOw2OsKdtZzeaGISjq89AGzo1HD3dblAZIJPBdjGfyOw5A
	d73URMowjBglCemHjzncJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712104179; x=
	1712190579; bh=o0/vJqpd9srucno4MRwmA+Fc6L50yGN5H7PaUAexeYc=; b=R
	hXpz0ayu2OpRtGRGr0o1lqgJpRUVHiktxAF2rwaNTnngFrhHrnSijxFlmy8Lf0yp
	KISbIxJ+SxG+t+Sy/OJHnMAYIOV+ju/+CkCjMHAXe43W+VuWe+yr0+c+vh23Jx69
	ka8EIT6NwazkcEI9T6AQtWVbUHT6FWmkGgU1qb+edZe5EOhcDAVozIbYb14EDgoO
	eD1sti1VuKUUWPRJywEMNpf3yCxfy2K60PSgbYKAiQUx2CPnbwVrmgZroBk3Ag0u
	YQYortFDqmHTU9Dlqomvy132CvcrucEjdJAi1NdJjucU4nX9twvOKP1mfmbMRt0S
	Cdtv52hZzv/5aLhRv1JkQ==
X-ME-Sender: <xms:8qIMZlPcFGWUPJYGWMU6AWGADxSELAhK_CfUAh8WzwGKL0pHphEyug>
    <xme:8qIMZn99TiZg7ftWrIlTeH_AQ3rBTNKFIA8-tywutfXKfKPdz4vSybskVxkrsRfKq
    vs2t-fGf-q-tXdDW9M>
X-ME-Received: <xmr:8qIMZkThn55d7z7xi4SvqEuuXYUsB42sCt7V63UB4uIvqhAf5CsmvmemZVHh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduudetudehiedvvdevveelhf
    egkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:8qIMZhtuCRaNHvDaX2PNf2CIvlolr62M3_PFdbA3ztnEqO6h9VSYyA>
    <xmx:8qIMZtfnFwIx0VSnrTovgoAqhhgP_n9SdQhki7GAL0YZhQZ_FKBvGA>
    <xmx:8qIMZt18kwurGgAK1j7eKQJyNHJ-2B4kpuMhK7lyRNbFZweP3_GO1Q>
    <xmx:8qIMZp9JVKQfVkfHWEwiUDkrcWDPClukabivrFqCYVjGygtJ6yyNBg>
    <xmx:86IMZlT8DXWXv9XgJ6P3VEyFv0q6e5BIRNFQQtEYK31RieGq0_DwMUsJ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 20:29:36 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 4/9] platform/x86: asus-wmi: support toggling POST sound
Date: Wed,  3 Apr 2024 13:29:12 +1300
Message-ID: <20240403002917.2870959-5-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403002917.2870959-1-luke@ljones.dev>
References: <20240403002917.2870959-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for toggling the BIOS POST sound on some ASUS laptops.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++++
 drivers/platform/x86/asus-wmi.c               | 51 +++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  3 ++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index ef1ac1a20a71..72933527d2e4 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -194,3 +194,12 @@ Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
 		Set the target temperature limit of the Nvidia dGPU:
 			* min=75, max=87
+
+What:		/sys/devices/platform/<platform>/boot_sound
+Date:		Apr 2024
+KernelVersion:	6.10
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set if the BIOS POST sound is played on boot.
+			* 0 - False,
+			* 1 - True
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index b6a8b4eefdb3..3cb907ee07c5 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2115,6 +2115,54 @@ static ssize_t panel_od_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(panel_od);
 
+/* Bootup sound ***************************************************************/
+
+static ssize_t boot_sound_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int result;
+
+	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_BOOT_SOUND);
+	if (result < 0)
+		return result;
+
+	return sysfs_emit(buf, "%d\n", result);
+}
+
+static ssize_t boot_sound_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	int result, err;
+	u32 snd;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtou32(buf, 10, &snd);
+	if (result)
+		return result;
+
+	if (snd > 1)
+		return -EINVAL;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BOOT_SOUND, snd, &result);
+	if (err) {
+		pr_warn("Failed to set boot sound: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set panel boot sound (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "boot_sound");
+
+	return count;
+}
+static DEVICE_ATTR_RW(boot_sound);
+
 /* Mini-LED mode **************************************************************/
 static ssize_t mini_led_mode_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -4205,6 +4253,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_ppt_platform_sppt.attr,
 	&dev_attr_nv_dynamic_boost.attr,
 	&dev_attr_nv_temp_target.attr,
+	&dev_attr_boot_sound.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
 	&dev_attr_available_mini_led_mode.attr,
@@ -4257,6 +4306,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->nv_dyn_boost_available;
 	else if (attr == &dev_attr_nv_temp_target.attr)
 		ok = asus->nv_temp_tgt_available;
+	else if (attr == &dev_attr_boot_sound.attr)
+		devid = ASUS_WMI_DEVID_BOOT_SOUND;
 	else if (attr == &dev_attr_panel_od.attr)
 		ok = asus->panel_overdrive_available;
 	else if (attr == &dev_attr_mini_led_mode.attr)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 3e9a01467c67..3eb5cd6773ad 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -137,6 +137,9 @@
 /* TUF laptop RGB power/state */
 #define ASUS_WMI_DEVID_TUF_RGB_STATE	0x00100057
 
+/* Bootup sound control */
+#define ASUS_WMI_DEVID_BOOT_SOUND	0x00130022
+
 /* DSTS masks */
 #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
 #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
-- 
2.44.0


