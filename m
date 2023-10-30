Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6B87DB708
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjJ3KAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjJ3J7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:59:55 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C632133;
        Mon, 30 Oct 2023 02:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvUdZran8XX1zKL/QIWWu46MAg4bV/hJYT5sKpCR8j5VJpKqhxAND3gpEf69Di0bCJf/YhrwefJLLCxqfrpjJgyvcHnGPVTpKl+ZwhpBPzl7v3wTVlwjtB5eNqzp3vQXlZZ0hcT82WfbPcWtyjJ2NKo6CsYNVmoZupUDwtY5RxF0FQmfTa1XXPspHYAqvmVoRts/g/H8TxvoTLDAiQRB7h6Kqnrrutse7AFiK3l6O1bj05abZ0dOvZoW/C1GlemI6ZZe+qEWUz7yjHbFfUA94lO1wpLpV2vlpB1++VJPjj4fBNBuv74nhRC+byTOsU4g5cS65mV7vHo296Pr7g8Ebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjTqOHOeZ/NVLKd9lNYRmPSGYlvl7aEySjLoUYNtkAc=;
 b=aAaR6mhN32uq9aecICn49fgN76MFi1+GsSlFvkVJezOoiyo9HtjXfwwaVaXS0na1+nKWYd2MH4mgNXKy9Ekol1rH3ds/0hn3A53+Pu+PuJ0AYhivuOTiazF9KQvQuyPT47SoZQIiXOpeVQ1DOoEdm8OLOvoIjE5pniKAyuGEYleZCLpYJsWN0QNKM36Kqx4M/YFst8/dcQ0aNE2BGbBg0l163mRTIz5cuzi6G8SnTtHgcEOOPXxw0hb3lKwMrMNMF5KtrOgUUFHbekDNjJ5tttwAFJ62XQWvxRyfI4ItpLYp5/bybcaaWS/vyXw4jZiWtB89lJozzr6tvb9gXAiSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjTqOHOeZ/NVLKd9lNYRmPSGYlvl7aEySjLoUYNtkAc=;
 b=kNT0hbKhnmh9LptVbALW2ND8ABoCzs57dj3kWCfHi7hQ1GKpNh2kddKPrMo379ra57ZhiAVGB0JkWaHtigQ5hDncvsdDWWtWJ1ghzNk284/HKWJVgWydcFXTZgt1//uKIT54hbP5OLkdXo3V8dtrOu4bl7G0v66SIqcDEPrZJRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Mon, 30 Oct
 2023 09:59:28 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351%4]) with mapi id 15.20.6954.016; Mon, 30 Oct 2023
 09:59:28 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v7 00/11] firmware: imx: NXP Secure-Enclave FW Driver
