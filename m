Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3847B03F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjI0M0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjI0M0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:26:32 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB59E6;
        Wed, 27 Sep 2023 05:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+KG+O7RrcU10hE/8LXJXJXdJJiGC8g4Iy34+vz0zkLq8qEEv3eVg1qUBlhj5HzyTnj79a+YZtTr0x919y+mPSDkiyitQMUZh/SQCahNZGRSyO0cIAib9sXGIPYbZpa+9cXNF4jb74I49/T3JQ1SW9nCh3ZYPqchG/Zg2N21SFSWigRW9SCP2NmQXKlRjvvEmqVKPmMoIKU7k+uhg0t2bnfrcnu1yNuAJXOFpKrx+lYXGiSumY73sM3pk9YvjrAslTr2eFBmmSwq37x7cS3ebt0QjzDO1uoUmwQN1JOMi4W5kBDOIqrZ5GnR3EAkTokf8J9vHzxR0goFSevCNA3VTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jkjTZzXfGW/gQ8bE8PkKRfnxqXYGPBNT0oVC0GmzZQ=;
 b=EzzDmfkZfQxcWztDpIts1x0diOLPg9QI1VRewIks/Fhhtjvvc3x4jC10Fz1Eid3MYqddJ1yxM0u7VvMNV33XaKIojCMBGCJW+kBVnePivyAmE/npCn8F8dWwL4DJex2Zl5Hm0zTHnAb3E65BM/NtosYUd44vNAmy3BdIRmQaGzRHt5Rm326YnxIcIwBCwgTo7MVH422WxOMNkkBd75ZeblegBS5jappx7SCd2/YnGHb3e2p4ORwM8RTxe6KL/7c9jPiZ1ijrInhollIXoQHOrpylDEeA2W4xv1mYJzaAfHcYbP1NIOdArYm31uA0R3XSvHeMfEZlCiVHl3hObtyiOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jkjTZzXfGW/gQ8bE8PkKRfnxqXYGPBNT0oVC0GmzZQ=;
 b=OougMJCnpdFXnQmc+uI/9JovPU8Oc2FUaocq3zjxKHlZB/7GE7IJ98OLFwc+3ekmIzbrNvLNZkV2F1rNw+0vZMSqOTn8z6hurCfLanLRd/e8jPParJSYd1agzBUPN1uyryDN5meZsjXsmXZVi0C2yX/tmUiX66StK903RfINpCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB7704.eurprd04.prod.outlook.com (2603:10a6:20b:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Wed, 27 Sep
 2023 12:26:27 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 12:26:27 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v6 00/11] firmware: imx: NXP Secure-Enclave FW Driver
