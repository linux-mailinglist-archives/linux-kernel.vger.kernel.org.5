Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7307FFBCB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376545AbjK3Tux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjK3Tuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:50:51 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1035D5C;
        Thu, 30 Nov 2023 11:50:57 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-677fba00a49so11248246d6.1;
        Thu, 30 Nov 2023 11:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701373857; x=1701978657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cWW8Aq31tJ4AFADeDZ3NfoI4ZhRoXFCiCERKyyo7JHU=;
        b=XcOFj6sydu0OPBXqGycQGZ+Dj292poIQTlTprORAW1dhkdRV1uOdzo262w5+RK1lJz
         nw66dLgc4FUBNLsfMLIWG4vswROtA06h/7U+lB7bW8A3HfC+X4tOf5kwhzuHXWebcpwc
         In9mBmipAoqBG4/azcTjvqFX/5Dptr7KuTFAhuFUiokEvqyS7VJ9skhtqyFU1+4WyJf3
         a+nbMzCGKe7UNXn/L52m8Z9PeW8zEK9caXL1mG2l1oNTNlGKE2uDcB9nVXqbuRiqD0pF
         WEPsKr/pGy4VZVt/IuKGxUnNFp2AO/1H4ugy27fcVEgf7rEyhCiVQyMf/ijQ4XBs3OfZ
         gVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373857; x=1701978657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWW8Aq31tJ4AFADeDZ3NfoI4ZhRoXFCiCERKyyo7JHU=;
        b=deMFESsoAB8IjKAdhU+QV8+70sXu9kXhK0KKwtwJUJnUvpq4U11zOP6givxnkZ0zn6
         qpO+7DcDFbU8RK/ppLATeY/gwyqZ5HE7oy8azyKV4gd7HEnmbqAra3VimJisEuR7sllB
         BvYySJDs9IN0fx0+goiw739yqiFr4wnrunIyt1Md5OsBGC92ESKL1f4B5fpy3qxmiwjV
         HPHTMeVxzEZxRNtHE/v8oMiyi/jTwO7riXjwZztnKiG2C5RwZAfpMqZyGEx7YjU5lFZ3
         WLBRLDF1xSor84DgDmANkufDk52zwBL4NPC7EYeVqSzBtg05aYnDSXZCZ/sfIa4Kv5cJ
         2a4g==
X-Gm-Message-State: AOJu0YzB58cjtyZA6ALhDvaFMqpYqG3KMQ2CqZ1RMR3JWIxHjtN7qxGO
        Uzscoyhvhg6gWYLVoP/TOL0=
X-Google-Smtp-Source: AGHT+IHgNPVt6A4aptxpmjsABzyQ4w6Nf/RDCpjyLP3UpHU7FSfuppdsfxSo+Ffo5KMRZPHgU5ehSQ==
X-Received: by 2002:a05:6214:1c0b:b0:67a:4546:9895 with SMTP id u11-20020a0562141c0b00b0067a45469895mr25511391qvc.12.1701373856929;
        Thu, 30 Nov 2023 11:50:56 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::6:43ad])
        by smtp.gmail.com with ESMTPSA id e24-20020a0caa58000000b0067a1e5ef6b1sm772545qvb.106.2023.11.30.11.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:50:56 -0800 (PST)
Date:   Thu, 30 Nov 2023 14:50:54 -0500
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
Message-ID: <ZWjnnjX6Cg9ywXK2@dschatzberg-fedora-PF3DHTBV>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <20231130184424.7sbez2ukaylerhy6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130184424.7sbez2ukaylerhy6@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 06:44:24PM +0000, Shakeel Butt wrote:
> [...]
> > * Swapout should be limited to manage SSD write endurance. In near-OOM
> 
> Is this about swapout to SSD only?

Correct

> >   situations we are fine with lots of swap-out to avoid OOMs. As these are
> >   typically rare events, they have relatively little impact on write endurance.
> >   However, proactive reclaim runs continuously and so its impact on SSD write
> >   endurance is more significant. Therefore it is desireable to control swap-out
> >   for proactive reclaim separately from reactive reclaim
> 
> This is understandable but swapout to zswap should be fine, right?
> (Sorry I am not following the discussion on zswap patches from Nhat. Is
> the answer there?)

You're correct here as well - we're not concerned about swapout to
zswap as that does not impact SSD write endurance. This is not related
to Nhat's patches.
