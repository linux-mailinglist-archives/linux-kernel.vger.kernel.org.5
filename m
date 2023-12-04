Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CC18042D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343584AbjLDXt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjLDXtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:49:16 -0500
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EE3F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:49:21 -0800 (PST)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 814FC105D3A79; Mon,  4 Dec 2023 15:49:07 -0800 (PST)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 0/4] mm/ksm: Add ksm advisor
Date:   Mon,  4 Dec 2023 15:49:02 -0800
Message-Id: <20231204234906.1237478-1-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
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

What is the KSM advisor?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The ksm advisor automatically manages the pages_to_scan setting to
achieve a target scan time. The target scan time defines how many seconds
it should take to scan all the candidate KSM pages. In other words the
pages_to_scan rate is changed by the advisor to achieve the target scan
time.

Why do we need a KSM advisor?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
The number of candidate pages for KSM is dynamic. It can often be observe=
d
that during the startup of an application more candidate pages need to be
processed. Without an advisor the pages_to_scan parameter needs to be
sized for the maximum number of candidate pages. With the scan time
advisor the pages_to_scan parameter based can be changed based on demand.

Algorithm
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The algorithm calculates the change value based on the target scan time
and the previous scan time. To avoid pertubations an exponentially
weighted moving average is applied.

The algorithm has a max and min
value to:
- guarantee responsiveness to changes
- to limit CPU resource consumption

Parameters to influence the KSM scan advisor
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The respective parameters are:
- ksm_advisor_mode
  0: None (default), 1: scan time advisor
- ksm_advisor_target_scan_time
  how many seconds a scan should of all candidate pages take
- ksm_advisor_max_cpu
  upper limit for the cpu usage in percent of the ksmd background thread

The initial value and the max value for the pages_to_scan parameter can
be limited with:
- ksm_advisor_min_pages
  minimum value for pages_to_scan per batch
- ksm_advisor_max_pages
  maximum value for pages_to_scan per batch

The default settings for the above two parameters should be suitable for
most workloads.

The parameters are exposed as knobs in /sys/kernel/mm/ksm. By default the
scan time advisor is disabled.

Currently there are two advisors:
- none and
- scan-time.

Resource savings
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Tests with various workloads have shown considerable CPU savings. Most
of the workloads I have investigated have more candidate pages during
startup. Once the workload is stable in terms of memory, the number of
candidate pages is reduced. Without the advisor, the pages_to_scan needs
to be sized for the maximum number of candidate pages. So having this
advisor definitely helps in reducing CPU consumption.

For the instagram workload, the advisor achieves a 25% CPU reduction.
Once the memory is stable, the pages_to_scan parameter gets reduced to
about 40% of its max value.

The new advisor works especially well if the smart scan feature is also
enabled.

How is defining a target scan time better?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
For an administrator it is more logical to set a target scan time.. The
administrator can determine how many pages are scanned on each scan.
Therefore setting a target scan time makes more sense.

In addition the administrator might have a good idea about the memory
sizing of its respective workloads.

Setting cpu limits is easier than setting The pages_to_scan parameter. Th=
e
pages_to_scan parameter is per batch. For the administrator it is difficu=
lt
to set the pages_to_scan parameter.

Tracing
=3D=3D=3D=3D=3D=3D=3D
A new tracing event has been added for the scan time advisor. The new
trace event is called ksm_advisor. It reports the scan time, the new
pages_to_scan setting and the cpu usage of the ksmd background thread.

Other approaches
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Approach 1: Adapt pages_to_scan after processing each batch. If KSM
  merges pages, increase the scan rate, if less KSM pages, reduce the
  the pages_to_scan rate. This doesn't work too well. While it increases
  the pages_to_scan for a short period, but generally it ends up with a
  too low pages_to_scan rate.

Approach 2: Adapt pages_to_scan after each scan. The problem with that
  approach is that the calculated scan rate tends to be high. The more
  aggressive KSM scans, the more pages it can de-duplicate.

There have been earlier attempts at an advisor:
  propose auto-run mode of ksm and its tests
  (https://marc.info/?l=3Dlinux-mm&m=3D166029880214485&w=3D2)


Changes:
=3D=3D=3D=3D=3D=3D=3D=3D
V3:
  - Use string parameters for advisor mode
  - Removed min cpu load sysfs knob
  - dropped unused enums in ksm_advisor_type
  - renamed KSM_ADVISOR_LAST to KSM_ADVISOR_COUNT
  - init_advisor() is needed but changed how it is initialized
  - don't allow to change pages_to_scan parameter when scan-time advisor
    is enabled
  - add ksm_advisor_start_scan() and ksm_advisor_stop_scan() functions
    to calculate scan time
  - removed scan time parameter to scan_time_advisor() function

V2:
  - Use functions for long long calculations to support 32 bit platforms
  - Use cpu min and cpu max settings for the advisor instead of the pages
    min and max parameters.
  - pages min and max values are now used for the initial and max values.
    Generally they are not required to be changed.
  - Add cpu percent usage value to tracepoint definition
  - Update documentation for cpu min and cpu max values=20
  - Update commit messages for the above changes



*** BLURB HERE ***

Stefan Roesch (4):
  mm/ksm: add ksm advisor
  mm/ksm: add sysfs knobs for advisor
  mm/ksm: add tracepoint for ksm advisor
  mm/ksm: document ksm advisor and its sysfs knobs

 Documentation/admin-guide/mm/ksm.rst |  54 +++++
 include/trace/events/ksm.h           |  33 +++
 mm/ksm.c                             | 303 ++++++++++++++++++++++++++-
 3 files changed, 389 insertions(+), 1 deletion(-)


base-commit: 12d04a7bf0da67321229d2bc8b1a7074d65415a9
--=20
2.39.3

