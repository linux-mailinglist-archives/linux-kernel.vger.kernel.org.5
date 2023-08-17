Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E76177FEAF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354736AbjHQTpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354728AbjHQToh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:44:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B7F359B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:44:36 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bc7b25c699so1458315ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692301476; x=1692906276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOdpLYxoLdDmx+TSr95GHH7gDMjqei8L96nVIKirCWI=;
        b=On9xusN8g7izznKyvse5ccEsSYnblSeWqRtkpxOK5gsVqQ5zms7D2DhmB5e51qjXqb
         njjxN2GoUtGK//o3YuF4w9bZtAdG4CAaDmuvnwkvDLlVGqy1pID+HJSSidHDADrCEan9
         woMrLYxmESn8f1AugKZGdsnAc+1pCOvmry1h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692301476; x=1692906276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOdpLYxoLdDmx+TSr95GHH7gDMjqei8L96nVIKirCWI=;
        b=bxAQ1fssL+7JScvHMHUPges3vQoMEQxB/qRGjjDHcCMAvPTP77bciHtUYlwdw+8ngb
         Ic7TAnMojB8UJb22TlfDI5gEmYjosnYJYz17c0rjX30CO1YkREWnkF2Fl6WHdFcbkMa4
         Lzm1myzrD7Dm4eo2lLSQtWm1Z1o+oaknPchRNgBPR3Fn3hnS9Mey8vELOKDfjt+yWl4M
         rG93NMaG+vOeBNFn8YcpkWfkyKUag8z2sguRaGkBtT0cXv1EkXnSVkec8SDtzFnk2LsK
         FteQX1+Si9xHulSrjCSZ3pqUJeTiorBmTkdL4Op5pYbf19Q/VXMDAql48BTANpDN+rSP
         3w7A==
X-Gm-Message-State: AOJu0YxXCanQNh8CTVoh0RxgvaQPoy33PdZINPbIbz2AupIZD9JHAuKK
        +fajKdsY/Mp2BqCZ3psviOLHYw==
X-Google-Smtp-Source: AGHT+IFYUfkZU/56LzRQHmcIWw+gdtjTYdMJMLO2aNeokD82YcM28GMv6GtlRXUt8yv7fxFy/I5rCA==
X-Received: by 2002:a17:903:1248:b0:1bb:d59d:8c57 with SMTP id u8-20020a170903124800b001bbd59d8c57mr405217plh.18.1692301475920;
        Thu, 17 Aug 2023 12:44:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o4-20020a1709026b0400b001b06c106844sm136078plk.151.2023.08.17.12.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 12:44:35 -0700 (PDT)
Date:   Thu, 17 Aug 2023 12:44:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] cgroup: Avoid -Wstringop-overflow warnings
Message-ID: <202308171244.4FCA8DB40@keescook>
References: <ZN5WkbPelHUSTXOA@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN5WkbPelHUSTXOA@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:19:13AM -0600, Gustavo A. R. Silva wrote:
> Change the notation from pointer-to-array to pointer-to-pointer.
> With this, we avoid the compiler complaining about trying
> to access a region of size zero as an argument during function
> calls.
> 
> This is a workaround to prevent the compiler complaining about
> accessing an array of size zero when evaluating the arguments
> of a couple of function calls. See below:
> 
> kernel/cgroup/cgroup.c: In function 'find_css_set':
> kernel/cgroup/cgroup.c:1206:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
>  1206 |         cset = find_existing_css_set(old_cset, cgrp, template);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/cgroup/cgroup.c:1206:16: note: referencing argument 3 of type 'struct cgroup_subsys_state *[0]'
> kernel/cgroup/cgroup.c:1071:24: note: in a call to function 'find_existing_css_set'
>  1071 | static struct css_set *find_existing_css_set(struct css_set *old_cset,
>       |                        ^~~~~~~~~~~~~~~~~~~~~
> 
> With the change to pointer-to-pointer, the functions are not prevented
> from being executed, and they will do what they have to do when
> CGROUP_SUBSYS_COUNT == 0.
> 
> Address the following -Wstringop-overflow warnings seen when
> built with ARM architecture and aspeed_g4_defconfig configuration
> (notice that under this configuration CGROUP_SUBSYS_COUNT == 0):
> 
> kernel/cgroup/cgroup.c:1208:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:1258:15: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:6089:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:6153:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/316
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
