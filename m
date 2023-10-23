Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891457D415D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjJWVHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjJWVHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:07:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2133.outbound.protection.outlook.com [40.107.93.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBD5BE;
        Mon, 23 Oct 2023 14:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHcwXhfvjs5CN0p4jifRlnyPs6+2IXptp5ElDMFwe//U8KmHk8VttrJxFUrn3Hj6ARsFmhkh2w6srDcqkhw3Go85BLyEcwu8xFXDYDRfv6UKmyRLbZeWm/cguN+Cg4dx2g1i3J/ZkpIlDuZoX1EY8yFZh/Cz3H5bipozGgChUWvrR04xAJbZ2AO/gS8BiqETuEY0aliMOL6cb0B3LVTsITierdUDblMzNnW7AjtD009eMgUriFBjjGJPnisOPf8NKyCbOfZhyBwlcQRuZFCPdXYv9Gfbz87dKZ7SW9sldauOBucXAHwZ9hCjM8V/G6q/VGiXTc1W/SKx20LszVeMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=os7ErRXujv+r5OobqNcDiUKc6N3TQnz7sF1gybOkZBg=;
 b=gJfcMBRnPCqKyPIFb6DNd6v3FBldb/1JsAfv3QF+ZeRmbYF6qqEd3j8Bugp4C2bQljlsWqnxxkDunCl0CptIXy0pEGt8Ow+mNNXD4uoyxCQ+bWd2XJPU7H4XDZDz+Gvbl/MqTERYgyywNFy7ahvd707eBF+TKKeLB2VZc8W4aRneljJ+BSwcXblqWAzotSdqNl6pIv9IHVxd9rF8l1LVW3/4EOyCisp4dWuUx/rkHV/jvMW2AL3FshhJbvuj31iv4nn1M/wJ3dKFPoSOlgbVL2Ogq7Ae7UQbv0Y5L4YKsEg/Hlsb9IaQzncy2rv55Rke9fLmuYdHiq4uSVgzVfjgUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=os7ErRXujv+r5OobqNcDiUKc6N3TQnz7sF1gybOkZBg=;
 b=QaX0yfVog3KrMR1zZajTeJ39t7t8AYNdipmpRMIE65EOKi6arax4P1HprUwauy+ueT0zRZ7yTU0+qAsjBtQ0anRhQmiLgVtPSxbeEeb8nCyDsxmAy+Nxa9NzlfC24W0CqrNFOP4jkKLspMP1SQk8qtgcd68Fx8m3HfCFC0nfo2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ni.com;
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by DM8PR04MB8134.namprd04.prod.outlook.com (2603:10b6:5:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 21:07:06 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::9481:d7e:63a6:1bef]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::9481:d7e:63a6:1bef%4]) with mapi id 15.20.6907.030; Mon, 23 Oct 2023
 21:07:05 +0000
From:   Brenda Streiff <brenda.streiff@ni.com>
Cc:     Brenda Streiff <brenda.streiff@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 tty-next 0/2] serial: Add driver for National Instruments UARTs
Date:   Mon, 23 Oct 2023 16:04:55 -0500
Message-Id: <20231023210458.447779-1-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0112.namprd12.prod.outlook.com
 (2603:10b6:802:21::47) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|DM8PR04MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 824b058b-e58f-4d0c-3362-08dbd40c0275
