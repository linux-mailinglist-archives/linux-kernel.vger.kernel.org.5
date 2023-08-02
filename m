Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A9276D62B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjHBRyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjHBRxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:53:54 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2116.outbound.protection.outlook.com [40.107.11.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0523C30;
        Wed,  2 Aug 2023 10:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHmMo7/YQlBJB+9YNB72xHoHOsU7vQ1RCubbQHVaImaWoePdAQRGZb/VUBdH33WNcu8jGM1AtbTUCqIF4/eObD3liVznlvl8kkTwI+31o5+IYtQtKEFr0tZbG3lYBeHbcGw6EhGpThhB6ehZWHfCSeAG4gyVV48kBTqMDAxmQMSUo7CVVx9AMCUfWGQwmS6xGDb4mN0KYknCRARy8MRavEOYVw1F9vsObt4jVVR5MOoGGmgEUz8x8ZpMoHB8rS9xtEQeTc/SAyazatbsknZ7q+6H+yEAwAnKZwlVRR1AXTh/t3MFWaKFdGQf9YN/hPUAnlGVyaLvhYgTs5r3DKV8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4C8UVc/tFlg1yIiznblANxE4sHn65OIce065fZn5UE=;
 b=VgWM5wqtI82jDRCdAO5LKHlfmJFLXn1MISaAaOpd+rDsZTYQzZxF4YaPYZc1X8OSGkub7eIXADWy4SpDbUi6eegxzT5wuzegydbn5lElTAVN9rYpccDDegrdwND9oQBvYmAPMEjCur9E/XU9zVJExxV2e1c3AT4h9lrdnpEaMoSJlyihHEKS5IX0TUCqb3yBFQscjyVlw/CLiB7qBtybFq97NzBPSUrs6zgFNCfB6HK8Nln7ZQPg/ReBQVhYHHPfdWClvM2i8bLbFiyktYuRNIT62mUnq/vse5qir+x7ndc9LgSiQfRKYKPTxKjbv2q4gJiDwYc+qjmvoJNFGK5I/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4C8UVc/tFlg1yIiznblANxE4sHn65OIce065fZn5UE=;
 b=bSxLRVbkW6Z90IPu5N4cd0gFHoCjLu6S8o7xmjQTZumgL+1o9SEpXVu+dnOw5fO5LB+LbjKexMDwnxtqJKj5u24ooxfGOEW6BzSyj5Ed7fsGIAANyKwc+4oo4Hz5gaRa8CzAUaJYidE5xWFSwIMO1yHGyJA476H8qII4IgBXb+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB5396.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 17:53:00 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 17:53:00 +0000
Date:   Wed, 2 Aug 2023 18:52:58 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 05/13] rust: init: wrap type checking struct
 initializers in a closure
Message-ID: <20230802185258.08a2a8d7.gary@garyguo.net>
In-Reply-To: <20230729090838.225225-6-benno.lossin@proton.me>
References: <20230729090838.225225-1-benno.lossin@proton.me>
        <20230729090838.225225-6-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0454.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::34) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB5396:EE_
