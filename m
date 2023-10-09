Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43327BD4AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345438AbjJIHw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345433AbjJIHw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:52:56 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DECD8F;
        Mon,  9 Oct 2023 00:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YADEpT4sf76hDfonuyZiQYimIzXocKox/F+VKlgdy6ama/I2Sp5esq8IsUWfBdgh+JgOXO3y83wfG4N3ghisMwKGCl27vZrqAh1u7Ifoyq9twffUeOwh+c/QLzIJXxyjOMhJXSvAr2GSwGcgbjI6SE2G9U+3uo7iR5z0Gphs67fOEqUWgV6nN+FL4Qcm341Z1h1Or45oOvXDBsN/WuBbo4qdfKdPkAjRfMaj5ZLaowOGou0WQhwK050Vn9UTbgnetDLdcCRsZCphSjYcf1xQvguSY0UVzUcMQggh8iUylXHtn6gslD5rSHC7mS4dCCKxnrmWces8f3XoZDgq9fz5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0V8qI+4ZMACYq+bXHfvlqB6PjXvEiRVf63oldSDCM0=;
 b=h/FpcC21naBHYDseeDKxmCcp89tEgUZugpfLvVf4QAHi42NUiL6tozaxNRlRd2/L61rmdMbhJC4MTtq47bY6RHHm7GIO+Im+5HGboFm1rswErYO6rLc8IStQAP8lTz3DH8Xfwgk+jF4NHuPZ3WHhzzRrDTg1d492MxkzgH3pE97M5+xJvIoPavfJeUEYgkxbdRWX8bJBjQz2oLr3zXtdnpyvWvz3fZz8iwvcgvb89kU7cBy1fewMO1zrW6rDNti4SFhT1LLzvXY6JgCaq2RJ367S08mEk5h5yct7p61PcwOnSvLxqXRi/elNO0uaATlWDM4snpY8VfCAUGx3/58DIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0V8qI+4ZMACYq+bXHfvlqB6PjXvEiRVf63oldSDCM0=;
 b=k08fxcLhrwVHWwSXpPb8BlV9LxOw73MAz0zkMXPN+0LTTMJyuIM5vqQyZATsgA9s483iMwTQ9WFjfbrdUXuTtNcnpLyqiNM7GnrasHMCDV/sItmmLmCvE+gFCORBm9teGq5Z/OVDyLO6jxqhSGVS4rpH7gzB37FVxKDgUhf4UgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB10064.eurprd04.prod.outlook.com (2603:10a6:10:4d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 07:52:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 07:52:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/3] nvmem: imx: correct nregs for i.MX6UL/ULL/SLL
