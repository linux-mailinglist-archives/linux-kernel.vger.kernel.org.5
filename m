Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33517AF2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbjIZS2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjIZS2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE261AD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695752838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OIL/lX3M9ACG53TNjcOTT4lqWkNl4RwNP4dVcowY+VM=;
        b=WTEVBU5hz4rNzA5h+NcKTvm8hrRYwN4fraVyzhNJlgzT+yCnIrOWZ/0EYi2eyfwMVH+yiT
        xEauql3TdvOdcdvWdz+FONG+xKgpl08cOua4TuFZfjcC2mr76RvFwisszz4lMKolDwvEYV
        9vIgjmD2V5mgNvt+AsavUq34Tyy/uVE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-IeSIh1jHN1u1qPk61oaKDA-1; Tue, 26 Sep 2023 14:27:14 -0400
X-MC-Unique: IeSIh1jHN1u1qPk61oaKDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F2D41C06532;
        Tue, 26 Sep 2023 18:27:13 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE88E40C6EA8;
        Tue, 26 Sep 2023 18:27:11 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     poros@redhat.com, mschmidt@redhat.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/9] i40e: House-keeping and clean-up
Date:   Tue, 26 Sep 2023 20:27:01 +0200
Message-ID: <20230926182710.2517901-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series makes some house-keeping tasks on i40e driver:

Patch 1: Removes unnecessary back pointer from i40e_hw
Patch 2: Moves I40E_MASK macro to i40e_register.h where is used
Patch 3: Refactors I40E_MDIO_CLAUSE* to use the common macro
Patch 4: Add header dependencies to <linux/avf/virtchnl.h>
Patch 5: Removes circular header deps, fixes and cleans headers
Patch 6: Moves DDP specific macros and structs to i40e_ddp.c
Patch 7: Moves mem alloc structures to i40e_alloc.h
Patch 8: Splits i40e_osdep.h to i40e_debug.h and i40e_io.h
Patch 9: Simplifies memory alloction functions

 drivers/net/ethernet/intel/i40e/i40e.h        | 75 +++++--------------
 drivers/net/ethernet/intel/i40e/i40e_adminq.c |  9 +--
 drivers/net/ethernet/intel/i40e/i40e_adminq.h |  3 +-
 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |  3 +
 drivers/net/ethernet/intel/i40e/i40e_alloc.h  | 24 +++---
 drivers/net/ethernet/intel/i40e/i40e_client.c |  1 -
 drivers/net/ethernet/intel/i40e/i40e_common.c | 12 ++-
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  5 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_ddp.c    | 24 +++++-
 drivers/net/ethernet/intel/i40e/i40e_debug.h  | 50 +++++++++++++
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_diag.c   |  1 +
 drivers/net/ethernet/intel/i40e/i40e_diag.h   |  5 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.c    | 16 ++--
 drivers/net/ethernet/intel/i40e/i40e_hmc.h    |  4 +
 drivers/net/ethernet/intel/i40e/i40e_io.h     | 16 ++++
 .../net/ethernet/intel/i40e/i40e_lan_hmc.c    |  9 +--
 .../net/ethernet/intel/i40e/i40e_lan_hmc.h    |  2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 57 ++++++++------
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  3 +
 drivers/net/ethernet/intel/i40e/i40e_osdep.h  | 59 ---------------
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  9 ++-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c    |  3 +-
 .../net/ethernet/intel/i40e/i40e_register.h   |  5 ++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  7 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 +
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 +
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 59 +++------------
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  2 +
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  4 -
 drivers/net/ethernet/intel/i40e/i40e_xsk.h    |  4 +
 include/linux/avf/virtchnl.h                  |  4 +
 35 files changed, 239 insertions(+), 251 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_debug.h
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_io.h
 delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_osdep.h

-- 
2.41.0

