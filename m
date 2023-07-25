Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C0F7608D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 06:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjGYEo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 00:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjGYEoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 00:44:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5296F173F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 21:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D85F261531
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C42BC433C7;
        Tue, 25 Jul 2023 04:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690260254;
        bh=+ACqNdes4jmCi8Obnif4i7hbEQJMXGCeCk+pRu6qhsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOgwA36ZJTCd8ep9foyK0Ml6RVutpQV8FWOfYn7vpM+S6O0aWLUKjFZoTDm3u8Y+3
         jWWWu6hOO00usmnVc/wGuEbZzZPEU+i/cSm9N+l1uUXJuZxV4w3P2VDzq1Kmf8tHyo
         yXf8qsQwLVFfEN8rE39M9L8iCe/FQkzOUAtzuUNwe/cDH4lUNlPCbzjEiOumg+WgNu
         jVDPn8W+a3poZOXFm/5eQgf+iAD1JmZyuMbnhIGf+OqKlbb+LANjw6lxOVUWFU/yRB
         nBnE73BheMbhgboucKa9fjeYxDfvkbwhVJeo23Pmj1EzCgbxVinfshWVOw8bGU0Bf3
         8xrmZxrTB2KTA==
Date:   Tue, 25 Jul 2023 07:44:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>, kuba@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        ast@kernel.org, martin.lau@kernel.org, yhs@fb.com,
        void@manifault.com, andrii@kernel.org, houtao1@huawei.com,
        inwardvessel@gmail.com, kuniyu@amazon.com, songliubraving@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
Message-ID: <20230725044409.GF11388@unreal>
References: <20230725023330.422856-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725023330.422856-1-linma@zju.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:33:30AM +0800, Lin Ma wrote:
> The nla_for_each_nested parsing in function bpf_sk_storage_diag_alloc
> does not check the length of the nested attribute. This can lead to an
> out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
> be viewed as a 4 byte integer.
> 
> This patch adds an additional check when the nlattr is getting counted.
> This makes sure the latter nla_get_u32 can access the attributes with
> the correct length.
> 
> Fixes: 1ed4d92458a9 ("bpf: INET_DIAG support in bpf_sk_storage")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
> V1 -> V2: moves the check to the counting loop as Jakub suggested,
>           alters the commit message accordingly.
> 
>  net/core/bpf_sk_storage.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index d4172534dfa8..cca7594be92e 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -496,8 +496,11 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
>  		return ERR_PTR(-EPERM);
>  
>  	nla_for_each_nested(nla, nla_stgs, rem) {
> -		if (nla_type(nla) == SK_DIAG_BPF_STORAGE_REQ_MAP_FD)
> +		if (nla_type(nla) == SK_DIAG_BPF_STORAGE_REQ_MAP_FD) {
> +			if (nla_len(nla) != sizeof(u32))

Jakub, it seems like Lin adds this check to all nla_for_each_nested() loops.
IMHO, the better change will be to change nla_for_each_nested() skip empty/not valid NLAs.

Thanks

> +				return ERR_PTR(-EINVAL);
>  			nr_maps++;
> +		}
>  	}
>  
>  	diag = kzalloc(struct_size(diag, maps, nr_maps), GFP_KERNEL);
> -- 
> 2.17.1
> 
> 
