Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A4B7B09E9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjI0QWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjI0QWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:22:47 -0400
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C490DE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:22:46 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 30125CA4DC0D; Wed, 27 Sep 2023 09:22:32 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 0/4] Smart scanning mode for KSM
Date:   Wed, 27 Sep 2023 09:22:18 -0700
Message-Id: <20230927162222.3827551-1-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
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

This patch series adds "smart scanning" for KSM.

What is smart scanning?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
KSM evaluates all the candidate pages for each scan. It does not use hist=
oric
information from previous scans. This has the effect that candidate pages=
 that
couldn't be used for KSM de-duplication continue to be evaluated for each=
 scan.

The idea of "smart scanning" is to keep historic information. With the hi=
storic
information we can temporarily skip the candidate page for one or several=
 scans.

Details:
=3D=3D=3D=3D=3D=3D=3D=3D
"Smart scanning" is to keep two small counters to store if the page has b=
een
used for KSM. One counter stores how often we already tried to use the pa=
ge for
KSM and the other counter stores how often we skip a page.

How often we skip the candidate page depends how often a page failed KSM
de-duplication. The code skips a maximum of 8 times. During testing this =
has
shown to be a good compromise for different workloads.

New sysfs knob:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Smart scanning is enabled by default. With /sys/kernel/mm/ksm/smart_scan
smart scanning can be disabled.

Monitoring:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
To monitor how effective smart scanning is a new sysfs knob has been intr=
oduced.
/sys/kernel/mm/pages_skipped report how many pages have been skipped by s=
mart
scanning.

Results:
=3D=3D=3D=3D=3D=3D=3D=3D
- Various workloads have shown a 20% - 25% reduction in page scans
  For the instagram workload for instance, the number of pages scanned ha=
s been
  reduced from over 20M pages per scan to less than 15M pages.
- Less pages scans also resulted in an overall higher de-duplication rate=
 as
  some shorter lived pages could be de-duplicated additionally
- Less pages scanned allows to reduce the pages_to_scan parameter
  and this resulted in  a 25% reduction in terms of CPU.
- The improvements have been observed for workloads that enable KSM with
  madvise as well as prctl


Changes:
  - V4:
    - Changed default from disabled to enabled
    - Changed commit message for first patch to mention it is enabled
    - Changed documentation to mention it is enabled by default
    - Changed cover letter description to mention it is enabled by defaul=
t
  - V3:
    - Renamed field skip_age to remaining_skips
    - Moved fields after old_checksum
    - Changed should_skip_rmap_item to use remaining_skips field
  - V2:
    - Renamed function inc_skip_age() to skip_age()
    - Added comment to skip_age() function
    - Renamed function skip_rmap_item() to should_skip_rmap_item()
    - Added more comments to should_skip_rmap_item function
    - Added explicit modification of age with overflow check


Stefan Roesch (4):
  mm/ksm: add "smart" page scanning mode
  mm/ksm: add pages_skipped metric
  mm/ksm: document smart scan mode
  mm/ksm: document pages_skipped sysfs knob

 Documentation/admin-guide/mm/ksm.rst |  11 +++
 mm/ksm.c                             | 115 +++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)


base-commit: 15bcc9730fcd7526a3b92eff105d6701767a53bb
--=20
2.39.3

