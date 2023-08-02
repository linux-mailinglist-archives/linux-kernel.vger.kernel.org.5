Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17AE76D5F0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjHBRs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjHBRsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:48:11 -0400
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2126.outbound.protection.outlook.com [40.107.122.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627CA1A7;
        Wed,  2 Aug 2023 10:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2vZ0Xevy4XAe6baX9DFp21tNNLHDQ8lYfD7iVrmT4wRcxN7m+764N4zqfrwr9vNhND8j3IMuneKLECeSGhcqqXWlYU8aBCTDVko73DyV5WBEAUmzCZrKihMpxDo7XA6EDlXEaYCI0+WIT9vflZuuYfiL52JNBSUiubg3+RH3ASb18sL7xBZxcmnZv2ZTUknT5LHYTXrjlwoe3SVvU+yMbFA4lZQQuH/hSNLn/LXl6Qy39zKl4oTneg5LQifgqBT6/nvwdqVJspuQndjHB9UZBcb9XxV3fr9Ky2Qe3MWCAm76pqNv7ShQoMInS80fAAcqOpgMLiS6FlMdcWgacEY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hxz8N5ajybGeNWDkqScYW+2hOsfkwikBBBHNWheAIUY=;
 b=FthfSU1Ry11CVVc4OFlp97HCX4oLunEr4a2A80JjYreBHLXPJNkiZsTnp6naG0qlG3deZ6IuISDoHqYdqKPXRTwtolonwBh7/282aOqQ4lIXnd0Oil8xPiB0OaSkdGpDtbz8dH3BeYNDxE90kohrr+hvHEciuXqW2sBW6eXrxcF2eZ32Vj4dVvyIlR4o7lMsRebEh+6/ay7XWAvs7jTkriNAowgoh/p9IPbkO7Fvw+xyTDb1/v2KYIFk/WB6DbBu/rdYJJxiAwqxiYhmlZEYuhe2dasQXHL/0sdrwjE/0nNkM/u4Z9nGrTyoTbrGOYaKidOhxxJgBLZ3LUnINdzskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hxz8N5ajybGeNWDkqScYW+2hOsfkwikBBBHNWheAIUY=;
 b=SCrc95h2gBLhWyTmgpeFTCegIPswJN7AJxFqsNaWVgvMDvWXFGsbw2bBcTpuGM3y7h0/x01indBBAQC6aBlYf3KyO5hoQyV8V7GR3xNdoWiKyrWke6lhhekkYCTAAhEaGlSkyGxma16Uk8XfW9B1ZlRbEEpg6RIKPELodVUqLOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB5396.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 17:47:43 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 17:47:43 +0000
Date:   Wed, 2 Aug 2023 18:47:36 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/13] rust: init: make `#[pin_data]` compatible with
 conditional compilation of fields
Message-ID: <20230802184736.76eb0843.gary@garyguo.net>
In-Reply-To: <20230729090838.225225-3-benno.lossin@proton.me>
References: <20230729090838.225225-1-benno.lossin@proton.me>
        <20230729090838.225225-3-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB5396:EE_
