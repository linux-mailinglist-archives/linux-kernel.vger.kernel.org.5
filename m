Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CA37D505A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjJXMzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjJXMzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:55:00 -0400
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2135.outbound.protection.outlook.com [40.107.121.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBF3AC;
        Tue, 24 Oct 2023 05:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez8alrB9izFeNxDO/e7WVbsDdEtR/UNqlGf4cvQ7nqQy/v2SBsc/Zi/iLgkB6uFimEutqrUu9guGBvnM6R7E520bcCz7WqigyX+qVZ6hy+DRQK5J0b1Ydvx6RhhKHauGURa06TL5DVbee3r7jVLz2Q5rLt2JInHvz9G1UZu8D656GiVGv9WRQtt/hydNyowqqzNCRPThiWaH4P+N7V7OLysRcXofaLrAALWT/Olc0V23nwp/sF96eAKqMDJau33rz4O9vqEeXZXvwud/wHezqr0LGow3DClCkIG4UrZxaf1zZHi6vHLHMUCLHNPznAYoWEXxr2t8VCOryOy7RGyeZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH4TUAkmJB8ZpWgOzu+hyrttw/cx+f+zZ0Ot0Grp/q0=;
 b=T4DhBKeY735C/cX+s9raaxTpNAN0mgzd8TypRRGsN3Q076OO/ggLEUpy6o/b57kIUAm4Q69xDCctdtFRPj/5BghIWSClLo0OuDPTAYaN+BZc7O4Mq88EHJ/QPuoTku/z4Np4FXj7PqzIXwK1EVyTOe3cTl+8uEGO1y4CAVyRDYcOwNpI2BNCGZMwzCoXoumwOOkmqzs+UzIKijIXjTBCp/9X3smFpUYu3YykvJHh0+75fuRtL3hfZLmUTvSj7TNWXkFzHmUpE5irEsgA1h9RDkeBONLBlpHAhcVk6WwlChQMOS6yO9YcubRiV0gJHhkr8nMSUfJkLViSMOCUfZRaAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH4TUAkmJB8ZpWgOzu+hyrttw/cx+f+zZ0Ot0Grp/q0=;
 b=Q/PX/KXciGYXSsgu8qUwNFQO/aH8tG1CDDPXxsjmvQIaiVL81msccObD5eRDQ1aMatmQtmqXAKSQ0bYRww6pBAoyGwG4zt0rTJUzGCBP2hcPPGmVnfv/W5nw9KJ/i+tGs69O/CGSPYEqzLIh5RDKebEWQNj7rNs+twS3A+BZBhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::14)
 by CWLP265MB6877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 12:54:55 +0000
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6af2:36f2:4aa:6e43]) by CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6af2:36f2:4aa:6e43%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 12:54:55 +0000
Date:   Tue, 24 Oct 2023 13:54:52 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Trevor Gross <tmgross@umich.edu>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH] rust: macros: update 'paste!' macro to accept string
 literals
