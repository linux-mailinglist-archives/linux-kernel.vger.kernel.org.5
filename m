Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B00776BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjHIWC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjHIWCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:02:53 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2125.outbound.protection.outlook.com [40.107.11.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BFAFE;
        Wed,  9 Aug 2023 15:02:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8C/6HIlkbzT+ymgLhzZzx+FW/dbUEO9Pch0kHCxMpMDU16NOuumbqjDtBkBiQ2mvy1Ep3PXM2PUvnhvD7xAIyxeQFHRh3ICGZuaCwknTNz6UALcdn23AsgbgPZQeFmFXNDdkI+WkMOxBKwB66UDZG8BRIZBDsFkEpwdIoJFC94hRGfHJN16NvZDlBhSpjAJG3XfG6klhRZpGmuvlFnvKPu8vQ30HwdhUAoj6ETnMAz991fP4X5BEQBXOQi0CuQwjBpbEBJWdbDFKLXsB9UQLkpGHUV461bKofySPYkI84aS00ZAL4075v9iUf8LkWFH4gc/Xmpg78RwkxOgPF7vOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTg1RTDFHy3fuVeSPJ8LctbELBpurJXrMysi709HN4U=;
 b=Bc5XaSSMaJ9RLtvqEPpl99j2S6ZrrF8NLIDh40747Zs5OP5dXJzHwxoHPDSQxD2JI1xzPUYbM+MODOliXgxeDlDI2cmCo/q9QLehld2gaxgvGyf5Bv02htk9nXOCXzs5Ksl1QeX19WK6DQzoGg2ZieFfafMRfWlqVNaIGDhNAK9U0t7wGpAqYwGMU+CPVy0yUOZE0zd+Mwy5M/sdtsr3Dd/R4yf09XVRe3eCxGXIE3mTDLlaBElgQ3SmC8lj8m72kkxtXLdMH7MQCmw0YULkXuPRDWVXQVTrEUVdbSVVCoolCsaKJQZbU3wHNPrE4tMyxvy+ttPMLZrF24+Fy9aYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTg1RTDFHy3fuVeSPJ8LctbELBpurJXrMysi709HN4U=;
 b=N0jrKbCiq4560VXTz4CvsMRusf6GPvcezVQZJjCU6jHwtQdBRxjzo+NnbCmQpOc7y9ADILyLC1EV5G/conuB6cvgNWeTKeXXIMEE1jXUxRS/PZ93vKRU+Pp+tNj8qxnNgUouiqMniehp+nTOob09yn0wMXd7yePnOw4TJoC9iDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB7313.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 9 Aug
 2023 22:02:50 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6652.029; Wed, 9 Aug 2023
 22:02:50 +0000
Date:   Wed, 9 Aug 2023 23:02:49 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: macros: add `paste!` proc macro
Message-ID: <20230809230249.01ffc009.gary@garyguo.net>
In-Reply-To: <CANiq72miVic=P+qSobuUqXoCuKW30_tT_buD8MyEsyVb_uoj6w@mail.gmail.com>
References: <20230628171108.1150742-1-gary@garyguo.net>
        <CANiq72miVic=P+qSobuUqXoCuKW30_tT_buD8MyEsyVb_uoj6w@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0437.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 354de098-8216-4901-b198-08db99245fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbfbLHJyIZd+9mpm3TDoWgUTKi6X57WAZryjUmtDeOLHdMIhKAU/YjuO2ajhYYtq206RGLNWN+ElVhGonkSgabftrklmWEXlx36cAbJZ8Itv7AebgLWctGhYq+gneO7nN3Hkvilv44F9bEo9i+CUiwTzG9rAYQ0JCc9GEIrBvfSiTdCfkXOFKVI61ec1ByrYsWcbXwsnBO1LjmXL9ePwI80Cdji11W8JZv9MV2euQEeOUmIwEEX14+2WbGdi40DxoIbjJIfiG0NN/xqnrUnZZ+wfT/1pdO7J3AA1Kob60MY05RhM9bKePZ/kfvBKJA75tNq1xocwn8Yu9dia5yL0X50tGmeHMIZaKHXBuSqqJjs/thb0T+9EcrahNm+yHI6lj2tokWTWXZ1LL+8GUKBWTFIDKsqcbo1kP42D2npvwjsIL0gafdB6yxc/t/weGhYuYinwrlDI+ul/vOHp+sXF45pWwu/5Dsc5XzCjDvP3/ZBDYvm5kT3PKoBu2M+rMGDnr2Jwdj5bIVgZjo2Tu54+oiYLWgtVTi2eqoZ9NFIyLAyyB6ipT855wAERQ1iIwrDkXHO9xeIST1m02jZkM8uHOM8SvA7c0JIIYTSQ6M9r0oI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(39830400003)(366004)(136003)(451199021)(186006)(1800799006)(6486002)(54906003)(66946007)(6916009)(26005)(66476007)(66556008)(53546011)(1076003)(6506007)(478600001)(36756003)(83380400001)(2616005)(41300700001)(7416002)(316002)(4326008)(6512007)(2906002)(8676002)(86362001)(5660300002)(38100700002)(8936002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTFxcHc0VUNjN0hqa3FUdDNlQmY1cndpUzRIc1BnSnljYmtPRjk4bmozM3Fa?=
 =?utf-8?B?eDVQTVdKSWJENXdCVVphZlpCcTlGK3MxMmttU3F3VnJIR1UxNGpzWVdVdWJQ?=
 =?utf-8?B?NjVFLzVDa00vdXBKZ3ArOGF2V01QdHJ0R0R0bEpqR1JBOVhtTFBJb2dVTGYz?=
 =?utf-8?B?Sk4wN1ZwMmNWOE1hTzlCeGljY2haMWxac21XOFBOeTNBa0RrR3QwSXI3RkZ2?=
 =?utf-8?B?L1liQmZLalF5NFlXQVBsNjFCQWNxSjJWd2swTlRPb3VMRXdqYUEyTjdhaFUw?=
 =?utf-8?B?eXo4OXlHay9xekxiYkNvb2VLMlN0c1crYUJwWDJvN2J3aFM4bmhKQnFrdmRL?=
 =?utf-8?B?OHdlVDRRRDRickFrT2hWS25EbVI5ajBQYXYyY01Lb1E4NVpiUHpNMC9FZW5L?=
 =?utf-8?B?MXZjd0VHeVk1TkdNak1qMlNXZ2hCbGU3NENieUdqb2RnK2tUbU93dDBLVHdK?=
 =?utf-8?B?QlBodzNUUUdrV3l3bURtNkd3VWJEbExISjZLMTRObGhQR0JUQS9LMnRuZzRt?=
 =?utf-8?B?RjMrcTRDa1F3djh4TjZVekhmUTVQTGpUanc2bnBaYUpRamFnQ3AwbXJMZWJJ?=
 =?utf-8?B?OGI2NFd2cHBFUkNtcXhnbXNKTkVxSUZuUGRMVmhvLy94VEV2TXpSYkh5b0NJ?=
 =?utf-8?B?d21nNGNCM0JWcVYrSld1OTJnR3Rjd0ZOVmdJblF6YTRpeGlzdTNtT1ZMVUlm?=
 =?utf-8?B?VEgrTTVaWGtDcnV3OTNBcDMvNlgvOXNBdVRkUGw5dXc4TkpJTVhmNU8xUUwx?=
 =?utf-8?B?VitIWE9PYzlNK0hwRy85UFVQdGVNRWdGTDBPZW04WFkrZHgzc2xwYWV2U1V3?=
 =?utf-8?B?N2t6QWhDbHo3bXBiV01wRzhnbkV3dnM2RjZ2Q29IMzJLa0hKbVBkSkE1aUFi?=
 =?utf-8?B?V1pPWk5RSVlQa0VkMXIzSk1ZOFFqT2hmWUVCRldKMHZsTVQ1SFF1SXBuVjZl?=
 =?utf-8?B?K0E4L1pkQ2gxSVFMd0tKTit2MG1mZ2NPYUtVZTNzYjhQNXFCVFFacGdwcmJs?=
 =?utf-8?B?UmNnOEZPVU85NmcvNVJZdlZRcGJ3ZVRlWlpBTjV1SUI1ekJtQ0pRY0lzcFdn?=
 =?utf-8?B?TFBXbVlaSGRDZStoSUF3bWJ2b2hnVnBGNnViNldqMGFRRllCdGV0Z29vN1VX?=
 =?utf-8?B?ZjhPRU44blZ0VDdtYmJ0dDlFdHFUdFpmbXVFZEthR3pCN1ZydkhqZGliUTh2?=
 =?utf-8?B?YlpFVUlCQ0RWejBEaXNINzNWellBcW5WL1ZQSlZPVm9CU1FjUjlYOEQ2dkRs?=
 =?utf-8?B?dFVaM1RjNkdDMk5rNFdZZ0NicWcyRUtTNlZ5c2xRZUpkTWxFYVo2SnJZQzYr?=
 =?utf-8?B?VUlici9hYTZSYkhmaWE2SWNxdmw0U25naGIydU1HSzErTGFVS2xnMmx6cFov?=
 =?utf-8?B?b3VZd3ZtNWszcy9BbHlqUXpqQ29NbFpqSitXS0c1OE8xQ01rRndzSllPUHJP?=
 =?utf-8?B?YjRvTkxGNHM4UTRqWnJ2SVFFdzBkcW9FZ2Q3K1ZscW1JS2RoaGVKTEgvWDls?=
 =?utf-8?B?c3pxSjhtT1E2azRzMTBkbE1yN3kySm4vMW5lU3VzY2xDNitXZnMrQ3hBUUVU?=
 =?utf-8?B?anV2V05wakdhcy9WcUNycm9LVEc0UHFCQ0s1NmFKdFFKS1d6SUUrMVd5bXAv?=
 =?utf-8?B?eTVBVTNnVnhDZDRVUWFxcGZSQjh6aTU1VVpnRnpuUUR5b1Y1NG1JQlEraDJH?=
 =?utf-8?B?aVVuaWRxQ3Njd3p2OSt1MWRhS3N0cmhwcmVMbEtGNDZDVmZPdms2Q1NSUGFT?=
 =?utf-8?B?Rk9RWlZkN08xWTBIOEFsS0o0WHlkdzVjNUw5b3d4QWQvaVl5ZGZvZEJDS21G?=
 =?utf-8?B?dHNNVW5GWGc4MHc4NGhGQXNsOXc1V0xQait6YTVkTE4zMHllQmthOEV1eVBC?=
 =?utf-8?B?STlyUVllREs4Q3JLRmRUNTFyUzFpOGgvOXlHMEtUMTVpeVdWakVjMFRqUmN5?=
 =?utf-8?B?aEcxbHlzbkJQRmtVQUprWTU0ZklQOFk0ZEJOcG9oTGFPemhQaXUxemxtcjB2?=
 =?utf-8?B?aUtnZWUzU29Pam0yOVVtSS9CK3QvWkNKRUFEZ1VCalNDeC9TUVg3ck9DVWVl?=
 =?utf-8?B?WXRBbnFuN2JiSmNicmU4YVhHOXEyTm40RmdpMDVidE1hcS9YdHUxRlM4MHJq?=
 =?utf-8?Q?XYLQVQw4PiCf7ytWBGNrFcOS9?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 354de098-8216-4901-b198-08db99245fa1
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:02:50.7188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzvR1lBFUuFrKUeoYnGZ2n3lcSJwnlveMWb8tdBzVfbTQecShp58pUCQir+EU6rjag0OuTVD8+OGjapzSV8IEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 23:45:34 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Wed, Jun 28, 2023 at 7:12=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
> >
> > diff --git a/rust/macros/paste.rs b/rust/macros/paste.rs
> > new file mode 100644
> > index 000000000000..42fde0930b05
> > --- /dev/null
> > +++ b/rust/macros/paste.rs
> > @@ -0,0 +1,94 @@
> > +use proc_macro::{Delimiter, Group, Ident, Spacing, Span, TokenTree}; =
=20
>=20
> We need the license identifier to apply this -- is it our usual one?
>=20
>     // SPDX-License-Identifier: GPL-2.0
>=20
> If so, for the record, could you please confirm it is? Then I will add
> it on my side and apply it -- thanks!
>=20
> Cheers,
> Miguel

Hi Miguel,

Sorry I forgot to add license comments!

All my kernel contributions are permissively licensed if possible, so I
am fine with this being either MIT or GPL-2.0 (I think GPL-2.0 is
deprecated in as a SPDX license identifier and it should be
GPL-2.0-only going forward, though).

Given this is non-kernel specific generic code, I think it might worth
following the convention of the paste and pin-init code and make it
`Apache-2.0 OR MIT`? This would also make it the same license as the
`paste` crate (although we don't have to keep the same license as this
is a different implementation).

I'll leave the final decision to you.

Best,
Gary
