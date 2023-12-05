Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9617A804D75
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjLEJUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLEJUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:20:04 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0875483;
        Tue,  5 Dec 2023 01:20:09 -0800 (PST)
Received: from localhost.ispras.ru (unknown [10.10.165.7])
        by mail.ispras.ru (Postfix) with ESMTPSA id 3F8CD40F1DE9;
        Tue,  5 Dec 2023 09:20:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3F8CD40F1DE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1701768007;
        bh=Xkj0nuUUERVo3DmD0W5CbQml3tG2cDGWBXJRyDsrHq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OOs6rrNxIXNTpiu+wwKGkoIxiCIgN0JjlOkTYcgNboYScKjXAtJUNbYxCx1uhxUV8
         V+dSISTy/vUdFlBok1a3MZBkLoxXytP8ZzQhgiKfvPLttDjHjp4EYZz5IX8s9V5rXa
         43jfNC40GiHt+8/BgkeP+wcGGsb2DrgnsNzJMeOs=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, v9fs@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH v2] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Date:   Tue,  5 Dec 2023 12:19:50 +0300
Message-ID: <20231205091952.24754-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZW7oQ1KPWTbiGSzL@codewreck.org>
References: 
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

Fix this by iterating over only lower indices of the array. Also handle
possible uninit *wnames usage if first p9pdu_readf() call inside 'T' case
fails.

Found by Linux Verification Center (linuxtesting.org).

Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
v2: I've missed that *wnames can also be left uninitialized. Please
ignore the patch v1. As an answer to Dominique's comment: my
organization marks this statement in all commits.

 net/9p/protocol.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index 4e3a2a1ffcb3..043b621f8b84 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -393,6 +393,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 		case 'T':{
 				uint16_t *nwname = va_arg(ap, uint16_t *);
 				char ***wnames = va_arg(ap, char ***);
+				int i;
+				*wnames = NULL;
 
 				errcode = p9pdu_readf(pdu, proto_version,
 								"w", nwname);
@@ -406,8 +408,6 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 				}
 
 				if (!errcode) {
-					int i;
-
 					for (i = 0; i < *nwname; i++) {
 						errcode =
 						    p9pdu_readf(pdu,
@@ -421,13 +421,11 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
 
 				if (errcode) {
 					if (*wnames) {
-						int i;
-
-						for (i = 0; i < *nwname; i++)
+						while (--i >= 0)
 							kfree((*wnames)[i]);
+						kfree(*wnames);
+						*wnames = NULL;
 					}
-					kfree(*wnames);
-					*wnames = NULL;
 				}
 			}
 			break;
-- 
2.43.0

