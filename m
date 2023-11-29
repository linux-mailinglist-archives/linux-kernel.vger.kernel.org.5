Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8A47FE2C7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbjK2WMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2WMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:12:42 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B6FB2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:12:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5e8TWYKNMbv2ahkrBHef0dQzW8AjWbQuaZVLhBembS8xADfXNscwFFnSc5vmWXElVHyIaByGe+hME6Nlp7KNqhfpuz411s96Csq/HwRuE3PrcwHjA47UQwOT1stP50wp90SOnCJI6Gqu6mAEj18jNS7wRnGHp8+jHV+24aTNyzBdFPIoM0sPNjWSfLYck/9KBMkL9hA4cdstWO3eIoECcoxqhoN4/XqNpz1464GwwjH97YRe2YEZw5gPBHj/+2/TesmmrRTXOsKmRp6umXCm8prNJlpuLSYnhO6iW/fqrZo4dcL+KEIGacWU6ZOd0a0+X0g6XuMLZ6ow1n3WF+tjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsrtkbPQEHdInV+W4Kar0OKs5ltKBaF5C8NTfcb2BEc=;
 b=FbaFuVYGXo9hKFbcdRvTEU9H4TrWkoA3nBrQZl8nhHUFFKLzS4BF3rsAkO4n9SjE+c6d021zvTuDDpwWPxOIGYJBI8Gy0+GmXnI6sxyASow8z+aeK7VPpwTXWb0tsY3iILxs7xmqS4m0Ggt9lA0yXmIcePZWk5yTlIDhdg+gPtAqWVZaMeZOubcosbN0Y7X/rlySepmfAVV+Wh3ed3sMczB8lJQ5K2AAzvUCpC/MP0Ea9ltILkZ34u2RHRHH9ltzdnxMyx5DSR5WdZPXb/VccaY7p8xE2f9u2FwRC6mD1rFwMMhulbKhZEMILwM05F7/c6kHwpcQCrqH+Ytnlmk/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsrtkbPQEHdInV+W4Kar0OKs5ltKBaF5C8NTfcb2BEc=;
 b=GKg0xbIrvpbQ3Uks6VyOLwHFn8IN3TkNMaT6FVIWYw8RYc/Wc8ny8MwV9s/RaSnhq2sLiXcmcnaz1hUcfZAgROwlI61OnDyGh9jzOF3NUpA3IJMZ6ueCtqrokcHPTckm6mDWQlitnW2+FbfI5LD5wy9WkNEKqVe3c4iiumQoG6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9578.eurprd04.prod.outlook.com (2603:10a6:10:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Wed, 29 Nov
 2023 22:12:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 22:12:44 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     alexandre.belloni@bootlin.com
Cc:     Frank.li@nxp.com, conor.culhane@silvaco.com, imx@lists.linux.dev,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v4 0/6] i3c: master: some improvment for i3c master
Date:   Wed, 29 Nov 2023 17:12:19 -0500
Message-Id: <20231129221225.387952-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:40::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: e535c1bc-a0fe-465a-c1aa-08dbf1284fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFSv/gYtgXqf7bEwJpx2EMiR5bQogNGWxbWFd7cYe8aE22r7pIRRP0JY81brsdza8EP9WKigcD+4j3YVVvnGvyS3vysob9zBZBO6FY4BcDaWVncIL3esphzRire9DXnxzGo2u6ian3MabVrLjCqqSFExGAVTgCTp4dVIP03LxU3ON859ppW5BVJRLbKTC31GIsWasRx0HZvyftmE3MSqBhDDbBOzJ1MQWDqdFLK3xwPYSxDavgmEbCd9uHwqs96Ff9qIv9wtBeIfAgbho8sbRHURusDCYnpAgJ2hIDtQI69juIWMANbbigiMOtOWthOS+hQPgb5IDkFbjqU3sg/wLTYmQXCJkELPdQaQZEv1rUL6CgaQRrfLZko9B6bLQdw7zXSzI5iN4NfmHkNQ+joe2OK1zw3IrXn2ws1vHfHfj+NM9EJecAGnNcqkSoQOEyv77Mlq15VVtnzLMMKR/scJnCpUG97hGp64OuqBvPqFKlcQ6MdSvOaOxjIDFCpFY/+MYCNy01gh1jJAd5YOnMaMlm7hd+lb68j14E1gXIF1Bcqc37/aXl4gm1w4BeekJ+agApN4xAeUDeYFkdXftstBbSyZ8MaItYUh50GfaGIz3p/o2uzhbGqbP2cNEqCMJohAIzVxY4b83Px14u+6HxeA9hwAPa1HY/o7RwR9BM1A93Jev6AHAV4cAp/KFCc9Y1z6R7JEQVXqYn/4yeLFaX0e5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230273577357003)(230922051799003)(230173577357003)(451199024)(186009)(1800799012)(64100799003)(202311291699003)(38350700005)(36756003)(2906002)(41300700001)(5660300002)(86362001)(6666004)(6512007)(52116002)(83380400001)(2616005)(1076003)(38100700002)(6506007)(26005)(316002)(66476007)(478600001)(6486002)(8936002)(66946007)(8676002)(66556008)(4326008)(966005)(6916009)(42413004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmNpdGlVbGErVWZ0cmIwY2FoWWhSVVJybDlQRWlPNU9IL0NpT3UrZlJ1b3Nw?=
 =?utf-8?B?d0p3Q1ZweGtyR2Q3cHJYMThvSWVYck85NklxWUZ0YjZHUDU4QUxCdTZ6U2xs?=
 =?utf-8?B?eDkvWTVoQzhyOGJRYXNOWm41dkJLdmFnUklEWGFObkV0UlhGOGViZ1BZcjNs?=
 =?utf-8?B?MVJiYXZvQ1kxWjFnZnhUbUtoU3dxWTZmMTdFclZ6RE1kUWo1OW1UcjJpMVlT?=
 =?utf-8?B?djJsTkpkMlFoTHNnZllJUGtqbDlXc0VJWUhQZTM3b1pyQ0hzMHFLR0NROVIz?=
 =?utf-8?B?dUpmeHN3MTA3Sjc4dGpJTHV6OTVYMFVtbnBmamNJM0xPWnpwUmFJbGdhY1Rn?=
 =?utf-8?B?YldZNlpFZE85dUVOamlqLzFadXQ1RzNvbUkvd2xKRWxNdHJWV1RNYWRURSto?=
 =?utf-8?B?MXZiYTNjZVBvRHpjajVQVmRDR0dIcmx1ZmhTczhWYWkxczBQaVJudlNKQUhr?=
 =?utf-8?B?SFptOGJLZTFjc3phQjFubEZzSmFPMCtnY0FOeDBEdUxZeHpJMFMzSTNyRjBr?=
 =?utf-8?B?QVBzRW1Kb1VqNm1UTFVsTEV3eHA2OFhiUnhJcXlJQi9rMDVvdWN5dkpFQk1V?=
 =?utf-8?B?cldkNTRuZnE0NmRvVkE1aUVvMUNVNTJWb3htK2djeGNtWStDQThTdkVqV2xi?=
 =?utf-8?B?bHF0dG8wV053ZVFRbHU5V0xQVFFWcDVwSVBmVXdHck8rRWlyL2FpVGNubFc4?=
 =?utf-8?B?NmdTd2hCVS9NUDhRYXJvMDArOTBITmJvaDZDUnYzdEZtQldFem5xTFFKSS9G?=
 =?utf-8?B?Q1NsaS8xSjZmV1ZNNEk2d2hpSXMyaittais1eHlFcENqOHNwclRXTXp0eUlX?=
 =?utf-8?B?d0wxRmJnb01BMVFQZ0REdTEveEo1S09GR0JlWlR4bnFEeitTK3VFaUxCcXkr?=
 =?utf-8?B?M3BIYXdpRlRCYndOQ0ozdzFmY3JQeU52Z1ZKV2tKR1MvazByb0EwNHh5VWdT?=
 =?utf-8?B?MXpDdUc4d3FtNGJsYUVyaE9ZZU1na1VjakpIS0hCaThZaFl3RGxPL2NRZlZS?=
 =?utf-8?B?VG8vVGVlS0IwWDgyN1orUHBzcTA1bDEyL1ZZNVFRNERjQUVNRU5UckdNbjhk?=
 =?utf-8?B?Q1V0K2xCQThEYW56ZnI0c0RNNjF3dkhWV3UwZnBxZjVRazJUNVJxbzBLeHYz?=
 =?utf-8?B?UXVWSzdUT2VuSnpXM1NXMCtEL1QrdlRBaVlPQWJLUWJrV01CenVib0hFSUN3?=
 =?utf-8?B?N2VXZkxsb3FKdTJseFBoWXd2UzRXckJoNmdka1pjL0pmc1J3WDEySDhVT3hC?=
 =?utf-8?B?RkllWmR5RVZ4WXFWQXU1NkozOXBadjZNMmd2ejZORk84UXdzZk1ScDRQUlN1?=
 =?utf-8?B?azZza2dZR2ErZmxVdmVDdjQrZlN6L3hrWnFaSTBQOEJNem90L1NYRjViWGFV?=
 =?utf-8?B?cTNneU1UZmdOWXJrM0pIMkM4aENOQXcwT3lHL3hla0JhYmdHcDFHQTZ4VFda?=
 =?utf-8?B?Zzhsb1JTWXRxZHArUHA0STFUdHUzczZZV1J2YSthMm1QbVVtRkp0Rlk3YnhM?=
 =?utf-8?B?bWdLMXE3Rmo1YnBJZUFTMEpsQU80RUpRMm1zUnFpd1BnL0JoVVhHYzEzUDVG?=
 =?utf-8?B?VXE5TVVuVDNrT1JMbXFhK2Q5K3FGTEVWbHlxYjFzYXVHWHdEYkNWZWNpQTVK?=
 =?utf-8?B?NXZ4VTdGY0NBcXFzeUZScFFDend1UTdkTE1KekkwT0dqbG9PRzZrcEdmUzFZ?=
 =?utf-8?B?TzdkeFNBbmg2R0Q3emVRL25zQVkzSGpva3RaQU9WbmNuK1FwQ3RTdVhBdyti?=
 =?utf-8?B?OHcxY0NxUXl1aWNEQU14Y2NvcTdEa1E5ajg3bi85UlYzTTZpRGFUd294U2hr?=
 =?utf-8?B?OGtrVmRhdllLZTZxWE5mZDhEU0dlbUd5V2szSjhqUWh6czdna3JPc2dsbTRP?=
 =?utf-8?B?U2d5NiswbkUvWHVDYTZTOWZCZ095VnlJRzNuQnlFSXAvV0g2eVNZVForbUZK?=
 =?utf-8?B?V1dSSDJoclFjMVBuSW5tNGUxWC9MLzFTVEdzR1VCNnlnUnFlQmNEblI4Rjdv?=
 =?utf-8?B?dmtkZFZUam5jdmp6dnJXUHRLOCtJY0pLa1ZMa2RabEJzWHJ6c0RNdFlsUHpJ?=
 =?utf-8?B?Wi8wdU5nRUwrZDhsK1NPdDY5NkZlTi9ZaWhqUDluVVlONVVZenFNZ1NsZkJl?=
 =?utf-8?Q?24je0cVgKX30s6vg6y0o9H9eQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e535c1bc-a0fe-465a-c1aa-08dbf1284fea
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 22:12:44.6451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VM/xjMeCH2yQBBrFxoZ9Sn95kHfD3JR06MvJdqI69Ixl7YGatkiqmts2WuScfJx8UXVRsOD6MVApLNDOKaU3/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9578
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are dependent on bugs fixed serial: https://lore.kernel.org/imx/20231016153232.2851095-1-Frank.Li@nxp.com/T/#t
There are three major improvement

1. Add actual size in i3c_transfer because i3c allow target early termiate
transfer.
2. Add API for i3c_dev_gettstatus_format1 for i3c comand GET_STATUS.
3. svc master enable hotjoin default

Change from v2 to v3
-fix build warning

All warnings (new ones prefixed by >>):

   drivers/i3c/master/svc-i3c-master.c:212: warning: Function parameter or member 'lock' not described in 'svc_i3c_master'
>> drivers/i3c/master/svc-i3c-master.c:212: warning: Function parameter or member 'enabled_events' not described in 'svc_i3c_master'
   2 warnings as Errors

Change from v1 to v2.
- Hotjoin control by sys entry, default enable hotjoin, which standard i3c
feature, user can disable by echo 0 > /sys/bus/i3c/i3c-0/hotjoin
- use actual_len, add document
- using &xfers[i]
- still keep check cmd->xfer because i2c and ccc transfer, xfer is NULL.
- fixed issue found by checkpatch --strict

Frank Li (6):
  i3c: master: add enable(disable) hot join in sys entry
  i3c: master: svc: add hot join support
  i3c: add actual_len in i3c_priv_xfer
  i3c: svc: rename read_len as actual_len
  i3c: master: svc return actual transfer data len
  i3c: add API i3c_dev_gettstatus_format1() to get target device status

 drivers/i3c/device.c                |  24 ++++++
 drivers/i3c/internals.h             |   1 +
 drivers/i3c/master.c                | 110 ++++++++++++++++++++++++++++
 drivers/i3c/master/svc-i3c-master.c |  92 ++++++++++++++++++-----
 include/linux/i3c/device.h          |   3 +
 include/linux/i3c/master.h          |   5 ++
 6 files changed, 218 insertions(+), 17 deletions(-)

-- 
2.34.1

