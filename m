Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C617ABD57
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 04:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjIWC45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 22:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjIWC44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 22:56:56 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2096.outbound.protection.outlook.com [40.107.10.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA4911D;
        Fri, 22 Sep 2023 19:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBmRLnMDmKXnkrWie6/ke1O8WZn6XVRpKeI3sLCFKIsbqQyx4iwnL+VIZ0dnr3+Q+OaKpImDP2kJXRbuBjN8YJI4rflQo9Oc0NKYlhKtag5IOjJXSHdy+Fl5ULpscupUHR2cfv6iGGxBjxzRDZ9dYCB6B1mPZ8lGvirwNghzQwvjJbs+CWt87JyRwS/CHkx1kjzNxKW6f4o+xAxokqcmz9G7B8AeQsp+dWhxkiGjr/usGbqXOQ8AePKdrhZYxqh3x4Wzw0vuOKbSU0tbS4LuElmiyoxT5Vh8SEW0y79Tlw1n4PpzuZZ04rVr4kzaNnhqQ77u2gJLqfP5yR795dej2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APyEcq9LpkSGYo+YisShjZD4+JncFyKE0WdbTkhGyG0=;
 b=SxXvCyIbBlnqJD67y2wBd1oitwJYm0bCWaME9rpKuhbotTQKnHzc7DBuyo0UgQyPmhN03UykW0oBI77haIp61zwtwS3B5dNlOCi/azL8ckN+PX+Ic9y4F9/vVrjJIhODPKA+xprytlNz4UA+3fPrVrz6CKV+COhrb/RhqogtF9c1kKpL/HeInMIX/fxqqAyAEDAlEaz+04qGziJJAVHBlj3/KPxHzK+a1Vpt2Vf2TapyFt3swL0QK9nfasD8kwWx7wUGQCi6hLOXM/qlW6dG7mi/UxhX+MxjusxpskZbTzlSHp4FP5lwhNG/6cD1ZUEIfg2s7zgbrAnNqwQUDZEwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APyEcq9LpkSGYo+YisShjZD4+JncFyKE0WdbTkhGyG0=;
 b=t/vfHZ82PnM6LjB5hHrbxtsVJHV6Kd/+HyRhm2nMNLzc9ItmvZeIgREWjk9F47LDM4x/5vRtJJyPWzNJiFLvknsJDoQDwq5yYBu6e2F6ftzJQD3uz8fePrfDlJoi538AZwWtChG+1PZcdZz9Ori06BQOM6/OXcPP2mVcbcHlTAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB2183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:80::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Sat, 23 Sep
 2023 02:56:46 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d%6]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 02:56:46 +0000
Date:   Sat, 23 Sep 2023 10:56:24 +0800
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v4 4/7] rust: workqueue: add helper for defining
 work_struct fields
Message-ID: <20230923105624.31215a69@gary-lowrisc-laptop>
In-Reply-To: <20230828104807.1581592-5-aliceryhl@google.com>
References: <20230828104807.1581592-1-aliceryhl@google.com>
        <20230828104807.1581592-5-aliceryhl@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:404:56::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB2183:EE_
