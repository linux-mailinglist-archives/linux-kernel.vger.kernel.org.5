Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68A1800001
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377394AbjLAAOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377352AbjLAAOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:14:44 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6337D196;
        Thu, 30 Nov 2023 16:14:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-333308c3683so131140f8f.3;
        Thu, 30 Nov 2023 16:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701389689; x=1701994489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbMRUAfFn47SD4U+uFEOnC9vSvmwUi2NELQbNX2DDtA=;
        b=Y8Lu5ZJ5uUoM3fQHPT234pGNqTsADTnSPR37N6u4gZOYOSb4MJmZe5+xvbUWLs32rM
         YxdyeCznqi2NTRu6SgL78J7kL5NhzPT4XbTNWWeajdJyqpx+aSG08gvtgI30jiA5/Yqj
         XpyjA548HcT2rn15QOyTENdLZUVyJGIWGKPldTX47/OlDBHWpwQRVYuGx1a/rPAKupH2
         sn7nZ/XAk2H51KWL3Vm6OyB5+1aHZtDqS2H1OTrPbyjhzNj6dGkEyugLe5d/T+Ujdp1B
         AO5KnvHlpkHAiMSpok6ymlI4DXsqoYoiVb5jFn/vGCgMHnnOmdSe7JhMI/xWzlO53pD4
         ZsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389689; x=1701994489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbMRUAfFn47SD4U+uFEOnC9vSvmwUi2NELQbNX2DDtA=;
        b=O/J6TrKVNM44MpwZsAVwFObL9oLeRJ8Rrj3EpN/IK3RjzE8V8ifVpO55LhMM2cOrDT
         nh/wrB0mN+mQEgNyBobjiMSGVPoCviLLuNjDw+cbKA82mb4TJwvop21TutarouQVUwEY
         7MKFkGc3yldz+fMjihZZKnZa5F7U0DvAPXl/k/qvpbKuEX3OcUELcY8hCZvixkqZC3GM
         yOmcGJ5tU9g91cfx6xVy/HVm0XRbFZNxhfKVpAZd2xFkPDQDv0DpfLx6WAgp6KOvuL+p
         hFtfnUNlGx5SIcto4iJTJqpH6fRuxnznJZ1VVc+KypMlwrrK6dyHUR7XQHkOcCe1GJmV
         M3og==
X-Gm-Message-State: AOJu0YwUASC09yZ+OtED7hcCuG5jNKSrKyeZGM+4Rx0hvgdFiHDMlxbF
        6V5fgaT+wAVNKVVtakuJFdg=
X-Google-Smtp-Source: AGHT+IFwRGHS2tPjFk1hrnhXtuCfo2T+vO+mPvAHX1fulP9kHjEvYxhfoQuWC4gItjSIhrawmk0dmw==
X-Received: by 2002:adf:e983:0:b0:333:2fc4:464 with SMTP id h3-20020adfe983000000b003332fc40464mr147908wrm.93.1701389688625;
        Thu, 30 Nov 2023 16:14:48 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm3535457wmq.14.2023.11.30.16.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 16:14:48 -0800 (PST)
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
Subject: [net-next PATCH v2 00/12] net: phy: at803x: cleanup
Date:   Fri,  1 Dec 2023 01:14:10 +0100
Message-Id: <20231201001423.20989-1-ansuelsmth@gmail.com>
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

Changes v2:
- Drop split part due to series too big
- Split changes even more
- Fix problem pointed out by Russell (flawed reworked function logic)
- Add Reviewed-by tag from Andrew
- Minor rework to prevent further code duplication for cdt

Christian Marangi (12):
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
  net: phy: at803x: move at8035 specific DT parse to dedicated probe
  net: phy: at803x: drop specific PHY ID check from cable test functions

 drivers/net/phy/at803x.c | 777 +++++++++++++++++++++------------------
 1 file changed, 428 insertions(+), 349 deletions(-)

-- 
2.40.1

