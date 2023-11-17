Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B317EF436
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346061AbjKQOOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjKQOOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:14:06 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B7BC5;
        Fri, 17 Nov 2023 06:14:03 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AH8IefK017599;
        Fri, 17 Nov 2023 08:13:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=F
        wPEmYl6wbAvf5HjePnJT1k0yWGDTyNaKGDv//NqY0c=; b=S7y+KHNDlGvP5McII
        R7J5BOt/RQmu57E/ZrwWpws8PZ+/lFJp05S9gt+eHLwhpUT9e40eQbyaggRjXE1D
        S/pLbTmd6Z1wnpfA8Fd2iTtMfqVclm+85mg8Pk/FnH6JMLx0NMQKEiaNP9xdLrt7
        0FVjGuE7jRskK7S3Kv0WtKnKcv3ZxcnfHsXa702D8eFXTNF/jx0iciCnv7GO/opg
        f7xXNXqMAUnCeOcBLdOAqIGZDTj1OiSUfnkIyTZpb9SunvAwlqb4qZNZ8r52s2Ez
        QZc5CDwdRRzJDqVPmKJ3vtJ1TotYAbEVRosSfoaTlUH34wIFHcUrfl51hd6BVhMZ
        7GCxg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ua7w2qj86-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 08:13:50 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 14:13:46 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Fri, 17 Nov 2023 14:13:46 +0000
Received: from upx-tgl-008-ubuntu.ad.cirrus.com (upx-tgl-008-ubuntu.ad.cirrus.com [198.90.251.167])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A49A915A0;
        Fri, 17 Nov 2023 14:13:46 +0000 (UTC)
From:   Maciej Strozek <mstrozek@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH 0/7] ASoC: cs43130: Fixes and improvements
Date:   Fri, 17 Nov 2023 14:13:37 +0000
Message-ID: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: saRXQWLGibz-4ixkRKO05Tbv7HBcjCFf
X-Proofpoint-GUID: saRXQWLGibz-4ixkRKO05Tbv7HBcjCFf
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to add minor fixes (first two patches) and
introduce general improvements to the driver (rest of the patches)

Maciej Strozek (7):
  ASoC: cs43130: Fix the position of const qualifier
  ASoC: cs43130: Fix incorrect frame delay configuration
  ASoC: cs43130: Allow configuration of bit clock and frame inversion
  ASoC: cs43130: Store device in private struct and use it more
    consistently
  ASoC: cs43130: Add handling of ACPI
  ASoC: cs43130: Allow driver to work without IRQ thread
  ASoC:cs43130: Add switch to control normal and alt hp inputs

 sound/soc/codecs/cs43130.c | 311 ++++++++++++++++++++++++-------------
 sound/soc/codecs/cs43130.h |   3 +
 2 files changed, 204 insertions(+), 110 deletions(-)

--
2.34.1

