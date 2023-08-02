Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C42B76D6D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjHBS0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjHBS0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:26:15 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2129.outbound.protection.outlook.com [40.107.10.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C1219AD;
        Wed,  2 Aug 2023 11:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiQ2hNfBZoKn4NLUJ3q4jFAJgzA/nDyZzpK3kNDL3ALh2q9fmC3jb6QIC7YoKPh2TRs9UnjBY7Cuif1n4koqJMjgle+1+jemya/LkVijTEqSvsBHiB6K2ruaNCGOjYeGyTq4iJHdlYGlvIWT5FwYhra+za8NO5yoXa690CZvfN+aXHYR0v73FbeW+XoFeE9Hkh2E2o1i/o0TCCcZh1NPBuILrD1iDDLwsG1d6kgI1/+xv77adglNHXOJisG/7+yvuajUlmMlBi0zXNQFjnO6rfMCNyH9rEs0faPVp/ypJzKjIdYplWYAKQUkBGrAbjS6QFLIJeYP7Wra3d52V/WB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kH2T2B+dV6pPNISct94v5SjSvoWjRuUL9KBf5TNY+6Y=;
 b=H5mOUcgsfa3PdNqiz6iP29KNKWYqQzEHgiXraZeOYKuTSEA8A3mKsZy/DDt2eu8ukws8v74f3C9G0Of3Y8+mMugESlH+B8YWc6P5Y6ZZLNhtpurVogcZgmxlHQUvRLnwYeFHY/wBoSj0sxJbuRp4GCAm1wlHRlLDXiY9kE2YiK0hOJqU9V+fx262gy17j8pwpzA2SHdFZKFWRg+f8nE2e4vnn7t005FktaESS2z4r1JeTvK6rdWejZ2NgfCprfiWscdI33CuAHe9NO1dBn8xdwrUrdXpErhFH7G3wunMTnXdCI7hqt6o72oGPa+w98yldCaryNJHjTns4EYHpoBb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kH2T2B+dV6pPNISct94v5SjSvoWjRuUL9KBf5TNY+6Y=;
 b=XDmWhMmTCeVF3gpsYW+1e37R6xvcB5f15Wc5KDWfoHwnFXmjNvqZml4iVXpZ39gyKdJ6O7/7Ec8z9q20jQHSD7SHVetYJZm3k9iiyfa+2G2j6uXtq4eXrRdWE3x4nvnd1zcUfBM3JZF34AfYk6QxaeuNZtPth4hW+p3pI/jX0Oo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6632.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:30a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 18:26:07 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 18:26:07 +0000
Date:   Wed, 2 Aug 2023 19:26:05 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 2/2] rust: enable `no_mangle_with_rust_abi` Clippy lint
Message-ID: <20230802192605.5ddb32bb.gary@garyguo.net>
In-Reply-To: <20230729220317.416771-2-ojeda@kernel.org>
References: <20230729220317.416771-1-ojeda@kernel.org>
        <20230729220317.416771-2-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0330.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::30) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1249da-2129-4928-801d-08db9385f066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBGcBp+sRgjqaLfFWg4IeoUPEd4mzcwv0aV56H6k7pHjWukUXO3BgDHFsWRYiHen6SCXEKDDGf/ea8zBmR6varE6x8GfBq042Rj5GM13O8DxudvQSCjVCwdpWGyocCz7FgmxJnzYRK8rgSEpPp5zut4ggk4j11np1udAPf3W2gTUYyeyTgMBn+8Z/OvGMIjbxjAoJHKJ4NotW5pR02v9RdpbUWUdAp/JuQD2xnzXpu0SA0a9Nfxh/yChS0N1+nz7783IitMMbK19n/dWqOIU8u9NUJz7Cgh4OpOi5I6LeIrofMvGNrK5PN2Fx0IvSHmEowWNA26ULRXlOP3bR4XJIvH6tbMgBdwH6ruMadU+i/eknZZ/EnSyawIj/nGzpYpN8FXzCIe07D79scdXD6ZkR1UEreyei4f/w3pFWla09hRp/GOTrjUt6Ywx8jKgcI1r8X0sx4JQs7j6nyPKx5JYDANLGgGhl1gygD8r4ZecQES1/bwHLRi7octkfwUR/uFwHF3ditt+bidWV95iAYuYiqMaMKF1PqbCNhurOBR5sE155Cq2coS+9F9Uih7Fk7ELw3F5eqQRH2A2k1nE5/qVPradHqRg8hWAmdhixhh/h+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(366004)(39830400003)(451199021)(2616005)(6506007)(1076003)(26005)(186003)(83380400001)(316002)(2906002)(66946007)(4326008)(6916009)(66476007)(66556008)(5660300002)(7416002)(41300700001)(8676002)(8936002)(6486002)(966005)(6512007)(478600001)(54906003)(38100700002)(86362001)(36756003)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZAoKiVR6GyDgj99u8NTQ1DZA6awC4x9qSejkN92z78rNJHdIDSffu332qv7S?=
 =?us-ascii?Q?2vzMGsllgqZakjoOvnyFHlrhhLWp1sAfcOJ7rbNNwiwRnKshVAJZCwfmUgpE?=
 =?us-ascii?Q?a/jewVAMHdJfsg7kyIls+GjecrwAOCEw25rl0h85VM+sOdw/mW+Uvd4FWCGV?=
 =?us-ascii?Q?TpdT+UpW2w4gYjs2+Mbj6cWWfgLvrJrK5BJVfmuQV82EnQgFuvanY+kKjeIQ?=
 =?us-ascii?Q?YhHKyRm91MjxkToi5NEqiA4PbzpjUbG831pAI2uOrJJ+zKhhgLE2iSaUOKbe?=
 =?us-ascii?Q?o4UXbi1A2SAhvZRW7PZMu80LrtudOAhupXUvRZQXUWArNc0i08sVtUg7kyCQ?=
 =?us-ascii?Q?LgwWGmvVWbCUO2BEhGcPD36kVaYayeZESNcUBJGDug70JflVM942G+pMigiQ?=
 =?us-ascii?Q?giVnfT/YofgEIdtclVGuCEohufJsxEsPKQvcR+jeoL/GiN4x6aAszALERg6b?=
 =?us-ascii?Q?Vx6Jh22ZcHX4r9eS/6DE74r5HRdPtCX1oiuQs4AAvsVOCO3ozuZyaLK1kPyQ?=
 =?us-ascii?Q?j4l2cMnGsbHNNkvAVEQkA9IAHnqqBlO7LJT0B7Jc9AxnNXbovmTsoSc4dj/W?=
 =?us-ascii?Q?lEgHSJIq/J3vXZvFRvWV0zYzMoGMuXcSU6laJ0s88xoW0isP5pg8teKHJUVY?=
 =?us-ascii?Q?7oqAmm45Q/kbAUEjtN1SgYmn4iYcqoRxCFAZP1Afkw5y2+FmeNhmIWLT2UpY?=
 =?us-ascii?Q?GTG/1ibaJJeiHjJ+46g4ETUqIWZrnX+T5rjktEmaY+uvNVG7iaxqPRKrvjer?=
 =?us-ascii?Q?doGpiz2XeUbI4h3Wn4p0VXEFM40q1H/mTk3TB/RNW233tNiZaB+p9izI7D5A?=
 =?us-ascii?Q?xPclJGu/IJRm7e3CwwSA2GTTujGipyGL+sVAlrfbpCVbHrH3Q2vKjUIlqQUR?=
 =?us-ascii?Q?y4xZBcIIi+Z1jucnBz/Y243yfSR8mQTMnaIOuSWG1H3VG5574enRsxiWwT4b?=
 =?us-ascii?Q?jdnoEs+V6a0t6UwKOlZcqV58VMjiZhKPa9zYA4tAlgo4kMl8SMx7zyhGjHtd?=
 =?us-ascii?Q?1syreZWC2NXV85cVhWNi9D916vaUe0xdqFsD1vlOxKSHpjzCz+gZiAR/GJqR?=
 =?us-ascii?Q?xHar6rtQrGy/eGcNh0//8iFbgr75l9Wox6GLyahwdh1/ynfhah2Yl5RkMHiT?=
 =?us-ascii?Q?dmYxEa+xPOLHwUSTSTS688onrMuENoB3+MxalqVomveHQ39qvUskFrGTha6c?=
 =?us-ascii?Q?cqpWycYvAF7RMtRFoxS5JmEuMCqJATBJKjSCcQOGZI/FP72tryCVRH3kcHl0?=
 =?us-ascii?Q?MoUtof2Kd/VayKzSkzhEby6E2sWGyt4DR8FH2np4vEQJkrnNMsPRCo3zm8na?=
 =?us-ascii?Q?QprgymqGAnTVlLjhB7itG6Pm7a3e1HtMozc/fzYSHzRSDqne5EECc7wEjdvn?=
 =?us-ascii?Q?8u/YQKXbm+gmwecwGn2au6Z0HmQ4i8bbD/r029pmkSVVdPNQg36icciromD9?=
 =?us-ascii?Q?fXjyM6QMT0uxgHEcQCsoPAob75ldkDWsO/lg7wn1SG0f9bIvKSKHOyAOa2yF?=
 =?us-ascii?Q?gl4aOevCegl0yWutUGcnIBtmfW+0S/4uWcTwESxmQLDskmiFntUw5pyCBBt5?=
 =?us-ascii?Q?mwvigi9AdN/RDeMjREHSHcjXbJj9lmpCJhxpcMx1?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1249da-2129-4928-801d-08db9385f066
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 18:26:07.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cJlHA/uMqgzvATnUUMii02/ESZSM/REMTp4wr11A/khN0CgJmlp+KutjX1oEOnVoLlTWRPaRScnvx8pU/XPLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6632
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2023 00:03:17 +0200
Miguel Ojeda <ojeda@kernel.org> wrote:

