Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DAC7D501F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbjJXMnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjJXMnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:43:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08304122
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698151377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uQvIAHxlIRsODDQvHhHg2yEUAX99/4EQzAeL/zSIx6I=;
        b=b0uKoGGDzFst9h3a5/tEVb8Wh6aabsddsnxZa4XavLu4RIWdUbDAKw5hz8De8uUIRoI9dt
        dGQMXnbScg9UhgDOssRNyF7VdXWzbrX3SqU48WuGu/UvMm8W0LOtdjITlslCCTv6bLiruJ
        7wk9mUDYlmCcrsr5d0XvF7th1SkCrsY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-14QY-GXoMf2RcfJKXAovzg-1; Tue, 24 Oct 2023 08:42:51 -0400
X-MC-Unique: 14QY-GXoMf2RcfJKXAovzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61162811E7E;
        Tue, 24 Oct 2023 12:42:51 +0000 (UTC)
Received: from p1.luc.com (unknown [10.43.2.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFFE32166B26;
        Tue, 24 Oct 2023 12:42:49 +0000 (UTC)
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
Subject: [PATCH 2/2] i40e: Fix devlink port unregistering
Date:   Tue, 24 Oct 2023 14:42:45 +0200
Message-ID: <20231024124245.837908-2-ivecera@redhat.com>
In-Reply-To: <20231024124245.837908-1-ivecera@redhat.com>
References: <20231024124245.837908-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that devlink port is unregistered after unregistering
of net device.

Reproducer:
[root@host ~]# rmmod i40e
[ 4742.939386] i40e 0000:02:00.1: i40e_ptp_stop: removed PHC on enp2s0f1np1
[ 4743.059269] ------------[ cut here ]------------
[ 4743.063900] WARNING: CPU: 21 PID: 10766 at net/devlink/port.c:1078 devl_port_unregister+0x69/0x80
...

Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index df058540d277..3f396c100835 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14181,8 +14181,7 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
 	}
 	set_bit(__I40E_VSI_RELEASING, vsi->state);
 	uplink_seid = vsi->uplink_seid;
-	if (vsi->type == I40E_VSI_MAIN)
-		i40e_devlink_destroy_port(pf);
+
 	if (vsi->type != I40E_VSI_SRIOV) {
 		if (vsi->netdev_registered) {
 			vsi->netdev_registered = false;
@@ -14196,6 +14195,9 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
 		i40e_vsi_disable_irq(vsi);
 	}
 
+	if (vsi->type == I40E_VSI_MAIN)
+		i40e_devlink_destroy_port(pf);
+
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 
 	/* clear the sync flag on all filters */
@@ -14370,14 +14372,14 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 
 err_rings:
 	i40e_vsi_free_q_vectors(vsi);
-	if (vsi->type == I40E_VSI_MAIN)
-		i40e_devlink_destroy_port(pf);
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
 		free_netdev(vsi->netdev);
 		vsi->netdev = NULL;
 	}
+	if (vsi->type == I40E_VSI_MAIN)
+		i40e_devlink_destroy_port(pf);
 	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
 err_vsi:
 	i40e_vsi_clear(vsi);
-- 
2.41.0

