Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACBD76E439
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbjHCJV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjHCJU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:20:56 -0400
Received: from out0-217.mail.aliyun.com (out0-217.mail.aliyun.com [140.205.0.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E70F2D43;
        Thu,  3 Aug 2023 02:20:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047211;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---.U7ZWN6a_1691054412;
Received: from 30.177.49.237(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.U7ZWN6a_1691054412)
          by smtp.aliyun-inc.com;
          Thu, 03 Aug 2023 17:20:13 +0800
Message-ID: <e7c4a61b-19dd-1bb5-e0a5-7cb55286c994@antgroup.com>
Date:   Thu, 03 Aug 2023 17:20:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] rust: macros: fix redefine const_name in `vtable`
To:     Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     <alex.gaynor@gmail.com>, <benno.lossin@proton.me>,
        <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
        <linux-kernel@vger.kernel.org>, <ojeda@kernel.org>,
        <rust-for-linux@vger.kernel.org>, <sergio.collado@gmail.com>,
        "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        <wedsonaf@gmail.com>
References: <20230626074242.3945398-2-changxian.cqs@antgroup.com>
 <20230802195020.3062950-1-aliceryhl@google.com>
 <20230802210208.4dce7501.gary@garyguo.net>
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
In-Reply-To: <20230802210208.4dce7501.gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 4:02 AM, Gary Guo wrote:
> On Wed,  2 Aug 2023 19:50:20 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
>> Qingsong Chen <changxian.cqs@antgroup.com> writes:
>>>      let mut body_it = body.stream().into_iter();
>>> -    let mut functions = Vec::new();
>>> +    let mut functions = HashSet::new();
>>
>> Please use a `BTreeSet` instead of a `HashSet`. A `HashSet` has
>> non-deterministic iteration order, so this will make the macro output
>> different things each time you run it.
>>
>> Alice
>>
> 
> Good point.
> 
> Another way is to just use the existing `consts` HashSet to avoid
> duplication. Something like
> 
> 	consts.insert(gen_const_name);
> 
> after emitting the const item would probably be sufficient.

According to the suggestions of Alice and Gary, we could do the fix
like this:

--- a/rust/macros/vtable.rs
+++ b/rust/macros/vtable.rs
@@ -1,7 +1,7 @@
  // SPDX-License-Identifier: GPL-2.0

  use proc_macro::{Delimiter, Group, TokenStream, TokenTree};
-use std::collections::HashSet;
+use std::collections::BTreeSet;
  use std::fmt::Write;

  pub(crate) fn vtable(_attr: TokenStream, ts: TokenStream) -> TokenStream {
@@ -28,7 +28,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: 
TokenStream) -> TokenStream {

      let mut body_it = body.stream().into_iter();
      let mut functions = Vec::new();
-    let mut consts = HashSet::new();
+    let mut consts = BTreeSet::new();
      while let Some(token) = body_it.next() {
          match token {
              TokenTree::Ident(ident) if ident.to_string() == "fn" => {
@@ -74,6 +74,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: 
TokenStream) -> TokenStream {
                  const {gen_const_name}: bool = false;",
              )
              .unwrap();
+            consts.insert(gen_const_name);
          }
      } else {
          const_items = "const USE_VTABLE_ATTR: () = ();".to_owned();
