Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734847B8CD5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245485AbjJDTHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343901AbjJDTHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:07:25 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7DF30F4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:03:19 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 0F49CD08C004; Wed,  4 Oct 2023 12:03:03 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 4/4] mm/ksm: document ksm advisor and its sysfs knobs
Date:   Wed,  4 Oct 2023 12:02:49 -0700
Message-Id: <20231004190249.829015-5-shr@devkernel.io>
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

This documents the KSM advisor and its new knobs in /sys/fs/kernel/mm.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 Documentation/admin-guide/mm/ksm.rst | 45 ++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-g=
uide/mm/ksm.rst
index e59231ac6bb7..8de93650d3b0 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -164,6 +164,25 @@ smart_scan
         optimization is enabled.  The ``pages_skipped`` metric shows how
         effective the setting is.
=20
+advisor_mode
+        The ``advisor_mode`` selects the current advisor. Two modes are
+        supported: 0 (None) and 1 (Scan time). The default is None. By
+        setting ``advisor_mode`` to 1, the scan time advisor is enabled.
+        The section about ``advisor`` explains in detail how the scan ti=
me
+        advisor works.
+
+advisor_min_pages
+        specifies the lower limit of the ``pages_to_scan`` parameter of =
the
+        scan time advisor. The default is 500.
+
+adivsor_max_pages
+        specifies the upper limit of the ``pages_to_scan`` parameter of =
the
+        scan time advisor. The default is 5000.
+
+advisor_target_scan_time
+        specifies the target scan time in seconds to scan all the candid=
ate
+        pages. The default value is 200 seconds.
+
 The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm=
/ksm/``:
=20
 general_profit
@@ -263,6 +282,32 @@ ksm_swpin_copy
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
+The advisor can be enabled so KSM can automatically adapt to changes in =
the
+number of candidate pages to scan. Two advisors are implemented: 0 (None=
) and
+1 (Scan time). With None no advisor is enabled. The default is None.
+
+The Scan time advisor changes the ``pages_to_scan`` parameter based on t=
he
+observed scan times. The possible values for the ``pages_to_scan`` param=
eter is
+limited by the ``advisor_min_pages`` and ``advisor_max_pages`` parameter=
s. In
+addition there is also the ``advisor_target_scan_time`` parameter. This
+parameter sets the target time to scan all the KSM candidate pages. The
+parameter ``advisor_target_scan_time`` decides how aggressive the scan t=
ime
+advisor scans candidate pages. Lower values make the scan time advisor t=
o scan
+more aggresively. This is the most important parameter for the configura=
tion of
+the scan time advisor.
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

