Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53937F435D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbjKVKQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjKVKP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:15:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399E2100
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700648153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zZArOzXHsetthpTt+RhsHuPDCYk009th/dGKHGi0hKo=;
        b=F2Yflf3JaJ0VtDO4FY0FEO+B3QUDeljHkMacBLq5Ejbv652x9x+DY1GIdk3P7l0zVlkZ7D
        Z1tN2lKqvJdb3NEg+UI+2gxSlWQFvG3JGPnh599Zw/RH2/59x7NnaCw26ito3qukD14Cs2
        eEcJ6eH5z/J7df3zP3izrHALXj/aj1k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-073jtuxGMvqz5LVNWHK_Lw-1; Wed,
 22 Nov 2023 05:15:49 -0500
X-MC-Unique: 073jtuxGMvqz5LVNWHK_Lw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9BBF280C28A;
        Wed, 22 Nov 2023 10:15:48 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.226.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F54010E46;
        Wed, 22 Nov 2023 10:15:46 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Simon Horman <horms@kernel.org>, mschmidt@redhat.com,
        netdev@vger.kernel.org
Subject: [PATCH iwl-next v4 0/5] i40e: Simplify VSI and VEB handling
Date:   Wed, 22 Nov 2023 11:15:40 +0100
Message-ID: <20231122101545.28819-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series simplifies handling of VSIs and VEBs by introducing for-each
iterating macros, 'find' helper functions. Also removes the VEB
recursion because the VEBs cannot have sub-VEBs according datasheet and
fixes the support for floating VEBs.

The series content:
Patch 1 - Uses existing helper function for find FDIR VSI instead of loop
Patch 2 - Adds and uses macros to iterate VSI and VEB arrays
Patch 3 - Adds 2 helper functions to find VSIs and VEBs by their SEID
Patch 4 - Fixes broken support for floating VEBs
Patch 5 - Removes VEB recursion and simplifies VEB handling

Changelog:
v1->v2 - small correction in patch 4 description
       - changed helper names in patch 3
v2->v3 - correct patch files (v2 was broken)
v3->v4 - added kdoc stuff
       - fixed wrong check in i40e_ndo_bridge_getlink()

Ivan Vecera (5):
  i40e: Use existing helper to find flow director VSI
  i40e: Introduce and use macros for iterating VSIs and VEBs
  i40e: Add helpers to find VSI and VEB by SEID and use them
  i40e: Fix broken support for floating VEBs
  i40e: Remove VEB recursion

 drivers/net/ethernet/intel/i40e/i40e.h        |  93 ++-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  10 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  97 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 563 ++++++++----------
 4 files changed, 373 insertions(+), 390 deletions(-)

-- 
2.41.0

