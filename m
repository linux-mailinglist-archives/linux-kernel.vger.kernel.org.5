Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C4C7FBA70
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbjK1MqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344743AbjK1Mpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:45:51 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBEC1FE8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:45:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d02sPnHQ3fG0VXqktawGvEyh3Kg3qQ9HioAcZBOc1CUpnf13oQ0eaWR0+UQ0P9YM4DEux0NH5sW8En2UsvnwacpeVoDyT3DVSVHthAh6ahOgVu/vaaCbbKxHDQtOy8ewLdgm94A9Vdv32Krnj85PjF0JfcAt28cYpLi8cee822wLTYNYDkDfYbs3VJlV1btITpFOIYB3pVf8+NGNOTyQkQHEeuUv988kqSpZ8z4+1Fojw702sIBNqAv7d4ymzP1DkEF8wG/otl9wXpCRkb8Y0eTmJIpc+WT2tI4joo+TRjldwF3kb/DiSbjlTQxLiTJQnPyl+pqE0WjHjRHJai5/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0Ruu1yfdXwTk8/Gm4Q233u2TpUQa/orNf1IPxeNRSc=;
 b=IO0UjztHU7c8mzonk6yHXqY+mDDh2lNjBeI48tM2lJ7zO7SOshDoYixR22tIujVgkYdK9OEultLmt0/7brzCb2dOJkcTrlnr9h2RI1NF00g8aCczO3wWWNNSeue3pjlNkRyTXfe922tM/T9AdUuNPXip3KDXS9wLZC9y8F/ufqBCvTxtFfnmtWQf2DiYm9akhiGlR+AjiT2uhffHolm+xv4uz5UVI66wbbBvNs9rJaP6LN11FIpyrfQBlfVzMPWmfcH+o/Q2MpSWgIq9YqmCv+kVG3kb+panpQvJfrcuyVwgvxaokyMOPSaPApPbLv+n5ziwC/1GocpE1Oo4be83yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0Ruu1yfdXwTk8/Gm4Q233u2TpUQa/orNf1IPxeNRSc=;
 b=o9dhk1Ctv9VQpCglrJ977ydm5w2SkytkfjIZkOqdaKz2DjiSXn2guwvv1ziurkOJYpbPkvFGGTyr/VEvRlz7/00Q2QBeGB5obhWM1783QWSTdnfiMtpEhAXzDBMTJTvl83U0NcqZ5yhZZ0YJHiSImoYLkEwrkKFfSzMnKDBxZegzryUrT7kvKkIyhCfU906zFYp5jEQconUnthvUg23Lgew10MoDL9gsaKP060dG6VCPfhXk8nQNhP/JEofXk1oaa0h7qeVBbD/zq/uI4Luh0r45GBDTUjsGMyjdBe0XNFdZ8W3hj9qsxNYYFjR6+PEgN7AZhRDZ/klmnmlBy1vDLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 12:45:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 12:45:41 +0000
Date:   Tue, 28 Nov 2023 08:45:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     kernel test robot <lkp@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: arch/powerpc/kvm/../../../virt/kvm/vfio.c:89:7: warning:
 attribute declaration must precede definition
