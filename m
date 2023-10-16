Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C459B7CA048
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjJPHPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjJPHPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:15:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72724E1;
        Mon, 16 Oct 2023 00:15:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c1c66876aso660524566b.2;
        Mon, 16 Oct 2023 00:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697440534; x=1698045334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GnspnY3pZEO6i/dH60zbPIvYwdd2LawPTbo1lOoWa5o=;
        b=IMT8bLEtdX55mmmrEpDOflhDpfNaZ0bPG/3QluDwt6voZCKWyUJ58nxj9wXavKcu9J
         L2m4qFCqpfGSQ3EVVjiMUCKmaLQThEB4h6hMynFVfQ+RBSy0pSIP6v52n3GY9jQQ/2fy
         RsYPzpKBQKZQnQe3onw2/W3Nx9T0RMHEzPW1Gmix985b6ISisLIGImtpp6fkb8b+5PAz
         70Nqn8gETYvXjbCObXK/ZsVw0IovWr76YEJCEIn1YakzInEQwglSDwBsnYrcmmyLkUbd
         2Ar6FHSRe19Os1EupEpfQUq87leUIQSD5QS2/3bYGTDXT3ouF1SfZln1wjZWZVSE8EDE
         +n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697440534; x=1698045334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnspnY3pZEO6i/dH60zbPIvYwdd2LawPTbo1lOoWa5o=;
        b=qzm8wPrKtUc86fBx36IUx7uINx2F5yT7ON4A0LxylMZfwQSKQaGwM+5eIYACFEBbqL
         RxlfhthJWerE09r1SfvCeOQYXr1SMWCzp7GtCLgkWpzXNrXOEyN5dwv9ZJzjH4sG7w9j
         BNak+fHDBuwC7xjCzXeWH6Wr4+6YwsLRb+dmLjd6/594Sjgp0+N/M7RQnwvDfwbKlDKM
         DIjerSutYTgvh66irlqjUuz6Nas8Syo5QdL0AfR0cx3pPoZJr2PmoV60RvD8dn/8aMSP
         EH6jHLuGGk8gnbYBszzfKDz8vGmwEmbhhP0LfTzN85Aj2x/q/QNzkfFEpSIYz80MxVJA
         YzeQ==
X-Gm-Message-State: AOJu0YxR4Y27Dx89LTIDhAdKPmTuMqGAgBbe4I4kqSnL0RSOQjTEVdyU
        t9fWgROw0TH2eUAbVArbp+PT34Q28Kg=
X-Google-Smtp-Source: AGHT+IHh/2fTe96VjmVT1RXtUYqpVdnuiYgHrXWjKsoyPr1OVgnx6Qhq1UuPbWCAyhvC/seF5IR08w==
X-Received: by 2002:a17:906:7310:b0:9c1:9bc5:c263 with SMTP id di16-20020a170906731000b009c19bc5c263mr2924319ejc.50.1697440533667;
        Mon, 16 Oct 2023 00:15:33 -0700 (PDT)
Received: from tp.home.arpa (host-79-55-64-40.retail.telecomitalia.it. [79.55.64.40])
        by smtp.gmail.com with ESMTPSA id jl25-20020a17090775d900b00992e265495csm3419471ejc.212.2023.10.16.00.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:15:33 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/7] net: consolidate IPv4 route lookup for UDP tunnels
Date:   Mon, 16 Oct 2023 09:15:19 +0200
Message-Id: <20231016071526.2958108-1-b.galvani@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment different UDP tunnels rely on different functions for
IPv4 route lookup, and those functions all implement the same
logic. Only bareudp uses the generic ip_route_output_tunnel(), while
geneve and vxlan basically duplicate it slightly differently.

This series first extends the generic lookup function so that it is
suitable for all UDP tunnel implementations. Then, bareudp, geneve and
vxlan are adapted to use them.

This results in code with less duplication and hopefully better
maintainability.

After this series is merged, IPv6 will be converted in a similar way.

Changelog:
v2
 - fix compilation with IPv6 disabled

Beniamino Galvani (7):
  ipv4: rename and move ip_route_output_tunnel()
  ipv4: remove "proto" argument from udp_tunnel_dst_lookup()
  ipv4: add new arguments to udp_tunnel_dst_lookup()
  ipv4: use tunnel flow flags for tunnel route lookups
  geneve: add dsfield helper function
  geneve: use generic function for tunnel IPv4 route lookup
  vxlan: use generic function for tunnel IPv4 route lookup

 drivers/net/bareudp.c          |  11 ++--
 drivers/net/geneve.c           | 111 ++++++++++++--------------------
 drivers/net/vxlan/vxlan_core.c | 114 ++++++++++++---------------------
 include/net/route.h            |   6 --
 include/net/udp_tunnel.h       |   8 +++
 net/ipv4/route.c               |  48 --------------
 net/ipv4/udp_tunnel_core.c     |  49 ++++++++++++++
 7 files changed, 147 insertions(+), 200 deletions(-)

-- 
2.40.1

