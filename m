Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9814D7B4086
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 15:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjI3NiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 09:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjI3NiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 09:38:02 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2092.outbound.protection.outlook.com [40.107.10.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3506F1;
        Sat, 30 Sep 2023 06:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbjCjMKSs8HC2hVpo32LbqokWNYzHc4s1hCCKdcU5oFOIUNECL3IfWWFnSrZ65I+9oHHquYsY258wmIjcvrZ7BVMGbr+dszuRTQrvmCCJk6lUWYqdTbmNjfo3663PcdUiwwPP7p+1eCLx1DAXnqNLsDFBo91u+0n9dF6qoLpR++YiuoP9Etx+2LZDFlePW1Slr7FJyn7dXA8OYSKB1c2LMQ94KAhWd5NLPLPyBRYOYcpBUlvfZEimCkVinMww0D7O/QIeRnVXYBU99ZtIFvvug7/1cdBj/znRa1TSxExTxu1uyqT/SuwMqrgRv8M+I/JTBzUv9HgYVAByhJEdhvRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFknlka/FUdHfs3wGlme7Gu46tgRaGDzMU22E3nro48=;
 b=hoYBHLB1bqMc8mWdyRy7ZGADsmeOXlT07ErBfuStoQQqN+NTzG6g2gz1D3SxKw7h/7M5MBit+5O0tKFnAJ2ghyu+kWHx6/0Vz4R4j4ClY5DIbW81qXi+Ewt6GnU44MFZc7sVAblEI9kf/2eaxe3+KuT/0HveBM43Wo2EcwY4BglevQOFEKxCGobuobaICgx7BcNdS/on+oHhq9qbKfrcfHeLYIy9QZklVARghvm8m0jMxiWperTF11tIxGugnV4iA2YSakBBLYnj5w0+MLX876hDLINUD1W5Jo/11krFpz1stmyJfmcxn8R/KSEvrnunGzTtFm0EBavdVYWxjowc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFknlka/FUdHfs3wGlme7Gu46tgRaGDzMU22E3nro48=;
 b=VXyMGp0E/2di07XnAwoiwIrLYMIGaOKQoAbvSinjTwrJjkHIKQmzGHlpeBF1yn2DvbpJ8yC62f9hHn7QBm3eNJyttGQc3hjJVs7RWN6HYogWodBTmfcx1nlnm0g462gl+23x/jiT8UO0mtjuvLjEXTQzg8jnurhGV9ulHBeIEpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB5083.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:194::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sat, 30 Sep
 2023 13:37:57 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d%7]) with mapi id 15.20.6838.029; Sat, 30 Sep 2023
 13:37:57 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Wedson Almeida Filho <walmeida@microsoft.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rust: bindings: rename const binding using sed
