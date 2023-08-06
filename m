Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC68C77162A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjHFRHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 13:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjHFRHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 13:07:14 -0400
Received: from rs227.mailgun.us (rs227.mailgun.us [209.61.151.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F0F1724
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 10:07:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1691341628; x=1691348828; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=ME2BQZzvkbXBeCZTOVBRw+S+EI7YoawH2uw+GS4l6r4=;
 b=F9mIcov1ZDPTw/wfvuqnUtAbMDdxwKYJ+QcitxxXi/vFREk4ug1e3dwvTvT09AMdCR8ICyb2p57sMZjBsZ3LmYtJEvq3w36p8tOe1GcaP4Sus/LZJdYFtUP/nz7uDt91LrRzkVPYWMWVSRi7itbxl/cqObLDSLBKI58I5UZyP7YNwEypyB/FeXcLUQjrkffqMjln6jEKMFAu81Ife26TqVfgBW8xVq2WwEBBIQygcLAJ2kb8LYR8aWVs63otBwTHPk8+LH2D3FK1nyojajqVsdqeW4WfxKMR8bbPVPypYPqhVxCAVDFo8FadCUcm8DCf5wOypOLIA2a2/yqd5uKlig==
X-Mailgun-Sending-Ip: 209.61.151.227
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 23c02243ea3c with SMTP id
 64cfd33a89833227aa739bb6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 06 Aug 2023 17:07:06 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     James Seo <james@equiv.tech>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/12] scsi: mpt3sas: Use flexible arrays and do a few cleanups
Date:   Sun,  6 Aug 2023 10:05:52 -0700
Message-Id: <20230806170604.16143-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") has
resulted in the only arrays that UBSAN_BOUNDS considers unbounded
being trailing arrays declared with [] as the last member of a
struct. Unbounded trailing arrays declared with [1] are common in
mpt3sas, which is causing spurious warnings to appear in some
situations, e.g. when more than one physical disk is connected:

  UBSAN: array-index-out-of-bounds in drivers/scsi/mpt3sas/mpt3sas_scsih.c:6810:36
  index 1 is out of range for type 'MPI2_SAS_IO_UNIT0_PHY_DATA [1]'

which relates to this unbounded array access:

  port_id = sas_iounit_pg0->PhyData[i].Port;

and is just one example of 10 similar warnings currently occurring
for me during boot.

This series converts most trailing arrays declared with [1] in mptsas
into proper C99 flexible array members. Those that are not unbounded
and really are fixed-length arrays of length 1 are left alone.

I didn't find any conversions that required further source edits
besides changing [1] to [], and everything seems to work with my
SAS2008-based add-in card, but please look things over in case I
missed something subtle.

Rounding out the series are some opportunistic cleanups.

The only dependency is that patch 7 ("Use struct_size() for struct
size calculations") depends on patches 3-5.

History:
v1: https://lore.kernel.org/linux-scsi/20230725161331.27481-1-james@equiv.tech/

Changes v1->v2:
- Slightly reword and add Reviewed-by: tags to commit messages
- Split up a commit that was resulting in many binary changes
- Remove the iounit_pg8 member of the per-adapter struct
- Replace more dynamic allocations with local variables

James Seo (12):
  scsi: mpt3sas: Use flexible arrays when obviously possible
  scsi: mpt3sas: Make MPI2_CONFIG_PAGE_IO_UNIT_8::Sensor[] a flexible
    array
  scsi: mpt3sas: Make MPI2_CONFIG_PAGE_RAID_VOL_0::PhysDisk[] a flexible
    array
  scsi: mpt3sas: Make MPI2_CONFIG_PAGE_SASIOUNIT_0::PhyData[] a flexible
    array
  scsi: mpt3sas: Make MPI2_CONFIG_PAGE_SASIOUNIT_1::PhyData[] a flexible
    array
  scsi: mpt3sas: Make MPI26_CONFIG_PAGE_PIOUNIT_1::PhyData[] a flexible
    array
  scsi: mpt3sas: Use struct_size() for struct size calculations
  scsi: mpt3sas: Remove the iounit_pg8 member of the per-adapter struct
  scsi: mpt3sas: Fix an outdated comment
  scsi: mpt3sas: Fix typo of "TRIGGER"
  scsi: mpt3sas: Replace a dynamic allocation with a local variable
  scsi: mpt3sas: Replace dynamic allocations with local variables

 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h         | 231 ++++++-------------
 drivers/scsi/mpt3sas/mpi/mpi2_image.h        |  32 +--
 drivers/scsi/mpt3sas/mpi/mpi2_ioc.h          |  27 +--
 drivers/scsi/mpt3sas/mpt3sas_base.c          |  35 ++-
 drivers/scsi/mpt3sas/mpt3sas_base.h          |   2 -
 drivers/scsi/mpt3sas/mpt3sas_config.c        |   6 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c         |  55 ++---
 drivers/scsi/mpt3sas/mpt3sas_transport.c     |   9 +-
 drivers/scsi/mpt3sas/mpt3sas_trigger_pages.h |  44 ++--
 drivers/scsi/mpt3sas/mpt3sas_warpdrive.c     |   3 +-
 10 files changed, 151 insertions(+), 293 deletions(-)


base-commit: 6cae9a3910ac1b5daf5ac3db9576b78cc4eff5aa
-- 
2.39.2

