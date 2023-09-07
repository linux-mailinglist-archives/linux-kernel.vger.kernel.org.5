Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC8979767A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbjIGQKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjIGQKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:10:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7579C7DB2;
        Thu,  7 Sep 2023 08:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVwaIHRCL5Jv0DRfwckzh54sOknwCY+wBph6q7IYZG4r5ugZahYPV1ys47w2I0zxzZWn6txGL4Pary0a2B0bYg4rASazjMKtyshPhuAdixB6Yjbm9ViL5aKAr57TudG4QmHJu4djxWM5662jEIegJ0yWcQqH9640i5E+GENZVtOzmXajM69EoChngVjUVsXHLoV0DJTIMC1bOUEaOvKhtmc9ASkz9hdDVGjUQoRHgdol7VOxwA4t3clbwf47AshV2JXaaZGdhT0IH7fXrKDfebkoDLoHlCAK7XbcgJ4oBRbkKOvvyFcVYLGC5dy9n4IoGxZg7oNB1kRUaO76XXmwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjEpgsGa8jxR2en88SAUhcucN9AppvX2UZb6Qgo1NYI=;
 b=Ih377/w0QtqMWksCkh5VGqFjindiaAqdE4O/RgserYT1b80nmOvfQnJfJ7nxu0NMakrEueGSjkWfJ4N9EVXEeyQWzfipPuDBLeyuOjZFwBFIFw68Z2d+5XLYPu8tSj2CnzAN1RS97ybwjMi3AxjZq0X4NZO8141P3SsWm0q6gqOpkF+8GK6Cs6/eRWJAAXy0Np/AINazCkRMdUnxUzmcVV0xMjazLHK8tFuYyTgTUDhyJBCm9F9npXSNCjVRvREPUjJTVhcShL70GRl0Mp+VEbj1NmL1onfBgdx2XIvT1jshbxHeq5Dp5cnzB1r79f6SgAptPuagF+SkgvDrXaGMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjEpgsGa8jxR2en88SAUhcucN9AppvX2UZb6Qgo1NYI=;
 b=ey6WFn1jP8101XdRVcrF2/JIlvOV3KYsxmV6Jrg4FfU4nH7+72C4nKoZdDZDNlrk5QpdnJztyzYZdO6vHCNsGjBAfwCWe8HBEDQs14dImRNJhmP4n4ws0pNgF5+h98tD3yC1gKlzs7R1gQSnx4hDcshrjq9NAxtAsVGCieDDGdNxyCUVnv6otOze3tid5St6MnG66G04AelqXZ1pI4W6S7jVklLZe2/l3l3AtAUu7wop+x6L/rkGwznFwv24UptJPwwtQ+ATn4Hl3ltO6AOu2dZw7mj5jpD1TheoSxTZNjRcfEidwnj5EEMLMWb8m12FFmn4lYkQsxM5COboebcScg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 14:21:19 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::210d:206c:a261:c024]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::210d:206c:a261:c024%6]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 14:21:19 +0000
Message-ID: <61ca531e-6138-7abe-74d1-357369134748@nvidia.com>
Date:   Thu, 7 Sep 2023 19:51:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, stable@vger.kernel.org
References: <1694069533-7832-1-git-send-email-spujar@nvidia.com>
 <1694069533-7832-3-git-send-email-spujar@nvidia.com>
 <2c3371b7-3dae-48d7-8cc8-1acfd5bd267c@sirena.org.uk>
