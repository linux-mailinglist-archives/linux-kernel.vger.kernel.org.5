Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADF5800285
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 05:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377331AbjLAE35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 23:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAE3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 23:29:53 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2108.outbound.protection.outlook.com [40.107.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730191711
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 20:29:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiPk0JoCepsK4NE6HIMKuQcFeBXL9ABQ7Vz0PvLSV9PT7u3iuLNQgIazS2NkPVqT6y2chWZ2lcjSbLKxtd0YQ7iJVe+GWh/Bkm6tkBgp0cqkmqG69RVrgP1v0TMOszyKEXTOAwWC90GraHJo9HROZwynpEALn7pWcTAeJeog7C3CdRwyWT3b2PPAZnvvl1n+5ilGg2RuPS/6uPcmRxLFsCxQ3uL6JFrYPRQ0Dpc2qsWif+JrThL1bo1FJPlPk1O/UjKYa2eHcUYFnv38CiUiHukuy0gJDvvhQgk+NViHiAF32NbmyM7y1V+2tYnbd1b6Y7QbDGKgeP9KUYNhzMnBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsJ9ue6eqL3fxS4b+GsaE/vR1dLATusKP+vsG6dMoAE=;
 b=gGbTyeak0w+Nnd3hCTxXPu2OpoyvBt6YdXAbK5hoxHTkdwQEi/7YfVF262wGeLvbuB0nQgmPvYX/3oFRgUNjEJpC7DRHU1tY1t6FD6m9QJdyrjoXsqzP/+0SWcUHmHlhryvRySEovfRAZhWKsoPT7v77eDaifqwPCOvWHqItoLTvgo/7qz54pq5L8XfeCu/aKmwfCLOgXqvAXuw4ujVJHqV5fk/EDMsucuurCApa4Hin7MWu5nCfnPpR4EnnsdwfOeVVle3A8LU/T71xUPCl2ctcPVyONf6dQ/uTV/by7hKyhE53Wx02IM8/GDvQkN6uSUIPpDQLOMAEkxFDqDoEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsJ9ue6eqL3fxS4b+GsaE/vR1dLATusKP+vsG6dMoAE=;
 b=goqChZo2GOKa4XdpeC3HSxOL1EC7i89ddEwj3/UIM/nVhhFIKcAbWkaOdv9TbBoOoCXSf44UTFiNbTA/izwYNnWcj0wFAgZcKM5o+OLevXIq3YrBfJtrh1mSDMNHq68ge0E7XXJPg9DO464uy8ETj3qxsUnNbbpU6WHow+7UkiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by TYWPR01MB9921.jpnprd01.prod.outlook.com (2603:1096:400:231::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Fri, 1 Dec
 2023 04:29:55 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::f6c1:b978:d777:e7ba]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::f6c1:b978:d777:e7ba%6]) with mapi id 15.20.7046.015; Fri, 1 Dec 2023
 04:29:55 +0000