X-MS-Office365-Filtering-Correlation-Id: 231107df-1e5b-471a-de8d-08dbbbe0b9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8T3+Cq1xQafcuexku3HIK3dQWCbogFlkUgkFRdY/trOtk4yzzGsdZ4D3AhU1mgfd4PuDCJrtl/5hbcrQuXDJiLri16xpTzfRwNMQuccmwz9KEuengg5j8wri4yIFh7VxTtilFugSVVEYIwwJNt8/KPqN9Zq0wKmj7yQ403yKTDxPSaUzSNJjV2EgBaxDOFQarSk5iW0jrtW+3re6D4RvK0fa1dE/Uo3yeNK7frEsKDZ7S+XhpCaqkTSbjivMDqNuTD57YLXDjU43iznJxOB29wpJs2gyvTZK/U4lXuskIrGbGCEMHPcI7nlQ1f/eHAsTjshx+uuHFTIR/IkouNJ3KSTVFaNT0ay5LdbLtFc8ecxIXxSTmPVYTpAN5QWngr8QxdPVSr5PaCaW9AO/1HK7TBJf0JMS3MCBNU3HCJrvtgoPVM0IM5/b5b4CQzfqiSUhyy4j7iC2rYNd3VABqHhJrMfQ8OSADp+yoiLfX7NsxjEFYVha8qRA+eQ14qinpEziCFTPhdGUcurIJ0/U2VlJcwtcwyzDjE+ywMfFkNIbOwQbE7XKx76ySgOdWPgKWl91
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(39830400003)(376002)(366004)(136003)(230922051799003)(1800799009)(451199024)(186009)(6506007)(6486002)(86362001)(1076003)(2906002)(83380400001)(30864003)(26005)(478600001)(9686003)(6512007)(6666004)(7416002)(8676002)(8936002)(5660300002)(4326008)(54906003)(41300700001)(6916009)(38100700002)(66946007)(316002)(66476007)(66556008)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+KcdKwi81q1EoWIkaBo1zlMjN0VjOuLILxrMLz9kza3qdtlBYUiLMF3ivHzK?=
 =?us-ascii?Q?0+FQ/Hw7u9FXi+X0ykk6TM0lGNkPij9fk4ictbOvYsrkWRzJAo9JM05TeM2M?=
 =?us-ascii?Q?3jsY/Wfk0BfSwiIoC/dF19/CSFzFxDlKu3wM8qnX/l5PiHu+Ux9DG0+2gXZo?=
 =?us-ascii?Q?+dyH9B9VySAa7L2mZkH3cWfJURQofXoiQI+d6gymlTkXoDv3/BvQsa/6M7DA?=
 =?us-ascii?Q?QloeAQxnplIgUhkrkoFaUB531zyX9Lonqsgg3NFPgG1QX1kOoCsKIbtVq31J?=
 =?us-ascii?Q?J9+5TpLeLU8a8peOoeM/b19tM67VyYbi9bkEMVc5lKPHDaDtcbBi8qRGafrS?=
 =?us-ascii?Q?tip2OfL0RokeBOIrE8wgGRA0/reUUXqbo5TXP1MLodzGM7DpzS3L5BbjBc1G?=
 =?us-ascii?Q?YVUdW24FWSo2i25L9z3qunRphwce9zjQb+aFXernE3b5IP22Xk56jYmUNqGX?=
 =?us-ascii?Q?A8FnmsSDMfE8bugbd3TWVp0iXNQhV60H251Vz4JqZlbb65VRVuzGhjTcI76R?=
 =?us-ascii?Q?ju6Kbm3UAs4ISHWG0G7MhxchNNZ8bbaRh4oi3c3qachuCDQgPWhLYad+Qz7x?=
 =?us-ascii?Q?mbxWpXMF4sIyX8UnaHtQe3eAavJygyTBeLcgoOg1l3wi6U6TBB2TL5dqfOIs?=
 =?us-ascii?Q?JB6HI0gT8hqQLd3Wp3693KoAM9MP+1Ii7lsDxMjejqQb5y7R5gsYkO0AOSWj?=
 =?us-ascii?Q?s+sNO1sAFL+YOaeTFfnj7fS+vV6iGU7kBBMOk5rJU1s8N+HhIcbXKrRzFQKh?=
 =?us-ascii?Q?OGV2qi5OS2cpqjQwONUycx1sWQ+hcodvXgKPGyxoq8/QE5prrZ5x4dljae3N?=
 =?us-ascii?Q?k9Czzy3oFPw6G60yHZWDwxTOUfKYxl36yh37UvXx8w1VqzLUxt5TaYY4BxNd?=
 =?us-ascii?Q?uKvCh579amCg4P4ayhlvzp8/l3pYTy5X/gUaf4vzencf14lPnnNLwjyYXROn?=
 =?us-ascii?Q?WFtSQ0BXP8Tiw3/8wNhOixSl/idoYImHH+EsKJCLb9bggpX9bszhIT4tbYLF?=
 =?us-ascii?Q?BuL9wYuA2Ykkkhl63/eX8fGrmtizDOcrSGrs+bZkT5CmgMofwsNtQkmwHhuQ?=
 =?us-ascii?Q?+hIofbEMLaQA56He/FKsik2iSG2zAn6Bd4OgUfARvh73S5CpKHEBgAJFYr89?=
 =?us-ascii?Q?T3u+W2QYDc+fDCE7IU5mLW8IOTb3h1JWF68Yb0iQisGZ/G3qcJtcanhivu3w?=
 =?us-ascii?Q?nfGSdco1ocMZ2O4GgwsfQPKnnn0QX1skvwOnZfeCy6A4gNhHdLyfvTdkEV+B?=
 =?us-ascii?Q?PsG94oLO4ypP4yQ02/oCSJ5n1li/ppqHrRjkqiGrecB5rnWOBxFq93tBkOap?=
 =?us-ascii?Q?4wkYLh0fyUPrzn7sN/OqztjVu88BKBnjFlj0FIYtBS7PI3kRUb9l6oCi1+Ke?=
 =?us-ascii?Q?PVmFmu/CTPrh3q0wIMxNZx8ANzWTUIF1bWdP+2m05U0/9NP8uGle2NyH9ELQ?=
 =?us-ascii?Q?RW1qoNGOALfXVAlGwkfV4wT0ZDshPCz+6kU4di04nPBghIXzOUgP4e+sYI9b?=
 =?us-ascii?Q?VWpcOrAk4tVpvHw8GiQBln+16tyym7kTWyplDxXq0mZTVfU+VRbMYDOYGoeb?=
 =?us-ascii?Q?AgaqvlXcGDzsf55QwE+UgnF9MiBOo6lsqr705Jor?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 231107df-1e5b-471a-de8d-08dbbbe0b9aa
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 02:56:46.6872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggR0NLSHaWmIqLPSVjY86ReZHpA9N+DpxJ7JDTjnnykaOhJuEQw7FQAHHFWYEXHdxXtvVhMi1EtXfJtck5lhDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 10:48:04 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> The main challenge with defining `work_struct` fields is making sure
> that the function pointer stored in the `work_struct` is appropriate for
> the work item type it is embedded in. It needs to know the offset of the
> `work_struct` field being used (even if there are several!) so that it
> can do a `container_of`, and it needs to know the type of the work item
> so that it can call into the right user-provided code. All of this needs
> to happen in a way that provides a safe API to the user, so that users
> of the workqueue cannot mix up the function pointers.
> 
> There are three important pieces that are relevant when doing this:
> 
>  * The pointer type.
>  * The work item struct. This is what the pointer points at.
>  * The `work_struct` field. This is a field of the work item struct.
> 
> This patch introduces a separate trait for each piece. The pointer type
> is given a `WorkItemPointer` trait, which pointer types need to
> implement to be usable with the workqueue. This trait will be
> implemented for `Arc` and `Box` in a later patch in this patchset.
> Implementing this trait is unsafe because this is where the
> `container_of` operation happens, but user-code will not need to
> implement it themselves.
> 
> The work item struct should then implement the `WorkItem` trait. This
> trait is where user-code specifies what they want to happen when a work
> item is executed. It also specifies what the correct pointer type is.
> 
> Finally, to make the work item struct know the offset of its
> `work_struct` field, we use a trait called `HasWork<T, ID>`. If a type
> implements this trait, then the type declares that, at the given offset,
> there is a field of type `Work<T, ID>`. The trait is marked unsafe
> because the OFFSET constant must be correct, but we provide an
> `impl_has_work!` macro that can safely implement `HasWork<T>` on a type.
> The macro expands to something that only compiles if the specified field
> really has the type `Work<T>`. It is used like this:
> 
> ```
> struct MyWorkItem {
>     work_field: Work<MyWorkItem, 1>,
> }
> 
> impl_has_work! {
>     impl HasWork<MyWorkItem, 1> for MyWorkItem { self.work_field }
> }
> ```
> 
> Note that since the `Work` type is annotated with an id, you can have
> several `work_struct` fields by using a different id for each one.
> 
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> v3 -> v4:
>  * The helper was changed to take a name argument, and is implemented
>    directly.
>  * `Work::new` now takes a name argument, and a `new_work!` macro was
>    introduced to help call it.
>  * Use `core::mem::offset_of` rather than a custom implementation.
>  * Fix imports in examples.
>  * Dropped Reviewed-bys due to changes.
> 
>  rust/helpers.c           |  13 ++
>  rust/kernel/lib.rs       |   1 +
>  rust/kernel/workqueue.rs | 257 ++++++++++++++++++++++++++++++++++++++-
>  scripts/Makefile.build   |   2 +-
>  4 files changed, 271 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index ebd69490127b..45cf9702d4e4 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -29,6 +29,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/spinlock.h>
>  #include <linux/wait.h>
> +#include <linux/workqueue.h>
>  
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -137,6 +138,18 @@ void rust_helper_put_task_struct(struct task_struct *t)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
>  
> +void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
> +				    bool onstack, const char *name,
> +				    struct lock_class_key *key)
> +{
> +	__init_work(work, onstack);
> +	work->data = (atomic_long_t)WORK_DATA_INIT();
> +	lockdep_init_map(&work->lockdep_map, name, key, 0);
> +	INIT_LIST_HEAD(&work->entry);
> +	work->func = func;
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
> +
>  /*
>   * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
>   * use it in contexts where Rust expects a `usize` like slice (array) indices.
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index b56aaea3de7a..c537d2edb4c8 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -16,6 +16,7 @@
>  #![feature(coerce_unsized)]
>  #![feature(dispatch_from_dyn)]
>  #![feature(new_uninit)]
> +#![feature(offset_of)]
>  #![feature(ptr_metadata)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 82e3fb19fdaf..da37bfa97211 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -262,7 +262,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
>  # Compile Rust sources (.rs)
>  # ---------------------------------------------------------------------------
>  
> -rust_allowed_features := new_uninit
> +rust_allowed_features := new_uninit,offset_of
>  
>  # `--out-dir` is required to avoid temporaries being created by `rustc` in the
>  # current working directory, which may be not accessible in the out-of-tree
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 6dbc5b9b3da9..251541f1cd68 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -2,9 +2,42 @@
>  
>  //! Work queues.
>  //!
> +//! This file has two components: The raw work item API, and the safe work item API.
> +//!
> +//! One pattern that is used in both APIs is the `ID` const generic, which exists to allow a single
> +//! type to define multiple `work_struct` fields. This is done by choosing an id for each field,
> +//! and using that id to specify which field you wish to use. (The actual value doesn't matter, as
> +//! long as you use different values for different fields of the same struct.) Since these IDs are
> +//! generic, they are used only at compile-time, so they shouldn't exist in the final binary.
> +//!
> +//! # The raw API
> +//!
> +//! The raw API consists of the `RawWorkItem` trait, where the work item needs to provide an
> +//! arbitrary function that knows how to enqueue the work item. It should usually not be used
> +//! directly, but if you want to, you can use it without using the pieces from the safe API.
> +//!
> +//! # The safe API
> +//!
> +//! The safe API is used via the `Work` struct and `WorkItem` traits. Furthermore, it also includes
> +//! a trait called `WorkItemPointer`, which is usually not used directly by the user.
> +//!
> +//!  * The `Work` struct is the Rust wrapper for the C `work_struct` type.
> +//!  * The `WorkItem` trait is implemented for structs that can be enqueued to a workqueue.
> +//!  * The `WorkItemPointer` trait is implemented for the pointer type that points at a something
> +//!    that implements `WorkItem`.
> +//!
>  //! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
>  
> -use crate::{bindings, types::Opaque};
> +use crate::{bindings, prelude::*, sync::LockClassKey, types::Opaque};
> +use core::marker::PhantomData;
> +
> +/// Creates a [`Work`] initialiser with the given name and a newly-created lock class.
> +#[macro_export]
> +macro_rules! new_work {
> +    ($($name:literal)?) => {
> +        $crate::workqueue::Work::new($crate::optional_name!($($name)?), $crate::static_lock_class!())
> +    };
> +}
>  
>  /// A kernel work queue.
>  ///
> @@ -108,6 +141,228 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
>          F: FnOnce(*mut bindings::work_struct) -> bool;
>  }
>  
> +/// Defines the method that should be called directly when a work item is executed.
> +///
> +/// This trait is implemented by `Pin<Box<T>>` and `Arc<T>`, and is mainly intended to be
> +/// implemented for smart pointer types. For your own structs, you would implement [`WorkItem`]
> +/// instead. The `run` method on this trait will usually just perform the appropriate
> +/// `container_of` translation and then call into the `run` method from the [`WorkItem`] trait.
> +///
> +/// This trait is used when the `work_struct` field is defined using the [`Work`] helper.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that [`__enqueue`] uses a `work_struct` initialized with the [`run`]
> +/// method of this trait as the function pointer.
> +///
> +/// [`__enqueue`]: RawWorkItem::__enqueue
> +/// [`run`]: WorkItemPointer::run
> +pub unsafe trait WorkItemPointer<const ID: u64>: RawWorkItem<ID> {
> +    /// Run this work item.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided `work_struct` pointer must originate from a previous call to `__enqueue` where
> +    /// the `queue_work_on` closure returned true, and the pointer must still be valid.
> +    unsafe extern "C" fn run(ptr: *mut bindings::work_struct);
> +}
> +
> +/// Defines the method that should be called when this work item is executed.
> +///
> +/// This trait is used when the `work_struct` field is defined using the [`Work`] helper.
> +pub trait WorkItem<const ID: u64 = 0> {
> +    /// The pointer type that this struct is wrapped in. This will typically be `Arc<Self>` or
> +    /// `Pin<Box<Self>>`.
> +    type Pointer: WorkItemPointer<ID>;
> +
> +    /// The method that should be called when this work item is executed.
> +    fn run(this: Self::Pointer);
> +}
> +
> +/// Links for a work item.
> +///
> +/// This struct contains a function pointer to the `run` function from the [`WorkItemPointer`]
> +/// trait, and defines the linked list pointers necessary to enqueue a work item in a workqueue.
> +///
> +/// Wraps the kernel's C `struct work_struct`.
> +///
> +/// This is a helper type used to associate a `work_struct` with the [`WorkItem`] that uses it.
> +#[repr(transparent)]
> +pub struct Work<T: ?Sized, const ID: u64 = 0> {
> +    work: Opaque<bindings::work_struct>,
> +    _inner: PhantomData<T>,
> +}
> +
> +// SAFETY: Kernel work items are usable from any thread.
> +//
> +// We do not need to constrain `T` since the work item does not actually contain a `T`.
> +unsafe impl<T: ?Sized, const ID: u64> Send for Work<T, ID> {}
> +// SAFETY: Kernel work items are usable from any thread.
> +//
> +// We do not need to constrain `T` since the work item does not actually contain a `T`.
> +unsafe impl<T: ?Sized, const ID: u64> Sync for Work<T, ID> {}
> +
> +impl<T: ?Sized, const ID: u64> Work<T, ID> {
> +    /// Creates a new instance of [`Work`].
> +    #[inline]
> +    #[allow(clippy::new_ret_no_self)]

nit: this line can now be removed.

> +    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self>
> +    where
> +        T: WorkItem<ID>,
> +    {
> +        // SAFETY: The `WorkItemPointer` implementation promises that `run` can be used as the work
> +        // item function.
> +        unsafe {
> +            kernel::init::pin_init_from_closure(move |slot| {
> +                let slot = Self::raw_get(slot);
> +                bindings::init_work_with_key(
> +                    slot,
> +                    Some(T::Pointer::run),
> +                    false,
> +                    name.as_char_ptr(),
> +                    key.as_ptr(),
> +                );
> +                Ok(())
> +            })
> +        }
> +    }
> +
> +    /// Get a pointer to the inner `work_struct`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must not be dangling and must be properly aligned. (But the memory
> +    /// need not be initialized.)
> +    #[inline]
> +    pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
> +        // SAFETY: The caller promises that the pointer is aligned and not dangling.
> +        //
> +        // A pointer cast would also be ok due to `#[repr(transparent)]`. We use `addr_of!` so that
> +        // the compiler does not complain that the `work` field is unused.
> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).work)) }
> +    }
> +}
> +
> +/// Declares that a type has a [`Work<T, ID>`] field.
> +///
> +/// The intended way of using this trait is via the [`impl_has_work!`] macro. You can use the macro
> +/// like this:
> +///
> +/// ```no_run
> +/// use kernel::impl_has_work;
> +/// use kernel::prelude::*;
> +/// use kernel::workqueue::Work;
> +///
> +/// struct MyWorkItem {
> +///     work_field: Work<MyWorkItem, 1>,
> +/// }
> +///
> +/// impl_has_work! {
> +///     impl HasWork<MyWorkItem, 1> for MyWorkItem { self.work_field }
> +/// }
> +/// ```
> +///
> +/// Note that since the `Work` type is annotated with an id, you can have several `work_struct`
> +/// fields by using a different id for each one.
> +///
> +/// # Safety
> +///
> +/// The [`OFFSET`] constant must be the offset of a field in Self of type [`Work<T, ID>`]. The methods on
> +/// this trait must have exactly the behavior that the definitions given below have.
> +///
> +/// [`Work<T, ID>`]: Work
> +/// [`impl_has_work!`]: crate::impl_has_work
> +/// [`OFFSET`]: HasWork::OFFSET
> +pub unsafe trait HasWork<T, const ID: u64 = 0> {
> +    /// The offset of the [`Work<T, ID>`] field.
> +    ///
> +    /// [`Work<T, ID>`]: Work
> +    const OFFSET: usize;
> +
> +    /// Returns the offset of the [`Work<T, ID>`] field.
> +    ///
> +    /// This method exists because the [`OFFSET`] constant cannot be accessed if the type is not Sized.
> +    ///
> +    /// [`Work<T, ID>`]: Work
> +    /// [`OFFSET`]: HasWork::OFFSET
> +    #[inline]
> +    fn get_work_offset(&self) -> usize {
> +        Self::OFFSET
> +    }
> +
> +    /// Returns a pointer to the [`Work<T, ID>`] field.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must point at a valid struct of type `Self`.
> +    ///
> +    /// [`Work<T, ID>`]: Work
> +    #[inline]
> +    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> {
> +        // SAFETY: The caller promises that the pointer is valid.
> +        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut Work<T, ID> }
> +    }
> +
> +    /// Returns a pointer to the struct containing the [`Work<T, ID>`] field.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The pointer must point at a [`Work<T, ID>`] field in a struct of type `Self`.
> +    ///
> +    /// [`Work<T, ID>`]: Work
> +    #[inline]
> +    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
> +    where
> +        Self: Sized,
> +    {
> +        // SAFETY: The caller promises that the pointer points at a field of the right type in the
> +        // right kind of struct.
> +        unsafe { (ptr as *mut u8).sub(Self::OFFSET) as *mut Self }
> +    }
> +}
> +
> +/// Used to safely implement the [`HasWork<T, ID>`] trait.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::impl_has_work;
> +/// use kernel::sync::Arc;
> +/// use kernel::workqueue::{self, Work};
> +///
> +/// struct MyStruct {
> +///     work_field: Work<MyStruct, 17>,
> +/// }
> +///
> +/// impl_has_work! {
> +///     impl HasWork<MyStruct, 17> for MyStruct { self.work_field }
> +/// }
> +/// ```
> +///
> +/// [`HasWork<T, ID>`]: HasWork
> +#[macro_export]
> +macro_rules! impl_has_work {
> +    ($(impl$(<$($implarg:ident),*>)?
> +       HasWork<$work_type:ty $(, $id:tt)?>
> +       for $self:ident $(<$($selfarg:ident),*>)?
> +       { self.$field:ident }
> +    )*) => {$(
> +        // SAFETY: The implementation of `raw_get_work` only compiles if the field has the right
> +        // type.
> +        unsafe impl$(<$($implarg),*>)? $crate::workqueue::HasWork<$work_type $(, $id)?> for $self $(<$($selfarg),*>)? {
> +            const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
> +
> +            #[inline]
> +            unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_type $(, $id)?> {
> +                // SAFETY: The caller promises that the pointer is not dangling.
> +                unsafe {
> +                    ::core::ptr::addr_of_mut!((*ptr).$field)
> +                }
> +            }
> +        }
> +    )*};
> +}
> +
>  /// Returns the system work queue (`system_wq`).
>  ///
>  /// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are

