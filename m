Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADF8761960
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjGYNIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjGYNIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4471BFB;
        Tue, 25 Jul 2023 06:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 660456171B;
        Tue, 25 Jul 2023 13:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCABC433C7;
        Tue, 25 Jul 2023 13:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690290489;
        bh=4q4I7n0aaIqbGyfbXcBN1ws5DJhAn2FpdXMN86OAmmc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WVUB9FCdJv1EMYTjUcxHcXJYUouo2s3qYFsvmIep8uiGmG2mT3CXbh0wUYGDciXXv
         MF7/M9RtWwsx+Zc1tQ9E0IiUT652kY6j/OTrvPuENz8Y17YLnseAJIsBoYVgDVXfbD
         qCbHC3CGIAAy+u+1AxB/qu0V1Z6bkU7+qjC3IVe5w+16XyOMHQ0bbAdTTtfjEWuWFz
         A/AFGHYV7Ykg0IA0a1y4Mp8XYLIm6VFTn+i4aiST/3ybj/IATPEAAQbZtdECTWlO8R
         QBredBFWRj3SkU924kA5VrT065PclWUG/Z5DcQ5D4h3Jwsi2r76ZzNkZdNMIxGFGgy
         r+7WzUMcQf5dw==
Date:   Tue, 25 Jul 2023 22:08:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] kernel: kprobes: Use struct_size()
Message-Id: <20230725220805.af340161a7c620a33750fda2@kernel.org>
In-Reply-To: <20230725195424.3469242-1-ruanjinjie@huawei.com>
References: <20230725195424.3469242-1-ruanjinjie@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 19:54:24 +0000
Ruan Jinjie <ruanjinjie@huawei.com> wrote:

> Use struct_size() instead of hand-writing it, when allocating a structure
> with a flex array.
> 
> This is less verbose.
> 

Looks goo to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  kernel/kprobes.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 1fc6095d502d..1d749a917b59 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2220,8 +2220,7 @@ int register_kretprobe(struct kretprobe *rp)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < rp->maxactive; i++) {
> -		inst = kzalloc(sizeof(struct kretprobe_instance) +
> -			       rp->data_size, GFP_KERNEL);
> +		inst = kzalloc(struct_size(inst, data, rp->data_size), GFP_KERNEL);
>  		if (inst == NULL) {
>  			rethook_free(rp->rh);
>  			rp->rh = NULL;
> @@ -2244,8 +2243,7 @@ int register_kretprobe(struct kretprobe *rp)
>  
>  	rp->rph->rp = rp;
>  	for (i = 0; i < rp->maxactive; i++) {
> -		inst = kzalloc(sizeof(struct kretprobe_instance) +
> -			       rp->data_size, GFP_KERNEL);
> +		inst = kzalloc(struct_size(inst, data, rp->data_size), GFP_KERNEL);
>  		if (inst == NULL) {
>  			refcount_set(&rp->rph->ref, i);
>  			free_rp_inst(rp);
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
