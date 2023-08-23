Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67ED78519E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjHWHev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjHWHeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:34:50 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC8DFB;
        Wed, 23 Aug 2023 00:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kzsu37T27uvlZb6l4NKBlc+hiXy6j2V6kXhZVHjOxeutr22VubB4Qo6OPAp0/m4zF7yGTTOPzvcVuMwYnjkROGW8c+xx0ttFrekvDDFLcgaAF6HVaqi8TIg+YA+osxIMsLAw2SKwBXbkTHjimfnca0LA92O0SSJ430GdsLSRsFzu2IgpiBarcrkOlkVhp9+40T28ybqLlS+YWmIrz8ydkyd/E187roJtN/W1rOkELpsN1sAyucMSxFQ0f5tGrnHCuEnunRCeJGHDA1zZPB6AjUtNbYTJsTndM1LN4KlwYxixzP60S5GfBM2duisx0ZK2fQb4ThKRLDDhwtuhb3qgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kCbXEAEVU62oQ29MBuWHA7B2lYm2gYVVW7wG/sxUTo=;
 b=Bo/v2Z+xADeVHiNcLuMbFCQyv6oruboCocrHzOHuDHhvL62VLZeA2E9vh/lWjZURpkbg2nDoDQbzdZ7R03TfWoXtxwtjQAE8X1RxCN7sowY42Q+S3m5EllORRJREOq/Ni+dclvyTnGM5/NUiKgItYUhV8DXgwki89+6a29S6uTRE3JEUEKHzL0i4SmqoAWoOxA/F5f6JXnzaxIpS/IbnTzEnUoczwyKleJarq7o2IKIM9BbeGvTVWeQ/7k1ooqLSu1ikRJK4lEZLZw1mxO4Ff6pGx9a0s+Y4POt1m3ylG+IB5hMuIWlAz6wwTqC5/cy93z1X6ybzJUBJxyhAEoi/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kCbXEAEVU62oQ29MBuWHA7B2lYm2gYVVW7wG/sxUTo=;
 b=blr+YTX2t+jKjo4pGsXNwUk4hXbFTdz2yN1hSNQUAJwSdOhSLgZTkCcGmsxmD9pM8QhfsPeTjod6fc5s0Z4D/Ww1xLfZ4U5PUq2bIcKiKvk/lsXULbf6xtlTqLirMBLLrC5kEAMf+mEWwBzo+pDnLb9U9iKepPfnktgBKem7bUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 07:34:44 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:34:44 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v5 00/11] firmware: imx: NXP Secure-Enclave FW Driver