X-MS-Office365-Filtering-Correlation-Id: fada76c6-62a8-4ab2-40e2-08db9380929e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ed1Crj1ZYX8q90PTVrLwMSwbSX1tf+G9PSDE2+naD5PcPBxdgcr/UccYiwSRMLEm//3xs8eMssMAU2VADPQEeOVbmLJxVoEguiaA19yqh5GfGfRMem35BJlUWJV5P6WXm97bVgGXGhrovF0ny4SLXts/6vQDRFMlOZR0qjuIbG6mvLBJ0U3HzmKbtiuLL8MNc6aoFo+Ej50PWCXfBJPJir9pw4KlT8blbiqCp2MI3kPnJccHJuxWsZIWo0ObY7o+tZ/4N794qD9aeMlH17QyxX1AnQ+XVVFhKmC+4feavi8nY6O3gVbwt8lSxwpZCNJRHxmKM7QiBpEyP5pqq5T4ECqL6IgqjnHUt6vYoU6p65FPjFDYYNK6k1AB85oyp5413mjV5xrVsNEPRnpbNeb1+PbuYwKWfnrPA3JFI0DBcZXdMotQrN5F//NiCkZUIfgf0NbvkWjov9SiGWJWGzfvFyDnKtthX0LC6JEAybFFX0g9DYun9sLbWSLFkvwZIk0Z/w1zDK8j1Ikk9UvS5KhjvjVmoBN9QwfoTa4iZQzBYk8FyvDrj81Svqhh0W7K14BZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39830400003)(366004)(136003)(376002)(451199021)(2616005)(36756003)(6512007)(316002)(38100700002)(478600001)(86362001)(54906003)(66476007)(6666004)(66556008)(66946007)(6486002)(4326008)(6916009)(6506007)(1076003)(41300700001)(26005)(186003)(8676002)(8936002)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Qb2FO5okc2Vb/GZuAs9tghMRD+AdB6OnCOycTLkD6/9jk1re+7eWa7P/IBU?=
 =?us-ascii?Q?UKgI3iGlxETb9hAYSfVIpoAEKpPVNj4Jwnk8zSTdfMm1/L//ygWmCTzby2kx?=
 =?us-ascii?Q?CXU046lqE3sm5nRylSy57NtsejIY2klA2o6EOzFrfbQyW3NYbl5J4elunHaT?=
 =?us-ascii?Q?tlLCChSwiO4RIClYFs/dfS2JqhVxP5OsD8TOagtyRzMhxesJ72cXWG6VLiJz?=
 =?us-ascii?Q?T1wQrqpQgtbso4JnH59sJP8AnKbt6UaNse2pypVucRVM/ySzbwzN+QwtcqiO?=
 =?us-ascii?Q?UgpMgZ2Y1+payfj+KG0/ERhh0oO89+w0wkMvds0o1u9NMTZql5AF+H3ItG0/?=
 =?us-ascii?Q?kuZ1B+tvy5rPH1Sw3+DBIMa+QDcguvLb0iRLpO/8rTJk22zDAJF0p75JYtAL?=
 =?us-ascii?Q?ImV7Hy3l3Yh2pDdvu07bTSZEN9b/r8bVbES2VmhaR3OPcT6NOs4g9hpvi9Ef?=
 =?us-ascii?Q?KLYWxdXarpMpyxHxDCgqBxULzTnenY+mkRsKk3SOmfRyGYHm+03akcY4agDw?=
 =?us-ascii?Q?x1VHIUHSIhKAoptoo8zKIB6RJhHC2HSYWLV774G06weK3u8x29TPbogYyOWH?=
 =?us-ascii?Q?PAK413JNKsSAevF3fNU/vRSIwb3XIB4mrSvZQh+dESvMwvU5NSPwGyfUvVCf?=
 =?us-ascii?Q?q71JX2fO3wWDkGXWmO9NB2tCzg3JCH3phi94M910nm4gdr/UQDCzbuD9S5vq?=
 =?us-ascii?Q?aVSa4AkDH+LE9vdwHp3Z6qD9TZ9lU2+y3s8z2xvXaGaeqUU62kQvN3oYHA9N?=
 =?us-ascii?Q?OJKbIayq+4f6P9iw9MbZYys6JXDvGe+yZupOQJBYcuuDa3UcTInGK/4uS3gX?=
 =?us-ascii?Q?18OKeQGrLXBXeDZuNHp82YtP8MwXbRXlqkuntYJVOgZpAq+CcLgmd4GT5IgJ?=
 =?us-ascii?Q?lkxtmyQCB4uJqobsPPUcge/mK/dncL7f20GOCj634bjgivweuYkFWkA6EIrm?=
 =?us-ascii?Q?W4dOLBbQ8pmkXfcciJCiZuMmnOZdJhb4LcLWsok+dlrU4GUZn/Xz7z73r87h?=
 =?us-ascii?Q?UWHF2AnlA5yGeM4QqWqmU4ThqWTAudV2SICDZvTJpQubNO+AwPqRTPl/Ijeh?=
 =?us-ascii?Q?nRSvC/k6Dgt2OK2AgFoDOZpGkA+6tI3wpCimHaZ9/sTYhAV4AAmOJMbSCCzm?=
 =?us-ascii?Q?2CXi+QWGXVkf9JUP8TzXihnIjggdyvyPV4Jjf+OZ4opTUT+rilN9HM9MJ329?=
 =?us-ascii?Q?f3Fr0BYsrPAiWpqvmIWkYqZayzrmcQY4NpX0XD0HmhuWmYxks7XJ5ZdRZAoh?=
 =?us-ascii?Q?hGyBFQl3NytVOzkTXiLGPXv95/cOH76Rg2AsbOC2mZf0IaF7rVDK2vpNll3B?=
 =?us-ascii?Q?EDr7rpWM4q5DA9eE+p1AmMv9CSMMJSyd290a2ZBZZAySZMaK4VUU5FK6LTgs?=
 =?us-ascii?Q?lr+mpHPtMF6RxJyu319RIidT6iMZokvwooCzGgcHVlmqbkiUtjxUVj4MtNG3?=
 =?us-ascii?Q?yd3kuML4bJEdJps/+t7XewnRQby4UHoz2XHgOLFEkAoiDozNQOtRJYwgFXbI?=
 =?us-ascii?Q?5ZWpjssb8eaD3tFo83bP0YLOJG406EOClmMX1Gkj1KMcRrlPh0pO3O8CHs+q?=
 =?us-ascii?Q?MzQIj3AfttbiPCd9KLJsLmOvGCAKou1HSuVlvfeJ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fada76c6-62a8-4ab2-40e2-08db9380929e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:47:42.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8mRluUgqCEx3wevsxvoqikJIy/evM00JxLw07RE5qDQioJGqGNgiN+n2WXu5WLFE6eKqq4e8gQ3xpvauF8RyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2023 09:09:23 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> This patch allows one to write
> ```
> #[pin_data]
> pub struct Foo {
>     #[cfg(CONFIG_BAR)]
>     a: Bar,
>     #[cfg(not(CONFIG_BAR))]
>     a: Baz,
> }
> ```
> Before, this would result in a compile error, because `#[pin_data]`
> would generate two functions named `a` for both fields unconditionally.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/init/macros.rs | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> index fbaebd34f218..9182fdf99e7e 100644
> --- a/rust/kernel/init/macros.rs
> +++ b/rust/kernel/init/macros.rs
> @@ -962,6 +962,7 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
>          where $($whr)*
>          {
>              $(
> +                $(#[$($p_attr)*])*
>                  $pvis unsafe fn $p_field<E>(
>                      self,
>                      slot: *mut $p_type,
> @@ -971,6 +972,7 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
>                  }
>              )*
>              $(
> +                $(#[$($attr)*])*
>                  $fvis unsafe fn $field<E>(
>                      self,
>                      slot: *mut $type,

