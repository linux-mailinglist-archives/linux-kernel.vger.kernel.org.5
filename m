Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B257762400
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjGYU5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGYU5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:57:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C12099
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:57:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98e011f45ffso873711566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1690318636; x=1690923436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0e2cyChRqGI3tRbPoTL2xt8a8S3w5QsHlIz9nls3pyY=;
        b=jqTc+EfXLmgZjGC5kaOFEqmUgycSNXUK+9S9FdyQ0cMymNN2iWk/hArhhAgo9rTNHF
         H9QrAzXDh2icbAEwLauwyV9rLpcyupXjv1T+/GLSt6se8WoJTJ4MILxmmeuDD6l4brg0
         eWxMj2P1BZkN/Xh0xXyWejzikAoGhzT5BgZro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690318636; x=1690923436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0e2cyChRqGI3tRbPoTL2xt8a8S3w5QsHlIz9nls3pyY=;
        b=ExnNE5//KBHrjz70qhHLnqjoqTOOCtoHSZQAyu0/1QrIc/uMsAEb/fnahtTgpr9CIr
         7VnrqSlF2j5WycRg2Y+rgOg24BXXF6ZvLnDJxzUpr4cwizguu/NuS+HHL1Jg66eFKNXm
         RSbmRg56KfzbDIIlUaQsumeWP0P/QGOKzvPCraCqR6Ss6QZ2F9vM+gLB6CEw9ZjUpZwY
         2wNBDL0lPil60kdCHoZEZmfsvSlGVkekupA3cqv3N037nSkSAVV//G5lUCR0+fXPhQxW
         +jy7xIZRNmxKI0KhgyHJN2m7bgNjspq5O7Cck/874KvS2Lb6raZ+81FtoggK12Hxr/L/
         J93g==
X-Gm-Message-State: ABy/qLZljxA1MBLNlYrh+zLECfjns0ALdO6G+2/YFrVGat7eMHU0/T19
        e6mORfGVFNiQFH4CVY+PJFfoLg==
X-Google-Smtp-Source: APBJJlFk6+OBdgoFmsams0uifI3NTvtks5cjyNRPRnxBISZaHzsVE9PQwnimrnJm2PliM0sy8Q6+7A==
X-Received: by 2002:a17:906:5594:b0:957:1df0:9cbf with SMTP id y20-20020a170906559400b009571df09cbfmr13487ejp.19.1690318636028;
        Tue, 25 Jul 2023 13:57:16 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709062dd300b0097073f1ed84sm8704186eji.4.2023.07.25.13.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:57:15 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
        ecree@solarflare.com, andrew@lunn.ch, kuba@kernel.org,
        davem@davemloft.net, leon@kernel.org, pabeni@redhat.com,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Joe Damato <jdamato@fastly.com>
Subject: [net-next v2 0/2] rxfh with custom RSS fixes
Date:   Tue, 25 Jul 2023 20:56:53 +0000
Message-Id: <20230725205655.310165-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings:

Welcome to v2, now via net-next. No functional changes; only style
changes (see the summary below).

While attempting to get the RX flow hash key for a custom RSS context on
my mlx5 NIC, I got an error:

$ sudo ethtool -u eth1 rx-flow-hash tcp4 context 1
Cannot get RX network flow hashing options: Invalid argument

I dug into this a bit and noticed two things:

1. ETHTOOL_GRXFH supports custom RSS contexts, but ETHTOOL_SRXFH does
not. I moved the copy logic out of ETHTOOL_GRXFH and into a helper so
that both ETHTOOL_{G,S}RXFH now call it, which fixes ETHTOOL_SRXFH. This
is patch 1/2.

2. mlx5 defaulted to RSS context 0 for both ETHTOOL_{G,S}RXFH paths. I
have modified the driver to support custom contexts for both paths. It
is now possible to get and set the flow hash key for custom RSS contexts
with mlx5. This is patch 2/2.

See commit messages for more details.

Thanks.

v2:
- Rebased on net-next
- Adjusted arguments of mlx5e_rx_res_rss_get_hash_fields and
  mlx5e_rx_res_rss_set_hash_fields to move rss_idx next to the rss
  argument
- Changed return value of both mlx5e_rx_res_rss_get_hash_fields and
  mlx5e_rx_res_rss_set_hash_fields to -ENOENT when the rss entry is
  NULL
- Changed order of local variables in mlx5e_get_rss_hash_opt and
  mlx5e_set_rss_hash_opt

Joe Damato (2):
  net: ethtool: Unify ETHTOOL_{G,S}RXFH rxnfc copy
  net/mlx5: Fix flowhash key set/get for custom RSS

 .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 25 +++++--
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  7 +-
 .../mellanox/mlx5/core/en_fs_ethtool.c        | 33 +++++---
 net/ethtool/ioctl.c                           | 75 ++++++++++---------
 4 files changed, 86 insertions(+), 54 deletions(-)

-- 
2.25.1

