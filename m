Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84057DF9CF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377187AbjKBSRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjKBSRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:17:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944C91A7;
        Thu,  2 Nov 2023 11:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9K35zuwEfbJ9cSE8HuEbzaeMXG48suI5YuIFBUI1TvXWpoFEmk7MjVwQfF87FwKP5Al+dO781zKInN0GT6B2IVUB3aWTbuQK1S/5fwJ4Ea0h2hT+pz0jL2O5GA2Pt5veI9U+sQNc8abwVJO4bo1Umw+YhJVfoz9GyKu9VPwPuOTfa7nkJEZO9Bzd7VvaHCsTAAY12J4g6MY40diRufGjNKNAmv62VDtXYlNb+FhsM5votkPqOFWTTp+dCR8VHWTH63mCrG0lTGAIwdtRGk1j2ltioAYwZ0t/MPCDjpxPINtiloS+lKNtJwU+fNSeNBgNGNdSt2loAtYq98Mhu5iFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUeEAtor6+jDpoIzaPpO34DyjfooFFW5azTZjnR0Tqw=;
 b=KJ3046Jz5qU4Yy5ohoHbH7SRB0iniTNgBJ+OaioOW0gR0C0krCiHP089xUOJjgd13zL/HsFyAATK01SfRLdEQq1NRAS77/crB4w/y2893D+jj/w5Djq6C/az0N+0M4Z+ev2QXScjSvUkVZBL0hZKuT5c/bVh6CRqxYGetdmuriGwFpdIIbNqCQw3TilhJinkh/0f36ctmWk2+VJ/hlZkIjI2yBjm0eY9S9q47isZSLfBUW13WyZqpE6XmY//hul1hXatDIdEoy0YQ01vnYRmd2je8r3NMeUHVuo1R8XUqPssC0mXWFt86jVRkRfZ1UtUXparWiUu7+/iMrtOEdqmnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUeEAtor6+jDpoIzaPpO34DyjfooFFW5azTZjnR0Tqw=;
 b=i7/BFniRaveg2wferfFc6riF/vRSOkCMuwMDqO6PcpvcFzwaJZtGCdWzIGtV0MzzG59hN7AnHQBkMBfG3AA8SQCIqJeIoPR0sjVZhISOpSDLBAaQ/3olFESp3VpvyiMBjcTwmQyHk8KBginG89ojvX4hpYNC1zEIIzbt1dnrlCSzKqzHtRnWW6cshBDBazT5MVTAKOmYxNP9a7yB3P0A57HyqyLgS8iCy4Z/p8ATcauaZ2PWUCgoO9YFO5CgrV8j8/9bsDNXbOX5zWqGydOBlp8owUYG4k8zWqBnFMmf7hP7Q40mN+RqU4N56jGI/06KTI3DYYkVXcyY2ag3ZCmepQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Thu, 2 Nov
 2023 18:17:42 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc%4]) with mapi id 15.20.6933.029; Thu, 2 Nov 2023
 18:17:42 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?= 
        <ast@fiberby.net>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yevgeny Kliteynik <kliteyn@nvidia.com>,
        Muhammad Sammar <muhammads@nvidia.com>,
        Alex Vesker <valex@nvidia.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: Fix reserved at offset in
 mlx5_ifc_fte_match_set_lyr_2_4_bits