Date:   Mon, 09 Oct 2023 15:57:26 +0800
Message-Id: <20231009-nvmem-imx-v2-0-86cb135c20a4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGayI2UC/23MQQ7CIBCF4as0sxYDGLG66j1MF0AHOwugAUMwD
 XcXu3b5v7x8O2RMhBkeww4JC2WKoYc8DWBXHV7IaOkNksuL4HxkoXj0jHxlQjt1V0Yv2l2h/7e
 EjuphPefeK+V3TJ+DLuK3/lOKYJxZbdCIURt1U1Oo29lGD3Nr7QsH06rZoAAAAA==
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696838258; l=732;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=D1pqvDMHDT2ZJAR8b7+3dzYMEgIW7P71xyVmBMao53s=;
 b=BHIX3XGnFd9bzh/l+P0bQl2rE9MvTI5sjimTedKtw3Qg61SypTXioME5rSGm3trXVFMNudn/N
 hcAdvdplvE0Bo449tMEgVzOhaUldtI4EUlvuoWG+8Ajp3EivO5zvoSD
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB10064:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3545aa-d34c-4f70-723c-08dbc89cbcc2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnPZyO0SX0ht7ss59NHUhvjxPQajNgMt5zK8zTmuaqXYq0d7EJwGyBXBJlMDUW4wwckiKPdoWN0ui19gXCZFRGML+iLcKFZ7F9uHpdGgJOMU97BNrrIGedKVSZjZqVj/lI2rC1QblIYeUNxC9bGjKCNiXagCCNyB96kIsPn08y6Yx4IVSnpMrV9UQaWhHs0uavCuDSyck5D2qO7Vk/ttka08F7q6EyMScWxPapSMG6I+Ex72pLECo8YvN6lCucOqxkGfaEKU/oQkq4Tuldbx3B3o3f3Ep0Ji2LlI3WM77qP4nQkRlVfgAe9wk+pgamDtCRY78YjBDr62s10gXK3/2wmYYJuEBbVUOL+ObjOd5R3LgJxx285RE8vc9b9WmttHw4sBX0VmeU2mFQPcCjvcq7gOsIpvhygGcpoy5m/KgQ9iMFA/zfh80sjWR5Z5LzUcKeXPc1zbv8fx355qMf8lTGjyk1raocezfdrf7lb3ZSSemKilJH2PIHx4XMyKTXOXWIIZJxojHMVVOx8SZud5pC4YKcYcn6OyrUbPgxKJ05tuVIIB4d+uxuK+C00hBk3wkujOH/I0qY+qhybTNpDoWdO74VmR9UnDHZjsqdkjTzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(346002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(9686003)(52116002)(6506007)(478600001)(966005)(6486002)(6666004)(26005)(83380400001)(7416002)(4744005)(2906002)(5660300002)(110136005)(54906003)(66556008)(66476007)(8676002)(4326008)(8936002)(316002)(66946007)(41300700001)(36756003)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0hud1ExaXQ0NjUrSzNqNlRZdVRnY05VRXBPSEEraFpPVHpWeEFhZWU5eWUz?=
 =?utf-8?B?RXJ1U2l5QXQ4UGJmdEhyMC9PYUZ4bk1MMDlMclUrMEtEYi80VnlvYkhEbVlF?=
 =?utf-8?B?d3daUExlSXAzQ0oraUtqUGlrQitHZS9iWjZjQ3lvU1BlQXJqQmJldzhGNDNw?=
 =?utf-8?B?aHZQcTVUQUg1ODJUaXJhQXpRZ0t2TGRSakttay9MZFNMMlRDdUlaQzNwelNC?=
 =?utf-8?B?ZVJvSE5IRDJ2VnhQRjJKSVZKNml5aUFOM2ZxSVVGQ2N6WXJ5aFg3ZFY3WVVB?=
 =?utf-8?B?Uk11VCtpdjdxWmFTQ1ZPeGNBaVFlMi9saXlrWU5oeXFRVW9sUjNLVUJNRFlO?=
 =?utf-8?B?d29aSW9YMlQ2VUUxaEZISzBoWUlmUENzRUtiWmY0aFM5OTI5YStKNkVnZFR5?=
 =?utf-8?B?OVdZRVFWQXZCUmdzZDVqQURzRkFKVTdMcFdSbGJyYmx3U2oxZ2tvMkpTbExV?=
 =?utf-8?B?NDlZeDFwMElRTmZ6ak9XSld5dWxSa0xjNFJNdXZtWjAzRy9mZ0FHTWwranJy?=
 =?utf-8?B?OUZRVXZPckxwMzNEZ3VnY3hza0xJRjg2QytHdXFFbStNNjFCMnhUb0ZuL2s5?=
 =?utf-8?B?VVlNclljYndtSmhUQVRPUE9NSnZrSmUzazI4K2hMUEd5WkNSdmcwMVdSWkIw?=
 =?utf-8?B?dVVpQkdhblhRWXMrK3FYd0x2RGp2Kzhhbi9JbWUvODh5R2I0U0lvdkdrWnRR?=
 =?utf-8?B?MjJMV2dSaTcxdFg0aEJIKzlhQ29WZnp0VTZ0SU5aL0cwbFhtbGdQaWpoVTRj?=
 =?utf-8?B?WDJVWWxFcGQxVUxRZkFZcWlPanFkVzlUcjhpM1RYdTBobk0xK0R2c01XbVVK?=
 =?utf-8?B?SCt1VUhWMGlTcElOcDVrYnB0RzdpSGpIc1ZrTTFxQ3dRSWRiQXJnZ3kwNUZP?=
 =?utf-8?B?T0xGZERDTjBzOFh3RXYvd3kzVDhaRlc5aTNYY0ttakwwRS9IZUFhYSt5cXZ0?=
 =?utf-8?B?cjQyWGNkc3h4emk3bzdKWU5FMnJSWmxIS2tXSTA0UDFBWHFzRUFJVjU2MVQw?=
 =?utf-8?B?VWkvdzJQbkE2VGNzbjU3Sm5hVTc3MzE5aEpBY0xyUEYxMGdCS1RORFQwL1Vh?=
 =?utf-8?B?OW9sVkxwaUNyZ0xhOWZmbFNMZnp2RTU0NWR5S0RTU2hnRVcxeHpabE1jeFQx?=
 =?utf-8?B?QVYweDlnakdOc0JKbDN3U0c5azFFZDRJYU5meW5xTi9ZbHEzL2ZqRHRYZFZI?=
 =?utf-8?B?TC9Hb284cFhBMHpUMDNIUUhFV1dtZXRtRG1HeXd3UXFEYWVLRjZpc2QrcGFU?=
 =?utf-8?B?Ym1DQjB1S3hUWk1aWUNCSmtnUTN2SUVMdzd4bXdNZUU3bWppYWJ4SGw1cUtP?=
 =?utf-8?B?Qnp2Ym90QXRTS24zc0FKZ05VWGhOQmJITVdXaFErRlZIZ253NVp0Wjc5bTVm?=
 =?utf-8?B?cW9qb0xnMlc3eGFPMkpWU1l3NVQ4VEhyd292dXJqdy9QcGd5VlVudXdWSktx?=
 =?utf-8?B?ODRlaHFHUjdYclRzYzkrSDBIYUl2aGR3enNaUCswK1NXMnFsTFVFRUhEdjM4?=
 =?utf-8?B?ZVJ1eHY1MHNuL1YxT1h1MnFsSko2NXF5Rnhzc0MzTS9Na1gzZC9lNnF0Lzhu?=
 =?utf-8?B?V1U3OWVma21mZE9rMS9waEQ3MGFteDRuYTdjM2tLa0JqL2tYVFpRMEZ4S2F5?=
 =?utf-8?B?a3AvZXB4RmpMWm8zK3Y2WVdZbFYzZGR2LzZMdk9mcFhkQytIaFJXanNVbjBo?=
 =?utf-8?B?TGFOZDFKSVRycENCY24rTHI1T3FRNC9QWm9rUXdMWmtDUkwxcTAwWGVaRE8z?=
 =?utf-8?B?cjJLeDVCSTZMcEdjSGdxYjZoMEJZZzIrM2ZQL3VSdDdQS3JYSGx6WU9ac25o?=
 =?utf-8?B?VXkxbnBka3lnR3Z3R1FnZGJyL0theUdqcVZXYksyUVhOK05OTitTNE91ZDBp?=
 =?utf-8?B?NEV6Z2V6enYvZndkR2N2L2tHMS9tUnFLcDFBRUoxVVpRc2JSOEl4c04rT2FD?=
 =?utf-8?B?UDJGUTVUMjRONGFXekgwVWNtZGM4anhXRkhDT2JkZXFWYkpGMWQvMExzMHRE?=
 =?utf-8?B?Q2Qvb040S2dETzN0eHBTN2VYMlFnVFJlemkvREk1d3NpRmVIUHgrVkw4WjFE?=
 =?utf-8?B?czZuVFVrcEZCWXQ5dWxtcFpCYVZUd0FYRkJaREZTYWNHbzdXOUlUY080MkRB?=
 =?utf-8?Q?gxE6JpHbCDqCIktHcEJMwkdGB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3545aa-d34c-4f70-723c-08dbc89cbcc2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 07:52:51.3704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4P0homYjcs1qH1+BvZB8TOghkkRX62e9wgO95EVVo9BZoNxbGM/rR+QssGeA2ztj2wTp9bRGe+IqXiz1J4TtgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10064
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code does not include the register space hole, after check
the fuse map of the three SoCs, update the nregs to fix the issue.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Cc stable kernel list in patch
- Link to v1: https://lore.kernel.org/r/20231008-nvmem-imx-v1-0-cabeb18ab676@nxp.com

---
Peng Fan (3):
      nvmem: imx: correct nregs for i.MX6SLL
      nvmem: imx: correct nregs for i.MX6UL
      nvmem: imx: correct nregs for i.MX6ULL

 drivers/nvmem/imx-ocotp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 0f0fe5040de5e5fd9b040672e37725b046e312f0
change-id: 20231008-nvmem-imx-1af696badaf5

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