Date:   Sat, 30 Sep 2023 21:36:56 +0800
Message-Id: <20230930133704.13313-1-gary@garyguo.net>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: 968e3141-2aa2-455c-7146-08dbc1ba74b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVMverxWcOw1FRSPdNxJ9rKu+ogCWX99mUSQEvR0PtxznNVKJzyQOEUoQuPs1idEZygYyfhOkIMS+X2midWP97Y1kLlapy2wxP0qstZeo6DAZofcYGeM0MW6yRJk0ymo6nfDe9pe6VTpSsmWLZ1ZAZNaflyHMQMpuvsDFlq89qh/TLV/3r96szUMgHtoAcfjwzuwFwU2q1QGdQDdznbDpRSi7x7vaV4e0RLcOgv58aoecCcVyJyD9g1/4uG0Eqs3MBJsW7G8EmwYp/zTuI6BKLQdPcudao7fn5YQXvVp+ETUehZlHQE/AVMvIXiQqhTLp9myJUjbdB6zX8ZQwZYrEX+HQqwaMHXZUUPzikCIZZ9k44TaR3balVb9pZ3xSP4MEqri3haFYjPWw62xxCp4qFTOI6qss24VzcoPmXIs06s6EYkuocmxsfMDm/0BhlHhoxtG3D6/AxzM3hH598/0jXTIC82a885BvYW9dErv90DoSJ1ayOuJtigABEFJIme6/hdmGKbc5UWRAI0xL85rdwBi8pdNQ7xg0idu1LfDTWaS61mbsxcJ27zInJB/HtToJiD04Iyb/MU1vugZYVw39PohO658YvY5SbxAP0rgJpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39830400003)(396003)(366004)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66476007)(66556008)(316002)(66946007)(110136005)(1076003)(26005)(2616005)(83380400001)(36756003)(6512007)(6506007)(55236004)(921005)(86362001)(38100700002)(6486002)(478600001)(2906002)(7416002)(41300700001)(4326008)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6bcQ6OfB1frqR4uspsYF/Mm1fgEHp24tGf0IqyRD+wZ1RukZ+AvTwqRTExfN?=
 =?us-ascii?Q?5L9sRf5gbwdp6mCJt3JrbRQQ+7VwWp2ACetNnKaf00j34w5+D52ZB6Mrp9wQ?=
 =?us-ascii?Q?sep434h+D4/OQuyQmoI8o8IjLPB1MyaIjMuWYfbmLceL39Mpk2ruYyp9QkRu?=
 =?us-ascii?Q?FLEOrW/YxwnDp/VaE6/4ojQ9ZIfV3GEwpEe1Vuf72/Ht9CXjANmxPX2zvsLd?=
 =?us-ascii?Q?8RaltuIF9PYJsf3LyfarNlbBNfNl6PA/iDffFo0RxVOQb2yJfwV8A/buM6pS?=
 =?us-ascii?Q?Hz9gXkJxCj46OUL2wgDGe8VloaU8r3HGu7g0LZpc65osbPWGarCq/2rB5Lxz?=
 =?us-ascii?Q?VZILR+v58Ny1HKRMqFLhq/jbntfMDulWumiFPBRKAQT9uo5ptAyiEEsb2Nvh?=
 =?us-ascii?Q?dAyGKPMkcvLd9i6F4Vtf/PjB7IV3YfrZReUdnQWJAzhZyNA6FmWpDtCe6Ymo?=
 =?us-ascii?Q?hGmq/2iaSBQVmVUuXgFVcoMVxFG+GsZvToj2mn6CbhrOeqWFhKqbGX78oqSK?=
 =?us-ascii?Q?2mjx6H9GLrxEUHn66xT4uQP9/tM8vtg9aTIQPRH4nHX1yuYGR/xEKQLAYn9J?=
 =?us-ascii?Q?6kxyfFYuhM34eeL+pq3UGjNaEuIjp7WEGvwZ0OXShU+Lp9NP+mtiewuWLylv?=
 =?us-ascii?Q?H8ZQqoHAxt8krKj+AmSUIRR2xbmOJohObxqZ7a7E/vaf0SEliZBcTQaqlHPw?=
 =?us-ascii?Q?iTCu+S3S4iSqskX/jPozhypNV85AEHf8mxrKidPoybCQ4kLFcwAcRyeVZfe+?=
 =?us-ascii?Q?pjPPOWlX0KBknUqFxOEYNldeqTXIp/JiTeEaKUKBaoPhEAqwQEJmAKq+A1ki?=
 =?us-ascii?Q?zNiU5WWIDo7KsrbHasyjIX9f0S+cc6hVaVd4bfTM9kyzps+UcAjn06J/mpeb?=
 =?us-ascii?Q?0oAIFvCE+jhz4U8qaUSceZB+sXLVTepsygitOhTn262R5Avx/r27O5l54N6V?=
 =?us-ascii?Q?2lc2NOAMlZ/OmnYAnl8Ul+7e5tAi8GTsADocYCQN7wij9+AgKYU2YPLTouQH?=
 =?us-ascii?Q?a61kemDz+gWozWX0WMa8zKDsRir5R+NBb4dOXawx32oDwFJQLdd5Mmj4x7UL?=
 =?us-ascii?Q?QUzxkUyzrM1/+fmVv83hJ2Lw8f8Dm7R09R9oIU9R3Kly5KHAf+Gsh2N7m7TH?=
 =?us-ascii?Q?2ZXhHf5Hd2xNQNL1L5AA5zi0VaDt49SnpVXVqHuOXknWJICSbeutPbn4PCak?=
 =?us-ascii?Q?2rMEOQaNQOlSCvWXLdGhJoNxMC05HZdI+H/RJ7ps1h222XXoJi4cWMZ/CgWZ?=
 =?us-ascii?Q?3pd8rklTx8BasivvPz7W3koz4qHMqVLhPA0HpaXfIyLVSLYkqBDbEEKZ48Cq?=
 =?us-ascii?Q?uKy7onasb0UxVLMXRQfZwrTZjTk2lSrExpD6F0vUoOEOKGW4AeFnL4kzlttf?=
 =?us-ascii?Q?35jnciwkETrN+aTHg8w4MmW5fh0FL/gG9qXcIpu21kTeqihbqXh1R0LKqsp3?=
 =?us-ascii?Q?gGHMV9lkOrHK5VRnu9jOphCspYwxUtWXbJDmFAIvQn2++edu+JSwlYHnqkBJ?=
 =?us-ascii?Q?0Lnq2bBGrhsQ5oBVhEkgGKDS7cFYQKHApWUACY4DcAg5D6ut7cvUwkpkrr/l?=
 =?us-ascii?Q?ZTm45UuJt7e5Y0XcmHY=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 968e3141-2aa2-455c-7146-08dbc1ba74b6
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 13:37:57.3738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6yyoGc11KqZNMMD590RLQsYsoiTETE/BVt/ip1gStulIQr+0Mgj8YJchPSYbKxULsU2LGfBFGQRCGoo06jTdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5083
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current for consts that bindgen don't recognise, we define a helper
constant with

    const <TYPE> BINDINGS_<NAME> = <NAME>;

