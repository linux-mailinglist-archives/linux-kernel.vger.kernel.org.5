Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21507D4994
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjJXINF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjJXINE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1137E99
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698135140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M4KgBKcWnOf+HdfkmOB81ZgiYiCuChuxsC6xnZ9eoT8=;
        b=bTU90w113xYeBiYVUg5N32q7w+IAMf2gkWePy47mOuutuniySuNAvn2ob86UUK5oq8cqOl
        C6IvOxoO1oaVZ5hfe/uz8Sbif++Uo5dx2Ozgq1Sb9CIfeaGC8n3xCPeU0F/Hptxia+cZxq
        Ys4Ii9toQ6HKg3WJgNta1ZPbZh9erxU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-yxYj-cPHOz2shsJQt_URWg-1; Tue, 24 Oct 2023 04:12:16 -0400
X-MC-Unique: yxYj-cPHOz2shsJQt_URWg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D73231019C86;
        Tue, 24 Oct 2023 08:12:15 +0000 (UTC)
Received: from p1.luc.com (unknown [10.43.2.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC239492BFB;
        Tue, 24 Oct 2023 08:12:13 +0000 (UTC)
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
Subject: [PATCH iwl-next v2 0/3] i40e: Add and use version check helpers
Date:   Tue, 24 Oct 2023 10:12:08 +0200
Message-ID: <20231024081211.677502-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Changes:
v2 - Fixed indentation

Ivan Vecera (3):
  i40e: Move i40e_is_aq_api_ver_ge helper
  i40e: Add other helpers to check version of running firmware and AQ API
  i40e: Use helpers to check running FW and AQ API versions

 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 56 ++++++---------
 drivers/net/ethernet/intel/i40e/i40e_common.c | 48 +++++--------
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  7 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 68 +++++++++++++++++++
 5 files changed, 108 insertions(+), 77 deletions(-)

-- 
2.41.0

