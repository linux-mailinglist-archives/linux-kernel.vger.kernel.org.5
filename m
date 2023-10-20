Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AD27D1614
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjJTTGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjJTTGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:06:44 -0400
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D67D4C;
        Fri, 20 Oct 2023 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4452; q=dns/txt; s=iport;
  t=1697828802; x=1699038402;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9l3dSsTvvZfV8JUBYN7y8Zw37fngkVNXc2D/Q3qS+g4=;
  b=daPW+uIESRR7N3kDvpeDtr47pWq4N4B8YD/H0EJF9HzBSFtb/g1696Qj
   L2uUez9vey8rNboQAM7QAPouGKu1XlcMRW2YrgJ6q1eS1W2RQshGF7Tcw
   yHNRmrW5vcVZrBOZEmvtRfm/sNlB5W3eQXDkhGFF6cwTyrS+h6+Y4wE7r
   c=;
X-CSE-ConnectionGUID: GsJSq0vWRE+oyo7RfNDLcg==
X-CSE-MsgGUID: 5qtjj0wzT8u/nxMHxjC7kg==
X-IronPort-AV: E=Sophos;i="6.03,239,1694736000"; 
   d="scan'208";a="127259641"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 19:06:41 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPSA id 39KJ6XPC026372
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 Oct 2023 19:06:40 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH 00/13] Introduce support for multiqueue (MQ) in 
Date:   Fri, 20 Oct 2023 12:06:16 -0700
Message-Id: <20231020190629.338623-1-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-11.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

This cover letter describes the feature: add support for multiqueue (MQ) 
to fnic driver.

Background: The Virtual Interface Card (VIC) firmware exposes several 
queues that can be configured for sending IOs and receiving IO 
responses. Unified Computing System Manager (UCSM) and Intersight 
Manager (IMM) allows users to configure the number of queues to be 
used for IOs.

The number of IO queues to be used is stored in a configuration file 
by the VIC firmware. The fNIC driver reads the configuration file and sets
the number of queues to be used. Previously, the driver was hard-coded
to use only one queue. With this set of changes, the fNIC driver will 
configure itself to use multiple queues. This feature takes advantage of 
the block multiqueue layer to parallelize IOs being sent out of the VIC
card.

Here's a brief description of some of the salient patches:

- vnic_scsi.h needs to be in sync with VIC firmware to be able to read 
the number of queues from the firmware config file. A patch has been 
created for this.
- In an environment with many fnics (like we see in our customer 
environments), it is hard to distinguish which fnic is printing logs. 
Therefore, an fnic number has been included in the logs.
- read the number of queues from the firmware config file.
- include definitions in fnic.h to support multiqueue.
- modify the interrupt service routines (ISRs) to read from the 
correct registers. The numbers that are used here come from discussions 
with the VIC firmware team.
- track IO statistics for different queues.
- remove usage of host_lock, and only use fnic_lock in the fnic driver.
- use a hardware queue based spinlock to protect io_req.
- replace the hard-coded zeroth queue with a hardware queue number. 
This presents a bulk of the changes.
- modify the definition of fnic_queuecommand to accept multiqueue tags.
- improve log messages, and indicate fnic number and multiqueue tags for
effective debugging.

Even though the patches have been made into a series, some patches are 
heavier than others.
But, every effort has been made to keep the purpose of each patch as 
a single-purpose, and to compile cleanly.

This patchset has been tested as a whole. Therefore, the tested-by fields
have been added only to the last two patches
in the set. All the individual patches compile cleanly. However, 
I've refrained from adding tested-by to
most of the patches, so as to not mislead the reviewer/reader.

A brief note on the unit tests:

1. Increase number of queues to 64. Load driver. Run IOs via Medusa. 
12+ hour run successful.
2. Configure multipathing, and run link flaps on single link. 
IOs drop briefly, but pick up as expected.
3. Configure multipathing, and run link flaps on two links, with a 
30 second delay in between. IOs drop briefly, but pick up as expected.

Repeat the above tests with single queue. All tests were successful.

Please consider this patch series for the next merge window.

Thanks and regards,
Karan

Karan Tilak Kumar (13):
  scsi: fnic: Modify definitions to sync with VIC firmware
  scsi: fnic: Add and use fnic number
  scsi: fnic: Add and improve log messages
  scsi: fnic: Rename wq_copy to hw_copy_wq
  scsi: fnic: Get copy workqueue count and interrupt mode from config
  scsi: fnic: Refactor and redefine fnic.h for multiqueue
  scsi: fnic: Modify ISRs to support multiqueue(MQ)
  scsi: fnic: Define stats to track multiqueue (MQ) IOs
  scsi: fnic: Remove usage of host_lock
  scsi: fnic: Add support for multiqueue (MQ) in fnic_main.c
  scsi: fnic: Use fnic_lock to protect fnic structures in queuecommand
  scsi: fnic: Add support for multiqueue (MQ) in fnic driver
  scsi: fnic: Improve logs and add support for multiqueue (MQ)

 drivers/scsi/fnic/fnic.h         |  41 +-
 drivers/scsi/fnic/fnic_debugfs.c |   2 +-
 drivers/scsi/fnic/fnic_fcs.c     |  36 +-
 drivers/scsi/fnic/fnic_io.h      |   2 +
 drivers/scsi/fnic/fnic_isr.c     | 166 +++++--
 drivers/scsi/fnic/fnic_main.c    | 156 ++++--
 drivers/scsi/fnic/fnic_res.c     |  48 +-
 drivers/scsi/fnic/fnic_scsi.c    | 797 ++++++++++++++++++-------------
 drivers/scsi/fnic/fnic_stats.h   |   3 +
 drivers/scsi/fnic/fnic_trace.c   |  11 +
 drivers/scsi/fnic/vnic_dev.c     |   4 +
 drivers/scsi/fnic/vnic_scsi.h    |  13 +-
 12 files changed, 835 insertions(+), 444 deletions(-)

-- 
2.31.1

