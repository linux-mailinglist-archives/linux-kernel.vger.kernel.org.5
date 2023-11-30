Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708CC7FFB82
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376531AbjK3Tjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376470AbjK3Tjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:39:53 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FFDD5C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:39:58 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77d645c0e06so66523885a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701373198; x=1701977998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kWhHBtnSLbzDgabGaZdMiHsx1XbL7QU05xk19LHaQ6U=;
        b=WNjVE1Y3/9xHKbrGPdiUpJMEHJvhooqIewU+40DWXhbwoJlNTIIT+m2sP5V39vLYyx
         +CaayDnMIsuLh2XWc1RroIhgpC2WJTaEzlAvZqmTKbjng5WojXCIJh8EN7lRhNcBpNWY
         mq5Etk82VDtqM6Dhw3MkA9PlESxNSNGdkYX17nlN+ukWwQ1gHZ4fNICLtgQ0g5xIJg6x
         nHaWmZ0zxS6cqeABJjOhf7i4C1sgKjdK2Na2lML25ENa/uH1bJedY11bNB103zHdoq+D
         lAGJ3VYgHCdb4ulZtQZRJBXVMto8q088LoQ7KgltTkVpJyrBEEyWJW4Oc9W2GTn+ecGL
         +trA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373198; x=1701977998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWhHBtnSLbzDgabGaZdMiHsx1XbL7QU05xk19LHaQ6U=;
        b=m63bq9TMCTEtWTx+mAuvBKeLfkmuBKkzoSHzgE1MutnfFUn3HeV0oTUN3kZKQrr+zW
         /Kon+nhhvtZlqEhshu4I8G6dSoFueT43bJf7X0gcM/pguqaRo8j0aOE6pZpPLqLxDDgt
         xMOG+9o4nJ16klkOmOHofjf4YISWMti3/EtIUubbnROdNNmTkTBfmcmrEO6H8eLSHrpT
         0ntx/PCNu6oFrZaebbW2z5eAZ7jRY56tgXjH1tGXkqTrW6oCpJV2irqv2ZdxEntTvAXr
         H/iMlzynJ4TUVhAZcWfXsibmS52bRRZRV8WtX4sS1NLZlxPzIUxyaORVXFB5PoZvh4L9
         KPJA==
X-Gm-Message-State: AOJu0Yz0CtaUUVUxYHXofs6OyCZU+gXL8UHzFKhTQUVASeqwNQ849BuQ
        1Qwkf4+56LiEdFTC13VwPDPH7Q==
X-Google-Smtp-Source: AGHT+IEFiJ7HUmH7N0Bzbwakio/WFmv3HQJLHQA0LHzQtGakhez6PA62028PhdqZ/7D8Vx5vBeBWnA==
X-Received: by 2002:a05:620a:40ca:b0:77d:8515:a5af with SMTP id g10-20020a05620a40ca00b0077d8515a5afmr22851289qko.31.1701373197785;
        Thu, 30 Nov 2023 11:39:57 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id vy13-20020a05620a490d00b0077da601f06csm775056qkn.10.2023.11.30.11.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:39:57 -0800 (PST)
Date:   Thu, 30 Nov 2023 14:39:56 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
Message-ID: <20231130193956.GA543908@cmpxchg.org>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <20231130184424.7sbez2ukaylerhy6@google.com>
 <ZWjabcWQm/GUoGTf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWjabcWQm/GUoGTf@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 06:54:37PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 30, 2023 at 06:44:24PM +0000, Shakeel Butt wrote:
> > On Thu, Nov 30, 2023 at 07:36:53AM -0800, Dan Schatzberg wrote:
> > > * Swapout should be limited to manage SSD write endurance. In near-OOM
> > 
> > Is this about swapout to SSD only?
> 
> If you're using spinning rust with its limit of, what, 200 seeks per
> second, I'd suggest that swapout should also be limited but for
> different reasons.  We can set you up with a laptop with insufficient
> RAM and a 5400rpm drive if you'd like to be convinced ...

^_^

Yeah, we don't enable disk swap on the hard drive hosts that are
left. This aspect is only about write endurance management on SSD
during proactive reclaim.
