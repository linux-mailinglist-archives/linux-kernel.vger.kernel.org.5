Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CA7807CEA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441895AbjLGAA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441861AbjLGAAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:14 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C209AD53;
        Wed,  6 Dec 2023 16:00:16 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c2718a768so3801945e9.0;
        Wed, 06 Dec 2023 16:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701907215; x=1702512015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tye+lFKaTYqQMgsTDUf39Nbyo3cJQMb67chfUAmRTkk=;
        b=dbGBai1FcnchEliUCVgqnUcDbhL83cfGlpydbbbD4Hat3UlDIeQ52tYFjXo6QdqIcQ
         ArQy2RrzjkdvN9JBw1AVaWCT7Sl1E0oVH7jHY99TQvST/8k7dihwqcVXdfLyhXsy+a5q
         jXOZIAePG3JfYqLGRHnsRKV+np3xQsAPT/bBdTmeUTdLqEMI9MfeAyDbSWps4t/E6VTO
         zPXvNiV1dnBYRIvA+f3Rs6A9sS7+HoG80Ju/d3i6DVzz9CFV2IqcpBc5nB6fB/yGjD0k
         10MqDVWMc4Ts0C5bEqo9/MhmHNXzP5nu77Qrgxf50tDwni3MJk7eZHqoyGXpt4N2PQ6O
         thKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907215; x=1702512015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tye+lFKaTYqQMgsTDUf39Nbyo3cJQMb67chfUAmRTkk=;
        b=A9YkNwochvtf4hJN/3wdRP6r5sZeKkP7d51YU1gvA1qWZ2XHL/lFFmmchWeqB31GgM
         3eka1d3k7+kulNU3qTlRDNNlIBgIr3JIWoVHNEzMvIxm2pO7CYl5+w0cJCK2rNwrpp5s
         feooPtk0z3lqqn7SfZdrwPyazG4maVyntmW3sWk2sKsb8yBGCLlLdEp0L+R4CN9ayW2U
         K39rGzZCG5C6HCfRnIKAXZECnU79VNkXuklbXwyU5mZQkJdLD4u2fqW3lMbn54/Wg65i
         bZbi+H36uDd6UC67p9lDqQHd2prxlo/ipIYpwohRo1a5Eikw3UO/WEZAdHGeszbFTGUI
         xXeg==
X-Gm-Message-State: AOJu0YzbJaaN2+74ETZIGnlm/4SsaFkqcP/Ne9eOiOQBLJfDBxp+wWG/
        v/ByzHdYSkqzdGkaRrtlSOw=
X-Google-Smtp-Source: AGHT+IGAh+wEwM51M1WboBecv6WFQ6J5V0N+9FsTAo0xRj6R/S+BGEPKz5X6BQsR0Dm/4rD64Z7hkA==
X-Received: by 2002:a1c:7501:0:b0:40c:9fa:592f with SMTP id o1-20020a1c7501000000b0040c09fa592fmr913835wmc.104.1701907214820;
        Wed, 06 Dec 2023 16:00:14 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id je16-20020a05600c1f9000b00405442edc69sm50280wmb.14.2023.12.06.16.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:00:14 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v3 00/13] net: phy: at803x: cleanup
Date:   Thu,  7 Dec 2023 00:57:15 +0100
Message-Id: <20231206235728.6985-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intention of this big series is to try to cleanup the big
at803x PHY driver.

It currently have 3 different family of PHY in it. at803x, qca83xx
and qca808x.

The current codebase required lots of cleanup and reworking to
make the split possible as currently there is a greater use of
adding special function matching the phy_id.

This has been reworked to make the function actually generic
and make the change only in more specific one. The result
is the addition of micro additional function but that is for good
as it massively simplify splitting the driver later.

Consider that this is all in preparation for the addition of
qca807x PHY driver that will also uso some of the functions of
at803x.

Subsequent series will come with the actual PHY split and other
required cleanup. This is only to start the process with minor
changes.

Changes v3:
- Add Reviewed-by tag from Andrew
- Split patch 10 (at8031 rename) to rename and move
Changes v2:
- Drop split part due to series too big
- Split changes even more
- Fix problem pointed out by Russell (flawed reworked function logic)
- Add Reviewed-by tag from Andrew
- Minor rework to prevent further code duplication for cdt

Christian Marangi (13):
  net: phy: at803x: fix passing the wrong reference for config_intr
  net: phy: at803x: move disable WOL to specific at8031 probe
  net: phy: at803x: raname hw_stats functions to qca83xx specific name
  net: phy: at803x: move qca83xx specific check in dedicated functions
  net: phy: at803x: move specific DT option for at8031 to specific probe
  net: phy: at803x: move specific at8031 probe mode check to dedicated
    probe
  net: phy: at803x: move specific at8031 config_init to dedicated
    function
  net: phy: at803x: move specific at8031 WOL bits to dedicated function
  net: phy: at803x: move specific at8031 config_intr to dedicated
    function
  net: phy: at803x: make at8031 related DT functions name more specific
  net: phy: at803x: move at8031 functions in dedicated section
  net: phy: at803x: move at8035 specific DT parse to dedicated probe
  net: phy: at803x: drop specific PHY ID check from cable test functions

 drivers/net/phy/at803x.c | 777 +++++++++++++++++++++------------------
 1 file changed, 428 insertions(+), 349 deletions(-)

-- 
2.40.1

