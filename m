Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296F7785EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbjHWRfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbjHWRf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:35:29 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2132.outbound.protection.outlook.com [40.107.10.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC27CC;
        Wed, 23 Aug 2023 10:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOGjbSSOIQkgYetRvP7+7NKEkdDsy7xIz23UAHOwlZnoa5G+qZG//YKHefztEC9P1xTpMz/jaQDz1XdWzCG9oQ+Zm6msBifK2vHvIx4VrslMx0EeOV5L5nkuMJ4mQtHoNOL4wwW6s/sit/2msf8+a5ScwfPLDvKk/rMWK6kcetu0yyjWjaA0PlqNhLXCzC3a9qVZwqxqUyT8xKcZIKigU6ld39vlqu4JRsIdynR3Qd1vI1tqg5fhRImHs1kif6/0HOeIzmexlyvrcly4tm/9VbSu3Mn/hrjgimY+tbOryN6GYEemqhiJFpcfW3VwphhvUOJYC6yHpPNdtIYVs8v4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4cl1WwQdylGkkkKiKL9R6z3n3ImSJe6bjwzqA7wtig=;
 b=YhFVDg2SplUslDQTAX9C8lBrxlU1WTGPkzGy2SngRk1bNqiDYsyWDAzvMmZcv9PIreHigOlUJksd807FaKa+0idptv+d+oFUSajTsre2tAXdeuOuRYh13aorpu68yymTIh0BejhVkTReGQzdZzBMMgIrjLZps0e3w5m1YvvC4XjnNA98zzfoU3uVDyBPioyGb2jFsNYu0PZrSF4MGPHDvNeAjoNrdHJt0sCU6LQv3KDffBOkKWXO/XY2IezsCcU2P19DKRBcuakUvCSOUSV6siN7bnvaAowmIqhp9cX1LcKWHN+5yYRp26gugQNsxDqgR+OJS6lRJNIZVITd5PKroQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4cl1WwQdylGkkkKiKL9R6z3n3ImSJe6bjwzqA7wtig=;
 b=Lt1LzxKpnNTn/BLwaL2Q3AOtnlXfGbF09daA+CNsQdT4/djHkBtz2Q/MJmsTEX4zmVxK9/h6PqehL9BB+Txz4uRgbOGXKHC9L5ax1jjXzVKx+4WK8ioOzhX3193MI6/WbLCx7x74bKVsvlV70SSiWYPOubPOEq3K8Ri/JXcFJCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO3P265MB1977.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 17:35:25 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 17:35:25 +0000
Date:   Wed, 23 Aug 2023 18:35:19 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 1/2] rust: arc: add explicit `drop()` around
 `Box::from_raw()`
