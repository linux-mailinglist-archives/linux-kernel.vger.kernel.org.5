Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829707FFBC5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376507AbjK3Trn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjK3Trl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:47:41 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D46D5C;
        Thu, 30 Nov 2023 11:47:47 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77a453eb01cso68724685a.0;
        Thu, 30 Nov 2023 11:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701373666; x=1701978466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lv+GmmtaQLarUwDGJAav6sGuLpEislLWofysxmwJakI=;
        b=ndownpIx4Bi/oIcTUQji/cOPO/xK0Hp0jTBFXcwdJfPiZ81i5Oh9vPxF3LT66ZcVa9
         /8Ba9wluIjQdjygIK4RqmzA6MiqJ0r/gnpAJTH0DF4mav2QeNq4Loxvc0uELESfDRQxu
         ZqXOWQmf8xFew/dmir/g7SC87GrHYvYRhRHmwjLavC+TQt+f7rB2zXzMd/5LI8egf/vh
         5WOZ+8Moi5ULva0nTdAR8A0bvf1S4uDyQW5YkDcu1jwGMutextMsHVO/RROnapT7ketd
         x0ur6uU8uuXQsAY+Kpk2XGTVBbgADE0GxCkPQ+7Pc1P+HzdAPx1D1qx0f6bfgyF3KZ89
         giXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373666; x=1701978466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lv+GmmtaQLarUwDGJAav6sGuLpEislLWofysxmwJakI=;
        b=psuuRtfdMx2fztr9lthL+BCetCtkXJf2Jo2AQD9K5Fb+O5gtoc9bgqR4eNAHarmfm7
         2bm65eqDdUt3jZQWbGUfLUxcqDGqiiZ5BVogpr8H+wvDjFX8lOb1xUng2Mh8+/AkBwKw
         TJuHDhrTK4U4/w0s2FH92qAUDkCsVIDug+5KYcG/dcf5XZJLWZjgYieu+dkAeP6epuBW
         3XegvSUtYFGYY71LKLRoktQb8zunbtC1EJas4kRsc2LTEANevQhLoNZif70rZyVhwFzk
         AgizGAXibNmDZlkRFtac11KmTCQWwGorBGRoq4bANH0Uln9f10LJWqfiEziR0vq0VIQZ
         Qokg==
X-Gm-Message-State: AOJu0YwJpjnRESQPgVLQBS92/OHdGSxlUOOI2EG4z5jc4PI7nq0KWHpS
        Pnovo+lxxMgnar7T7oFvZqaI+vSkmwrwxA==
X-Google-Smtp-Source: AGHT+IHr7jKju+q7fcsHGej8mnpGAMae91Dq5ivS0hsctdM9vBhFv0dY66LqTwqB9o4bWbamQt/blA==
X-Received: by 2002:a05:6214:86:b0:67a:2b0b:c591 with SMTP id n6-20020a056214008600b0067a2b0bc591mr20348209qvr.25.1701373666490;
        Thu, 30 Nov 2023 11:47:46 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::6:43ad])
        by smtp.gmail.com with ESMTPSA id n9-20020ac86749000000b004239ed654fesm773629qtp.51.2023.11.30.11.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:47:46 -0800 (PST)
Date:   Thu, 30 Nov 2023 14:47:43 -0500
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
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
Message-ID: <ZWjm3zRfJhN+dK4p@dschatzberg-fedora-PF3DHTBV>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <ZWiw9cEsDap1Qm5h@tiehlicka>
 <20231130165642.GA386439@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130165642.GA386439@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:56:42AM -0500, Johannes Weiner wrote:
> [...]
> So I wouldn't say it's merely a reclaim hint. It controls a very
> concrete and influential factor in VM decision making. And since the
> global swappiness is long-established ABI, I don't expect its meaning
> to change significantly any time soon.

I want to add to this last point. While swappiness does not have
terribly well-defined semantics - it is the (only?) existing mechanism
to control balance between anon and file reclaim. I'm merely
advocating for the ability to adjust swappiness during proactive
reclaim separately from reactive reclaim. To what degree the behavior
and semantics of swappiness change is a bit orthogonal here.
