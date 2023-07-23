Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65A75E2CA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 17:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGWPHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 11:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 11:07:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70484D1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 08:07:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-991c786369cso555623466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 08:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1690124846; x=1690729646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3NErtpmKZLDudWNuVZ/0OM4T/FxzlnDuRfRYmitD82g=;
        b=dwgbO6GKaHAqW+LFtaslcJ4q3w+T5gxHonbMLkXZ98QEsonyJ+G99ojQFbOVzzzgB3
         2oH2Jg1gDQdoRjxW/yI33vo/b4O/EycXHp46cyf4XdHD24J/77TMkDYPYkMouQcGm/oL
         0KXUMKH4LgcdH+23eBfhhQUbXJdj53/CBiwj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690124846; x=1690729646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NErtpmKZLDudWNuVZ/0OM4T/FxzlnDuRfRYmitD82g=;
        b=QFeirdwjpMWnPXijHl5TEwpgyj3cND+zNZ3xQM7IexWRF6BmKd6oX/IvPfJdi4VDG4
         A8+hZrJa469WtR+ReJCbc7PcM5iJLmFfIUUVlzL13odM1aKZ1GDdEdII0KpWgkvhos51
         Bn2O72x+xQN04Eb9Hr0AgDNwGpxapAPHC0ZuX2KR5211W07E0DnVeq6fTLTQyMMHeK4+
         bmK2DenkW+vHsgvUivZKq1vEhDVYQdA54JnR6/SKW4DmQSL2x/mWjeJiJHVQC41tttNX
         +4vBE+3qpwVb9iSNrYSsHOEF7YK1s2rt+oWN9b3r60xDpGDp27nmjCZ6JaVxU086NqDl
         DPog==
X-Gm-Message-State: ABy/qLav312z8x8dqpF5ygaoyFXI8ZQ0z4m4QMO+vvp8NKQQ27cfkjEN
        BVYsGZRcYI9iDN9HFBSQBdelyw==
X-Google-Smtp-Source: APBJJlG9eVdbuWWsSvWOHjNaGAWjri0ArafcUcfiImigaOveP4JfxckC2J1CP/DsZ8r8rC3PrFYfeQ==
X-Received: by 2002:a17:906:9bf6:b0:988:6e75:6b3d with SMTP id de54-20020a1709069bf600b009886e756b3dmr7208827ejc.33.1690124845756;
        Sun, 23 Jul 2023 08:07:25 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709064f0a00b009929d998abcsm5227691eju.209.2023.07.23.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 08:07:25 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
        ecree@solarflare.com, andrew@lunn.ch, kuba@kernel.org,
        davem@davemloft.net, leon@kernel.org, pabeni@redhat.com,
        bhutchings@solarflare.com, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Joe Damato <jdamato@fastly.com>
Subject: [net 0/2] rxfh with custom RSS fixes
Date:   Sun, 23 Jul 2023 15:06:56 +0000
Message-Id: <20230723150658.241597-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings:

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

The patches include the relevant fixes tags, as I think both commits are
fixing previous code, but if this change is preferred for net-next I can
resend.

Thanks.

Joe Damato (2):
  net: ethtool: Unify ETHTOOL_{G,S}RXFH rxnfc copy
  net/mlx5: Fix flowhash key set/get for custom RSS

 .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 23 +++++-
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  5 +-
 .../mellanox/mlx5/core/en_fs_ethtool.c        | 33 +++++---
 net/ethtool/ioctl.c                           | 75 ++++++++++---------
 4 files changed, 84 insertions(+), 52 deletions(-)

-- 
2.25.1

