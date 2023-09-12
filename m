Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC45679D0F7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbjILM0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbjILMZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:25:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19661704;
        Tue, 12 Sep 2023 05:25:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-502934c88b7so8912803e87.2;
        Tue, 12 Sep 2023 05:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694521540; x=1695126340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn4TgEzrAdz2bdBKKMJZsRroR4da2heG9+A1fboRUrw=;
        b=rLjDZBYu0W1MbcafUORHEn7Y6UywGWGr6LzUnhkgncSWABK19cE4TCsaISwIpswARZ
         b8SRpWmHQaseRbzpN2Pediqa3iMdV56ZSrT0GAG2gMqjW3yFnPqmIE7WuGmZA1sZjfqu
         vSQl5xB3XyMnNTqfH2qmC7Qb3Gf40U8YU+Eed0SJPuvVC+WXH7a1dgLo0nAVnwjz9D5j
         ra8o8EDQAK53gX1aeZQJoxnnvC8J33HXlt0lp1Lt1c3uDegiaP0yt+Kde/o6jDCiVpP9
         3puPqhX9vmxOZMXAmVF7cbr+a21XvEsp6xpP0DTVRduP7pP+dvDIwIXgHz2UJOA1CRsb
         YmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694521540; x=1695126340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dn4TgEzrAdz2bdBKKMJZsRroR4da2heG9+A1fboRUrw=;
        b=i7Tsdf+Y+m777qe9WhrKwPmvELB9saYwlWov/JAbHThoCwG7eYovvR1gBIkcyVk9Mz
         BfRvENReOB3X9O0jtbpIqK14pj0rUIbbrfa0krviFjIn6LdHlkJpGkMF+s7lyYOTGq3+
         9CsqrFCBi7y9GOxK+f6fR909UiyevFpLLG4Q34ufbqbL+nEqwKxlYUyLzVTnqpA4FsRJ
         5H1tsp+bcXVE0MevjHzLoq2hEjQvJbdnlz2EGt5LhFNbIp/um8ZEg6/5TLOAVWeJga4K
         Vpm4ExWfw788MlRsX7lnXrcraFwgSMrmJ+v9LC2mlti3MnPKXYI6RnlPxHQ+YbTp6BET
         LTKg==
X-Gm-Message-State: AOJu0YyXLUu+P9sdDcI8+WjxPwboMBUeRHZnU1qoDm6mw5O0xD6VkP42
        laYv4GDIGpMUHchLM6WLsaj2FV7p7Rh34w==
X-Google-Smtp-Source: AGHT+IH6bUJuqv5vaLmaanFk89tI6/8qVXo4Yi/c8+SnJtc+2TNLrXZmF2uSm7FpCG/hylv58ccMKw==
X-Received: by 2002:a05:6512:1196:b0:502:d765:a7c9 with SMTP id g22-20020a056512119600b00502d765a7c9mr520lfr.28.1694521540288;
        Tue, 12 Sep 2023 05:25:40 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g21-20020ac25395000000b004fe333128c0sm1737327lfh.242.2023.09.12.05.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:25:39 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Pawel Dembicki <paweldembicki@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/8] net: dsa: vsc73xx: Make vsc73xx usable
Date:   Tue, 12 Sep 2023 14:21:53 +0200
Message-Id: <20230912122201.3752918-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series focuses on making vsc73xx usable.

The first patch was added in v2; it switches from a poll loop to
read_poll_timeout.

The second patch is a simple conversion to phylink because adjust_link won't
work anymore.

The third patch introduces a definition with the maximum number of ports to
avoid using magic numbers.

The fourth patch implements port state configuration, which is required for
bridge functionality. STP frames are not forwarded at this moment. BPDU frames
are only forwarded from/to the PI/SI interface. For more information, see chapter
2.7.1 (CPU Forwarding) in the datasheet.

Patches 5-8 provide a basic implementation of tag8021q functionality with QinQ
support, without VLAN filtering in the bridge and simple VLAN awareness in VLAN
filtering mode.

Pawel Dembicki (8):
  net: dsa: vsc73xx: use read_poll_timeout instead delay loop
  net: dsa: vsc73xx: convert to PHYLINK
  net: dsa: vsc73xx: Add define for max num of ports
  net: dsa: vsc73xx: add port_stp_state_set function
  net: dsa: vsc73xx: Add vlan filtering
  net: dsa: vsc73xx: introduce tag 8021q for vsc73xx
  net: dsa: vsc73xx: Implement vsc73xx 8021q tagger
  net: dsa: vsc73xx: Add bridge support

 drivers/net/dsa/Kconfig                |   2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c | 800 +++++++++++++++++++++----
 drivers/net/dsa/vitesse-vsc73xx.h      |  17 +
 include/net/dsa.h                      |   2 +
 net/dsa/Kconfig                        |   6 +
 net/dsa/Makefile                       |   1 +
 net/dsa/tag_vsc73xx_8021q.c            |  91 +++
 7 files changed, 806 insertions(+), 113 deletions(-)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

-- 
2.34.1

