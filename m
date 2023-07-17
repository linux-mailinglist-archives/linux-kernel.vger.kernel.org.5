Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C43755FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjGQKAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjGQKAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:00:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB28A10D3;
        Mon, 17 Jul 2023 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689588003; x=1721124003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0/4YfnWj7uZZvcBnfx2vVS2SmTppJGml5QU6wI2Ls2E=;
  b=ec1w6SSpDWjz2aQ6KbmuzXoz1RtMxP15rwtZgJ7yJQbQt0h0VaWngsr8
   GtiNcHv3a+e01j4jD1N91FWj38kdA1No1zQdTmZ7c7QA6wy3tUc1+YQIp
   1aotsNHOHBrTDWMXGIKxCNVaXPhvMgKMxozfQt5gm5KhefWG1ufHJPDGd
   karlOB+mYgEopeqjmn10kgdM2eEv6jOb1nhLzFXOjr1ak7a4I4TQF9iWf
   c3FPDo+8mTa8DeV/IJ9dt7p/IV90xVIiIodhrqeosqZI1KqKglbFItNgu
   Z4B3sC+5hdcujYZI0qvSq3Lwkz6LR+vO1D0JtHV70/nL8/8DFW22EUl2R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="452264270"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="452264270"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 03:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="788595459"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="788595459"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2023 03:00:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 82458256; Mon, 17 Jul 2023 13:00:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Steve French <stfrench@microsoft.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] smb: client: Rework memcpy() to avoid compilation error
Date:   Mon, 17 Jul 2023 13:00:03 +0300
Message-Id: <20230717100003.11824-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function ‘fortify_memcpy_chk’,
    inlined from ‘CIFS_open’ at fs/smb/client/cifssmb.c:1249:3:
include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
  592 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Instead of memcpy() use member-by-member copy. Let compiler do its job
on optimisation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/smb/client/cifssmb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 9dee267f1893..33ebb63826d3 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1245,8 +1245,11 @@ CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
 		*oplock |= CIFS_CREATE_ACTION;
 
 	if (buf) {
-		/* copy from CreationTime to Attributes */
-		memcpy((char *)buf, (char *)&rsp->CreationTime, 36);
+		buf->CreationTime = rsp->CreationTime;
+		buf->LastAccessTime = rsp->LastAccessTime;
+		buf->LastWriteTime = rsp->LastWriteTime;
+		buf->ChangeTime = rsp->ChangeTime;
+		buf->FileAttributes = rsp->FileAttributes;
 		/* the file_info buf is endian converted by caller */
 		buf->AllocationSize = rsp->AllocationSize;
 		buf->EndOfFile = rsp->EndOfFile;
-- 
2.40.0.1.gaa8946217a0b

