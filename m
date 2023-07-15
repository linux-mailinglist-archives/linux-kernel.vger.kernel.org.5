Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC37754952
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGOO1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGOO1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:27:17 -0400
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2098.outbound.protection.outlook.com [40.107.121.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D242E4E;
        Sat, 15 Jul 2023 07:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGdDCZP/iLPcS8mSYRagWvQkNePwp8xXotSKQsKOn4++qTkqVo8chuRuGbTNT7FFYO6SxkdMjxGK9R7Hls1us7wFzM+agwc0lVT1kABJ9Q3uOh3yGssFiGOrQaIqO6WrfneRld/HYLKztb9MPs1CgnCPIMwoEaX9nDKquel3uPbuZ7yy/qMbj+UtcB6rnDJ89PX5Bf6N474zN453TSopSE5tZi0i1suKtnZFo6tRzG8CzrZCLEXIiGKCKhJMHAcPfznNlyYkekQaMEda2qmmY8lgw3eRzCdFnceqiI8Ljjodm+LlunK6JToqmytrE3HZUsqNgz5kxac3CZeGnYwYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5J06aKY3AMnCu/wSDArrPRafU+WoKB1MkpgSCv5zyQ=;
 b=Evo09yE9BeLpqhNWygVQYsBBwV0a+q0iWAkDr0cwfzVmZziVi79JmkNoo+U89iFeyxTYguTcbtbNTCoSphqYWPox7Nz2Ig2voa72hfEL4EsENsAGbPwUaGETQ3lFjW3SRkFsAj8zafiqQg373uLnXgVDEZWxs5DVif0yqUfBuC4k+9rv2xG62sOWz2YWCNZdUl6PVh3IxQJaOJEAmnjiw0mG+nprWmBR5gHnHlpYGNT4de1UYvmGj+RHCbESCCMUwv0d1bllgec35gloPCci98nYNRO8kjVldO1f9506+axqsAoDltBDRJtjLvd40OVAWwbcSqyOLvTmKcGM4vsgLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5J06aKY3AMnCu/wSDArrPRafU+WoKB1MkpgSCv5zyQ=;
 b=gRBLNiBDS397O+bfj40cvsR4bLEp7MaOJa5Sydv3x5UVk5ogBfXUa1u53ZhCyM1eLCTnN2FWsjd3x4L8scpbFcSIJFYucNfBKZx3yo4L2pLA7KA8EQvYcDs1jt8CMjjIUfaxnfday6CMUzdJui3DrNBlm7YGp9dr2gflQhCgT5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO3P265MB1786.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 14:27:14 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 14:27:14 +0000
Date:   Sat, 15 Jul 2023 15:27:12 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH RFC 01/11] rust: types: Add Opaque::zeroed()
Message-ID: <20230715152712.21008d5a.gary@garyguo.net>
In-Reply-To: <20230714-classless_lockdep-v1-1-229b9671ce31@asahilina.net>
References: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
        <20230714-classless_lockdep-v1-1-229b9671ce31@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO3P265MB1786:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a16099-ae40-48c3-b01f-08db853f95af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AhhACxLfIoNTroQqdOplyHoH5EzAnIac/MxBphmLi7fEsWIzfiPeaANcRZLZaJbEGp6TD7EqYxGEvtHYNjRX978uw3gGnsiS5sq3Dxg1CnJn9UXlum7t6Gl1SC/R3XnakTbokrzSTOTHkMOoj8I8C7f37X/BR/vJo5hjevOYNylik8t/L3hcUrAMntVGRXX9/sPDLrctttmIzw/WYNX96iqWgV1PWSeUyT6dePCpB767O0pMbFFMonpUNgfzUCpqSEDToO1M/qmDxRpTsi3s1NnH+jiNgRzRORkaYEb5V2pCEigAlpHVuQ28qw9dU/Jyj+DGbgLwY59/uVL2k19c5FePRltn20DZ3eL+mDOuVdK50EtP4j58+a2yekJuoI0Rg2Uq4ZgrxBzFpft8L0jaswS/JDz9+uz1ASmoNj9+nZo9DaspK8EdYfMhFxiLp9RSiYusWT+qvD8blGBVyHr5EsNkDfHRZmRQW2ep0eIAHx2MjOwR+7UsnWczh67XGM7COuvI0rJY3U2reuAZ4hT23w44ypDjC0fWaoDRMvpcICd1uyu2slaugkSa3A9cSrC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(39830400003)(366004)(376002)(396003)(136003)(451199021)(2906002)(41300700001)(316002)(7416002)(66556008)(66476007)(66946007)(6916009)(54906003)(8936002)(8676002)(5660300002)(4326008)(478600001)(6512007)(6486002)(6506007)(26005)(1076003)(186003)(36756003)(83380400001)(2616005)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UtIplAQ8YfRrJukoqvtGDlFl41v6op5Py+FzDazaioiVeVkAhqdbBz9Zc96l?=
 =?us-ascii?Q?VGD46WCKCHm7d0z/0s+BlNTQJkp31gvEsWzqmHWbkOcTwn3FVAOIDgFN4Joh?=
 =?us-ascii?Q?uU7Lvm7ZHfe+/ojSVjfPRcTgE6ZqqDqvhefdyAoCfKtZNwmlgoWL9csdHonL?=
 =?us-ascii?Q?Q6DHtWRh5ssaYVoZpBLWnmiHegQuiEhD+WrRkZnopOOLR7pko7iApNOfBmcb?=
 =?us-ascii?Q?Gs/CcLrVMKyExFZnN1XuowpPkrt1Fck5AFZT2r8DOsVo+xD6cvXOFsNLHhQz?=
 =?us-ascii?Q?uWVpEzGyGsYa+IU8AnmurP7B2bQ/9FWN2DivDhSY3wYD7h5iOXQKwhHh4WUS?=
 =?us-ascii?Q?TNNfQ6G3RxSS7k9HoMyUFB9kw1+5BFc5dmhbtOFVvrikumDAUH/OhaBr3OTH?=
 =?us-ascii?Q?a2inm5PVKU3IyUCJ5VffQcMPA6v7OW38Gp8kfDGvI5+TGbS1KjlGRPWc1LN5?=
 =?us-ascii?Q?yT55SUCubdmPOin5w0vU4KwynkZQLUDOE3Ai08qBHX7A6WXbjpfYOCaJ4WEH?=
 =?us-ascii?Q?obCp2i0EpjVTBWy8AsJ9nESX1AJwsRHa7Jm6S2XyrvZCJpCvZK6VLtjSwKj9?=
 =?us-ascii?Q?BVciMiBpZqAfjZ0Om6chQFsnZgg1CkX6j6jAuHP/kFKwpr+lIomAV8ehwYfn?=
 =?us-ascii?Q?mXnZ2EOIIxbZ+svVarHZRVeOhnxnkQPFXA3kTeJTVpJKn98wOgFvv12XGfX/?=
 =?us-ascii?Q?/B4SBWzKZd/c1z9IjYd17VnknXgGTIwP5r/GS19JxPQeNXFnkVdgUdGsNGs4?=
 =?us-ascii?Q?DZ9UCtc1BuiRnqn3sb07Kro9C3rH5vrJqD03DVhPYmxcMeP7qn9tTEiVyOK5?=
 =?us-ascii?Q?kTLGC6cNkOsQiB3m+TJe3YN+X13Yl3m5h1PMbr4HkCdcfeL2m9hWVZ4max8/?=
 =?us-ascii?Q?vXfR1vy1ANzcorKERYKpxZGo3tp4MvVMjuFZM3KOKieakjmaIYVtXPvk+zH/?=
 =?us-ascii?Q?mL+Imz27jvpJ9zMu8UDc4AAxIfbdUr5nT1DbwcURU1KkD7As7uQY8D/ZgfwU?=
 =?us-ascii?Q?XEn3TBBmIX3yYSVx6C14yqxzJHy1Vu70UjOEz1Xvv8DKyzOp9FsUmufM+1KD?=
 =?us-ascii?Q?jFR3d840tTIA7IZk9PzrokvV69vBeUpQrBVcHUCBWKS71y4hyosF3GE94FSR?=
 =?us-ascii?Q?5aXhNp+mru/pKM9/kTGYaN8tf1BYqWCgtpAMjkkSubRavFshJShtrwdQsNBc?=
 =?us-ascii?Q?cc6lCNt9nBarq/MFYTYMHBk64plogvfQWWMAszJ3Kz5o6eKi7564cWnC5I+o?=
 =?us-ascii?Q?znRJPp2e8PiDnxEjnHot69DihO1v9WGx/k4QOhEBjzbZ1s7zPUE8sdby8OtG?=
 =?us-ascii?Q?VNYWvQVtT3v61ZOIGHqe5C7PQ4h2hNPDOpiG+dNvyAl/FVZHDxNTZg9KXj3N?=
 =?us-ascii?Q?9STyq/wOkq3+y+nnVuQmaZKquIdqnKu0Dkt8HS3Em/c5XxmzdvbMP/GFR5Cx?=
 =?us-ascii?Q?IFsDUsqcg65nPhBql0H6catM5GQUxHxV5P/WbbIqb/EFqI2zJTvPbgHlhQgr?=
 =?us-ascii?Q?t85VfaAkXT8Vgxo8sr0SxHa7tk1qZxWKCCkVsCIm7g3Cn3n/ZrDY5YGeOXzd?=
 =?us-ascii?Q?wDmxnnBCV6VH3G+nAAGR4LyUXP0EP651oAmQi1Sf?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a16099-ae40-48c3-b01f-08db853f95af
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 14:27:14.4966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2h8fo1qQTU/22yVy84huZY/WI3G+1K63IyO2ObcfJ7Aka/1tk2C4MSXRRcjNVQEfU/mAT9/zw0yZwI6doTo2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1786
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 18:13:53 +0900
Asahi Lina <lina@asahilina.net> wrote:

> Opaque types are internally MaybeUninit, so it's safe to actually
> zero-initialize them as long as we don't claim they are initialized.
> This is useful for many FFI types that are expected to be zero-inited by
> the user.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>

Reviewed-by: Gary Guo <gary@garyguo.net>

I agree with Alice that this patch can accepted on its own.

> ---
>  rust/kernel/types.rs | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 1e5380b16ed5..185d3493857e 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -237,6 +237,11 @@ pub const fn uninit() -> Self {
>          Self(MaybeUninit::uninit())
>      }
>  
> +    /// Creates a zeroed value.
> +    pub fn zeroed() -> Self {
> +        Self(MaybeUninit::zeroed())
> +    }
> +
>      /// Creates a pin-initializer from the given initializer closure.
>      ///
>      /// The returned initializer calls the given closure with the pointer to the inner `T` of this
> 

