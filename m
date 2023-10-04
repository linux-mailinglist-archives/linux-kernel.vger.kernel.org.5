Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9A07B8D01
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245397AbjJDTHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343888AbjJDTHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:07:24 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F370430ED
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:03:15 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id B20EFD08BFFD; Wed,  4 Oct 2023 12:03:02 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 2/4] mm/ksm: add sysfs knobs for advisor
Date:   Wed,  4 Oct 2023 12:02:47 -0700
Message-Id: <20231004190249.829015-3-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231004190249.829015-1-shr@devkernel.io>
References: <20231004190249.829015-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,HELO_MISC_IP,
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
- advisor_min_pages: 500 (default)
- advisor_max_pages: 5000 (default)
- advisor_target_scan_time: 200 (default in seconds)

The new values will take effect on the next scan round.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/ksm.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index c9edfb293024..12e70f806b2b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -341,6 +341,14 @@ static void init_advisor(void)
 	advisor_ctx.change =3D 0;
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
@@ -3692,6 +3700,102 @@ static ssize_t smart_scan_store(struct kobject *k=
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
@@ -3714,6 +3818,10 @@ static struct attribute *ksm_attrs[] =3D {
 	&use_zero_pages_attr.attr,
 	&general_profit_attr.attr,
 	&smart_scan_attr.attr,
+	&advisor_mode_attr.attr,
+	&advisor_min_pages_attr.attr,
+	&advisor_max_pages_attr.attr,
+	&advisor_target_scan_time_attr.attr,
 	NULL,
 };
=20
--=20
2.39.3

