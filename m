Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CC5797F94
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbjIHASN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 20:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbjIHASM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:18:12 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06481BD3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 17:18:07 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-794cd987ea6so58411739f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 17:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694132287; x=1694737087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kwqmgF23vQcnqhZph/r7b6EAuDvU+RRr94jnoyag2zI=;
        b=k4ldOB/WV2Id/FMn4xqDqDA5iWuBuakDzCDiwsDF5nqDBOUAQ8uJZN8Tz1OBZJdl56
         RdXUeyfXrQYpiHVVc2ljR0AhD/OuIu1IMeBMBu/4ftgQr9lYAduL2FlbvvZU5/ef4sTX
         NXuZ6xkRrnHynR+vqFPgd/d0b3DLAxBoVsb1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694132287; x=1694737087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwqmgF23vQcnqhZph/r7b6EAuDvU+RRr94jnoyag2zI=;
        b=qJ4ToMQ6KdMuChkpS4JZLMqiyz7zLwqsDv73DyNSGlvQSgzrOPO/emE71hJ85/T1fG
         r/Nx1LOmEqfL8Jntn+XX0ToviAhIObIMbyXfYfnyAqfgJOGqCXXlv18POZ7pkvDswtVT
         6ZMh8LigOrrgShNLHHUyewjyFpTz1pOiSsa9HFNT/wrHhW7HOwJr9z4gNR9lqiPXtOUb
         /CDEg/2a2+A1lHhMlNjZARTSyuvERlFuIMT8qbXiHRTWEbt7fyWrRMt15VrAhH8Ax49L
         Gjx1WR3epB/ZalnChO1j7i3g1I4UCiTLfl+WC/PNRHEp6XCM0UJJkfJgHmrfa35xFNR7
         UPpg==
X-Gm-Message-State: AOJu0YzD9N+oXS2iO87yb6yB3APN9mvqokZgcENaEhhUWDkM14hPYm3+
        ccojemzfjTEFdkJIGjqdyYW5sw==
X-Google-Smtp-Source: AGHT+IH0N9Wu/V5lr5E20iI/yXizux3YQc4t0WJJ5poVDN3LCLNNDsPqZDNXh/R/umIjfpjCExXvYQ==
X-Received: by 2002:a6b:610a:0:b0:786:25a3:ef30 with SMTP id v10-20020a6b610a000000b0078625a3ef30mr1337280iob.7.1694132287217;
        Thu, 07 Sep 2023 17:18:07 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id u1-20020a02c041000000b0042b1061c6a8sm143948jam.84.2023.09.07.17.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 17:18:06 -0700 (PDT)
Date:   Fri, 8 Sep 2023 00:18:05 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        rcu@vger.kernel.org, Zqiang <qiang.zhang1211@gmail.com>,
        stable@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/2] mm/vmalloc: Add a safer version of find_vm_area()
 for debug
Message-ID: <20230908001805.GA4088026@google.com>
References: <20230904180806.1002832-1-joel@joelfernandes.org>
 <571d4a4a-0674-4c84-b714-8e7582699e30@lucifer.local>
 <20230905114709.GA3881391@google.com>
 <CAA5enKbvrvTx=d6MgLZjupnsEuoCnRN8e9p+ffnJV1rJS+HkXA@mail.gmail.com>
 <20230906224608.GB1646335@google.com>
 <499537a7-3380-4355-ae34-df7f5c0f41bd@lucifer.local>
 <ZPmWnGG9b0JXsR54@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPmWnGG9b0JXsR54@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 11:23:40AM +0200, Uladzislau Rezki wrote:
> On Thu, Sep 07, 2023 at 08:11:48AM +0100, Lorenzo Stoakes wrote:
[..]
> > Anyway, so TL;DR:-
> > 
> > 1. As we both agree, add a comment to explain why you need the spin trylock.
> > (there are no further steps :P)
> > 
> > And I don't believe this actually needs any further changes after this
> > discussion*, so if you fancy doing a follow up to that effect that will
> > suffice for me thanks!

Thanks.

> For PREEMPT_RT kernels we are not allowed to use "vmap parts" in non
> slepable context, this is just reality, because we use a sleep type of
> spinlock.
> 
> I am not sure how urgent we need this fix. But to me it looks like
> debuging and corner case. Probably i am wrong and miss something.
> But if it is correct, i would just bailout for RT kernel and rework
> later in a more proper way. For example implement a safe way of RCU
> scan but this is also another story.

Bailing out for RT kernel is insufficient, as we need the trylock() to avoid
self-deadlock as well for !PREEMPT_RT. Plus IIRC in the past there was a
opposition to special-casing PREEMPT_RT in code as well. Admittedly those
PREEMPT_RT cases were related to detecting preempt-disabled than a lock-held
section though.

We could optionally do a trylock() loop + bail out after certain number of
tries as well but that would compilicate the code a bit more and I am not
sure if it is worth it. Still if you guys feel strongly about doing something
like that, let me know and I can give it a try :).

thanks,

 - Joel

