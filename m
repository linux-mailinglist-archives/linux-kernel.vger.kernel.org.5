Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D418042CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbjLDXtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbjLDXtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:49:15 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6B0FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:49:21 -0800 (PST)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id E345C105D3A87; Mon,  4 Dec 2023 15:49:09 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 2/4] mm/ksm: add sysfs knobs for advisor
Date:   Mon,  4 Dec 2023 15:49:04 -0800
Message-Id: <20231204234906.1237478-3-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231204234906.1237478-1-shr@devkernel.io>
References: <20231204234906.1237478-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,HELO_MISC_IP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_NEUTRAL,
        TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds four new knobs for the KSM advisor to influence its behaviour.

The knobs are:
- advisor_mode:
    none:      no advisor (default)
    scan-time: scan time advisor
- advisor_max_cpu: 70 (default, cpu usage percent)
- advisor_min_pages: 500 (default)
- advisor_max_pages: 30000 (default)
- advisor_target_scan_time: 200 (default in seconds)

The new values will take effect on the next scan round.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/ksm.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index b27010fa2e946..18b7185bbc65b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3735,6 +3735,128 @@ static ssize_t smart_scan_store(struct kobject *k=
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
+	if (sysfs_streq("scan-time", buf))
+		ksm_advisor =3D KSM_ADVISOR_SCAN_TIME;
+	else if (sysfs_streq("none", buf))
+		ksm_advisor =3D KSM_ADVISOR_NONE;
+	else
+		return -EINVAL;
+
+	/* Set advisor default values */
+	init_advisor();
+	set_advisor_defaults();
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
@@ -3757,6 +3879,11 @@ static struct attribute *ksm_attrs[] =3D {
 	&use_zero_pages_attr.attr,
 	&general_profit_attr.attr,
 	&smart_scan_attr.attr,
+	&advisor_mode_attr.attr,
+	&advisor_max_cpu_attr.attr,
+	&advisor_min_pages_attr.attr,
+	&advisor_max_pages_attr.attr,
+	&advisor_target_scan_time_attr.attr,
 	NULL,
 };
=20
--=20
2.39.3