Message-ID: <20230823183519.1549cff1.gary@garyguo.net>
In-Reply-To: <20230823160244.188033-2-ojeda@kernel.org>
References: <20230823160244.188033-1-ojeda@kernel.org>
        <20230823160244.188033-2-ojeda@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0400.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO3P265MB1977:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d302485-4413-48ac-b6e8-08dba3ff55bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXe6/Hj0MOhA7DEFfv3G2Q8I3qwp5yPzb52nZfIiQolP1fGEHhCvyYko9Cpfl+oDA+pr1zdmsa66D5XsNdDqNHxFIJ0ARw4jM3hqcvyEexhmsmUdIdsobQWZIOWEGy4h/gyKrEvB0iZZ/TpaFqftbeMhYFthuz5seG6QtqCHuEwK/nCV8Mc3epqzAi46wMC26KtIHvvcwhrtDKxiyhynwygJbTy4PlNuvfzj+SVx/YLFFs/MSyuRIuWs7bz4jw83LlHttpDKBMNvhY3nJFqhje88K9Y4xfIRLC/wk+X/2efA5u2fVoCXgzHhuk5NR1Wz9/40/VH3a6uoSVydSayOCOYnGaLV3i0FlKSNOgPL/NOkW6Ape3P6w0MVRrCGzaJL6mAs0M9YgpKN2us3pBNJrjFd0WP4lQO+50kD/DjTbIsLlR1QOWA2jIPmU7mjbMLXT9+2oN+aGPEx1M9SYh46ofeIO5T62M7PQZVxWP537he3YSoGjIBoA6j+WuvWA6kr9i6UxQzvTi6S5XgBHn693bEck+GaPUlm2b9PKQPuSQdKjtNSgBCAtnVW7GSYPt+iniLpCbEedhTSSu4LriN6qrJyCKjpcZZ2bsohF6wIEXp34xEExkek3kxpfnZDX337fWTLY/knMSoR1f77W8OytLkm7RBVJLb4RnZjd46Mc/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39830400003)(376002)(396003)(451199024)(1800799009)(186009)(36756003)(478600001)(966005)(86362001)(6506007)(6486002)(54906003)(66476007)(66556008)(316002)(6916009)(66946007)(6666004)(41300700001)(6512007)(38100700002)(8676002)(4326008)(8936002)(5660300002)(1076003)(26005)(2616005)(7416002)(83380400001)(2906002)(30290500001)(81973001)(54580400013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CqJGPERxjm1oxZTKVMGadf4D+/uw4L+mN2nqUzvpVnz3I0GSCcap1nETfK/B?=
 =?us-ascii?Q?AzLERv+GwdXt8K8eOYlyHYI96tJiZjvzt1NIn10T45falW3PjLaQGP24XETw?=
 =?us-ascii?Q?3nSeXc20+UvIRox3kwjwyGSTXW6GO4wtbXfsYdQb1kopIuKe7r0QYXUVVKvL?=
 =?us-ascii?Q?fcWYzAe78xqqNJm11aqzBS4opzhZi5cTeX7e2pk987cHS4fj5by36zci7U/r?=
 =?us-ascii?Q?YgPojUSdzI7Is7GpDJMfX99QE1h4MAdGXkFBUM44umXh+9+MGFASL3CAF5vj?=
 =?us-ascii?Q?Tktge62whpBxYK/b4/9ikMA3/E6fO0YQNIU95NK6EiQWi0j8NXP4EfPoGEYa?=
 =?us-ascii?Q?H8noSVBC3c4tw5eDr8uaVr7zqahmsCDD50lEZR7bDdHjZXhuwMr2Bx/5/Qv9?=
 =?us-ascii?Q?66CyNLyKESrGiFxzCFBcMBOGs+2YChTqI4N0VxjLXPi82I7+jbM+JvcotiXN?=
 =?us-ascii?Q?N6mcT4+vdxeJmH67ei9QNlBHunphYa/2QC/EmKF2g+RJsL4h6r1NbWCprGBb?=
 =?us-ascii?Q?jddqr42S9dnIUgfsL+IjB3UQEJAz+99ugRDihn+Wfp42D463mRmeejhSvmL3?=
 =?us-ascii?Q?ukoxHdQuvbNQdMXLdMIrMpOwFIFA/DT31uU/CJlPqAGEe3fYRgGg6suB8L50?=
 =?us-ascii?Q?wlVxItpfyR7sjJZDG7eVF8blrjTuefTlsSBLubKW8MEnrpUd00i0WURPeu95?=
 =?us-ascii?Q?pn5S5zwPV37TXGcQhu2aCQDOZJtvbFhwiNw2hnsrp/zdW7NP+XrHdkQc/sJg?=
 =?us-ascii?Q?D5Yzw+CQ6k3NFsea+Lxvlgm44hd3/dzKsbxh5hTMiO0A4d8Ls3kzx7HOtGu3?=
 =?us-ascii?Q?I0rtdpSVuyul1ySwQYHjkIABQp3J/Zi+Lkn2OoDsY/XpC6Qs3PCOAb9v2F73?=
 =?us-ascii?Q?UG6IHfDFe/wZ255UeCEGrUvebSjVmrRIoFrxSdkSm61NzAaAI33SCElVjdMI?=
 =?us-ascii?Q?BXkcKhcoorP0hWN+8RnsSskAhT3Awhf14DPAjOZ+Avf7EG0fMRAzaOC2a+ZF?=
 =?us-ascii?Q?/5ay3uUMbBnCI2aHqbPjGqLHjgHmojKddZbi5XMKXdaHk2DXpCkyQKYc5Ljp?=
 =?us-ascii?Q?Pkyn+9b9H3Tbx76eGK4Rbag46oJ0yyshRyCTGhKZ9EUUX1cAVAqfslbOZhBh?=
 =?us-ascii?Q?zKG6otc64GVF08kgD4Pjip9WtXzdnJqYb7uXtC/qkuPLQcDJe4tUgBQ5lsN8?=
 =?us-ascii?Q?YXHMaChmd0DJZbiiHzlCrpZiYq4URE4KitlPbrPKsBynTrLu63OoBjUZkphG?=
 =?us-ascii?Q?VLnXlB7A+m8+N4NHXKAe9zZbD+2H82fw2wkyz5UNoOWAfqVFm4WxxMH5yt6b?=
 =?us-ascii?Q?sflprdC/MlhPkQXYtVkmSazJU033znp4RGDcssPk/xPzGI/B9h2p8Mja6Ghe?=
 =?us-ascii?Q?+P8V8x+0/wc3gqk5doadBV9GVjUPhoop/smmpsB+biqZp3UuORNKmPRP3tG/?=
 =?us-ascii?Q?jhlCRWeHsAvJFJry86cBCu0ZJnv34TQ/Qc3qNn2mDXXYTuoNnrUSI+VIeWoN?=
 =?us-ascii?Q?WIZzvhzY/DIZrLbk+h88CQBG4lsYFcQGKyoJhcutbPFEJ6KHjZf1+I9t2frf?=
 =?us-ascii?Q?qm7xQknZYaLMTEb+6qlZnrTzb50roY/9mJ9kZE+L?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d302485-4413-48ac-b6e8-08dba3ff55bb
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 17:35:25.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xzvh6A6wf8jDqnn+hb7nzoQXVCMTZXNfo3yUE5CROiwUqkTRo406trPfWBQKksXxXxpvcmatN2pk0Ndr9A2sPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1977
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023 18:02:42 +0200
Miguel Ojeda <ojeda@kernel.org> wrote:

> `Box::from_raw()` is `#[must_use]`, which means the result cannot
> go unused.
> 
> In Rust 1.71.0, this was not detected because the block expression
> swallows the diagnostic [1]:
> 
>     unsafe { Box::from_raw(self.ptr.as_ptr()) };
> 
> It would have been detected, however, if the line had been instead:
> 
>     unsafe { Box::from_raw(self.ptr.as_ptr()); }
> 
> i.e. the semicolon being inside the `unsafe` block, rather than
> outside.
> 
> In Rust 1.72.0, the compiler started warning about this [2], so
> without this patch we will get:
> 
>         error: unused return value of `alloc::boxed::Box::<T>::from_raw` that must be used
>         --> rust/kernel/sync/arc.rs:302:22  
>         |
>     302 |             unsafe { Box::from_raw(self.ptr.as_ptr()) };
>         |                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>         |
>         = note: call `drop(Box::from_raw(ptr))` if you intend to drop the `Box`
>         = note: `-D unused-must-use` implied by `-D warnings`
>     help: use `let _ = ...` to ignore the resulting value
>         |
>     302 |             unsafe { let _ = Box::from_raw(self.ptr.as_ptr()); };
>         |                      +++++++                                 +
> 
> Thus add an add an explicit `drop()` as the `#[must_use]`'s
> annotation suggests (instead of the more general help line).
> 
> Link: https://github.com/rust-lang/rust/issues/104253 [1]
> Link: https://github.com/rust-lang/rust/pull/112529 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/arc.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 172f563976a9..4c14d540a581 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -299,7 +299,7 @@ fn drop(&mut self) {
>              // The count reached zero, we must free the memory.
>              //
>              // SAFETY: The pointer was initialised from the result of `Box::leak`.
> -            unsafe { Box::from_raw(self.ptr.as_ptr()) };
> +            unsafe { drop(Box::from_raw(self.ptr.as_ptr())) };
>          }
>      }
>  }

