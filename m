Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979B97C0456
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjJJTWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjJJTWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:22:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59A094
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:22:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB9AC433CA;
        Tue, 10 Oct 2023 19:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696965723;
        bh=FkJc0H6OMIzQhv7nVnzWu7KssuAvk/PqTWIo7TR0B2Y=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZMhN2TCq7x8MzAmed0YdfWJMvjxXy8vvn6DRMNJKqofdnPwSjzbUKDv0Mgd723V6d
         UDUOhgC7xYfBpWWcXZFSIlCenD0ODOXDa8tFMPZIfIJjU+Zu+ztW3dpi3a1CH9LLPi
         i75PJFVTyjMtm9uAaIs3i+LIZooFY1PE55yFQ6Bv26au1uR4mifmBUfuQM9eJVb4mn
         0uZIu9Ud56zIreMc0hYtQIdEZpgbl7Pn6+GKnCO5SC5iHd32jYH6rXdDI5fMxmC9zF
         jZyzUpRVI+TqOVtVNxq4S38rigopzS38Kdy+vHPdUUd4+3iwMo09H6FWAZnajbndMB
         kmwft/mXNOtuA==
From:   Matthieu Baerts <matttbe@kernel.org>
Date:   Tue, 10 Oct 2023 21:21:42 +0200
Subject: [PATCH net-next 1/6] tools: ynl: add uns-admin-perm to genetlink
 legacy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-1-18dd117e8f50@kernel.org>
References: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
In-Reply-To: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
To:     mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davide Caratti <dcaratti@redhat.com>,
        Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CEeDuoKr4YsKIddFImJBrssE0bezdUIPrFAMqU2bEiA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlJaRV+0vC8TF4WfZNftXeCyx5hCfO811Y6oY6y
 5a9Ewv5TjWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZSWkVQAKCRD2t4JPQmmg
 c7wnEACI2bsm/JE7+qvhFjq4ltf6+PDUF7ckVR3d3UqkYZoCcH858cbirCFjv19PW59InjdsUl2
 fwWKdfoX4cLdaPIAIAkQo5ZwBJWd5h5VKM7nNaHyElv34sRKMzdGyiuJUYopB+buNlHRnRmbwT+
 QroJ/7330TgX0ZPOR7HTz5opALlRsA8gpzMd0ziCHWOz3be1yqa2oKFTk/IX9qSl8fciuz0LEqY
 xES+Gu8sVUd5gn9lUSFI0flv6O0RGv6Vp+sj74z6V7yhO57/TKIXFVEFZ7wbfNinyU3CZtcpQlM
 xmDrkQtfbWIhCz/eMlD1XgeoU4m9sRKtIJw3mWSfIYg9k6o4dYfS6TKIFkXFg+qZkVDCGoolK16
 FFG/8CPRWEBQYZrmgmb/rZLscoT9PRMRMMhHTC4S/pM2Em0QCS4d+bKD8Z/UWDIXI/mC+yLEg9y
 pt1tN7cfq/FBJNtk56/iwba1FDwouuE56c/6t463bQWJS05G/l5BiiWwmMPgxorcEIIQKiGlIGh
 fSB64jqqEhauXk2SfDIB/j85wm73hArRPN45V1a0Bd1NO49fIwj/yotA1Fyi8/rqPjBhKGYDFrb
 WkR1joNU1+ArSJrfSJ8fmMKy7w8w/Rf0yWZ+P8mSXB7+OVTg//Aaht2nf23tEVxPSYmS8ogXiY8
 +wy90qiA9wt1heQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

this flag maps to GENL_UNS_ADMIN_PERM and will be used by future specs.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 25fe1379b180..6b4eb4b2ec17 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -328,7 +328,7 @@ properties:
               description: Command flags.
               type: array
               items:
-                enum: [ admin-perm ]
+                enum: [ admin-perm, uns-admin-perm ]
             dont-validate:
               description: Kernel attribute validation flags.
               type: array

-- 
2.40.1