> Introduced in Rust 1.69.0 [1], this lint prevents forgetting to set
> the C ABI when using `#[no_mangle]` (or thinking it is implied).
> 
> For instance, it would have prevented the issue [2] fixed by commit
> c682e4c37d2b ("rust: kernel: Mark rust_fmt_argument as extern "C"").
> 
>     error: `#[no_mangle]` set on a function with the default (`Rust`) ABI
>       --> rust/kernel/print.rs:21:1  
>        |
>     21 | / unsafe fn rust_fmt_argument(
>     22 | |     buf: *mut c_char,
>     23 | |     end: *mut c_char,
>     24 | |     ptr: *const c_void,
>     25 | | ) -> *mut c_char {
>        | |________________^
>        |
>        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#no_mangle_with_rust_abi
>        = note: requested on the command line with `-D clippy::no-mangle-with-rust-abi`
>     help: set an ABI
>        |
>     21 | unsafe extern "C" fn rust_fmt_argument(
>        |        ++++++++++
>     help: or explicitly set the default
>        |
>     21 | unsafe extern "Rust" fn rust_fmt_argument(
>        |        +++++++++++++
> 
> Thus enable it.
> 
> In rare cases, we may need to use the Rust ABI even with `#[no_mangle]`
> (e.g. one case, before 1.71.0, would have been the `__rust_*`
> functions). In those cases, we would need to `#[allow(...)]` the lint,
> since using `extern "Rust"` explicitly (as the compiler suggests)
> currently gets overwritten by `rustfmt` [3].
> 
> Link: https://github.com/rust-lang/rust-clippy/issues/10347 [1]
> Link: https://github.com/Rust-for-Linux/linux/pull/967 [2]
> Link: https://github.com/rust-lang/rustfmt/issues/5701 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile b/Makefile
> index 658ec2b8aa74..93bf3eca3ead 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -467,6 +467,7 @@ export rust_common_flags := --edition=2021 \
>  			    -Dclippy::let_unit_value -Dclippy::mut_mut \
>  			    -Dclippy::needless_bitwise_bool \
>  			    -Dclippy::needless_continue \
> +			    -Dclippy::no_mangle_with_rust_abi \
>  			    -Wclippy::dbg_macro
>  
>  KBUILD_HOSTCFLAGS   := $(KBUILD_USERHOSTCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)

