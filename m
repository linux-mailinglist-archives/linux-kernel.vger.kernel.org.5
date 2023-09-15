Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB79B7A201C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjIONrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbjIONrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:47:45 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB591FF5;
        Fri, 15 Sep 2023 06:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxfCV08bgEC4o/5K6mp7fFiY5HQyukKJ5dwPMVvtNGZYGrzuzsDCavB60P73p1EK6vmhseRhFcTNEOnypY3pSXZm/elpAVX4u4l3RCrHSwOkdyeZsRSpgeJq6Da2ODxgY9XKI+jQvhaup/a2LTIrS8g9/OXWR5hXmP9Z+QXWa1QiAaaud2jXrIoF8z6m5i2oyx/9RidkUcSyX/xJw27jA+OMQqBbYSYz+FrrSrobz9mlLkk3VOrYqxFhvnxym6QRQIzxZ9OlZmBkiLIPdV4bCB43iKelM6KGSL6mKTlixOG2pF+l6STGSYEEv+/dy5KTHPksgA4RBO1Ot93G2MKkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Opds6waEb8sct5lvtGQmWwRkF0ju7yJOrbohF50nuRo=;
 b=kTffYm4S4PVg1n/3+jDCuAra4uX4TKdt8FF4YuBCBFJ41llcHwRc+CpNbPZgymFjafy1iPWIqhS+V0MbP0PpnLziEILGfkN1ZhecP6SLDlRBaZEmTIw+mzEr4hh4Rkr7oH65YWLi0Vu5NW+vgn3ymcnmnX1cJoTYBojY5JAFoDf9mZAGHNgRg8psgToM6v03UYDy4pYrNwYMNHqxIWwod1pNSRAt0Wq8ChOWJ8IiTzh4x1mLMUkZQfPXWEXepeqeIjq02CNwlnXjRGdbVx0xYnVOcrAzemeT1W+RuIviS7mXj7tjuEHACmvBzdzKzldxSclSXi8LfX5kUeWrL6yLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Opds6waEb8sct5lvtGQmWwRkF0ju7yJOrbohF50nuRo=;
 b=YWpZ7lpjF5p4Qwd9qGbuOF3VrMKiIwYETx07CrMAFrH5V4DXhi9v7P0Rw6ssH7wAWRQYi9Ahk8imzLkeAipm7788o08YhFBC/HLhKPH7xfG5DYb/9aG9PzRM/oAssljQi42hVDAuCgErFcg+a6lhq2uI2s+mS6rGrtufblyiUyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PAWPR08MB9783.eurprd08.prod.outlook.com (2603:10a6:102:2ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 13:47:36 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 13:47:36 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v2 0/2] Input: st1232: wakeup in Suspend to idle