Date:   Wed, 23 Aug 2023 13:03:19 +0530
Message-Id: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS4PR04MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ab42bf-6aed-4553-6cb9-08dba3ab6b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NYF6QXFP+GaVMlmKmepYiTssFRyVS4cTkzFGRvtskgNH0GYmrOWfu6V5KoFoMfS4MHAX/P4SzMRKp4MJOZyNMOMquin55RyyYiOzy3PRcm3Fb/pSwONtB2efDjWol8WKc2lefZj9V2HMlHaUD5YIJDu4WUP1LxcAaZZyNtJ44ZyiXqYG/qEhX+q3xet8IbJozPOpS8mMy3Ms4H1WP+E0wRzmLiXjk5Som2h8hH3OxHbfSnzq7UKOdWM5lwCSHMzHsKmfoZ6muRieiMXT9G1sJB1I0H3+bf13SydqU4mD0jRthuNSIXFDMpFzADVb60gil/z/5QlNA7R7m9zNDh+cyCUiz6BZCPnqF41RUdTOMjEOqrPBVspiqcmoL0mVvklqkEK4Eb3P7rXPgT8Hd0t0VccQYMPy5nez68rVJr0SIbQxv/n6M3uONMycbTQy3D8150xK0AkakFptUM1iK9IW92Ux3IgoB9DYt0CPGsp5C++Mjx1KEZnWbzrP9SMtX5WN437ix5cvK1lNcdjvaBXhwbu58xLGKByBAscxKU7kwboA15q/EDQUNX/qZr5cCrAgFmp9IxOLPeDO8z9+PgCyMgSVn8lq5VlHPqfZAFdHFQd/b9Gjsr0TaK9wV8S25Afb+9nATrJhH8nKzWcu0MK8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199024)(1800799009)(186009)(2906002)(7416002)(38350700002)(52116002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(44832011)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(66556008)(66476007)(6636002)(478600001)(921005)(6666004)(36756003)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?huVTqE/lkprhUZqF1k8a+E99fJrQjiEMS3TvEbn7WveRvuUqcCQgfaNI41AV?=
 =?us-ascii?Q?eJD10cL0ZE1ddUrKSPKWD5LuNktS9PQ2OOMKtOrDpCqhkZ0Z/0pDi3N5PB2c?=
 =?us-ascii?Q?3FCDSN3bAAP/IYOVWAAhpv1MQkrjqJdMQGyQSn383ibeDx38zoc177HKtqDh?=
 =?us-ascii?Q?JfCZtVh+2cKEHqEOk8lhFpTT+HK3jVqID5HX3hg+mVWf7xAJ5OMh0a0MwjVa?=
 =?us-ascii?Q?VkR4CXnGv4yV/c+nruVFqlEfqWyewQ8C/NBLK9rnbp+O44o1QsYpQ6b/EUBu?=
 =?us-ascii?Q?UrI8Jj0UFR6kq8Icl9+qK2eovu1rcZqTeKeUAZ04sbZEI54hmiGO1kFqBuGK?=
 =?us-ascii?Q?eQvpOcluHx4/I9M3bxllSA1Q8svzYV24FPTnnb5sCWwdnFLxXLkPuav9Zo5X?=
 =?us-ascii?Q?OcaLEoHsgfTRz5zTDi3zfSCGV7LT+y9t+n9V5Mi+nkbsul0Cnm6pxPaUUpQ1?=
 =?us-ascii?Q?OqwWf5RFkzHAj6gj9mzbeyRSgfB2nQMqJIURD13QJEgDVnsMEth3GrNK5fO9?=
 =?us-ascii?Q?0dLBzYwcARQvegevw1yQS69z/ifhm1GJsN4HWZ4aS0KjQ83EOzcn29efSM8J?=
 =?us-ascii?Q?fhRmR/7tU0SLc7ebIcU6nhz3MCkYp1hh7euIhjWxBGj8RJVErtkvliCRgMbw?=
 =?us-ascii?Q?Rf4SOBaB5ncS0yF7P2GKaEkVZ+mUF2Hq2mIP8BPBAB+F21itn1/ahiepN22z?=
 =?us-ascii?Q?aZVF95v2P7xEJWCx0M5eQMZeo6apnOWc7msFFg5f57g9lVrcVEYAHIjf4u5v?=
 =?us-ascii?Q?4Yf7s6BxvXvOTvYS+d0EQRaDrilusBc+kiH7cPfHTuw+YVRfnkvl3ym1eg99?=
 =?us-ascii?Q?BqrNUx0xDdz/sS6Ok7PsOqslDKiXy6m50DEhN/HPYCR14ojBqUnoRPMsn+AS?=
 =?us-ascii?Q?+2GB5s5glsy1M4SejAahiwpRFz6ozfWjAhp3CZ1jLrScaW8EakB+YqqChe3a?=
 =?us-ascii?Q?YdF1YMtNsgJaZlg4AKC35lJRxQVkMP2dzlbnS3IiZsfMWbEMcCTM90GLe42X?=
 =?us-ascii?Q?6i5YO3MUa+/jU4nwVhPNE6Gf2j+sLLXfDsgWD26Xp63cyeGVjTumUli43HT8?=
 =?us-ascii?Q?Vk0ZYc933ZlmK+vhHdDhzCd/3SnTy4zT+dn1ERyb4BtbL3egoqjCXO+2P0Gh?=
 =?us-ascii?Q?irJUM56JZDzbrZ3bNqb3Tm8fADrszvOuNSThJtzgfqyKkC8RYCOVXFASZvut?=
 =?us-ascii?Q?5r3N4BYJlQhIUo61mxHFmqgWukMWlBt0dUyK2Z6fhUvrL7i2J+HmUVm+Ek7u?=
 =?us-ascii?Q?CDDJhCnInTo7hbWgUPcRRZkvHmTBH1675h1BhMJjw6v5XLUGn0DMWdEypKZp?=
 =?us-ascii?Q?/9P+ArLRXgF7Im2nFBs4xpye551VZzFIeNxc1ES8H8CLqAB1ZfjNtAtAxsim?=
 =?us-ascii?Q?0HMN74DuQvMQQjtk3olS1sAK//mmddUku99PyFaOkiQ6ep/b1lK8+r1Bt/id?=
 =?us-ascii?Q?gsqP0I/8NTshJ78QZ4zt2dJ05fyIgOWaXPy4ItP8kxmdWxDhiMC5FGEs6mMj?=
 =?us-ascii?Q?PVbCFaY19311PtOnhKicP8+8yNCK/8czgSJNjHIgzPJiOzbvnYsifxMrCyzM?=
 =?us-ascii?Q?EVKohZOp5SH+hsRF1T+wFtt/f2cbCH/LvUP0WaC/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ab42bf-6aed-4553-6cb9-08dba3ab6b56
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:34:44.1347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2NAcIcn7LhXQInHEYfOH+5pNVcpfmFj5HvGgOg4rtMuWiZEjjWhYlyuV2q18tHJh5jb4AuodSuuvqFROKrywQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
		- exchange init-fw message with enclave's fw
		- enabled TRNG
		- read-common-fuses

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
  dt-bindings: arm: fsl: add imx-se-fw binding doc
  arm64: dts: imx8ulp-evk: added nxp secure enclave firmware
  arm64: dts: imx8ulp-evk: reserved mem-ranges to constrain ele_fw
    dma-range
  arm64: dts: imx93-11x11-evk: added nxp secure enclave fw
  arm64: dts: imx93-11x11-evk: reserved mem-ranges to constrain ele_fw
    dma-range
  firmware: imx: add driver for NXP EdgeLock Enclave
  firmware: imx: init-fw api exchange on imx93
  firmware: imx: enable trng
  firmware: imx: enclave-fw: add handling for save/restore IMEM region
  firmware: imx: enclave api to read-common-fuses
  MAINTAINERS: Added maintainer details

 Documentation/ABI/testing/se-cdev             |   29 +
 .../bindings/firmware/fsl,imx-se-fw.yaml      |  121 ++
 MAINTAINERS                                   |   10 +
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts |   15 +
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |   11 +-
 .../boot/dts/freescale/imx93-11x11-evk.dts    |   15 +
 arch/arm64/boot/dts/freescale/imx93.dtsi      |   10 +-
 drivers/firmware/imx/Kconfig                  |   21 +
 drivers/firmware/imx/Makefile                 |    3 +
 drivers/firmware/imx/ele_base_msg.c           |  272 ++++
 drivers/firmware/imx/ele_common.c             |  188 +++
 drivers/firmware/imx/ele_common.h             |   31 +
 drivers/firmware/imx/ele_fw_api.c             |  110 ++
 drivers/firmware/imx/ele_trng.c               |   48 +
 drivers/firmware/imx/se_fw.c                  | 1274 +++++++++++++++++
 drivers/firmware/imx/se_fw.h                  |  176 +++
 include/linux/firmware/imx/ele_base_msg.h     |   66 +
 include/linux/firmware/imx/ele_fw_api.h       |   24 +
 include/linux/firmware/imx/ele_mu_ioctl.h     |   52 +
 19 files changed, 2474 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/se-cdev
 create mode 100644 Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
 create mode 100644 drivers/firmware/imx/ele_base_msg.c
 create mode 100644 drivers/firmware/imx/ele_common.c
 create mode 100644 drivers/firmware/imx/ele_common.h
 create mode 100644 drivers/firmware/imx/ele_fw_api.c
 create mode 100644 drivers/firmware/imx/ele_trng.c
 create mode 100644 drivers/firmware/imx/se_fw.c
 create mode 100644 drivers/firmware/imx/se_fw.h
 create mode 100644 include/linux/firmware/imx/ele_base_msg.h
 create mode 100644 include/linux/firmware/imx/ele_fw_api.h
 create mode 100644 include/linux/firmware/imx/ele_mu_ioctl.h

-- 
2.34.1

