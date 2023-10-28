Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D3C7DA444
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 02:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346750AbjJ1ANF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 20:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346735AbjJ1ANB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 20:13:01 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CB21B8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 17:12:59 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 85062E5A25DF; Fri, 27 Oct 2023 17:10:02 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 2/4] mm/ksm: add sysfs knobs for advisor
Date:   Fri, 27 Oct 2023 17:09:43 -0700
Message-Id: <20231028000945.2428830-3-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231028000945.2428830-1-shr@devkernel.io>
References: <20231028000945.2428830-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_NEUTRAL,
        TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds four new knobs for the KSM advisor to influence its behaviour.

The knobs are:
- advisor_mode:
    0: no advisor (default)
    1: scan time advisor
- advisor_min_cpu: 15 (default, cpu usage percent)
- advisor_max_cpu: 70 (default, cpu usage percent)
- advisor_min_pages: 500 (default)
- advisor_max_pages: 30000 (default)
- advisor_target_scan_time: 200 (default in seconds)

The new values will take effect on the next scan round.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/ksm.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index e18fecfb359d..042ecaeb0beb 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -351,6 +351,14 @@ static void init_advisor(void)
 	advisor_ctx.cpu_time =3D 0;
 }
=20
+static void set_advisor_defaults(void)
+{
+	if (ksm_advisor =3D=3D KSM_ADVISOR_NONE)
+		ksm_thread_pages_to_scan =3D DEFAULT_PAGES_TO_SCAN;
+	else if (ksm_advisor =3D=3D KSM_ADVISOR_SCAN_TIME)
+		ksm_thread_pages_to_scan =3D ksm_advisor_min_pages;
+}
+
 /*
  * Use previous scan time if available, otherwise use current scan time =
as an
  * approximation for the previous scan time.
@@ -3719,6 +3727,146 @@ static ssize_t smart_scan_store(struct kobject *k=
obj,
 }
 KSM_ATTR(smart_scan);
=20
+static ssize_t advisor_mode_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", ksm_advisor);
+}
+
+static ssize_t advisor_mode_store(struct kobject *kobj,
+				  struct kobj_attribute *attr, const char *buf,
+				  size_t count)
+{
+	unsigned int mode;
+	int err;
+
+	err =3D kstrtouint(buf, 10, &mode);
+	if (err)
+		return -EINVAL;
+	if (mode > KSM_ADVISOR_LAST)
+		return -EINVAL;
+
+	/* Set advisor default values */
+	ksm_advisor =3D mode;
+	init_advisor();
+	set_advisor_defaults();
+
+	return count;
+}
+KSM_ATTR(advisor_mode);
+
+static ssize_t advisor_min_cpu_show(struct kobject *kobj,
+				    struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", ksm_advisor_min_cpu);
+}
+
+static ssize_t advisor_min_cpu_store(struct kobject *kobj,
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
+	ksm_advisor_min_cpu =3D value;
+	return count;
+}
+KSM_ATTR(advisor_min_cpu);
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
+static ssize_t advisor_min_pages_show(struct kobject *kobj,
+				      struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", ksm_advisor_min_pages);
+}
+
+static ssize_t advisor_min_pages_store(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       const char *buf, size_t count)
+{
+	int err;
+	unsigned long value;
+
+	err =3D kstrtoul(buf, 10, &value);
+	if (err)
+		return -EINVAL;
+
+	ksm_advisor_min_pages =3D value;
+	return count;
+}
+KSM_ATTR(advisor_min_pages);
+
+static ssize_t advisor_max_pages_show(struct kobject *kobj,
+				      struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", ksm_advisor_max_pages);
+}
+
+static ssize_t advisor_max_pages_store(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       const char *buf, size_t count)
+{
+	int err;
+	unsigned long value;
+
+	err =3D kstrtoul(buf, 10, &value);
+	if (err)
+		return -EINVAL;
+
+	ksm_advisor_max_pages =3D value;
+	return count;
+}
+KSM_ATTR(advisor_max_pages);
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
@@ -3741,6 +3889,12 @@ static struct attribute *ksm_attrs[] =3D {
 	&use_zero_pages_attr.attr,
 	&general_profit_attr.attr,
 	&smart_scan_attr.attr,
+	&advisor_mode_attr.attr,
+	&advisor_min_cpu_attr.attr,
+	&advisor_max_cpu_attr.attr,
+	&advisor_min_pages_attr.attr,
+	&advisor_max_pages_attr.attr,
+	&advisor_target_scan_time_attr.attr,
 	NULL,
 };
=20
--=20
2.39.3

