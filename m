Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A0C793FC4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbjIFO5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjIFO5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:57:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4166194
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:57:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B839C433C9;
        Wed,  6 Sep 2023 14:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694012251;
        bh=ZBgpvR4ajUnLeP3Ejw60COA1aCrBgnETU5Rszf3cZPg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PlTUmJe34gfRXP6APUN0lg5l/al9gbz/RjW2qdABsI6QjMj+MY1S9eueO/gOk23UU
         tdlykc4CILwMlyYQtLPGefJhnoUp6QdN0lPRevkZuM9+AaEQsgjn3gRma0Mi6SL9Pm
         IVY5lXXkKBLIF0ux5mD/Cfos5bs/37G/zMAUoel9vHhLdxfjKfV7bdsilx/z5L/8b2
         cq3CcVQiKcqh3pwnWF/bCOXhXLOGDbfezxVE/diTRfcGuaA74J1S5CbWu2NHx1iKoa
         b/UkP/wQnj0JM3UUSw3DuYj8z8GeN6t8MdkD05L7327Szpq5G34KeRa3vvtAMdYiAF
         NP7P5TlVicDrA==
Date:   Wed, 6 Sep 2023 07:57:30 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     syzbot <syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com,
        hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com,
        yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] general protection fault in
 bpf_prog_offload_verifier_prep
Message-ID: <20230906075730.6d61420a@kernel.org>
In-Reply-To: <f3eacce9566d14141cb591dc8364123b809841cb.camel@gmail.com>
References: <000000000000d97f3c060479c4f8@google.com>
        <ef4b96a75ff8fa87a82a35d4d050338d0bd9cce1.camel@gmail.com>
        <f3eacce9566d14141cb591dc8364123b809841cb.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Sep 2023 16:50:23 +0300 Eduard Zingerman wrote:
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 3e4f2ec1af06..302e38bffffa 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -199,12 +199,11 @@ static int __bpf_prog_dev_bound_init(struct bpf_prog *prog, struct net_device *n
>         offload->netdev = netdev;
>  
>         ondev = bpf_offload_find_netdev(offload->netdev);
> +       if (bpf_prog_is_offloaded(prog->aux) && (!ondev || !ondev->offdev)) {
> +               err = -EINVAL;
> +               goto err_free;
> +       }
>         if (!ondev) {
> -               if (bpf_prog_is_offloaded(prog->aux)) {
> -                       err = -EINVAL;
> -                       goto err_free;
> -               }
> -
>                 /* When only binding to the device, explicitly
>                  * create an entry in the hashtable.
>                  */

LGTM, FWIW.

> With the following reasoning: for offloaded programs offload device
> should exist and it should not be a fake device create in !ondev branch.
> 
> Stanislav, could you please take a look? I think this is related to commit:
> 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
