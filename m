Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFC2801D7F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 16:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjLBPlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 10:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLBPlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 10:41:45 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B80BB;
        Sat,  2 Dec 2023 07:41:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701531672; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=b07VKVp3Y6KFSvXCq5WtA/wgwkIQOH2fLg1vVgZoMkH3HaksMyW+xK7FyB7G7iVqTfeXjkXSeRqiz3seB36GTmulhDVkWA2JvV+b1BoCIaxe/myU36N/WxQQkcFP7oO+NaC2+xBu1n0o3qIfZUSd5gf6b11N2xMU7+1sFH/I1WI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1701531672; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=8NY9bd//Bp+IVrU4lm9lUah8k6STVPOlOeGkQeycAEQ=; 
        b=NKsepZb6PWTkl3BMgX9JB7p3BDFRx6JmmMCJ3+57Zmn9vXAeIK/SC2qPbPW19UkIvwvD+6hsfMzApzELzOURnAdwE5cuKk7c7M9n+pM89TKcyBwMj0kTXDeXc0dMipx4AOwc86q7w8GarsP82H8jI56nGk7e5nq6CIoCZZS2zWs=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701531672;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=8NY9bd//Bp+IVrU4lm9lUah8k6STVPOlOeGkQeycAEQ=;
        b=pc9d1gBBtKz3gEWE+aU6f8Cne2i7KvNB7gJFhomdsLE5nIeQXQz2j/KsNIBv9uVa
        pNCs/xQPAYwzTvEkIvShBN8VCHNdRfqM1wK1iwERTmHuFxUFjh0v6oecJLT9qdIDgNj
        QmCqlu5FRabYEpIik7tu4O6UeJg/JE/jjUfJaBWw=
Received: from kampyooter.. (122.170.35.155 [122.170.35.155]) by mx.zoho.in
        with SMTPS id 1701531670973749.3078715470447; Sat, 2 Dec 2023 21:11:10 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH net-next v2 0/2] nfc: Fix UAF during datagram sending caused by missing refcounting
Date:   Sat,  2 Dec 2023 21:10:57 +0530
Message-ID: <cover.1701530776.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Changes in v2:
- Add net-next in patch subject.
- Removed unnecessary extra lock and hold nfc_dev ref when holding llcp_sock.
- Remove last formatting patch.
- Picked up r-b from Krzysztof for LLCP_BOUND patch.

Siddh Raman Pant (2):
  nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to
    llcp_local
  nfc: Do not send datagram if socket state isn't LLCP_BOUND

 net/nfc/llcp_core.c | 21 +++++++++++++++++++--
 net/nfc/llcp_sock.c |  5 +++++
 2 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.42.0
