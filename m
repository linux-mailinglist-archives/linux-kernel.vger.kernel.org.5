Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64E47B5DCD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjJBXkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbjJBXkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:40:22 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC933EC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 16:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1696290018; x=1696549218;
        bh=DpHnaHAijT4d4KiioJpkmarggtLbGhDHnkNuc1o3f/E=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=epe6D07shF2IKgkogFyig7ZBdeACCWSnRHv+vnRQuFl5aNbLvCdxuk4XrcoVi8yog
         qFwZTCsMw+tpu57fXb1g7zRHTM3VXTWsF+1Re9OjOqt59vYEcq26RInlM1K3+rNtOt
         +CI2ZYPCXH1V1YaYSt0JrZn+0ua1axr2CqAMoQQq7p9YveHe1DkRdg/XqWlOweuczB
         g6tqLJ5vA0RTZriRyMRS97SRL6nJBtVGL1phVs0v9NZXgZKNML/3TiG+BLGguSaa8L
         oZSCd0cUwGu1AuPLTUEWxtLw6mtpwuZ1/Ff2/c/cVf6bFri9/u5ZtS03sfXMuCYvpd
         S9NwqeX1uiesQ==
Date:   Mon, 02 Oct 2023 23:40:02 +0000
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Michael Pratt <mcpratt@protonmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rafal Milecki <zajec5@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Michael Pratt <mcpratt@pm.me>
Subject: [PATCH 1/2] mac_pton: support MAC addresses with other delimiters
Message-ID: <20231002233946.16703-2-mcpratt@protonmail.com>
In-Reply-To: <20231002233946.16703-1-mcpratt@protonmail.com>
References: <20231002233946.16703-1-mcpratt@protonmail.com>
Feedback-ID: 27397386:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Pratt <mcpratt@pm.me>

Some network hardware vendors may do something unique
when storing the MAC address into hardware in ASCII,
like using hyphens as the delimiter.

Allow parsing of MAC addresses with a non-standard
delimiter (punctuation other than a colon).

e.g. aa-bb-cc-dd-ee-ff

Signed-off-by: Michael Pratt <mcpratt@pm.me>
---
 lib/net_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/net_utils.c b/lib/net_utils.c
index 42bb0473fb22..ecb7625e1dec 100644
--- a/lib/net_utils.c
+++ b/lib/net_utils.c
@@ -18,7 +18,7 @@ bool mac_pton(const char *s, u8 *mac)
 =09for (i =3D 0; i < ETH_ALEN; i++) {
 =09=09if (!isxdigit(s[i * 3]) || !isxdigit(s[i * 3 + 1]))
 =09=09=09return false;
-=09=09if (i !=3D ETH_ALEN - 1 && s[i * 3 + 2] !=3D ':')
+=09=09if (i !=3D ETH_ALEN - 1 && !ispunct(s[i * 3 + 2]))
 =09=09=09return false;
 =09}
 =09for (i =3D 0; i < ETH_ALEN; i++) {
--=20
2.30.2


