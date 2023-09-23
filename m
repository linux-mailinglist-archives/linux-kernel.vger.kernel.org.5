Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977497ABC83
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 02:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjIWAHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 20:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjIWAHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 20:07:23 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2121.outbound.protection.outlook.com [40.107.10.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF601A5;
        Fri, 22 Sep 2023 17:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOAeO7tUFFpHYXeiv67W1A+uKuHL7rUKyM4dEXCnZbOT9NnP8P3O5EYmy1ml4VylmM8YWRYMJ+9e4Kotq4Mk2ZNvCBrF4c2CWablvGxq6xvt6voHoPSDQnACEH9DB3lnmNiqQUQZXR4/TAuIN8qFdFZgX6i0mqn2/kIKZvse1WIloweja8QRvdtkHpZODNg32XrJOEwjkRM1P7PKIsUg2lcpJOtu9hi+q968nkbZR0FcEJhfm/HAPbI4eBPKT+UhlYsKpn9xa3I7R/tuxjbcsz/Tk7OA+fV6BhuYZLoXKSoGW4Yvt50Wf/Xl5b3sC8fCqdCrfd5gvi0GMKDA+MNRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMxMPilv7+ukwN2t3e8yJv/XHcUE7uS3SBvBuEVAu38=;
 b=KdA59zUX0EJFQIjZDvGwde516xQxo9rSnuaStgAlR8KOzSYTDmSYbq3n6MTXtpNk8ci1F5+lnMugXZ6oJqZ6nVYohPNOTUNQx1toDKWH1SJ+1qn7cGjRJCEMMdyRuHCdXiZW6wEQ4QY/mKJBdmwb2sHuuZ1TORpoOOOJMl63Vbwe/azaXK8YFtu4FHCLCBr907tY8MPMSRO+Kue0O3574arD2ynlYphpMxA9BdYzWDweessDXCCy4j4uNxXTsiwfiu9MZu83wL3PBzUzLu/ovl+EcCn5A6tDm+8twGmlnsFvXWjSslTsvPMAXxmc7puBEBP11JCYvKP3BkSQlVaXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMxMPilv7+ukwN2t3e8yJv/XHcUE7uS3SBvBuEVAu38=;
 b=hCFKCDKMiKzoh6KGGdA5IOxyUVcmHF+YovypyKUcIMWz8JQkyun2fZ3X5PgWUzrolC563hjvykFirI0BI8s4L54ZaWoqQELZ5OLdE2HbcXPMmqQts5wG2Ze+mzXuQjrWBOA2kXWKbSh6RA0CMhWEcW413MPP4yJJbUVSVXX38iM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB7358.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Sat, 23 Sep
 2023 00:07:14 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d%6]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 00:07:14 +0000