Message-ID: <20231128124538.GO436702@nvidia.com>
References: <202311280814.KwQVhwqI-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311280814.KwQVhwqI-lkp@intel.com>
X-ClientProxiedBy: SA9PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:806:23::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 68218d80-d6f5-43ed-bb18-08dbf00fee29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xdMxSb/Uu6TNW4caWKYi4V8M4fiDuXs44E2a/miPAFFj/3YkgDgrC/N519J4pY2Viw2Iam/YOk7HbgbM4RPG2hisLvJUkqy0RB0251i177ro3bwjki/pqtboTz11OoZmdzAA28CW3R64FHcsz2QiLRLFLxXC/3mU2bWcxeHq/tDsJNdWwe5RD6VgZNeEXqOExLBA7pGJkTka7ihHiPb7il1pm5uIaeJxgfmtn96d5M9fviIAPqvMr0QZ+vqpzXN3dgrZBlHx+VmsyANbklCUI3de/7OYK9fuAVzjhyFED3HvptGPsLGVBg2WnAFoZnxzoxnvqKoyIabL1dXk/9uTg9TpTjcCFMb7PjAg2qLlAjyCZJT8ffLT4GON/giDoodeM5nQU7ZHNq0Y1jqtO38tSxq5lkWwy+wk+iZ4FzztuprVo82KQS/K9mNWKUN5Y3+dYv9eu8F5Mj/bGpwCY0jPkWMjyftJ0LVOlUyN39zUROsGgrFykjJwACloLDJipK+4PDoXgmY7dGeo4vuDk8PEJroE29YnVfYfbSNXa8PER2Zv9b5Sd634vqmzY8JD1r4WWxUoMUHW4kDhwtHfCfnuusUmaWAfUjrC7YKwWn2VyOwMfAfg82qIP78DGvNaKep/9MoZqOOnBqGT2Swi4juj1Hd8cKGj90NGx8nQU6dTf0mFIX4LQ8mRsQUkdUqZKPU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(316002)(110136005)(66946007)(66476007)(36756003)(6512007)(6506007)(6666004)(26005)(1076003)(2616005)(478600001)(38100700002)(558084003)(33656002)(83380400001)(86362001)(6486002)(966005)(66556008)(2906002)(5660300002)(41300700001)(8676002)(8936002)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ROoDPdi8LQ/PUM1upuEBkjq0xDYxxXX7RRTnyH1l1RUufbImrebY4ktW4gjj?=
 =?us-ascii?Q?pfOzqq39FLuWyXlUbTGFQf49Vl9k4uQ8ckWRpR/QMD3aa8YSlkSL2sxFc2/v?=
 =?us-ascii?Q?3rgpiJ/ZFBXoluevSdc/7BgWz5CqCO99RgOwgXjOITGhd8TA8YmlQA89l01t?=
 =?us-ascii?Q?9YoXTYGZY/pxJXehX5anZmgiLk7o3s4Y4Ju+GGlkl5QHo279dE01v9IN2Rpc?=
 =?us-ascii?Q?sMWbUNyY3DUARLC/g6gh+hzjuKeW87NIZ9G8IRmJCOxBmK7EnnHDHCwfBCR6?=
 =?us-ascii?Q?E+NzoRmAL2NV/Yy2nZxC3+yYOrbYfQGsjvCQZ52OtycC6FZ3PxQbXOM1QY2q?=
 =?us-ascii?Q?ZnlxtrHRXlQFIyI/8pBaMrPvLTsNoQaHIl8bbPpASV8Bx3bzeu5omqwxWhTl?=
 =?us-ascii?Q?5uEEz+2fpTcWpxF/9eJaPXtvZXs/WX8kllC1hQTlHHr11ctE8NuZGshBNih/?=
 =?us-ascii?Q?wStKT+/2wxBbR26Ewt/3VR3k8fvDOrOPlPRvacCy2dZAeBFwbefoRhzgWbbJ?=
 =?us-ascii?Q?rc5x98VDktIbV3riKcj7zEb0TMl3v0khyUJLKhxtBay8RtgKLPJMVsKeiLY/?=
 =?us-ascii?Q?Oe3raHPbgqpEHaiq+bVW1839A9q8Z+IlS6i+9dugYphKY1AcJjzTnA+gE9VL?=
 =?us-ascii?Q?tpDmyo3rqVoebo+0NmniOjDdWVgJA+j2KCIaP2efuZGhNZXj20mX7L5IX149?=
 =?us-ascii?Q?7D58b618GGV4P36vt4nzQ4IWF2PEM7wc7HVeWZTaqEQfjQjS5AKT0z+zbbqc?=
 =?us-ascii?Q?u4MKa1uwTGvOCH3tjx/6nymwu2mL8J/PFY3m7giKFBL79ofhm0GHKrgItoiD?=
 =?us-ascii?Q?mFWrBzC6tgdX2L3y5XqYWRgnkoD7+ixF774x1TJexY5vN9pJnEXuzJf0aYhJ?=
 =?us-ascii?Q?kysruBtF9Avi73mlHA8CSsO9+ioBjH8FCMQmPGr63+pZoUwbrGS83gnuJVjN?=
 =?us-ascii?Q?W0kZxvHphZ5S9dZRB4q5W5+f1qMwatB+AewZLCu5u8C2TrjHZD+P/1Sm/tp8?=
 =?us-ascii?Q?GWJ9AkFlVJWhM/IAZar4juxRO+MNP8g1wr7/d35EO74s5LY/QWMVlAL1C/G6?=
 =?us-ascii?Q?e45nFSePQdf6ScEDn7yYSBSTyuaBflGHtnPYjF70PULHOVJR0GVXVTvUz6dg?=
 =?us-ascii?Q?P/qZ8Q6KWAg3SLkx4SGR2YVQdDCr1PzJ6Zrybax9MEbtcj067Ciayn70aHGu?=
 =?us-ascii?Q?Hol5bVLP/iHV0FOKs3GMveiFPZ6bhqHFSqyn2R1mLhkxFH2YXm6nqz9MH5Uw?=
 =?us-ascii?Q?7ZVKPo+o9v7rTFX742iQ/0yCt4i3a3ph9BRId904ssGPfwJFIjSVegKnR/ud?=
 =?us-ascii?Q?B7NIgKjHOscp5IpPYWJB+tgKMQXDFSTk+NFLmAHZKhD98x7vas5Sz7vza7G4?=
 =?us-ascii?Q?SMgBJeiVy2IXfKKvVEhwFGS+SjjVJrW964mUYt8yfTLIlPMLj5iFaSclkQAm?=
 =?us-ascii?Q?cK1mORpjcrNgg/0u+BwcDk9072SkdKU48rtZhEiqdSLe8sJclA7on0I9/44N?=
 =?us-ascii?Q?ey6FpKFNz/fBw61LAorahK3jh0arey89AuumVKzD7po3H5EQPK4kMGn4Mnq0?=
 =?us-ascii?Q?ip3CgfODplUT54rGcAk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68218d80-d6f5-43ed-bb18-08dbf00fee29
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 12:45:41.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+ioJ5bBrHjpzAce9WV6Qu6VCykVguX9Udz5k/jTxZj6w20tTxeLO40+3fYSh2Lb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 11:01:45AM +0800, kernel test robot wrote:
> Hi Yi,
> 
> FYI, the error/warning still remains.

The patch is still here:

https://lore.kernel.org/r/0-v1-08396538817d+13c5-vfio_kvm_kconfig_jgg@nvidia.com

Alex? Maybe you should send it to -rc now?

Thanks
Jason