x-ni-monitor: EOP Exclude NI Domains ETR True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ClD5PXfP7QmRzUMRJGzTv89s5B5uXLPvz6w9irJK3iR/ljhJ/bL6Z19e93DSdzmnj6B4kLFSrWvCfCUestfqRQrBKI4tRE+J1xvSn3xN0Ia1Or8DtbXfZOzRfljbY1DRReT1YSSwTQ2QSNPdN8I5b/LP3EwuLjXvcm7LKdiL4uEhPARHuG/KrDzHabKLYCjYgHFIO+NuCogjXDOX6Z1oE9ee/2u6FM35aH38A1aozNLfJqNiOVX0mOG9VKj/rxAMGTMPvILpgIgyQvXI59zBGziAOtzTBgcqrK/A8W/mkKHUJrD0WTi2QffUYlYWBQsgQ2U473wbTesBg/liH7sidsRHPNO7fRAYKCWI5V6GnuVCVNkp6Iqrkzg8GEOEC/VoSnwp1rF51xO9DLPTHG6dUMdw/owLsG2FQ18ZNtYG8dUv1lMM61hrMh13nb7u+mOC6tdItLaeTpF8xJaotfFmNIDkbuctf3zGZoKvhfzguIInGvG22y9Rf2exKZSuKl1ARKbSvkOHmBCK/byYjqnixkQTGmqnriexfiM76Fl3B+sP1v9KnQB3I6UT9+xMCm24klv9SIdSgGn1bPtlheF89w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(109986022)(2616005)(6506007)(6512007)(38100700002)(36756003)(86362001)(1076003)(26005)(44832011)(2906002)(6666004)(966005)(6486002)(478600001)(8936002)(41300700001)(83380400001)(4326008)(8676002)(5660300002)(54906003)(66946007)(66476007)(316002)(66556008)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oCicetd+u3cmW/qPT67niqKqZdaOtyq06orc0oKnHZzeQF8AfsNZ6igXoNGQ?=
 =?us-ascii?Q?i/oUuvqMCa/uUIYJr2BrRNiKzDkdVKE5/65gNRxogSvr5Qh6KHwhR+td36ys?=
 =?us-ascii?Q?NlwBrvOCFDQA5zMCgw6iQEIWOH6bE4YD27kpDe/rmKwnKQfM/kwERadryUa4?=
 =?us-ascii?Q?hgGipgGnCi5nNO+4N92kD/9WPoxX428COyeJTs1XrcQD/XuFgIFTiNUCjSUg?=
 =?us-ascii?Q?LqgdNzDLAOA6Jz8Omr24KE4roJM3VX8jn7uc+d0kphcn2G7yuL7EZiwFsKEh?=
 =?us-ascii?Q?C5GZOHl7tcVQEPz0rUkzmb9xDrvh2UOnhiADioQRghoSscqip3SueE1s+LQe?=
 =?us-ascii?Q?/2THkv7GQ+USOlveeCWl4UG1fVyACCxJZs4JwwecFn+CGpPSFQNJCI7Whavh?=
 =?us-ascii?Q?FGuuCTd0nvluyIBndo8yqWJNMM2I4dr1BbWuX3o4JQZQhGPzt14/Pszj7K3o?=
 =?us-ascii?Q?nIecrweLlSdbmYixbI0VL4bZ8zTYESZY3Bmser5UJVspdSz1nBFvB9CibVF1?=
 =?us-ascii?Q?bRDqA1NXO+y0VY29caV1M4saI+U7/q9iYvRfEQHWg4F7CJvHnavjrao7r2pw?=
 =?us-ascii?Q?yP/mJiwnM/yyoK3U3Cm+kBktqys8rIE1SPl2cCnwzqMyqhtnPw/J1pmxhp0s?=
 =?us-ascii?Q?dsH+e9e/tptsu8u6NIHrlAJ4myjx3f4h2+dRs+Dh5tcrmeHO8HOLovcGatx2?=
 =?us-ascii?Q?CH8CiHIx9BRXUPVX1ClZdCpZFC1sR55mcHOVeF88Ze6pHudNEARKDl1l3slU?=
 =?us-ascii?Q?1wiPrR6bZXLFSewKLUEoe3eQwTjsZecYY+/PGsw4LSP3SPijL/pWtena7L2h?=
 =?us-ascii?Q?MvjPoGQdrsZL349Qyh+sME8y9lUkgWcwjGVApdEj1g2YNihMvQwRyLlTUD42?=
 =?us-ascii?Q?yGhh5Prmo49/toRxJiwzmqsygBjDP2yEPQSmfaDENFNDkHfrUVFP9S/b1whF?=
 =?us-ascii?Q?ZulWIJtRdtYGl1UEmNdxycHVw1cmI/Rkzezhlc6arodY/vwqxlNw4YhYu5OX?=
 =?us-ascii?Q?pCQF+zxCbZFKdsGi6nVStHNpx8NBz8Y57r75gI3npfr1982OcPOXviA12IY4?=
 =?us-ascii?Q?fDD/MA+wEJlwDzOTE+zbh8im48ij4kSlWX6sz0ZAL1SwfdOB/Rq0KviJQe/+?=
 =?us-ascii?Q?UUeUzLFgBMnwM/yBSB7uSNO/wyG/IFHWkycX3A+IZALM4MB/BXztS1V0fh2r?=
 =?us-ascii?Q?ZCzRyj6w186qlnfoXIx9L4PaCh0iib741ddPTwryJVrpoS7/6zez5lVak2oD?=
 =?us-ascii?Q?ZBnfwabPdPuQrVPqZxMsXy2ogNVfuP81gMkWf90reqjyXekWauM2fhVi2e0l?=
 =?us-ascii?Q?0tp6Q13OnFDvzq5yILz5dw9+nojRHxQebGNSHfO7XbLFnRutVsVj+eZvNOxF?=
 =?us-ascii?Q?HFzj9PRdD+OzgScRU17Bi7qjrRmkNeBVET0qUn/tNmixGPKROeWOpTR60FrU?=
 =?us-ascii?Q?HWRYkXSfs2LnLSYhnxzPmd9kEDrPtF+SWLkdgjKO50UjDlHpcRnelMgessCX?=
 =?us-ascii?Q?tb+m6FL/QEzmfFqrClFYlWU45d68sbgN9SfocmljQwxza4onyIeZL8t1ZT8F?=
 =?us-ascii?Q?whOyH5juQkEfAJXVUXjRs+0e4gnyJgsQSWROPMFv?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824b058b-e58f-4d0c-3362-08dbd40c0275
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 21:07:05.3391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8T0q8tpx6K+KLTFaJV04FlaLvSeRDcUoLuzPLFec4fPpP0fj5+2BtsQYVzjRPm0X6Bt2lHVW5dDi/Mzfq/h4wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8134
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a driver for the 16550-like UARTs on National
Instruments (NI) embedded controller hardware.

