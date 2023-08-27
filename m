Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA1C78A13B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 21:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjH0Tly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 15:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjH0Tlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 15:41:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E81312F;
        Sun, 27 Aug 2023 12:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fy3U+ypUoPR45z16bJsFEpTDNrdS4XQhr4VLASQbjY6JyAgTA7qfdah1x0JTDb4muoTsP3xr/LZo0vIxFOduLaly0Fi2WBh7nTQPfwmX/dXSanAud3Cue+sRHvwzQeRZb6H5y5Ji8SlOyUFgbbmqMsW0iBTouyOceosrZpN3TvvA4aHg4la8TCmkCwgYZYJ/T3nlzKTUWifrXBdSptawTfizJZJL97qjrAldvTnWd6eU2B3dDoZPSSDJSAaM+UJEhDRu2Ti3ZM46JecKu+Hlgt3X62GRuW0G1wXyHurg+OGor197ShKR5fQTVEU5cZV1yug2oMZqvt0XfSQe9l0VyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUnzvYJYWlCqM52IlkE6DHQ8OX26/rGZsrQ9nIAaIgg=;
 b=O6T4gR7WifBm6iY7IKpvbw0HQhf/89KlHzP//Ht8ym/bezPubpZ9ZG4Ba9Mho+UqrWc0LUDrI83rQDtR26eRSyJFrfHvjOhFUX4h2S6D6AHqKsXEKGA4bBYU7b3EY8Nd0ICMB7FrUFk+/Z5AB0sGCnf1jcNdu+4aKa1pp8eQUzvbaTtDUqctfrx/Sc9bl2S5uADam3w1fVxH3N/t5VvDh3sdM52bvtWz65Uc/+VcfFqyqOeuWIJ1qNbgwnizBfp9gZyRyIx4Qew88cM2Lxd9KPaxhSis9S33fopkkWWm04HH9M+3lxsSt2GaNAaBMZW1CXAWKCXvku3IXPF/+YEgKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUnzvYJYWlCqM52IlkE6DHQ8OX26/rGZsrQ9nIAaIgg=;
 b=lJfEegVO3+WpPC5iGl0CrCCGFRK5crzEOPAt//tQW2H8BvybLK3uWOk5tTlgrsxNDjwppiH5y5dr7nupOWvtrlq+32YsHnOMTxNwFAeHBoZmczdI7SslRgrkFk42AKrzLguDDfrquti+WLW2wAdQwjzbhXPqmztD6uOhJ9GnWZ81JA40tt3s1trUWWpLPQf0LIIqN+mjPaQ2HhRItWcbZy0m7iXTNNS3xeCkS55RAGFCEJxzKZEdFQrO2OhJs5WQKAv26oVtkDmiklWhEUmphqF88ojc1q6+ME/fky+lrX5M4eYwa8hZ3eS/YGC+TGp5pTa+bkQG1UAD4yQ1NVJjVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 19:41:38 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f%5]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 19:41:37 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/3] HID: nvidia-shield: Fix the error handling path of
 shield_probe()
