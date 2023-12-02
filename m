Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E42801DAD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjLBQOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBQOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:14:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8136FA2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 08:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701533696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d20ZhiqnGqdkMktjpUNLxnQJIPIANFRSnbo7tB7yeNg=;
        b=CyQXXHDjMRle7eh02tO4/Tdo+UVXgGzySfvCDTDEJSCeN4LHtts65xvgI+7JaagGK70iOo
        vyn+XDIfYbfoe/aXVsRtyaPNhXcdkDH/T/vY+TSnGrXn6ycsFeN2J4KPfE/rJBiUkdYBnl
        DtDbQHrfQOdFC+Mr+N96ECaaY/Xp8cM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-iUP55ek1MZ-Wq4EvSMfO1Q-1; Sat, 02 Dec 2023 11:14:54 -0500
X-MC-Unique: iUP55ek1MZ-Wq4EvSMfO1Q-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6c7c69e4367so3702110b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 08:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701533693; x=1702138493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d20ZhiqnGqdkMktjpUNLxnQJIPIANFRSnbo7tB7yeNg=;
        b=C0fe/wMVWs9htC4cj+hwAp2m4nCteaA1BF7fGMMw2cjQ9SOvNPlGhKgGO03R2cPMAu
         owWWj0oTK2Q/6wA7YnEu/y7pokprmgx3DxVoLmSozu2hdV2qIxjNiYjJetB5xjQQHQ9s
         D3rBQUjdlcXiwPU/2qpkQDh/GiH5fq3kH7gJ9ekX3eC3g+DJtEj6baSpzlrnNygW2rvg
         bZm7z3o2K3kK4yilCy119qTe5ACLgvdPXlOP5zpjyFFbxd36B9Vcp+jmjyk2rQAOFSB0
         zJiYLeys3EaZ6/CqPZCqUCNYLZVGRjHofuqjEeubDmuH/IxahjNKxHv4PNvp6f7iVkzf
         9f1Q==
X-Gm-Message-State: AOJu0YzAs8SGnhRFaRAFFRYwIWJ/JvOerlNRj919QVYLzg9YxXZ21m4O
        nFTLYiXTLzjsx9ZDD7SJSRu8K7ZEQu6IdU767m3wL71PZW0V/X0PfmfRgKb0C/f6q1SZ1Tm5l7r
        1rnjRZw4nmuGhjZmltf9ySXqL
X-Received: by 2002:a05:6a20:9191:b0:18f:97c:823e with SMTP id v17-20020a056a20919100b0018f097c823emr624397pzd.72.1701533693139;
        Sat, 02 Dec 2023 08:14:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfFdY/i/DZ0sRJ9+sag4VgIi2E/F4EvzI9yvvPSiinv1XbXACUpSJRunNxi+YJ9YEykL4mJw==
X-Received: by 2002:a05:6a20:9191:b0:18f:97c:823e with SMTP id v17-20020a056a20919100b0018f097c823emr624383pzd.72.1701533692823;
        Sat, 02 Dec 2023 08:14:52 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id g34-20020a635662000000b005c19c586cb7sm4871533pgm.33.2023.12.02.08.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 08:14:52 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net v2] ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()
Date:   Sun,  3 Dec 2023 01:14:41 +0900
Message-ID: <20231202161441.221135-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() returns
true. For example, applications can use PF_PACKET to create a malformed
packet with no IP header. This type of packet causes a problem such as
uninit-value access.

This patch ensures that skb_pull() can pull the required size by checking
the skb with pskb_network_may_pull() before skb_pull().

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
v1 -> v2:
- Change the title
- Update the code with Eric's suggestion
  https://lore.kernel.org/all/20231126151652.372783-1-syoshida@redhat.com/
---
 net/ipv4/ip_gre.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 22a26d1d29a0..5169c3c72cff 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -635,15 +635,18 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 	}
 
 	if (dev->header_ops) {
+		int pull_len = tunnel->hlen + sizeof(struct iphdr);
+
 		if (skb_cow_head(skb, 0))
 			goto free_skb;
 
 		tnl_params = (const struct iphdr *)skb->data;
 
-		/* Pull skb since ip_tunnel_xmit() needs skb->data pointing
-		 * to gre header.
-		 */
-		skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
+		if (!pskb_network_may_pull(skb, pull_len))
+			goto free_skb;
+
+		/* ip_tunnel_xmit() needs skb->data pointing to gre header. */
+		skb_pull(skb, pull_len);
 		skb_reset_mac_header(skb);
 
 		if (skb->ip_summed == CHECKSUM_PARTIAL &&
-- 
2.41.0