Message-ID: <20231024135452.223d8d85@eugeo>
In-Reply-To: <20231008094816.320424-1-tmgross@umich.edu>
References: <20231008094816.320424-1-tmgross@umich.edu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0461.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::17) To CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:15f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5186:EE_|CWLP265MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: e52f65b2-45a9-4bd2-be95-08dbd4906bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBHmTL3OGO2R3SkJsHbjm3syM8aFYS99l7509jhohZuhIT+FhtfpjAeLPgpJOI1ObwBU5LVo8ER7MI02k7XwWeLA5IT8Ix/PhfW4gTUpEXJy76oqNvc13Wm9jBZxhoc77QLGU8ZkZc0wm9L59dpztyj/7Otcb34eA9Wm48gqmtBlPALcnWte6FZ7mwAo3zUxXcHe1w+O3IojUqTGGPWaevc+xodMaAZxM4nyLFDzBkytoW5IU4qy8Rgpgd6lKVUFe1CLhMd79a8WrSK7Cgc0RGQJtk00mmo1OF3qMqrBobcT523tK4O0KwbmB9pvm6KMtLFcW2HNc7m1eCAZFkVUeUOvKfBnIpWX6kBI/7JBiuo8JhkbxrSkRsfQ5+I8FzUx5jJldNwqds+intPAoYUWJECDl+bV/JMNMqqDr5YBuHisbPtLSxk9zJyQ0PEBSn+U/5llK0kZwubTX19yaBeBjtxi0GTarqxnj9OCJQIxnwD1cfegr2228ur9zmPSDFlZ6jNG6eNVopZ1OKaUyy4yP0FSQIwVtrxMiqpCw07vQGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39830400003)(136003)(366004)(396003)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(26005)(33716001)(38100700002)(41300700001)(2906002)(86362001)(5660300002)(7416002)(8936002)(8676002)(4326008)(6506007)(1076003)(478600001)(6666004)(66946007)(66476007)(54906003)(6916009)(316002)(66556008)(83380400001)(6486002)(966005)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VeM/wipxsDTPMX5iNHdVccGXss+fvOjvaom23KQS1nPDLF57RqEQc9yo2RGj?=
 =?us-ascii?Q?QvcMEIrKLELx1PwZ0ZXKDc4kQkSRhjDyzaVwnvYTbkrp1JIiBbxdj8O2EmZL?=
 =?us-ascii?Q?pTyp/fw/6Rzfqpi7zY2QnfcnGucy2ew5TtZg1HPWWN24Enr98vpTNXc/MSy5?=
 =?us-ascii?Q?zuDajrxP9oRkZ8KAJhEbxn0YHeqjGDWkNfMuKJ/DNf9vmMq6IMusgBeXAUNy?=
 =?us-ascii?Q?HkxH1rYUoKFEhS6xRi7yvqPEe6sJzu2t5KKsso3715r3gCYeQy6hK3hbZNjJ?=
 =?us-ascii?Q?y4i/IZIiTfQvZ/d96JV5d/+KPc07tgrKUiXzchU1PA+KiouKKrjdWen0VP6m?=
 =?us-ascii?Q?ZxXxiSMDPGl+nX9kCxHrPACov9xwomZlWUD18rjmpkEI2aoSTKO5TploW8HT?=
 =?us-ascii?Q?m+mfk5Cn5RK0mgbDJu9HpdD6XWYSc9UrEjSwozV/hA8eYmIDcNv7OT22N73T?=
 =?us-ascii?Q?qAVNdXfDLokM9mnwSQ+EGAgWWWO8U2UwxDTJ4l2HB8WXSjZu2IP3i8c01VOJ?=
 =?us-ascii?Q?9FY3z7dK6bdd40ibr8rJk8yjMyeaZzlzTGlcxki0bvDZBgs/K+TmMAiwvHz3?=
 =?us-ascii?Q?NGxl80D+IsETG+SF46hPVmwh+m1/Z41RAiqcV1FH9aDpgKUjTI66fGNxsxOp?=
 =?us-ascii?Q?A5HnbOA+7s7AbF+pNUvyG/UQuQmLYNhmEIL668Hphi3+86K8Ppj8oO2kAecE?=
 =?us-ascii?Q?TcGoIWoKGVBSXGzYM2g79mvuPLinPp3jduNhjqXqLtTl1xE4HWbbVzEfluQB?=
 =?us-ascii?Q?+RdXFxUMpJ5Cw4MRjaYdL3MaimqxBTvSL9y73wBLemKKOwYCc/3oGT+C0qdF?=
 =?us-ascii?Q?vD+UQG8VnO1wVqHyClHvh7Xtzv8mlkw2NEjwgGg9kRBaLL+VfxWFk0CQAktu?=
 =?us-ascii?Q?+4+nTMlub32Ib5Of3FHjGl/zWEN/646en3E+jg2IEG7//Zhx0ApCA44aEzHY?=
 =?us-ascii?Q?A7jwfp28WDauHYT/h5DLYq8o/Ch9YrbAkAMUUT1zSXyD2h3gj9mi3rCLfDNz?=
 =?us-ascii?Q?st7x4zaPG4DQAt13fRaw4Jr9cRlMXtNwrYCeJXCzXYmMyUd0TGJNmoHEoAxv?=
 =?us-ascii?Q?o2rE/24Ofc0Pc2x4K8RtGgFhv9jjekQ7ubcJYdTaER+x/Wney+Nn5qYOVKJb?=
 =?us-ascii?Q?YVfmj+mGMm3M2ENHnwGYAm4QhYu1i09ygnjxYh0j7CpjEoa3hQxUrJfg2NZB?=
 =?us-ascii?Q?6fuVAlAXfm4wA45kwYznMTCtdZmFpaWEubfdjGoArCtAgGV4Pp7ZAxSKkenM?=
 =?us-ascii?Q?jGldj9Ww01THhvF5p1hZHlti7XQBIgLAsL2Y/2qHvYDatYyiVMQVOftSagQy?=
 =?us-ascii?Q?XGocDb0yVj+l6xD9AhE3rc0rDJ8Fpv4v/mBl5E4V2u5tBI0gqXHH9taUIenx?=
 =?us-ascii?Q?4iFDpNh0Jw3h9nQj4U6VKeCnM8C1PD0/r/66h0S8lZ7N4SL/JLBcm7K7dve+?=
 =?us-ascii?Q?hmF/IkzzQTJHtr0htab4vHJeS60m8I2c4cjW8k1m2C4ITfo6C9RBDCsGh19s?=
 =?us-ascii?Q?CibfcwsFNeNrZquonbXAezX5Wh2s4/hspqWn5PDaWINTjmGys38KzmKB22VO?=
 =?us-ascii?Q?JjE6A0NYikwloXFHwZGcYUv3J+r256/rP2oB/IYp?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e52f65b2-45a9-4bd2-be95-08dbd4906bb2
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:54:55.2456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qtd1xtbOrIIe7iC/rtEgD9xivJv9pItMbvzBke7a7lrWE6QdqhQ856hjia7o+tRhnNyG6sH9xprx93kGVa1JIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  8 Oct 2023 05:48:18 -0400
Trevor Gross <tmgross@umich.edu> wrote:

