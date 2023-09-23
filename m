Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081FD7ABC98
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 02:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjIWANS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 20:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjIWANR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 20:13:17 -0400
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2134.outbound.protection.outlook.com [40.107.121.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F806AB;
        Fri, 22 Sep 2023 17:13:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vuqjcjv/JrsbFYROvXSEan1SFRRM3gh/BTBxRMSyfRGN2UmdJYA8lIQYrPHJjaMqIH3/jRXUlC2xSwUGw3e1ZK7puF/PlxpcIRc2OGzU400YClK/2i3IHy98duIFOoOrehkh893+6I1QHluYKFRzYHs3/TWsNGLHrZPeqebTYTx9wKzeR39yfhGcbHJdkU0RAtPJQ7sLj70jLe8QpwioSyFrwqkQpEhuqOZKj10CkLP+6mfRn1GNKObzLK9OoOSAycVxnxYSXhflRJuVXzUAn53DfQ7vOrU/EOZPM11VsEz6La3jr5829gr0LRF4jRTDDIAEFI7nVZNXFkx4I8qu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UKvxAGbVK9qURW/nMH4CN23ngQ3BHp7XH8LaRoeDy4=;
 b=M1fSaasFwg5Bou1/vgfMlg7nRoLvXSp/llyM1t575qfWTibpDrbpbCGHfw20Y3/UOLFalo+U8NLaitv502CvRfmKAk96SggXDtmJUGgecSHO/UktMYHJDj566EpXnZ1UKIAnDvesE5T+lkOOFsxg11HZBlNsDIVzH4DUPVpvR9gkqLzvkaxyRz09/y7O956bOIbOTZE5O1Cf/MDUGYDJ1yr5jUC9y0U9ES+VoaTXzHOUgFk24PFeex1s+lWhV+XFWpiZqggcFOzEeH7OGM3SF6IqnlQQdst4ZzSMCR198hpEfk6rz8X1bwyXE0BZdVyK8wQXL9y5M31JmUvnHipZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UKvxAGbVK9qURW/nMH4CN23ngQ3BHp7XH8LaRoeDy4=;
 b=dEYakVaFVPbe8R7MbYZ4dPI0nDKjClWzvGFnh4j6J2ApiiwdEWtrflRfOfGKT144TNcEvDiKE3cb88jKiM3n/nZ+nCIzscJYoDU+7Y6CesZS044J/T19q21LWfIkD+Jr12wXYK6gCfTaiRt10ZSONukmqO0TLbzz5r0s0dH/1QI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6861.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Sat, 23 Sep
 2023 00:13:07 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d%6]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 00:13:07 +0000
Date:   Sat, 23 Sep 2023 08:12:51 +0800
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
Subject: Re: [PATCH 2/2] rust: arc: remove `ArcBorrow` in favour of
 `WithRef`
