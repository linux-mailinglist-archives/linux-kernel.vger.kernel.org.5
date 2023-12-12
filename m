Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283E180F5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376712AbjLLSt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376638AbjLLStv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:49:51 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB41D0;
        Tue, 12 Dec 2023 10:49:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702406967; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=OEDbM/7Nh+ThCBsFEQCeUubWdsTOEL0mGX/WzouBF5FpVS4sOTYuO2tOUkbBrOTds2pYNTJCQ5CIYGSn3R1uZnZnOq1swBXt782sMcecgey0PZNjaEycKghALTTK02XTlzFkb2hOym5ITH/n0alRrAyKnVEd3ru7WCElqbY2qW8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1702406967; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=Y9BKQtIfmMm0sVY++cu3R+sS5q4tdRr2o2bcRqoIeps=; 
        b=CJqBDTw3OYrKBVuWr/2Kro6k7cevoqsJY2QRpxKn4AdYKipiHrgAlh9FnsGSViqMgzkTiJwqrrwOFUgT+z5w3FCa2R7dwDqRalqhhaHbgCEbxpEwosAkj1ReDaLHBvANVUCVxCrwZ1NYH1V8tFasJ5BjPOBac02YSMjAb3YDjMw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702406967;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Y9BKQtIfmMm0sVY++cu3R+sS5q4tdRr2o2bcRqoIeps=;
        b=qJDjqT1P2Rcgd2vYjnvrmn/yBZknNWDIc7p+MFgb5DfZoxdjMuvY+bsslJBPKNpm
        H69CGMzXQtO6Jxt/FTHtdGJXgkTn75sjhhTxWVVPK0UhbSPhYzEfhxAU7ghlUXUFEC0
        DNK6TC2esVHvQ7dEuHNEtuJFPr1ZgJf/CsyVpAj8=
Received: from kampyooter.. (182.69.31.144 [182.69.31.144]) by mx.zoho.in
        with SMTPS id 1702406965316224.42754580873793; Wed, 13 Dec 2023 00:19:25 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Suman Ghosh <sumang@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 0/2] nfc: Fix UAF during datagram sending caused by missing refcounting
Date:   Wed, 13 Dec 2023 00:19:18 +0530
Message-ID: <cover.1702404519.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v5:
- Move reason = LLCP_DM_REJ under the fail_put_sock label.
- Checkpatch now warns about == NULL check for new_sk, so fix that,
  and also at other similar places in the same function.

Changes in v4:
- Fix put ordering and comments.
- Separate freeing in recv() into end labels.
- Remove obvious comment and add reasoning.
- Picked up r-bs by Suman.

Changes in v3:
- Fix missing freeing statements.

Changes in v2:
- Add net-next in patch subject.
- Removed unnecessary extra lock and hold nfc_dev ref when holding llcp_sock.
- Remove last formatting patch.
- Picked up r-b from Krzysztof for LLCP_BOUND patch.

---

For connectionless transmission, llcp_sock_sendmsg() codepath will
eventually call nfc_alloc_send_skb() which takes in an nfc_dev as
an argument for calculating the total size for skb allocation.

virtual_ncidev_close() codepath eventually releases socket by calling
nfc_llcp_socket_release() (which sets the sk->sk_state to LLCP_CLOSED)
and afterwards the nfc_dev will be eventually freed.

When an ndev gets freed, llcp_sock_sendmsg() will result in an
use-after-free as it

(1) doesn't have any checks in place for avoiding the datagram sending.

(2) calls nfc_llcp_send_ui_frame(), which also has a do-while loop
    which can race with freeing. This loop contains the call to
    nfc_alloc_send_skb() where we dereference the nfc_dev pointer.

nfc_dev is being freed because we do not hold a reference to it when
we hold a reference to llcp_local. Thus, virtual_ncidev_close()
eventually calls nfc_release() due to refcount going to 0.

Since state has to be LLCP_BOUND for datagram sending, we can bail out
early in llcp_sock_sendmsg().

Please review and let me know if any errors are there, and hopefully
this gets accepted.

Thanks,
Siddh

Siddh Raman Pant (2):
  nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to
    llcp_local
  nfc: Do not send datagram if socket state isn't LLCP_BOUND

 net/nfc/llcp_core.c | 72 +++++++++++++++++++++++++++++----------------
 net/nfc/llcp_sock.c |  5 ++++
 2 files changed, 52 insertions(+), 25 deletions(-)

-- 
2.42.0

