Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6607E188A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 03:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjKFCMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 21:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFCM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 21:12:29 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD9DE1;
        Sun,  5 Nov 2023 18:12:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UORXS9lnyA6DLx5caCH5a/1A+CoZYmE8HVa2ew+wFbQejp7VYUbwRYu3wyuDTxfiqRI4H9xzc7nEMTsKPSyRdhNNVMb8Xv6ihj+pe/keVlcAlrOb41y+BNcRErRHQwMu6W956gC7IqXMvrHbDT8wgmPuW5G83yVgRjQQAEoOVnaatDTPc+M9vNGtUqsRjGVXtRf6jqjsKJ/BrA8sHYcscIy2kHa/D44uEUHR9adVlO8WsgYdm4OoOV2/cACaq+MSWIQGErXUZ5jfXsGb6A6vbwD0bvibUKB2eUIrY1YtCusPKsPp4UxyiTZmJpE7E06RpYgeb0IWLl0MZzqX124yAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2YTKqvgykwhxtjydSseB0g6WKD2OmVVlfGwTWMt8Y4=;
 b=mvEbCVwJNUcEWsbqBJYmz7lB0Y/VtKsMRMR1UZk2chiri9d+DKI966c/I9wi9ZQmm1jBlL7syDNwb5WZ2TIcu7gQdbo8XAy+glBpVi06gdWrTJr7Wo3F1H5OvwyGHW9kVR8bFVkdMoTFhF+y6vnatA5Z2cBej0MPV7c1Wz/V1O5h11VhMes/gCrdGVRlujm/K/3lXrttODcI8HvrHQ1RF5y7Ylu+KsCe+oJ7ryEEl1ErevIIBJfeTfiGNBshTgnBGDmqF9UJZysLXuTIKKaUM4p1+ebQkfl6Wjiglp8ePOTZbmZdeFQ5Gl4oXX8X/5n2PUxAsSpnd+fwb1gwjRrXxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2YTKqvgykwhxtjydSseB0g6WKD2OmVVlfGwTWMt8Y4=;
 b=Pw+7npYRcdyqOqFaJKL49tfPbFtwe89RX9q2n/+EOVzS5IPlRh2bUuWAKfVet7ZJ1g+ualvRrn1YEBJZ21Gg7Qv2N5BFSSpB5G6vt5SAKMvO1+1DG0C/ro9/Vw5wWDfj0wBu9D4QXtuwqv3VRrk16W+MHdTmZm5zZ096U/gNZSOtzG7eq7mvd6Gt+beGwHocbLxcvpp3pLKoTWIH8TmytYHomYVxmwPjlBjAgFcVGSwy44mjLkTKtr1yubRn4Jfpf2H4fx+u01UoqIw+0JXh62mdbTOqkSmCwterYY0/NcmCepZ0JtdmB3dwRIupegJX4ZV/d2qw6+7x7JnIT9y84w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Mon, 6 Nov
 2023 02:12:24 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 02:12:24 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Lizhi Xu <lizhi.xu@windriver.com>
Cc:     <syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <reibax@gmail.com>,
        <richardcochran@gmail.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] ptp: fix null ptr deref in ptp_ioctrl
References: <000000000000e7b62806096c7d67@google.com>
        <20231106011926.2928881-1-lizhi.xu@windriver.com>
Date:   Sun, 05 Nov 2023 18:12:14 -0800
In-Reply-To: <20231106011926.2928881-1-lizhi.xu@windriver.com> (Lizhi Xu's
        message of "Mon, 6 Nov 2023 09:19:26 +0800")
