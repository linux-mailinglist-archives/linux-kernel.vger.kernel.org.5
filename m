Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2776C7FE484
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343705AbjK3AGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK3AGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:06:42 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A84612F;
        Wed, 29 Nov 2023 16:06:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ/e67xCYiR1/HqTG3cH0ko7mr4armuaLT8BWhMpttZhCL9xcWIFJDne7TkUn6N6gJ8HqWkXn26hvNMCMEykg650m8XezFDUNIBCfryseScYKC4S25Qm4BEZCD+ZxbwM5BlOwVHLNViIsMFALLgldAaHq3n7N07psd5demgxKlWcUiNPhhLYBo1Q2FPj7NLu6xFD/m0EFp0Xo436Yd/4QIuMJ4V7h3lU1bXXDiD1+7lwJybWfQqWmJAmT3Xg7pY1i89wytd6QhtXTsLvExYxq65N/xRFLuijjjTjDWsdVKibWufyoenasaJq4gXvuBulehqnxoNHnoOVw7x3oGK9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQjrOeuPLKQihTpuRzSLI/m7HFPRHuNvOLf/CbCM9oM=;
 b=R9dleGVMhp5sVfTgbiSX/bH11JsyJGnD0W1zjalcje9X0Lv8XH4JpVnlCKaV6vX5IcQSih74rvUlsIAyKSUy7c5Fp0rX0t+8sicsmKRJkzV3Um+66qZ3jxpOGI8tXw9SbHacp8uzlXVE453PaprFMq1REErvd7tAtY/cITnvafi/aIV1J7OllxdiNsx8T1uboTGV/RlvKxpa+Cy+quEY/B3wH6f4S/QagXANJZaB8yGnGx2YhfdDlcodb+/SyrDgewB9YLQ7k06mGLzpL/UC9s5l0z77W2S3m2eiUjWEiKVRR5vU8CvVT5ZhUZzWbzbjqVZTkkAU7ilQCqgxyuEbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQjrOeuPLKQihTpuRzSLI/m7HFPRHuNvOLf/CbCM9oM=;
 b=YUmEDLhGoxV0Q/ZwVC7Ni+wPCFjsgjCnHQV4RM8eqUBZtUManwG1De6SsrplFoJNcPJPSAHoxfwmH/Rtdq+HfPHWAeMSXBQRb2wwfKovVhV8wZCzdwpj8rrxwsk628Uxx05nOtjY0SOtmLJNaIcKKerxwztj84eV2BWV9aGhe8Udou6Tp68aqxb4u2XflJUws7sX6u3BaFt9YWs15cMPDIZ5+D47uheq0tc1c/4HJRK0eQQidzXaCSUcpOWiHAMyV1mfmqB5GJBo+/vDudfsmzzoPwCQLSYfV6RTGfDvSkudVW7OgbA3zV9GV9O3uLYPOQXAzKA2xrxsYmsjc//ZYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Thu, 30 Nov
 2023 00:06:45 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 00:06:45 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     =?utf-8?Q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
References: <20231120121440.3274d44c@kmaincent-XPS-13-7390>
        <20231120120601.ondrhbkqpnaozl2q@skbuf>
        <20231120144929.3375317e@kmaincent-XPS-13-7390>
        <20231120142316.d2emoaqeej2pg4s3@skbuf> <20231120093723.4d88fb2a@kernel.org>
        <157c68b0-687e-4333-9d59-fad3f5032345@lunn.ch>
        <20231120105148.064dc4bd@kernel.org> <20231120195858.wpaymolv6ws4hntp@skbuf>
        <20231120134551.30d0306c@kernel.org>
        <20231129210959.19e1e2b7@kmaincent-XPS-13-7390>
        <20231129203700.ckpkc4r5bwwudwpf@skbuf>
        <20231129230034.7301d8b2@kmaincent-XPS-13-7390>
        <20231129155613.58c4b93b@kernel.org>
Date:   Wed, 29 Nov 2023 16:06:38 -0800
In-Reply-To: <20231129155613.58c4b93b@kernel.org> (Jakub Kicinski's message of
        "Wed, 29 Nov 2023 15:56:13 -0800")