> Enable combining identifiers with string literals in the 'paste!' macro.
> This allows combining user-specified strings with affixes to create
> namespaced identifiers.
> 
> This sample code:
> 
>     macro_rules! m {
>         ($name:lit) => {
>             paste!(struct [<_some_ $name _struct_>];)
>         }
>     }
> 
>     m!("foo_bar");
> 
> Would previously cause a compilation error. It will now generate:
> 
>     struct _some_foo_bar_struct_;
> 
> Reported-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Signed-off-by: Trevor Gross <tmgross@umich.edu>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> 
> Original mention of this problem in [1]
> 
> [1]: https://lore.kernel.org/rust-for-linux/20231008.164906.1151622782836568538.fujita.tomonori@gmail.com/
> 
>  rust/macros/paste.rs | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/macros/paste.rs b/rust/macros/paste.rs
> index 385a78434224..f40d42b35b58 100644
> --- a/rust/macros/paste.rs
> +++ b/rust/macros/paste.rs
> @@ -9,7 +9,15 @@ fn concat(tokens: &[TokenTree], group_span: Span) -> TokenTree {
>      loop {
>          match tokens.next() {
>              None => break,
> -            Some(TokenTree::Literal(lit)) => segments.push((lit.to_string(), lit.span())),
> +            Some(TokenTree::Literal(lit)) => {
> +                // Allow us to concat string literals by stripping quotes
> +                let mut value = lit.to_string();
> +                if value.starts_with('"') && value.ends_with('"') {
> +                    value.remove(0);
> +                    value.pop();
> +                }
> +                segments.push((value, lit.span()));
> +            }
>              Some(TokenTree::Ident(ident)) => {
>                  let mut value = ident.to_string();
>                  if value.starts_with("r#") {