in `bindings_helper.h` and then we put

    pub const <NAME>: <TYPE> = BINDINGS_<NAME>;

in `bindings/lib.rs`. This is fine that we currently only have 3
constants that are defined this way, but is going to be more annoying
when more constants are added since every new constant needs to be
defined in two places.

This patch changes the way we define constant helpers to

    const <TYPE> RUST_BINDING_<NAME> = <NAME>;

and then use `sed` to postprocess Rust code by generated by bindgen to
remove the distinct prefix, so user of the binding crate can refer to
the name directly.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/Makefile                   | 2 ++
 rust/bindings/bindings_helper.h | 6 +++---
 rust/bindings/lib.rs            | 3 ---
 rust/kernel/allocator.rs        | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 14d93cf60a95..20889302b172 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -339,6 +339,8 @@ quiet_cmd_bindgen = BINDGEN $@
 
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
     $(shell grep -v '^#\|^$$' $(srctree)/$(src)/bindgen_parameters)
+$(obj)/bindings/bindings_generated.rs: private bindgen_target_extra = ; \
+    sed -Ei 's/pub const RUST_BINDING_([a-zA-Z0-9_]*)/pub const \1/g' $@
 $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
     $(src)/bindgen_parameters FORCE
 	$(call if_changed_dep,bindgen)
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 85f013ed4ca4..c41eaab4ddb2 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,6 @@
 #include <linux/workqueue.h>
 
 /* `bindgen` gets confused at certain things. */
-const size_t BINDINGS_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
-const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
-const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
+const size_t RUST_BINDING_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
+const gfp_t RUST_BINDING_GFP_KERNEL = GFP_KERNEL;
+const gfp_t RUST_BINDING___GFP_ZERO = __GFP_ZERO;
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 9bcbea04dac3..40ddaee50d8b 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -48,6 +48,3 @@ mod bindings_helper {
 }
 
 pub use bindings_raw::*;
-
-pub const GFP_KERNEL: gfp_t = BINDINGS_GFP_KERNEL;
-pub const __GFP_ZERO: gfp_t = BINDINGS___GFP_ZERO;
diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
index a8f3d5be1af1..4b057e837358 100644
--- a/rust/kernel/allocator.rs
+++ b/rust/kernel/allocator.rs
@@ -21,7 +21,7 @@ unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bindings::gf
 
     let mut size = layout.size();
 
-    if layout.align() > bindings::BINDINGS_ARCH_SLAB_MINALIGN {
+    if layout.align() > bindings::ARCH_SLAB_MINALIGN {
         // The alignment requirement exceeds the slab guarantee, thus try to enlarge the size
         // to use the "power-of-two" size/alignment guarantee (see comments in `kmalloc()` for
         // more information).
-- 
2.40.1

