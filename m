Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603D67A48FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241792AbjIRL6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241809AbjIRL6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:58:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAA519A9;
        Mon, 18 Sep 2023 04:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dvpi7oG++m27m3gnRVYpLhSQQhAu9JoI/YzJzm82kt5Rrr/S+1WLWJdXCcwFtmXXldhDcA8mc0n6NjokFNftskRidRAvfJjCjDmVVKLnEuIAnbIVkFuKzTDuPOr2iTGXdcadfVEpR8AW+TVlNAnuiPgnoG0X5tg7RKD0Epg/73w0DPq3eV0shXGNrs0yV69rDw2D2zXxLYokENmQWZgTAz1wuCa/gnslzhuG8fNscys1D//MUic4JdinUvY1RBErCEnxx2R2xjqNg5CZHOgdULGv3lbGZY4CgoWnD9SMd2AXpUlriO3Gauw0YcvrqIJCKtriJxTEcQvk8dyZ3eQ+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeRzHHEC9N8TLcL30izVuKIHODCdH6kdTThQsE5G9N4=;
 b=CmnSQHxf4Ngf/8Ben30a00JlJkMhneIoUmjJGnQtJo8AQS30cPYlj/UcMv1MnDGgNqVdgYLVqt+fwemK1/dbduB7FAdd82wNQDhv8xwHMob7stM3flp4mwPCpltqxeD32HcFfnoJD683g6fhHCpiggGyNo4fOApk9BkezRLLDl4GGTpuV7auhlxH7uaCW3xHnPBjoG/EUH7SiDCFI4DiZE5p51HiSmB5axgxgyq/KqXIeXQCr3/ixM8cu0OLbtpiIyo+q6txqNqqfYITcVm6I5Uw1nL8HeL1VwwMX4+OZmWNB0rlVJx2Ny6lDV+fEPOuo2T64/HcWAe7T1GtDGQMDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeRzHHEC9N8TLcL30izVuKIHODCdH6kdTThQsE5G9N4=;
 b=SryFs1gYVJsiCRWkG55MTyMijU/2yHFMCM8qADqgouMRzlZfAF1Pts/CPsIwLbJ7KMFD0nafXrwT2EmOfSmKX1bzCxDQjlcrAnlVm8/1NVVlHbPuQbODyXktyRGZJCDRQzXaetG7QX8I1iNF8PlO3c9AcLtEnoGdLMnJdwwHOr8H/hhS5kAZvdfZE12QakdzUGPX3RoaSn3bamCVtU5Gsg4WHA7PZ8FeRp9Jq6Jhl6wTT8Phy8UzrCZkgNfRRM2Vvfge5ICjlZMj4wegur4K/4dwIxl1SpR7jPhH8G0ALlxLnK83iS4QZiui4hKQfsQHpkvT2NsMyywPqc8JbMu/hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 11:54:45 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 11:54:45 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH v3 0/3] HID: nvidia-shield: Fix the error handling path of shield_probe()
