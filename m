Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899A27CE9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjJRVMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbjJRVMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:12:31 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2087.outbound.protection.outlook.com [40.107.15.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FF41FF5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2NaRYjuHV1EvSHL/hw3hETlT00k1NS/6//zpDf7x/597P6m1QzoSrM6cRjB8ZIQj53xTRvR9RNQFrhaUxNKw8lm/+1hkPTe7QwisN0AcWoHuiDhLxD8osbxC66+CEMF2SbCFWxRBhvXmKHReFAI1AVArcwQH6YePgtVy8+LRsLPj3HatqnFk2dQW8jVK78jWLTpXnD5ovGR3mouKbcxyzhKDl0omR9qU8lIcLrHtvy53o6QCDGGeUzmDy37OUJGNKZExF05w0EpMj4WPUY/a2ZIdZKok5wd06oAPhKSgPv07Xpl/lOWSgC/nRFclY3FJCQzsSOf2CYjNqG7B3v57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A7TUodxO7AkkBqM03CJiYKQDrUpiaHEzapJqI1G5GI=;
 b=A2WR9CNnEoqmo4YwDAemC0TyRT9jRHwMabDgdLJSy/TrXg78X/U4rTx2fbvYwA2jit7Nn4KN07Vp6WVAguhrr8sgMz9XehiKvfsD0p8+exAkpzFzKNZR7Lsq7teUuy8R5cdhKGEpbTlR1Rb9xWnqWM4uJ9R3mAqbKHmM31p2ygku6HGQVB5Jtk/+NVvFF8JysUujiMIV5Vq+Bal9y1XnjBqzEwEEoX0+kcxwFrzsjwjGTpQvHD4wihSpjItqzsQYSgp5F7q7e3CjvibxVvj3u8lBxd0mfOr+ERV1/o8kCVekzYuMLI0xxfe/UlmRscF6iSwxRS6MbeD7eHnUWhjR0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A7TUodxO7AkkBqM03CJiYKQDrUpiaHEzapJqI1G5GI=;
 b=qYevKj7LBUAd9OyGfZcamdFHtJBjLwbzRBrTz78iTGTMhi8I3TjjWiiTBNEFXncz0+MuhjQkKSotkvgFmVGW1DJC3UZGuy0W/9eEUd0YmKbufVhvelXTIymhHQhTF1barMW6VuTZnFHxtMHTuVy3kz6Tfz2tU1eF4wpCu4A4qmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 20:59:45 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 20:59:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] i3c: master: some improvment for i3c master
