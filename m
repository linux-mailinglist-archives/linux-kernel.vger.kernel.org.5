Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51B27ABD4F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 04:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjIWCre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 22:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjIWCrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 22:47:33 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2124.outbound.protection.outlook.com [40.107.10.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1768DC6;
        Fri, 22 Sep 2023 19:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFxT332vNt7QOftbOfhKHtsWak1dx0idfIBdG+ZW2CTVaTdWhRjNE638VoIB+cAIsv8Klfam2xKH+1CfcMoZXyrjem5K1315/1fKUrv6yGgu9lZhcRDZo5wgXAbN2zkJZRJBS1v5idRXe1lW9CJQEGhTjxpHJy4KbI5WpupOkqriZHCyziaNr8ilKkPWDkZmN1vWhHBJouNncXcaIGyViiEmfovpVCoglyJIv+4sbag2vM/Db6k2dxNJO31plcvr+CwhR9Z2yDV7h45f6TiFw/YDTu6P2x5JR3CvcyOTdzHs2u8nDx0kAC7FJi9kPmLBPZpADJrH5ua3IakAR+Ij+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQhPvmjeqcV7ZRA5qxxeY7lCVc7tueWDOmoSoyUtvoc=;
 b=C8JL54ccatC3kU2IoMe0vw+lAGUYiIxILLX8rBmqfcRaSDRA4PFzltvuQUOTdmKia/XaXyANnD3P1R1x092/vjSGWKDyv25YPbPJUmGnF1bvf01lYgS9jgWkWZ0++WLVrzqRfRcR9xpcr4zul9N9ydLUZp0DdTWCN1JFDiB+aGuMhU81UcD8syKx/JwgPzr+KGTMqiuiyM3ak0xUac6qCwwrHM4M8puLGeMV6KJ1rFkyPuAA1rmqnw1S7v3WBs0Fi6KqFV/TDSwiuvwmllf4aEuIdClk9mUofq6ZZ+iipVBX54yh6qigJVhSjyuN3A2sd0inKYzP6Hzik3Jk+ZdJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQhPvmjeqcV7ZRA5qxxeY7lCVc7tueWDOmoSoyUtvoc=;
 b=iV7jA1kPg6sMKd2zhtKMtMvHX9Fw2CWmCUl0hb9vRitWjXCQGJlFQurMUqfQ0+7FOwR3XAJpQphgvFw8R3u275MSYfY4VUoBUYIwOrP7KHZSR6JxEGhXFO/ijNlYLDd/O49e4oSLRb0628rp1O1l2oesqp8m7Svt60Vhm+npHI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6632.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:30a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Sat, 23 Sep
 2023 02:47:21 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d%6]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 02:47:21 +0000
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
        Ben Gooding <ben.gooding.dev@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rust: remove ignores for `clippy::new_ret_no_self`
