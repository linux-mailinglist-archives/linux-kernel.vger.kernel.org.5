Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74FC7CAE03
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjJPPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPPqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:46:51 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2922283
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxa4zvalZRXI+k+bJ6CNTnMy6cF2siLG18iWcC4FFDMuaJT/Mt4FwHvlf0I3r/8sry8E59z0hyOE4hQgPNOuMuIincE9btuGxqDGOLpCM5+GFbVe54tAcFM2mvbYUUkCl5/z1XRVcao0DMohr8hyO6BcbUpaBAKsYj9Y8X5y/0BNgrqTPsyqIxJitUbRUetIWq80Co+slW5uqbjAd5SQkAj7iKQjhWuZxy6Qe+2lQ8asc30W75DOHzLnJbAIqf6QUTDzqm1ERvbvPqIVn9c6kAmFNN19pPFb7QtgG+vn+LCxMf+TqO9wS3HpFpXBjEB++lOCQTlMEMthmh2iRNOGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScfVmsfXbCWnrpepgRJNmOHNIwDJ7f0NuygkmmT3QR8=;
 b=K2GDXzjwGakWBMRH9mL7XBpES+FxeloyrxJ5Iass+AgXU92LleA8pyRVXO9cOqcLktJ4+wxqlH90paKXdRH5caYvJMjyWCDUPM2krEXj2J/wjmLd6KMZNAaomL5XfQBQ5i8Q5UWtt/Ksk4YKH2fWdVLpn3ZtkbYKPN00P/vTTCQtiH8H3rqKHwO/3p9lZAPWF8BcdqMh/gyvEZwQJXGcGh32YLNX8xi44O91PwBkharpPnZaS2ugff9pITv/G0L1gJioBpA4Bk0aYc6SVe4Nrx7bdhxYPk1vW67UDnWZs+fpw6ykuvvr6U/Z3UIQTgKF9Y5bs+TN72muL3xMv0PFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScfVmsfXbCWnrpepgRJNmOHNIwDJ7f0NuygkmmT3QR8=;
 b=BaA1AUBQsP/bhwyARhjV/lBYOfMpa8K+PNMBGSrOT8M0GBB+E3XFLm311DBw0Z/3ahzJN0cg4SAQ7iJWLY83xYnWuTtPEarQR/OuiACBS/bk3yXdYF2uHOaae+qD1HEumPbrsQOyOEvXYrbaBLDt+eHdBYx5FbnWSMlu7notrBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB6998.eurprd04.prod.outlook.com (2603:10a6:20b:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 15:46:47 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:46:47 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     alexandre.belloni@bootlin.com, miquel.raynal@bootlin.com,
        conor.culhane@silvaco.com, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH 0/5] i3c: master: some improvment for i3c master