Date:   Sat, 23 Sep 2023 08:06:57 +0800
From:   Gary Guo <gary@garyguo.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 1/2] rust: arc: rename `ArcInner` to `WithRef`
Message-ID: <20230923080657.277819c2@gary-lowrisc-laptop>
In-Reply-To: <20230921213440.202017-2-wedsonaf@gmail.com>
References: <20230921213440.202017-1-wedsonaf@gmail.com>
        <20230921213440.202017-2-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TYWPR01CA0035.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::22) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 0840a382-d7b9-4dc1-958a-08dbbbc90ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RyXMsPrNff/kA035pwpxjZnSmawKs1wXe5LjnZJ5J6j/HYRHZMs89CqXN9C3RciX/QYPnmS7PVH98vewQ0eL9A1UtpIDhgLG2qX9sOo2OwZGGrGt2RKG1vo4MnFNCysd/zXhVdtmngj/PvjvgdUUHOZFlzH6dSTvsabH5p2r9Z2M+0vuCOrBluaOZWAAzVssh0yI8/8RmvyAU+eIe3XPTtxRhcNH7uNUu+b2pvXsy4vvbfiPbTbsUNaXFky9ZjX2MsYUpX1FzygjKXkiFBfDc8zCfop5V096NoP41f9tAgjkXlQYVqwf9nfJkDhLqqseezPMLvK7yKYcBcIbj0gn7/ATGQy10gvr900W8pvAi8qsAb2yHOhBul5UAcx7LK3JDwkkOm0MJ04F5H+oC18HxTpvWKxbu7jvTntFpsAAJhah3YGjfbIoSN/wEwAKyeYICBU/MLp6SuVYmHPHkGXhEX21KUynPIDL5tZWdoh56obXIXM+hbjaWImVeEZrqkzx3XfbvjxUJVfZwTiHFB8F/O0fzJl3QT8ocY8ChkNA4fnVRTG+J7fdNVNYUS52Lc3EziIyDHnoBVkv1TlRK02sJpxhw4i3wOCjtOh1SPDnic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39830400003)(396003)(376002)(346002)(136003)(366004)(186009)(1800799009)(451199024)(1076003)(6486002)(45080400002)(6506007)(6666004)(478600001)(9686003)(26005)(83380400001)(41300700001)(6512007)(4744005)(2906002)(7416002)(33716001)(5660300002)(316002)(6916009)(54906003)(66476007)(66556008)(4326008)(66946007)(8676002)(8936002)(86362001)(66574015)(38100700002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1RxR2p6WlIvczZNUE1jRDJtWGF0MUpvMHQxUWhYNmRSTEhhdDJUcG9aV2k2?=
 =?utf-8?B?Sy9Ra2VIWTFhNndOenNIMVdQVGZYSTF2akJpRXpMK0ZRa0FBbm1RNVExLzdE?=
 =?utf-8?B?U05sR2p6Q3Bscm5PaFpUendkSk1UMmgzVmtGNnZKYlpsdG5xNENiSmJSS21r?=
 =?utf-8?B?RzZocVZPTVd4ZUwralczelZDLzlNU3k4QVY4ZkJoTHpCeGtBeVlzcWM4UnRP?=
 =?utf-8?B?SnprT2Y1MVdCOTk0SC9yWFhTaHNwVVE1VTFyOVlwMDU1UVpqRkJkVjU0QzJq?=
 =?utf-8?B?WmEyem4zRWpJRVVORFRidUUwSmszS09vVmptWlJHYkJoeThPVG1ZNUlaSllj?=
 =?utf-8?B?WkMzWElHcHJlY3pFQXJMa3JXenJDQ3IzYjZ5UWp6S1hPVHNXUkUzd2NqSmxM?=
 =?utf-8?B?QWZUWlhTNkNVTWtIcUxINmpPYWNUbUVuTTNaNW5zUEJnTHpPTEY1M2wzdlB5?=
 =?utf-8?B?T2NZNTk3bTQ4ekZ0d295VW1UNDBEWHlSODg0Q0ZwOUFsWXhrMU45SWN2WTV2?=
 =?utf-8?B?V0JQZGpJektmcTFhVldENHJINUg1R3NVVjcydVp5N2Q5TGFmTE9ENm5mbFNj?=
 =?utf-8?B?SWJxcUZ3Q1I4MFhJdVU5c2VnZHJxbTBVS096N28wTmg5NzVrb1hRd1QvUVJq?=
 =?utf-8?B?TlR3emZ3R1JDd0YrSW5iQ2orekhHYVVvcnk2b2RiVVpHZWY4R05vQWFoTC9G?=
 =?utf-8?B?ZzRocmpmOEJiblNzK1BwQ1VRdk45YlhiMEdVWENnS1ZjZUNncG90ZDlqa2JG?=
 =?utf-8?B?VHFnUVRacVFFcDRIWWdkQWJSMzMyeVF0ajZlSTBKenFxSjBQUDYwWFUvK21T?=
 =?utf-8?B?ODg3cjIwcVl5b2RETXRMT3N2a3pLck9hRGY4YjVZVEVBekpjWXo0Y2s1MHBN?=
 =?utf-8?B?SFZBQ2tIMTBZWHgwNmphYXhzUktKclVqK1ErWHpSZVdDUXVpSy9SSWxza2FE?=
 =?utf-8?B?SkVZQnpZMjdqWFk4UjRENXZGUm14NWVzUXQ2aU0rRjk5R1AxT2NUUUoyd1hV?=
 =?utf-8?B?UWl3L1J5eXBBenFKcDg5V2FYZjlkNy9CNEFJTzJVTUtCeTlOSGY4bGNLLzc4?=
 =?utf-8?B?OFhvSW9GMTBpb252c29Rb2RlaWh0bWRGRWtPdWFrU3hpb1JFWXFsM1lCM1N3?=
 =?utf-8?B?RW1RZ0RHdnpmWHhZZngzV1JhL1JocTl6a1NzeDdyU05OVjdSMEQyMGNrK3lz?=
 =?utf-8?B?OHJxdEIvanRoWkJmVzl5aURRZ0ZpZjhwYjlETlNzT1V5ZXdUeWdUd2c3MVdh?=
 =?utf-8?B?MTFtNm40eCtvVmZQbXFYQitHZUVEREFod2M1MmU1L3RqY1lCeUVKazIwd0tZ?=
 =?utf-8?B?RURYVmI1c2xtL0VIRy85Y0VJVVl3ZnlUa3BGd2RuZVJFeUpYYm43N0Y4WmxK?=
 =?utf-8?B?TDZSeTlVWkxsZ1VJSW9LOUI4WWJPZmJHSHFjVmcvSG9jb0taRit3djRjUkht?=
 =?utf-8?B?Wi9RdzVMTWZIdyt0VU1HSk5mLzBaZGlzUUZleUpuMzJZNTBCZ1Rwdi9mejFm?=
 =?utf-8?B?QmZhTWtGTzl3TTJueXhNTHM2VjB6bThBYkdWMlE2UGN3a1ZxaXJzU3FWcTFv?=
 =?utf-8?B?SExBS1hVWGhqb2F6M0UzS2hIUlRHbVZ3WDg5bHpPMHVFN2tHbjIycnRVWmEx?=
 =?utf-8?B?ZXVCbFZheDJTWTZJZ3VGdS9yd09ldng1UnQvKzhTc24zSnpvc0dCUGlJNGk4?=
 =?utf-8?B?VGxYUys1TnVVQ1hMcEllbzBTTkhsbElXalVXTVhqMFpBM0Z5eHhlYkdVQmFu?=
 =?utf-8?B?Z2lEVTYwUjB1YWJjTmIvMU9OOTEyaGp5YmdBZVNKOWN1aDF0ZnVuelNKb1Ux?=
 =?utf-8?B?dFZqaFA1Z25WQ3p0V05OYldYSS9VSDluNWJDSm5QcEJvdzAxSW0zeEZSd1Ra?=
 =?utf-8?B?bXdhSlNPYklzcStjVDdsYUM3b1NtRnZBd0FBQUdTemgwOE9rbHVhVVB5cjlY?=
 =?utf-8?B?UnZQZGtxWGYvRXpaWGVMZWVobHZFYndFdGxPSndkM01wWi9QWldDN1ozZVpE?=
 =?utf-8?B?bU94K1NNRjhhVEoxWE5ZMTFoV1g2R0E1UldYQm5GRnlldEVTbS8zLzJSZFJn?=
 =?utf-8?B?enhKSjFjNU5RQVg1MDJMU2VqcnVaMlJJVE1HOUtSTmxMcDJ2V0hnYng3SlZs?=
 =?utf-8?Q?alyldsv23iPVSkVmY9DXngBIz?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0840a382-d7b9-4dc1-958a-08dbbbc90ab8
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 00:07:14.6704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eT2Kl90p1RH2ZNRuFawxJeKp5y/DwGNblXHuX1PAKTlKPOGXeztIHW7wL1neulTfty6wWHeGidSboK4TaCIcyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7358
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 18:34:39 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> This is in preparation for removing `ArcBorrow` and making `WithRef`
> public.
>=20
> This is a pure name change with no functional changes intended.
>=20
> Suggested-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs            | 20 ++++++++++----------
>  rust/kernel/sync/arc/std_vendor.rs |  4 ++--
>  2 files changed, 12 insertions(+), 12 deletions(-)
