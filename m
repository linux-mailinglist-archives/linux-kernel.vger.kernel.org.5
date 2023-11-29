Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BD77FCC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376744AbjK2CMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjK2CMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:12:24 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D919BA;
        Tue, 28 Nov 2023 18:12:30 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-332e58d4219so3614548f8f.0;
        Tue, 28 Nov 2023 18:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701223949; x=1701828749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgQ89J9c3uszO6o9xy/pNVP40wp2tzxLJEUGDYsTDYE=;
        b=k8My24x8PwzpoY62fB8a5q3uwG2mIwFnmYIIeXcKua6nk0U0IzMAQ2AUcpb8A7E3Ke
         qAer8gMDRO9Jl2y7VG4IAihOK/KWTPsPsM8CMIfG/J2ZxUTA9xlUvzBf4DH6K4TcKeBH
         4vwnafTr4m2SE3HAJALTz0HnCYNIztxgBENFM4ivkDoV5bvRSeXrHtXWjPJ1GTkht7JR
         F0F6HiV3cB/ihk3Q4/Wi8TMU9z2gQTpm6d3CkYTUAColJtWPSI96jfFawcJqE3zV1vOb
         +km3/enWob58YjFGgFJZvD6ZFydDSiRgk5my+Yoq26zYEc0PPvINQW8uOFriBX/Mvg6C
         P6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701223949; x=1701828749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgQ89J9c3uszO6o9xy/pNVP40wp2tzxLJEUGDYsTDYE=;
        b=ljZMBMtl5l3GOTfV3zsSnX+NYcgweJUMa34ODBCdcgIu0h2sIwYX6Y5vV/7On7/+7M
         +G1RbiqFt5iH7LfIzAE5d3se4DMSJJAWrs8yDG4/0TzEbPg8HeWGVIDbxA37WbxjiTbX
         l133hLZH0YcJ6nC3qKTR63SdxrcuInLDwPsKFi6kuP2i48w4wV0+7Xby9QQytw5X57v5
         gpVH9gxa+NZ6z1BTBog272u2tlm2DHK6g3UCNjmin4HAB1CeuaiZxeTtVV37TCQdzGOr
         G7WMMWQoWrLnYrK9YrjaT9S9YtJjc9NFgPVV0xMbIIqElq7eqIo7eVDgNYOjzoAF/W6z
         APvA==
X-Gm-Message-State: AOJu0Yx8wh9jxgrTsAZb1HAYqoAB/2IaT+3hQvrDtazOdMoYgRIwgfWW
        3gyJneEzEwKNL1IcPPlxgNQ=
X-Google-Smtp-Source: AGHT+IEA84J4BUwzgt6ri/sglZvQdT1+cylXfse8HAFnt5lCUSSK60IYq+Yui4VAWkUvtaDu+Io28Q==
X-Received: by 2002:adf:ee90:0:b0:333:ed:82e7 with SMTP id b16-20020adfee90000000b0033300ed82e7mr5949287wro.10.1701223948601;
        Tue, 28 Nov 2023 18:12:28 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b19-20020a05600c4e1300b0040648217f4fsm321406wmq.39.2023.11.28.18.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 18:12:28 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 00/14] net: phy: at803x: cleanup + split
Date:   Wed, 29 Nov 2023 03:12:05 +0100
Message-Id: <20231129021219.20914-1-ansuelsmth@gmail.com>
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

The intention of this big series is to try to cleanup and split
the big at803x PHY driver.

It currently have 3 different family of PHY in it. at803x, qca83xx
and qca808x.

The current codebase required lots of cleanup and reworking to
make the split possible as currently there is a greater use of
adding special function matching the phy_id.

This has been reworked to make the function actually generic
and make the change only in more specific one. The result
is the addition of micro additional function but that is for good
as it massively simplify splitting the driver later.

The main bonus of this cleanup is creating smaller PHY drivers
since they won't have all the bloat of unused functions or
extra condition (especially all the stuff related to regulators
that are only handled by the at8031 PHY)

Consider that this is all in preparation for the addition of
qca807x PHY driver that will also uso some of the functions of
at803x.

New Kconfig are introduced for the split PHY driver as they are
now built as separate PHY drivers.

Christian Marangi (14):
  net: phy: at803x: fix passing the wrong reference for config_intr
  net: phy: at803x: move disable WOL for 8031 from probe to config
  net: phy: at803x: raname hw_stats functions to qca83xx specific name
  net: phy: at803x: move qca83xx stats out of generic at803x_priv struct
  net: phy: at803x: move qca83xx specific check in dedicated functions
  net: phy: at803x: move at8031 specific data out of generic at803x_priv
  net: phy: at803x: move at8035 specific DT parse to dedicated probe
  net: phy: at803x: drop specific PHY id check from cable test functions
  net: phy: at803x: remove specific qca808x check from at803x functions
  net: phy: at803x: drop usless probe for qca8081 PHY
  net: phy: at803x: make specific status mask more generic
  net: phy: move at803x PHY driver to dedicated directory
  net: phy: qcom: deatch qca83xx PHY driver from at803x
  net: phy: qcom: detach qca808x PHY driver from at803x

 drivers/net/phy/Kconfig        |    7 +-
 drivers/net/phy/Makefile       |    2 +-
 drivers/net/phy/at803x.c       | 2248 --------------------------------
 drivers/net/phy/qcom/Kconfig   |   17 +
 drivers/net/phy/qcom/Makefile  |    4 +
 drivers/net/phy/qcom/at803x.c  | 1222 +++++++++++++++++
 drivers/net/phy/qcom/common.c  |  351 +++++
 drivers/net/phy/qcom/qca808x.c |  550 ++++++++
 drivers/net/phy/qcom/qca83xx.c |  275 ++++
 drivers/net/phy/qcom/qcom.h    |  124 ++
 10 files changed, 2545 insertions(+), 2255 deletions(-)
 delete mode 100644 drivers/net/phy/at803x.c
 create mode 100644 drivers/net/phy/qcom/Kconfig
 create mode 100644 drivers/net/phy/qcom/Makefile
 create mode 100644 drivers/net/phy/qcom/at803x.c
 create mode 100644 drivers/net/phy/qcom/common.c
 create mode 100644 drivers/net/phy/qcom/qca808x.c
 create mode 100644 drivers/net/phy/qcom/qca83xx.c
 create mode 100644 drivers/net/phy/qcom/qcom.h

-- 
2.40.1

