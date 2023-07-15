Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173637549D2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGOPdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGOPdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:33:31 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2114.outbound.protection.outlook.com [40.107.10.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555B92D7B;
        Sat, 15 Jul 2023 08:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcP8H/ROzS4NpdrDvaBv31jFV1rmSrPIuDUhdbWq6vZYLNz3eDJOgzC2c1NYzHRbD/WLfDR64ULRBvcE2qDRVbDAAyBi/AZjoX+/4tZI+OU59MYlYwHWNTa4UT4FavaiC+tqn+T7rF15vLSUj0FVi+rLsq2+Rk8KMH3FyYvs7FoYRthtSSJ270ssnrt25JWQNR5xwPZ1bcuLpoH0XH1N6h0HSg72tsRGGqUUuPn41MQ4uwId/F5GRV2HzglRT2YJmRgdK5e0CKo/24+OS7Y9E01ZFXS6HnubDJ69sHkLzCseRAT3QjqnohY39A1WlsZnA+pT0zI/bcRbIpjjE6p2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awJzxiqI7DffwN51fCYaXyH9+qrvpBxlYteVmOZ3fwg=;
 b=eDoeNnaDdPp17MYP0uCQMBmotzc01NxC9kzKjrXIywkifu3EvoEIQDpC1vfWqsHNvUwtV3yCRiFLkPuzKE53cV2TKa7EM0t9RWBycQPAtDo5+EpuV4v/nLcbDMOHNBZPA7NDaR7qK9FyXP1M8rm4IPLaqxrM9CqoGaWcQsvpZXLO5ZH3JjD7y5cbJY9eO22AC0AGUajGwxGRgZJYtNUmsGEfsQmlSUtMSnxxfIsXSz+fEpfD6yEYG76JwlIPu9ig5AKMjivMEg5GP1V7Bp4tvnyoAvS1WdLW4RxpnHkg1/346fahxHrKjWZ0dQlM7UjEQH6uTViNgY3hLsc64AeaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awJzxiqI7DffwN51fCYaXyH9+qrvpBxlYteVmOZ3fwg=;
 b=BVnYhmgVq+R986sdx3Eo2yOlLYFVHWmLiJEYw3isHpuj4ig1Lo8NgB+ELbn2SfKqXjZKcjdKKokn4HIHJAIzwqRxrpIzUG/0E21CUTGJmnVmgAcktjClZgAOk6kUxOq6cHuIZ8N8qLCk/7pJsnSvSKss7PriADygy17rQ41lV4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB7163.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sat, 15 Jul
 2023 15:33:26 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 15:33:26 +0000
Date:   Sat, 15 Jul 2023 16:33:24 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Josh Stone <jistone@redhat.com>,
        Gaelan Steele <gbs@canishe.com>,
        Heghedus Razvan <heghedus.razvan@protonmail.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH v2] rust: time: New module for timekeeping functions
