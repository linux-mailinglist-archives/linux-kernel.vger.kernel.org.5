Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF8D79EBE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbjIMPAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240856AbjIMPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:00:38 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA9DB3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:00:34 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38CMxBYr012824;
        Wed, 13 Sep 2023 10:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=C
        2aOQUnst1sSvwyVTyYjTBnLEp5Xj6haYIZlFfs9Kyg=; b=fDrm011es/4gR/YmM
        SZZZwb4pgxzbui3FEXV2+d0bqASSQvR4obfUVf8BhkPzVCtNxyToQRyoqlJNbaMr
        ukbGIqfBJRfSJdRvOZS9yoVVtvzQYVfgpat9495aUR+n0au6im1V0A8hQSkL2bj7
        VkR3jyLx0MpZ6laq75UUdaabDji5J16LNSKxE0+zCS1UDaV87Rd4taQV9CPZxuTB
        px09dRwRc/1yy6weJY/33FYaB7JiExjed2eY+4TiEiyIrbg2rMg3s/eaoI7mITNu
        t8+qwBOY2TBZwfo5hwd28+IVVfb21uvN4YEV8P1adA/RTI/cV+ZohvV/f+ph/xWp
        Q/5Fw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7u125n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 10:00:22 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 13 Sep
 2023 16:00:20 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 13 Sep 2023 16:00:20 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.120])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D249C15B9;
        Wed, 13 Sep 2023 15:00:19 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/3] ASoC: cs42l42: Fix handling of hard reset
Date:   Wed, 13 Sep 2023 16:00:09 +0100
Message-ID: <20230913150012.604775-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8iOFmS7J4x_emYUOqk3LNtz3skRREkJV
X-Proofpoint-ORIG-GUID: 8iOFmS7J4x_emYUOqk3LNtz3skRREkJV
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix 3 problems with hard reset:
1. Ensure a minimum reset pulse width
2. Deal with ACPI overriding the requested default GPIO state
3. Avoid a race condition when hard-resetting a SoundWire peripheral
   that is already enumerated

Richard Fitzgerald (3):
  ASoC: cs42l42: Ensure a reset pulse meets minimum pulse width.
  ASoC: cs42l42: Don't rely on GPIOD_OUT_LOW to set RESET initially low
  ASoC: cs42l42: Avoid stale SoundWire ATTACH after hard reset

 sound/soc/codecs/cs42l42-sdw.c | 20 ++++++++++++++++++++
 sound/soc/codecs/cs42l42.c     | 21 ++++++++++++++++++++-
 sound/soc/codecs/cs42l42.h     |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.34.1

