Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A46578A895
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjH1JLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjH1JL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:11:28 -0400
X-Greylist: delayed 592 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Aug 2023 02:11:24 PDT
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F15EC;
        Mon, 28 Aug 2023 02:11:24 -0700 (PDT)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
        by mx0.infotecs.ru (Postfix) with ESMTP id 844C71024B9B;
        Mon, 28 Aug 2023 12:01:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 844C71024B9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
        t=1693213287; bh=e1LoLEWqLdQNVrpbhibyY/jWf0inRICe7rnSUvTENN0=;
        h=From:To:CC:Subject:Date:From;
        b=fLh36ZdSjclfmkdDwDaGK+bsxz1dmHZS7EhQ6zmCjcMP1qGPw3NPayV1J4A2daORZ
         9gU6bLFP5UIPriKd0iJGTXA48/brPI/K2IX6jlmc7hGmpIBQgj3uVGusFnE0Z2YHrc
         xP9qzkOCLwwczEKJiYKGEhxdH/M+P6GetX5nT950=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
        by mx0.infotecs-nt (Postfix) with ESMTP id 8110F3032702;
        Mon, 28 Aug 2023 12:01:27 +0300 (MSK)
From:   Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To:     "David S. Miller" <davem@davemloft.net>
CC:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH net] ipv4: igmp: Remove redundant comparison in
 igmp_mcf_get_next()
Thread-Topic: [PATCH net] ipv4: igmp: Remove redundant comparison in
 igmp_mcf_get_next()
Thread-Index: AQHZ2Y46eeJuAyOxGUmxwt3NBxsAdw==
Date:   Mon, 28 Aug 2023 09:01:27 +0000
Message-ID: <20230828085926.424703-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2023/08/28 08:24:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/08/28 04:26:00 #21751202
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'state->im' value will always be non-zero after
the 'while' statement, so the check can be removed.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
 net/ipv4/igmp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 48ff5f13e797..6ebf06886527 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -2943,8 +2943,6 @@ static struct ip_sf_list *igmp_mcf_get_next(struct se=
q_file *seq, struct ip_sf_l
 				continue;
 			state->im =3D rcu_dereference(state->idev->mc_list);
 		}
-		if (!state->im)
-			break;
 		spin_lock_bh(&state->im->lock);
 		psf =3D state->im->sources;
 	}
--=20
2.39.2
