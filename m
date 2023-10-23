Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB937D3C94
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjJWQbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjJWQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844A9100
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698078598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vUKxPOoWV9B5U7uvi2XDDGj+trRuDSgbS765fvrE7hM=;
        b=NwZc8wv9FUozwGHoU7BX0RMrdQPMo9bSWejLyZz8k5RSJg8wQ7ggHl0KY9QsmgUt//ry9y
        5RGcK8uIaoV/OGHvBBJaUzztftx2A/oAmUZRQAoq16mJm84Xw82/yONkLt5sTa89CK2kih
        0sDJuOIDwwLVCLdfNe1ZjCaRb3X+XzU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-tZq6VPX4Mye2f5hKABNMOQ-1; Mon,
 23 Oct 2023 12:29:47 -0400
X-MC-Unique: tZq6VPX4Mye2f5hKABNMOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 443E93827967;
        Mon, 23 Oct 2023 16:29:31 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 528C325C0;
        Mon, 23 Oct 2023 16:29:29 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>, mschmidt@redhat.com,
        dacampbe@redhat.com, poros@redhat.com
Subject: [PATCH iwl-next 0/3] i40e: Add and use version check helpers
Date:   Mon, 23 Oct 2023 18:29:25 +0200
Message-ID: <20231023162928.245583-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series moves an existing check for AQ API version to header file,
adds another ones for firmware version check and use them to refactor
existing open-coded version checks.

Series content:
Patch 1: Moves i40e_is_aq_api_ver_ge() helper to header file
Patch 2: Adds another helpers to check running FW version
Patch 3: Re-factors existing open-coded checks to use the new helpers

Ivan Vecera (3):
  i40e: Move i40e_is_aq_api_ver_ge helper
  i40e: Add other helpers to check version of running firmware and AQ API
  i40e: Use helpers to check running FW and AQ API versions

 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 69 +++++++------------
 drivers/net/ethernet/intel/i40e/i40e_common.c | 48 +++++--------
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  7 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 68 ++++++++++++++++++
 5 files changed, 115 insertions(+), 83 deletions(-)

-- 
2.41.0