Date:   Fri, 15 Sep 2023 15:47:23 +0200
Message-Id: <20230826-feature-st1232_freeze_wakeup-v2-0-29ae9f747137@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGtgBGUC/yWOyw6CMBBFf4V0bUkZSEFX/ochpNSpVElLpjxUw
 r9bYXnu4py7soBkMbBLsjLC2QbrXQQ4JUx3yj2Q23tkBgJyUYHkBtU4EfIwZpBDYwjxi82iXjg
 NXEsBZ1kZMKVkUdGqgLwl5XQXJW7q+zgOhMa+9+atjtzZMHr67Bfm7L8etULkGRSlKNMsWivJg
 T/VbJFSrYhU0P66+N4cn1OHI6u3bfsB8x3YbdIAAAA=
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694785656; l=1537;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=da5YvR2hX2ppM6RgVFSXd7AleMVl1rIx2CgP/coMfqU=;
 b=9XbBU3kMH/o33kggB8kUQw/ESMBp/OvpbD0N4MJUY/2YEyTn0ST0H1NP7hIIBmTtQTdiS2tvo
 0ZJIV6kK2GTCfWUn0qddA747lRUBV7YGfnabcfZP06rizv1/AfN5MmH
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR08CA0233.eurprd08.prod.outlook.com
 (2603:10a6:802:15::42) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PAWPR08MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: c09d9e42-c150-4338-4856-08dbb5f251e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KjN8cK9DrUiVoOM7h43R8Vka6Y8EQRF6CjDoWdXwhsFYQWPyyqBXefkIRJQFpaocobOP+MLPOjrps9xJISBlZpSKBwqr/lldjD/53eGx1dvZxd0y5tR+MphLSOlALy49eZyMsltDk4jbPcbsydcA2jzKCBKniceJboMXkKN+8bFt34Kbhiy1q6RkO5scgywCia2t8Vqh737KIttZmRL9t+8AYA8p6bGAvVWTDx0VrouOEbk3k93yNlBEKig1QdDqETAQEFu30kWeubUxZjEiAFeRAhZP3LA0JVqfFK4ticmkYRvqvUc8ROgdu7yMeLHvZoNiMzU2UzdcbASUbD4b5Uep5Dv2zFlG74LA6bvQfiOZgFMeLZXzcgGKv4VDwJOatR9Sls9q4iIaXauQ+mTk1c35x46ViLYN5TpDFXhNtts64DqXMyghWX5amrrtoewhr+gpXQTbon0sOju14d47TWS1iOusHK/WO0GuA08KIGheUX+jtavNdEZeW/1KyA9dfyoFuEJolnX6zIQC11taZ9GqJIJMRyVGoPTNmBzaIMbUWRCgAtFBV+DWNltZF8ysSofCojF5EZnWefE5XuUcMq6/G4eqFdfAzCsHRbRi24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39850400004)(136003)(396003)(346002)(186009)(451199024)(1800799009)(41300700001)(6506007)(52116002)(6486002)(6666004)(38100700002)(26005)(36756003)(6512007)(86362001)(38350700002)(2906002)(2616005)(966005)(83380400001)(6916009)(15650500001)(8936002)(8676002)(478600001)(5660300002)(66556008)(4326008)(44832011)(107886003)(66946007)(316002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWkya0IzazRsYmpiTlgzejZRR1N0S2M1QU5aVnNaTm5sb2VnVTQ0bm40bVpY?=
 =?utf-8?B?TVRkVnVpVzFPNUZ3ejNHSVZ5VUx5MXlVdldIK202MGJXeEdubEp6bnNpM25U?=
 =?utf-8?B?elVLZkZoSjRZNlJKYXdUTXA4VTJSMXRteU5PbThBa3ZwcGRKdUdOMUVLbjFR?=
 =?utf-8?B?Q1ZUdTNsUkZ2bmZoUTMvdWdVN3pFbm9lUnY0a1l4TVFBcml5NVFsSTRvZDl1?=
 =?utf-8?B?c3BwMnRLT1huNFVWOVg1dkNqOWhtM1FUNzhxZnZOTktIaHpKbnRDWDN6cGRv?=
 =?utf-8?B?eHlrZTNCNDBmRU0rTUM0YjlCTGNYeEd5NmdJVmNFRCthV0tGaUY5SUNGZGsw?=
 =?utf-8?B?eFk0VGpzTitHSC94NFh3TnRWM0hlUGRyVE56eW5ZcTNBcE0rRk9XSXhuc05E?=
 =?utf-8?B?a3RuWXFULzBuWEE2Q1V4NEZmWG1mVFRTUElLeU92bW93ZTR2ZGc1UFF2Zlc2?=
 =?utf-8?B?TVh0ZHc5U25MUEFJOXlFZVlBbWlsR2RjR0VGODFGOWh4aWw4VjhSV3d6OW5o?=
 =?utf-8?B?ZUt2Wm1NeTN4NHlDTFVqN0dHazhjcGlxQVRDZHFUKzMyYXI4K0pyNmtQa2E4?=
 =?utf-8?B?ZHFLWkhmMm8zbUFvNTBrL1RrM2owWndtTlVrY3VuNnRGMTlkakJTbE1Edm9h?=
 =?utf-8?B?amhuL3I4ckoyMC81akdPdVZHTjAxYzdkemVvdG1mY1diNldnZ3dNa2duZEla?=
 =?utf-8?B?Ujh3VlhsRGplcGZLNjl3L04xZHB5anlvRlMrVUVVeWlORC8wYk9WZ0p1RVNN?=
 =?utf-8?B?Q3JId1BodDNjSmkzTlgzbnV3Ky81QnVuSTg5THo1VWVXc1FCUlFkM0FJR1pt?=
 =?utf-8?B?dEd5Mm9kb3NWRVNGcjZoa0lnUGxZbTk4c0ZoZ3FKN2owZHFzc0dOQUpwRjdQ?=
 =?utf-8?B?dVhQS3Y1eWcwcVpIVW1JMDl3YllHVVV0MTh0SjVBRHpPQXFXMjFOUU9DTTUy?=
 =?utf-8?B?anZ1U0E3YURUM3gxWXo0Z3cwSTRQWC9HM1lJM2RXOGJXMldVbW41RW5uVm5y?=
 =?utf-8?B?V3BqSmFRM0NETE1ZK2g0Rk50VURQQVgzYXZzSUk0R3EwOExSZjY1bjdDSmlm?=
 =?utf-8?B?a01CNkxOWUxybDNkOTZ0RzQrQ0ZOcVVIVUVMVzd3TkZ0UW9iTlhoVy93REpm?=
 =?utf-8?B?UUlDWE9vTU9LUGJleExzNWtkZ1htb2JyZy9WV21vTlExeXA2UTR0b0JlYjkv?=
 =?utf-8?B?MTNEZ0g4alM5TEwvWVpnR3RUMXFOU21DZGRHelBKemY5SkwxZXdyV3M0dm12?=
 =?utf-8?B?ZmF5eEpaREFkRkM0Z2JMOE5ycjhyTjN6cXRzZnVxYmpzSnk1YnZRUnpQQWo4?=
 =?utf-8?B?bVVUckhSZm5XUXIzVGdYN2dBck5yeGpCZlJzaCt3bFlHQ0lCWjlwUytsdFdq?=
 =?utf-8?B?Mk8yaVBlRmU2RlN1UUh2ZjFGbUd1QUpoamFtbTFlc2RxWGowZGVMUXU4Y0VE?=
 =?utf-8?B?TkJGeHpEMHZGOUtRNWZKRjgxV3ZsSWhwRTdDUjkxenIySGpsdXRWaTlKajdS?=
 =?utf-8?B?aC9rQXRGUUpnSXVpZDN2OHpqM3Jtajk2ZkVjOUtYVVhxaDYvV3d5UW54ZmVS?=
 =?utf-8?B?TkJSL3dKVmZwTTFaZnB5TjBBS3oyTUFLeDh3RjY0QmJBYnNsVlRJY05qNFRL?=
 =?utf-8?B?aldFTTBNMncraUZpRWJwSzBicWVjVGpaVE9GdGppd21mbXhzbTVnR0lSNlJT?=
 =?utf-8?B?OGVkK3AzM01EaCttYXZTbnBKdlRKTzlQNGxjRC85TXFxb3NaMHlCbzVoQXRw?=
 =?utf-8?B?TzdEKzRtaUlGMVljY29rT0FYbm13Y2JjbUh1UUcyOExnTlU5L1IvaW9COHFj?=
 =?utf-8?B?UitVTmNqNTBlejNuSm9hZDdHanFTdVo2aktNTE9kYS9MWEtQQU9kckZLMFZk?=
 =?utf-8?B?aE51QzRQckJNWlBuVHlOeXpFdDMyaTQyaHRJbWRYek9ZbUhXQVhQc1gybFF0?=
 =?utf-8?B?UGc5WVd0ZGUyeWErNTM0SUF3OU9qTU0yY1V3N21xdHVTcllwTUhBdlRHS0hQ?=
 =?utf-8?B?T0tVeFVUSGIwV01qbk9Bc3BVc0ZFOUgxNnhBV1lqZzZ0UjI1c2pqV0llcjhW?=
 =?utf-8?B?SkozZmd5d2xqWmZsamtWcXJtc0t4dUp2S1dlUWR4S2RRRHZRd1F2ZzRNSlFp?=
 =?utf-8?B?SWJ5ZXhhZldzSjNoSG1WNEZDY0ZrTmVzKzl0MFNuYXp2cEdHMzlBNUlkdkpC?=
 =?utf-8?Q?K7LovcYD8vG2/7icdx85qpU=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c09d9e42-c150-4338-4856-08dbb5f251e4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 13:47:36.4972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4pKmfnm5opnBHpwSa5eJOMsP12E3u41amij2lpv0lWxT6jWVggnntpTXFCtMt6LQlSftzXTju5q2njBTtq4nkMowWrcJSveasu020J/mxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9783
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The st1232 touchscreen provides an interrupt line that can be configured
as a wakeup source, and currently it is possible to use this mechanism in
"Suspend to RAM" and "Hibernate" power states. 

Unfortunately, that does not work in "Suspend to idle" (freeze) because
the device driver disables interrupts in its suspend callback
unconditionally.
Partially reverting the patch where this modification was made to
disable interrupts only if the device is not a wakeup source has proved
to solve the issue.

Given that the st1232 device driver does not reflect its wakeup events
in sysfs, this series also adds pm_wakeup_event to the interrupt
handler.

These changes have been successfully tested with an ST1624-N32C and a
Rockchip-based platform.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Changes in v2:
- PATCH 1/2: enable/disable irq if the device is not a wakeup source.
- PATCH 2/2: remove unnecessary mutex locking/unlocking.
- Link to v1: https://lore.kernel.org/r/20230403124707.102986-2-javier.carrasco@wolfvision.net

---
Javier Carrasco (2):
      Input: st1232 - remove enable/disable irq if device may wake up
      Input: st1232 - add wake up event counting

 drivers/input/touchscreen/st1232.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230826-feature-st1232_freeze_wakeup-c602968f2f76

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

