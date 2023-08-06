Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0E2771602
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 18:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjHFQHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 12:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjHFQHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 12:07:15 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2130.outbound.protection.outlook.com [40.107.11.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5D21B3;
        Sun,  6 Aug 2023 09:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtKYtdJl/7M7gmQPnx4+XQOrVXSnAIuEh90njWwtm7cF4uTcZMbkPL67gHqBp8oyJqdU/Y04J5ihBTqNRZuZD/ovWLq6iRpZ0aaNzLyjrdkvkwk+Bjj6E+C5OSDODIyy44Jzam0VkRpKdSlc7k6JfAWnZsUXq7nG0bdnLMn5JGN5hnT3xbyL85bEXSOSgepX+Q+sbX3roHTWcmKMLC2t7YN2atr2K05mfE0WKA+qERYFW8FzZr4LRAVQTjzHKnlI24Geur4Z7+H6MROd8L1vwxluRcAWpljpbVhjKkO9feRX1semn197cOC0SwuTE2IYtsEkGh01bNOgFWJSvKBLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzuOJjFkK141+cNad+okqjcIdm9Xb/+2iAm5RRjh2N8=;
 b=hmVtqR1ozcqjdrf8hjVJ0QzC2TeZ7YevKtMFltJGXUZn9CnRo+SzqXDYYUVkbKfZdSclTb/Z5FqnuxrgwioH+4fOQ9RyXebX3uCaZ0iKLuOJnf87kRqTiLaMGkahJZoPZ8ms6a3VZf6pVJdpC+HCVgjVj1DPf1a2Mv8Gs8JHRL5Jax3Ce/M7byfLJi9ELk1vtMOJFkj7mOJkwBvYgHTBEViFswumT3DwySaHyqQsoHiTmMyX1L37GcnsV2uqZjAK9ePXEj1BVhuc0OVTXlXduVoUAcdgr7Bq344mFcv2ll9BkRPVJ5T2gvVY6WL+CVlUNiRY54mLID6GS9g5BVN0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzuOJjFkK141+cNad+okqjcIdm9Xb/+2iAm5RRjh2N8=;
 b=DFqUXsj39krrkJ9i8/HUCgT3DTKcbrc57jBf22rEc1jEZzT2pbfeyHnrVqdvZucht5DIUgNlnAPhvzSHHMSaodrwy06eXKe4gpXx/a/wkpcZsTe32pZt6PK9YDqjiDsjFA7vps00eaGVWlomck3RnCLNcDm6S4TYFsxYrMITcko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB2368.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Sun, 6 Aug
 2023 16:07:10 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6652.025; Sun, 6 Aug 2023
 16:07:10 +0000
Date:   Sun, 6 Aug 2023 17:07:08 +0100
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
        Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH v3 08/13] rust: init: Add functions to create array
 initializers
