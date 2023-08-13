Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8122677A9BC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbjHMQRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjHMQQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:16:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD48A49C9;
        Sun, 13 Aug 2023 09:16:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C11D263B7F;
        Sun, 13 Aug 2023 16:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B070C433C8;
        Sun, 13 Aug 2023 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691943286;
        bh=Dcwc41CO/eB9pJwSHXN9zI43GutmR5tY9l7XN/s+x/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KKhKqgpOzIBl8UBrlXCVUSMgNtr9S68Kb/O7CH0YjtlGUnKqARofSHlpXKpPhJLqY
         Pnx+NRVyeWLNo0rj0EsyHnKT2lif1aVZMexjTZe1Lh/nqCClWN2UsbSJGVC4WFLauj
         TrOa4C9VVAAT15Uk1IlKX3rTvxi5RNvfhqZymtsZOvcDiD9SOKRq7HIJGJ5hPMUbaj
         +eheg3VWfp+ZkhvXEAFqgQ92zpsfvnXovfEImv0U78uVWKm4sUL7PzOCIff66dHQV7
         RPR2G9/GiIf1fxu0YIrYJd/v9e92sYlxeO66ySvAKv3mEkIsaSkM3yQ8GTtnFWvGsY
         b3Kw5Kpb28Qgw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 4/9] vxlan: generalize vxlan_parse_gpe_hdr and remove unused args
Date:   Sun, 13 Aug 2023 12:14:22 -0400
Message-Id: <20230813161427.1089101-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813161427.1089101-1-sashal@kernel.org>
References: <20230813161427.1089101-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.322
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Benc <jbenc@redhat.com>

[ Upstream commit 17a0a64448b568442a101de09575f81ffdc45d15 ]

The vxlan_parse_gpe_hdr function extracts the next protocol value from
the GPE header and marks GPE bits as parsed.

In order to be used in the next patch, split the function into protocol
extraction and bit marking. The bit marking is meaningful only in
vxlan_rcv; move it directly there.

Rename the function to vxlan_parse_gpe_proto to reflect what it now
does. Remove unused arguments skb and vxflags. Move the function earlier
in the file to allow it to be called from more places in the next patch.

Signed-off-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan.c | 58 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 31657f15eb071..52aa32d7e4c5c 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -542,6 +542,32 @@ static int vxlan_fdb_append(struct vxlan_fdb *f,
 	return 1;
 }
 
+static bool vxlan_parse_gpe_proto(struct vxlanhdr *hdr, __be16 *protocol)
+{
+	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)hdr;
+
+	/* Need to have Next Protocol set for interfaces in GPE mode. */
+	if (!gpe->np_applied)
+		return false;
+	/* "The initial version is 0. If a receiver does not support the
+	 * version indicated it MUST drop the packet.
+	 */
+	if (gpe->version != 0)
+		return false;
+	/* "When the O bit is set to 1, the packet is an OAM packet and OAM
+	 * processing MUST occur." However, we don't implement OAM
+	 * processing, thus drop the packet.
+	 */
+	if (gpe->oam_flag)
+		return false;
+
+	*protocol = tun_p_to_eth_p(gpe->next_protocol);
+	if (!*protocol)
+		return false;
+
+	return true;
+}
+
 static struct vxlanhdr *vxlan_gro_remcsum(struct sk_buff *skb,
 					  unsigned int off,
 					  struct vxlanhdr *vh, size_t hdrlen,
@@ -1278,35 +1304,6 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
 	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
 }
 
-static bool vxlan_parse_gpe_hdr(struct vxlanhdr *unparsed,
-				__be16 *protocol,
-				struct sk_buff *skb, u32 vxflags)
-{
-	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)unparsed;
-
-	/* Need to have Next Protocol set for interfaces in GPE mode. */
-	if (!gpe->np_applied)
-		return false;
-	/* "The initial version is 0. If a receiver does not support the
-	 * version indicated it MUST drop the packet.
-	 */
-	if (gpe->version != 0)
-		return false;
-	/* "When the O bit is set to 1, the packet is an OAM packet and OAM
-	 * processing MUST occur." However, we don't implement OAM
-	 * processing, thus drop the packet.
-	 */
-	if (gpe->oam_flag)
-		return false;
-
-	*protocol = tun_p_to_eth_p(gpe->next_protocol);
-	if (!*protocol)
-		return false;
-
-	unparsed->vx_flags &= ~VXLAN_GPE_USED_BITS;
-	return true;
-}
-
 static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 			  struct vxlan_sock *vs,
 			  struct sk_buff *skb, __be32 vni)
@@ -1408,8 +1405,9 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	 * used by VXLAN extensions if explicitly requested.
 	 */
 	if (vs->flags & VXLAN_F_GPE) {
-		if (!vxlan_parse_gpe_hdr(&unparsed, &protocol, skb, vs->flags))
+		if (!vxlan_parse_gpe_proto(&unparsed, &protocol))
 			goto drop;
+		unparsed.vx_flags &= ~VXLAN_GPE_USED_BITS;
 		raw_proto = true;
 	}
 
-- 
2.40.1