Message-ID: <20230923081251.2f702cc7@gary-lowrisc-laptop>
In-Reply-To: <20230921213440.202017-3-wedsonaf@gmail.com>
References: <20230921213440.202017-1-wedsonaf@gmail.com>
        <20230921213440.202017-3-wedsonaf@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 00bee959-a4a2-4cf6-3bb7-08dbbbc9dd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQFIMWm+BT3trQ5zfkTIqZInRViVFBP28oZ3V23z0rgMCRv77rlKS9ntDMHvds/nuHi0mFWGlpJj05HZOCW73RwjXhpeoNXGlR/5dgPDqhKuEQDt7JhgC9pwsZ+ekV8FH5cLa1xfIn9CQkJeC4BZnaWJ9bVTabEeFh2siKzPKAQNipGAHMdki8nC8u14myxCP8THw96fG8llVlb5ek0Pi9ef9OHZCUM+osACJbui7Ve6sv2sPX00RL/9Pa6nO5kOSLQwyJ+50AmbnLPzb3f6aBjG11LM26rAnbnoVjFtIlCR3pTy4Gd8M/aoXZQiZ+/Oq9vNo0D8N3rL997HDVlg5q2w7PpM2dmkGTkDh5Wl+hG+LzpYtXCbAd2oXN4LwTu8M+LIzT7+pQCqKJCgdFWZsL8bPflQrCaWm468iJmtp4294mBmKKBnG/6asuFLVAPgjCNK6Co/DwFY+qtQ1q314JfO65BMyeORdnIIHTacdMY+7cE3jEgNaHORTB5BqPJonn+CMsfa3yBr1Jiv/pulthxhY09XUSLf8e/EJwznni+d0g+L6iXZ5SaNKwJI1fRaYstEzCIgF0rWcLlzyyc5r5La0/CStaoHYrBZWagBG3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39830400003)(396003)(376002)(346002)(136003)(366004)(186009)(1800799009)(451199024)(1076003)(6486002)(45080400002)(6506007)(6666004)(478600001)(9686003)(26005)(83380400001)(41300700001)(6512007)(2906002)(7416002)(33716001)(5660300002)(316002)(6916009)(54906003)(66476007)(66556008)(4326008)(66946007)(8676002)(8936002)(86362001)(38100700002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IpGLQrlY1zlusGyp05OLLzzuRmfq4gJyY8kmIWiWmFTrQNCPik432dUhpvxp?=
 =?us-ascii?Q?BT5su0tCyNMiIdN3G9fGwdQRetA4R1Tu5oTQkQbJ7P/pWvmHu/HsXVJOapWX?=
 =?us-ascii?Q?4R9mdKbzSms8LmZ4Z09dOWs2YQAwurhFWjjUZ8qx/cSRq/ETyMYZX3UH006j?=
 =?us-ascii?Q?B1MvAHqx3Ci0oR6J2ccqYqfDfYJqHM6IUxQTbBAe9n0oz4TBsLdh56iBecAj?=
 =?us-ascii?Q?320D/j8UsqjZbZOxbmg7pXw4jkPNyAPQd47gVzi2mbYAvY8a6qhFe9MkQ1AK?=
 =?us-ascii?Q?uADNQH3N62bI5rwPJxxmrd0KX7D2KbBAPgmdmO+moMh9LZiEeD9eWl24oeYF?=
 =?us-ascii?Q?S+ie0r4O4CDZ61iH+AeZzQq0B3SuDD2xJBlQwsk0izerTLH6DEJgfDPcqrGx?=
 =?us-ascii?Q?kyGawrZgYtRF7QZDytaC4ypsASUVJi8vdI84sgOJCPWGKtrUQMBbm23Mlube?=
 =?us-ascii?Q?jKKxn5bmJzlLSyE0F+TFUIdNGlTzKxReT14J7WiB3JtgKtxNoN7h9FsNF8oQ?=
 =?us-ascii?Q?lt5UThM0IFzr9P2u32fqtfRX847haq772EwthzHTCfa+PqM7RHkhIjzzP6fZ?=
 =?us-ascii?Q?mSlF0TPjD2e11yYCBjMh9Wn5y0o4TlPWxWZG3Yk965rzpE61aAq2iMebaFfI?=
 =?us-ascii?Q?H1dsvkZynZAmDICM/4HhyCW8m7p+uqBjrZZL+M4WfxP+n4O1H/fhAvf4DXOh?=
 =?us-ascii?Q?zSfuWK7OntcOesRyy8xBdrq51ka4dUBuY9oU9dtGHM2t3nc+g2Vuj9vB6+05?=
 =?us-ascii?Q?i8T78qjU8ql05lnyJa8kQX3Vtxvb9UKmPZ7jI5PrfAsSuyzpl/jESpTEZ9tV?=
 =?us-ascii?Q?MjK6f0si71aXNJFUVzqcfsF4KtW4vW0/X5fS9I5cM5pSWqBFcwpzHJoWX8rG?=
 =?us-ascii?Q?E1g+Z4hRHXytYtjUlFD3Om4OGbsGDjewO1GQzAtKJScXE9Vv/IIHir0teKU1?=
 =?us-ascii?Q?b62raNxdSViaOSTFZatVjYtrAvn+8r41e3Eupj+cZxQIzBxAlhYKXeE1wTqp?=
 =?us-ascii?Q?Vq+lX1bsxd1yQM6olcjxqjyJWEKJjEEMO3VoagFCLa+dCyxhUNGw7CZynZCw?=
 =?us-ascii?Q?ZJiDJqRkd2Mm407Po+dZbMwsvojuqRQbBIunLV9cF7bl3p7kt8P0LXqUDynC?=
 =?us-ascii?Q?pxzJFtNO0tbtUx3qoxWZK9vvkNUmj8jvOrlm3/WJL6QZ0d1Ur3Z+dYKf0MtN?=
 =?us-ascii?Q?le0UWA+gNFgi3qxothgh6RT5S/iCxcIgJdysEYGI9PB7fn+6G8Y2g3thkGa6?=
 =?us-ascii?Q?bKjZV34KUIz0yG33tVfokITEhMwHaw6R0KqIGVGxlsrITKuGtSR1KIs3cRFi?=
 =?us-ascii?Q?ShqfiNFfTPZ2CpX5V6TYOnC9b6yrxvUyglz95gVTwJ/Ib3XR8TM7LPQXftHk?=
 =?us-ascii?Q?r7NO4ULqihMvymIUy2yEAMdny1t8uNZQ0jb8MHUxp2YsBQpqxh4Bca4eFoxs?=
 =?us-ascii?Q?bxVAZw1JFFD3Epjg7R58lFV+tj+HBLajFbCLfdeMxF2MSgoV8/AqOjyvJ+Mx?=
 =?us-ascii?Q?AcKyjHtVLMvR9AkIt4dr7HpawuV/dx6VIs2F2tIhl76quw9q3Txmgs8nls78?=
 =?us-ascii?Q?90HXB1DeQRncjD9nNpbdFdwBILDcLPWQr0OHjSXo?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bee959-a4a2-4cf6-3bb7-08dbbbc9dd0a
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 00:13:07.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbi13nnvpKwBHDmrBea3NH/4IBP0sq1nvBSUElXRowuT/3eGKguYO3Jw9dBhvJNflu85eP6/3rTyBALVzac8JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6861
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 18:34:40 -0300
Wedson Almeida Filho <wedsonaf@gmail.com> wrote:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> With GATs, we don't need a separate type to represent a borrowed object
> with a refcount, we can just use Rust's regular shared borrowing. In
> this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
> 
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

The implementation looks good to me, thanks Wedson.

A minor thing that worth considering is to implement `AlwaysRefCounted`
to `WithRef` and reimplement `Arc` with `ARef<TaskRef<T>>` or add
conversion functions between them.

It feels natural to have this this impl (because `WithRef` is indeed
always ref counted), but on the other hand I don't currently foresee
anyone to currently want to use this API :(

> ---
>  rust/kernel/sync.rs     |   2 +-
>  rust/kernel/sync/arc.rs | 180 ++++++++++++++--------------------------
>  2 files changed, 62 insertions(+), 120 deletions(-)