Message-ID: <20230806170708.174cc26c.gary@garyguo.net>
In-Reply-To: <20230729090838.225225-9-benno.lossin@proton.me>
References: <20230729090838.225225-1-benno.lossin@proton.me>
        <20230729090838.225225-9-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO6P123CA0033.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::6) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB2368:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f20b59-3b3b-458b-a4b6-08db969730d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2PjYXMP0InZZ02thTr2vK/PMbHGU6oCidqQNrBiP0NWhV31WS9+/WHo7c8cwLoqat6ME4r7aLAg2Yyt9BAZUhcLmoas9ypu/nnGqZY9CN1bJ9oC/qemLDPy6pseXIXsZ2gkPBtXih/sNgvMcPo2LdDnJ4ai19l8p5X83xFjZV9Z6uEKxdrOAlA+IK6UPuktJiQzcyd9pnXegF9HHBal2DCOVhySlDjeeyfUG+pNtWonoeYtCt/o7EoRYuTBv5teTFcoJ4PN8ctINdU0Jp22PbYy2l3x9obw7Rywet4d0E38Xc1dC6VSydS7etwd6g3kwDBZeNDXwr8XinpZ+Y9dKItDlCwkC35sL1Hk4mU465t+WymfnFsnNWHdrp+V2C3KiRLMmrVwYN6WGnmO1W8zIXWUoE5hzOy+a1u6uBCBOF2WxqIMdVMYYHrI1hRJv9u6EacrqjGGk73LkKwqJLb9E6X9tPdKERZYhtQZsU3HoQxI2FRWScdMQ91iOw9rJoYgWXTp9LUF4T7yTXlpiBAfTAumDebM53k3yVq/k+fnIerusHLtK86Nqe3OvFgE+/ny9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39830400003)(396003)(136003)(1800799003)(186006)(451199021)(66574015)(1076003)(41300700001)(26005)(2906002)(5660300002)(83380400001)(7416002)(8936002)(8676002)(2616005)(478600001)(6916009)(86362001)(316002)(6506007)(54906003)(38100700002)(6486002)(66476007)(66556008)(66946007)(6512007)(4326008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2FvMjZNOEFiYzU1YllVakd5dFRrRnh6NTVvQkhoVVE2ZVlpTm5CTEtyck5N?=
 =?utf-8?B?akQvQjUyNk1tbDRYU0pnMzNXOTQ0UkFqYXVTTi9oeTgxbzB4RTMrV09Zbll3?=
 =?utf-8?B?VDNTMlMzeDhMeDdtemxoZkRHeFdjUjN4Uy9WZnpvR3QydWg0VHZlWjNLUGZF?=
 =?utf-8?B?R1ZGb0RlRUt6NlhHNEEwYWUyM3daV1ZKWmhVWkYzWGUrNnRSZzgyODJyblRs?=
 =?utf-8?B?Q2J4azhUYjZEMXJaR2REZ1doREpxb2hzWDlmUzVIMCt6NlNYbXFNb25FUkoz?=
 =?utf-8?B?VGxhVWlzdm5sbVNobXZwOWVzc2o1a0tVWGxtUHFyVW53U0RuK25pcWNlcEEy?=
 =?utf-8?B?TERtVlZOM2VOWmEvbHhZRnRvUHM1d3gzVmw5N21kVklRYWpTTXhUc25oZm84?=
 =?utf-8?B?anc0Z0NWVlFPb0I4MzlFbklNTWhsN01tWFplNHhURkhGdVpxZlFKbWdCMWZ2?=
 =?utf-8?B?NEpQTlJVYUhZaXp1YWRHVUNjd2hET1orbXFHeUFIMzNkQWhTVTlmeUJwZmJB?=
 =?utf-8?B?bWs1VEczaEF4ZEkrRTdPQ3IxNkhqRDF5bjRMZTM5T3dURHpEbHhEL3o0elRO?=
 =?utf-8?B?emdxMSs1UDhhdUZqREdoRS9KNzJtTTByOVZ6TU9JN0tKU3R3bFVoUDc5WXFm?=
 =?utf-8?B?S2VIMFpqejZYM3o2NUcrV24xV0kxQ0FmUVB0eUxUeEp3TDVBenlDYzVUV1cy?=
 =?utf-8?B?SHN2VG9hVkd2bEVCSWMvcVVFdEphY2tTT2FRWWcrOFRNbWNFbGRkOEtrNngx?=
 =?utf-8?B?VXpHUzZSRVpuUnBUTzcwa2lORkhodVlHK0VyWmwvYUppaFhFTWlDallOZmFm?=
 =?utf-8?B?akwzcGRUQzdkb1Nva0tZUHNCcVhDZk1TMUs4KzU5WjRqcVlUREhyVVpqL3N2?=
 =?utf-8?B?eDNSdHBuNTd3bHVTaWp4UkQvNmdVVjM4dzZzTll4dFpnQWdwVXB3a1FybWdK?=
 =?utf-8?B?a2Q4akE5Z2l1MjM1UVZJZUt2MndONzVlWHRBNFE4Q2dVOUlYWnZBZzlWSVZ1?=
 =?utf-8?B?TzlURlpzQzdITGczVUNEL080a0dqdndiSSt1WlUxWnVpUTZVTzg3YmsxUGJh?=
 =?utf-8?B?cFIzNUQ4d2lvTmxTajlCYWRpNW9obUF4NERCQmN2TDNYZGF0TmZTdFI3UDdr?=
 =?utf-8?B?WnZtamFzVXhKREE0NzlSZzQ1RHpHeXZtN3oxR2U1dDBlMW93M0JxV3dWVXB3?=
 =?utf-8?B?Y09ZZGE5MlVjaytmZnh6cU5SVERxdlFPT3JSUzZaa1VSSFptRUE4UUFIMzl1?=
 =?utf-8?B?bUozdUdQMjc0ZTZxclc4d0IzSDlYMTd5eVFoZHRNRFdhdEdURUh4UldFVnB4?=
 =?utf-8?B?d3NMN1VYZDNaejg1bmQ5azdJa210RDdwUEFuckRBaDNzUW1Wc2NYUC9CVDhk?=
 =?utf-8?B?OXFUTGhnOTBXdHpvOU0xUDJPSjhjWUQ0SDE2eGthRFFlREdPNkFOMDB0Qnk3?=
 =?utf-8?B?eTdSNFd2eFRiVUxvQnpMWllWODhsVnJHNVVydmZGVHZCZGpNcjUvNVRBbExR?=
 =?utf-8?B?ei9TLytEaERYKy9tMVIwZmNjb2J3amtocnlmQkpJTERFME44U3RVaHZxbkRO?=
 =?utf-8?B?WkJkdlpkT1BlZlNDclo1T1AwbjBhdXZ3Y3hrTW9pRFJMZjVkeG4yY09QYlpx?=
 =?utf-8?B?QmxrdXFxbUxmUEZNZW5UNzE3bEN3VVM1dUhiaXA5UGhHNkxvNC9iR25GYVNX?=
 =?utf-8?B?UkZpU1dRcG01Y05TWm5OWm4wRERzU01pUWJtWERISGUyZHpxK0FZS0g4U09h?=
 =?utf-8?B?aG9OZlNuWTZzaThwc2xqVUFXZXRKd3RaUytkekNZdnhNb3BrNUd1MzY4WGda?=
 =?utf-8?B?QmJ2YXl1YzVjbGdGNTAvTWxCc3dBWDBvWWY1OXhqSk1RTzA5ejlSSDJXZ2o5?=
 =?utf-8?B?NUdWaGs0ckc2clk2NEN0V1BvV0p3NlFsWVVVRGxneWpZanBxS1BpSDNnY3NW?=
 =?utf-8?B?ZWtMTkh4ZmJzUll3emlqNERuei9lM1VhU1NzTHdhU0VaeWd6bFp1d2xPYzFr?=
 =?utf-8?B?UEErN1o2TzF2NkRvT0FHWGovcnZxRzRjMnVqZ3RhR3YxVXlQOU1rL2dSZllU?=
 =?utf-8?B?MU9tb3VQbk4rZWh1RFdWMTI2enFUTG1CK0UreVBqcllGQUFzNWF2REF3dVVw?=
 =?utf-8?Q?EJMzVZWz9D3933nSBxCqXlnXm?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f20b59-3b3b-458b-a4b6-08db969730d7
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2023 16:07:10.7925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/PtlzJ4jugVLeT0hTMQiLN/TmeNJqnk7+4GWs1diqNFoRI9scZp0p+qaY48534cY0M7PxBTVR1AILiYO0kmBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2368
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2023 09:10:02 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Add two functions `pin_init_array_from_fn` and `init_array_from_fn` that
> take a function that generates initializers for `T` from usize, the added
> functions then return an initializer for `[T; N]` where every element is
> initialized by an element returned from the generator function.
>=20
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> v2 -> v3:
> - changed doctest: instead of printing the array, assert the length,
> - added Reviewed-by's from Alice.
>=20
> v1 -> v2:
> - fix warnings and errors in doctests,
> - replace dropping loop with `drop_in_place` and `slice_from_raw_parts_mu=
t`
>   inside of `{pin_}init_array_from_fn` functions.
>=20
>  rust/kernel/init.rs | 86 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>=20
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 460f808ebf84..af96d4acc26b 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -875,6 +875,92 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E=
> {
>      unsafe { init_from_closure(|_| Ok(())) }
>  }
> =20
> +/// Initializes an array by initializing each element via the provided i=
nitializer.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// use kernel::{error::Error, init::init_array_from_fn};
> +/// let array: Box<[usize; 1_000_000_000]>=3D Box::init::<Error>(init_ar=
ray_from_fn(|i| i)).unwrap();
> +/// assert_eq!(array.len(), 1_000_000_000);
> +/// ```
> +pub fn init_array_from_fn<I, const N: usize, T, E>(
> +    mut make_init: impl FnMut(usize) -> I,
> +) -> impl Init<[T; N], E>
> +where
> +    I: Init<T, E>,
> +{
> +    let init =3D move |slot: *mut [T; N]| {
> +        let slot =3D slot.cast::<T>();
> +        for i in 0..N {
> +            let init =3D make_init(i);
> +            // SAFETY: since 0 <=3D `i` < N, it is still in bounds of `[=
T; N]`.
> +            let ptr =3D unsafe { slot.add(i) };
> +            // SAFETY: The pointer is derived from `slot` and thus satis=
fies the `__init`
> +            // requirements.
> +            match unsafe { init.__init(ptr) } {
> +                Ok(()) =3D> {}
> +                Err(e) =3D> {
> +                    // We now free every element that has been initializ=
ed before:
> +                    // SAFETY: The loop initialized exactly the values f=
rom 0..i and since we
> +                    // return `Err` below, the caller will consider the =
memory at `slot` as
> +                    // uninitialized.
> +                    unsafe { ptr::drop_in_place(ptr::slice_from_raw_part=
s_mut(slot, i)) };

Beware that this isn't unwind-safe.

You probably want to use a guard for dropping and set a field of that
guard in each iteration (a very common pattern in the Rust standard
library).


> +                    return Err(e);
> +                }
> +            }
> +        }
> +        Ok(())
> +    };
> +    // SAFETY: The initializer above initializes every element of the ar=
ray. On failure it drops
> +    // any initialized elements and returns `Err`.
> +    unsafe { init_from_closure(init) }
> +}
> +
> +/// Initializes an array by initializing each element via the provided i=
nitializer.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// use kernel::{sync::{Arc, Mutex}, init::pin_init_array_from_fn, new_m=
utex};
> +/// let array: Arc<[Mutex<usize>; 1_000_000_000]>=3D
> +///     Arc::pin_init(pin_init_array_from_fn(|i| new_mutex!(i))).unwrap(=
);
> +/// assert_eq!(array.len(), 1_000_000_000);
> +/// ```
> +pub fn pin_init_array_from_fn<I, const N: usize, T, E>(
> +    mut make_init: impl FnMut(usize) -> I,
> +) -> impl PinInit<[T; N], E>
> +where
> +    I: PinInit<T, E>,
> +{
> +    let init =3D move |slot: *mut [T; N]| {
> +        let slot =3D slot.cast::<T>();
> +        for i in 0..N {
> +            let init =3D make_init(i);
> +            // SAFETY: since 0 <=3D `i` < N, it is still in bounds of `[=
T; N]`.
> +            let ptr =3D unsafe { slot.add(i) };
> +            // SAFETY: The pointer is derived from `slot` and thus satis=
fies the `__pinned_init`
> +            // requirements.
> +            match unsafe { init.__pinned_init(ptr) } {
> +                Ok(()) =3D> {}
> +                Err(e) =3D> {
> +                    // We now have to free every element that has been i=
nitialized before, since we
> +                    // have to abide by the drop guarantee.
> +                    // SAFETY: The loop initialized exactly the values f=
rom 0..i and since we
> +                    // return `Err` below, the caller will consider the =
memory at `slot` as
> +                    // uninitialized.
> +                    unsafe { ptr::drop_in_place(ptr::slice_from_raw_part=
s_mut(slot, i)) };
> +                    return Err(e);
> +                }
> +            }
> +        }
> +        Ok(())
> +    };
> +    // SAFETY: The initializer above initializes every element of the ar=
ray. On failure it drops
> +    // any initialized elements and returns `Err`.
> +    unsafe { pin_init_from_closure(init) }
> +}
> +
>  // SAFETY: Every type can be initialized by-value.
>  unsafe impl<T, E> Init<T, E> for T {
>      unsafe fn __init(self, slot: *mut T) -> Result<(), E> {

