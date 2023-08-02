Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DE476D66F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjHBSFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjHBSFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:05:13 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on0704.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe14::704])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7256B8F;
        Wed,  2 Aug 2023 11:04:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXA13qTI7n9XMdMnMggS+Gnh9UTGimWqYi815fIy8aYRaj/+AnuoQgnrHKoI9F6xdnuZK+GisR/9s3t76PKPDxmvHFkn+1zOS/dT7IjyrpjRNhlm8B7ydPs+7R+Kzs6xvOaUmeZYdn3hQA7DkeLS6D2oEEL4AkAY0tOQbdPPdLJ6poFijW6zb9dmEcYYttHR+WCKQfsaSiUx7cTbGoSoGlrGzRuL6/hZ7UKc9nsZNVb5/tS3iBsw61v1haEH7kZnAyWakuQR+c2jveC402j2KIldNEjnFc7pHp3ZtVDNf9h5Zx8UcidTMSY0k759OYh2Is+IT07Fk2htDE3HvvGzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GyR2YzrIgQlsOh5jD6+81gzQIsWeW9jfW0OXRO4iYs=;
 b=D9IolLjpsxD+DjvZ2RZgvLm+MO3Y4vsOXvTnsU8OJuQcEL701erC/cPz+tV2GJ0fR6HdCotv9PmTbgAyd5FjQDmD2yRfghLolwx0B5yRUTI3WNFwq0HNlc5w4wHT1P0UzY/ejUmxE+T8/d2m/KHU9i5rViYzs5sgQ5/f4nfLGmaTLHn8lPf+1x0+CgnY32Ya9l6p+x+hRGm+LuLzdK9uyeB4zVNDH44c8hde3oxPXTW3jAx34ReNM/n1C3/0GMZSu5isinhXPPjlD0DOYGSSyYf6o9uW2fRVdCKVQfM1zDAe4TqWdcGDnubuSVP9l7DuhimTuR9ngI9enaYQWORwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GyR2YzrIgQlsOh5jD6+81gzQIsWeW9jfW0OXRO4iYs=;
 b=Dn7sKm0iOhygBQdXIPcVyK7XfcmHpMnKaHGVWp2HaH4qYtoJnunYj5tYUtcn2ceuzH7IgFXx4FVD3gtLIqtUk2LPwXNWmyuUnj0AlV6HMbWsGImrXRpsNk4VkLou2O70bTXJ8H/lMeYHmIeGnLBxUWMox8VaxKstfqlA4f70Hyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB5848.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Wed, 2 Aug
 2023 17:59:05 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 17:59:05 +0000
Date:   Wed, 2 Aug 2023 18:59:02 +0100
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
Subject: Re: [PATCH v3 06/13] rust: init: make initializer values
 inaccessible after initializing