Date:   Sat, 23 Sep 2023 10:46:50 +0800
Message-Id: <20230923024707.47610-1-gary@garyguo.net>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: c0af1d5a-ac0a-47df-7b06-08dbbbdf68b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IAayHz2K8ZkaqwRY+D5/V9l9OE/8Aj1mQ1GFpj/Usnwo37XW6nYIQUbIFGFDnxzUDY5MIS3a+wcp9HkH5DZB6N2PwCeNUL6xm8kQQNSVUfIHGZVffU7M/qWB38S1Cc+lutEp5Vy2XeW39KHb0TQ0ExLhaIO+A5QoenXEyJUFtxaEt9CD4Ds+OmQbymbgvAK052hAB5iHqjzkB4IHW6mjpP8RbD1tBrMYXtSRAK4tApWmxLchbrIeqznggR6EEi170KLvRX9v52Lw9vD+ko36J0oAPpu835C3FksbGFPO5ojmOBn+prY4RmJyzRq1Pnq6KM81Qvn6UKhrS7UvtGx1DZDBSQ4zuOMqQuvQFK8QZ4jMCOTxJcv6m+1C6CQnlOe7w7D8EKZFZ8re45SNI8Cu5bxSU6YxsJSFhA03XO/mxBOdnTgGqB5YXZe0p8K0c44PsjWDJCfaXNQjSFcv6SVpjjuKOENskoV8Pw6g5KHndQoW6mdw8ezAlGDbJ4Erze4TWFgH73zbNpM+bWDJv46INydXumKh0aXh9Xgl7o9lupynFEKQw2oSxo9q/9zLm+0T9nn/ngGy6WWk8qaUmiQ8/AjXFD0mb0cnDrMFqXk1CXQWvgoxF1eTpVeyKdqcBgG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39830400003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(7416002)(5660300002)(8676002)(8936002)(4326008)(41300700001)(316002)(2906002)(66556008)(66946007)(110136005)(66476007)(478600001)(6666004)(6486002)(6506007)(6512007)(2616005)(26005)(1076003)(83380400001)(86362001)(38100700002)(36756003)(921005)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9DcBqdBCT9piBijnAocXXG6oxavrpPkkMnLIjOzJfzP3S1CcyGR9DCgSHyVu?=
 =?us-ascii?Q?1eaxG0s3q3UPrYb68V7TEJt0+ppa7nzUuhgkQfnhwHtcxbm+Vk5E9GuLNsQG?=
 =?us-ascii?Q?5zoIF/GD0YIJPBs1OdRuVyXlNNSUAkUiKP43H3r6+u4P6txttSGjYUYD/uVP?=
 =?us-ascii?Q?hTpaCyXu5pDXer2RsBnH2VSIaxGIc69U8QYUkCyku9ro8/XVSC9u/+U1KOc6?=
 =?us-ascii?Q?BGxzzXPHMLlGh6DmsU8ADrFCigvFZc5Ie5QerQUIQl0FCeBf7anry8rSI4UW?=
 =?us-ascii?Q?vUgPXkmTsMepEd0aeVgEqmtifnoc2RgrBU1js6261ZJUKXl/2vvcGY90bLkq?=
 =?us-ascii?Q?ZjpFnoB8PEiPNPiCR0HD2CWoXt6lhL/z3L6erMtW+AANbCnB3f5OinCFmc9w?=
 =?us-ascii?Q?L+gP7jBWiwIFa3kgm8BMRHX2v0s0ubOWElZAuC4EmOuOVxsYpiwww1VCUtT9?=
 =?us-ascii?Q?lQm0NSsZQHXDp1p3oHdx0QwaxZp2qJFiGLQMpxs9/rRFIAwqIUqaUjKHQHOI?=
 =?us-ascii?Q?hEKngh7qZt4unfQ6mxYr2pCOvuUskSsXepfCRAFBAnGp4Oa4nOC8J0dT/xk+?=
 =?us-ascii?Q?HOzygA8pYIVAP48p6hd4xBUpLs7JmQh0uFqrQqyfnMeTI0pZeS8E+gTdFocN?=
 =?us-ascii?Q?i92/JDSleZLSxGlM6PTXNOmnhKVDByfLPFLW6YDAdlpF4LvVHQow9dOyR8nQ?=
 =?us-ascii?Q?SZTtWTxOh9IfezyJ0vLR5eZ42JoX5EZNZ7L/1dyJ4qLnaVtwV4FMrHcRfL6l?=
 =?us-ascii?Q?JKKWQNppUqycxIBHqyNSav0KKgfTvofiov8mWS5FPFT2DE82QAuBPepSl9+i?=
 =?us-ascii?Q?Rn3z45I65u2qSFT1VT1TTssLbWgrvV5MgMJe8kMmGc45vzP8nrQDwXikVzs7?=
 =?us-ascii?Q?L7jrncgvmqw7QefbAVzK98s7es4B5enowP53+U7HPDYVlSFtTH/gFrR0qVdo?=
 =?us-ascii?Q?NhpAOTR8KLp6STieGYebO01q1awvlNK+oS/hnOpcew2X0YgXEAiA4ct2cV06?=
 =?us-ascii?Q?v9Jg5/exW4hjU6vwlBVyfF0lutFylZqdXIfx8AnV/rDtA+bjjbC+1A1nSbYV?=
 =?us-ascii?Q?DOZn7ApW5NNCi6NCoSY2tqnmyT7jX5x26+ljOoaHdZ+0RS9jsEu6a1wwhIqz?=
 =?us-ascii?Q?FYUFcj9+knPv8SDlBFCpsKLyLAKnsEPNWqi6pM1HrFV7mED7EiblOH/4Exam?=
 =?us-ascii?Q?+2RRY8NqZd9Qxrhq3flGe7P5pa5R4QN3XXSf1tiTixaXHmtbXnDWkLEYDd8v?=
 =?us-ascii?Q?yXHDwMV73kriU6CVEM22kXHhWg9rZGNAS5gLd4WEESM8yQdjZyEZvbLqHq4+?=
 =?us-ascii?Q?shzOHlHBHWmY8jt6FpAHFsZxTCqVXStl6ghkIqZ0tig620NoBZ0OvSpnWMK8?=
 =?us-ascii?Q?PpgpRJ99Iwjt7JvKYGNzT2Ae8NBmkfBwAVSjKHRDtRBE94PXn1/UoakHbW13?=
 =?us-ascii?Q?/uYQHQ9Nso1PiGfd/hLx09yHOi5NFLZ5f6FdtBOtxZFhTLu6PxySYugjKc0h?=
 =?us-ascii?Q?Z32RF/qf54XOQ3F7DI5LzuuUk/F3+Wde/ImkoagSNsSt9ny+mIXvM0Ps8bcg?=
 =?us-ascii?Q?/NseXP05OTpLAXs09jNT2wnfr76gWnP3Tg/9A6tR?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c0af1d5a-ac0a-47df-7b06-08dbbbdf68b1
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 02:47:21.3610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOjvGaLIt/eQ0dwjWBiRjWbQEv1O1CTvSMvZ3MIdyd/f1SystLBJPbwNwYAA+aTKGJdcp4L18lpRp5u/411fNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6632
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clippy false positive triggering `new_ret_no_self` lint when using
`pin_init!` macro is fixed in 1.67, so remove all `#[allow]`s ignoring
the lint.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/init.rs         | 20 ++++++++++----------
 rust/kernel/sync/condvar.rs |  1 -
 rust/kernel/sync/lock.rs    |  1 -
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 4ebb6f23fc2e..65be9ae57b80 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -35,7 +35,7 @@
 //! that you need to write `<-` instead of `:` for fields that you want to initialize in-place.
 //!
 //! ```rust
