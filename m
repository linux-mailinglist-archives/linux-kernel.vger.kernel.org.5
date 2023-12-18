Return-Path: <linux-kernel+bounces-4470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40252817DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547031C21C52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8691768F1;
	Mon, 18 Dec 2023 23:13:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4211EA85
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=devkernel.io
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
	id E0DD6111427B7; Mon, 18 Dec 2023 15:10:57 -0800 (PST)
From: Stefan Roesch <shr@devkernel.io>
To: kernel-team@fb.com
Cc: shr@devkernel.io,
	akpm@linux-foundation.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 4/4] mm/ksm: document ksm advisor and its sysfs knobs
Date: Mon, 18 Dec 2023 15:10:54 -0800
Message-Id: <20231218231054.1625219-5-shr@devkernel.io>
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


