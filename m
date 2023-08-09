Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E801C77679C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjHISsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjHISsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:48:08 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2104.outbound.protection.outlook.com [40.107.10.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77053E51;
        Wed,  9 Aug 2023 11:48:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwYhJlAfbz6Xajf9sLjAjt8yieLlKFS29SRSCuANM6K55+7sa2tUcm2Rgq2GrgfdbQ1kvEvIBjPP8zieIFkT5C336IbwtB0nK0eVlXJrf9XYdhaw5sSMjwwpgZ8sks05FDZ8yfyUHOXI+a0MPSngIGz6sGgDaZSMl61/g/IfBrPtRkZ+/KVGXX0FCco+14rBOBVhh6mYbHsZaXzvCAt70kkn+SyCFiq3bQ/Mg54QNYryB8Cd6vcv4/x/Ql8/9+4lsJxW9n6bZQSz0EJdrgp3ILULrDSx9ly4x42SDSqCoEbgMbt86PC5im578fyxj9uM0zL48YjTPaKelbNHTxTXlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIyASTRaFUHUbajpWsGAbfmrMpWnSKrkqkE9qEHxbt4=;
 b=EGBtYwoMy8Orb6t5gZJd79KyEecdXFn4lD6+k60+3LMJJTuf/pdRIJiQ2TklRll0v1eNxcwa2ZsuOaQ2yHELvdRCUyNM+jBLyfiNWSG8VyG6ck4LHHpLyrem6LQafYqvRAc3m3Gt5d6ox/vE5u9Ycowk5z/nlZILEtRtERV++VK3tkfD/5ZVSRr9YP7MtUtoOXuu5/qJZdbz33SbPMaeHpxXv3U3j6ncRJn5e73fZElob5M4G+Phi+6QmdRJTdaHv9raKWTylrnwRz6WBPspu/zU6wS3omiWuTcC43gjeAMVSe3saOtveQmR0YzllG9ldOpocvzyOnN51bpAV6N/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIyASTRaFUHUbajpWsGAbfmrMpWnSKrkqkE9qEHxbt4=;
 b=QmVwk30qxgRks3edvSd01M0IXoUE1zVZSAJcEvIrznwqF4/gWBXnR2F5/T/gJlFfNsz4r7PM0ycJcWrwDqr5wQLe9PUL4tBrQrb52i4PBTPXFORz+1eack1yvUQBuPDgKCLzDsbMduvMKXSAOSuJM/SqArEAdL6yus0xnxwmKOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6047.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 18:48:05 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 18:48:05 +0000
Date:   Wed, 9 Aug 2023 19:48:02 +0100
From:   Gary Guo <gary@garyguo.net>
To:     "Qingsong Chen" <changxian.cqs@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Sergio =?UTF-8?B?R29uesOhbGV6?= Collado" <sergio.collado@gmail.com>,
        <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3] rust: macros: vtable: fix `HAS_*` redefinition
 (`gen_const_name`)