References: <20231102175924.3456007-1-ast@fiberby.net>
Date:   Thu, 02 Nov 2023 11:17:26 -0700
In-Reply-To: <20231102175924.3456007-1-ast@fiberby.net> (=?utf-8?Q?=22Asbj?=
 =?utf-8?Q?=C3=B8rn?= Sloth
        =?utf-8?Q?T=C3=B8nnesen=22's?= message of "Thu, 2 Nov 2023 17:59:22 +0000")
Message-ID: <87o7gc58ax.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:a03:80::36) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c054409-9152-4660-1263-08dbdbd000b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBOs8uSDLY4ut4kmpHEKaltvREzbMRaC9Ny2FDX/uelVGqlB5A++lu/KCJQPD1BEhu2zbZgl9Iyrl6Oj3SCIDL3wXTO7neyV6yMsBawWekgiey7TJTbK+5gtK9W0pQokTUGPXrThuyxNv1wWZMgpvbaOWYe+N29SYwGKaoON2oNdPoWE5pNMASbnKnIb+CJMJzo3ef8b/ZLJC6B4/C+z7Tm/9c0QaLuzkf96WWPeSIZLRQHXpoX3b9WL7wzqop1gd/1Ku6nJvmKPGEg/6aBPyVYT621jBHbLhGYRcL5taY6/7O1PC2btcKMIFCuAbE6E4bkhyUU2xao+MOVMEt8o/Nu8dPIhaLzCCOi/21RCC3oE4cfNhE9K+dGifuBKEnALv1hLf71s5sPpXQum5T7mNZswAmVpYZW8aqJznMmjmOFxheD66mPkf3/kEabqyglmj/EMDukU/SkWcG12psX2mH5Fys3pnmFMNg6cHBXV+n+91aanRYOTQT9xgRqKmoEVECG493p/SszCSJTnO54e7qOptpKo4lq2K80ARbP320Nt12LRINXdj1a9DINqUgl9GuE3dAUWtW28rGMWNi/ueVzOfxkOGVac2yhz+VxTCgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(6486002)(478600001)(966005)(6506007)(6666004)(66574015)(4326008)(83380400001)(8676002)(6916009)(66556008)(66476007)(8936002)(5660300002)(2906002)(66946007)(316002)(54906003)(26005)(86362001)(38100700002)(6512007)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG5RbW8zL1k3TGtMVHFzMEF6RDl1cG81SUoxRC9IUUQ0a1daT1Y4UURhbWp0?=
 =?utf-8?B?NzV0blpVR0N1aHljdDF2MGZ2TnN5UkRSZ2tndzh4Q2RWNGJPMHlwbEdLZlNa?=
 =?utf-8?B?dno4SFlPSzVHUFNySnNpaktrc0ZlRklDMU0rdE9LYkJYS0psWSs5NlZwK2tV?=
 =?utf-8?B?ekkyMkxQNWFTenFkZi80dCthRk51RGhNc1RtVm1MdXR0T0VSTDFBemJHRURQ?=
 =?utf-8?B?cjM5SjFqS1JuZmVwOVRycDNDYXU5UU1QbW1sdjFNdjMvK0Y1V3JyQXEyeUph?=
 =?utf-8?B?WVQ4U0xxajFGbjVNQmlNb2RQM3hRbVBYMG9WMEI1emdJQ1d3bXZSV0ZDUUVp?=
 =?utf-8?B?bGZEQnp6MUJ4REpTUFNIV1MzaWRXNzFGZWVIZi95UlVnd0xzREorTnc2eHBx?=
 =?utf-8?B?R1NQbVhtZFdBaVNTT09DclYwR2tUUGs1c0xXS054bTMxNzBsNHFXRTJjMzI5?=
 =?utf-8?B?Sno1eXdwc3F6SkhJeTR1RHRmKzlwMGg1YmpMUExwVHdpTzZjbHNueTZDL2xq?=
 =?utf-8?B?aitmNmM5cmxuMXo2aWE2UUtjMGpOTFFsd2xwMWExSUo1VmloOUlSSk1NZk1U?=
 =?utf-8?B?VVFDWExieW5ENzlvT1lJa2hDS3NoMlJ1NUxXTWZIM2dWQ3pFZHZCK3h3dDQ5?=
 =?utf-8?B?N2JLMmM4U3NVUHhTVE8xOWp4YndzN3BlM2hORnREc3AwZUtMcVVRdlhndDVO?=
 =?utf-8?B?YjZybDhxNFpHb1YvZ1cvN285bVZZZGNxZGFSQmtkUGhyU0MwWDN2RDNTeGxl?=
 =?utf-8?B?YkN5cThqdW9ORXdCNG8xV2xHRzlxZ1ljZjRFays4M215SFEyL1BTNHlnK3RZ?=
 =?utf-8?B?dGM5ZG9yaWpTNVdkbklUdDErWWpjL1ZiWGlzTlNIKzdDRDNKZGJ3ajBRZkZl?=
 =?utf-8?B?VzZxazZ3MzVtSXlNbEFzekcvSzRGY3FJaUpwVm9OdUdUSUZuWDZ4dXlYdi84?=
 =?utf-8?B?Q0pXeVRxTXZiN2x4ZXFHMk5TMWJNMWN0ZEtDR2M3dUR6MHpIY05tb0gvckZl?=
 =?utf-8?B?ZlExTDV4N010bjhBeDBzQ0Rwa2d2eEF2M2tHc3RYY1dVcVE5K3VqVkhEQUhV?=
 =?utf-8?B?ZnROWjRUNzRad2JxV3FCT3BySHFyaXNTUTN6SWcvRmRSK1RJSE5wUTY4ZnNn?=
 =?utf-8?B?dTJVaTdYZVpONXRPKzlJZHRtUTJHZEJ1WDJabXlZbmxqTVp2UVl1aFI2TDJk?=
 =?utf-8?B?Z2NmYzBhM0ZLeWtQanZGdlVIMncwOE5OUzBBTnJ4WWhzWFFCZmtCdVc1bFlB?=
 =?utf-8?B?bEhtbWVDK0s3bnJ4NzVsbzNYWUZaV2Q0N09KUDkrekRhQXdnWjlaV3d4d1By?=
 =?utf-8?B?TzlIN3R0MW0vc2JTMW5WSDA3dTYrVjBLZE5OUGxSc1l5dGV0emdKZkQ1aHRJ?=
 =?utf-8?B?YWp5RDRDM2xReHdrbVlIWVFLL0hKREdCeHRiU05zdUtTbi9BN0tSU3E2cGtJ?=
 =?utf-8?B?Wis5OCtNbUtXbE92SWYyMitqZWJxWVdUYk9wS0JzSFlDVTVhaXlSSXI2UE5P?=
 =?utf-8?B?c0I4OTZoazNoVGhITjA3VjJ0RFVYVFdpdW5wZWRneDJFejV6ekJycitWdHNY?=
 =?utf-8?B?SUlDV3NkZ0Y4b1lUU1NRK1g1WFljY0svZlJnTkZnbTZ6TC8xUGRiMFM0L09E?=
 =?utf-8?B?MzRZVDZIVUxwUGhXb29kOHpwVG05bTlMS0QzSW53UEZja05UREE4dzBtS2pw?=
 =?utf-8?B?ckRyTDFQVk1LWmxjVWhFQkhydnhkZnpOMVBQaGpTaHJCaERoWG1QMTcybmV4?=
 =?utf-8?B?ZTNRem9kWms2cCtrTG80U09qWkNyZm14dFhIQTZqSzBGcW5oVHlkV0tTb1Bz?=
 =?utf-8?B?V0N5M3VrSU55dm9BVFRZeXhmYkVNOTFkZWVrWWoxZ1pWcEovMUJqQXdOWXNY?=
 =?utf-8?B?ZEg5b3JuWGRZdFVoRGxWLzdGOHhnVG5FL2t0SkN0aGV5Wmt5MHNteFdlbE5F?=
 =?utf-8?B?YkhqaHBDQXR6YzZhQU5rMHBJTlJaaVhuTTdQRlBYdld4dWlDQnpCbEIvZ2lq?=
 =?utf-8?B?azZJZWpqSG5INkVCVXIwTmdHQVlvUzhuSXJlZTNKM24zdGdQY3FOV08rdmZi?=
 =?utf-8?B?b3BwUjBBaUN3RkIxV1c4WHQ0OUM2aXdkUmlwTDJNSDdUYUtKM2hHOWV2ZWhF?=
 =?utf-8?Q?54XcVZnCfLCTppTiFw4U3kniW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c054409-9152-4660-1263-08dbdbd000b5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 18:17:41.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbttuBuK4p++6iCNyWJGaraO5wr7n2a3gcCqn7lwhPhX+tCn3B5xiMWvAc8zt55QMvPno+GFAzCQtglzEMYlQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Nov, 2023 17:59:22 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@f=
iberby.net> wrote:
> A member of struct mlx5_ifc_fte_match_set_lyr_2_4_bits has been mistakenl=
y
> assigned the wrong reserved_at offset value. Correct it to align to the
> right value, thus avoid future miscalculation.
>
> Fixes: 5c422bfad2fb ("net/mlx5: DR, Add support for matching on Internet =
Header Length (IHL)")
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> ---
>  include/linux/mlx5/mlx5_ifc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.=
h
> index 4df6d1c12437..09c50e786ff4 100644
> --- a/include/linux/mlx5/mlx5_ifc.h
> +++ b/include/linux/mlx5/mlx5_ifc.h
> @@ -552,7 +552,7 @@ struct mlx5_ifc_fte_match_set_lyr_2_4_bits {
> =20
>  	u8         reserved_at_c0[0x10];
>  	u8         ipv4_ihl[0x4];
> -	u8         reserved_at_c4[0x4];
> +	u8         reserved_at_d4[0x4];
> =20
>  	u8         ttl_hoplimit[0x8];

In general, patches should target one of net or net-next on the netdev
mailing list as a heads up.

  https://docs.kernel.org/process/maintainer-netdev.html#tl-dr

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