Date:   Mon, 30 Oct 2023 15:28:38 +0530
Message-Id: <20231030095849.3456820-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 976b661e-733e-465e-5b2f-08dbd92ee77b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ye7vGccLbXgXf8ISTsrG+BVOtC88Nq0CzyZ0MaUPth+V7rQWiO318t9MF8jEdKPirE5++z97NA9/usMImdrw6FGQioKM5YD/OdB9si2558F5WOQzsq9jmc/HS9DKb5EQwbnqWntmBVUBbVpwervsBIYebIS+i+1iETBYvzIaYEr+5hoLAkqDRFYsoB+hgjQoLXVrpFC21psIvFlm9ejIp/tn5PQGbur77Br84H5IRW13fcs3WpAIv4KUHPJp9DjOU7wR3MzdSBKcwBwEmxpvmJahb9uFFJv3EgEt1ccCNwcS2lxZm/D7l+wH3AlKlY9Sy17Zt3sKN9Iz4m12/ohzAdU9y22fADD/Z7PYHqIZfpgM/q6Wn6xJFGNuyLVVZ9e3hsmhzU/QImKwRnqbB8F5D3Rw+jJtYhjgqKc9aNF1gUaDBqQpiMciK5gyDkm4nPYXLZJLDZipcTPAjV1tUJBf+P/MSX4QlV2bI6tbYBcIOad/ckL/fjet6Jk58NuyjCshZr7UA4fMc4F6cc7H9Waultz00QLAdleVNA+yp62eMKROQMze5e6QSBd1GudmOJKOmRZUDT3WKatICkjpW/NTKFW+n01kOsQ0IqJzNeMQbGC1egHxUroPeKdTZb5GmsVQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(478600001)(6666004)(66946007)(6486002)(6506007)(83380400001)(36756003)(38100700002)(66556008)(1076003)(2616005)(66476007)(2906002)(41300700001)(26005)(52116002)(6512007)(44832011)(86362001)(38350700005)(921008)(6636002)(8676002)(4326008)(5660300002)(8936002)(316002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LGKQZaOwmnAG5HA7jJvo33gPeTGBMmVNKO5mh1nrWqm5QQWym5dSinxFmnve?=
 =?us-ascii?Q?EQLwTCx2uQdrHUkFPNqoADNHHcq+cgwY11pKH7WjJ2PvsPvwp1ePicHRq4+4?=
 =?us-ascii?Q?ENzsoHSnskIwbA4pO6IVEdWsdq3ugzd1HgrqsDRgtocjI3+uo1bq6eCd30LF?=
 =?us-ascii?Q?LvdQS9udSqmnHEzDcZsoVj6KTrXHUulReBSXo/ecbicbPNX/GYRUVNEZEc3m?=
 =?us-ascii?Q?UegJkLTXtWJXTHqGe/J/8cX8wzP6dlVu2WxuC4wxPqKPYX30P3qmaNTyZPWJ?=
 =?us-ascii?Q?VHGAVJkN9Wwbxy4rZU3iMDVukpnyz4cMBfd85udAMyyU5dV0IQnB97g0Exm2?=
 =?us-ascii?Q?RpUNbrLO1jOOb/qhZNBIBt9RbHdNP+Ttt3fdLl/dtoOvOx0mEN0hWsZRkgo0?=
 =?us-ascii?Q?qGIw2xHpEsZixZSGRM6vDNOoVz9UH1uXe+KT0Xl8DUF861xgUDoCj9v/YkSF?=
 =?us-ascii?Q?+SKipOlL9MFnmoCxDhOdKSp+uIAbNFzNjbtoZs9uWZmu/Ttu78wWZmGlZT9W?=
 =?us-ascii?Q?mOtc1sWPXcc4AFwOyFoclXUBX7LYx8muIil5dRhzY3K6hlzA45aXMnudEm3T?=
 =?us-ascii?Q?8kkq1hpTfK5bLhD4ZHVZkWrk8NrukR6zvDxg17v+W+FlanYMy0wr1Lyy45yp?=
 =?us-ascii?Q?wmqsUEuxSPC4xEOA5Kue0sxFmcNeoPG7HlzdYiPOneGXMtmDTk7R0JeGNbBx?=
 =?us-ascii?Q?HbkWwg+hgBPoVLhCZrBHdW4vVYKwAfsJdwUlgUtrY4Te4UyWZ3fhiFL2DgOi?=
 =?us-ascii?Q?8OdvJWwbNo460P1Zps8+FPuiDHniww+pp6B5q9pauzZgVrmuQFf1vMa9WG5A?=
 =?us-ascii?Q?GMIn7Nc4/+Ws/8Wz/ZBHslB7yv4MwfqkWBEVdobfP4b34kAsEaJPUh99zOXP?=
 =?us-ascii?Q?gmCemnHre59kUHjLP6suTrAAgFX4rkzoH3oLOh8Sbjt0WJwpBeork1Hrk1dp?=
 =?us-ascii?Q?kbtZ90fZqLh93FwCn2ig36S2xQDAqXfDDJnvAHD/8TXvhASp8ZHcJCkjwM90?=
 =?us-ascii?Q?RcXMbNfpum+aun7yrPV0Ogw/i48exP5+Emni+qd+lj2CohxnE0VPFht5/OdD?=
 =?us-ascii?Q?jxaCjAbACF7GEz4dAevqciNXbCG1jZ+1zBXJo3Ur75t9E01cCSSPqge31Dsu?=
 =?us-ascii?Q?tR9KQrI2w+QCwWcGALL/7AsfIfALdURxumBmgGXmpeTxVdZSxEkZfCq6VjMy?=
 =?us-ascii?Q?d21XKRT+yZmuG7SU6+2OyEYECPknm+jyq+gkTpFmTqPU6Zk49aCxayeDoBjk?=
 =?us-ascii?Q?mVger8e/5VkcG5DDza00Yh1CS4ZGehR6vi1DXoiL+1GSJIgYmsVBixi8rqN6?=
 =?us-ascii?Q?et0nfBN7/5Vtnn0Cv5qagKnGKUbk0VZSoVkmch7TLeAjN7vzMSVaG4gLewgC?=
 =?us-ascii?Q?BXODbpzeyDMf0ceijuVEvjGa8y6hu9gWl0UJR5K5ezxaPiBiRm0J9OaDE9uH?=
 =?us-ascii?Q?5g97Z0PbQVQqaPgbY7SMw1TACQtY/73CJBwYBKuLUykj6w0XimAItRpGMBuy?=
 =?us-ascii?Q?T0901c0BBY1Dw8U9KIfdHbj9a45+LpXNlog86U2Xsc6VrGhJEMZhjhs4z9+O?=
 =?us-ascii?Q?pJhkDWh3KtTjzaMFFGfq5QMDMrHYIyQpqe1z/Ygb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976b661e-733e-465e-5b2f-08dbd92ee77b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 09:59:28.1486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wK4IsXvT0jF3z12j2CQ1Molr57qcOcGaMUn4foMf34+yifZtrurggQldcx/oGIBukVmzP5ZtmuVJMbTLeTVwlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V7 Changes:
- 2/11 DT Binding: Disposed off comments from .yaml
        -- added | to preserve formating.
        -- removed extra spaces, restricting under 80 col.
	-- replaced the "fsl,sram" property, with standard property "sram".
	-- Added details about usage of sram.
	-- removed the property "mu_id".
	-- Added allOf:if:then: for reserved memory.
	-- removed label.

- 3,4,5,6/11: DTSI changes:
	-- removed the property "mu_id".
	-- rename node-name & label

- 7/11 firmware: imx: add driver for NXP EdgeLock Enclave:
	-- Removed dev_err for the cases of failure in memory allocation.
        -- For others, coverted dev_err to dev_dbg.
        -- Updated the commit msg about the details for userspace lib


V6 Changes:

- 1/11 (New): Kernel doc: "Documentation/driver-api/firmware/other_interfaces.rst" is added.

- 2/11 DT Binding: Disposed off comments from .yaml
	-- replaced the "sram-pool" property, with standard property "fsl,sram".
	-- removed the additional details from the description.

- 3,4,5,6/11: DTSI changes:
	-- Validated using the following commands:
		--- make dt_binding_check DT_SCHEMA_FILES=freescale
        --- make CHECK_DTBS=y freescale/imx8ulp-evk.dtb;
		    make CHECK_DTBS=y freescale/imx93-11x11-evk.dtb

- 7/11 firmware: imx: add driver for NXP EdgeLock Enclave:
	-- Removed:
		Reported-by: kernel test robot <lkp@intel.com> 
		Closes:https://lore.kernel.org/oe-kbuild-all/202304120902.bP52A56z-lkp@intel.com
	-- pr_info is removed.
	-- macro "devctx_info", "devctx_dbg" & "devctx_err" is removed.
	-- Updated ABI:
	    --- Users: user-space SE-LIB, crypto-api, imx-ocotp-ele driver , smw
		--- IOCTLS: Updated the ioctl
		--- read/write: 
	-- Correct message header validation.
	   --- segregated handling of the error, while msg header parsing.
	-- removed TX and RX messages static allocation in state container.
	-- ran coccicheck: make C=1 CHECK=scripts/coccicheck drivers/firmware/imx/*.* W=1
		--- ran on all the patches.
- 8/11 firmware: imx: init-fw api exchange on imx93
	-- removed TX and RX messages static allocation in state container.
	-- moved the header file ele_fw_api.h, to driver/firmware/imx/
	-- segregated handling of the error, while msg header parsing.

- 9/11 firmware: imx: enable trng
	-- macro "devctx_info", "devctx_dbg" & "devctx_err" is removed.
	-- will remove this patch, will send this patch later, including RNG and crypto-maintainers. 
  
  
  
  
- 10/11 firmware: imx: enclave-fw: add handling for save/restore IMEM region
	-- Linux comment style fixed.
	
- 10/11(old)(Removed) firmware: imx: enclave api to read-common-fuses
	-- This API will be used by imx-ocotp-ele.c.
	-- This patch can be sent later, when the changes to imx-ocotp-ele.c will be sent.
	-- "Documentation/driver-api/firmware/other_interfaces.rst" will be update for the exported symbols:
	   - read_common_fuses()
	   - get_se_dev()
	
v5 Changes:
  - 1/7 DT Binding: Disposed off comments from .yaml
	-- to use "-", instead of "_".
	-- to use generic name, concatinated with soc-id.
	-- removed mu-did.
	-- renamed the ele-mu to se-fw
	-- moved the file from .../arm/freescale/ to .../firmware/
  - 2/7 Changed the .dtsi, as per the comments.
	-- removed mu-did
	-- renamed the ele_mu to se-fw.
	-- updated the compatible string.
	-- tested the DTB.
  - 4/7  Changed the .dtsi, as per the comments.
	-- removed mu-did
	-- renamed the ele_mu to se-fw.
	-- updated the compatible string.
	-- tested the DTB.
  - 6/7 Changes in driver code:
	-- replace pr_err with dev_err
	-- removed export symbols, except one, which will be used in other driver.
	-- Each API, send-recived based on device reference.
	-- Divided the commits into smaller commits.
		- Base Driver
			-- Added ABI file.
		- 7/11 (new) firmware: imx: init-fw api exchange on imx93
		- 8/11 (new) firmware: imx: enable trng
		- 9/11 (new) firmware: imx: enclave-fw: add handling for save/restore IMEM region
		- 10/11 (new) firmware: imx: enclave api to read-common-fuses

v4 Changes:
- Post internal review, changed the name from "ele-mu" to "se-fw".
- Disposed-off comments in the dt-binding file.
- Removed the non-hw related dt-bindings from the driver code.
- Corrected the File MAINTAINERS for correct name of yaml file.

v3 Changes:
- update the commit message for documentation.
- Fixed dt-binding checking error for file- fsl,ele_mu.yaml
- Coverity fixes in the ele_mu.c

v2 Changes:
- Fixed Kernel Test Bot issues.
- Removed ".../devicetree/bindings/mailbox/fsl,muap.txt"

The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded
secure enclave within the SoC boundary to enable features like
- HSM
- SHE
- V2X

Communicates via message unit with linux kernel. This driver
is enables communication ensuring well defined message sequence
protocol between Application Core and enclave's firmware.

Driver configures multiple misc-device on the MU, for multiple
user-space applications can communicate on single MU.

It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Pankaj Gupta (11):
  Documentation/firmware: added imx/se-fw to other_interfaces
  dt-bindings: arm: fsl: add imx-se-fw binding doc
  arm64: dts: imx8ulp-evk: added nxp secure enclave firmware
  arm64: dts: imx8ulp-evk: reserved mem-ranges to constrain ele_fw
    dma-range
  arm64: dts: imx93-11x11-evk: added nxp secure enclave fw
  arm64: dts: imx93-11x11-evk: reserved mem-ranges
  firmware: imx: add driver for NXP EdgeLock Enclave
  firmware: imx: init-fw api exchange on imx93
  firmware: imx: enable trng
  firmware: imx: enclave-fw: add handling for save/restore IMEM region
  MAINTAINERS: Added maintainer details

 Documentation/ABI/testing/se-cdev             |   41 +
 .../bindings/firmware/fsl,imx-se-fw.yaml      |   83 +
 .../driver-api/firmware/other_interfaces.rst  |   67 +
 MAINTAINERS                                   |   10 +
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts |   15 +
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |   10 +-
 .../boot/dts/freescale/imx93-11x11-evk.dts    |   15 +
 arch/arm64/boot/dts/freescale/imx93.dtsi      |    8 +-
 drivers/firmware/imx/Kconfig                  |   21 +
 drivers/firmware/imx/Makefile                 |    3 +
 drivers/firmware/imx/ele_base_msg.c           |  271 ++++
 drivers/firmware/imx/ele_common.c             |  294 ++++
 drivers/firmware/imx/ele_common.h             |   40 +
 drivers/firmware/imx/ele_fw_api.c             |  118 ++
 drivers/firmware/imx/ele_fw_api.h             |   26 +
 drivers/firmware/imx/ele_trng.c               |   47 +
 drivers/firmware/imx/se_fw.c                  | 1376 +++++++++++++++++
 drivers/firmware/imx/se_fw.h                  |  154 ++
 include/linux/firmware/imx/ele_base_msg.h     |   67 +
 include/linux/firmware/imx/ele_mu_ioctl.h     |   74 +
 20 files changed, 2738 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/se-cdev
 create mode 100644 Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
 create mode 100644 drivers/firmware/imx/ele_base_msg.c
 create mode 100644 drivers/firmware/imx/ele_common.c
 create mode 100644 drivers/firmware/imx/ele_common.h
 create mode 100644 drivers/firmware/imx/ele_fw_api.c
 create mode 100644 drivers/firmware/imx/ele_fw_api.h
 create mode 100644 drivers/firmware/imx/ele_trng.c
 create mode 100644 drivers/firmware/imx/se_fw.c
 create mode 100644 drivers/firmware/imx/se_fw.h
 create mode 100644 include/linux/firmware/imx/ele_base_msg.h
 create mode 100644 include/linux/firmware/imx/ele_mu_ioctl.h

-- 
2.34.1

