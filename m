Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440917AB930
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjIVScM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjIVScL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:32:11 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A09C1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:32:03 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-578a62c088cso2984697a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695407523; x=1696012323; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ngBf+ICvbxi0AiCYVulY76r9llgqXQtbJzL3HizOtVw=;
        b=THn26/uovqc6YYrJhCHEn9NZwjIxqhMByK+6Z6snN6B/UuS3mnUduGhdG5MDM3Hikg
         RYmbD/9kfrbH629kT36/LB9VTzVTWSXoHsKuZpwt2ZhCamkHYVGK5KSnjrwqI0M9R0z4
         fNlbdFxf012kTFbatXD2Bp1HGu27p87yUEiVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695407523; x=1696012323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngBf+ICvbxi0AiCYVulY76r9llgqXQtbJzL3HizOtVw=;
        b=B0mA17HrDzOOw+9VQ+XWU85yXV/axogRU5FMjn+plaXdXt0ysHE6w7438quTh5WBAU
         n5adrrtU3UmM9s3altFFO9EWOdd70r/v92lIq841fVQYDZ0C7rb9rlZE/xVA8xsBpSW0
         V9E2PTLnVe/sQ+8pVSRPDANq0dIzeyJEYVaa8mpRWZxz2PSl7JUwMIo1LndW97GzJe9l
         kZ59gk+d67o3uqvGT6SsoB6nozonFrxauLS+Y1Cxg8u0HHGEnAEu/NHIYxCeHR1W3x9I
         2D/4MLevmLeaNallPa9f2yRmNtagKzu/B2TUaJQU84UJHfOdmQgpV5WWAt6ZWhzMWRii
         HEiw==
X-Gm-Message-State: AOJu0Yzk7BsN0VLo2+jhqf9YmsZx3HfBOEy2uFAM/AB0RI7HLDjdugaG
        lzD5cxnLqXn1yE5ZkZibNolO/g==
X-Google-Smtp-Source: AGHT+IGMpVeVaBKxQRuTd7FExBg+6JvbIKew4fzduHUrzQv2ncVyYW9f1qAq9F1UrlDz3W3OfJNzAg==
X-Received: by 2002:a17:90a:428b:b0:268:535f:7c15 with SMTP id p11-20020a17090a428b00b00268535f7c15mr5122344pjg.0.1695407523130;
        Fri, 22 Sep 2023 11:32:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a004e00b0025dc5749b4csm5726599pjb.21.2023.09.22.11.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:32:02 -0700 (PDT)
Date:   Fri, 22 Sep 2023 11:32:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <202309221128.6AC35E3@keescook>
References: <20230922175327.work.985-kees@kernel.org>
 <CALvZod5xVhR_Feq7Wp_P9BLjYHJCxqvA6BmHmzwGzw34niDQ2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvZod5xVhR_Feq7Wp_P9BLjYHJCxqvA6BmHmzwGzw34niDQ2g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 11:25:56AM -0700, Shakeel Butt wrote:
> On Fri, Sep 22, 2023 at 10:53 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> >
> > As found with Coccinelle[1], add __counted_by for struct mem_cgroup_threshold_ary.
> >
> > [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/memcontrol.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 45d0c10e86cc..e0cfab58ab71 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -143,7 +143,7 @@ struct mem_cgroup_threshold_ary {
> >         /* Size of entries[] */
> >         unsigned int size;
> >         /* Array of thresholds */
> > -       struct mem_cgroup_threshold entries[];
> > +       struct mem_cgroup_threshold entries[] __counted_by(size);
> 
> Does 'size' here have to be a member of the same struct as entries? We
> have nodeinfo[] in struct mem_cgroup whose size is nr_node_ids which
> is global. Will __counted_by() work for that?

Not presently, no. This may come in future expansions of the feature.
We're also hoping to gain expressions for places where a size isn't a
native count, like for big endian, or a byte count that includes the
entire struct, etc. For now, though, the feature is narrowly scoped just
to get the common case landed.

-Kees

-- 
Kees Cook
