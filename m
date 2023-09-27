Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F239B7B0D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjI0Uv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjI0Uv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:51:57 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C67911F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:51:55 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7741c2fae49so693906685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695847914; x=1696452714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kRCNzMNNybq7cAu+oy1LC+Etj9MlXZAFVZAiufmH92A=;
        b=Xlzu/GFVefzrGUDyHTZji5baHV0GPkfaleH5J16F3/I2qPimOF9bCqysC4oPQOqmqk
         d90M4cIdy2to8geX49BJG/UFB6fvwo2au42wmm15fzD/kMRt2AaerwezpLQM6G57DC/z
         BWzxzwHWA/2GUFlJRwZV5nYC1zCQyWmUxvqsQdW4maOFS3AufHLob4dIG4yiHykOIJaX
         5VQv8GXsrh1KGsXZ5V1gSfjn+525nMdqTUoY0XcT8OLC7rO4y6h76zhxLuKpqTNw9vv2
         oEwO0KS/RzFbJbeHSMf+ZqkRyNgOiMAg5TcuXLcp27cndRk11sPoeJoMvu3sv3TQhKWb
         SKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695847914; x=1696452714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRCNzMNNybq7cAu+oy1LC+Etj9MlXZAFVZAiufmH92A=;
        b=FAHUmW5o70lgSDLyCNc/wLVpAikGxlj5XsxsSIyeP5YPgFPYAvnIcHLOmna/gbWtSg
         aU9Q85583OYxfll8NTm56V5uwoR1RqeDDe69tUN9Y2EEPjHyUMQ8Qzb624N4+xiw5Y0r
         nJNdXD2pM/hk5NOvSbjknRAsNcSkbiuP0ZGv+Tmn1dGUVgfcBCA6pUsB6KvOZC73Hg5r
         unpieLirPLzAeF2JP3HvJ4WXPqv+CdHRuiTyW+yWF6GuL/Siq3GacVK45HxPEJWlBCZz
         +6XNowPEoDEwISU3Ns2kRNa7PkGEzgiSdVsYbDVIwJSC4dtvVCWrm84H4ZBqr/iUlFRx
         9CiA==
X-Gm-Message-State: AOJu0YygBJb0H4NKJ8evP6a1pK91FOgfYaPojiNnhEzpJrhOyxI1G8kB
        HhaFBKuSYIwSEngzwWnGPxmRGg==
X-Google-Smtp-Source: AGHT+IEsDnnRUIaHnSP/hHJDWWLMNozyqerJ1lkvVvG4CfdgK9DeET5BnAp5Nyc0BU67X2rrjVz1vQ==
X-Received: by 2002:ac8:4e81:0:b0:403:ac95:c6a9 with SMTP id 1-20020ac84e81000000b00403ac95c6a9mr3566477qtp.30.1695847914504;
        Wed, 27 Sep 2023 13:51:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ba06])
        by smtp.gmail.com with ESMTPSA id w19-20020ac86b13000000b00417f330026bsm5001070qts.49.2023.09.27.13.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 13:51:54 -0700 (PDT)
Date:   Wed, 27 Sep 2023 16:51:53 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Chris Li <chrisl@kernel.org>
Subject: Re: [PATCH v2 1/2] zswap: make shrinking memcg-aware
Message-ID: <20230927205153.GB399644@cmpxchg.org>
References: <20230919171447.2712746-1-nphamcs@gmail.com>
 <20230919171447.2712746-2-nphamcs@gmail.com>
 <CAJD7tkZqm9ZsAL0triwJPLYuN02jMMS-5Y8DE7TuDJVnOCm_7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZqm9ZsAL0triwJPLYuN02jMMS-5Y8DE7TuDJVnOCm_7Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:17:04PM -0700, Yosry Ahmed wrote:
> On Tue, Sep 19, 2023 at 10:14 AM Nhat Pham <nphamcs@gmail.com> wrote:
> > +                       is_empty = false;
> > +       }
> > +       zswap_pool_put(pool);
> > +
> > +       if (is_empty)
> > +               return -EINVAL;
> > +       if (shrunk)
> > +               return 0;
> > +       return -EAGAIN;
> >  }
> >
> >  static void shrink_worker(struct work_struct *w)
> >  {
> >         struct zswap_pool *pool = container_of(w, typeof(*pool),
> >                                                 shrink_work);
> > -       int ret, failures = 0;
> > +       int ret, failures = 0, memcg_selection_failures = 0;
> >
> > +       /* global reclaim will select cgroup in a round-robin fashion. */
> >         do {
> > -               ret = zswap_reclaim_entry(pool);
> > +               /* previous next_shrink has become a zombie - restart from the top */
> 
> Do we skip zombies because all zswap entries are reparented with the objcg?
> 
> If yes, why do we restart from the top instead of just skipping them?
> memcgs after a zombie will not be reachable now IIUC.
> 
> Also, why explicitly check for zombies instead of having
> shrink_memcg() just skip memcgs with no zswap entries? The logic is
> slightly complicated.

I think this might actually be a leftover from the initial plan to do
partial walks without holding on to a reference to the last scanned
css. Similar to mem_cgroup_iter() does with the reclaim cookie - if a
dead cgroup is encountered and we lose the tree position, restart.

But now the code actually holds a reference, so I agree the zombie
thing should just be removed.
