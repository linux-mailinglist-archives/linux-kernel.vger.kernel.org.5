Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7346D789C2A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 10:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjH0If3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 04:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjH0IfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 04:35:04 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27A1136
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 01:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYNbxU2NY04ofE20kx6G+ssOW/RPBQSPu9yWaJWUQsx5Rb9hzLvVmBDCPbSvEZBmMyvNsAaROcnvKUreZ4TqZrLyI7XFhQE0xfGuMxIsWG3bwOH/63B8VZP1j/vng8sHc8B+U0s3jva7a6bIrF01DvukXYxNwTgVyt7BVo/IMwaV+GLiV5ON0aRWbrcLembAPzcjjBACcQpBp2ytgO/rLdioHZfp8v76LzKtIElw6dLd7mZVSTl4xF7UW5qc1Tvo+9uOFMDnQoJYx36/e9bhmw6BtR6yWm6O0aSNnfkzl0E95kowyn6Sd5DI1quC38BZEJWStigi7S3W4M9cWRhkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=af7DhcnM1wheJnw9vkTB6qVZK62n2zx6t993RcZJHqA=;
 b=YGtL07K2EVIkxrwiUv3G4Iu6gyHy0Ubt0x9wfj1CkhGbTTcwG4Li0P28x8wyjnbcr1nUWFny3r81Iwg3oz4+dcLOE+Yi9akjY2PceyXpliAXqG0unngfV9+O1/jdjhnPfj8P3aEP+gi6VLZtqI2HIdmEU/35BnrjH415Z8GnBNRdaYhZKdIo4m0yMBBVR/bHK3Jr0H0VjrDUKR66M9JOPX4Gj13C3NSNBl+HMV0ThtQBFTpF8IDnvJpOOERDYPjhBowUUdxxBSzpplbx8g5QgHuZJrts3BFQnsCNsZtPLI3vxYRPj+9eKDYVZR4fqv5BOMaZO+HEgcmUjMhfB0GfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=af7DhcnM1wheJnw9vkTB6qVZK62n2zx6t993RcZJHqA=;
 b=bizZHqYYBGbv6LijCmnwzvnJFDabVDxnw5iunNcI12hcNfdUq+SaEys5Q+jV7UxI92S+1qqH7LI9JbitQEyL6t/xHZJ/zcLFQzilNl9+oxX0KvWJStT+/sy0ZcWZWwmEMd2j6tbxEX/VD1kcovSrPKRkEq5WDz2hw/hxpLKzrQ0xRr+S6TaWT5VCqyDu3ZixvcFCA3Rb4WpACURU2AZgp7dR8QuN/aMqqi3DlycAiJKSANpVeXe2thustwFoSRFSR+gnhabtxa0CYrYzu9cmiek8BMkY7qjnQFo9gbYFel0mx4XsECn/YeQ0nGmFKWJSiPj8dme8bqAVCH8Ar53aDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.30; Sun, 27 Aug 2023 08:34:53 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 08:34:53 +0000
