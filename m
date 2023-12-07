Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793F2807FB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjLGEgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGEgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:36:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64868D3;
        Wed,  6 Dec 2023 20:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701923778; x=1733459778;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=zD9JVL7KH7q9hrn7MRAVLdgdiV8d1EIq3/KpInC/SHg=;
  b=ewGVWqsZ8K/XXhr4pwSD5vDW/wK8nifmtT5EK2OwsIYsPtbTvfqLb744
   KISErK/eulegxPCsA8hdouJD0EfFREBUVHgH/NXud0bNXeRkLeYVFpqeI
   Gyp8Hlxz/Qp4I1cqI0Olr9IGHuR4ZhjNlObqLO/0QiXcKbF49KNW3lyq8
   BlIqE5Q0wbLeuL18ojCLrJce10qZn10vw+ThfC5+FTRYFsAUGoZx1LHak
   NfWMj0t0F1c9vdMcZ03bbpuZRBqGYkuuFff7Vu1PXdGe0nfJw8ZIm7NVv
   wfVb73Zy3BhOOOblfWY1N65zlhC7Jvy/o1P3GslAzawOSd0EK2pXdrPs+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1053219"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1053219"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 20:36:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="19570373"
Received: from apbrezen-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.213.160.175])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 20:36:16 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 0/2] Add DAX ABI for memmap_on_memory
Date:   Wed, 06 Dec 2023 21:36:13 -0700
Message-Id: <20231206-vv-dax_abi-v2-0-f4f4f2336d08@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL1LcWUC/03MQQ6CMBCF4auQWVvTGRGQlfcwxJQyyiRKTUsaD
 Ondrbhx+b/kfSsE9sIB2mIFz1GCuCkH7Qqwo5nurGTIDaTpgJqOKkY1mOVqelFYG8KTLStdV5A
 PL883WTbs0uUeJczOvzc74nf9MaSrfyai0qqsS+6bhkmjPcs082Nv3RO6lNIHQ+3CpqQAAAA=
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=zD9JVL7KH7q9hrn7MRAVLdgdiV8d1EIq3/KpInC/SHg=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKmF3vtPxt7zFGeepfSHJyv/pff1h2bi3LEL5rld/Fzr1
 tOwY+bBjlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAExkwl1GhpnhrBnWpjr10y0U
 p364cn0Cb7W5/clYfbed03OjdvkLPWNkuKx5fdW1bYIC+WtWpnY7tSyKWup675q1/rVfs5vvW+4
 XZgUA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DAX drivers were missing sysfs ABI documentation entirely.  Add this
missing documentation for the sysfs ABI for DAX regions and Dax devices
in patch 1. Add a new ABI for toggling memmap_on_memory semantics in
patch 2.

The missing ABI was spotted in [1], this series is a split of the new
ABI additions behind the initial documentation creation.

[1]: https://lore.kernel.org/linux-cxl/651f27b728fef_ae7e7294b3@dwillia2-xfh.jf.intel.com.notmuch/

Cc: Dan Williams <dan.j.williams@intel.com>
Cc:  <linux-kernel@vger.kernel.org>
Cc:  <nvdimm@lists.linux.dev>
Cc:  <linux-cxl@vger.kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Changes in v2:
- Fix CC lists, patch 1/2 didn't get sent correctly in v1
- Link to v1: https://lore.kernel.org/r/20231206-vv-dax_abi-v1-0-474eb88e201c@intel.com

---
Vishal Verma (2):
      Documentatiion/ABI: Add ABI documentation for sys-bus-dax
      dax: add a sysfs knob to control memmap_on_memory behavior

 drivers/dax/bus.c                       |  40 ++++++++
 Documentation/ABI/testing/sysfs-bus-dax | 164 ++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+)
---
base-commit: c4e1ccfad42352918810802095a8ace8d1c744c9
change-id: 20231025-vv-dax_abi-17a219c46076

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

