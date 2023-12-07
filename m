Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B2C807F60
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjLGDt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLGDty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:49:54 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BDBD5C;
        Wed,  6 Dec 2023 19:49:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vy-Kv.7_1701920994;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy-Kv.7_1701920994)
          by smtp.aliyun-inc.com;
          Thu, 07 Dec 2023 11:49:56 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, raspl@linux.ibm.com,
        schnelle@linux.ibm.com, guangguan.wang@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/9] net/smc: implement SMCv2.1 virtual ISM device support
Date:   Thu,  7 Dec 2023 11:49:45 +0800
Message-Id: <1701920994-73705-1-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Note that this patch set depends on an under-reviewing bugfix patch:
Link: https://lore.kernel.org/netdev/1701882157-87956-1-git-send-email-guwen@linux.alibaba.com/)

The fourth edition of SMCv2 adds the SMC version 2.1 feature updates for
SMC-Dv2 with virtual ISM. Virtual ISM are created and supported mainly by
OS or hypervisor software, comparable to IBM ISM which is based on platform
firmware or hardware.

With the introduction of virtual ISM, SMCv2.1 makes some updates:

- Introduce feature bitmask to indicate supplemental features.
- Reserve a range of CHIDs for virtual ISM.
- Support extended GIDs (128 bits) in CLC handshake.

So this patch set aims to implement these updates in Linux kernel. And it
acts as the first part of SMC-D virtual ISM extension & loopback-ism [1].

[1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/

v4->v3:
- Using SMCD_CLC_MAX_V2_GID_ENTRIES to indicate the max gid entries
  in CLC proposal and using SMC_MAX_V2_ISM_DEVS to indicate the max
  devices to propose;
- Using i and i+1 in smc_find_ism_v2_device_serv();
- Replacing the large if-else block in smc_clc_send_confirm_accept()
  with 2 subfunctions;
- Fixing missing byte order conversion of GID and token in CLC handshake,
  which is in a separate patch sending to net:
  https://lore.kernel.org/netdev/1701882157-87956-1-git-send-email-guwen@linux.alibaba.com/
- Adding extended GID in SMC-D lgr netlink attribute;

v3->v2:
- Rename smc_clc_fill_fce as smc_clc_fill_fce_v2x;
- Remove ISM_IDENT_MASK from drivers/s390/net/ism.h;
- Add explicitly assigning 'false' to ism_v2_capable in ism_dev_init();
- Remove smc_ism_set_v2_capable() helper for now, and introduce it in
  later loopback-ism implementation;

v2->v1:
- Fix sparse complaint;
- Rebase to the latest net-next;

Wen Gu (9):
  net/smc: Rename some 'fce' to 'fce_v2x' for clarity
  net/smc: introduce sub-functions for smc_clc_send_confirm_accept()
  net/smc: support SMCv2.x supplemental features negotiation
  net/smc: introduce virtual ISM device support feature
  net/smc: define a reserved CHID range for virtual ISM devices
  net/smc: compatible with 128-bits extend GID of virtual ISM device
  net/smc: disable SEID on non-s390 archs where virtual ISM may be used
  net/smc: manage system EID in SMC stack instead of ISM driver
  net/smc: support extended GID in SMC-D lgr netlink attribute

 drivers/s390/net/ism.h        |   7 --
 drivers/s390/net/ism_drv.c    |  57 +++------
 include/linux/ism.h           |   1 -
 include/net/smc.h             |  16 ++-
 include/uapi/linux/smc.h      |   2 +
 include/uapi/linux/smc_diag.h |   2 +
 net/smc/af_smc.c              |  68 +++++++++--
 net/smc/smc.h                 |  10 +-
 net/smc/smc_clc.c             | 278 +++++++++++++++++++++++++++---------------
 net/smc/smc_clc.h             |  27 ++--
 net/smc/smc_core.c            |  37 ++++--
 net/smc/smc_core.h            |  18 ++-
 net/smc/smc_diag.c            |   9 +-
 net/smc/smc_ism.c             |  50 +++++---
 net/smc/smc_ism.h             |  30 ++++-
 net/smc/smc_pnet.c            |   4 +-
 16 files changed, 403 insertions(+), 213 deletions(-)

-- 
1.8.3.1

