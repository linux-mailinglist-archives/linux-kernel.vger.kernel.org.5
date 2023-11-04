Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116157E0FFD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 15:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjKDO6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjKDO6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 10:58:09 -0400
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2138.outbound.protection.outlook.com [40.107.121.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F854136;
        Sat,  4 Nov 2023 07:58:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRJoJjBvsk2s4h2F7ynQJoSmcT2b6wg/N9Wgfbdq9JS5Bf+odNtDSfzE3Q5q4D99ms4t2HghIFVSG9ZP+YXPJDnvZE2ue7n5d1PfcYW8MO6fXH5iwtcTjd4ymV2CP+XYuf6ufHV9sTwFhT7eR9BRcimSvXCEMsXK70csN3eT9EqJW7SP5UZuNQmRMYAf4oMFOEnmM4QARW8h8PvteUCEpaU27PykMbC8wo6mwuxhbunLNeP7TBQeR/2pCxD2WIJRq1idplFIJJPUxfOJ+u/l0EdQ7f4VuKmL8LD0K39c+NVV266t/Z3AMC1zhfMvDXyONVbkY5JO5pUCAUgamxFnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9s1hzLmxTaKH8A4FfgTU4rD6Ptfrz1EDgYULeKNc28=;
 b=Gnh4SnTxy+HIORU8M+QuPqUMH1g7gsaSSSHe5cGT5KT4GjaLdhVYyNSdL0n4vr2NC8Je1Iygqug0A1f48UiXT4bbG0Z5tZ3uc1boO9Dz5MghHIwm/3wUDZpUAxZWLbUWbwPrGGmN9DKvaSqliZk9vDvgAi6E4YY2FoCD1bb34K9YbzAb6S8/b0xWCmRp2pLHn/MFtHDNy+oev18Pe8AFWxAOfRp5Gr8kI0U38QT1cN0DACIJOcroEVdxaauTCMXpszGXVD+oDfjRKp/VtVAOlHHjaQ1+70V430J/yCJkjdNymIfpTbLNiVYZ/E2Xoa5kZMh5N7M2HDzKlmJweCn6YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9s1hzLmxTaKH8A4FfgTU4rD6Ptfrz1EDgYULeKNc28=;
 b=KtfpM6U1ILQO8s3f/PMHAzNjSlgqPL+wYAKqX39SwGcoz7DeSNMnty90zY7E/rQXyLONs544++mAG7mvIScBT1pTD8mTrBixmYUjp1rEKxsEIKz1lGiqLX8p4bfk4L0ySihgOp42i4/7KqSUm7931VTg4Z/I9KK8e2V171VM7bE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6012.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:29e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Sat, 4 Nov
 2023 14:58:03 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6510:fdc7:1dc3:98c2]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6510:fdc7:1dc3:98c2%4]) with mapi id 15.20.6954.025; Sat, 4 Nov 2023
 14:58:03 +0000
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
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc:     Wedson Almeida Filho <walmeida@microsoft.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust: bindings: rename const binding using sed
Date:   Sat,  4 Nov 2023 14:56:56 +0000
Message-Id: <20231104145700.2495176-1-gary@garyguo.net>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: fbbd5a5f-3b1a-44ac-ea67-08dbdd467212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGQApOaF/5BRQcq4xQq9phBEdvQmSt0K/svz9N2rZUljWknVv1I2IVTDZsexoMcNdNCkdRl4QNfefAoObvy2b50SVTFCsdyS6bqqcvD+1/xLT0dU8nzdwMtbvqUQlhZXUn8nd1fyNVSDCpmDT+UszGPV5Mt6oqfmEjfCipXpb7wntEpATr9qmKKOAqtrv//f6oPdLaoTMTdXypiguhHGBMWJTobl9ypUXVOVRGO2WtgWHJ3ddu6wZd6pnHqGAofWvrkwhzV3syq+UsFa88QyD8Dx+vh7swcDxKdykQ/Al6C9NasdjU0P4s0+0EiWZGWtWeJtkFNf38hd6UAf6U94qYM8leaFzQgiZVaHppC3il7DudcJvVqcIU79MpHKwv4pAjyWl0eKpjMlWiH48yAGvPbSK8tygbI7tnE9o/MBO4uOHiKq91mWhb5OIsCU2tiem8ePcNbu7YLXkjZXpc97qOGgWYX9WhXiA2hNa4MKfJGxxuxk5oz4vGww2PqJJothDwxuDhpU1jElN0lWQx0TKEsWUb7jodpV+HlqXfMA8PdiRaP/QCobqe7EfyAucJfoyJUr9vwROvMQxjZlt0sHedb7dm7L3k6cfMRj+/dcqYo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39830400003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6666004)(6506007)(921008)(36756003)(86362001)(38100700002)(478600001)(2906002)(1076003)(6486002)(6512007)(2616005)(83380400001)(110136005)(54906003)(316002)(4326008)(8676002)(8936002)(66946007)(5660300002)(7416002)(66556008)(66476007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?smzAKmZDZuMXtlbVo+BkWAXH2MNQAtZ5M0Q9+ChGjdUrpli+DUtL0KLq1F2w?=
 =?us-ascii?Q?WjXksFdqxmFHx7sD7GyRadzUNl9dl0qZZOBDgrDyolZb/o+awzjja0xjUZLB?=
 =?us-ascii?Q?fbWb/XM2bZDtEp86NFYMcDqfL/xyXSGp3IkA+I02y1eGZoL747hOuTGnAHvC?=
 =?us-ascii?Q?MTUq5ifeS95Cr1s0bDb5Ef1ZK8RKYgVjA7us7xs8fpvXIa/v2v5TTrHt79nw?=
 =?us-ascii?Q?hiw7dxuEzlQMbuebj/HEf9tubnwhTX74QZ8W91EY35e8YgrF53KDcczR2kJX?=
 =?us-ascii?Q?YjROAvf3sbgUzFrjfA8B30CzPggKVYQHcOtK285y68F6CuU0O9NJcdh9NUbG?=
 =?us-ascii?Q?+aW2gmBA/RjF4nJeg3q4/VwWz1sC5yfZ0zEiy9WqfrIQZR7zJCs5jE8ErTRk?=
 =?us-ascii?Q?W9tfJH1lk4Hha3vOsvbWPn9VqIktXg4K3Tgg0z0wS7kxfKOvgetlHATkgSwM?=
 =?us-ascii?Q?xLxLoymLKKPC8+Sh6ZWPTP9jkG+IojqKgaPLzY7nw+H5WbPE68mFupWNx2Ia?=
 =?us-ascii?Q?z1OF9QanuftqDyEQm/OyzsGjeUzLAlPrHrLz5xd/LbvYJndHW9lpZvK9tvUy?=
 =?us-ascii?Q?HfpWkK+0GPsSI9X4a7M/Vry7YBbkD3RADC+IbaDp9qk8wHqNJcMVjOSyL4AU?=
 =?us-ascii?Q?g3Jr0+uI1uibLyVU4zZTvr3PeFIg1yPtg139KM/EGZ7tc44X1hSsxORaUjvZ?=
 =?us-ascii?Q?wfT3wdHioOWc0jQcVcnj8PnXawHtqm9BGTBfRKHmlFkynGCyajcrxsaBl7j6?=
 =?us-ascii?Q?UkPERIgW93KFT75zQ7ofqalFJxXcCcbjZhgYrD6TEveM5hmIejBhVHunVc0/?=
 =?us-ascii?Q?ne7CK21AV+zLa+qvBM2Spuahq3mGkOnkXkIQh5Jz8o96pW73CqcdIFuMwKO1?=
 =?us-ascii?Q?7VVXZFbhSJ5CexGdx2VSHFyYcwGY1x9JTtLkVwSERe1Ze4Kf65iWHvPV+7I3?=
 =?us-ascii?Q?vCncKRssB8WgZbPjXhDiP32OIAHnni5gy17VzGMTLlP9b/w6MSy5++pPFRn3?=
 =?us-ascii?Q?V6jwzvy6FSZRSNL8gyNkggUVV5komvA7A7FZIhONa8o8IYDd95u4RPudgCSn?=
 =?us-ascii?Q?1Ki4dPTnJ7JPD0jNNZ7+6vyDA7GPxDrQpXlCy5GHPf/EeVlTEiqyOyH5BfMp?=
 =?us-ascii?Q?/vMkj5SDAoBltmIz4yVHphGTFO8IC2EnSUThYo73BKpB1GEgYoIfzpR1Qwgb?=
 =?us-ascii?Q?r8iH+x6tS28L6tF5ncpblAlHM3XQ8g/I3IgTaWLv3dA+bkrX4pRDCNelro1a?=
 =?us-ascii?Q?v0D/lUiv8T8PUI811A8gLyUoTERD3uuEzvVzSQ8+KQiCim1SNz9ear7Yyf7w?=
 =?us-ascii?Q?+bcGx8poinARHAR682065zqgdg8OQPVzunEEvIm3YOdu17Nj2wscmGWDVyAa?=
 =?us-ascii?Q?J+MrQsEjy14YvXhZ94IfTNrtahzHnJ3/Jv2lfO5EALaBgkMPGN7NRFEL4yQH?=
 =?us-ascii?Q?WVuvcajv7HRjZ+BMZ21qcGUK4NCVNYwZr24P5OFZ9/YnaQ/BLwghqqCoa7JU?=
 =?us-ascii?Q?fePWiLOoTuS/qUWJcqDfZZ5qltsMSp6wqkVdnru7KLC3mfw97PoGGr2AITpf?=
 =?us-ascii?Q?PBUFciTcFLbnq7jGgoXRUW4p1TWSa7Ij4nq2sRTTTInQjOY3e/igazfBVayw?=
 =?us-ascii?Q?+abibzft5jA0QptUoadtE13oerqnZLxdzlWg54pWI2Cx?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbd5a5f-3b1a-44ac-ea67-08dbdd467212
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 14:58:03.5933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnitynQhL1+ioTFC3ONuUbg3n0odMSWN7/VXlDVyascEDL+KZUHMM7pCHt9gD0PaeJWGulIO88mKfTK14WmY1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

    const <TYPE> RUST_CONST_HELPER_<NAME> = <NAME>;

