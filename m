Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D03798AFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245241AbjIHQx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242077AbjIHQxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:53:25 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED562105
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:52:54 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6493389c56fso12576376d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694191974; x=1694796774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFgFFCKLJ5w4KEXVj4sLDW2zQKRl1fCp5caELQugN10=;
        b=Umx9ZAOQYrQjY6VaphdIL5/UmiDyvQfSGa860US8sCqIALK8uHrOJNckzZjaiq4wcR
         M5id9cHBVpSD0ziUMk2QwqCFm8GfNhf7LWQW1nAZuOrUPU6GOqOfxRcL2ePY5rvItTdl
         eFjVbuusU1mQmEWAy7Qx/ASPxWAGGMh+/nH53KW2i28lCdULSj7XtpwquZlMX8WGnbYj
         Mh/R/jDmA7SL+PdZLTwHLvo/4ojh6rWUVcJCjM/9KzTUeHB9ype3GrSwnmYDjiMipS9o
         Yuzn8BM2wWTtbdHgQ7LjFuvnSW3IUZnOHWbKR81O4c+a+vRRn3dZ/cQPTga/n3XzkQ+W
         FPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694191974; x=1694796774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFgFFCKLJ5w4KEXVj4sLDW2zQKRl1fCp5caELQugN10=;
        b=bOka3/u/y+Y/qWiIrKoOhGzSL/pR5ebFJ7hbP7a3K2IhVW+iOMrAxPREFL7AsFLZmu
         Ub1xjWijEmB75NF15j1V330W3L20wZRCXo+nIVDQyg+y1byPNBbCmrWnjwTdS6QQnzi9
         Txw0vBi+ckrMbty42BzQm9FBqWUS7qD/Jnh/I1R6MFf8nBqOZgLNGMVDyxsiMf0D2BrZ
         7qAc1NUJX41lxB0Q24BxLpLdU3MHux03QYcKbgMaBiyyz16/XR9lIKfgLOxGZpWMA3h0
         w1UfQty51gLuMhiaFDcFDvXYmerbMgCwxnulx/IVyWuMoEkihOktnwOEeR7X1oXaC9oF
         dJPA==
X-Gm-Message-State: AOJu0Yw6uhjfLSFRf4leXu0kqAVx4j5mA4+86+D/lXEojXQfmizgS/So
        Vk7mT4et/bIvgorcH0CJZ4jiHhqHtMO4COnTRq/bdw==
X-Google-Smtp-Source: AGHT+IFXSQuRL19IVQpjI0ydTiACWCGqqd0y6PANxeLBcmXvUcpWOa8JEabxZHoydCi24eoU5hNMT11dg17tr5jT2uA=
X-Received: by 2002:a0c:9a09:0:b0:64f:3c68:98ea with SMTP id
 p9-20020a0c9a09000000b0064f3c6898eamr3178455qvd.2.1694191973767; Fri, 08 Sep
 2023 09:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230908093103.2620512-1-liushixin2@huawei.com>
In-Reply-To: <20230908093103.2620512-1-liushixin2@huawei.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 8 Sep 2023 09:52:14 -0700
Message-ID: <CAJD7tkafz_2XAuqE8tGLPEcpLngewhUo=5US14PAtSM9tLBUQg@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: fix NULL pointer dereference in can_reclaim_anon_pages
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Sachin Sant <sachinp@linux.ibm.com>,
        Michael Ellerman <michaele@au1.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 8, 2023 at 1:37=E2=80=AFAM Liu Shixin <liushixin2@huawei.com> w=
rote:
>
> The variable sc is NULL pointer in can_reclaim_anon_pages() when called
> from zone_reclaimable_pages(). Check it before setting swapcache_only.
>
> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> Link: https://lore.kernel.org/linux-mm/F00144DE-2A3F-4463-8203-45E0D57E31=
3E@linux.ibm.com/T/
> Fixes: 92039ae85e8d("mm: vmscan: try to reclaim swapcache pages if no swa=
p space")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f1dc0dbf1cdb..5eb85ddf403f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -617,7 +617,7 @@ static inline bool can_reclaim_anon_pages(struct mem_=
cgroup *memcg,
>                 if (get_nr_swap_pages() > 0)
>                         return true;
>                 /* Is there any swapcache pages to reclaim? */
> -               if (total_swapcache_pages() > 0) {
> +               if (sc && total_swapcache_pages() > 0) {

If sc is NULL, we will not return true even if we have pages in the
swapcache. This will make can_reclaim_anon_pages() return differently
based on whether sc is passed in. Is this the needed behavior?

I thought the sc NULL check should be used only to guard the setting
of sc->swapcache_only, not the return value as well?

>                         sc->swapcache_only =3D 1;
>                         return true;
>                 }
> @@ -626,7 +626,7 @@ static inline bool can_reclaim_anon_pages(struct mem_=
cgroup *memcg,
>                 if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
>                         return true;
>                 /* Is there any swapcache pages in memcg to reclaim? */
> -               if (mem_cgroup_get_nr_swapcache_pages(memcg) > 0) {
> +               if (sc && mem_cgroup_get_nr_swapcache_pages(memcg) > 0) {
>                         sc->swapcache_only =3D 1;
>                         return true;
>                 }
> --
> 2.25.1
>