X-MS-Office365-Filtering-Correlation-Id: c89cbe1b-e2a7-40b2-6263-08db93815008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3f8LDcG1d31ORZaklXXVDg2RA0fXnMJOvmd3XLO8prgZ3UQr58t7QTniAZe4bgeRIX9+fEzME92qB9GVoROvXlEJu+V/+8J4Yl4F2457yMKP+gX1GgGmdD96EqWOFRdgZ+czUz+oxPnCBOa0WLAbyRkBC8AQ7LjiK8LoV2qIiYBqoDKqhv8Op4f8hUFJTeQoQF5vd3eS5GvTljNBiTf2KGlDeKoy8w0BWSy2nYczTWIiah4+9m0FtbiS8/rgiGPBGpq5Mc/VfSRW+GWxlLP+brwdwB9x6sY1N0Ats/pjXffpwK2bx4Y6eHqsLjRGhfn7f/Lfo9cOKOw/Y4T70pq6JB69YFbqBGtIAf4sOTw2iU9T/JVtHFYiHV3bRRkN0Sq+1E7/IGO8wg3pTsGQt3r5xKEXdXsDLLtiiWe6IirmOfC7oKML3fREwupGd2SZ9P5emWx9OcwFaMMu41Hvi5OvRbAPif5okvmlZvGlMMBHnMDjAplPKRwxkI/mFciPpHzYwXOMkGn0qMqCXqeeRWuwPbYOyStgqX9D4YdpmIB3ac/HFp2WhBrTvkvTIRAU/Je5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39830400003)(366004)(136003)(376002)(451199021)(2616005)(36756003)(6512007)(316002)(38100700002)(478600001)(86362001)(54906003)(66476007)(66556008)(66946007)(6486002)(4326008)(6916009)(6506007)(1076003)(41300700001)(26005)(186003)(83380400001)(8676002)(8936002)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jeX6ny0p814RAWdVUD9jOPKADrIv3WetHvFaE3u3xdD3ra9F3PV3EUZRhWrI?=
 =?us-ascii?Q?bx6Id+qg8mP5NB0VWMj0syCljO/SUwLk+Qn1TQwqnHteHm+MwKq2n7ZhEQxK?=
 =?us-ascii?Q?DcXSTCk4xTBrMsbpSqo6h2wpThVfs5kdukAuv+HIAe4p3V3xhdwFSJEfOMJ1?=
 =?us-ascii?Q?Yx5NLcp03oSG8yl0txULEQj+M+1VnZ8AW2YE0mNyCmOP9EA+JdDmSiwuKEyv?=
 =?us-ascii?Q?dMiGNEUUBkXPDBbS9LIv+udS4bhw2X6C2U2WuE9BYKvJSIcwGuw8wUWssFVR?=
 =?us-ascii?Q?6G6aJbz6/fA3eOwYjoc+pj5ZGofcxY9qxkEtmUEPNRNqw6vSecF80e+aOkvI?=
 =?us-ascii?Q?2LaY3DBPxtAZnVSTkpJWStZeCoC90KL0L8+jDz8g/zg8aVz6Fj/ChZYXfcMQ?=
 =?us-ascii?Q?0bq7ebGExFv5bBPCVf5kcOo6aMFR3IH4WUV0DDpf1NaSehVOaUGjRlK3jT91?=
 =?us-ascii?Q?OOWOaaIbbRep+pG2jb/s8lguzIgV21KP7UVanP4sCfJAdGFDUdhwOH9G0i7y?=
 =?us-ascii?Q?RqCxQk3XobIJO94IEbwvfQiAB/EsWsDie0bHCchkNefHVOfEtYdW3L8oS/Gp?=
 =?us-ascii?Q?KZhi3dl3YKQXXl5j89hO3T3d7F2z3pQxBf3gXXC+pG6ExbUy+IMRiylEQsxs?=
 =?us-ascii?Q?1R1nnltqGzV2R7xCCxG3lduuDQA70TLUY0P27hJmzfrIp3gBRnVP6x0jOWql?=
 =?us-ascii?Q?pVCrHQvcGYAokFFb0l/OEBx/QjXy7rZRv1Xpo2m0P4FR32AhrblbMwnj7iM1?=
 =?us-ascii?Q?W0T4yecHI8SqHyq4XPq7/3H2SLyhkRAKtcIM3HTwOao2+j/WSfHQUBA7WJ1p?=
 =?us-ascii?Q?JohWaV4ApbehbnLuvcb5Wq43K9NANdRXC5cJ2aXiVPdb1QQfuU4qK3iBJJy+?=
 =?us-ascii?Q?xZ81BrIhqy/ZyAV3S9lLY+FDDCSC1+bEq9/x3fcNsNzcc8QiCEpZX+c+gqgS?=
 =?us-ascii?Q?DY5jFZAYzVq5ASOTVBXoZnJDWbjEmiqxZ+Mfjjsb/yddr9aXyglBWp3lmP43?=
 =?us-ascii?Q?6RN6zDakcwvvuSR4ClOFPGMuXR7ZUxIcqrKqkyeQwzyR/LMVAienMW3B6KQX?=
 =?us-ascii?Q?gqvM3ozeNvs56Euy4iyI4RuoHtfz3CqcPOoYMpflC7KNr+XTOPKJbMWaZnxr?=
 =?us-ascii?Q?m0aZAmPW4FrcuVePSH0mNHg1MVs9hLXW4Zu2K1686H+rRG+iWJhx6OJwFSQw?=
 =?us-ascii?Q?hhvwF5niPgX43OamICVd2o19kdHqqTqQJGvEWEVgj49eZ/hEepBG4bT+uPXz?=
 =?us-ascii?Q?VC6U/ZBha0JofYZ1eDUHSbNiZB5UHMa25mTcDQJOXJ1X0rk05uazJYxBPbAd?=
 =?us-ascii?Q?+TMPBxt6SIOR/WXFOj6QjyD7tPTMcNdyzfdrIoX/DRBj6+9QIKMWHIh9MPlJ?=
 =?us-ascii?Q?T+Fy1VMVODO0sWB9/jFwhqi2bDEQSsr3G7tfCBdJ4QJwRf004LUgndmDG8GK?=
 =?us-ascii?Q?T/2TRiUC9LUgQyQHUw+q8vvBWvvRa28XUyl3ptBtRTawSn4g4yCYfi6V6YeG?=
 =?us-ascii?Q?XJZ8OI4msbiV2/UZVruLBDebLXuW2/WzNaKjwOvURXjMEeBc3nVByJlQwshH?=
 =?us-ascii?Q?QllNT7KXWtddKsdmuBpCP69buLW5rOwwnE5lT0AZ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c89cbe1b-e2a7-40b2-6263-08db93815008
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:53:00.7274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNj6Leevx7ymOu/YcatgPmwkpwBrw50tCltZ79OyW0+0Dno82Ws8KNyWw4DxGfNdHiCjI7EZCKwGHjHBrn6/aA==
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