Date:   Mon, 18 Sep 2023 04:54:29 -0700
Message-Id: <20230918115432.30076-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:254::15) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e85b63-5415-4fbc-6677-08dbb83e0d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXEMsmnY6Ynh2kz1fwT2Ty3+WpJKR+EO26vSbyz+TuSJ5/Z3ORP+12Fm81Qp9w0rb7ZVaTtyENbQJ7dpExQ0wrJRq2+JKf9klQMCSEyh02i9NWwl109q9bSaDnpKayhAozA5eyKytq9VgS1TwkVkrTJwS9V/pm8sB18Wj7Lf0QuPyjCg0i2jOUC7Jva5SqIw1gEIgqv7ebmu2lL9wCcgZIyVku8SnYaW+QnI21yrS8YgCBEPOW5m4HEkOPS1eOpscqkduPnUMCZDtloZIkoqW/fNaO1CsvvTyT4FuCT3Fh4b4S0usU0wmYUSi5gix2nbZiidj6jO/ksIFDC7xYKIPEvB5RIGCY43PFtJyDgx8V5FA4XZLiNzHVzj4abcF1TGuFiF/wr9MiZ3KWzTGqA5e/FoWDrdDehNOf9h13Zvjdhvo/kvyePMTEwpV62Sads02LPKZddQURRmhV5wZzyj8QfL90JJNeNhhpTph2zg+HY49QalDMBpodMQAH3JKGPfJpzg3P904d83483bZkmSNKB3ei8t7EdMR9lYPdIYyUdrgg1KPHvv/g0UGUqHtPHFZwbjBiwZYt8dNi0P0bqwrhtt5zIzhE/BGE0cQnj5tAA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(1800799009)(186009)(451199024)(26005)(2616005)(8936002)(8676002)(1076003)(4326008)(107886003)(83380400001)(2906002)(36756003)(5660300002)(86362001)(6506007)(6486002)(966005)(478600001)(6666004)(316002)(54906003)(6512007)(110136005)(66946007)(66476007)(41300700001)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Apsu6kkoSyCUX5jrM8MJt8ugg4KcKBBI66cVz3g4x/Gs88xaqRh74OPNPLxF?=
 =?us-ascii?Q?iJ4ITkXauW4ZCYF3rgiqcDTUTXUYHKR9iRzUDlNCKUpwgNHo0fBkPsvz9LxY?=
 =?us-ascii?Q?Uk1XP0GuTmcwuyxRJBV5mQ0QvCIg+GDS1Yg7szaEUrL6HH+nQ4N93dKsL2Rw?=
 =?us-ascii?Q?6xn1pUPvs0ryzVS9FfKjKSFYjxGExH5FVr2FE1IccopGTkhUPIaG8K+qxVjY?=
 =?us-ascii?Q?uctHVhbsLNEzYgay3ZXE1H/9GMFFYuT3GbJN8XeYwroUmqdd5d0v+qBhx3x/?=
 =?us-ascii?Q?V2xlDOoI7Xbwp9qo+MQ7hgukrFatMaRSkxtU/mmsXBIPAu/zk5cs7Lte3W/T?=
 =?us-ascii?Q?fb2Mk2yDv7J/bS2S0qWQqu7YkiQmmqSLr0kH34hQxtA5S7s/GZ6tDY+lqVR0?=
 =?us-ascii?Q?oIN80miwutfGXgZOCUfyEkwhf6v7CkP5Cpp4DNMY+HAYdW91ey7LEWyA3ZI2?=
 =?us-ascii?Q?DkXE3KKZnh2+gbY8jj1c8hXmqMwbA49LCCdQZUzz7IfGbwWbMG62/1fcb3zo?=
 =?us-ascii?Q?wgHUtv8igRdQ3ktskjafF8HOxLvIWqLngMuNxoVWEFdSLBKCyz7AKJJnklkL?=
 =?us-ascii?Q?oHeJiMRgcKzkKA/OwLcl0kvP9jJvKcFgPCLqfDs47n/A16sG2VnS6+H4bJn3?=
 =?us-ascii?Q?oaKYLX6NEwQmWnVAXn50zRifMBbT2UPEYKDGJB78RlcIBRxWE5gIIp5b1vvz?=
 =?us-ascii?Q?xAr9t2b7BEs6iz3oyVhyBjHVzJgBuLf8O45Mqxwt9BH6nwtiqidMxrr5VXk4?=
 =?us-ascii?Q?/ajoxAm/lRtlvDeHKwp5xCQxxsmg7uBO9+AxTaEcwE9tqW1rtidgkq+BASTW?=
 =?us-ascii?Q?OUISZ+WUUMVGO1+1zI7GqgpUlhCELr7lUwwM45gBOt4NS23dCnVV7bfhJmxX?=
 =?us-ascii?Q?oCxjOw5GkcyWDAJ4Pf8ZqSJvjXoSTJs+UioyzQguBd5yGUqgqgpl0AYDXHSz?=
 =?us-ascii?Q?0uau5xUffkBIqnn5xaXHYS54lxAYs4MASR3p9tLpgW54xrHVSCqhp8XH3llK?=
 =?us-ascii?Q?s/yOYTLw8zQB7Sxoa35LFw3OQZfS7t7XHWg73FK04w9NptBlFpJtb/uCxOda?=
 =?us-ascii?Q?pQbDwQ80Fz3y4C8hpyvnL1v41rmX7NJx2gtwhSw3M/ZY/iAGKgQLOaIy35zl?=
 =?us-ascii?Q?DO1wMevHFams0uiYCduf2lLTYYPVOKHpCrz3N5vN0CKEzwA3Ucc7RyBY4a/w?=
 =?us-ascii?Q?hzn2NIMaTqO0PzN7lVQsyIepwPqITfLYn+x14fT6Qp9zZCpyw+53dS2ovSH/?=
 =?us-ascii?Q?19+TNjGBcrMWob4WP5LeRxBG1z1qYIKlyauyVckeOFbpAHW/P0HLRMQQcVFq?=
 =?us-ascii?Q?rElfABRch2io8dqnE3h5KE0cwkZx8kPoGGiU5j5/JRbRQ+3b4RBr4D5BzNId?=
 =?us-ascii?Q?nF3XC8wKar4Jt0WPqX0YHBkAkbEtPUraEKJKMAEw/ypGjHcaTKNw0WDMTTlG?=
 =?us-ascii?Q?C+TExaktU+DW7AuUyVSU/lW5dtX61ogx6XF4zR0bLi/tJzh3DSwVvVxpxrIF?=
 =?us-ascii?Q?5atmDhMWiIc4F+vYe8WUnEEO0Z2Vu2z4SnP13ZBFx3bke6HI70jwCE6Hf+KQ?=
 =?us-ascii?Q?LaiEPhlH/fGcEpptlDlPLjTrgEx9DeBLAUjhJ4YB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e85b63-5415-4fbc-6677-08dbb83e0d47
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 11:54:45.4499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7sKrrQRgpYReFEEP5xNNIgoYRtbvxcl66IUsE1b4rrqmxZCAJi7ZDoyDh9YntkIVsAl71RMbdLx+7pJnRefTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872
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
  v2->v3:
    - Refactor thunderstrike_destroy to take a thunderstrike instance
      pointer as a parameter and prevent a variable from being unused
      in shield_probe.

Link: https://lore.kernel.org/linux-input/cover.1693070958.git.christophe.jaillet@wanadoo.fr/
Link: https://lore.kernel.org/linux-input/20230918041345.59859-1-rrameshbabu@nvidia.com/

Notes from Rahul:
  - Thank you so much Christophe for these patches.
  - Sent v2 without accounting for the fact that thunderstrike_destroy in v1
    makes the thunderstrike instance in shield_probe unused. Tested v3 with W=1.

Christophe JAILLET (3):
  HID: nvidia-shield: Fix a missing led_classdev_unregister() in the
    probe error handling path
  HID: nvidia-shield: Fix some missing function calls() in the probe
    error handling path
  HID: nvidia-shield: Introduce thunderstrike_destroy()

 drivers/hid/hid-nvidia-shield.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

-- 
2.40.1

