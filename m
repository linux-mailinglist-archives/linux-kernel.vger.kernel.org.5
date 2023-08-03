Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFA376F38E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjHCTjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjHCTjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:39:40 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B7F3C3E;
        Thu,  3 Aug 2023 12:39:31 -0700 (PDT)
Received: from localhost.ispras.ru (unknown [10.10.165.2])
        by mail.ispras.ru (Postfix) with ESMTPSA id 4FF354076751;
        Thu,  3 Aug 2023 19:39:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4FF354076751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1691091567;
        bh=5Qgf85sJxo24YJ/Hz2w1q6OVVERRFRhFo/X+eWoRL8k=;
        h=From:To:Cc:Subject:Date:From;
        b=rwGA+VwVp+9ulZMMPmsbTKsPCc0swFojp0FahGfB95yHdgb6ubrweROfarleU602L
         FnGZ+B9/O3IbRCWTyOiXr/GqEhTjzzmKQogBgR2Z6j3fWl9wzxxK4C4oS0lRiVZAVu
         zsWxlc6snIO4LGbc3gOxJvE0/NQ0DhTzLN+xxx/g=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Roopa Prabhu <roopa@nvidia.com>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH] drivers: vxlan: vnifilter: free percpu vni stats on error path
Date:   Thu,  3 Aug 2023 22:38:32 +0300
Message-ID: <20230803193834.23340-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case rhashtable_lookup_insert_fast() fails inside vxlan_vni_add(), the
allocated percpu vni stats are not freed on the error path.

Free them on the rhashtable_lookup_insert_fast() error path in
vxlan_vni_add().

Found by Linux Verification Center (linuxtesting.org).

Fixes: 4095e0e1328a ("drivers: vxlan: vnifilter: per vni stats")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index a3de081cda5e..321cd0b450cc 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -740,6 +740,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 					    &vninode->vnode,
 					    vxlan_vni_rht_params);
 	if (err) {
+		free_percpu(vninode->stats);
 		kfree(vninode);
 		return err;
 	}
-- 
2.41.0

