Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC28D7FFC9F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376320AbjK3UfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3UfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:35:22 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223AA10E6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:35:28 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ce2988d62eso843848a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701376527; x=1701981327; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BvSdTJaNOnOGpTCIQ0TIiZEwNuG0mo2jRjX7yhoMQa8=;
        b=fGRMAL4OPiTkIzFJswEDKdRw+1J3cpDDOc4JliQMvfFrlXvpw7TVvCUsVJKTSinxla
         yY5zpSyiD4X/YVNaLQA2lVpLwB7Dh4oD4Eecdmz/GK1g1EiiIzWgggBa7QbnawKhSCdU
         yMqOTyE+ji9YiyU8a4kTlwcj5cXDolg2Me4QiYebp++IoZWPIMxyfQF0955r++RKt7d0
         qQrtzPFa56W8VeVCg/2JbsJoJfUoTIs/ZY+HjxhoVRdu0Os5BP8XC0D4dFru63rTSjFS
         MHY4bnxI227DNv59FARhNaDXXdeXObmSgjk48ue+I+1BZxc4p35Da+DJY27NcS4NN8OT
         0mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701376527; x=1701981327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvSdTJaNOnOGpTCIQ0TIiZEwNuG0mo2jRjX7yhoMQa8=;
        b=eAfC27o3xa7KRmIxUKYysx5GJz/znW5+z6vhA7REllNXzwW7QxZTD7v7rX/jsOmZf0
         9AS4HYsvQan7gN/wOyX7I0TPn8yq5JHuerXTGPhxDMalSPmoghgUOWot6x09/xGDfqb0
         623IvYpKZBQ3mC3hzgPkfH7aLCcAXGP5U5BMqOCE85CIrqF4MlDRCUE+/O/u2eFSZzwy
         B+pucMXBJ9EO7/C6wcQbmGIgbhVc9aTrUzM9wGFoigB26iI+C2MwX73PlffM+D4Hb6S3
         vhFkYlMTuqhFXyfrEaCb16pmut7KL79frbJsjJChvOPbUlCwlpS8C4Y1y5MHoh4k0/Bu
         CdEQ==
X-Gm-Message-State: AOJu0YzESCCVnv3ow4QHpytPlfwbG06qOeRcMjM/4zPQta1H2aI7X6hG
        /A2iS9dUDlsG1Zb4w7Y4G/Tk5Q==
X-Google-Smtp-Source: AGHT+IHJ7OLYrr+3HHJd78vh493YJrStqv/97nm/tolthFXTq9aW9P83YmmgwtFds6L9t5rJr1+WbA==
X-Received: by 2002:a05:6830:4423:b0:6d8:5027:4620 with SMTP id q35-20020a056830442300b006d850274620mr946111otv.24.1701376527391;
        Thu, 30 Nov 2023 12:35:27 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id eq8-20020a05622a5e0800b0042404e87331sm66369qtb.64.2023.11.30.12.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:35:26 -0800 (PST)
Date:   Thu, 30 Nov 2023 15:35:22 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v8 1/6] list_lru: allows explicit memcg and NUMA node
 selection
Message-ID: <20231130203522.GC543908@cmpxchg.org>
References: <20231130194023.4102148-1-nphamcs@gmail.com>
 <20231130194023.4102148-2-nphamcs@gmail.com>
 <ZWjpNr3ZzvU4TDC8@casper.infradead.org>
 <CAKEwX=MV-F50i_=sZ0unfbgjrdxSTio00c4xTM19113BAN3-wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=MV-F50i_=sZ0unfbgjrdxSTio00c4xTM19113BAN3-wA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 12:07:41PM -0800, Nhat Pham wrote:
> On Thu, Nov 30, 2023 at 11:57 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Nov 30, 2023 at 11:40:18AM -0800, Nhat Pham wrote:
> > > This patch changes list_lru interface so that the caller must explicitly
> > > specify numa node and memcg when adding and removing objects. The old
> > > list_lru_add() and list_lru_del() are renamed to list_lru_add_obj() and
> > > list_lru_del_obj(), respectively.
> >
> > Wouldn't it be better to add list_lru_add_memcg() and
> > list_lru_del_memcg() and have:
> >
> > +bool list_lru_del(struct list_lru *lru, struct list_head *item)
> > +{
> > +       int nid = page_to_nid(virt_to_page(item));
> > +       struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
> > +               mem_cgroup_from_slab_obj(item) : NULL;
> > +
> > +       return list_lru_del_memcg(lru, item, nid, memcg);
> > +}
> >
> > Seems like _most_ callers will want the original versions and only
> > a few will want the explicit memcg/nid versions.  No?
> >
> 
> I actually did something along that line in earlier iterations of this
> patch series (albeit with poorer naming - __list_lru_add() instead of
> list_lru_add_memcg()). The consensus after some back and forth was
> that the original list_lru_add() was not a very good design (the
> better one was this new version that allows for explicit numa/memcg
> selection). So I agreed to fix it everywhere as a prep patch.
> 
> I don't have strong opinions here to be completely honest, but I do
> think this new API makes more sense (at the cost of quite a bit of
> elbow grease to fix every callsites and extra reviewing).

Maybe I can shed some light since I was pushing for doing it this way.

The quiet assumption that 'struct list_head *item' is (embedded in) a
slab object that is also charged to a cgroup is a bit much, given that
nothing in the name or documentation of the function points to that.

It bit us in the THP shrinker where that list head is embedded in a
tailpage (virt_to_page(page) is fun to debug). And it caused some
confusion in this case as well, where the zswap entry is a slab object
but not charged (the entry descriptor is not attractive for cgroup
accounting, only the backing memory it points to.)

Yes, for most users - at least right now - the current assumption is
accurate. The thinking was just that if we do have to differentiate
callers now anyway, we might as well make the interface a bit more
self-documenting and harder to misuse going forward, even if it's a
bit more churn now.


