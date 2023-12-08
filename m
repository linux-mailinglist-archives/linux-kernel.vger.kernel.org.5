Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B507180A642
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574190AbjLHOyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574176AbjLHOx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:53:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AB51BCB;
        Fri,  8 Dec 2023 06:52:09 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c07ed92fdso22820065e9.3;
        Fri, 08 Dec 2023 06:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702047127; x=1702651927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oEKYKodY1E/giJPSN13CfW1nieKiaQr7P7WLnGy73po=;
        b=g6fFrmkg2IzYyrQuPXz3zU8/I+yZ1TWAcMuIU4suZQufC6L7sUXJP1mzJ0XWLqDCKW
         pqKqD/eRcQRjndPjd+7UDgnUqu4AffOuCtUvGpz7b0TshmUIFabF3GJbUT/4r8Edq8k5
         ts0l7BNnbfzuSKVolz0TNL48qjXM/KzAqxbEy3J3APcJOjALemNFyc3XNfU36hqlpp/d
         zlj9UOyadi9CgQrsCVlvyxRTAOsWUwdFiMMvHYL7tR0ErzMG16IevJiVdoj4kfgpUuCS
         1tzf/2SUg0btx5VYITtNH4PqrZEr/KTsAap0OPSqGCruuUB4SbIOGzbTBctJDK9kBtHL
         lgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047127; x=1702651927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEKYKodY1E/giJPSN13CfW1nieKiaQr7P7WLnGy73po=;
        b=KOC/o+gw6PG7Aep1/i1REXiAbGldGDNkjVPoEY7sPxqNncfybJfX883iQtEyIB1k08
         QDHmVT/LOEaAgJNjKLz7zcbqsFQgeKTbrLxBGyYcCyNwa0z3H5wac0d5JjtldfQbadty
         AnH1ij8xNVoeA3t4jb/OsVw+t2meHH9hSd/XNxBIGOzxA0MACzanZqk+zTnloYBVLiLm
         7G1dsCP576hX7lTl9oASaAN8dOQ69JSz/YaacJwR5Q+9gzzrdBGN0fKGFmIw94bwwfNz
         dWWAongkskoIs7pzrJT7sillE+rMFZ/BlfUqIbnMkZ73bmGOUmjsqXwD3XEBjXC0x231
         lw/w==
X-Gm-Message-State: AOJu0YwKho/XjIjjXvdFFyPAqbsGE+KIGXrja5XxhHBaxdkT5zl7aBGK
        KptN4TvYqIQVsNYpQAPV8mc=
X-Google-Smtp-Source: AGHT+IGcFb+VadFXu4tbDQ1WJOk1/14URdXerXIdSsNVHT4NUKJ1b0G1Yh9uLYpC+mij3zgsc8pLzw==
X-Received: by 2002:a05:600c:20cb:b0:40c:3464:f821 with SMTP id y11-20020a05600c20cb00b0040c3464f821mr55883wmm.68.1702047126647;
        Fri, 08 Dec 2023 06:52:06 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r9-20020a05600c458900b0040b3e79bad3sm3088264wmo.40.2023.12.08.06.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:52:06 -0800 (PST)
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
Subject: [net-next PATCH v4 00/13] net: phy: at803x: cleanup
Date:   Fri,  8 Dec 2023 15:51:47 +0100
Message-Id: <20231208145200.25162-1-ansuelsmth@gmail.com>
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

Changes v4:
- Improve at8031_probe function 
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

 drivers/net/phy/at803x.c | 775 +++++++++++++++++++++------------------
 1 file changed, 426 insertions(+), 349 deletions(-)

-- 
2.40.1

