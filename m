Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BA9804BD2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjLEIG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346395AbjLEIGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:06:06 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AA6D41;
        Tue,  5 Dec 2023 00:05:48 -0800 (PST)
Received: from localhost.ispras.ru (unknown [10.10.165.7])
        by mail.ispras.ru (Postfix) with ESMTPSA id BF7DB40F1DE9;
        Tue,  5 Dec 2023 08:05:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BF7DB40F1DE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1701763546;
        bh=JTEXi8TgIL4mRes1RKwLHstGL+1Ht9ZpBqt+VDl25fI=;
        h=From:To:Cc:Subject:Date:From;
        b=ZeGt7KNDwgTR4NzwLFREB5RIzRFIzKzj8J8UY8T9MJ56stiHkXx6ciQse+PccqsEC
         GysZq/0K7yIzDBSDAsN/QgKIspYqMjWRgsZ1mIa33nFG0HiaJX+g+waEXIPT7atVY5
         HmTZUSaAsMxczUfMalOl3hYFHECIm4diML+dyO8k=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, v9fs@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Date:   Tue,  5 Dec 2023 11:05:22 +0300
Message-ID: <20231205080524.6635-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
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

If an error occurs while processing an array of strings in p9pdu_vreadf
then uninitialized members of *wnames array are freed.

Fix this by iterating over only lower indices of the array.

Found by Linux Verification Center (linuxtesting.org).

Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 net/9p/protocol.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 4e3a2a1ffcb3..d33387e74a66 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -393,6 +393,7 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 		case 'T':{
 				uint16_t *nwname = va_arg(ap, uint16_t *);
 				char ***wnames = va_arg(ap, char ***);
+				int i;
 
 				errcode = p9pdu_readf(pdu, proto_version,
 								"w", nwname);
@@ -406,8 +407,6 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 				}
 
 				if (!errcode) {
-					int i;
-
 					for (i = 0; i < *nwname; i++) {
 						errcode =
 						    p9pdu_readf(pdu,
@@ -421,9 +420,7 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 
 				if (errcode) {
 					if (*wnames) {
-						int i;
-
-						for (i = 0; i < *nwname; i++)
+						while (--i >= 0)
 							kfree((*wnames)[i]);
 					}
 					kfree(*wnames);
-- 
2.43.0

