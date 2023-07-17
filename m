Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFE575632D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGQMwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGQMwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:52:11 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B8CB1;
        Mon, 17 Jul 2023 05:52:10 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H5Tq4m020449;
        Mon, 17 Jul 2023 05:52:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=jmtjFxp42ZyNv2chltldYPbE+ncQnkd6aa9V2Suk64o=;
 b=E/2Em+lT6qKWwbKtRNH2JOqTJqnOjRSWJgWtnYehlS4heHNkZGBD0hFR4BMTNhPTVpeG
 oMvCN7rX8OWpXzi03g6jLZMD+nvOHLzyXj9+itCBguJsoBaOs6CXRkhiG3e4uqTwbQsB
 0KEAUlMD6qTdTO0+xndxTYS1A5dpYLJBkB3+xhnSHtkFdq3GM2sdcQ+e2N2RzumhTY4e
 UQMF+Wep9g7zdfLDpFZqyi108GEzPH6I+My4SRv83ARbazFlsB5UMNwEmjxPVeB1Ta7v
 FJ5VS/JixXrXXBc9E6z3JfoqsUlxlHzu8g1Fup6xu5iKBiDn7zYwM1u8aTirdgACC8+w NQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rvyhx18hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 05:52:00 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 17 Jul
 2023 05:51:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 17 Jul 2023 05:51:58 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 4F63D3F70A4;
        Mon, 17 Jul 2023 05:51:58 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v4 0/6] mmc: sdhci-cadence: SD6 controller support
Date:   Mon, 17 Jul 2023 05:51:40 -0700
Message-ID: <20230717125146.16791-1-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: T2E7MBMrWTxUjv1d51-exHQETXgqh58R
X-Proofpoint-ORIG-GUID: T2E7MBMrWTxUjv1d51-exHQETXgqh58R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_10,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added changes to support SD6 controller on Marvell CN10K SOCs:
- Restructure and reformat the code.
- Add SD6 related operations.
- Support added for MMC_SDHCI_IO_ACCESSORS.
- Related changes done in dt bindings.
- Support for debug option.

Changes since V3:
- Adapted to the new code structure sdhci_cdns_drv_data.
- Added controller version specific phy_init separating SD4 and SD6.
- Added SD6 compatibility check for SD6 specific things like
  quirks/version.
- Added marvell specific string to dts properties.

Changes since V2:
- Added separate patches for renaming of functions and
  restructuring, adding new structures to support SD4/SD6 operations.
- Added proper suffixes to properties in dt binding.
- Removed unreachable code.
- Handled sdhci_cdns_uniphier_pltfm_data similar to sdhci_cdns_sd4_of_data
  as per the added structured design.
- Used dev_dbg instead of DEBUG_DRV in debug patch.

Changes since V1:
- Added separate patch for reformat/rename changes.
- Enabled MMC_SDHCI_IO_ACCESSORS in config MMC_SDHCI_CADENCE.
- Used proper properties in dt binding.
- Removed patch of config option to change default for sdhci timeout.
- Resolved issues reported by:
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>

Dhananjay Kangude (3):
  mmc: sdhci-cadence: Rename functions/structures to SD4 specific
  mmc: sdhci-cadence: Restructure the code
  mmc: sdhci-cadence: SD6 controller support

Jayanthi Annadurai (3):
  mmc: sdhci-cadence: enable MMC_SDHCI_IO_ACCESSORS support
  dt-bindings: mmc: sdhci-cadence: SD6 support
  mmc: sdhci-cadence: Add debug option for SD6 controller

 .../devicetree/bindings/mmc/cdns,sdhci.yaml   |   52 +-
 drivers/mmc/host/sdhci-cadence.c              | 1613 ++++++++++++++++-
 2 files changed, 1603 insertions(+), 62 deletions(-)

-- 
2.17.1

