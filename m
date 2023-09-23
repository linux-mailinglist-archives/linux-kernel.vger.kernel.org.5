Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621007ABD9F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 05:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjIWDo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 23:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIWDoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 23:44:24 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2128.outbound.protection.outlook.com [40.107.10.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D771A5;
        Fri, 22 Sep 2023 20:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNXZ9CkFkn6rbZ/i8+t4MUAy4HR81uz3u87ufb9TEPyCsT9gQsT9LkXMRl8UwLYkGSv/Zz1mtOGWKhqVjNLNJXlcTDGlf2YjsePOIvYvWbWW276Fo40T4r0ke5td2gRrcleH1OyMa+LgsrGMvL6tKffzkqjrkGddP/UdX2+9kAvZEenlpZnYYpXLTfte7Up7/xJS8HVV1wBiEIonwJVckOtGoRNdMse2WX/zKx6icksfuvEHA+UoEXrcpvdZzlTO2gwlD0wt+kkrIOTmRUPlxw1Ol96P/TCMC5Is9+8eh8lvWIJJG9gm7nADkmlR0PrPaARsxBQCdNgL5ptGugeATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esP9VJu+yggbsgs4J5u9gvpAQrz11NA5jL5d5zmBa7c=;
 b=iiw5XmNVFtqzzqCukaf3JRvIbJMIUxIwlH81VeXvuhw/621d1hKQWeqEJbdarhHAXNkHotbg+EBNr/aN7WtGyXTWTS4jtwYmIDATAjJfZM3PCP6Zkyeh9Yio7ucKBM7EeyC01z+sUpXpkIuQ0Hj8wOxESClb+AzlSXnc5VX1xP8i03J453V8VvBztJvTs0GIJnFbYObYpXLw18n7mGNnf8pq08FhwgEM8MmI4PV8e86XIT6oRyjXcowYyZdVdBdLibd8qvLeSQ95HLfgY7vVJrJWYdV87aE5J5/OnWxFnYh9CxR72SiZKQ3GuUoZYYHCzGEygwjxjlnN06N1Kgm9aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esP9VJu+yggbsgs4J5u9gvpAQrz11NA5jL5d5zmBa7c=;
 b=uJWbAnb8aGhDF2C3qknTaue/CuvgjCfJDReGt4Oj91NfbHZJ3ymOFmpO0HMH+Q5npqMacR7u/dSvwWyL3BL0iwz/I9odZ+EDTlF2yTLax+1qPV7uK9NRUEF+GN42Q7eODaqqtK2ubLOvwQNfvzZ5Dk6s6Ljoh1GwFgiowuB7BAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6248.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:180::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Sat, 23 Sep
 2023 03:44:14 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d%6]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 03:44:14 +0000
