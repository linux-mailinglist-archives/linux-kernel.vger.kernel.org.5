Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF48A7A4003
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 06:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbjIREPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 00:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbjIREOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 00:14:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9009F;
        Sun, 17 Sep 2023 21:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTr763rtPWpbi0O/wPsdV/xoV1ZBiXZaC9TQ9JVqwFyX/3BbqoM6sh1mmhIF2dL4whINcubERlnCBG3XrqeAJw5yPVSOHbyt3xUfH9lkrj6DZ9rDx5AY1XWEHZpYQ8Wpsv8sxJgX5RD4mK0DP3IM9MszRBJtF3UAXnOj3iHpEyI2N/WAr+14ejTt2h+9YeqyRggAiSMbYvbHpJ8WxnFETcEUftz4V3LGcXFKnwvhUrX7q4CqD3DStnnMjX10ARZtdS4NmLHcLUugpx56cA6VH6mIV6inoFzdw9WJ8V5kM0nKzGCWOk3qIohwCFPZtay1zPORp+NVXfRLnfBohxF+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQxF9/pKXo/4pkEoVJPxpLCLfjM/7XPRUMW0kT3Dkmk=;
 b=NZveR1tn6rdp+GhJYrtuqV6WPEKcGtuEUozBcg0520ZV2zM/YHXDZQseheNTIcL5Joa2LLbyuMYVj6VKmzczdb1l2gPKMVO9BQZKtH2gvq43K9nNai8eYkMrJDTgJKnRxyRp3t55M+Dg+vK6Pru7pAYARY9LHhEKJ+v3XOOMR8A+VPSCQBJF2OYSaoaWzrBZjVNzXdaAJoL27uIrA2fP7c6nx7yRa/9gKo71MzIaZGckHMztviq/66nCoI61EDYFKHPCZj2KmrFO+VrV/hn0OTGZKZR+Kl+E7qmFWDDo+UNwGX4M/eMImaiFSNRbd0JaPqyxYRYm0Wi0P2l1gDB1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQxF9/pKXo/4pkEoVJPxpLCLfjM/7XPRUMW0kT3Dkmk=;
 b=tM5WblMykzuPS5x4Zrg/GmJ+NX5kdTIWho1vT7mT4XtIvYFYk4/yzIOTS5JJqnYrMmdGxoSLPSuUbBgRY++sc8ThhhCUbcbfZ5JzydV+mbLA1fa+wftPB+S0zXeu9BjOA1Lksnr6sOB+7YWvS9POU+Owb3fGTFbINhdYEudx6YOVGWsTcPCab2at3Dn10urlrP0N3gLrYnV4ZvRuUQi0xP1SOZYFPCQwBay67ELPxTQwvgp0/nXXHQS1aJ13FWNiAaC2iq0l6AMxja8QKjsXLa+EWn/9c3sQf0wHbVSP54WMp5yo2dLlfhxzU7SQrFKTYInT1HvmqACsHpZ0J5ks/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 04:14:26 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 04:14:25 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH v2 0/3] HID: nvidia-shield: Fix the error handling path of shield_probe()