Message-ID: <877cmvhbpd.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::21) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: d0900799-c8e6-41c2-ea53-08dbde6dd0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kX2ntwoSIzn/simzmB0Ov9vbTZHfujXH2dFCLRTyKS7+PjScGRbJVy1BPH6yjIBXAEgXteXVni6FtCBbNOkuQpXH46CJras+rgpAxwA2Jr1aC/cu0ZOnlAk9ffIOLEJA6Ws4Z/xS1ryTn6DlDZZ9BCvKQT5kO657pv5YmpW6kTBifAxDtw2c1qAJdrNFdnJ8/vxy8L7aJMyq8DfEYbX2RKGmPke77vDNWsiuQSuORKxexsg/XSebHd2p3WKXLNa4yhFa4k2VcryG+/ey4C1xoXcmy9KyJjMEMlLcvlbj5YZesRfV5aHHDpv1kL6i8fSTexdLuW2bCFBdkmFg4JnkbXcn3xdz5WdshleavAozYqgIliOIbCOhs8TDR02pNyAqZBUmvUquWGVP/GNtYYPFSKYEYaw+DUFmUs9heRSwS7C2winrq4QR/M3evabQliMAHB0jCgxNTPYaqF7XoQTe5KgpDIKOWRef9X5FYPKUWCTeBi0NCAl2Lh6BBxlVDXWCfjyUCVLF8BOVjKBqamPhQlHQEZyvBHc+VKV8h1nRtPZyJZjy4m4KdgL+hxCk09f+uQZeef1ZnN0+umreWDCl6wntRpN/DduWqMdPKCkT/tk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(6506007)(6512007)(2616005)(38100700002)(86362001)(36756003)(83380400001)(5660300002)(6916009)(2906002)(8676002)(66556008)(316002)(66946007)(66476007)(54906003)(8936002)(4326008)(6666004)(41300700001)(6486002)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f1+vanvGcMIaeKHmHBOmeh4X61mMUmLb+kZzYU9e1RrHEBrpTUI81eAnIw8+?=
 =?us-ascii?Q?JwQ/29ufmYZS9U+RadAURzhcGlfK+rUMyPegJnh3wkgBXEq6uuGurqnVBBml?=
 =?us-ascii?Q?+mwMV2J9kjvPszVNS4fbjTnfH2t052XiekeUV3ZGShfNJrjAbIDIiMdZ0eSL?=
 =?us-ascii?Q?UiA7ekQWiKSt4a7N5G2dJ02Tq1IX896HWl+qWi1RCgtQwRwGYUCc7fjOR6YU?=
 =?us-ascii?Q?XunBVUwx5C2FFZCOmiLpC/4vUMePApws7v5CLQzpPClBPYwwpFQpXKIvDJ0q?=
 =?us-ascii?Q?dHSMgpl3gg0JXaxdwMnaP241aqrTgs6F7kcktYEofP5N8mRSoRxx5+26nQjR?=
 =?us-ascii?Q?NdXpw12gLlNj1DulnFI+NNSnMLwLBR0whOKtxfa4yLxz+wdeWdnatXh6oqBS?=
 =?us-ascii?Q?gX4Myi7+TaMp/uxXB01e9AKnZE0Sm/QJ58erjyyDlJ1p/kwHFFV4HD7cHNYk?=
 =?us-ascii?Q?KZmP0v3VhdfcgtcMae88e5LbSW6EypxJr2o3u2DqcXiRKA474Fyuyz1GukXx?=
 =?us-ascii?Q?SXzy2xWB9qUfiFWgVry/UYFAtAJ73M8naG52nxlgmRcQNp6pTiUpmKNcF5PU?=
 =?us-ascii?Q?qlP9hNFLHmVHEULtq1ZPOgKHy4Dy3rzYrECbLJpwRKO7ancMcdBsso7+n7KJ?=
 =?us-ascii?Q?6CvFudy0GH/1Afbjr9Ae7ZCBARw3nEQzBKB6mK6w/aMB6Y4rPUxBOQHjWmvY?=
 =?us-ascii?Q?Fe9vhH5ajJkCnVZmUBUMY0fQnjyd7qq8gpzy4Sk3rfbfn05AgrI1jDyqYFF6?=
 =?us-ascii?Q?EKZYFVk3kfmC+TBqN2KP+1jDSavOZx4nnQOYXyd0hD0GUApnj1+871lezGac?=
 =?us-ascii?Q?wqP1RpijixA6YQ04XrM2tTOJLVLdzGbpRgqwi+58oxH8D6NggGGkANuQ7WFm?=
 =?us-ascii?Q?NNvYU6vJr06ocSMHHRyH2GB/DYqxQflnRItt3QdXCiZ3lR/rb6khHzZ4XlmP?=
 =?us-ascii?Q?pad4m0LPJGk0K7wlr5enhkDFPHRPPRmxYVDAkc7JKBuPx9Mm2WoSrBYja+Wb?=
 =?us-ascii?Q?ZYI72lhwvDNCQyh/5oOiIfrBJUSB1fJfHWa8OH3qHDAgv/We1cbUCNury2x1?=
 =?us-ascii?Q?tyQDYNy9PlwyWEgMzxqthbosQO3qR+VG+8R45z/ha6QWZ18bAhxCzk0SMM7h?=
 =?us-ascii?Q?JY1VvHQE9W/bVr21sRUlm/3MwpHFEIr4UopI9r6579oFxh7khutohEpPe8ZK?=
 =?us-ascii?Q?omzskv/hFHATYcOaAUkXPc8vw58vnbJ9map19hvn5Fd/vRpchtuHNcgjRki8?=
 =?us-ascii?Q?tviBc9Z2JmobZlA4dnYu5f4+sbEOOSJs3HXi9Ddcqpc8cxhZm8VqLdcf3Sy+?=
 =?us-ascii?Q?Vb0emnqr0BVXjUttP/fSg76IJIpMUs9aWaOvRpxC/FWsjTEp/cFwAxdKZToE?=
 =?us-ascii?Q?Kpp9I9MNtp/9j3DwagLIDSqSi/OmG9k6rnQHs4xkhk0p14qP8ukuFMuUvNDh?=
 =?us-ascii?Q?Iv0PKJZsO8oOKfRZ4YRM9/X9xQj3/uSb/eqm4VsBAXw8lPJNZFY2+TgP2aRA?=
 =?us-ascii?Q?kY8xexNelcNY5vBO4Akc49DVe7V3au0cwS541nRnU6KGiLkFik9LCTnEX5UJ?=
 =?us-ascii?Q?V7v/yMcTsKQTKLjjvvAQnFrUTYulC2z0u1ZoDG8r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0900799-c8e6-41c2-ea53-08dbde6dd0cd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 02:12:24.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25T3iwknh/bXD3HKt7cJpDQnu75tdZysk7Mmq5nf1KZLPHvpQfR4iFh1YpG9c84+b6Xorgob4CLd/+NLZG32gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov, 2023 09:19:26 +0800 Lizhi Xu <lizhi.xu@windriver.com> wrote:

<snip>

>
> It can be confirmed that after the execution of "read (3, 0x20000080, 90)",
> ptp_release() will be called to release the queue and set
> pccontext->private_clkdata = NULL at the same time, this is unreasonable and
> incorrect. The queue is not the memory requested in ptp_read() and should not
> be released in ptp_read().
>
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  drivers/ptp/ptp_chardev.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 282cd7d24077..27c1ef493617 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -585,7 +585,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
>  free_event:
>  	kfree(event);
>  exit:
> -	if (result < 0)
> -		ptp_release(pccontext);
>  	return result;
>  }

There is already an ongoing review for a patch submission that covers this.

  https://lore.kernel.org/netdev/tencent_856E1C97CCE9E2ED66CC087B526CD42ED50A@qq.com/

--
Thanks,

Rahul Rameshbabu