Message-ID: <20230715163324.348dfc0b.gary@garyguo.net>
In-Reply-To: <20230714-rust-time-v2-1-f5aed84218c4@asahilina.net>
References: <20230714-rust-time-v2-1-f5aed84218c4@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0475.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::12) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b9e0db-7907-4334-d02b-08db8548d533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCwAaIWrqMF+sLzVIbux9XMNwVyxV93F+B1IGt0+5lobKa1zUQXQwsAvVBrtuwz9B3xqt5npp58INQj1ayfQWacGejOlEHp+KN6EfsL9fOs5LTQll5FJbGYtAbwnrKmxbcwZeMWOUyPqjdENhC3svDwXpj1Ql1rpivOx56r4MCSYOKbuoOToJDzhehbpp3mlYXN0PVr6HaOX4XdUflyJUsv126fWsb3GiVreUWxIPU/nJ1Ra3XKPbgxcWybUEENeyPQLe1xH2GyeVi2tig+wY5prTaIC3LbkhQfSRsarCOCJ/ftzmKlMc5hByD1mGQt1THcN0aXxXVAzwDaznNSDFifdq/UoRyAo8IHuF3p3KfEn1JNGdbTsVlvH5PlawI+W6kTZIveHMXL5nDZL0KNQZtBtmJPOWNSsblSrboec/v1+XKdfu8PvQd36zcu8+/cXT7O+uOSSvLkNO/r1LgDoXUM9g6yKnWpEjrJcKRskys/Ll0DzBB3xMj28ip5193+kwAcrqQaP4YM6WnwO5aHl1dYWX+n2N4iNsQzQbAFLnb/Tqw0cM8K3n5JuE1nvW5A4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39840400004)(396003)(136003)(451199021)(41300700001)(8936002)(8676002)(26005)(1076003)(6506007)(66899021)(54906003)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(316002)(6512007)(36756003)(6486002)(38100700002)(86362001)(83380400001)(2906002)(2616005)(5660300002)(7416002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eZ1gLry9EsYaE/8vQy5SV4ZtrYG83vOcxr4XmK8u1m7GrrqEHctxXlIqACEa?=
 =?us-ascii?Q?nnfmO/grkP0l/mfdx5Sv4FZHxQzZqoYZgnSdRYgBGPQUoJq0Sg7Jstcc+5tx?=
 =?us-ascii?Q?/9K0S1+XCltUsT+xvZMor2nMhvfDKoq7tj2FJVvXEaZ8dySvz2aRbZHVEhWG?=
 =?us-ascii?Q?jH/svu6eCeHJ9kZZ8b3AtENoV/HWlc3xgK7cvi2R2UKpja+nPY5Tg9IThQj9?=
 =?us-ascii?Q?YHTFnpRKj4TbZsK+2jLFDCCdjIQjE1WbCwvAQECmdQ/wCFnHpumhNRkp4i/F?=
 =?us-ascii?Q?DznZZlEN6uMEQ/Pz8WfQPQS7C2zEXVWUl0HfTP1CNy3rRCduS9CPFiDDf6lL?=
 =?us-ascii?Q?hfpVOmxCzss7ZPKeO+MMsG126SGNfU5QjTeMAFYIOJmQVEvWO+wcbpi8O7Ph?=
 =?us-ascii?Q?EnuLptQ9YVemwIKwWu2DZ/9nrXJNlsAkF1WJf/oOtv1fhOWgFXPHhsXEN/W4?=
 =?us-ascii?Q?a+LxCqvVW12VK5IXudTZ73oFf5RY2XFvZgZNZU8aKwHhhZ1pQaUwAQZk0Wwc?=
 =?us-ascii?Q?U47p+i7dpGY3NoPE7Hdg9amb2IQzoo1EyxNWe7w11ufuSbm90Vh4et+for3Z?=
 =?us-ascii?Q?/8wvoSFyVxYGDiQD6XpEyLDxvhXcjFWdmzwkhlt/FHb16jfgdCChCX+k4u0M?=
 =?us-ascii?Q?2+qdSOPS/qK7WaRp5c4ZinSKDuBUuv0PdTWYb9m49aZqt8h/QtaRj8OYjHc2?=
 =?us-ascii?Q?Yg/peQMq9HCP+tuW0etxx+29i8Eywsa4x8fyOSsCaS9leLDLEgpyBaosnIFR?=
 =?us-ascii?Q?eJdUCl8Cdw8+roqPjxtbxeqUpTcjyN+JDklWMHOdu2NW4Pw6BJy/66ApV94r?=
 =?us-ascii?Q?RyWPDlJ/BCecpZ5JT1rzLVVNbAUTt2YrPE+FoDNrPl9CYsyHi0hps228MkOZ?=
 =?us-ascii?Q?uUOi48YRb9LlMHYTI9E7MOSWW7O/uA7rYb5WQrxZqOjvdz8l9ct5EVis/w91?=
 =?us-ascii?Q?R1VbY+Wzq1FZiqmTvLsZJ+OKAvImarovh6L6/E3XUz4H9tTB9P6qN5Rhztyd?=
 =?us-ascii?Q?jg5SPID9VeoRIqajqNiQ84dkutHUUJFBNrPedia9hXRRlMsFVYZK97NOhqR2?=
 =?us-ascii?Q?cuteHmREEiC9eRiR9CZ90JFXtqKCzB0eX+0uD9UL4WNgskEUXrU5lXjrBDAm?=
 =?us-ascii?Q?qGfqRejSnnueskbVmPbx18Vf3cDUfwogamPMxU4ZlRNNp5tIfzvbY3JtLxnt?=
 =?us-ascii?Q?3/3j6LeA1yDG/MA0tz356C1E9xE9baXoUZHFxp0UIeSANGU4Ap8Dz4LYV5To?=
 =?us-ascii?Q?vhtuV5FY+XBIp7xb5r41xyFTMdv5j2VUhbG0QJ31pziYg5jIPAI0RaMhYiT2?=
 =?us-ascii?Q?YFKKgkx/V+Y3GSxchde97Bn6ioq8cJwXPQ+noRihkr32WQnp1QiuM+0X48aW?=
 =?us-ascii?Q?BSC0QlnFIJ0ZzBuWujdy5kJlVTJ/5g/WYRJyTGjY47oUNYSZg7eaCoN0sms8?=
 =?us-ascii?Q?DdDmtNAydkROtmJJBhch6bxBmEgnqojzTENt/B5AvxFZcUn+Ep9XBqVQV7RT?=
 =?us-ascii?Q?eKuXYaeeEOeEKY6GxIAutPQkHrSe2GTfcCofwv43PxJl8IlVmOgOjtPirNm8?=
 =?us-ascii?Q?qtW7sNhvP4JCnJBKJv1FDyB9xwFqy3N+xTjzgVln?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b9e0db-7907-4334-d02b-08db8548d533
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 15:33:26.5855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXVK033wUua+HySwwqkWHRU2QoCV0JoDqC0TO6G0WA2hn/P9by4jXnjVKY3sbWe2MMThe/5qr3gpM7Bui/x24g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 16:55:01 +0900
Asahi Lina <lina@asahilina.net> wrote:

> This module is intended to contain functions related to kernel
> timekeeping and time.
> 
> Initially, this implements an abstraction for a time Instant (analogous
> to the Rust std::time::Instant) that represents an opaque instant in
> time. Unlike the std Instant, this is a generic type that is bound to a
> specific clock source, so that only Instants from the same clock source
> can be subtracted/compared.
> 
> Then we implement the relevant clocks available to the kernel:
> KernelTime (CLOCK_MONOTONIC), BootTime (CLOCK_BOOTTIME),
> RealTime (CLOCK_REALTIME), and TaiTime.
> 
> Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> Signed-off-by: Asahi Lina <lina@asahilina.net>

The API seems much nicer. Comments inline below.

> ---
> 
> Based on the feedback to v1, now we have proper type checking for kernel
> time. I decided to implement marker traits for monotonic vs. wallclock
> time sources, since it's useful to be able to safely implement different
> semantics conditional on that, but that left me with a name conflict of
> the Monotonic trait with the CLOCK_MONOTONIC / "default ktime" clock
> source. I ended up calling it KernelTime since it's the most fundamental
> kernel timesource, but suggestions welcome!
> 
> Heghedus: I think I need a signoff on this since this is based on the
> playground demo you wrote in the feedback to v1. Can you provide that? I
> can fold it into v3 (if there is one, otherwise Miguel can probably just
> add it when he applies it). Thanks!
> ---
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers.c                  |  16 +++++
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/time.rs             | 150 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 169 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 3e601ce2548d..eddfdf887364 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -8,9 +8,11 @@
>  
>  #include <linux/errname.h>
>  #include <linux/slab.h>
> +#include <linux/ktime.h>
>  #include <linux/refcount.h>
>  #include <linux/wait.h>
>  #include <linux/sched.h>
> +#include <linux/timekeeping.h>
>  
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
> diff --git a/rust/helpers.c b/rust/helpers.c
> index bb594da56137..eff092302e23 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -26,6 +26,7 @@
>  #include <linux/mutex.h>
>  #include <linux/spinlock.h>
>  #include <linux/sched/signal.h>
> +#include <linux/timekeeping.h>
>  #include <linux/wait.h>
>  
>  __noreturn void rust_helper_BUG(void)
> @@ -135,6 +136,21 @@ void rust_helper_put_task_struct(struct task_struct *t)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
>  
> +ktime_t rust_helper_ktime_get_real(void) {
> +	return ktime_get_real();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_ktime_get_real);
> +
> +ktime_t rust_helper_ktime_get_boottime(void) {
> +	return ktime_get_boottime();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_ktime_get_boottime);
> +
> +ktime_t rust_helper_ktime_get_clocktai(void) {
> +	return ktime_get_clocktai();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_ktime_get_clocktai);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 85b261209977..52c91484c5d8 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -42,6 +42,7 @@
>  pub mod str;
>  pub mod sync;
>  pub mod task;
> +pub mod time;
>  pub mod types;
>  
>  #[doc(hidden)]
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> new file mode 100644
> index 000000000000..f3bfeed20145
> --- /dev/null
> +++ b/rust/kernel/time.rs
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Timekeeping functions.
> +//!
> +//! C header: [`include/linux/ktime.h`](../../../../include/linux/ktime.h)
> +//! C header: [`include/linux/timekeeping.h`](../../../../include/linux/timekeeping.h)
> +
> +use crate::{bindings, pr_err};
> +use core::marker::PhantomData;
> +use core::time::Duration;
> +
> +/// Represents a clock, that is, a unique time source.
> +pub trait Clock: Sized {}
> +
> +/// A time source that can be queried for the current time.
> +pub trait Now: Clock {
> +    /// Returns the current time for this clock.
> +    fn now() -> Instant<Self>;
> +}
> +
> +/// Marker trait for clock sources that are guaranteed to be monotonic.
> +pub trait Monotonic {}
> +
> +/// Marker trait for clock sources that represent a calendar (wall clock)
> +/// relative to the UNIX epoch.
> +pub trait WallTime {}
> +
> +/// An instant in time associated with a given clock source.
> +#[derive(Debug)]

We probably want a manual Debug impl, but that could be left to a
future patch.

> +pub struct Instant<T: Clock> {
> +    nanoseconds: i64,
> +    _type: PhantomData<T>,
> +}

Do we want to pick a default type parameter? The `KernelTime` could be
a good default, given that it's `ktime_get`.

> +
> +impl<T: Clock> Clone for Instant<T> {
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<T: Clock> Copy for Instant<T> {}
> +
> +impl<T: Clock> Instant<T> {
> +    fn new(nanoseconds: i64) -> Self {
> +        Instant {
> +            nanoseconds,
> +            _type: PhantomData,
> +        }
> +    }
> +
> +    /// Returns the time elapsed since an earlier Instant<t>, or
> +    /// None if the argument is a later Instant.
> +    pub fn since(&self, earlier: Instant<T>) -> Option<Duration> {
> +        if earlier.nanoseconds > self.nanoseconds {
> +            None
> +        } else {
> +            // Casting to u64 and subtracting is guaranteed to give the right
> +            // result for all inputs, as long as the condition we checked above
> +            // holds.
> +            Some(Duration::from_nanos(
> +                self.nanoseconds as u64 - earlier.nanoseconds as u64,

`wrapping_sub` as other people have already point out.

> +            ))
> +        }
> +    }
> +}
> +
> +impl<T: Clock + Now + Monotonic> Instant<T> {
> +    /// Returns the time elapsed since this Instant<T>.
> +    ///
> +    /// This is guaranteed to return a positive result, since
> +    /// it is only implemented for monotonic clocks.
> +    pub fn elapsed(&self) -> Duration {
> +        T::now().since(*self).unwrap_or_else(|| {
> +            pr_err!(
> +                "Monotonic clock {} went backwards!",
> +                core::any::type_name::<T>()
> +            );
> +            Duration::ZERO
> +        })
> +    }
> +}
> +
> +/// Contains the various clock source types available to the kernel.
> +pub mod clock {
> +    use super::*;
> +
> +    /// A clock representing the default kernel time source.
> +    ///
> +    /// This is `CLOCK_MONOTONIC` (though it is not the only
> +    /// monotonic clock) and also the default clock used by
> +    /// `ktime_get()` in the C API.
> +    ///
> +    /// This is like `BootTime`, but does not include time
> +    /// spent sleeping.
> +

Extra line

> +    pub struct KernelTime;

I feel that the struct names are a bit awkward, but couldn't think of
any better suggestions...

> +
> +    impl Clock for KernelTime {}
> +    impl Monotonic for KernelTime {}
> +    impl Now for KernelTime {
> +        fn now() -> Instant<Self> {
> +            Instant::<Self>::new(unsafe { bindings::ktime_get() })
> +        }
> +    }
> +
> +    /// A clock representing the time elapsed since boot.
> +    ///
> +    /// This is `CLOCK_MONOTONIC` (though it is not the only
> +    /// monotonic clock) and also the default clock used by
> +    /// `ktime_get()` in the C API.
> +    ///
> +    /// This is like `KernelTime`, but does include time
> +    /// spent sleeping.
> +    pub struct BootTime;
> +
> +    impl Clock for BootTime {}
> +    impl Monotonic for BootTime {}
> +    impl Now for BootTime {
> +        fn now() -> Instant<Self> {
> +            Instant::<Self>::new(unsafe { bindings::ktime_get_boottime() })
> +        }
> +    }
> +
> +    /// A clock representing TAI time.
> +    ///
> +    /// This clock is not monotonic and can be changed from userspace.
> +    /// However, it is not affected by leap seconds.
> +    pub struct TaiTime;
> +
> +    impl Clock for TaiTime {}
> +    impl WallTime for TaiTime {}
> +    impl Now for TaiTime {
> +        fn now() -> Instant<Self> {
> +            Instant::<Self>::new(unsafe { bindings::ktime_get_clocktai() })
> +        }
> +    }
> +
> +    /// A clock representing wall clock time.
> +    ///
> +    /// This clock is not monotonic and can be changed from userspace.
> +    pub struct RealTime;
> +
> +    impl Clock for RealTime {}
> +    impl WallTime for RealTime {}
> +    impl Now for RealTime {
> +        fn now() -> Instant<Self> {
> +            Instant::<Self>::new(unsafe { bindings::ktime_get_real() })
> +        }
> +    }
> +}
> 
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230714-rust-time-10dd9ed25333
> 
> Thank you,
> ~~ Lina
> 