From:   David Rau <David.Rau.opensource@dm.renesas.com>
To:     broonie@kernel.org
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>
Subject: [PATCH] ASoC: da7219: Support low DC impedance headset
Date:   Fri,  1 Dec 2023 12:29:33 +0800
Message-Id: <20231201042933.26392-1-David.Rau.opensource@dm.renesas.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0026.jpnprd01.prod.outlook.com
 (2603:1096:405:1::14) To OS3PR01MB6641.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6641:EE_|TYWPR01MB9921:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9f3a5c-8ce9-4ab8-434e-08dbf2262b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCM351XYsIHQtQWD/v2j3n2eB/3o9UM3WkfP2Qyzugtq05UOD49ZkaLN+MYQ5JnxiFxuu5QoXOakJzXlqEWXRwqIb/mPvTv7kyWJKJBTHEzIB3yiMY4hIO5NDevnNCQhGVrlZnzrHcFgK2QbDMqrsmnSr+l15q7oPNO54RSmGPuGUrfd11RHikK1kI83J6/w8nWnhFGZvtj+PKmIeqkObesJbEzhkhEJLCSI6marem487hZsOHYCj9CidUVUm0NcOj9TW7tC+644X9qLMV7qHF3VNp8rEbmoAjvMiZKQD2asVDwoZfwulNnLtOmJtfwp/RpDy+Fiq2ibkpm3Nh6yq/S+JG87QUO1ji87c6XCMBGQDQ8RXHLXomyoZ7Aq4n4B2gRi2f6R/TBQ9QlFLFrzisL98uRdo6TaT6dS3GqCliICHHMGluMPJAwAhXMTb6M09SXuNgQx6nrPZa/i2+emYJ3LOWUIChPYPPHs39TLFWZBolMDSSbWWHR4ZdHSFF5bpHc4TNO8C7uZZV/AYTESbK3QZdj1XRO82AuThAOiA/T5iKqSJ0KGILR5vDTFF9q/t5/KW1tpJZkSXhgloS87LcSKICdiF5moE8Gh3JJViypCLjZxDl+Nj5h8Snd07Sy2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(478600001)(2616005)(6512007)(107886003)(6666004)(1076003)(38100700002)(86362001)(103116003)(38350700005)(83380400001)(41300700001)(6916009)(66476007)(52116002)(4326008)(66556008)(2906002)(316002)(8676002)(6506007)(6486002)(4744005)(66946007)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OjNDjdZAxDZDE5d8p8FvrxbVOGM6IodhOHh64SioLcUiTetj4np6KKOkq3F2?=
 =?us-ascii?Q?lmAO/B2kaEa4rUbGm8isrQOI9wa0x5vtq6SAxun9zfjIQ9MJP6FcOImylQCh?=
 =?us-ascii?Q?1E0HN7eXVsYpOOXdzOlvDn3fC+AN86XaBF0i4grQ1QMiazbGdT3WrWB8RtcH?=
 =?us-ascii?Q?SRqzetdL6roNU5xzyPPL5QojRUdAofhCxa2Qq3rRYazxC3vFUOVo49QHnKv/?=
 =?us-ascii?Q?HmkGikHEUfmQZQt5pBmyx2lsL29DmsW2uEQwOQO1M9STHHYNz2CO8ptWWo2n?=
 =?us-ascii?Q?5bBYvfKudWAg+piw2gkd4YVUutUTmAaMEy3jg192yjt7o4zqerzN3+AvbnaZ?=
 =?us-ascii?Q?RbvqAFs8/BFw167zlLJm7q3t7UWgJ3N274jglqHHPV4IwXvssXR2tWZY6jAy?=
 =?us-ascii?Q?fXZqHemm0ssvwHQi924djW4hrs6/+c57Y+URxGfcB7foVtaAb8dB2UXgJ9A/?=
 =?us-ascii?Q?u2c5cLk4JUUkLyVjeBoEjoUJKoC5DuCot6ArXJt6OFLO/1cnRxvQ+z0up7vB?=
 =?us-ascii?Q?HdzJgX9K8fhyHDpy1jurxrgIdIg/OsBAw/9+4VltfQBp2bjmNJd8elR/Jcd1?=
 =?us-ascii?Q?xIuMeObPlYi3tM+yJ2fIKOrqXCZrqmAlTFDKGBRCI/oj5wR9CqZH9t+3rHbs?=
 =?us-ascii?Q?IavQ+SnYD7Rskd7H+sELE5aUiX3QjqX3p3dmx8KlSXN2OcFmJWHHQ99yjjOK?=
 =?us-ascii?Q?TrOqwdOwEf7o9YvtVVrb1FPXJbvyL3qSrhLtP25+bjLZudGklHvR+BrAsFcH?=
 =?us-ascii?Q?k4VmYxSjhQZFl1x8grHk8KTwhgajHOgzHY+kH9wEaC1mb48mYUyavpmvniBo?=
 =?us-ascii?Q?wr/puWWT/QQNK0Ol6eNkPM49DNyiFOdxzdchjrtoljSpyyWvblbKbnh/c48p?=
 =?us-ascii?Q?THzsMKM5PZe9fRRRC7hn3U8U0h0eg0DTKU0SpyR33s4tvy1GTM6CqDT7ZLxe?=
 =?us-ascii?Q?ULuxLk1dlwAukN8SWRg9FOL85YlMXLR6+vEWF/8M1Is3hEc48a2tRatylbVa?=
 =?us-ascii?Q?UNm1avpRsnPQXvvY1a7NcxjfvFVcIUmsBZpRg+bVsIqbKefkjYRWFMviuZBc?=
 =?us-ascii?Q?aRzNATJr6GCXU/pQ/x2ScLYdXXXY4uLdyf4yz2PCn00YielcQlreTyWzOx6Q?=
 =?us-ascii?Q?QvneqrNLD6/e3I/e3F5gSHWnW2FARLMp8vv2TM2ZM+/cwtaBpe8OKYZoSy27?=
 =?us-ascii?Q?N92gy2vOLnWnF3d1so5Nm2ySc3oTDQK5QYEqz60elzk49nhIxShaTLrZElcb?=
 =?us-ascii?Q?dfQhhlQdcjzhtXkxBRbi5SvcP2B+ZzM3WjWYeZHPIyTBbuZFBqRLx5IEtID9?=
 =?us-ascii?Q?sR2iO1A9vK64Si7mgeuLBA8T9FwLx+w/q43QqWYy1N/go9pXCnGI6Asjuovu?=
 =?us-ascii?Q?uPjQHy0M/FyLOpF2aSZD2DLnOXV4Du1m+dNJQzFoKgleSYYbYvvfOqUpdV8V?=
 =?us-ascii?Q?u1CjTmErAFAsSoxSVYAo30DmohqVvGHWRDn8/vr2EJE81Jxv3Z16peZr4KB5?=
 =?us-ascii?Q?TLrRsHDHxvxqtHOXRGdI4w9j9FpWtAZv5wayMmqkeY2OU2kSuMGBbkDIQMrl?=
 =?us-ascii?Q?7Q1/TrXf7/FPbCzI2fWf3lcC3o5Qsciq+41iazwiPfhjBLtOKu9LFQr1jiXI?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9f3a5c-8ce9-4ab8-434e-08dbf2262b6e
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 04:29:55.6330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfeYa/beLpLEiSYe/444KwZpB0ICG0GP/anPCOmcsQSw044v3oAY+6ejEiLv2ZTff0DMgWIPaDCIqkZwGPdTGeHbuN4o62boM+KoG8xTWrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9921
X-Spam-Status: No, score=0.5 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the default MIC detection impedance threshold to 200ohm
to support low mic DC impedance headset.

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
---
 sound/soc/codecs/da7219-aad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 4c4405942779..6bc068cdcbe2 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -696,7 +696,7 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 		aad_pdata->mic_det_thr =
 			da7219_aad_fw_mic_det_thr(dev, fw_val32);
 	else
-		aad_pdata->mic_det_thr = DA7219_AAD_MIC_DET_THR_500_OHMS;
+		aad_pdata->mic_det_thr = DA7219_AAD_MIC_DET_THR_200_OHMS;
 
 	if (fwnode_property_read_u32(aad_np, "dlg,jack-ins-deb", &fw_val32) >= 0)
 		aad_pdata->jack_ins_deb =
-- 
2.17.1