Date:   Wed, 27 Sep 2023 23:23:50 +0530
Message-Id: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc37925-da7b-4c19-bcd0-08dbbf54f85a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9QAdXbWvBBT03p7orH3VUHGfLx5ZB2NTTjAxbVsqy0PAGg9UaWWfvhTr8DZwhkhhq4jGW6YE3vc1CT8z13Qv4g1kfXAZdaaSSfbvZrPfwby+x7Wna4DHj7ME8Fl6hZr1oC30k0VGEr1HGTyuudL2HahZBfFNPIhPtwzPaE3NbFQ0FgL1MjVPRlOkHSEI2SZrcjzUOUb2LhAcTAkP1N58CV3f2jFTAHmUir9tyjUnxaDoaF4AbxVDY5qQuV2EjmtnqzOvpVmg/oz1TIupjyqTxkEpXGUF58OgHsU0NPbiDipDrkMz5XhCYAZTotDrKN4p6KBNPx65TG5XKj24ft4otFnx5ztNuApAZuv32BYxYR273cN2W/DBY/vkh4G/CcZTBSKHCxDAUiM5RVNvTZ3O0DAQ2E+eb/8GacX8bSbO21qBDMqQzciImc5LvTm8d1GT3p45THGtnhKKeF8wYl0CBHiyhCAhmkSVgofnBjUTe2uOfAZT+YEhm0ai+LI3YeJgjiD55v87ep6VnWN+dozhz1GAzc+1+2BLIQH4NjBWCJqkU237U4GlZcv/NndrIec9Je+TmWRQkXojZvIldxIMHDkOt0kbfzhgxOb1YbUSpe51Qlb52xOfJyT0Jp4jSLX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(230922051799003)(1800799009)(186009)(451199024)(1076003)(2616005)(6506007)(52116002)(6512007)(44832011)(26005)(8936002)(478600001)(921005)(5660300002)(6666004)(36756003)(4326008)(2906002)(316002)(6636002)(86362001)(66556008)(66946007)(8676002)(41300700001)(38100700002)(38350700002)(66476007)(6486002)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PHTbdS3ky+EBz3HwI0CL3QsMGd3Sd7SdG7O0LzI7z0Yiu3G1ftIbFS9uRijU?=
 =?us-ascii?Q?w+R2zgU8/+realC3ndvibfG1YSAd5OPk0ey6vKdpAUZKp2+oKMASNyhGY/7o?=
 =?us-ascii?Q?WdRCmW+xXip4SmVXhkO+w0BbYQnHiIg6ald9qOdKoVtn6CsFOTED3fV4JREP?=
 =?us-ascii?Q?sK+je5OubL5WxbuWehwb/P8igKgBA8yANRF7c3Zf8H3yaj0z4hFmTnj2FdcT?=
 =?us-ascii?Q?fVnXPWosnDIvvj3ZS4rY6HK8GdHpGl+cAawAS/cDrv3p+h7XsMB4J7CCeJBL?=
 =?us-ascii?Q?0BLUxz8ICoPOgjiok7XnqsYCZGxCVvau2Pu4a+IMYZPV73e/aPsenU1Vp6kw?=
 =?us-ascii?Q?xr8y2SPS6PIiRX9gSgPQNTrorbrlYEw9U1QyU5pCd2JvdQHMQbxMFf8fEL2K?=
 =?us-ascii?Q?70l0AOGlN/XyUF+lc0u1tjsexPX7gqWlw4sh2BVtYLtF2GzpLNeoZht6rHv9?=
 =?us-ascii?Q?5ms0RrX7IUL/yUwgld5yyIMInF8kPH7nsmHVIP0Awu0Ae78bcIPYZZZCJD1J?=
 =?us-ascii?Q?nMYUID5oYGibRttZmYuWWN5A37b4Kufv59Y/2Q/7UufsZz10SZMcTyWLPdNm?=
 =?us-ascii?Q?Tos2LZzFcSoa2348+JAdvT+xXOR1kx6nZhTaVuCghmwYKGP5YO4t/xr4LBfq?=
 =?us-ascii?Q?WoR1krhb+nJ2syRqrtCNzW790Jiiy++MN+7KMqGdWDSTxxQ74xGnOc1KrEXN?=
 =?us-ascii?Q?GJSLr8ZOKcCd8PUrbylmSOwE2KDVsFx3g6Qjzdf1+lwZC/wccmJ1FOKeee3H?=
 =?us-ascii?Q?kaW5icDvcUiaTkF1xQZBQVmADI93LUgbfCxZ7mNPOcBu+PGVn6Logyu/jH1m?=
 =?us-ascii?Q?HLHJF3XsV7/UXCYtKATyGMPEkgv5GZe6cgiUbyU8vNasfSbAwfZ6wvMPCc9t?=
 =?us-ascii?Q?NF56Lf9Lw8IZInyHzPf2ODfMJtLpzDsS4h+tGnMGYVcd4GlsJSjgAb5ef9vV?=
 =?us-ascii?Q?Z9t0J6ZfCtvC5S5pXPk1BnC/GeZ7NGgWjYZUcet4PIDJRIyKc2Ztf+na9Qfc?=
 =?us-ascii?Q?3HADO6F49wQ/G77QngRzSke2hYPCh2IFZuBQh1xt5D/Z8Fsz1S5jFMFIyF/Q?=
 =?us-ascii?Q?OJ7CduDqJv9euBoBzKl1LPtZ4oGGBoWMtV1fn1szslosgTArUwuhlqDkqxuy?=
 =?us-ascii?Q?Yqu+9tK4AqSd0YOUupJnsayoyLNMKYWLzQSBPg5HUCBegTlTv7BOCu707cNH?=
 =?us-ascii?Q?YBfLP+jeK6esPokvmAzWYWSgz/XkAdAS/8sUni4SAbb533V9/E71A6wR/A3Y?=
 =?us-ascii?Q?jktB7EMNTpv197jfGTTSd8mNJno8lW3BqbyWqsHXJbDbRQkGRJs96v7Dr6Oh?=
 =?us-ascii?Q?5duESc4z5o4EMCFqOjSwuZEarMcJjFxi+0lFAdWMQ1SkSnoEkaTkWMr3fmKJ?=
 =?us-ascii?Q?rAUu6Ptj0W1DCTZ0qMfMIJy7yA0s+/IcDK/ttht22cyA474l5GgnlOPZEkp6?=
 =?us-ascii?Q?ts38WeDQtep5NdVPJXn+T6xmuCsypMKYyda6/nvDffFm/1nXTQ6qGgW+sTwS?=
 =?us-ascii?Q?qKrJ+bFjFZLF9lW/d4X1dFLqWdq1FmFe9fPq2eFhS3f8igdu8iBfkBhhubuY?=
 =?us-ascii?Q?dJobSxdnA3oHDYqmlFvTEE5FIPFrRm1gqg+w2WoW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc37925-da7b-4c19-bcd0-08dbbf54f85a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 12:26:26.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLG09VjRZrPQFKC9GEWAFqFOolypHlMcUm2xN9MLbKFMZtL4wruhRmWo3o3lJUOwfqaghNVSICsCozvAyS0LxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7704
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 .../bindings/firmware/fsl,imx-se-fw.yaml      |   73 +
 .../driver-api/firmware/other_interfaces.rst  |   67 +
 MAINTAINERS                                   |   10 +
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts |   15 +
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |   12 +-
 .../boot/dts/freescale/imx93-11x11-evk.dts    |   15 +
 arch/arm64/boot/dts/freescale/imx93.dtsi      |   10 +-
 drivers/firmware/imx/Kconfig                  |   21 +
 drivers/firmware/imx/Makefile                 |    3 +
 drivers/firmware/imx/ele_base_msg.c           |  271 ++++
 drivers/firmware/imx/ele_common.c             |  294 ++++
 drivers/firmware/imx/ele_common.h             |   40 +
 drivers/firmware/imx/ele_fw_api.c             |  118 ++
 drivers/firmware/imx/ele_fw_api.h             |   26 +
 drivers/firmware/imx/ele_trng.c               |   47 +
 drivers/firmware/imx/se_fw.c                  | 1372 +++++++++++++++++
 drivers/firmware/imx/se_fw.h                  |  152 ++
 include/linux/firmware/imx/ele_base_msg.h     |   67 +
 include/linux/firmware/imx/ele_mu_ioctl.h     |   73 +
 20 files changed, 2725 insertions(+), 2 deletions(-)
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