Message-ID: <20230809194802.46aa18d0.gary@garyguo.net>
In-Reply-To: <20230808025404.2053471-1-changxian.cqs@antgroup.com>
References: <20230808025404.2053471-1-changxian.cqs@antgroup.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0114.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: df179480-d294-4b12-8428-08db99092a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MTMon6cZ+5fGnBGmLiknbejBJpOx0VXlSJQDFKTU19JE7oFhivdGi66/Me8JoRzB9qOmMgGBbjJFtf2TyxlY3p8V1p0j1DxRhiU7M9BcxsTn0SwmQj27D53u48rl17U39EDgd2jJ+R0PfvLA8Gc5PSBJObOkuRwGegroO0VoR/B4H4cwB9fnuWp634eR8gq43RTUzWw2TfJ66j5qK1BpOrvAh0MWMBFqrDLDehliOdW/3UMqTiz4OeYYwE1gYQrp0wltGoJqxBiSsKXspG1SsKbwMFTERBx40QCSleAV2DIbBh9i5PEvxkKVK6Z6NteeF6bzMp/PxqtXtNnNn8gqPjlpdqR9PsLUdIGlIudWFBXxVOQRfbr4g1FOiwcKE0e+EEx/oHRUpmy4v28qGIkgGpnO5W0SbYVuChLigM7/+IdC9oNMIuSKoCMnOH/fDOBhKMrqx6VcGTZHv3VKBH/330FxSLMFkwSW2w76IJZLkdpmaHWMgeTkXMIQNn3d4QagSY37uuv2IhC0nNGfTqgkvlKHyQ2+oMrN7Oc/Y31d/Jb9YVydYu6/EhOMMOedJkHY5lkzB4/hT656nhsiSHI1TnKG3gnfwJy4nUDR68j/mA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(39830400003)(396003)(346002)(376002)(366004)(451199021)(186006)(1800799006)(6512007)(1076003)(26005)(6506007)(54906003)(38100700002)(36756003)(86362001)(7416002)(5660300002)(6916009)(2906002)(4326008)(66556008)(66476007)(8676002)(41300700001)(316002)(66946007)(8936002)(6666004)(6486002)(478600001)(83380400001)(2616005)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8mzR3+Ax2VsP9GU5us6plOFb8SlEWTNKVoASWewKWAWuTQkrH/VauyDFULIV?=
 =?us-ascii?Q?KM4lRl60LTu7++osFE80bO2/p33xmdQTZ6ZZgwIDtpfov3ied2c8hinUqxd0?=
 =?us-ascii?Q?dcrZ0kl1uamSNrmzWH2d8mcS4EaYq+V8dMUvlpDvLx+vfdNJBt6I7lhvEVqN?=
 =?us-ascii?Q?FrHIPxrXLe/qj9X6a9BB6FCO3b5WsMfZ0PioTP+/E+bf06mRfJ4f1EkFZW8x?=
 =?us-ascii?Q?2eQLE0VpBgnrlUc1WYjLX6CsBjJUdM19S+GlPP5oMTQ7Bg/fb7VGMM2QOiK8?=
 =?us-ascii?Q?5suurWb8PsXlir0O3X55hArMn8/koP9hoYleMNZzGKlWC5XdksuCgVCuwCFB?=
 =?us-ascii?Q?JSBy/MCNFOcuoQyW1pIX4J/70CfoFID3eQMJUA4lEOFqryX2uuppQMUWuGnO?=
 =?us-ascii?Q?YP/wni1ZMGIyPfYTlXomOBw4wZDXe6UVS6JbVxT3I9MnE3Z9iWxVDbt/518Z?=
 =?us-ascii?Q?+SveD3FRuAGzDp4kj5WuOGOY0Ba+NH+CAo6ul5nHicqZO+mOCHeNASMbhm0e?=
 =?us-ascii?Q?/NDXXhX6d1PdzOVFU/wPxOeWwDW0mzUt8bdqNITmaJrALfvSJyv3YGU9f8yO?=
 =?us-ascii?Q?VCtrMdwGHYpItpfx4r+C98GmwXmXSJQrcGMGbG+Jyf9C67f+1aOmW34qqmb2?=
 =?us-ascii?Q?zOGVIc3c5psUJdHr4WHDJZd2g9jhvodIPNIw2lfd1GMneBOFkCxY17FD5qGq?=
 =?us-ascii?Q?mOL6r3g7tzGHjSlpnL21ybhlKCc6Z/ZL4WE2CEk1APlCLzVNgpNTyckR5SXo?=
 =?us-ascii?Q?oti9Is/NK+aOWL32s4pkCvjikcvz4MUW/jsAO1evJFD/1l04DqKQc8ipLgkk?=
 =?us-ascii?Q?2cwCvF7lBLyVstF5RN63HsNNzCiByKt/pdEHuvl6WxDDj83EcuGfGx/K9uZ+?=
 =?us-ascii?Q?jels+bUdU6QUkwVXKDE+yXmL0hQaAv7Y1xWS2FXJDICLGYG+N6/9bxHQ6Ntg?=
 =?us-ascii?Q?HkIo6BapoEqvSRwzaInwGxylu/SOJkgcri1eFH2iaf79Wd8wsb/6H3nWlLCc?=
 =?us-ascii?Q?xrRn8ZxjHC8OMAhm1+eDNuQm/QzYfbGP4WHTOd1wG7tS95B9hMW0IWqGYsqJ?=
 =?us-ascii?Q?XP0qRnBGGNkdl1fO1ALeRtMTGPCM2De2HircTOb8yntE4eA6JzF6aMbhcW05?=
 =?us-ascii?Q?MJXnZyXJI0Mu2q6HGU8NhwGl9K8lTp+qG1SHSHBFjIPB+2o3r8Uz4Kp3dlz5?=
 =?us-ascii?Q?NXM2GoMdhYid1D6x1p84HaT94dP5pLyYflohC6uF/EuhXXD/gBSrZbazsnRo?=
 =?us-ascii?Q?PIp4DPokqrxO/3vRbs2aEhXtKmlwIU5xcTcKj807WQUA44YkUEFUZN4Gs0r6?=
 =?us-ascii?Q?bQaCh+zvGjbiDLs0VBEnNj7vb05N7bsVfA8vQoz5Ue4hYnDCpTPqHTREKu0p?=
 =?us-ascii?Q?ZZULmuhHOla0WS9E6lUwwPAmS4tJ5gJlxEVnJQjNY4uVnXtcGvucHBPbi+hf?=
 =?us-ascii?Q?b/KfajsUKjGzTYHIEC6bFDzrssP2TgsdsH9b3FqTUrs4nD8VdflNItXa27/b?=
 =?us-ascii?Q?HTZ8B5DMcDy8lPbQbdkvpdyXd0leXycXw3eEQM2szhPFarCA6cLZspQZco0o?=
 =?us-ascii?Q?iwUm1O3sVLGmI0t9xgx19dqzuL0yD4FP0YCNwS3d?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: df179480-d294-4b12-8428-08db99092a72
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 18:48:05.0423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qe4mvQOuy3Yn9GuYwC6en4WmZRbePwIuZDiYG6UpMUUGqAc3er9I9+IhqCgqUkcF51qItuSv5d2PnnYmrxp8qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2023 10:54:01 +0800
"Qingsong Chen" <changxian.cqs@antgroup.com> wrote:

