Return-Path: <linux-kernel+bounces-4466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACFE817DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A5CB2307B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2949D760B4;
	Mon, 18 Dec 2023 23:11:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AC76093
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=devkernel.io
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
	id 1568F111427AE; Mon, 18 Dec 2023 15:10:56 -0800 (PST)
From: Stefan Roesch <shr@devkernel.io>
To: kernel-team@fb.com
Cc: shr@devkernel.io,
	akpm@linux-foundation.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 2/4] mm/ksm: add sysfs knobs for advisor
Date: Mon, 18 Dec 2023 15:10:52 -0800
Message-Id: <20231218231054.1625219-3-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231218231054.1625219-1-shr@devkernel.io>
References: <20231218231054.1625219-1-shr@devkernel.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds four new knobs for the KSM advisor to influence its behaviour.

The knobs are:
- advisor_mode:
    none:      no advisor (default)
    scan-time: scan time advisor
- advisor_max_cpu: 70 (default, cpu usage percent)
- advisor_min_pages_to_scan: 500 (default)
- advisor_max_pages_to_scan: 30000 (default)
- advisor_target_scan_time: 200 (default in seconds)

The new values will take effect on the next scan round.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 59911700695f7..10e2696907250 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -338,6 +338,25 @@ enum ksm_advisor_type {
 };
 static enum ksm_advisor_type ksm_advisor;
=20
+#ifdef CONFIG_SYSFS
+/*
+ * Only called through the sysfs control interface:
+ */
+
+/* At least scan this many pages per batch. */
+static unsigned long ksm_advisor_min_pages_to_scan =3D 500;
+
+static void set_advisor_defaults(void)
+{
+	if (ksm_advisor =3D=3D KSM_ADVISOR_NONE) {
+		ksm_thread_pages_to_scan =3D DEFAULT_PAGES_TO_SCAN;
+	} else if (ksm_advisor =3D=3D KSM_ADVISOR_SCAN_TIME) {
+		advisor_ctx =3D (const struct advisor_ctx){ 0 };
+		ksm_thread_pages_to_scan =3D ksm_advisor_min_pages_to_scan;
+	}
+}
+#endif /* CONFIG_SYSFS */
+
 static inline void advisor_start_scan(void)
 {
 	if (ksm_advisor =3D=3D KSM_ADVISOR_SCAN_TIME)
@@ -3723,6 +3742,130 @@ static ssize_t smart_scan_store(struct kobject *k=
obj,
 }
 KSM_ATTR(smart_scan);
=20
+static ssize_t advisor_mode_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	const char *output;
+
+	if (ksm_advisor =3D=3D KSM_ADVISOR_NONE)
+		output =3D "[none] scan-time";
+	else if (ksm_advisor =3D=3D KSM_ADVISOR_SCAN_TIME)
+		output =3D "none [scan-time]";
+
+	return sysfs_emit(buf, "%s\n", output);
+}
+
+static ssize_t advisor_mode_store(struct kobject *kobj,
+				  struct kobj_attribute *attr, const char *buf,
+				  size_t count)
+{
+	enum ksm_advisor_type curr_advisor =3D ksm_advisor;
+
+	if (sysfs_streq("scan-time", buf))
+		ksm_advisor =3D KSM_ADVISOR_SCAN_TIME;
+	else if (sysfs_streq("none", buf))
+		ksm_advisor =3D KSM_ADVISOR_NONE;
+	else
+		return -EINVAL;
+
+	/* Set advisor default values */
+	if (curr_advisor !=3D ksm_advisor)
+		set_advisor_defaults();
+
+	return count;
+}
+KSM_ATTR(advisor_mode);
+
+static ssize_t advisor_max_cpu_show(struct kobject *kobj,
+				    struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", ksm_advisor_max_cpu);
+}
+
+static ssize_t advisor_max_cpu_store(struct kobject *kobj,
+				     struct kobj_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int err;
+	unsigned long value;
+
+	err =3D kstrtoul(buf, 10, &value);
+	if (err)
+		return -EINVAL;
+
+	ksm_advisor_max_cpu =3D value;
+	return count;
+}
+KSM_ATTR(advisor_max_cpu);
+
+static ssize_t advisor_min_pages_to_scan_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", ksm_advisor_min_pages_to_scan);
+}
+
+static ssize_t advisor_min_pages_to_scan_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	int err;
+	unsigned long value;
+
+	err =3D kstrtoul(buf, 10, &value);
+	if (err)
+		return -EINVAL;
+
+	ksm_advisor_min_pages_to_scan =3D value;
+	return count;
+}
+KSM_ATTR(advisor_min_pages_to_scan);
+
+static ssize_t advisor_max_pages_to_scan_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", ksm_advisor_max_pages_to_scan);
+}
+
+static ssize_t advisor_max_pages_to_scan_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	int err;
+	unsigned long value;
+
+	err =3D kstrtoul(buf, 10, &value);
+	if (err)
+		return -EINVAL;
+
+	ksm_advisor_max_pages_to_scan =3D value;
+	return count;
+}
+KSM_ATTR(advisor_max_pages_to_scan);
+
+static ssize_t advisor_target_scan_time_show(struct kobject *kobj,
+					     struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", ksm_advisor_target_scan_time);
+}
+
+static ssize_t advisor_target_scan_time_store(struct kobject *kobj,
+					      struct kobj_attribute *attr,
+					      const char *buf, size_t count)
+{
+	int err;
+	unsigned long value;
+
+	err =3D kstrtoul(buf, 10, &value);
+	if (err)
+		return -EINVAL;
+	if (value < 1)
+		return -EINVAL;
+
+	ksm_advisor_target_scan_time =3D value;
+	return count;
+}
+KSM_ATTR(advisor_target_scan_time);
+
 static struct attribute *ksm_attrs[] =3D {
 	&sleep_millisecs_attr.attr,
 	&pages_to_scan_attr.attr,
@@ -3745,6 +3888,11 @@ static struct attribute *ksm_attrs[] =3D {
 	&use_zero_pages_attr.attr,
 	&general_profit_attr.attr,
 	&smart_scan_attr.attr,
+	&advisor_mode_attr.attr,
+	&advisor_max_cpu_attr.attr,
+	&advisor_min_pages_to_scan_attr.attr,
+	&advisor_max_pages_to_scan_attr.attr,
+	&advisor_target_scan_time_attr.attr,
 	NULL,
 };
=20
--=20
2.39.3