These UARTs have an interface that is compatible with the TL16C550C (for
which we build on top of 8250_core) but also has extra registers for
the embedded RS-232/RS-485 transceiver control circuitry.
---
Changes from v5 -> v6:
- fix unused-const-variable warnings with COMPILE_TEST=y and W=1
  https://lore.kernel.org/oe-kbuild-all/202310170418.GCOnw1n1-lkp@intel.com/

v5: https://lore.kernel.org/linux-serial/20231012205112.112261-1-brenda.streiff@ni.com/
v4: https://lore.kernel.org/linux-serial/20230505213850.829639-1-brenda.streiff@ni.com/
v3: https://lore.kernel.org/linux-serial/20230418223800.284601-1-brenda.streiff@ni.com/
v2: https://lore.kernel.org/linux-serial/20230410211152.94332-1-brenda.streiff@ni.com/
v1: https://lore.kernel.org/linux-serial/20230329154235.615349-1-brenda.streiff@ni.com/

Brenda Streiff (2):
  dt-bindings: serial: ni,ni16650: add bindings
  serial: 8250: add driver for NI UARTs

 .../bindings/serial/ni,ni16550.yaml           |  51 ++
 MAINTAINERS                                   |   7 +
 drivers/tty/serial/8250/8250_ni.c             | 478 ++++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |  13 +
 drivers/tty/serial/8250/Makefile              |   1 +
 5 files changed, 550 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ni,ni16550.yaml
 create mode 100644 drivers/tty/serial/8250/8250_ni.c

-- 
2.30.2