Content-Language: en-US
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <2c3371b7-3dae-48d7-8cc8-1acfd5bd267c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::20) To BYAPR12MB3205.namprd12.prod.outlook.com
 (2603:10b6:a03:134::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3205:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: d56275da-b07e-4977-eb19-08dbafadb414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bye6ws7pEY9+7Hwqo62qXdYIIsYL9Hm6w2jK0aQA58ADAsAXgQ4owcYQJG9aypPZqan4WFtKMMT4ITDcn7yv4Kw5GN7pwdagEBjBHl1Yw/AhkvBNvcSFo46ItQWpoL92kGyJJOfeIk0DwYciGhV/eu1aC6Fx4N71J8dj/o9l8xoSrEasPUTAauh/sMyiAcs9fQjMtU4BDHnzUtOeU35aVRdA0AZRywu0yX6LzlK/DlkUHJROq0SBMn53siZB9rC69CA+tXN78Gpl5eAwWWHiHo6RM6ikrrPUnzMpkfb8F1x4ARaGfNHUTml6p797M8Fh8mx9ZlM+LKrm/6lItSektoHI2ubZFXiMxCbZ+tYmkPJ/F/+ojWiM3S/buOrsz4nc/b2y9xzqSY7VN7DZaCADHqQTaoJ3B8l4j1LBkbeQXFDq1g9gccpC5x0e/EV1NIFUwGJyLZnDCIQ9DTb5jvtudDFNuKuuDfAnbs9Y6nMMxZQlpK0AgbjZplF5K3bYOQqhi8DClJrM+PdhAr1puJi2Rkau/y16EiKhX11ktXXxLhEztt4F37tcTgnGjC1hPyLEfhFYJJ5IFEaPlVw9degqklPjS41d3rYQLIZDia2w4QCZpvwrqf6O7zGVsex4EX60KCr5f7H7+zz7Xw5yCvCYbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(186009)(1800799009)(451199024)(2616005)(26005)(38100700002)(53546011)(6486002)(6506007)(6512007)(36756003)(83380400001)(31686004)(4326008)(478600001)(8676002)(15650500001)(4744005)(8936002)(66946007)(66556008)(5660300002)(66476007)(31696002)(316002)(86362001)(6916009)(6666004)(2906002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2VnT0hTS1pCdktLNC9vb0lxaFE2WW13V3I5SERZU1ZmOE80NUh6L2Q0b3E3?=
 =?utf-8?B?Rk5MaHg5VXBXYmtqRGRjVm9ORnQzTkd6TkVQRWVZM2hwazFrbFR3RlBTLzNq?=
 =?utf-8?B?a3U0QUZnTG9ZVTJkcjkwbWtVOGF3alh6UUNDalR3cUVzOEFLdHFFYnhmOUgw?=
 =?utf-8?B?MlNQSDcyOW1XeVllYnVJR2ZOQkVBUUxJTitPN2hwcTZPSHdRdUhFakNHb1Zy?=
 =?utf-8?B?dkg1RTVxbnZ1TzB0SVJsckFFMUpYdHJxa3doWkFyT3N0L2ZjZk9zZGV6ZXhZ?=
 =?utf-8?B?a3pUdTk5UXlQT2w2NHNlRnVZOVhvc2tHcVROYW15dGsreWtFWG5KZTJuRU9S?=
 =?utf-8?B?S01oblZLNlhVVFJJQ3o3UXNwRlVmdVJWMzJXVWlybTE2azJSLzA0K3NwdFNE?=
 =?utf-8?B?eVpwejN0SFl1ZWZuUDg3KzRWOXp6Sms0cndwdmZqVWFDUWdsTmxubG9zTHFz?=
 =?utf-8?B?N3hPQ0ZuNENocml0ZmUxNU5UQlhneGM2Z0FXS3l1TUU4ZFMwKzUxeHhPc2ox?=
 =?utf-8?B?NVMreVVkWnJXejRnQmdoY3ZNNjdtamMwWGkwc0k1NVRzUUxnZlFHb2l0cng0?=
 =?utf-8?B?QS9LcnpValkzbDBpUW5IaVR5a3gzOTlTU21UdjNqYThGYU1wRDlFUzlhN1Rv?=
 =?utf-8?B?L2VnSGhrUU11YldWR2dHUmVZelRDRkFZSGlpUkhDbWZmdTdYbmxTdmF0dVMx?=
 =?utf-8?B?RmVpL3VKSXBlVVUyQ2ZQeFNwYzNGV0xoOUtlKytoU3Qwc0MwcHFlM0hwdmhv?=
 =?utf-8?B?bER2M2tPUUJvdkE1Qjh4Z2FWQzhPOWtWY0tFQVNIZXBreEQ5VkcxSlRyb2Fh?=
 =?utf-8?B?aHFnWGFsZDFaaXl2eXVZUmdvQWdNY2FLdVFNUU8vT2xPQSt1bllVY2t6bXhO?=
 =?utf-8?B?OWhoNkFiY0RnMHNtMWZIczloeXpQdDRKRlFHU0JrMnk0SmZxaXJadld1MVZY?=
 =?utf-8?B?a1JMTVhBWVZwQVVxdDhUUGwrZ3hPU3EyWW0vR0lsZWppNHI2aDRsY1pYUHZa?=
 =?utf-8?B?V1RMUlNoMFBWUjVQY010NUtZSEZFbythSHFod0MvRFFhaE4rOUZkN1pEY1FP?=
 =?utf-8?B?Wis2UVlsR29XanNJK2tWR0J2Tm1nMHFJaDR1MXFOODFxdnErdDRYazhLVnRv?=
 =?utf-8?B?RWJpeDBjZWRmTFRQeU9XYWRjTmtpTVllTjZkZ3NzbWJodjRlVi85L0c4V3ho?=
 =?utf-8?B?U1FVQ1lhRUJReGlUdGlCbDNmd2RmSENsRGJVQjdzTnNmaHZWZE5jSUV3UFJ0?=
 =?utf-8?B?aUlwelRhT1RDSjV1QTFJVnV4WnJjNTM0cjJyNGxXR0cwOWltbmVIak55cEZZ?=
 =?utf-8?B?VWVNNGlISGtqcE5FRE9CT3dMVzVIdnBrRFhiTk05RDJZWXdHM0FENWtJSlpP?=
 =?utf-8?B?aU5WS3RIUUtsRHpLVCtxLzlkOFgydXF6TFFnRmg3SC9iMVZYMlpMczh1VEdx?=
 =?utf-8?B?V1AzV2swVCtIN1RMb1hQSkduQUFnSzZTcUVCZHZ6OVdub0RvT1htS1Exa1Nl?=
 =?utf-8?B?VnpObURQdXJnVm9qaGt6UXFkU3VqQTBNWlpkcUFENWpMTm9YbFk5dnkyalBZ?=
 =?utf-8?B?QnBFbzMwR0RXekhkbUxML2pjSnFTZG1BNTV4bVNCcEJ1MU9zY1lKREorTU5y?=
 =?utf-8?B?TnB6cDAzdEpqbHhsT1NuTmZZand1UTFVQUdvZGpHOWRoZDdWa1U0TzI1SG9R?=
 =?utf-8?B?eXJUVTRzTnEyYWpnakdDRW0yUnBvc0Vka3VQUUhYdG1TdVBYOGpENDE1Y29s?=
 =?utf-8?B?c0dnU0d0SS9haXJXTEVKZ2YxaTUvLyt4Q2hFcVJLMnZHOS9Ka3o5aHBXckV5?=
 =?utf-8?B?d0xrNEJjUlVuZ1laNkdNYTV2djJKMDVUVTdKL1JOR1JRVFRrRmcyRll0aTRk?=
 =?utf-8?B?am9hTEJQRnRic3V1SUdQUm8ra1dvTEJFUmxKV0JTcjgrNWF3bUlNblhHWDND?=
 =?utf-8?B?Y2lZTXZ0NDZ1MmpmbDdvSWxwN3ROVXFKRXJ5a2JSTitFVHFvem84NDFYbFlV?=
 =?utf-8?B?WTZXcFVOZVJwN01uK3ppcnBZTHhFOXdRQVkzS0ZUK1FEY1NDNXJHZzlQejAr?=
 =?utf-8?B?d1hGdmp3YllVUC96cnBQbFhBV0txU3pmUWZIb2xPVVl3c1NJemdPdDZtb3pN?=
 =?utf-8?Q?nsEg3YrB3kitYqFabYgSyGsiM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56275da-b07e-4977-eb19-08dbafadb414
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 14:21:19.2070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMVyCV10OUSGaItNG62ACSacFUYJt8DCzjA6jJaHE/fqckA7d0DbBihHQ5mURPcPxQKvzNXrgmpOBv038Q9wfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07-09-2023 17:21, Mark Brown wrote:
> On Thu, Sep 07, 2023 at 12:22:13PM +0530, Sameer Pujar wrote:
>
>> Fixes: 202e2f774543 ("ASoC: tegra: Add audio graph based card driver")
>> Cc: stable@vger.kernel.org
> This is just a performance improvement rather than a correctness fix as
> far as I can tell?

This was supposed to be a performance improvement. However this is found 
to be resolving a DMIC clock discrepancy and suspect is it happens 
because of back to back quick PLLA updates. Thought it would be safer to 
have this fix in stable releases. May be I should mention these points 
to justify the 'Fixes' and 'stable' tag?

