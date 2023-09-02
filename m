Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4EA78F77B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 05:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348234AbjIADkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 23:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjIADkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 23:40:03 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0B330CF;
        Thu, 31 Aug 2023 20:39:59 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id C6380604A13D7;
        Fri,  1 Sep 2023 11:39:56 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li kunyu <kunyu@nfschina.com>
To:     idryomov@gmail.com, xiubli@redhat.com, jlayton@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?ceph/decode:=20Remove=20unnecessary=20=E2=80=98?= =?UTF-8?q?0=E2=80=99=20values=20from=20ret?=
Date:   Sun,  3 Sep 2023 04:11:12 +0800
Message-Id: <20230902201112.4401-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret is assigned first, so it does not need to initialize the
assignment.
Bad is not used and can be removed.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 net/ceph/decode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ceph/decode.c b/net/ceph/decode.c
index bc109a1a4616..9f5f095d8235 100644
--- a/net/ceph/decode.c
+++ b/net/ceph/decode.c
@@ -50,7 +50,7 @@ static int
 ceph_decode_entity_addr_legacy(void **p, void *end,
 			       struct ceph_entity_addr *addr)
 {
-	int ret = -EINVAL;
+	int ret = 0;
 
 	/* Skip rest of type field */
 	ceph_decode_skip_n(p, end, 3, bad);
@@ -66,8 +66,7 @@ ceph_decode_entity_addr_legacy(void **p, void *end,
 			      sizeof(addr->in_addr), bad);
 	addr->in_addr.ss_family =
 			be16_to_cpu((__force __be16)addr->in_addr.ss_family);
-	ret = 0;
-bad:
+
 	return ret;
 }
 
-- 
2.18.2

