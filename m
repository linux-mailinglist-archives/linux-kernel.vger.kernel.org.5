Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD9575B3F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjGTQNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTQNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:13:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E7A114;
        Thu, 20 Jul 2023 09:13:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso8626145e9.3;
        Thu, 20 Jul 2023 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689869626; x=1690474426;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KT5zlUFLt+9ArlY0df84sUttPCw70QBkOyPQwBnF6co=;
        b=oHa7mMa9P/+axKz8/wBwndBn2idcqf9865ECO1Cwbyboc/4T21mBVyI8Z9z+jJUip4
         IK/2ADlZDTDyI+uTVrxosfkJW+mlEZwMnraDmi8h10mkhj4v8F71Dr0m01PfAEB4nDnT
         SNGrsAyCroCQveWWC60g9tvPL1uqTqcauYPktSqU81QMjMWSUtO9enUvCBQL9lqK4PtS
         YzZhO5qB0Sr61J9OueuS6o40OrQoI2TMzQO8RDXTyxXtSs3xOfPVCTtD5FrFrCUMYeLU
         N9QCbLIXoyuWPbtIVDqkvucEeEsS8ukpHBHJZqncQGVC2G9wIoAgOyvmi9SeiQD+U8yM
         yO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689869626; x=1690474426;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KT5zlUFLt+9ArlY0df84sUttPCw70QBkOyPQwBnF6co=;
        b=Cbx19XRT24XT/ch0+nmayIs4Hs6/n1K3SCwBsvGSkFQ/OGUeFHv05B5GyI9F45T44l
         Bze6qwgrj7uIWRHt8fp2njihe0oRAtUBRQRJ3gi4RKRg99qT2oLvTru9c91tvvQ1PYgj
         hy/IUDt/S3dWrX9LUiqCvCJXdOATegW67k1pud3MDZK0DttAyBQx4zuuN8ismWZzncBR
         WXncUU4NKmwM3aKSbglOP4Ln58hEqibUCsVU6u37qcod1gzWji5fhe2aOT5lLEVkO4Mi
         2lJnXgpx3wDIhxruFLoLCARAs27/G0Zss9zv5KU0XRKU7DuYsz8uZupRgBMU5W4RI4j2
         n2rA==
X-Gm-Message-State: ABy/qLYLiyMU4Cz2zlpP2jtXahGj2wfXixaX1hq//cqZQbVP4HlWfiC2
        7ScP8W19PQkkLiANZqYZK0c=
X-Google-Smtp-Source: APBJJlEOPjamw3iLzItS/JveqpR7gzliI3inH14pMlbOioIIKdB22wY1CaLIqJFAXTRRKNWOLqq7mg==
X-Received: by 2002:adf:e404:0:b0:313:f4e2:901d with SMTP id g4-20020adfe404000000b00313f4e2901dmr2090525wrm.22.1689869625717;
        Thu, 20 Jul 2023 09:13:45 -0700 (PDT)
Received: from debian ([89.238.191.199])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d49cf000000b003143765e207sm1746892wrs.49.2023.07.20.09.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:13:45 -0700 (PDT)
Date:   Thu, 20 Jul 2023 18:13:29 +0200
From:   Richard Gobert <richardbgobert@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        dsahern@kernel.org, tom@herbertland.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gal@nvidia.com
Subject: [PATCH v2 0/1] net: gro: fix misuse of CB in udp socket lookup
Message-ID: <20230720161322.GA16323@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GRO stack uses `udp_lib_lookup_skb` which relies on IP/IPv6 CB's info, and
at the GRO stage, CB holds `napi_gro_cb` info. Specifically,
`udp_lib_lookup_skb` tries to fetch `iff` and `flags` information from the
CB, to find the relevant udp tunnel socket (GENEVE/VXLAN/..). Up until a
patch I submitted recently [0], it worked merely by luck, due
to the layouts of `napi_gro_cb` and IP6CB.

AFAIU it worked because:
`IP6CB(skb)->flags` is at offset 16 inside IP6CB:
 - Before the patch: `flags` was mapped to `flush`.
 - After the patch: `flags` was mapped to `data_offset`.

`IP6CB(skb)->iff` is at offset 0 inside IP6CB:
 - Before the patch: `iif` was mapped to `frag0`.
 - After the patch: `iif` was mapped to a union of `frag0` and `last`.

After my patch, on the receive phase, while `data_offset` is 40 (since IPv6
header is 40 bytes), `inet_iif` calls `ipv6_l3mdev_skb`, which checks
whether `IP6CB(skb)->flags`'s `IP6SKB_L3SLAVE` bit is on or off (in our
case its off). If it is off, `inet_iif` returns `IP6CB(skb)->iif`, which is
mapped to `napi_gro_cb->frag0`, making `inet_iif` return 0 most of the
times. `inet_sdif` returns zero due to a similar reason caused by
`data_offset` being equal to 40 (and less than 64).

On the other hand, the complete phase behaves differently.
`data_offset` is usually greater than 64 and less than 128 so the
`IP6SKB_L3SLAVE` flag is on.  Thus, `inet_sdif` returns `IP6CB(skb)->iif`,
which is mapped to `last` which contains a pointer. This causes
`udp_sk_bound_dev_eq` to fail, which leads to `udp6_lib_lookup2` failing
and not returning a socket. This leads the receive phase of GRO
to find the right socket, and on the complete phase, it fails to find it 
and makes the throughput go down to nearly zero.

Before [0] `flags` was mapped to `flush`. `flush`'s possible
values were 1 and 0, making `inet6_iff` always returning `skb->skb_iif` and
`inet6_sdif` returning 0, and leading to `udp_sk_bound_dev_eq` returning
true.

A fix is to not rely on CB, and get `iff` and `sdif` using skb->dev. l3mdev
case requires special attention since it has a master and a slave device.

[0] https://lore.kernel.org/netdev/20230601160924.GA9194@debian/

Changelog:

v1 -> v2:
  * make functions inline
  * fix logical bug
  * add a comment when we can use the new functions
  * checkpatch fixes

Richard Gobert (1):
  net: gro: fix misuse of CB in udp socket lookup

 include/net/udp.h      |  2 ++
 net/ipv4/udp.c         | 28 ++++++++++++++++++++++++++--
 net/ipv4/udp_offload.c |  7 +++++--
 net/ipv6/udp.c         | 29 +++++++++++++++++++++++++++--
 net/ipv6/udp_offload.c |  7 +++++--
 5 files changed, 65 insertions(+), 8 deletions(-)

-- 
2.36.1

