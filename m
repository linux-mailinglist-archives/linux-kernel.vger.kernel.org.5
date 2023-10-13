Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4427C8413
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjJMLIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjJMLIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:08:42 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2100.outbound.protection.outlook.com [40.107.114.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D96DD;
        Fri, 13 Oct 2023 04:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfsE3W8oVgKcpOlZwB6Sfj2gXL9YcyPmnkp+/lvb6jZjYmoTsQK9KGDucU9ZOiMYkrTAPmqyQ8M4LGznIbLYPec9AMsCJC1D8ToevunjIePinoWgEiGPaHeCw6pP1F4ojQRNNhBKxjdIH6KZCDWBuiY4zi1v9PR5riRqBxiwRIoQuAct3HhY7tdoxmNtKi0mLNCBEM3CN8SV6bDDsvq92LlvF/e5YYC4COhEqmyaZzAFtT3QBraBj0477aaxBu5aby6gS32BWt8ftAvZtq+CbbF12N53hL0Tewi535MbsVodHP8ueq7KzPzmvjjwLjz62I6YU+LSYyXuclDrpwdjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rueLHzQ6Bontn22z1wfBC9BeodsVBDLFV6QQ0OykItQ=;
 b=bcxTNic4xfZVswUbvL4L1mJ94USfs91gqGb6x1+vXju94YC7wR0kOTIbnsG14BuBec9Sf1jWXwWyxP/ukJnpeAdIvWQnEJpuHKZyiCUkm382V+e3lxefFevP808njxznDoRLFJbZ7ziSxZqbA/wZdujVKinY2J+1GGq9zUCmkIQRWvGwWKIOy60BINKEpwtLrBa7bM6K5Q7Dm+2GRmifrNe04InS8GPvHy4d0UYG3n0C2mqQq+pfjoKLhq3Fhrfyx4HLSNZp3W4cyODvcGph/7MZUu9YmfZs1HwCqvcxy9Ky+Vynyl1LGvu7+wXC8ZTtytkY0JvzMHhePBsfyQaq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rueLHzQ6Bontn22z1wfBC9BeodsVBDLFV6QQ0OykItQ=;
 b=Qaa8Ea8SiAjo/Xz696Lb61oZXkpZ1tbcW851e70Q5UHfCj9DX5q7cfzUiqzQnQoxzsWVQNFKT+LzYPoOzuszySH1YBB+OeT8K9YpX6A+MuI45c9XqcjbO5VDRcQ9JJUHbgOoaIzMuTirL5s4B4k4ZdyOvMRot4y7grVSFH8FrdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:de::5) by
 TYWP286MB3646.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3f8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.30; Fri, 13 Oct 2023 11:08:37 +0000
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc]) by TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc%7]) with mapi id 15.20.6886.030; Fri, 13 Oct 2023
 11:08:37 +0000
Date:   Fri, 13 Oct 2023 19:08:29 +0800
From:   Hongren Zheng <i@zenithal.me>
To:     syzbot <syzbot+e0dbc33630a092ccf033@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, valentina.manea.m@gmail.com
Subject: Re: [syzbot] [usb?] usb-testing boot error: KASAN:
 slab-out-of-bounds Write in vhci_setup