On Sat, 29 Jul 2023 09:09:46 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> In the implementation of the init macros there is a `if false` statement
> that type checks the initializer to ensure every field is initialized.
> Since the next patch has a stack variable to store the struct, the
> function might allocate too much memory on debug builds. Putting the
> struct into a closure that is never executed ensures that even in debug
> builds no stack overflow error is caused. In release builds this was not
> a problem since the code was optimized away due to the `if false`.
> 
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> v2 -> v3:
> - added Reviewed-by's from Martin and Alice.
> 
> v1 -> v2:
> - do not call the created closure.
> 
>  rust/kernel/init/macros.rs | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> index 454f31b8c614..2bad086cda0a 100644
> --- a/rust/kernel/init/macros.rs
> +++ b/rust/kernel/init/macros.rs
> @@ -1040,14 +1040,14 @@ macro_rules! __init_internal {
>                      // once, this struct initializer will still be type-checked and complain with a
>                      // very natural error message if a field is forgotten/mentioned more than once.
>                      #[allow(unreachable_code, clippy::diverging_sub_expression)]
> -                    if false {
> +                    let _ = || {
>                          $crate::__init_internal!(make_initializer:
>                              @slot(slot),
>                              @type_name($t),
>                              @munch_fields($($fields)*,),
>                              @acc(),
>                          );
> -                    }
> +                    };
>                  }
>                  Ok(__InitOk)
>              }
> @@ -1168,8 +1168,8 @@ macro_rules! __init_internal {
>          @acc($($acc:tt)*),
>      ) => {
>          // Endpoint, nothing more to munch, create the initializer.
> -        // Since we are in the `if false` branch, this will never get executed. We abuse `slot` to
> -        // get the correct type inference here:
> +        // Since we are in the closure that is never called, this will never get executed.
> +        // We abuse `slot` to get the correct type inference here:
>          unsafe {
>              ::core::ptr::write($slot, $t {
>                  $($acc)*

