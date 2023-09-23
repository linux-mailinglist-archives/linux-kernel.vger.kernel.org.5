Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678C67ABF27
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjIWJDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjIWJDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:03:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE29CC1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 02:02:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A854C433C9;
        Sat, 23 Sep 2023 09:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695459723;
        bh=1wubkG7ScgzJloOTfB6qo/zH9IOKqKxVD813hWAMOMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RVwSdE+tm0lpxlsWqXhaGtF2ducIVr9x3cxZz3wj1JpSqVnElQJ2JluT7yRQq72qC
         In/LR+xCLTgdJ7GVOXWdq0pPVjp4DmxNLYW1wQ8rXMY+aBQfN8EHTTBo6pENBRU24u
         IyT8bUspR70T26/FHiAbnuSW7wRsQoOE1/CfjUbuMhSmuH+xwLZWpzjX7NB37uIkuI
         29zgjWACFqp9ruPRugwyqA882HiME30/Payb0oZ0dyImZg2xupSPlOA5UAhg6iot38
         m/uoO6xmxETVcYUx9nEywcM4pX1yGrx7+XVj1kP9dIhweVDWLxmYmab/kS+E8y8Pts
         6nsleciA65S8g==
Date:   Sat, 23 Sep 2023 11:03:04 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Yosry Ahmed <yosryahmed@google.com>,
        Yu Zhao <yuzhao@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: Annotate struct mem_cgroup_threshold_ary with
 __counted_by
Message-ID: <ZQ8aSNgBiJI7Jr+T@work>
References: <20230922175327.work.985-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175327.work.985-kees@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:53:28AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mem_cgroup_threshold_ary.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  include/linux/memcontrol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 45d0c10e86cc..e0cfab58ab71 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -143,7 +143,7 @@ struct mem_cgroup_threshold_ary {
>  	/* Size of entries[] */
>  	unsigned int size;
>  	/* Array of thresholds */
> -	struct mem_cgroup_threshold entries[];
> +	struct mem_cgroup_threshold entries[] __counted_by(size);
>  };
>  
>  struct mem_cgroup_thresholds {
> -- 
> 2.34.1
> 
> 
