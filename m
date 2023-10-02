Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74F7B5DCB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbjJBXkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjJBXkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:40:18 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F90C6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 16:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1696290013; x=1696549213;
        bh=f73SVN23XeUhlvXE2ntl83ku7FkRb7mPON/Y+MCs9PI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=MJPu1oW18Wcgbk5mEVrXMkE/3dzhiE5IL6Qf1NXtwSiG9Nlii+WnuJchpAt4pFhxf
         o3S4Y+IqI3KWXTZdRr4cWniZj3kb3SqJpLOUjW4DpYVCIbgVBUsatF81uSvcmXVdA6
         GOpHwIcR159vKPY2pv2qm2iat6K+u874pv6IazWHILFHxdf1hanDkBDkYQyyExk5Ne
         03AR/Y9N6nUjoIYQD5w6hQnMIIL0mfJJhNnaT1Ht3O/aiyuTXEkuYSSAMHqW7VmhS4
         aYXDgNT1Rdx95k/wXMotL8zG7PLWevkGDEZJsV2BB8g9H4/KXUOwO3p82SfXz7GkcI
         Fg41zcy9k3geQ==
Date:   Mon, 02 Oct 2023 23:40:07 +0000
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Michael Pratt <mcpratt@protonmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rafal Milecki <zajec5@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Michael Pratt <mcpratt@pm.me>
Subject: [PATCH 2/2] mac_pton: support MAC addresses without delimiters
Message-ID: <20231002233946.16703-3-mcpratt@protonmail.com>
In-Reply-To: <20231002233946.16703-1-mcpratt@protonmail.com>
References: <20231002233946.16703-1-mcpratt@protonmail.com>
Feedback-ID: 27397386:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Pratt <mcpratt@pm.me>

Some network hardware vendors may do something unique
when storing the MAC address into hardware in ASCII,
like leaving out delimiters in order to avoid
using more than a single 16-byte logical addressing line.

Allow parsing of MAC addresses without a delimiter.

Signed-off-by: Michael Pratt <mcpratt@pm.me>
---
 lib/net_utils.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/net_utils.c b/lib/net_utils.c
index ecb7625e1dec..f5fd1926af59 100644
--- a/lib/net_utils.c
+++ b/lib/net_utils.c
@@ -7,9 +7,14 @@
=20
 bool mac_pton(const char *s, u8 *mac)
 {
+=09size_t minlen =3D 2 * ETH_ALEN;
 =09size_t maxlen =3D 3 * ETH_ALEN - 1;
 =09int i;
=20
+=09/* AABBCCDDEEFF */
+=09if (strnlen(s, maxlen) =3D=3D minlen)
+=09=09goto no_delim;
+
 =09/* XX:XX:XX:XX:XX:XX */
 =09if (strnlen(s, maxlen) < maxlen)
 =09=09return false;
@@ -25,5 +30,15 @@ bool mac_pton(const char *s, u8 *mac)
 =09=09mac[i] =3D (hex_to_bin(s[i * 3]) << 4) | hex_to_bin(s[i * 3 + 1]);
 =09}
 =09return true;
+
+no_delim:
+=09for (i =3D 0; i < minlen; i++) {
+=09=09if (!isxdigit(s[i]))
+=09=09=09return false;
+=09}
+=09for (i =3D 0; i < ETH_ALEN; i++) {
+=09=09mac[i] =3D (hex_to_bin(s[i * 2]) << 4) | hex_to_bin(s[i * 2 + 1]);
+=09}
+=09return true;
 }
 EXPORT_SYMBOL(mac_pton);
--=20
2.30.2