References: <cover.1693070958.git.christophe.jaillet@wanadoo.fr>
Date:   Sun, 27 Aug 2023 12:41:28 -0700
In-Reply-To: <cover.1693070958.git.christophe.jaillet@wanadoo.fr> (Christophe
        JAILLET's message of "Sat, 26 Aug 2023 19:42:16 +0200")
Message-ID: <874jkkqnmf.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::33) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BN9PR12MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e9da60-41bb-48e1-67dd-08dba735a0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ivn+vlj5oj/u+enn9DjbjDz8hV/rcdInI8m7zc2SQnbbKS+N/B3Qq2Jcfw2jh1QRZTLW5QsZs47mNdIv1RLPS/TQ9OjAJPei+lEJ/bDdrwk3w8iRggUy8AVdhyavNiWT/5bm7CWP6/1UrX78qpbLY0sAhgtMsRmGG8/ki0AKOyBka1zXxVkNwFfyzEQ7bjdiNWv6vHMHcqfi7v5PYU0lcHpYUAfaJB7/AxzcAOGKQrhVTPNpVBPflzK+WDKaiu3FB9kqh8YJNerugkjIUrhJXNHKaxPrjVJUE/w9ilH7Aao3k8SPinvZQJsxOo7dmxnqPped7TsgB3onxSPx+CagHloozVr7jBVqFheGVv0pMY1Ab1GmVHbOwzwrtD0oEEQUs3Wo2UcGi180OHNLt1DAYlZh0dhopji1ORcXA5a/RPwSJ9bOUxZG0i7f3xDMGIoIiRjOZQ/is+/nzWeafgtYOEWUzaWNMbc3/J6ZVTgBseDi+mXPWLtnlu5zDooImOFkN9R/HVNzEXC+bTBOKyttwhNV52DTiShkXPJUPdygcxnH5MTlD3GzEWbAGHAbj/PR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(186009)(1800799009)(451199024)(6666004)(6512007)(6506007)(6486002)(2616005)(2906002)(5660300002)(86362001)(4326008)(8936002)(8676002)(66556008)(66946007)(36756003)(66476007)(41300700001)(316002)(38100700002)(6916009)(478600001)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHyiGnomR+9Yz51deJ4IlBjfxgJweLUmeiWE1TtyLnGQ9/1QgWfo8UuLhP41?=
 =?us-ascii?Q?K+ua5FIrIp51y7VsGZuc3CGfXcU0EJxwC6S7WE7usOw6qn7G2/5E85QK7XF4?=
 =?us-ascii?Q?O5VSZt+WIul5ZdSG15jbow+lEohPtazeL/rsxnXv/VEpOES8BSS/AOXAUkUT?=
 =?us-ascii?Q?49DAxva+mPvi+pbVY1C6svgCJYpzat7xJRiEXPhEZx6KEUQ8AQAQxa3tpLHz?=
 =?us-ascii?Q?v45O2+Lm9VnbkvAQZXJJfMHiTXyHSKCkWVQvo2MMshqHFVb4EUSFMeQgir13?=
 =?us-ascii?Q?WsTf3CPPogJ51V1mts48l9tXoTYEe+TkVhsQDt4Ji+HpYx6x3/ukP0vv0Q1j?=
 =?us-ascii?Q?4Xir5j25LbHMhokF1tcYxyrr/JFTomno92uX+vaR3+/Nzp7hPe+cxQeKOmy2?=
 =?us-ascii?Q?jAfwpO8c8eomSkI9/G+7qe0vn057tJiBoQCjMMH+cZOQAgqe0cvkSyrDChHe?=
 =?us-ascii?Q?8itQOCE6qK5rc8Qr0LygMzyJ663Kizo45jxj3SzD9X44L6IG14aRps8BwHAy?=
 =?us-ascii?Q?te9KdNZLe/8JYk1atMmHzYn/VaGlQTdSuXUeUudl2uYyTxVd6XSB+1sydRHo?=
 =?us-ascii?Q?NXREdg0MigCgC4uqRkKnlzETDWxed29ey3YX/dMvdQ23TREeH1/AuGknORC2?=
 =?us-ascii?Q?A+gJbFqloz6cm+nxOXNiEdsCs//tL2SxTDKu9A2El5Rtp3PigJ5D7YY9zy1b?=
 =?us-ascii?Q?rfh+Vr+qEVcPb3Hf0yRP5bUp+f0KjadzqGz8aWy0741OKdDOPy8VoprxL9PM?=
 =?us-ascii?Q?3+xrMWRzGUwf1ejwVDCOVseF/KKtPPJXfoIE5vGA96LLhxLsh4uDvu956xG5?=
 =?us-ascii?Q?f4rr23sd0q83JQOVswY3XfCX8Tk2ErxieeWs4YCzg52YKNgjy16bPr+22Bju?=
 =?us-ascii?Q?dsKeu62HF1yk+oGYGrHkYHPUIZDD9RdBF/o5NOWfJYrHPdXEdv+/I/iWBcfU?=
 =?us-ascii?Q?pD/v3clCFFH/hh8yNu9/rkJr0sIMq6Ar6MfbIXBk/pEJctj2SpyCxjsIrZfw?=
 =?us-ascii?Q?h6gIDxncdG0X+/cTr5kclt1qxPezZDT8tvOGjXT4hx5PK9AjDKa7wQfdAIn+?=
 =?us-ascii?Q?BBsdFQrWyrqHRIwBnx5TfLo+0b6YTf6bbvqqzfKzSAPxSsgXlhJ30iBEJ/2X?=
 =?us-ascii?Q?euV8hH4rOoe3voMiFsgHvYPPnBbho9daK0q9S3Hz6I2hR3tr3t0dFzunT2ng?=
 =?us-ascii?Q?Krp6VFO4k0kzFw4sw2V4BYxKjs3prM8LNKm6zVlAkdyCfbfJcruCVmAyeQrB?=
 =?us-ascii?Q?UUBl/CeMHr9U3VnirXrmR8C/i89UyJpHOyYQhdvaGcnQ7E73jji47QxFeSIa?=
 =?us-ascii?Q?Dbg5mDFVrnHD45I5AJBW+jlPPMAtgU/PKkAuTmY4WWowGNgfU8MJlv/0oI2i?=
 =?us-ascii?Q?RD4bTvKDZ6S6kxtMhWpiSVmrNhgmyVpw4om7D2D6DYc0tFGxmRpH1iHPJVNn?=
 =?us-ascii?Q?FCJBSB1mx0pMCOIK1tEJpJolRd3t2F4Z/1jNlnNNJCkoBISnqY4QktmFwcjf?=
 =?us-ascii?Q?TtAAPq2HbnJN/phWuNk+CittR4pGP2pllgV8l1nPdT0v49cQTYxDZABqWVFp?=
 =?us-ascii?Q?+EGYX570ERjfD5WyFGLHXjKXiZv8zLnC94tgzVvI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e9da60-41bb-48e1-67dd-08dba735a0d4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 19:41:37.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyGqUs5MxUvfKYU2ViTCMMbNahNbIW/exjbhvW++4sbsxqHTsgmLH3EhvIhwUGscBEEYGXjlTqEaXf3yFZ239g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug, 2023 19:42:16 +0200 Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> This serie fixes some missing clean-up function calls in the error handling of