Message-ID: <20230802185902.3753dba0.gary@garyguo.net>
In-Reply-To: <20230729090838.225225-7-benno.lossin@proton.me>
References: <20230729090838.225225-1-benno.lossin@proton.me>
        <20230729090838.225225-7-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: b37dce6c-1aa4-48ac-3e1a-08db93822958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLazqkAnfo7W7cb8ocntXttIxud+8Djh3/2zjBrjili5rLOQMXWUv/bxiD3FI0JyXLY7BpjvehYMCVphTkds0mzFrpQSuvymGE30rfB1SscQ3TczqSpP/Ag+9gg/XOUJiVSCws3JSCEkC5YdSqV8VvMRd4pfehAitaZmPC2amjr93grWnezc79lqqi6gAGDMirFl5DljkZR3Pdy6Fyrytb21UTNaZcQuYX1gJ5ukzq1M/BAS6jBNcWT58LxoBYriaXImQZtYjrey2Sa83CsBRMakPuIFYOxfWQmz6srIb8Qnj3q2g7JyROQ98hZMNXWCtHF60mHAHrboPKIiXror77hb/fHHV4n5ymvfVH+gjKvrYPzYvNcY1yEQ6agJCMXvLSdq2A62c/ojw/sX4nCeRof8cMCgoGAGQ/31vGohadYR4i5/Xi9K28zn1Q143evlVHIoCit0hmQVNnXrIgwogFbJDAgPgs96x1Y0hJGVLvtokz+tyIBix1dua83EPvxhzPET7eZtBkK6+wsitR39AQ1dL3C04D7ahJywScdzCme4L9FaXbEZsu31COj4ku6W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39830400003)(346002)(376002)(396003)(451199021)(66556008)(66476007)(6916009)(4326008)(66946007)(2906002)(38100700002)(2616005)(186003)(6506007)(26005)(1076003)(7416002)(83380400001)(54906003)(86362001)(36756003)(478600001)(6512007)(6666004)(6486002)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EJp6SPDqFx5WQetspq9N+OFleIcpZgXsvzzihVHx8ZMl23sjplgaZVIRU+N8?=
 =?us-ascii?Q?B9ds8IpNJneyB23RHiLn3i26DBnI595h3asOcYivNIyn7dsVaklzA/nr65Hf?=
 =?us-ascii?Q?wyjcTAyq1SbL2veynA72dqr/h1uBy9GngTitZGN0VLQUdg/hG1kN/fhcJPh+?=
 =?us-ascii?Q?xs9U7HiOnUprF8bWoVNLn7N3lFkCeaoZpwylkX3k00DPiJ+eLVvI1A8Ps0fa?=
 =?us-ascii?Q?oe/ml/2rOvHASex4W/TAXoz41y5P7Ln7vSD+/9uGXYuOn604abNkNqZObTKk?=
 =?us-ascii?Q?8pF7Ih+NlxNZs2T1SgPlMW41+ZiciZwfyCxhm63NT7sOmR27vhDjCcSaO9Eg?=
 =?us-ascii?Q?msDt1AydEU/7EKVgfPiZzH+zL46tlGdWIV36KaBbksLW05L00RI894nJMLpi?=
 =?us-ascii?Q?WaXHr8Va3jvfY8H3EEYmo+/XW5j7SrMBuKFX5y7+g8f6RNCGvKSBvUTQ7vxI?=
 =?us-ascii?Q?3UWZFWH9AOsg7nBU6jzXIXVperjpemYgVWPh5CdIjVDgRF7sxbkGk0EX+WDK?=
 =?us-ascii?Q?AYetrMOzfDbMLlZCExtg1fjatqQnWo+VL0Wn4z+g509xvYvDustBOYdG2blj?=
 =?us-ascii?Q?VKvuxP1bUy2MdjCxpDuzvr+LwUenuLRkzUCzGorJ90DJJU0cMKMb4j9K3vkI?=
 =?us-ascii?Q?+lPDMR63Bhn3jkWONqOMyQiKom3MD/EGlWchCQYmvM/dv9/xbiWCYn/MX6eM?=
 =?us-ascii?Q?T4CXp3ig+Tr7P+G1JeniWJKx58ins+4AGxeoSqQeR64ECyPulKBv2dQxGVq2?=
 =?us-ascii?Q?cC+299Ale9Kv5F240qOltgQmtD+aAE7p2pePyJC9Y1stWLi0T6skO8VQXw4/?=
 =?us-ascii?Q?ONxLuTz9xUn7qau2w8XHUtWuPabZpvGDx59fo2GunXUVhNbbU8kkA5LH3ALd?=
 =?us-ascii?Q?qXWWR+2MlXFNRGtBRaCrBUG6N9nHdixDhm4zUtIXmgmZzztIWO3srfzirVcS?=
 =?us-ascii?Q?+UuxPgYlhPrSZjZGReMJoJ3U31p5CroYEmlEUWIauQdfBxZqYLP7bYXfGAiZ?=
 =?us-ascii?Q?UA4qeB8nk2/RCs0ySWse/eH0fOVZCQopgELWqU+2tZWdTfVtnP366RGrjw7L?=
 =?us-ascii?Q?HLPEyaxAlkgzAwlFi4Qea4hhAySaztpC8unzBbQLG1D3m10OpwvGchyfDCI3?=
 =?us-ascii?Q?ItI3a5WNUdlvISjyBNxPNm7I6HlL9+2BEnUf/G32KPuH5OR70KnDQsqd7LI+?=
 =?us-ascii?Q?+e3l/VHhvNWCN18eWGw0Dpc4BDgR2YuISxj0FoRRThCHb2Rmn6baEUAyn136?=
 =?us-ascii?Q?U90CnIYG0zCH88410XgsWbtQjO+Dvedhpw2CusB+WMyf6mubwsU1aH5ne+LY?=
 =?us-ascii?Q?Pclri9xW5emhGC9RuFtPPuIxTsVxZz2oVMZwIRLwrXusiw/yb/h9oluTDQYp?=
 =?us-ascii?Q?FenhA2+rw51KXlgpfLkF4Jb6XnmJ7LSs6GUwzmBXD52P+mKk45pFz8qjoSJ/?=
 =?us-ascii?Q?AT8vovTWAg8oEEbwKcX6pCN2X1WJzZsQMaZGj7vR3dNCA/9f3469g9ZYkTY8?=
 =?us-ascii?Q?ZRQwrAp7m+iffXxn5b5nOzb4FL4CjwaiCJaEOqrkFXf+QFWaSlE6dPETFjky?=
 =?us-ascii?Q?nmXKaScSKQ98gqowagpVYWWIZE3n2B8BGhSK3212?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b37dce6c-1aa4-48ac-3e1a-08db93822958
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:59:05.2873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ggl/DM3vYliK4hnxyBvaUkT+zmVdgK0DpAAQsjuJKke4PHGCtmyQuk5gK7kh99yam18XY0dMhkFRA6mxo733tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5848
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2023 09:09:53 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Previously the init macros would create a local variable with the name
> and hygiene of the field that is being initialized to store the value of
> the field. This would override any user defined variables. For example:
> ```
> struct Foo {
>     a: usize,
>     b: usize,
> }
> let a = 10;
> let foo = init!(Foo{
>     a: a + 1, // This creates a local variable named `a`.
>     b: a, // This refers to that variable!
> });
> let foo = Box::init!(foo)?;
> assert_eq!(foo.a, 11);
> assert_eq!(foo.b, 11);
> ```
> 
> This patch changes this behavior, so the above code would panic at the
> last assertion, since `b` would have value 10.
> 
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> v2 -> v3:
> - added Reviewed-by's from Martin and Alice.
> 
>  rust/kernel/init/macros.rs | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> index 2bad086cda0a..cfeacc4b3f7d 100644
> --- a/rust/kernel/init/macros.rs
> +++ b/rust/kernel/init/macros.rs
> @@ -1075,13 +1075,13 @@ macro_rules! __init_internal {
>          // In-place initialization syntax.
>          @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
>      ) => {
> -        let $field = $val;
> +        let init = $val;
>          // Call the initializer.
>          //
>          // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
>          // return when an error/panic occurs.
>          // We also use the `data` to require the correct trait (`Init` or `PinInit`) for `$field`.
> -        unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), $field)? };
> +        unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), init)? };
>          // Create the drop guard:
>          //
>          // We rely on macro hygiene to make it impossible for users to access this local variable.
> @@ -1107,12 +1107,12 @@ macro_rules! __init_internal {
>          // In-place initialization syntax.
>          @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
>      ) => {
> -        let $field = $val;
> +        let init = $val;
>          // Call the initializer.
>          //
>          // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
>          // return when an error/panic occurs.
> -        unsafe { $crate::init::Init::__init($field, ::core::ptr::addr_of_mut!((*$slot).$field))? };
> +        unsafe { $crate::init::Init::__init(init, ::core::ptr::addr_of_mut!((*$slot).$field))? };
>          // Create the drop guard:
>          //
>          // We rely on macro hygiene to make it impossible for users to access this local variable.
> @@ -1138,11 +1138,13 @@ macro_rules! __init_internal {
>          // Init by-value.
>          @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
>      ) => {
> -        $(let $field = $val;)?
> -        // Initialize the field.
> -        //
> -        // SAFETY: The memory at `slot` is uninitialized.
> -        unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
> +        {
> +            $(let $field = $val;)?
> +            // Initialize the field.
> +            //
> +            // SAFETY: The memory at `slot` is uninitialized.
> +            unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
> +        }
>          // Create the drop guard:
>          //
>          // We rely on macro hygiene to make it impossible for users to access this local variable.