Message-ID: <ZSklLQuMjoso9RRY@Sun>
References: <00000000000029242706077f3145@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000029242706077f3145@google.com>
X-Operating-System: Linux Sun 5.15.67
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: SJ0PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::24) To TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:de::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYP286MB1406:EE_|TYWP286MB3646:EE_
X-MS-Office365-Filtering-Correlation-Id: 3379e270-e867-4606-c5ce-08dbcbdcbfa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CEhacZstV1XBsMrtpqMqdxjenf+ycwB294ecNM8R3Bxa9obDNU1LGrD4V0/OXYTIvCtix2CBoc4p5i00zq3tTt9WkUuVKPtXh2clnCFZzds6RSuoTaIEzHQG6q7m5mSXeLPQFqCGXbs5jwgngqDxEUIiPNjaEPkpEX9qu8s90hqaE4FnQ6yN4juuWfKEip8WazDoAXbXK+qZL+mrTjw3FZtBHluV/PglJJNru3TiUkg+Kz+Ob02AgNBzdRuq9idr/d1UwxHAtnmEJgMW0DNE/OoVzDOJ/gfE3azGgtjaO21Dy5lIKRkk7AROHOe4OzfNQq9CkRCjxHqFDh4g2JHie5p9r749p0Fo/3+eihj1/cVT6ZdU563M/lOSrCVH2sYkKpX7UewAX0emHcq/Z1oxVxVmlMvdxgwjDv9f5NEypBZqfBIEqRgCxXE1me+q3cqumAcDtuEmPyCiwaiv+bBjXwx/ZqfjHDPhbzQl1pv4MVh60uaqc+Is+c/zJFQP+yY7HcHTB0PzwAQ43Sn3pAqHe5i2bXS23lxV6ETpDBqfnBnsVnj7CO7LqIpfMHgVq/YnhYq5ERSev6b/8K1OQvFvPZZcOVFI1M0e3xGG7ECw5RI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(136003)(346002)(39830400003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6506007)(38100700002)(6512007)(4326008)(9686003)(558084003)(86362001)(33716001)(2906002)(5660300002)(8676002)(8936002)(41320700001)(6666004)(316002)(66476007)(786003)(6486002)(66556008)(66946007)(41300700001)(478600001)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RwdZCU1iLSqpaiAmgADrdhnHVhZz5rZHVA84q51uD+HbYVCukphjFNUWvY6G?=
 =?us-ascii?Q?kwjDfcWGF46VH4RF84w6GwCz3HRC8sXSjRSTbWGYaFMgKrz1azAth6EmDjog?=
 =?us-ascii?Q?lep1OGDpaYC6uicwz5n/thOHQ5+CmQiIQQ1nN3uyiqhwH1HrZD0fx3jiDjm+?=
 =?us-ascii?Q?J5T1TsJYa33bu2N1VWL1oVGF0USXHP/lDEu6p8JGGMOQ2+rrS0EVnUsz3c/5?=
 =?us-ascii?Q?xkps/JqopwpN8FpNdaBKRDMU991eiyIevJ3b3QzO3KKLX0uHuBOCc4jKepM8?=
 =?us-ascii?Q?O5ni3Cv/A/mbcfLTjC8rW3K9i6NFuW3tgB/LYaTxAlyHDkTG3MHdVaMniBgV?=
 =?us-ascii?Q?fRb6Tqs1ruQ18crznf5xx+d7Lh0XrF/acgQ780NB/lqe4PTsqSIzbg+fxY71?=
 =?us-ascii?Q?IOOqkXicgjbM3by3tHUGQ1tpVvzqzSv/lB8gr2LHjJfjvoM0nIyj/meTMuSU?=
 =?us-ascii?Q?Qi0wlwnGd6yTyTx90IHmUeO9apFbhOmdX3crYjZy1ijnuxuH9rZcMJrsUcI8?=
 =?us-ascii?Q?KqgCwiZ5Fd4VBoBCv/pAbZ4Ohfx7oMZ8Kjze4SjJTHPyF9HUba/cBre3xSal?=
 =?us-ascii?Q?Wwj20dS2hp7lOK0daORx1Kg1nhaLqRmM6jOAvtH2br6igPaQuNNassAjvxKF?=
 =?us-ascii?Q?HDZhFCR0x71X7rkTi2ecuHs3ye5MJKanC7MM9trg0v/09rt/c2l1kQWGySZB?=
 =?us-ascii?Q?w/93TfyECgkinEdwA1OB+JBkOWosh+ggts+RxRj1ydmRlTjE7mQwifaieVJy?=
 =?us-ascii?Q?5DNycDu49EgyDBHKIIJzdiGvjjY3pCnlCrKTppYhgjLtgBusiF4WqdtmiEyd?=
 =?us-ascii?Q?I/a2Cefwn3tLGEeVgeebXME9yFw2e6nY3VI1riOT15FR7W0qlcinZPGG9D3Q?=
 =?us-ascii?Q?f2TQTvcFfpioZOJJIZZoxW4yGhEZWfkzBjDVASDLkugA0g781zR9aBE+/lmE?=
 =?us-ascii?Q?z+q+VjEsvLAiX+H5sxt/BIzLVGweWW1VnXz9ybKIA79kSghQqY+vRhGx3M7I?=
 =?us-ascii?Q?1oO+xeDN1d2kHJ1KMdqeqipvuqJIEx2Wd2sDAmzPU1Ea1/spZUuHtq+RRFTH?=
 =?us-ascii?Q?+2kEd2yDHi9Ea0to1rjx0B9/ji0Wp6dhCZ9bGkEgYSY/DoLtZNHGN1E6LdJZ?=
 =?us-ascii?Q?3Zxi/NdTC7eRDl1keCkc1NIZjUxecjdjY4/ZWFecgVrlO0Ovu8jhIZYBuMG+?=
 =?us-ascii?Q?OLp+UiXXxmuSxgNwpqQ0Woo8Tjmcoj6JnJWbvtcGja1mf6lk4WKAe/fROYNF?=
 =?us-ascii?Q?1PSEheEqVSzIqOAcqEA7az2ka+xRc8LkJsG/OaxK4ASEy1Y+U4XXlPzfWMBZ?=
 =?us-ascii?Q?p7lkhPc/MkkColLcDlxJQDCgYax/8UfK0HWpKjnjnVDVgvmaps/f2zLPlpXt?=
 =?us-ascii?Q?UR4UuNZ0AHwmApjWJ/XjtIoyT8TsCTBtR0oDemRDMrhZPltx5PeO5FyRNVfQ?=
 =?us-ascii?Q?CLGBXMLSZz7DBnvUbcAmJxfpkFN7pzlKMVdI2Jtc8H1ac1MPTJmBiaJjtWrP?=
 =?us-ascii?Q?1q1/CQo21dNDNkBly/1kuhSjXvZWMIok2qh6J+uvEdFLnkFdEVaE9nQrYXRp?=
 =?us-ascii?Q?WYj+oiFTvxQbWp5HoLUi9oxmfp5mXSc2loEQK0zj?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 3379e270-e867-4606-c5ce-08dbcbdcbfa5
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 11:08:37.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnDaebpbz9qftI+3+HCZd2aiOcBreXWvfOkpGIHRUMBsAFhlIq8ZdIPD31wxPT5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3646
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 11:38:47PM -0700, syzbot wrote:
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report

#syz dup: [syzbot] [usb?] linux-next boot error: KASAN: slab-out-of-bounds Write in vhci_setup
