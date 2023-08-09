Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4794775EE7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjHIM2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHIM2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:28:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2362E1FCC;
        Wed,  9 Aug 2023 05:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD68D63889;
        Wed,  9 Aug 2023 12:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A73C433C7;
        Wed,  9 Aug 2023 12:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691584114;
        bh=sEM6A7v8beM65GOpgbPHHqgeliizvdkk3E1U4YHkLoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lpoK/uANDrW8WWjFdIuPn8HIUyukQYCDHPHUzvttZ439ycDydHiICm5YqRDCqY6fX
         GhUTaH+Tj/1szgSGYR7S6EQdOjsMVdj4pvqmSSrtvP5avxFBLiaWavN8Kb3h28jJXg
         0VqS1lIIo9GuUeiOgZH1PUu7H7QSp23twNms3I9JUpceKvuKxSZpnG5ZNNoIHDz3Ed
         UMGCP3VYYbXzf8n4GhWVDo8RVGAGAuw7lwGS4GMhtU3bZxpSZum6GlCMb07OXLrdwn
         5fLzVBS/OUNhIv+pdDtHcBi114C5FDI0zl8wpha3dCK7Ny0bGlzjDJ21vQU6w/HEoR
         FzVF/NRyH3dQQ==
Date:   Wed, 9 Aug 2023 14:28:27 +0200
From:   Simon Horman <horms@kernel.org>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH v3] netfilter: ebtables: fix fortify warnings in
 size_entry_mwt()
Message-ID: <ZNOGa02ymvkTAXPD@vergenet.net>
References: <20230809074503.1323102-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809074503.1323102-1-gongruiqi@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:45:03PM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=y, the following
> warning appears:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘size_entry_mwt’ at net/bridge/netfilter/ebtables.c:2118:2:
> ./include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Werror=attribute-warning]
>   592 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The compiler is complaining:
> 
> memcpy(&offsets[1], &entry->watchers_offset,
>                        sizeof(offsets) - sizeof(offsets[0]));
> 
> where memcpy reads beyong &entry->watchers_offset to copy

nit: beyong -> beyond

...