Date:   Wed, 18 Oct 2023 16:59:23 -0400
Message-Id: <20231018205929.3435110-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a15ac3-1438-4c2b-e7fd-08dbd01d2871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zgviHGxxJg4ypZjgial0IdL6QpCvjZuVJRsnLkhMRdH06Et71Z+7sjY2LEjsVPWsepT9Bx8R30ZLqUmyddiRvRBfKTqRU2lqhk9QwlljmT5piu7c37WyIJ1GPS5SEJOr1sG2GQPGY5SemLbU6EW39OnpcP7L6mk9l57VMH6KkpvFUFHLYOuUZ/rZe/eIbO9sH0Q4FI+8O9N+nOkwROg/pFvEPTgsll5IQR8UYerDVk25lgPBRDyIpm1eAG4mus/JdT8DnwKSAHhHYWjUn5XPSrIb+h0R6taCWxr2lvJ8cy/c+qSURXBKVBMK1bSQW7cf2PQ41EwtyAv63DOtu0lvuQRzEk0xWljEayBNc8H26bZpE+p8K3BZSjA40jXmfkWVLfeAtdTGmep2BqqVpI9tALZe7RxgWvSaNTo/j411lg4szT9LFMkQq2XwJT3WyUKVL6e9buwV+0TOmxvWuxYqE4HcyAqntF57fUFnVJpz7nZj91QDtoEk/iQCF62w1dUV1LaEKO5HqEEqmdZRtLr5Xsrp91OCiAqvlbupxuYt8ycbMmlO1a4aIsjHwIzx5aXWzGfdQZiLS4d80xFFjNK3fqgj+8TqTOQiPUkTqYg/ue/QajkdYIJBDzHn4RSeP07q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(6666004)(6506007)(52116002)(2906002)(4326008)(41300700001)(478600001)(38350700005)(966005)(6486002)(1076003)(26005)(83380400001)(2616005)(36756003)(66476007)(66946007)(6916009)(316002)(66556008)(86362001)(8936002)(8676002)(38100700002)(5660300002)(42413004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bElkcWpYS0ZaOTl6UUN3aEVoUWttT1RvZ1pJL2tzKzZyKy9mVmxKVjJpV29E?=
 =?utf-8?B?bzVEYjlRWTFYeTVmY0lTakFkQmdKcHVIdFFtWnVmNFFwQ3Nra2tGT0cvOXdD?=
 =?utf-8?B?Zk1GSVc0T0pBcGNCQWVNNDRxTVNYekFGQzE2RW9kSmExLzdFcG5rdjllYmNR?=
 =?utf-8?B?QWl0SjJJeFN5aVZxdkFVOU1FNmhvdi9XaVVQRGhYYWNBYS9PQ2dzMFpiRko2?=
 =?utf-8?B?RFlwQzA5R2tXVGt0dEtQdHpJOUlEVk4yWHdpK3hVV0NMUVNMTWxZdG9hMFFv?=
 =?utf-8?B?REJxMVZVTEw1ZEI1VHY5QnUwMlBXOEZUS29CWXk1WFk3RDFxWTN2RFFTd3h5?=
 =?utf-8?B?am5nZEwyZG1iT2JVSFlvUHlwZTJMalV2VnZ1a1E1WXpZZjM4aGhCMy9HZm4x?=
 =?utf-8?B?TXE5NGRZazJXWXgraHM5UEZVc2lmbmFsUTc0d3kxWWNyb3NTYWdXSnFhbENC?=
 =?utf-8?B?UllWaUNrV3VsR0pIQlZZNkRWUGpucTdNYnF3RlIzakhGd21UQTdtTW1tZjZx?=
 =?utf-8?B?cW92dUNnNFdiaWtaZmVHRVVVZEJKMWI1QUgzYkhLRjFQbDhSTU9hUGIxNnVB?=
 =?utf-8?B?aloyck10eExVTjVhTlJiL09VbjRuMjBXaXhKdnYwU3J2K2hDLy9QUXBJZEZx?=
 =?utf-8?B?MHpUcmY1WlRCNUR5OCtyWkRXUUtIUml6R01EMEtCRi9KVWVUVzJSZy9BV0Nj?=
 =?utf-8?B?Q0l0cU42bHFkYlBtL2hDSGlTV1Ira3MrQmNKdyt1SDE0YmM0b3VlOXlYbFEr?=
 =?utf-8?B?NmhCdnZESXV2SnRMQmxBNFFJaVE5L2EvNHBBbm5LZkxBT1Y4TUh0cjd0RFVt?=
 =?utf-8?B?dWpnL29GVUdwNkxHUW95Zk43RzJZc2JVNG9nWFJNZk1TSVZJMytoVDN5bXFB?=
 =?utf-8?B?ek5pSXEyMTNHRHR5MXY4Q1dHY1I2Z2VIb0dWUHFPd1hGUlZVc1pWUHNmcTZD?=
 =?utf-8?B?cWtWbDhSc0J0ZUp0VWNBQkhsMDRsczFuM3Q2T2dzcnRqK0tnUStOS2hlL3h2?=
 =?utf-8?B?b1ZJQU1nazNBclNncFVOOXhoQ3JFLzZISGZYRk1ZdmNNZmFlRUtidzBCTjFh?=
 =?utf-8?B?SzQ4QTd3RjhESCt4U0NPNjhhODJyc1JiNGQza2tTSVFxNXBNVWdXMUNPdU13?=
 =?utf-8?B?YmQzbkFlTVoyOHgyQlVlbXZGdTZKZk9sK25wc0dDeTdkQkV3M2lya3o2V3lo?=
 =?utf-8?B?bUxMRnYzTkxYSENzRThSa2EzVUY3Yk1ibDFJQzlyVk9Ha1JvbkdEZk43bXA2?=
 =?utf-8?B?Ym9Tdnkxb2hUZ0djOWNEdmttMHp3RFkxZmY4K2ZJeWp2dzdOV3BQa3pobWpB?=
 =?utf-8?B?Nk5aZ2hsMVl0dEYyYVhkeUJpd2VVcGJMY1hJRWNxRmZxR0pUWVVPNEdaVkpn?=
 =?utf-8?B?TmlUdllIakU0N0Q0UjlyQUxEK2ZLLzJ4bzIrYWJWYU5BSEhSa0dhRHF1bk5J?=
 =?utf-8?B?YU8zbmNEUnByNzVYSVhLTUdRZHhuL0R3RnNqV1h5MlUxRDBVajVFQ3hDaVFz?=
 =?utf-8?B?Qm1rc08zZ1VWTk9RSmV0enNveEFTWDQ5Q2NIZkNQZmxOUStWNVdIVGJwdHM4?=
 =?utf-8?B?OEhoMjdSRHNwaG05VjlTUVBwaW5MckNia2EzbVlaNCsyYTVkcTF1aFI0dURK?=
 =?utf-8?B?RUNrRjBTcXY2QWNrajBLcTlKcVU5QmhqSVhsUy9YQTQ0MklaL21KUGRFbWht?=
 =?utf-8?B?c1ZocTR6bFROcEk4L0gzMWhKNEIrRlBDUU9oTTZ4SGZDemx4ZVZIakZFK01x?=
 =?utf-8?B?OW4zdGJRWUQ5aFpBVlp5TmZuWUJFQTFBUUlEVDNGWlhVWDhNQWxERjR4dFRD?=
 =?utf-8?B?UHZFZHM4d0xZVjRuWFBtWmpQRHc2VENJZjNLUEVjM1V6UzJYek5UQ3lWdUpE?=
 =?utf-8?B?UDlTTURJT25kWThjWTBQMWgxVTExWHdMS0RwRmFES1B6UjR5WlZXdUlwMFpm?=
 =?utf-8?B?OUE3L28wU0hFTjVNbXNPSzYwdm5hWVZBM1J3UHZwTFlZMzBzbjd1THU4dFMy?=
 =?utf-8?B?Q0QrZmFaTzVzU0ZRaDNrT251dUNmOXR6MXZkWmJFL2NGalNKSFlRYUtOZXk5?=
 =?utf-8?B?SjRZbytEY1lIT0ZLN0xpRG5oNzJWUEdyQm5mTFpaMGlhUlZJYlptY1FOd3dC?=
 =?utf-8?Q?tulgMT4t4IURUx9667HjoakAP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a15ac3-1438-4c2b-e7fd-08dbd01d2871
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 20:59:45.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSzJMD5uR9b0yB82a5XwVbHXQgGwVgyhkF17OPamT5hcUY4GGArU5vt0xl9XVj4iwA+Iu402wZ1SluGdVvm5cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8653
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
There are three major improvement

1. Add actual size in i3c_transfer because i3c allow target early termiate
transfer.
2. Add API for i3c_dev_gettstatus_format1 for i3c comand GET_STATUS.
3. svc master enable hotjoin default

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
 drivers/i3c/master/svc-i3c-master.c |  91 ++++++++++++++++++-----
 include/linux/i3c/device.h          |   3 +
 include/linux/i3c/master.h          |   5 ++
 6 files changed, 217 insertions(+), 17 deletions(-)

-- 
2.34.1

