Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7992F7633DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjGZKdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjGZKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:33:16 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2138.outbound.protection.outlook.com [40.107.212.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4C52126;
        Wed, 26 Jul 2023 03:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtOrrbfjommzzF4PgJPfS/CGBbrI9OryC8da+/kng5qxi4WZN7yoM8O0v7OPJXxPVv+La5Ul0xb55wiBg6lVVMKwTRx4FXKXdZxmpDxOGbmSf5QA7TNFUwkS1nLQKHiu2n2qfHont+kznjS2uOcn1qc4i8AspuS49j3JLWBhGd/jvB0UjAF1MnY+ISMskEJyMIlewSQ0BlEfdbTDzR6sV3HGMAyLIDJPL7QC4Ay9Fj+qM3Tu6QTIvL8l1tZyaWfV0NFJtWn6qlleYhHweO2M0J3KobLArXm0e+02HGWngg1gd6n8QUwHVuocs1jqh3eG+BuExANBSIvuopLG2M3Gxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqkMUatlcPXvZB3kf7JWcwNcqa8mMAMOaV13DHWEFXY=;
 b=AvH+IaYxwKQHB50zktb94UJtlQRP3IMQwXT5Ca/9LsAZya6ob0wL8TpmvuIoA0gGV6ECSBN1/JRE9vswSat+jSetLPn91ExlPX/EucZ/z5EaEoPV9VDupW7FW3pM4OzknFB9jHFWdfw+lFFt0KvUcrhSrFI5n82d2DGM28GPdAywheFUmbM0hW8WeYBg+SOYtfJb+K/8Z887Zd6ZlHg9g7XQVxyo/LCvOutMLAQmffBmQ+LC8jw3mKylNbGLtEqhkn5/C+4watoEtG3HUXB0tY3Dc9gCM18xk4Hky0C9g8srRTJjWxACQWg9a+QurBWfDMB2UCnmidxXMfujKe5SEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqkMUatlcPXvZB3kf7JWcwNcqa8mMAMOaV13DHWEFXY=;
 b=SlVZ0nXVM0PDbKxt3P36dvJphyvgzER21iLBG5itRrs7vOAzosDqvXDxNUNp41mgynRGcsIFbFh8h6DoHxGEQhhLouzOVlqyg4TRZ+5Z9lqhEvW2bxDp+Yz7E9xn5I7t9kk/42C8fC1dnl7ZWsFod0ZZoK/61spHk6bkHYA1/Jw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA0PR13MB4064.namprd13.prod.outlook.com (2603:10b6:806:72::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 10:33:13 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 10:33:13 +0000
Date:   Wed, 26 Jul 2023 12:33:06 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Howard Chung <howardchung@google.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        Archie Pusaka <apusaka@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: Add timeout in disconnect when power off
Message-ID: <ZMD2YqAJ9+2i5ZvH@corigine.com>
References: <20230724111206.3067352-1-howardchung@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724111206.3067352-1-howardchung@google.com>
X-ClientProxiedBy: AM0P190CA0029.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::39) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA0PR13MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 258e5a45-046e-4ae9-3a7e-08db8dc3b73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZXYj9BeNaqW6MmAQ+pqL58WOMF5UfJiqj+daQ2N8ZWzWHIr4OvKXrOpGJW4dw4Pb/knBweUVT7F1+k6Y+L9t2/KZN9C4Fbr7ZynLDGB+O2A1YUXov3LHmqcrAFr2+PRtaWvdTp7emST9lVXa35aXzIw+YW2hNC9mybllvAuae6Uk7GKmxKwKmz4fRuS6gl3QOEwcTSOOiyuGQBcZUnSAiBt+/KYisKxpAFhXQycSsgXikHGbkG80X8bE7/a1g9GpXeb8OathtSMC/h7IEts7m4Y83S9ESkoLVpYsEP9xkKJooMw/cVHQ0TMLXaZLx5eKH9Ov63rvFG1hZv4XuB5E5H6BzPwEnYkopv2raqMaKyTRzP6Gehe6Mmsq/HEDQ8owPuL/QCwkj66IEkKiJ2jjXiHOWV2iGkjQ7HljWa4WQpxW3erxnDtM47O5vfSJ71VRIpbObv6AndkVzfC19NnX1W9pXj+/H+EK++RPHdaxtjW8QnxbJz/UlcUM9eHka08FyeqZT88xRBW1PXl0MiPub+JcwOmUeq8cTHEeADCZH97/cdYyTm2dw+PP66kPmP901xf2vVuaBdFYjtCOG0DUVAxQU/w/OBmkZdz9Z/o8s6fcOSo3cyHl6O3SmUqHMAg6G7jK3cB6J3mPSlcOs5EUteYI341lvDO83kt4AiCz2/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39850400004)(346002)(376002)(451199021)(83380400001)(6506007)(186003)(41300700001)(316002)(2616005)(6512007)(6486002)(6666004)(478600001)(38100700002)(54906003)(4326008)(44832011)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(6916009)(86362001)(5660300002)(4744005)(36756003)(2906002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?evleGRBosSUBWWSSeZJTaVNnuDuGtBAh9wJLN/2cS5MGqn2ynDGcBIfNyDWk?=
 =?us-ascii?Q?25nCVldA+wno3kYHCuaO9wg1gXzYhL1MnLHz0iGPTHRUM/VsxNCQoDfTj+mg?=
 =?us-ascii?Q?2AzvrampzqfeVawJIIMbJucrKpPh6RQVzSMROvHRBsSbnOAM5CbAMcmwA6ZF?=
 =?us-ascii?Q?mWGlLffwSpdg4mTQBAy6/sqxP3I/VwrndUi4aslkdoDV5iUskWAvSqmsVsDv?=
 =?us-ascii?Q?TCLTCSUXjcLIBGLu9q5+ZhoufEsAVvS5qa/SC1WPx5DvBqEUQ9mAlX/o9kpD?=
 =?us-ascii?Q?AwqblHtfN2Q3o13OH/p+JhNa3h0lAea2NJ8akih/Zod5Lsuh6ET9oKz8qU2m?=
 =?us-ascii?Q?5iDA4TgpzNK+z6i7VPTtC5kuMye8dGlqOQ2Rp6cSlinftEesJUC7egw3yPnX?=
 =?us-ascii?Q?zJElwUVnjHvbIL5AW+pJnljDIIB4fOaxr89ptuMHePTRmuEix7i8VwI+6nDy?=
 =?us-ascii?Q?3AExweEUbNoALUsww0rkPek4VsF3asBx9qAeaE5ROLXsb5R14AeR+WXGNMVQ?=
 =?us-ascii?Q?DHGMQDmvBOlqMvTwoqJTu19soE8gN1RRl85lvKr2Wa7iilfYGMc2qKMFeYLP?=
 =?us-ascii?Q?JjWIhciupl9xZrAP3stSmr7tc0kkwYkTCOm+jI4E+UGgLbcdUzdd1RRXfXEm?=
 =?us-ascii?Q?J3iodo035BTsjh3NahUtt/LsJYXoVab/mDWewxpCKymTtjrnZm3pxnKcACvC?=
 =?us-ascii?Q?aq8q8F8ittrnCS4X9ymuCX4mcWgXC2jMzSdttP+3vejThI/LXf+o86QFAGg0?=
 =?us-ascii?Q?Z/6CDE1OReQzI7zsGNSkQayjtQCH7II4mwFyprbGFl54lwrvZz2gyJYTE4Nn?=
 =?us-ascii?Q?iW4iIOUUSi3FJaVS/+HCegmNUOMD7VwVDOruF4B80hYhKCivwsv7CTA9DvZx?=
 =?us-ascii?Q?zFMTQyE/ajyYSewEq9uXTPZy/W/qU7jDZ/ZAH9ehR5k7gbm1vT7XKSHXavKx?=
 =?us-ascii?Q?UoxNrzmoOtzhiGJVwLq6kIa3M9XMFWfKoAr6ktKkSkI/qNzzBZEVHuXXYlRz?=
 =?us-ascii?Q?JBKezUoKvjAvlOp+Z0+CB5SToaMqd/qZPrsvTn3SnUDBWWSQT7RYLCR7mUP6?=
 =?us-ascii?Q?JElGCx21fvU9sXl92s0NQnRnNpDEqvOOtFRRhArAtbDVEXDOMKH9QtZZayO4?=
 =?us-ascii?Q?UERF545UFXyK9d7sb0XZLTfVSi533xYaedihUNzqOZJGKu/pJlvwI7PjkXhS?=
 =?us-ascii?Q?lyj0DU3BIJofRC2Y1uj5uiwoy4PFuiLmNQbFcJZrH9AZRGTC8Exl75e/mDOw?=
 =?us-ascii?Q?6YD8PnPhbEQXhc3wVmbCN0zf5WtBIFvGvGcwrWXQ/NjzsAP36LwAU238uLfv?=
 =?us-ascii?Q?Q2wMf0KZwDmBKExsa8UKAbbqRTHzpNcKqKID9pUf3pVosXKVj5WeX5HUNkqS?=
 =?us-ascii?Q?HzSCwwW5O0wwyiNEsJ3B4u8oxvON2bujeg+rPn8sp2r48+FgHtaUngZ/MUYP?=
 =?us-ascii?Q?Zej8TlmtAe/beZa/Z9W3ovchWd9p67jrScDXuCwNdHfWdSLVDW7IZDiLUPlU?=
 =?us-ascii?Q?9/qTfoH0SNJPJdMc5Kvbkr08FLCzpjr0OXU2ZkEXZ+AyK3z5Y9CZ8ZdBFGZM?=
 =?us-ascii?Q?L26W+67q9proMg3+kPiLrbhfFxJaWtyi6QmtLMwLG/0SHg9f59qCmzV71vNW?=
 =?us-ascii?Q?GutDU5/cR2ubDunhQ7DQABTaze9LBddeYnbu9hclFm0gp4lqwdijMcnR1HnC?=
 =?us-ascii?Q?C86gBA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258e5a45-046e-4ae9-3a7e-08db8dc3b73b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 10:33:13.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+T5YzxTZmJNLqSQdy54NW5g97QI96JrQKDSTic77hIfCifLmKtP18F1U6HBuPUB2Mep54hR1Oe3WEMdjMNSA97dbW1hIY8xeTrbZDHaJF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4064
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 07:12:04PM +0800, Howard Chung wrote:
> For some controllers, it is known that when the HCI disconnect and HCI
> Reset are too close to each other, the LMP disconnect command might not
> been sent out yet and the command will be dropped by the controoler when

nit: controoler -> controller

...