Date:   Sat, 23 Sep 2023 11:43:56 +0800
From:   Gary Guo <gary@garyguo.net>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: fix bindgen build error with fstrict-flex-arrays
Message-ID: <20230923114356.537aa84a@gary-lowrisc-laptop>
In-Reply-To: <20230815065346.131387-1-andrea.righi@canonical.com>
References: <20230815065346.131387-1-andrea.righi@canonical.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0102.jpnprd01.prod.outlook.com
 (2603:1096:405:4::18) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 74678a4b-c026-453e-f065-08dbbbe75b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2zZHDmJ5hQcRP4AJtoYimVpRjhFl42FZikQyYlChx9AEd7mzAO15d7SVbyT8l6kWLejMw5x36lRq32QZ54grNRTqbkEeEY6BSiR061d/7EfXK8g6t0aCbnncVuwPUOZjq4zyQ9M4I4qV8taFeK862gMMeLktpfhfPQmM71XBJY4QyCNmUQZgO0OYixhipmgr36TyS21NyKQzUmPc5PhjWsJCtsI6uG36A0IbNWhNbffLd6wBZJh+QmVXHtNucr+oXka78vpKvjZbfh1G8M+VeQKAiTsL8cKelMrI2V2YbJqVV3YXACiN9MT7TmaOxtc+fapmhKMbT4puNcPHyyx5hQXsDzavKBFEVdVz/wlMn89Qy7V1teFqgkD24SjAmC8apbONLH3G+UW+xJGczz2a741ByOfVNDurdnPBcIu+iSj+lQ/NxHa3g0E+jZe3c2DMNzGaWKkgzXQ8p/3zKdnPeUf+kY4YChRZPz5Zola3fuVCny00hu9IIak84qqf3QXZIaH73tykOnoMRjHJyhfoS7zPCtSFawd78RfwSghhOjR6FiTsQpU6JDqDQIwSHII
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(39830400003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799009)(2906002)(7416002)(5660300002)(54906003)(8936002)(66946007)(66476007)(66556008)(33716001)(478600001)(6666004)(6486002)(6506007)(9686003)(38100700002)(6512007)(26005)(1076003)(86362001)(6916009)(41300700001)(4326008)(316002)(8676002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s+2Sy8GRYsk2eb41cRTxWBiq3uWamcFl4V+By96XkvS8u7igeGgLlGDkqQ7w?=
 =?us-ascii?Q?MOvFTGYoutoh3LcutepuUTFreqkgiufKM3AJhssqJKM5HVLh0rIG9CZERMZF?=
 =?us-ascii?Q?YWreoqCPntYoUC6KiLAeoASQmjFhDeZyBvvcT2Knt0e0ymEdtDUWx+8sfnCg?=
 =?us-ascii?Q?ZrNKc6RSNnei6+dsW9eom2UeelLAkwjHxkwQ+6Rvdk/C2+PIr8wKSc6elUBt?=
 =?us-ascii?Q?MvcHIhOHSO3EOdvVV2ONMrWeXBlsJPNC/OHuq4+ziVsW6jty3gUmgk1/VqYB?=
 =?us-ascii?Q?GZZAHvdMtOJs0kSmBqPWEJlhMlLPPTg+e6s9AUM4RglF+oIguT5PmQgawCgv?=
 =?us-ascii?Q?FuDM6qF72zGOICHUyWeGgvAFq/KV78Mmuz17xAKn36ZFBTxnKBM9jYCY/nJW?=
 =?us-ascii?Q?/Sb2gxTZ37oENw/q8mk1JnloUd5r/sJZdOCu6fTqkqsOGO3T6lQ2PSwhmR/O?=
 =?us-ascii?Q?idufH4eK1JujnWBLE8Bi69Ryf2Ur1bQ+cOJL7CC0N4IKtsn96cfDeWPzWU4n?=
 =?us-ascii?Q?sYRDB/nlyUWhY/1vP2Fw+4FSrXk5ys/2Tt55eFnOeDpQeLQ2SuC5PYIXRCVD?=
 =?us-ascii?Q?LcwPyLf6TrFCkEmT6ZGdj5tMRyWyoFzfTXlEJvy9cUd4a+hiWSLouoGK0vlR?=
 =?us-ascii?Q?ifHWNjNJQAErAuaWtWGJWdZGOsh6s4vHP+Y6K0GZ1qKKzVda4Nzx9RDB0yG0?=
 =?us-ascii?Q?NZDpYhuhtyJ/qGJIjn+F3qLb+YxbufApRt63WDI3NYe8sfLBrjoQfwgui9Tl?=
 =?us-ascii?Q?I7eRo2pHoYsxrfkHUThua0LcpfpOdmP6f5jVfM41TS42YE5ds7Q0SKMFVrfY?=
 =?us-ascii?Q?dxfOQfg6clbeA3ZosyQw2lziJHjcgheHTOecbVVh+5E/vdET9WUzTagBN04e?=
 =?us-ascii?Q?NX7ES6Rvf7Rxro04g1K24XgA/msrlu+OJ3S3g38Jz07XQv8n8qMSIiwyL4fO?=
 =?us-ascii?Q?9bZHhqbgoo5SejooKkiDlxj+44lz+LSqETymTk6znGrN6dgZLdBNIqR8R6P+?=
 =?us-ascii?Q?9/hdSWuJH4PnrTKTD8PJS69MpOv7m91zZ3vZFFMG0TgrXCzTUoi0jNHJ/A63?=
 =?us-ascii?Q?os7Bi6ibJMxGPCNjebUaJh+jc2+esHNQaTA2hsxwBeIUb7mCQ8CBgziNoHjn?=
 =?us-ascii?Q?4af0PDTKy8Us48+Fh2wOpwfHQUskd/72RLtJJe3sMdPAbj34mnEb66p3e34M?=
 =?us-ascii?Q?ZhywRO0obFgS9L3SSrqv8jU9DgAHsvwoijE/+4SoDrbdOQaE66hn1JWwpFYv?=
 =?us-ascii?Q?9N+t6R13s7JIGehgdg01wYvKnG9nV3rocRref2/3k9K+Qk5P2zeVbN3fwnJ7?=
 =?us-ascii?Q?/pmMjowiPjk6q27k7fu9UgbKKVsxL7jp2ga6tArkk3bwh0GwsFNtqD8W6q+3?=
 =?us-ascii?Q?smmOtsNGTe3CqGl8R/KpavJD14pbjOeBqwUNOES5kBqai5+IPRnVWtW++H6w?=
 =?us-ascii?Q?aEOa0xXGiFgQmkTsuaRl8VXh8FGzgCUx9Ajn2hGnGdYFMt52YMvdNZcOpOed?=
 =?us-ascii?Q?3nSRcw3ss8obaW2pN/HJhyM1mxJL1BJFxENsohrg+bq69Z4F4Q6NUmbif1+O?=
 =?us-ascii?Q?C+bwc4t0jFSLow0nETLHN8NziF6LvIqBl86CJPdG?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 74678a4b-c026-453e-f065-08dbbbe75b1b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 03:44:14.4443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUvcuLVnmUqs436H7I4fXH58COL72a1wwBZryeuyxK8a2TE+A+5Mc3m0XbHU1CZhFFOhJwT8YnLM/uBcURypNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6248
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 08:53:46 +0200
Andrea Righi <andrea.righi@canonical.com> wrote:

> Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") enabled
> '-fstrict-flex-arrays=3' globally, but bindgen does not recognized this
> compiler option, triggering the following build error:
> 
>  error: unknown argument: '-fstrict-flex-arrays=3', err: true
> 
> Add '-fstrict-flex-arrays' to the list of cflags that should be ignored
> by bindgen.
> 
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

Tested-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/rust/Makefile b/rust/Makefile
> index 4124bfa01798..ae2f5421da25 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -258,6 +258,7 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
>  	-fno-reorder-blocks -fno-allow-store-data-races -fasan-shadow-offset=% \
>  	-fzero-call-used-regs=% -fno-stack-clash-protection \
>  	-fno-inline-functions-called-once -fsanitize=bounds-strict \
> +	-fstrict-flex-arrays=% \
>  	--param=% --param asan-%
>  
>  # Derived from `scripts/Makefile.clang`.

