Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397AA810F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378533AbjLMLDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378551AbjLMLC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:02:59 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B841510F;
        Wed, 13 Dec 2023 03:03:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKSMFy6i51sSbIeNLvFGDZ79ZYGzlO4rhgvFiyL4cpDJRrCASVxde/HxGEsiniuM0J6WvzQWlyPYhKban+oaEilrGKU0FTdANucWvuQP29PizZCBgrIknVqErxrh3JzxU4ZrCvfJaknsWzdFc0jasU1Xhrb/eoGRvFFR0L7//W6yUTmLECF4gL80DvtJvEy8fWaeLgFtfzevkasAph9Zum68vZIY8NtOkc8dpx3G0WO6VwjKc4ljYisUA8T7qxeKOCnf1RucZDR13UFG70rxKX4T6wXGpRRiBNUUL1y5EBXvm8FiD7DLXIHZe3f5AwJK4y54GZgbhJVfiHT/6ob9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTpA+FOZRJqP/LcrGpbOjKtVKDmMrv1Kkx6vHEedyYM=;
 b=Y1zfuVNBT0i7bO1ZSeLmyIsTfc3IxCgEY5IqvUFbY+maAgjSmaTI9e39ikXM212ULL2lTODrxnFgyLJ2tyd5PrRszYCldzcogv0Lm9KAHgdzzEPsfl8s4CsPmEoaVNFn6Gpg3sSyRbtlC004O5JF4TrcXjYtE7Mbz4zEPHNZDpsKl0R/Uw3K7wwRM/EzbxU8A4L/RFOw8J5zJUR0RIXhtVz/q/hdamxEat1Av8KXWW8sNnnBWVm3l3VHoKynRZcaOfgbrkyoLi8BsQwNdufE26CX2OVn4JGL+4xtop4viipuHVvMlKw7wmLB7Oy7IUyUNVtt5qt6EQEq8lQMJweFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTpA+FOZRJqP/LcrGpbOjKtVKDmMrv1Kkx6vHEedyYM=;
 b=lmGmXuauPSZBvkhD0wSqFfWWoEmRLovIzSnYwW0EKYo4vWt+D94TmQoOhTLuFfF2RJgn9ValE+bNe2S/ZuibqLM3BsM87FYbR1/y3wBpedmh5d47o195G7UzJ11Hh7xNkfstEs0X4/4zHPJXd/r1PSb+UdcDEgwSNz2FTMZ1v1e0Q1uCrIygI6SWYss41fIW/HeoYTwhqi0ECUGsuQNheRJnA/SYA9lRdI9nhx6IjjU8EhApkelYvNOwAW8oKTOr4FHOyXtkEOKIDMgm8iwZcOKSASHRBDUnCdaN6qGApgKy2gaKQDCog9FqgI7wbkbGU+AtuV5F6+XdAQYnaep/RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22)
 by CYYPR12MB9014.namprd12.prod.outlook.com (2603:10b6:930:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 11:03:00 +0000
Received: from IA1PR12MB6163.namprd12.prod.outlook.com
 ([fe80::148e:6823:e6c0:ffbc]) by IA1PR12MB6163.namprd12.prod.outlook.com
 ([fe80::148e:6823:e6c0:ffbc%2]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 11:02:59 +0000
Date:   Wed, 13 Dec 2023 13:02:55 +0200
From:   Ido Schimmel <idosch@nvidia.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 5/6] net: hns3: Add support for some CMIS
 transceiver modules
Message-ID: <ZXmPXzSxq0k4eO0m@shredder>
References: <20231211020816.69434-1-shaojijie@huawei.com>
 <20231211020816.69434-6-shaojijie@huawei.com>
 <20231211192122.14da98f0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211192122.14da98f0@kernel.org>
X-ClientProxiedBy: LO4P123CA0287.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::22) To IA1PR12MB6163.namprd12.prod.outlook.com
 (2603:10b6:208:3e9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6163:EE_|CYYPR12MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cff0631-f9fb-4c1a-a940-08dbfbcb11ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S4sfQnCs1VdBMyDgXyb5JMRmOp6bJl0rLC1+0M0dz6FO8+OT6LToSFDBXKWwV9i/Mpf8ZruC7AjK70as3Cn11wWWwR8NvcGzc969KR/dMbX2q9irKKK4rPxD27KBuYGu7Vb67GGMCILvyUOgSvFVj+PiB85d4qcCkX80Gk51/7lExwv0R+MmN/EBP+/u9LYvvq7abAxvP42HEveKbzm21GC2tDUoCdh4EeqkqFE48mTPaLnXcUUTB8wK3mIOuVvuyRnuzYnUxjf6uf4jE3EPqMLSrMQZYTBOQadLwVcQW2xoJzcrdY/K/Vx8RSQZwuA24YHVfBgI0lKyV4lABZUFfAobctz6w75gdzxzIMV6BbkUa+FmYtp/DOBhJyB3ORraF5jak/KhFp+yadx7R5kjvxZhdxLy9FORGV5YMIaJ2ETEXZfE3kW48bXCia7SN2B3YZh9mryS65Rzj/QwDpXTQxbGJjTF7ENuqNfJXuIZo4ImdrzHEpkfJVmZbv3wBoKA5guisQr4jT75/O03Q5eYbrhsfkm/lR2sUXgPXaQNCzhGfJGT1Zq0GTZpYUbC0esk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6506007)(9686003)(6512007)(26005)(38100700002)(4326008)(7416002)(8936002)(5660300002)(8676002)(41300700001)(4744005)(2906002)(6486002)(478600001)(6666004)(33716001)(316002)(54906003)(66476007)(6916009)(66946007)(66556008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OwbRup+Ouga2cINz1jtkX7emLEYPBqLJVfehVuChlzL79dh6HJmmo+wFGOwy?=
 =?us-ascii?Q?ru0a+zsYzFuWepDqnR+N80gc3DG3VwRou98c5IaB0tpMGigd4T8ZPVPyC+NO?=
 =?us-ascii?Q?P51nTbQBdm7A7F22r4mcF3g5ZD26uCZpyyGVxEi2b64NA70fgebGv33MBfFY?=
 =?us-ascii?Q?C1LTJSgqmmr/JOakvQSH0jSqSpUtBzfe2FtGe93hH/rCins1qGMWU81tnd6X?=
 =?us-ascii?Q?OXheLxSiVkD3pSDAosNCuXE+GpaTxuZUlSajPOX7TQI9WyAUwBgGc59yPB7D?=
 =?us-ascii?Q?/RjbnlfIPuYQ9aRbANz9eaf9jSfqYkUmLTHuVxFMNN35SQCGb1HZuASUn51g?=
 =?us-ascii?Q?qK4fDDJp9k2XLuLhtG4HWteLiptY8qN/uZyGQlxLHizp/oHKmTP/Ux1DWdEd?=
 =?us-ascii?Q?R0L6Kf8JjXqj6Pxuf5jGrdRPdcUlR7PC6ScyJe61dzrBTFUsSVzbnNZsShFC?=
 =?us-ascii?Q?ES9mKn9dk09tPbhQXfW3lWfx0BXiQROqmVJKQMf6Rrz3GYNf4v9AlEnGP6Gi?=
 =?us-ascii?Q?mp/r2UrhnoPQixezFwvnZySVrMlZ6dELPUWKBR6DbWsCE/TcKdeuvj1CPezZ?=
 =?us-ascii?Q?tBPak8G2zN14LXCt5DP98xFZ97t6FfaMafEmqq4cGWk/VHJXPRgs72FCdqLY?=
 =?us-ascii?Q?UmqiCswrI9V7VHFANNqBwuc//j55FYFcED8GkDFuYX3aGYbzg/mLz4kHQJic?=
 =?us-ascii?Q?jbHH1SPdkf0KB1UEflNG/sqWFoscLDrVKbBXKx3AHsGX691VUT1lVI1Grbie?=
 =?us-ascii?Q?tuGKPdjhGYZqI2quGhA7Y/C9lcyZxqDM21L0H3B2I3n7Mm54WhrCKBR41xkl?=
 =?us-ascii?Q?8ZbdBlXGJc7Dvp+rhKfcBXWl4GW6NZRArl0VtwO0+FXGlM8yYgZDDAfZqWvr?=
 =?us-ascii?Q?Y0WCnpuYTgd/AZUhTsKTjLlJc9ytvCLLYvHDBMjZthEtuITOB5mPFbatIbtv?=
 =?us-ascii?Q?hDCLuIvaztueRip9WehDHNSTcVUv4P/7HMkqAbHwptuUBNJptglIYesuRxVj?=
 =?us-ascii?Q?xG9MBlbLluyaLrA0t40Qh1BdIHavBtvTJ5lBmRzC1XaMwSDzM1etVIO3pMAc?=
 =?us-ascii?Q?Adayq3zUbmIhGAmHHHX116eQYdlCexOKd0o+i08pQavZoU16TYACVa/y0utZ?=
 =?us-ascii?Q?vnVmfo19uHUc/FsPp534yd1BvLaz5EN8Vmcce15JDNcjQAHtlhJG+Vx60Dgm?=
 =?us-ascii?Q?avjlYDyrTQFRzLQbM72asCx6UM34J/s3U+YxJ329c3V7YDNFDC7Zlxtjldkh?=
 =?us-ascii?Q?FFWbrPpmFhLzuO1H87mGH6Q1oAyz6PYSQQoU/oimTlqfqMLZJQka1ioOW4oq?=
 =?us-ascii?Q?QCaFwDyjK+SuicOSGfH6vRUbWT6zD4bb6eixNW0nztoBLvBhGAbAb3nVgD/w?=
 =?us-ascii?Q?LQsenMVCBQa29Xjn8/a6Ntg7h7B8fWkEUxVSvDD+LaKCAgxw+5+ABOH1v4SM?=
 =?us-ascii?Q?JURd+KvgJrT1ioy+I3WmubtrknV5BryD/zbejB6Y0E0VhxmV9dgjBVnOxq8j?=
 =?us-ascii?Q?mQBDAoz89f1GabUMai2XfTrNEwU715Ts6VDtijyCwxKdvScrcxYUecl45ag8?=
 =?us-ascii?Q?/jhSVCHPwk9mUoPwPeIxFLJYZHDsp8gJXJjpLRHV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cff0631-f9fb-4c1a-a940-08dbfbcb11ac
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 11:02:59.8024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnIxImPC+e7y63XdHg8/VkMKNTL+DX6jUqQVtoNZZRtMPC0w6XdfkboYMe9D8fmQthg2RVY0rvthcOkvz6nlig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9014
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 07:21:22PM -0800, Jakub Kicinski wrote:
> On Mon, 11 Dec 2023 10:08:15 +0800 Jijie Shao wrote:
> > Add two more SFF-8024 Identifier Values that according to the standard
> > support the Common Management Interface Specification (CMIS) memory map
> > so the hns3 driver will be able to dump, parse and print their EEPROM
> > contents.This two SFF-8024 Identifier Values are SFF8024_ID_QSFP_DD (0x18)
> > and SFF8024_ID_QSFP_PLUS_CMIS (0x1E).
> 
> Hm, you don't implement the ethtool get_module_eeprom_by_page op?
> I thought for QSFP DD page support was basically required.

You can read the first few pages with the legacy interface, but for the
rest you need the get_module_eeprom_by_page op. My recommendation is to
implement the new op and abandon the old ones.