Message-ID: <87a5qwhzox.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR01CA0010.prod.exchangelabs.com (2603:10b6:a02:80::23)
 To BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 077515de-fac0-4aa2-e752-08dbf1383d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FmvsM3LX8puOqixkiaMrI9yI3iT9FFX2HYi+BVvKGwqTQSYVlrpfcFURedIl5KvwJKnn88f5PoYz7aJcIqe9AyOT6P1efLbKecrTOapy4l6W3t1WIctMYPctCkGClk9/Pca1idmX/HmNEqsJy1W9+1OD2WI+Mvz5e1Lbqwupm9wb8xHUdng/onvlTe4m3RHFVJKIc80/Wagi8YI50JsboFvzPfk4lQnD0dGkNnJBOf23qnTWI9oW57W9gPlCXCNUlPfZJ8ngBYDg+Ch8DijadUDWFJ26p0Xj9J6IcWvm0uMgCOi+3vAilP9gPsCTNL1j2DeLGi2B3V0rhFlCmR8w/HADCZDZCCeA74roy9mKEqN2m1C6NEs+fHbll5546bAXv7fYbN59mb8Cs2fRzL4wVu8iMQA7/fy4QbbNr4MrkIppDOqcotbFtydwB11g8QtR2YTyECVlJSBCWWoRVaMrDcOocJh+4x15lobVVXhIMwbnhMQgPiOk5FcKs4afcohWPVAwxVlHNozmtrVCv8mSfz01b8U9s1AyyMVojyGxwm6Me+QCI51/VYG/+owSTDaoRlH71MxYEgI7McsZfdjLWjceCEqHDbQyFPP1+L2q0adfmExpr+0X2S2ci1nroe75
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(316002)(202311291699003)(66574015)(86362001)(66899024)(66476007)(7416002)(6486002)(66556008)(8676002)(8936002)(26005)(5660300002)(4326008)(36756003)(6916009)(54906003)(6666004)(6512007)(66946007)(2616005)(478600001)(6506007)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym81QW94a2d0VDhlVk14b1RJQzNzcWV1N0lOS3lpNnEzQmI0ZThUaEJ0Vmd6?=
 =?utf-8?B?b0gzNStLM2o4alh2NFM3SUlLemhLditqdzlTaG14MzNLTWZjZGZ5M3Y1b3VU?=
 =?utf-8?B?N04rY1JielNveWx6TS96aXErUXo4Y052OUpVNi95QS9vVDlMbVpaRmF6d3hp?=
 =?utf-8?B?S2FLMVlIRURCVEtRSFRub3pBays4N3N4dkRLTmpJTWxkVGdIeWM0Y3hlR1FR?=
 =?utf-8?B?ajVlWVZhMmhOZHQxNENaNHJUYjdMQnAxS1FOaWpVTlg4anFuZjF4YVA4bXNB?=
 =?utf-8?B?WkN5V2NrTXAzR3JtSVJBRU40Yllka2QxQ2Fud2Riend6c3lpM2JGcWxySmhV?=
 =?utf-8?B?TnRzLzgwaTJTSlJDc2R0Tks2dHZCUVJsSmhNR3o2Slh0YnM2S3lFenVrRk5p?=
 =?utf-8?B?VHRFdW1JemtMTzg3QnAyWmNOOGZUM09oY1drUGNKS3pZU2NndlA4V3U1c0F2?=
 =?utf-8?B?VHlwcTE5dXkvYTJBOUFvYkdQSjZnVWMzT1R4bjdqWWJ3eGFUdE8rL3l2VlVq?=
 =?utf-8?B?a2tVUlY5dmorTTJZTTI3MFkwcysyU0MyanMweGpKVGxaMjAyQmk4VXFibUZF?=
 =?utf-8?B?Q0FOUTIwQ3RaNlJIVnNkeGVYaFBtM3AvV05Wa0c4U3dwcy9qZHdNWWQ5dW5S?=
 =?utf-8?B?YUdUSzlrZUxQbytzWmlUaThFemZqSFZJT2VZVXR6MEJRL05qdjFUSzVsWk8y?=
 =?utf-8?B?b1pETmJzTHFuVWtQdFhLaXB0S0U0NXF4QS9WYUF0ZUx2OXZqSElwMy9DNktZ?=
 =?utf-8?B?M2w2blFzbHgxc1BXMnFNNTBhU1FjekE2elRUSFVlQ1hZQkJzUWVLNTdrdTJU?=
 =?utf-8?B?ekRISGR6VkpGYS9yM1NPMGU1Q2N3SWRkQWIrcEYzN2hvSnAybm95bE5VYWNW?=
 =?utf-8?B?aTUxek9hNHAwbEVka0dMdGJUM1lJdkUzd1A3TGRCV2dEWk0vZUZNZ09OSERW?=
 =?utf-8?B?TVFHczhOTm16WEE1UVJIQ2kvYjFsSmZPMWg5MnRZaS92eVFtYXNRTmZZckpx?=
 =?utf-8?B?aXJtemhxNDdHVEl1WEhWcjRyVmcrUno3dllPVHQvOWNpUU9pYWk1YW9RenVj?=
 =?utf-8?B?U0o1bnNnVXdlUlNjK1pZUlhOS095VldkZDhjc2dqRVUwM1pHa3p6c0owVzd3?=
 =?utf-8?B?VWREWWR5MFNwS0w1cHdZK0VtWTE4TUY2MzlhY21IRjArdDZ2S0FTamZ3UmRp?=
 =?utf-8?B?ZUY4QWg2aEpFUnByS3NoVUZRVk01aWxDK3FDeWJzZ0tWa1h4VXNJVENDRXA5?=
 =?utf-8?B?UmNSZnpLZ0ZuNFNCaGhaRmhMeEw3c0tnVG9CL1RuUTBoT3NaaG1KNUFZbW5S?=
 =?utf-8?B?ZnVpQm5xR21Bc0ZnRXNEUDk3clVMWGRmNVQzRXBMN2hVQlVBUC9zVlRvOXhP?=
 =?utf-8?B?ZCtkZjl1MGVwa0JLL042SzRGRUsyQUFORWo0OFJhV0F0VEU0dE5XMkVTelB1?=
 =?utf-8?B?ZGppZmZmQzFoQktEV2hERy9PeXhhVUE2d2ppcDY0NEw5SDc4WWRrU1diUEgx?=
 =?utf-8?B?QjNzY1JOQzdqVWxYN2F6bjVvblZxMG9nY1ZQR3dCaXBOZEVyUFROYTNldlJN?=
 =?utf-8?B?RGd1d2JXbnZBN1Rsc0NPVGlIM3A1bUc1NHlJT3NXSGpXdVMybG1ZbHNLamJ1?=
 =?utf-8?B?TW5ZNEVJdkt5dmZubDBnWFpMRGVTMUNrU0k2RTlrR2JHQWEvR29VckVHSnR1?=
 =?utf-8?B?T2ZnYmFOR2FiZndXR014R2U4dEVQanZzNDlIemVFTTlObHJiNUJEZXZkdzBK?=
 =?utf-8?B?RFo3MnFCUHlyRVhuWSs4UUU0aVhUL0x5VEFWeEhoSkk3TkNIWU4yWXZBNEJG?=
 =?utf-8?B?QzU0WEhsajNjT1dwbzQ0alMzejIwSGlJZGxrdUpTRFYzSG1ORFZnQ2Vud3ZL?=
 =?utf-8?B?Skw5NDF0aXlybmxoZElzd1dhWlFTM1IyWDV6MHdZa0NITXJkd1Q5eHhoc2pT?=
 =?utf-8?B?V1hUWkJkVTEwRk1oRkNlUXg1Vmd4WmZ4MXJZQTUzV2NRMzdNUE55RGIzVGM0?=
 =?utf-8?B?TVF3MHN6Qjc0TGtXUmQ2MDN1dXNNZzRFM3YyWGpZWDkwaEdPTlVJLzZyY2I2?=
 =?utf-8?B?R05CTTlEaHRXQXFtY1o2RGRuMzNxWWtiQUdkWmk2S0h5UFBFV25LL3FDc2d3?=
 =?utf-8?Q?1yh55chTdMtX1q9CQUWzKH9za?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077515de-fac0-4aa2-e752-08dbf1383d4a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 00:06:45.7048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ES5ZReJ3tqSqWrrLUmLunJBdi3CamWy/281YYyDh+0SwvbKNZ6bxLhhAK1+TcmRiYy4nDkQiKNOW5BxWS8rj6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov, 2023 15:56:13 -0800 Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 29 Nov 2023 23:00:34 +0100 K=C3=B6ry Maincent wrote:
>> > Not sure why you say "not used", though. Are you not planning to expos=
e
>> > the qualifier as an attribute to the listing of hwtstamp providers
>> > offered to user space by ETHTOOL_MSG_TSINFO_GET? =20
>>=20
>> Yes I will, I was just saying that all the PHC would be set as precise f=
or now.
>> Approximate timestamp quality won't be used because IIUC there are no NI=
C driver
>> supporting it yet.
>
> Agreed that we should add the attr from the start.
>
> Maybe we can ask/work with Rahul <rrameshbabu@nvidia.com>
> to implement the right thing in mlx5?

Thanks for looping me in. We were already looking at this patch series
out of interest. I saw your suggestion to rephrase "MAC / DMA" as
"precise / approximate", which we really like for mlx5 devices because
our "approximate" timestamping logic is not exactly a "MAC" timestamp
but its not a port timestamp that has the greater precision we use. I
have a task already for implementing support for this ethtool attribute.
If folks here are open to it, I can add mlx5 support for both modes in
this patch series for the next revision that will entail the discussed
changes.

>
> Failing that we can mark mlx5 as imprecise, until its sorted out.
> So that we have both types in the tree.

--
Thanks,

Rahul Rameshbabu