Date:   Sun, 17 Sep 2023 21:13:42 -0700
Message-Id: <20230918041345.59859-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0208.namprd05.prod.outlook.com
 (2603:10b6:a03:330::33) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e68870b-da94-4813-4aa2-08dbb7fdbead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jcTotBFxr7R7K5j5019YS+Owyi0b645Y/txXOf2rQAFek/omy5pPq7lb/zFy8r8Z8pudF3lUdYu4Qp4eLXQgUIbans32Zb5JqGnMj0laO7hmACcDtv/Quy6HZ03hdQXoMdrM01sRzmWz+Q/OAX2EEq6SXBCJC4hGg9F0qbWpEujrpKR0Gh4f66g97FwTbgxeF7qbXzXWGQ9T9UbdFBt19Wjo6KZTKLhZSXjJKzr3fmJ/epIgf9rYtjR6TefUbUDQlyXEPr04Uy8YeavlJx5Php8j8BkETCb6n4jRs4tcS9IbQtdIyLVxRWfciWqZkMs60arNkJdJw69COGZJNunJmbPuRPFEDfUqj0GtPLQqglWlgZNXtMrl6iadz36MULCHvWzdrWdeL1J+Nex5Eg8hWW5WQ7Rg+o0J18TBFXJkBu4b6MaUH/B+ELefbk3J1897FUXZEZNDWJeWIVOHoBLwSfhSZKvx4fud9P7UvzsFV7EjfwnESYnhn1Su9RBEIRY1ETn2Lq6lCVlZIsliO2wf9ZVtRjBeAz5De6moa3/8c3vvfbzJgIT+XCCo4vrJN+s0oeNY3cD2DSLvXtdsBE7WJLxMahwh5d1Lrpn6pwKy2LY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199024)(1800799009)(186009)(6486002)(966005)(5660300002)(6506007)(86362001)(6512007)(54906003)(316002)(66946007)(41300700001)(38100700002)(66556008)(66476007)(110136005)(6666004)(478600001)(2616005)(8936002)(8676002)(26005)(2906002)(36756003)(107886003)(1076003)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wAGTqfiyxtR8wE/Fco6atWEXg9WGNoirAfp380ml3AZnxKh1Pmr5Rp7002Aq?=
 =?us-ascii?Q?UAmuZbbPeqFT2vORcd+3dc7e5UbPwhnJgtFTvRGH9t8sivaNdhTxY+HXqLCJ?=
 =?us-ascii?Q?VkTvLr9HoUou+OIYe47/cddFfaC4FCnTBXVDFquc9n3Raxw3Ef2v//CuRYwV?=
 =?us-ascii?Q?AJdG4TzBBdc0/VVCugBdprvec16vQ5KhM6rOkIbcagFC2t0k0JUKG1oR7sPG?=
 =?us-ascii?Q?Dl7yHbcnyMWjz6+N4LD/UNDlI/3qDC0xwgtoHYVIDIn/GvdnKXHR8/lXjQAv?=
 =?us-ascii?Q?B9cZz6+QOWFLmX1Ytq20CY0DOO5FF0oDk2NMmpmFXLCTe+nrYpFuezDSa2Ea?=
 =?us-ascii?Q?BTieUyo5t3w3TzelXGkXT5WAGfKpHDDVAlzq+Pzi/DQIUwKI1yFA5/mqaZnV?=
 =?us-ascii?Q?wD1nDHqTYNb4x8VDv8qesfg+l4+TvTT5tEWpgIijFdHjrv2AwcCSpLZFNpAp?=
 =?us-ascii?Q?2GIYpTjaDZrfcr5YbKcsSN99PjKBAL9rIBp0KCdvMUy0Z9UYb4VYwMw3GH34?=
 =?us-ascii?Q?yTwMdgXT4dyd89C2FCnjZxEuSXzV8NCJo+xppF7dOgavKE7WRvNLLdecqzBp?=
 =?us-ascii?Q?CPlqNAEcdBqsGl8oh33wIFBCd4aFQLiTn/T9x/dohxZf8ges8GZotgXqkib8?=
 =?us-ascii?Q?fWGhc2vKf5cho7jGkJjsBC90QJol8zEp9ttyMhrxAF4H4/uMcWxdhFn60Ltl?=
 =?us-ascii?Q?VFi8Pu3Nzoq7MdZuZymbT++TQg0lI+460niNbPtwQWEhtMJ68TiGcsr82TsP?=
 =?us-ascii?Q?176woJjzM47ykxmeZEffeV++YaS1YBlqnvNsL1vLWWN1Y5H/iHu0cn3bSh84?=
 =?us-ascii?Q?cVu6+GbfcgGw++YuLvfK4QHBrIW1tn6iu6GPs1D9byxRDa3lsUR3FsQuz5uo?=
 =?us-ascii?Q?+1qEi2v7WRF1mGyCbTpt9YXFl61SwmjIvyUbcnTzc/AvgXOqBCPPCGPQ4P5E?=
 =?us-ascii?Q?B/hO48AB52Gk8zFJooOgsckWoQjtStKxaFT6T6HHJK4e9out2PCjGwMAYDEO?=
 =?us-ascii?Q?yo2Ab6V3A1p0ekgFzTtC/y/ySjrW5/32Nftf6dM0NMKTkJdgqab0QR56w/Ga?=
 =?us-ascii?Q?qDqIZHLPuZ5M7wV2dBcE9nqeQSqQEwOaaxcwqOrVrSPz+U8+c2vvyX+r118B?=
 =?us-ascii?Q?Xc2LP1V+DO+7YiiXALxmhCPfvx8xy6rb+/kjij3qaO1ndc/+r6wQrJ1pC6j3?=
 =?us-ascii?Q?oZPNWO9u/6hSJpw2fv6/jtq6IdM7rQ3JkEcx7F2jQGSDT2v3X+sVVXpxZT+6?=
 =?us-ascii?Q?lxgPJ5iG1WGwXoUT+QHqY1cio3koO5/5Ldv4Cbqb5CIOSPP87hQpeZyDV6q2?=
 =?us-ascii?Q?INTAG+HwmaqZ2aE0wnZCi2mCMciLSUYV4hyTUMn6o7oMT6+6+G37WOBbZAPi?=
 =?us-ascii?Q?ENDeKbRVpYy5lAlx4g3qtE+w7XGOmJEkkTthN6YLGjTcSFMntlZkj8nyHcWU?=
 =?us-ascii?Q?kGQHU7aadGOpAlbMHOyxrVzUurIOH6EWrVZsL27h+wI1/wHHNK01n2gKjxj5?=
 =?us-ascii?Q?Q0mtNX3Cy/DokncCBkBk1Z47A0ZAdG2Ely2o4W8jI6HukM4WE+R7i1ozdJRe?=
 =?us-ascii?Q?yZYPPqcjxCrMRLcqFqCwbl6KTfVHDg/YaY9dJssB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e68870b-da94-4813-4aa2-08dbb7fdbead
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 04:14:25.7596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vau0mWrvIc70UvdDV7wY1F7tNGuH9bQXOJlieO2POZOhjaNDwjJntrKr5MwMaU4qa+xnNwegLIY9UXYCj/fBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes some missing clean-up function calls in the error handling of
the probe.

Patch 1 and 2 fix some similar issues introduced in 2 different commits (hence 2
patches)

Patch 3 is an enhancement that creates a common function for cleaning up
thunderstrike instances.

Changes:

  v1->v2:
    - Add the LED_RETAIN_AT_SHUTDOWN flag to prevent
      led_classdev_unregister from trying to set the LED to off before a
      successful call to hid_hw_start.
    - Rename err_haptics label to err_ts_create to make the label name more
      accurate.
    - Re-order operations in thunderstrike_destroy to be in LIFO order with
      regards to the operations in thunderstrike_create.

Link: https://lore.kernel.org/linux-input/cover.1693070958.git.christophe.jaillet@wanadoo.fr/

Notes from Rahul:
  - Thank you so much Christophe for these patches.

Christophe JAILLET (3):
  HID: nvidia-shield: Fix a missing led_classdev_unregister() in the
    probe error handling path
  HID: nvidia-shield: Fix some missing function calls() in the probe
    error handling path
  HID: nvidia-shield: Introduce thunderstrike_destroy()

 drivers/hid/hid-nvidia-shield.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

-- 
2.40.1