-//! # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+//! # #![allow(clippy::disallowed_names)]
 //! use kernel::{prelude::*, sync::Mutex, new_mutex};
 //! # use core::pin::Pin;
 //! #[pin_data]
@@ -55,7 +55,7 @@
 //! (or just the stack) to actually initialize a `Foo`:
 //!
 //! ```rust
-//! # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+//! # #![allow(clippy::disallowed_names)]
 //! # use kernel::{prelude::*, sync::Mutex, new_mutex};
 //! # use core::pin::Pin;
 //! # #[pin_data]
@@ -86,7 +86,7 @@
 //! To declare an init macro/function you just return an [`impl PinInit<T, E>`]:
 //!
 //! ```rust
-//! # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+//! # #![allow(clippy::disallowed_names)]
 //! # use kernel::{sync::Mutex, prelude::*, new_mutex, init::PinInit, try_pin_init};
 //! #[pin_data]
 //! struct DriverData {
@@ -236,7 +236,7 @@
 /// # Examples
 ///
 /// ```rust
-/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+/// # #![allow(clippy::disallowed_names)]
 /// # use kernel::{init, macros::pin_data, pin_init, stack_pin_init, init::*, sync::Mutex, new_mutex};
 /// # use core::pin::Pin;
 /// #[pin_data]
@@ -288,7 +288,7 @@ macro_rules! stack_pin_init {
 /// # Examples
 ///
 /// ```rust,ignore
-/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+/// # #![allow(clippy::disallowed_names)]
 /// # use kernel::{init, pin_init, stack_try_pin_init, init::*, sync::Mutex, new_mutex};
 /// # use macros::pin_data;
 /// # use core::{alloc::AllocError, pin::Pin};
@@ -314,7 +314,7 @@ macro_rules! stack_pin_init {
 /// ```
 ///
 /// ```rust,ignore
-/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+/// # #![allow(clippy::disallowed_names)]
 /// # use kernel::{init, pin_init, stack_try_pin_init, init::*, sync::Mutex, new_mutex};
 /// # use macros::pin_data;
 /// # use core::{alloc::AllocError, pin::Pin};
@@ -366,7 +366,7 @@ macro_rules! stack_try_pin_init {
 /// The syntax is almost identical to that of a normal `struct` initializer:
 ///
 /// ```rust
-/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+/// # #![allow(clippy::disallowed_names)]
 /// # use kernel::{init, pin_init, macros::pin_data, init::*};
 /// # use core::pin::Pin;
 /// #[pin_data]
@@ -411,7 +411,7 @@ macro_rules! stack_try_pin_init {
 /// To create an initializer function, simply declare it like this:
 ///
 /// ```rust
-/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+/// # #![allow(clippy::disallowed_names)]
 /// # use kernel::{init, pin_init, prelude::*, init::*};
 /// # use core::pin::Pin;
 /// # #[pin_data]
@@ -438,7 +438,7 @@ macro_rules! stack_try_pin_init {
 /// Users of `Foo` can now create it like this:
 ///
 /// ```rust
-/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+/// # #![allow(clippy::disallowed_names)]
 /// # use kernel::{init, pin_init, macros::pin_data, init::*};
 /// # use core::pin::Pin;
 /// # #[pin_data]
@@ -466,7 +466,7 @@ macro_rules! stack_try_pin_init {
 /// They can also easily embed it into their own `struct`s:
 ///
 /// ```rust
-/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
+/// # #![allow(clippy::disallowed_names)]
 /// # use kernel::{init, pin_init, macros::pin_data, init::*};
 /// # use core::pin::Pin;
 /// # #[pin_data]
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index ed353399c4e5..b679b6f6dbeb 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -91,7 +91,6 @@ unsafe impl Sync for CondVar {}
 
 impl CondVar {
     /// Constructs a new condvar initialiser.
-    #[allow(clippy::new_ret_no_self)]
     pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
         pin_init!(Self {
             _pin: PhantomPinned,
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 70a785f04754..f12a684bc957 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -99,7 +99,6 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
 
 impl<T, B: Backend> Lock<T, B> {
     /// Constructs a new lock initialiser.
-    #[allow(clippy::new_ret_no_self)]
     pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
         pin_init!(Self {
             data: UnsafeCell::new(t),
-- 
2.40.1