and then use `sed` to postprocess Rust code by generated by bindgen to
remove the distinct prefix, so user of the binding crate can refer to
the name directly.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
v1 -> v2:
- Changed `RUST_BINDING_` to `RUST_CONST_HELPER_`.

 rust/Makefile                   | 2 ++
 rust/bindings/bindings_helper.h | 6 +++---
 rust/bindings/lib.rs            | 3 ---
 rust/kernel/allocator.rs        | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index a27f35f924ec..57f7f5e5a95d 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -337,6 +337,8 @@ quiet_cmd_bindgen = BINDGEN $@
 
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
     $(shell grep -Ev '^#|^$$' $(srctree)/$(src)/bindgen_parameters)
+$(obj)/bindings/bindings_generated.rs: private bindgen_target_extra = ; \
+    sed -Ei 's/pub const RUST_CONST_HELPER_([a-zA-Z0-9_]*)/pub const \1/g' $@
 $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
     $(src)/bindgen_parameters FORCE
 	$(call if_changed_dep,bindgen)
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index c91a3c24f607..bfa0fa794dae 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -14,6 +14,6 @@
 #include <linux/sched.h>
 
 /* `bindgen` gets confused at certain things. */
-const size_t BINDINGS_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
-const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
-const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
+const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
+const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
+const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
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

base-commit: 3857af38e57a80b15b994e19d1f4301cac796481
-- 
2.40.1

