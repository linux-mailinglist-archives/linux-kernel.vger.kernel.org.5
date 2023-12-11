Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C0280DF2E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345114AbjLKW5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjLKW5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:57:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE3CC4;
        Mon, 11 Dec 2023 14:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702335465; x=1733871465;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=pO1ltlMpojjEdRLLW5K+Kn7C7Cek0sghm6CntoFK3oI=;
  b=kcob3KzpMSaHY5Wc+yO/NHQcXPGFMBzNoE0ItrZe3Mgeu7Efs9WRRjV1
   gA341IGhI82yiQCgoC2bghizZ6XNqHYQK6ubtrZ0z+XMbhoqkPCE+9BmJ
   vBnGr2AN2Dw9n+jB7UGn67uxFcQkASajA3QakwZSU7HWNPqkllfPX8ipQ
   oK2JNokplBb0yi/GFwhCu35NgjlxP4n9jzL5SIIEbq04pi3QoB3mIMxnP
   4TJGmXyVtPGtNS104TOEPiXhWOPPkvrGGfPdyiknU1NiWWu8/Kle3bbEs
   j1D6M47YA8K0ZTnCwGD1oTAxC/RBLCrsMudW317vtQLJF8MdoLb3tXbdf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="8084342"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="8084342"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946513455"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="946513455"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.189.178])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 14:57:43 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 0/7] efi/cxl-cper: Report CPER CXL component events
 through trace events
Date:   Mon, 11 Dec 2023 14:57:40 -0800
Message-Id: <20231211-cxl-cper-v2-0-c116900ba658@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOSTd2UC/3XNwW7DIAwG4FepOI8JAyWhp77H1AM4ZkFqkwiiq
 FOVdy/kFG3L8bf9+X+xTClSZpfTiyVaYo7jUIL8ODHs3fBNPHYlMymkEkYAx+ed40SJSxMCtsq
 iQcPKuXeZuE9uwL6Ch8szpbqYEoX43Dq+biX3Mc9j+tkqF6jTf74vwAW31jutQhuaRlzjMNP9E
 8dH/XkAOrABHELrvNmB2rrIoyZZoALdWVTGeSF/Q3UEVYECWtsZCI09/2nUR1AXqBvvrYAA6kx
 7uK7rG4kt3TyVAQAA
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Shiju Jose <shiju.jose@huawei.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2539e
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702335462; l=3170;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=pO1ltlMpojjEdRLLW5K+Kn7C7Cek0sghm6CntoFK3oI=;
 b=SGExsRHARsdJSNSh8Vhtqr61v6kjA69hsRkf6R2HYSSQ0RyFqjUcpIzINcVKaLlBVdbqwty5a
 khN3+IaD5+yAYmMam5CHJsgSUdyIX7e4ehHJ5zFpUdHmW28e6RKf5gl
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series status/background
========================

Smita has been a great help with this series.  This includes testing the
last RFC version.[1]

Unfortunately, Dan had a better idea for how to register the call
between the efi and cxl subsystems so this is reworked for V2.

[1] https://lore.kernel.org/all/7ec6d2af-c860-9b05-7eaf-c82f50f8e66e@amd.com/

Cover letter
============

CXL Component Events, as defined by EFI 2.10 Section N.2.14, wrap a
mostly CXL event payload in an EFI Common Platform Error Record (CPER)
record.  If a device is configured for firmware first CXL event records
are not sent directly to the host.

The CXL sub-system uniquely has DPA to HPA translation information.  It
also already has event format tracing.  Restructure the code to make
sharing the data between CPER/event logs most efficient.  Then send the
CXL CPER records to the CXL sub-system for processing.

With event logs the events interrupt the driver directly.  In the EFI
case events are wrapped with device information which allows the CXL
subsystem to identify the PCI device.

Previous version considered matching the memdev differently.  However,
the most robust was to find the PCI device via Bus, Device, Function and
use the PCI device to find the driver data.

CPER records are identified with GUID's while CXL event logs contain
UUID's.  The UUID is reported for all events.  While the UUID is
redundant for the known events the UUID's are already used by rasdaemon.
To keep compatibility UUIDs are injected for CPER records based on the
record type.

In addition this series cleans up the UUID defines used between the
event processing and cxl_test code.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v2:
- djbw: Clarify GUID defines
- djbw: Clarify UUID defines
- djbw: Use a single event callback to the CXL subsystem
- iweiny: Minor function name clean ups
- Link to v1: https://lore.kernel.org/r/20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com

---
Ira Weiny (7):
      cxl/trace: Pass uuid explicitly to event traces
      cxl/events: Promote CXL event structures to a core header
      cxl/events: Create common event UUID defines
      cxl/events: Separate UUID from event structures
      cxl/events: Create a CXL event union
      firmware/efi: Process CXL Component Events
      cxl/memdev: Register for and process CPER events

 drivers/cxl/core/mbox.c         |  77 ++++++++++---------
 drivers/cxl/core/trace.h        |  32 ++++----
 drivers/cxl/cxlmem.h            | 112 +++++++--------------------
 drivers/cxl/pci.c               |  52 ++++++++++++-
 drivers/firmware/efi/cper.c     |  15 ++++
 drivers/firmware/efi/cper_cxl.c |  45 +++++++++++
 drivers/firmware/efi/cper_cxl.h |  29 +++++++
 include/linux/cxl-event.h       | 162 +++++++++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/mem.c    | 163 +++++++++++++++++++++++-----------------
 9 files changed, 481 insertions(+), 206 deletions(-)
---
base-commit: 7475e51b87969e01a6812eac713a1c8310372e8a
change-id: 20230601-cxl-cper-26ffc839c6c6

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