Date:   Mon, 16 Oct 2023 11:46:27 -0400
Message-Id: <20231016154632.2851957-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 56767342-2440-4db2-375e-08dbce5f1ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDjG6sUGDsNI53zN4HcbhoRT7xtgjqzsE5efnegtuK8pSlVYCTYfkxM3KFlhY5jDRhhNnQZwUNglQxRL+vnzB+vnC7uPSlgBmE2l1ECWHKk+FnE1xm2qlr/tia2hBUrL7C94jPCqFNmQ7zEqnB4z/ecGf89wBzMKgbOuazH7y08I6nafP42eTs1nus0IY4Um3IUw3aw6AsYjkOldQibR+tWhRVXHPYb3TiAz5fEBTX98bFVQ/4ewAmF4pQBoDrBYiXAMgg5RGrwVR/mjCuOZx/wzF2VAYNfnT3948xy9oT8gzYvjTTJn8Cq67+6GS+k4FOri2jRs5cLO1teoVyjd7DtPMXFZFrpd+b1jLrKAcLGFSpSE5tPoPmoxqdGnZDNXu510WtSRs7l7YQyGZRx1dsu3246j+Ko0TAbbXRbii4Oty0fZsy/IMrl7RUeLr2pt81skFag4ZqfQVzodaQAID9KP96NVBbEFUt0aAiznyt/qz/qRs8XSz8LY/TI6e2kryy2/Bm1xsBlerhjUHG6bSrQY7ZziD0raXcvPmU4Unygubkg3TyGgjot3FGJlZ7f0kqZk+3QyNmcjO+sa+ljJ3lFyWZFRZ4iG8Yja9CFIfcVLNlNCV+zgAtdh3rK4e1Pd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(1076003)(26005)(2616005)(8676002)(8936002)(5660300002)(38100700002)(83380400001)(41300700001)(478600001)(86362001)(6486002)(966005)(38350700005)(4744005)(2906002)(316002)(6666004)(6506007)(6512007)(52116002)(66946007)(36756003)(66556008)(66476007)(42413004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmdOclMxU2hWN3ZEOHc3K1JCSG9iMUNWeC9jRGxSWTdxYlQvRnRMRng4Q3c5?=
 =?utf-8?B?OXF0alJsb05xUmk3U1J3eGNSRW5YcVhNcVJUbUpMbC9BTXhNWWd0dG1ZU08x?=
 =?utf-8?B?cDVKb1pHVTgvaVkvMFBmbXBxSStxQWhvWmxHZU1saUozcEtVaGMwbnJhUEgz?=
 =?utf-8?B?TmU3Slp3STkvTzBjVHpHV1d5YjVadG1XdUtydnJwRmViNGFGMDZjMHl1VGhv?=
 =?utf-8?B?c3B2SlJkQlpHMEF0TnkvTzVpZEpJeXRKNTFIRFhpSDd0R0lqcHROek5tNllL?=
 =?utf-8?B?SjYyOFg0T29KbzNXcGhxZHZpck5XWXJQeDZKYndwTkdsd1pyMUp5MDZUSm9Y?=
 =?utf-8?B?SWRRd244RG11aVFhN1QzYnE5Q0lqR0xudSsrdERPQmZKc2tzZjY3U2hVZ3ZL?=
 =?utf-8?B?dFR2SndKSkxkY3NETmI0eEdmUkNybzhFMGtRWklnQ1dEMUY4aWJzdDBzdktz?=
 =?utf-8?B?dWJYWU1sWjZQUy90NzV0QUZaMVZVTzlMSkxhRzZNZy9odkJnRDdSWFNHNEEv?=
 =?utf-8?B?U2Z3dllNMUFmTGRFQktGbjREM3ZIUlNPelRjd2xJM1I5WkFNVmRRcjlwQkF5?=
 =?utf-8?B?NGZVYTByUWhIM3lvSDV1c2xQdjQ2VHd4RGF2WGJRMXloTm1ienBLMjhEMWZK?=
 =?utf-8?B?V0lvVjc5aDQ5dmJZdFVxOGVBM3d4ZlhFRnlaRERZVVNBUUE4bG43elVyWElt?=
 =?utf-8?B?RWVJc24yVXVhak5HaUFwNm1Rb1E2YUpNeDd0UDVrcTN2dFQrUHZaaTd4bkNO?=
 =?utf-8?B?WVpSK3FrRjZya0NteDMwMThsNmJnM25oNDNOek5yQUpuZ0JpZ295MmhkZklu?=
 =?utf-8?B?SlFWbXd2MEwwNnNJNWhOZXJmVW1sVGVTb2wvQXI4UmJlSGwyUko0ZEc2b0gr?=
 =?utf-8?B?MFlYRHVSaEpXV3Y5QzhoN0wvb1BoZmhoM3hiY1FzUkphekdIMWNzMnVjYk5S?=
 =?utf-8?B?WDFhLzQvaXBJdDd5OCtCVmIzRXhxOER2YnJhYUdUYU0xbnZvbS9tY1BVZFJO?=
 =?utf-8?B?RVFMRFJjd2F4Q2l0QWhYLy9TZTE0cm80eVdLS1ZpQTVqZzZqMEoxVU0xcyta?=
 =?utf-8?B?aFMvUUczSkozVlRsa0pLSjNyNVByZ0F0cGtQNERrSExybzFzamlLOU9IRW9M?=
 =?utf-8?B?Q2RFKzNwM0Rmcy9JL1RpMHBlbzg1aVB4SnUrTlI2L1g4M3VYcnRSTzU0ZWN3?=
 =?utf-8?B?NXlFMGFJK3pSSmFEWlBjRWlod0xkL0xHeis4Y2pHNkQveU5aZEx2Ti92U0Iv?=
 =?utf-8?B?UGVBMnNGT3VBV0EzbVVIVm1yWlNFdVo0SFhvN0gyclMzWHJhZ3pMSEEvVlJo?=
 =?utf-8?B?TGkxVlkxZGJyeUFnREJvSlpRSmRVNVhXeG1TS0Jyc0pLL25Vem1RNU5oZTVM?=
 =?utf-8?B?WHZXZ2k3ZzhiMDVBc2hGeEk2TzFFalhSQTlIbGhIYUl0c0pmMFFwR0RTcU9F?=
 =?utf-8?B?cjFQS0lyU2dva0h1VlFrdEp1eGRkc2ZIcnM5OUFJdG4yblY1YlRDUlY2YnF2?=
 =?utf-8?B?b2lFbENvbkxSL1V4cTB6N1dyUjBsWXUvbjZ4Vk1TcU5DUC9FRDV3ZXl2aEFU?=
 =?utf-8?B?UURaU21MR1AweGZBSVBxSnM5MXJLbkhWdkthL0M1SmdzdWlhalE4R1V5bG5C?=
 =?utf-8?B?cVhaUzd1d2hkV2pnbktmWlQ2Z2NxK1Y2YldkS0Jaak4wYzhPWGdoR09NNU5B?=
 =?utf-8?B?a0RKdFVXaDNzWFJ1N1NjZHpWMHlGVDBzanpvdHJJOFhkazVQTXpRZm16SmxE?=
 =?utf-8?B?MTROaitOblFxNHRmdm1YcURQb3ZtREZkeGszN05Sd1E0ZVNIWG5VWUZTMjVz?=
 =?utf-8?B?Y3RVYldhTklVY1YyQlFFdklDa2hhdDEyTWU5ZVJhcGFMWk1ZOGZCbmhyUXM1?=
 =?utf-8?B?YWRRbFdMSU1uZFJTbTgwMlZiSGVvWWdNbTd1V3p4b3NsSWtwMGJhRnZidUtq?=
 =?utf-8?B?VjNqbXhmay83azZQcDlYRnVaNndvQ0MzM2dyUEdFZlpMejBwTWZJRWRTbFhW?=
 =?utf-8?B?Z0ZtSUpjR0laczNBRUNrWHRrU1ZtMGRJZzNwbXgwYVRLcVVjVUlPQlArUytZ?=
 =?utf-8?B?a2J1dTg4dEZDNUptVlVHYmtUVVFMelJDWFJQNzVYOGd5ekFZNC9jSU1CWkNW?=
 =?utf-8?Q?u2ZE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56767342-2440-4db2-375e-08dbce5f1ade
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:46:47.3979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jq7lgxqoRfXGFXKbLROW/hIlld0pUAefN9dT5VMfsX9zSZEPsEigY6fqMZSqWFm1F1D8vxwTaetfI0LCFgNGGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6998
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are dependent on bugs fixed serial: https://lore.kernel.org/imx/20231016153232.2851095-1-Frank.Li@nxp.com/T/#t
There are two major improment

1. Add actual size in i3c_transfer because i3c allow target early termiate
transfer.
2. Add API for i3c_dev_gettstatus_format1 for i3c comand GET_STATUS.
3. svc master enable hotjoin default

Frank Li (5):
  i3c: master: svc: enable hotjoin default
  i3c: add actual in i3c_priv_xfer
  i3c: svc: rename read_len as actual_len
  i3c: master: svc return actual transfer data len
  i3c: add API i3c_dev_gettstatus_format1() to get target device status

 drivers/i3c/device.c                | 24 ++++++++++++++++
 drivers/i3c/internals.h             |  1 +
 drivers/i3c/master.c                | 27 ++++++++++++++++++
 drivers/i3c/master/svc-i3c-master.c | 44 +++++++++++++++++++----------
 include/linux/i3c/device.h          |  2 ++
 5 files changed, 83 insertions(+), 15 deletions(-)

-- 
2.34.1

