Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7107D504F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbjJXMwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjJXMwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839F890
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698151880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q8xEvrw5kPl+Kn6m0vz2m9HYGcHh0NovL+ylnmM6Mjc=;
        b=PFReqZwzdA7mD+0K/rC3Av/1E+rX/mYLNERU3o2XHQaFMrVWN5cua2ZCv6IP84NI5xcReV
        tSQ1VziLdAW2MXBWMY+QSK7PXSyBvL3pygg32cnvaLmogcMduw2zCTQSoClJlMIdXrj9H/
        Aj0XYD4qhYxMSbBCGZCsdEQ3wbgeSvg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-tXnH1RsiM6Clwt0Q6F78EA-1; Tue, 24 Oct 2023 08:51:12 -0400
X-MC-Unique: tXnH1RsiM6Clwt0Q6F78EA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E336088CC4D;
        Tue, 24 Oct 2023 12:51:11 +0000 (UTC)
Received: from p1.luc.com (unknown [10.43.2.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DC568C0A;
        Tue, 24 Oct 2023 12:51:10 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 1/2] i40e: Do not call devlink_port_type_clear()
Date:   Tue, 24 Oct 2023 14:51:08 +0200
Message-ID: <20231024125109.844045-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not call devlink_port_type_clear() prior devlink port unregister
and let devlink core to take care about it.

Reproducer:
[root@host ~]# rmmod i40e
[ 4539.964699] i40e 0000:02:00.0: devlink port type for port 0 cleared without a software interface reference, device type not supported by the kernel?
[ 4540.319811] i40e 0000:02:00.1: devlink port type for port 1 cleared without a software interface reference, device type not supported by the kernel?

Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_devlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index 74bc111b4849..cc4e9e2addb7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -231,6 +231,5 @@ int i40e_devlink_create_port(struct i40e_pf *pf)
  **/
 void i40e_devlink_destroy_port(struct i40e_pf *pf)
 {
-	devlink_port_type_clear(&pf->devlink_port);
 	devlink_port_unregister(&pf->devlink_port);
 }
-- 
2.41.0

