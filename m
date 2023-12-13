Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E63811C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442624AbjLMS1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjLMS1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:27:40 -0500
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FDB11B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:27:46 -0800 (PST)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id C6E0610CFA72F; Wed, 13 Dec 2023 10:27:33 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 4/4] mm/ksm: document ksm advisor and its sysfs knobs
Date:   Wed, 13 Dec 2023 10:27:29 -0800
Message-Id: <20231213182729.587081-5-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231213182729.587081-1-shr@devkernel.io>
References: <20231213182729.587081-1-shr@devkernel.io>
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

This documents the KSM advisor and its new knobs in /sys/fs/kernel/mm.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Acked-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/ksm.rst | 55 ++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-g=
uide/mm/ksm.rst
index e59231ac6bb71..a639cac124777 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -80,6 +80,9 @@ pages_to_scan
         how many pages to scan before ksmd goes to sleep
         e.g. ``echo 100 > /sys/kernel/mm/ksm/pages_to_scan``.
=20
+        The pages_to_scan value cannot be changed if ``advisor_mode`` ha=
s
+        been set to scan-time.
+
         Default: 100 (chosen for demonstration purposes)
=20
 sleep_millisecs
@@ -164,6 +167,29 @@ smart_scan
         optimization is enabled.  The ``pages_skipped`` metric shows how
         effective the setting is.
=20
+advisor_mode
+        The ``advisor_mode`` selects the current advisor. Two modes are
+        supported: none and scan-time. The default is none. By setting
+        ``advisor_mode`` to scan-time, the scan time advisor is enabled.
+        The section about ``advisor`` explains in detail how the scan ti=
me
+        advisor works.
+
+adivsor_max_cpu
+        specifies the upper limit of the cpu percent usage of the ksmd
+        background thread. The default is 70.
+
+advisor_target_scan_time
+        specifies the target scan time in seconds to scan all the candid=
ate
+        pages. The default value is 200 seconds.
+
+advisor_min_pages_to_scan
+        specifies the lower limit of the ``pages_to_scan`` parameter of =
the
+        scan time advisor. The default is 500.
+
+adivsor_max_pages_to_scan
+        specifies the upper limit of the ``pages_to_scan`` parameter of =
the
+        scan time advisor. The default is 30000.
+
 The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm=
/ksm/``:
=20
 general_profit
@@ -263,6 +289,35 @@ ksm_swpin_copy
 	note that KSM page might be copied when swapping in because do_swap_pag=
e()
 	cannot do all the locking needed to reconstitute a cross-anon_vma KSM p=
age.
=20
+Advisor
+=3D=3D=3D=3D=3D=3D=3D
+
+The number of candidate pages for KSM is dynamic. It can be often observ=
ed
+that during the startup of an application more candidate pages need to b=
e
+processed. Without an advisor the ``pages_to_scan`` parameter needs to b=
e
+sized for the maximum number of candidate pages. The scan time advisor c=
an
+changes the ``pages_to_scan`` parameter based on demand.
+
+The advisor can be enabled, so KSM can automatically adapt to changes in=
 the
+number of candidate pages to scan. Two advisors are implemented: none an=
d
+scan-time. With none, no advisor is enabled. The default is none.
+
+The scan time advisor changes the ``pages_to_scan`` parameter based on t=
he
+observed scan times. The possible values for the ``pages_to_scan`` param=
eter is
+limited by the ``advisor_max_cpu`` parameter. In addition there is also =
the
+``advisor_target_scan_time`` parameter. This parameter sets the target t=
ime to
+scan all the KSM candidate pages. The parameter ``advisor_target_scan_ti=
me``
+decides how aggressive the scan time advisor scans candidate pages. Lowe=
r
+values make the scan time advisor to scan more aggresively. This is the =
most
+important parameter for the configuration of the scan time advisor.
+
+The initial value and the maximum value can be changed with
+``advisor_min_pages_to_scan`` and ``advisor_max_pages_to_scan``. The def=
ault
+values are sufficient for most workloads and use cases.
+
+The ``pages_to_scan`` parameter is re-calculated after a scan has been c=
ompleted.
+
+
 --
 Izik Eidus,
 Hugh Dickins, 17 Nov 2009
--=20
2.39.3

