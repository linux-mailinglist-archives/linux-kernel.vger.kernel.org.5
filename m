Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB7F769D68
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjGaQ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjGaQ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:57:54 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F36B1FD0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:57:42 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36VEwHWb032490;
        Mon, 31 Jul 2023 11:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=D
        pc3VbtcgH5dw2bWcYGHp9VKyHItpm8FBtHXtotTc7Q=; b=MojlI1S3wPIbyJ55f
        49XlhCZuOfQGuaxFAp0kHUVxb8Nb97wV1mS95+8frqoBDjAkl80nKdOkEAna6Laz
        mk6FD/mk/cp0YqsEX89vfqlrbOJPSxZoVKw3tOz7PqL4jcGADkRM/fsXAGroguiU
        0qxNIcrjtvpjM+HtPa3unJOVjz95VoEe+25oJJ2pOm6uQ+Tfzo0Rd+P/kvrnQE9d
        dfv3o4kWevy+l/cfDlVGAhFNVXFfkQSNaNmmaBz/JyzA2E9w6Mhe2xHq1gB6oy67
        +/kqAs7MAdpfUGl6d0i4Yk8L/y96TVIk8jCZTBBSZg0xWdRypm6Vpn3Hpsg6wU2p
        KfCZw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s4y6jsqap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:57:31 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 17:57:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Mon, 31 Jul 2023 17:57:29 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.107])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A3E4D45D;
        Mon, 31 Jul 2023 16:57:29 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/9] ALSA: hda/cs35l56: Various bugfixes
Date:   Mon, 31 Jul 2023 17:57:17 +0100
Message-ID: <20230731165726.7940-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: PWwIvLfDyaxyiRD9TvkGHVEfMWz1iJpP
X-Proofpoint-ORIG-GUID: PWwIvLfDyaxyiRD9TvkGHVEfMWz1iJpP
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A collection of various bugfixes to the cs35l56 driver.

Richard Fitzgerald (9):
  ALSA: hda/cs35l56: Complete firmware reboot before calling
    cs_dsp_run()
  ALSA: hda/cs35l56: Do not mark cache dirty after REINIT
  ALSA: hda/cs35l56: Call cs_dsp_power_down() before reloading firmware
  ALSA: hda/cs35l56: Always power-up and start cs_dsp
  ALSA: hda/cs35l56: Call cs_dsp_power_down() before calling
    cs_dsp_remove()
  ALSA: hda/cs35l56: cs_dsp_power_down() on cs35l56_hda_fw_load() error
    path
  ALSA: hda/cs35l56: Do not download firmware over existing RAM firmware
  ALSA: hda/cs35l56: Fail if .bin not found and firmware not patched
  ALSA: hda/cs35l56: Reject I2C alias addresses

 sound/pci/hda/cs35l56_hda.c | 91 ++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 26 deletions(-)

-- 
2.30.2

