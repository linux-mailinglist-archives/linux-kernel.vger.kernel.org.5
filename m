Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F2477CCE9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbjHOMtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237292AbjHOMsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:48:47 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F421BC5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:48:38 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37FC59WE010995;
        Tue, 15 Aug 2023 07:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=Z
        E0qnOdBtKzLQtZ0IT5D4MO9KtCscaiR+dmQHQem3h0=; b=nCzLOQlX7NB+BUncn
        aNHPiKRfrCZ9kaJD25A/TsSCo9qZN+RQrl9YwKNxi3QxOgy5Htj2wsznxg0nH8CT
        1XoeS13Qf9Hwzr2cjav/2o+zR0I0PwUiMwGMF9owHRoPzWwSYhnuynzj644BbiXN
        JOeCqlG84IlnGEkVHvPF73OTDcg/YMxkWvSV6Oi525HolzsgpwxLNmHJOP6aFTVk
        m5bVFe30+HlRxQ+PVHRiQ14vqD5VtXOEfG37uQddpVZkAYkeTvbji4dRhYpmpWLf
        K5Tlm9Nr0Hz3z8YOZcJpr7tGRWAMg01ZHHuwB3ymg91AiHC5D3JQhDeVHIKH34er
        PuHng==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3se6uhjxk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 07:48:30 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 15 Aug
 2023 13:48:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Tue, 15 Aug 2023 13:48:29 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0EB9115B4;
        Tue, 15 Aug 2023 12:48:29 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/2] ASoC: cs35l56: Don't patch firmware that is already patched
Date:   Tue, 15 Aug 2023 13:48:24 +0100
Message-ID: <20230815124826.5447-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5n45QvV6BqyFdfmOYdkMs4OCCp_b1d1h
X-Proofpoint-ORIG-GUID: 5n45QvV6BqyFdfmOYdkMs4OCCp_b1d1h
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the FIRMWARE_MISSING flag in the CS35L56 to determine whether it is
safe to download a firmware patch.

Richard Fitzgerald (2):
  ASoC: wm_adsp: Support powering-up DSP without trying to load firmware
  ASoC: cs35l56: Don't overwrite a patched firmware

 sound/soc/codecs/cs35l56.c | 19 ++++++++++++++++---
 sound/soc/codecs/wm_adsp.c | 16 +++++++++-------
 sound/soc/codecs/wm_adsp.h |  2 +-
 3 files changed, 26 insertions(+), 11 deletions(-)

-- 
2.30.2

