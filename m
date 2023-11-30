Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D647A7FFF5A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377239AbjK3XVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377245AbjK3XVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:21:45 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2071.outbound.protection.outlook.com [40.92.42.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9291716;
        Thu, 30 Nov 2023 15:21:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+7n4Qp31q3YMTTvUU9hEwyxUWXT9ifH/Ak+NGfCDTnDQID7FoQSxB0Y+gkfqTWFH3HjgViGfbtEGA6LtNAO3C1C+qlEs+FceHU7zcCE5q+cZ4DWMf+G+BZNUpDuE3JAec3i9dkEEm731xRwL8sN/WHI+QUXfOWs3njJzr5+uLZHXi/60Ojb0Ee+aohP2FWNJTwRtdLTFvjRWB1uhtDur51fH6H070mvLFRp0gEbqjrWrUrd0HmAGvej2cEeAA7f7FZ4iGHv3tvONQdMW4RKLwVgianwL5teUYY60HLG+q4qsu0oYfRSuQO5oYI8VdjrxUEe5pZRo/MGAvEOPafgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRzmDpJOHIT8kdYM/+sWnTGi9qOmc3ZWtV1UNM/9Ohc=;
 b=TU4N7IFlZIXsnbPSpvPCrpDUNPzTcQBCKLyFyS43bWuQeLS+VGd4zrit8dJDHmvkOiZtaoXk9gg2Nh/FXifM3TDimgBdQOtsN2ca9FZR7KZQ36U/E7UTyJdnRYN9kCOoODHoMc78u136zgmtfq1o5aJ5jWxPWDZddjjyKCEg6rSFcIFXuOyGHHrgmiL/JeQ3y5fvgoS3jH6Q9A0TEVTRggk41Dvr31XFmfH4SljbxAcqA2E78D5Zqzrz/txxAap4XDTgxbw8TfSuKedr+fUFrWdI+lZNox5EwdMc7H0amiaTABfvv0xeEgjfGfAcMIg4qw+BG9qLIHESC/U2oIvgQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRzmDpJOHIT8kdYM/+sWnTGi9qOmc3ZWtV1UNM/9Ohc=;
 b=Urgjd/ZTI7697QksD7dACaYF/9aceHJfa8yhkHRwtqQUmnDD628hDMgXA19KDuoYgbepKwZBLnx1Qwk0ANzeWdkMbaGIKplXy5xuwEjulo3B0I9hmEqjOOU7eX5EqzdpMxgqAUCeDhgFfnmXu3NHMiCCRXB9FukEkTF0owmHgP/VhuVthTznDzRF+VzxoY4/Jubndn1KBWntdOS6andYT87AHua0vr6iocuNihQZt4bhhG1ocOdXonsqI4dy6hg0+lSrhMfUH7KGs1PzL5mbM4k996Jy7Oq3ce4PtHrQXKAP32Ry7lQWPPsCOdeASBekME91/uQ3P+nnHnZyD5LjkQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ2PR20MB6657.namprd20.prod.outlook.com (2603:10b6:a03:536::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 23:21:34 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 23:21:33 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/7] Add Huashan Pi board support
Date:   Fri,  1 Dec 2023 07:21:29 +0800
Message-ID: <IA1PR20MB4953275B5B7BB241916A937BBB82A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130-radiator-cut-167bcaaa2cd6@spud>
References: <20231130-radiator-cut-167bcaaa2cd6@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [MJhOTG+ZMCtiFRnmAdt+48gyPAUjOd5Msyi38GmXUZo=]
X-ClientProxiedBy: BY5PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::41) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231130232129.10413-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ2PR20MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 082ee638-9a53-44a7-a705-08dbf1fb1771
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQ5rXsA3Pt7TbC+ezYZAwznZQzvOr0aijsafjbpIv3F/cXVdqifwLPpSU6AMBnu/iBN9hYQJQwPNyNH+u9NeDUVI/CUiSZqFVAtS04ApXyGjVC0XR8Rq24w3Ap2ziXok0ywzGQAZIwja50HIEhC+wJthjVyGTsLFM5CDY/iiThCRAnsowxMoinBUcIdwyPSyqbiGtBcaTAWyxbRXFUM5ORrqBD/bwhdPt/hIutEU56nYdpdcSNIKlf7yOdLrUuCBS15mNIvr++b0jkWoeBaEBBStRlifa32FeejVFL4mKye5StEmI4ez78xPdc1q4hGGsSRP8GOKP2vz/D78NF/cDmCsVOkHpuM9+NN5hohJ2l3oKuSi9Vls/piM2kUZcrlQ1okDCVC20MwfvTpn0slUVWdbtctdoJGV2g3tqnfSSYx3f3NxEz94bi9itlI1KJ+zcpLGsPvzF4dQxPYv5kZNtYVcy3UPiW6xDZDrO3W5+9Mzgwnh1RU0vCrP3cc0B8XmKG/cQgp6+eoiwiNmCXWiFgrE0/zzIuYkhkkJvOGybSM8uIeaKxMCv1O6g5gBvrF0dbIdEQ8v3eV2hN0DtHiVdWugnuy9wBiUo9/+m5Pn6GqLV1FJ7ZziWGY9+9cH+Cv7
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sb9jMGcRmG+QcjFy3fWanA4PUqHG8ehRH7i/qqyNVY+JCM4g8ecIaetlt3mg?=
 =?us-ascii?Q?vP7/tS6H4lzHg+pzWTpp8UgJMTlH8xs0hFpcH3TpZl95CdlCKyFt/vGAep8Q?=
 =?us-ascii?Q?Gq4FDZG+y2/+GriLcMW2e+ubhXC71MLsVMlgmfN9lEurBuqABlaOszm7Ha1r?=
 =?us-ascii?Q?yRHUQNnzlvr/atV+aw1ml8JU5KJFod3yWouBbLuBJdAiqLCVzsDwKh+Tn/em?=
 =?us-ascii?Q?03re3+Z3c9nrZapxRdrME/rUr3wJb30dfSEGp4SxOn3H5TH0gYp2gCvtuICk?=
 =?us-ascii?Q?b2f4X9zpAmZRM4TPS09ES1LEKtTkpOvuBmy7UI8pk1i4Vw74mgUQGlAlMXoF?=
 =?us-ascii?Q?QO12l6hVWOI82S4/Rhrl4MWQvV4fr1+TW4kgtkfV81dwz85aCVz1YhDQz6K8?=
 =?us-ascii?Q?vyS+6ABKmNebYeGCg/mUv0r0MW5OBFXZCbEQz1lcORGfEpJNr9IPkCJpMk1O?=
 =?us-ascii?Q?nJ08888Wnj2KuSMsas5k+v75Pu6lOMzolJNW/A3Z9esk3tsxTlW+fx6s4oar?=
 =?us-ascii?Q?B0Gzfmx4PI3QR2nXOw97AwvwiiYJOYkAvu5YLiP1RcZ+z6FQhPY3Qvp6P8E4?=
 =?us-ascii?Q?DGYTvbzS2HdsbkBWZWc4jVwU0hsET++LOErusHtliNA7s4mLcFraHNbkiRWN?=
 =?us-ascii?Q?wKAqQUa709/qiLZS48L+Fcl1e4kq82j8Q9a8Alx+cHRW9X4gqvkVihcF/Q6S?=
 =?us-ascii?Q?jLcJ0GHQ19ZbFPnXlSHa7GkJ7KXxwxUGiaaxg3ibpM19cqt9IYJXbe+DzFIf?=
 =?us-ascii?Q?ZOWL1dbsdXMAkrmIuWwvFk9Sw7uBI4WJ9ovSMrdbqWT65QpvYlEMsI+HfWb8?=
 =?us-ascii?Q?8shQa2FWd7Ib7l3oJta7TqYwbHTiclXT06DLsuLSDTv0OHGHffHjVbW6Hj06?=
 =?us-ascii?Q?VlvgaXGei80xoRsXoHhgE/5uNyeNzffWf4l8OKC2KVudGhmV7qSuxs4uKist?=
 =?us-ascii?Q?uhgx8HSS4EAa4xon3LVozyFn/0syjLg4gO3VgU2mqFv3BMvUQYkX/hTXd0IY?=
 =?us-ascii?Q?IVN3qITK72H6FLeI4ORvkF2rz55aBubKiXs2r+BIuTYMoRa/Jb3DoLWgpqCO?=
 =?us-ascii?Q?PiqitdsiTQ8h8Z6VA0VuI1NKb1zu2slqNVFn+NLiCUcVQrrGAodhHl9J1Lj1?=
 =?us-ascii?Q?5biSmL5ndnR+5Is00uXLY3iwm5y5lTwIZp/a0DU2DyiKGEIJI3R2mBBtxOHW?=
 =?us-ascii?Q?ZEd7XwO4hYLnupMXuFzeTXmiXcBN/vUxc3QMmSujCSnOqdLdV/6gp5belQ8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082ee638-9a53-44a7-a705-08dbf1fb1771
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 23:21:33.8231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR20MB6657
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Thu, 19 Oct 2023 07:18:00 +0800, Inochi Amaoto wrote:
>> Huashan Pi board is an embedded development platform based on the
>> CV1812H chip. Add minimal device tree files for this board.
>> Currently, it can boot to a basic shell.
>>
>> NOTE: this series is based on the Jisheng's Milk-V Duo patch.
>>
>> Link: https://en.sophgo.com/product/introduce/huashan.html
>> Link: https://en.sophgo.com/product/introduce/cv181xH.html
>> Link: https://lore.kernel.org/linux-riscv/20231006121449.721-1-jszhang@kernel.org/
>>
>> [...]
>
>Applied to riscv-dt-for-next, thanks! LMK if something looks not as
>expected.
>
>[1/7] dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
>      https://git.kernel.org/conor/c/21a34e63afcc
>[2/7] dt-bindings: timer: Add SOPHGO CV1812H clint
>      https://git.kernel.org/conor/c/06ea2a1968a9
>[3/7] dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
>      https://git.kernel.org/conor/c/d7b92027834e
>[4/7] riscv: dts: sophgo: Separate compatible specific for CV1800B soc
>      https://git.kernel.org/conor/c/5b5dce3951b2
>[5/7] riscv: dts: sophgo: cv18xx: Add gpio devices
>      https://git.kernel.org/conor/c/dd791b45c866
>[6/7] riscv: dts: sophgo: add initial CV1812H SoC device tree
>      https://git.kernel.org/conor/c/681ec684a741
>[7/7] riscv: dts: sophgo: add Huashan Pi board device tree
>      https://git.kernel.org/conor/c/2c36b0cfb408
>
>Thanks,
>Conor.
>

Hi Conor,

Thanks for the confirmation. But I suggest to revert these patches.
Several days ago, Sophgo informed me that CV1810 series will be
renamed. And the Huashan Pi will switch to the chip with new name.
To avoid unnecessary conflict, please drop these patch and I will
prepare a new patch once the renamed chip is launched.

Sorry for this inconvenience.
