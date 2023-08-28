Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B00378AEA0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjH1LST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjH1LSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:18:11 -0400
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA87BF;
        Mon, 28 Aug 2023 04:18:04 -0700 (PDT)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
        by mx0.infotecs.ru (Postfix) with ESMTP id 29F041046D88;
        Mon, 28 Aug 2023 14:18:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 29F041046D88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
        t=1693221483; bh=Gwx+6Ebxth0f3cunO2WHpVX9PHLFZKluP78M27Wfyco=;
        h=From:To:CC:Subject:Date:From;
        b=Qo7eFCfHrzoBNoM/Iv2CPquvjnn2MhDEH1rXbg6xwS1w4HPnkR7UHRdLlZgRjs7pG
         yuWIQUp3fj18ksw9lUxDAamemeR+LR9Qf8zzvBw8rYIFOCje6yw1SY8b4Bpzpd5llz
         3wXa8xVsaTH1UVV9L8JoqwCOlkFuRVmL5n+I0MSE=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
        by mx0.infotecs-nt (Postfix) with ESMTP id 269963155AB0;
        Mon, 28 Aug 2023 14:18:03 +0300 (MSK)
From:   Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To:     "David S. Miller" <davem@davemloft.net>
CC:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH net] ipv6: mcast: Remove redundant comparison in
  igmp6_mcf_get_next()
Thread-Topic: [PATCH net] ipv6: mcast: Remove redundant comparison in
  igmp6_mcf_get_next()
Thread-Index: AQHZ2aFPBjmirnyHxU2khrQS2Mr61w==
Date:   Mon, 28 Aug 2023 11:18:02 +0000
Message-ID: <20230828111604.583371-1-Ilia.Gavrilov@infotecs.ru>
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
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/08/28 08:28:00 #21754631
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
 net/ipv6/mcast.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 714cdc9e2b8e..9696343d0aa9 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -3013,8 +3013,6 @@ static struct ip6_sf_list *igmp6_mcf_get_next(struct =
seq_file *seq, struct ip6_s
 				continue;
 			state->im =3D rcu_dereference(state->idev->mc_list);
 		}
-		if (!state->im)
-			break;
 		psf =3D rcu_dereference(state->im->mca_sources);
 	}
 out:
--=20
2.39.2