> the probe.
>
> Patch 1 and 2 fix some similar issues introduced in 2 different commits (hence 2
> patches)
>
> Patch 3 is a proposal to be more future proof.
>

I really appreciate the contribution.

>
> *Note*: I'm not 100% sure that the order of the functions is the best one in
> thunderstrike_destroy(), but it is the way it was.
>
> My personal preference would be to undo things in reverse order they are
> allocated, such as:
> 	led_classdev_unregister(&ts->led_dev);
> 	power_supply_unregister(ts->base.battery_dev.psy);
> 	if (ts->haptics_dev)
> 		input_unregister_device(ts->haptics_dev);
> 	ida_free(&thunderstrike_ida, ts->id);
> This order was explicitly chnaged by 3ab196f88237, so, as I can't test the
> changes on a real harware, I've left it as-is.

I agree with this proposal. Let's clean this up in the patch that
implements thunderstrike_destroy. The order change in 3ab196f88237 is
more a matter of sloppiness rather than due to handling some functional
side effect that requires the order change.

>
> Christophe JAILLET (3):
>   HID: nvidia-shield: Fix a missing led_classdev_unregister() in the
>     probe error handling path
>   HID: nvidia-shield: Fix some missing function calls() in the probe
>     error handling path
>   HID: nvidia-shield: Introduce thunderstrike_destroy()
>
>  drivers/hid/hid-nvidia-shield.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)

--
Thanks,

Rahul Rameshbabu