> If we define the same function name twice in a trait (using `#[cfg]`),
> the `vtable` macro will redefine its `gen_const_name`, e.g. this will
> define `HAS_BAR` twice:
> 
>     #[vtable]
>     pub trait Foo {
>         #[cfg(CONFIG_X)]
>         fn bar();
> 
>         #[cfg(not(CONFIG_X))]
>         fn bar(x: usize);
>     }
> 
> Fixes: b44becc5ee80 ("rust: macros: add `#[vtable]` proc macro")
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> v1 -> v2:
> - Use `BTreeSet` and existing `consts` as suggested by Alice and Gary.
> - Reword commit messages as suggested by Miguel.
> v2 -> v3:
> - No need to replace `HashSet` with `BTreeSet`, since `consts` is never
>   iterated on.
> 
>  rust/macros/vtable.rs | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/rust/macros/vtable.rs b/rust/macros/vtable.rs
> index 34d5e7fb5768..ee06044fcd4f 100644
> --- a/rust/macros/vtable.rs
> +++ b/rust/macros/vtable.rs
> @@ -74,6 +74,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: TokenStream) -> TokenStream {
>                  const {gen_const_name}: bool = false;",
>              )
>              .unwrap();
> +            consts.insert(gen_const_name);
>          }
>      } else {
>          const_items = "const USE_VTABLE_ATTR: () = ();".to_owned();