Message-ID: <1b3f6041-cb4d-90cd-29a6-e0327bd19c91@nvidia.com>
Date:   Sun, 27 Aug 2023 11:34:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] MAINTAINERS: Add myself as mlx5_vdpa driver
To:     Dragos Tatulea <dtatulea@nvidia.com>, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20230815083321.533688-1-dtatulea@nvidia.com>
Content-Language: en-US
From:   Gal Pressman <gal@nvidia.com>
In-Reply-To: <20230815083321.533688-1-dtatulea@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::30) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: cf98eaa0-2fa4-46fe-0626-08dba6d87c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPUJXngKm0qvynahcxmhRLCuXBfirhs8A9wtyf4sTAN8ckpMrLvmIElsTrzl9jwZl2fUTDuzcFitYWXO4nweTceFF/fdXtz7zyupsx1wJxT0NyrUK333AhCJZEDUO/fAAw8z7kyfG7avdjRC5L1EVRP7Px/g5JG5nnHpV48uxTM333Z0g1tIkXDwf6ge8nwyAJexd8jdrpj8ZviIWgKht0UwnbD0DN6fvA4U3kUZvi0eHJZsz/M6L/GvvULksfgTap/28OJT0WBPdZVgL2nVH+9m9z8m8cwI/ZAtAjIAbJLfNng0nb56+IUFZUhK/h3PuoCD3RTf7gncGhT+Q/XoE/jnHGmMA0MkL2SeNU005HMbO5L1sX4WapcrPUZucjSiqaKOQIMrFxB2NpAuyBs6saTdoojM/BtZhUty6FSQIeAfaoOgd1rRJPyLFwSDkRVLoMkGw97lDCcbCU91gNjcINvVrWN0+Rk77RDCio4xKC9rZSJc6YIhwJeLRu3zF53SC/RVLablIKUS9WG5toY/tTvzGEqw1CTxqUQH6qMOgWrFXG2wQkLel6FYgjqLqK9LfCoLfLMBBQJhQwH40botjb1k+giedqJwwyOWPtt4mn6vvwYA/8ZoYqiHXtiQ8f14cQ98oql1wGby/dNWYLgBVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(186009)(1800799009)(451199024)(6506007)(53546011)(6486002)(6512007)(6666004)(38100700002)(31696002)(86362001)(36756003)(26005)(316002)(2616005)(66946007)(41300700001)(66556008)(2906002)(4744005)(66476007)(8936002)(4326008)(8676002)(31686004)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWo3TnFMUnhMSjgzTzBKS2cwSnZSamxLMzBkVWhSbTFUbHMwU3ZtTDgvTkhU?=
 =?utf-8?B?ZksrTjlLZ1BTUkw4YklnbnBzOU9VT3pUdjJSOEZvNlBDRFlMVElHOTZIbC9v?=
 =?utf-8?B?QlJHUjBVRXBuSjRZN3pGdHdCR2RXM010SW45dXRnTktOK0pJVkRONzVsaTRa?=
 =?utf-8?B?d05aMERXTHJQMW1JMk1CbVc2eTcvQUROR3NVbFduQmphV0ViZkRsbzZ0WFQr?=
 =?utf-8?B?c0xTS0h2K1MvWDVDQU5lNVZ6WWtjaXgzS0RqbDNXS3N6Sm11NU5kVVZVRjMx?=
 =?utf-8?B?Qi9EYmQ4NjN5WU1jY3NMSDRMRHQ2K2pSb29MWFFucVNDaVBFNGJqM3lmZHha?=
 =?utf-8?B?WG1tS1pGZlpKMEM5bzZkaTZyRm8zUXpXTWhhZmpZSVovamgwck5LMjI4cERx?=
 =?utf-8?B?VXR3dmtXZHpuMGxVeVR6M0w2aGdGVmlVaW5FK1JJeHAraEpUZVlEaENGcWdN?=
 =?utf-8?B?TUIyQjJCTVRUc0dncE5sdFgzNFhvcStKZWpuOSt1ell6RWVSbzh5NVc0c2Z4?=
 =?utf-8?B?UXdEUkdWUTJqQlRKbmxVWmIrQlhXbmZEKy96VXhNWERwS2dHR2tkVy9DVjln?=
 =?utf-8?B?bGRQWi8yYjl3Rks3Vkh6OFZJU2ZTUGMxT2piaWo4aWhtZnpnZVRWZnB0OEVo?=
 =?utf-8?B?WkpJS0MwbzREbnZzdktsdnFOSUxNejRHQnpGRnFLSDJGNHF0NnN0dUZheWxz?=
 =?utf-8?B?aGtzMTQ3S0ZVUU85UWFSTklweTEzenM5Z1RxSHFzOFI4b0dZN0ZHeG9DREo3?=
 =?utf-8?B?NUw1SjE5MnFJNzRkN3ZkUkY2Q2hBZEl1NVV0STZaTVNEODg1OUVXMis3WWVj?=
 =?utf-8?B?TVZ0a2dpRWxVdGlld05RRzR1N3pXd2NrcjUzUDg3R1UydkZLQmIyM05MclFV?=
 =?utf-8?B?SnNqNDRYUE1rTEpqb1VJUW9rOVZWUDE4Sm1semRBdG1hY3UreE9hbnFVVW1E?=
 =?utf-8?B?NUtJRDExS09rdm1pbk90bmNGR3M0Wkw1RmZaTCtwSllxVWFHSDNhRkpsUXNa?=
 =?utf-8?B?d1lIVlRDTXNaY0RwTDhGQWxkZ0N6dmMxR2N3TDJCWS82NkdpNE5rcngzaWJC?=
 =?utf-8?B?YyszQmpGNnVNUEwzKzQvRFBDUlBjSEp5TmJYbUdnUjJvTXVRbzFtV2JXNmhr?=
 =?utf-8?B?NE9QODVER21rVElvTm5RcnVJMnhWeWdzdUtjSk1zMGNNdXRJSEkrSGxIb1hU?=
 =?utf-8?B?b2lGWnh5M2ZBd1J0K1ZNd01lUnh2UUdLUWZHbDBMWW4yVmhSL3NLbzJkakhy?=
 =?utf-8?B?cTZDaUFQSTFUeElsa3pjUUgzckRkYjVSVVNFSStYc1l1V3AzWGpoQS90aXI5?=
 =?utf-8?B?bmtrL1FZL05BNlhvZEtWRzZsMVAxUlFTcm5vdUVKYnBsZEFtaTkvc2FvVDBo?=
 =?utf-8?B?Q25Wa0Z4YU9vTXFFMTBGNjNYNlZEZy9SRVIzTDVuWm16STVpcGpFNEFpUzRi?=
 =?utf-8?B?dEM2dEcwUU1wZThTMGdVNjZGMllmbkM5enJ0Ty9mQlhnVVBpMXVvN1doaTFq?=
 =?utf-8?B?aVlGTkdOM3N5UDYxU2FvTldwSnBYZDNFaDVieEoyazdjaWhsSC80a0t2eHV2?=
 =?utf-8?B?SEJjWTAxMVlUcXBCcks0RnJ4Z0kxR1BPamcvWHFLTXhIR2tTT2dLbmpiZTky?=
 =?utf-8?B?bll4OUJ0MDBqR3hxYXZuN096MXlKM3E5ZllQQjhReXNXQm16YlczV2M2azdq?=
 =?utf-8?B?RmhGeGtoS1VrdzZ5QllwalVMYU9jWGk5SGEzUUF0dnZsVmVHaHBiTzRHMS9o?=
 =?utf-8?B?d2pFbWdOQWJrUDczcGFUdjBLWVlkVVBZOWhaZlQva0d1S2grRHdMRW4zV1E2?=
 =?utf-8?B?QTlIS3FweGlwRE1TNWh4Tk9MNnNuM09oZ2V6bm5GRVpQcmpZdjB2ZE5LdG16?=
 =?utf-8?B?TkJLNVp5L0FYd0taT0ZrRndsTWdzeW91ZnZKYTJwYzRrejhlY0hEam5GSm5Y?=
 =?utf-8?B?dnF6ZWNZL1FIcHhSMVpnSzFNdHYyQWkxSE5SVTNCTGlUWkVpakQ0dzl2WG5S?=
 =?utf-8?B?bDd2NjlBcHRPTnZidVZURHQ5a1UxTWt4NGR0WXBUVmIrWEFVZ1hmekREM2Ju?=
 =?utf-8?B?bGVOUWRRSUpyK1h3cElsTXRLaGFnKzNPUWk1bVhYVHZxU1FGekJ1MGM3anQ5?=
 =?utf-8?Q?43XEDvOWIcrPq6urzNHTd1X6N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf98eaa0-2fa4-46fe-0626-08dba6d87c13
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 08:34:53.1192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSwuprQwJSmo4O6ymJHITGCYbXqWvDoijLCVX0aqjEVFXdA6feOmXugqIeKj3yA8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 11:33, Dragos Tatulea via Virtualization wrote:
> As Eli Cohen moved to other work, I'll be the contact point for
> mlx5_vdpa.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a5863f1b016..c9a9259f4d37 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13555,6 +13555,12 @@ F:	Documentation/leds/leds-mlxcpld.rst
>  F:	drivers/leds/leds-mlxcpld.c
>  F:	drivers/leds/leds-mlxreg.c
>  
> +MELLANOX MLX5_VDPA DRIVER
> +M:	Dragos Tatulea <dtatulea@nvidia.com>
> +L:	virtualization@lists.linux-foundation.org
> +S:	Supported
> +F:	drivers/vdpa/mlx5/

This breaks the alphabetical sorting, need to move this after "MELLANOX
MLX5 IB driver".

I'd also change "MLX5_VDPA" to "MLX5 VDPA" for consistency with other
items in the list.

> +
>  MELLANOX PLATFORM DRIVER
>  M:	Vadim Pasternak <vadimp@nvidia.com>
>  L:	platform-driver-x86@vger.kernel.org
