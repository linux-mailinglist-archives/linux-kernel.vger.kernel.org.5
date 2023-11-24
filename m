Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9574E7F856B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjKXVWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXVWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:22:33 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C6219A7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:22:39 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00b01955acso342313566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700860957; x=1701465757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=apBows719Ql6+y2BcpLIbVUnN8kkKRkZuJ5YeukjHu4=;
        b=SH51FT7Ew+d98DyAlBHAA5qXQhUL6YaR5qhhTrR45XMN/ZzDLwzlz2jb94PanQ6S5s
         MYctfLQnjyVSWdSer2cjH8nUQLLWB+Ez4lWt+RygNRFf8zDN+fE/kN3bryaLq0OTz9e4
         p/+NZZhwRcvN3Iivq1MCNJ6OmSKRTL3iulN4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700860957; x=1701465757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apBows719Ql6+y2BcpLIbVUnN8kkKRkZuJ5YeukjHu4=;
        b=v1Wyd93t+wBIlexKMO/JV15u6QsaQtb7rTocP9lhpIT5CYNiIzBdVYnGOHatVUk6gw
         y0Bl/gcLuLIT1+OTt5byKoU6Z2DgTZqNmJqmHStInJaDCzzVwfBTVKY7LO6dQT0dfl2p
         WRwmIa/O3LH5G2mCnIORognY0SvZMoq+qMndsvxo+QZwkthAEdg7+ximegnZ7XMsuoK7
         7s2e/7ESi4QwELYDz+BOvn/YdTji+ItT0vh+bNSWEDF2a4vmDBmS13nm6ag/5tKEL7W1
         bPEd3itPxtRuW0NCguQ4jb/kXZdD6xmGkvNzlKaInYrSRzZ6FWHw8Y6Gue+2/MIUcAzO
         0nRw==
X-Gm-Message-State: AOJu0Yxz+yvfF+QI4Oy2ZqFFMY05KTH4QFQf+HAgY4PJmmiLDmUcZldW
        4glZeGtuBSKVge0+O581XVEvlKd8/p/HFDoHq1/5FxlQ
X-Google-Smtp-Source: AGHT+IHJ12w/jjtzDkN1lr/rUCesQUzo/njod+gfGl0d8ddtKHStuDKpIGT36tluqDrAVXpN4/7PgQ==
X-Received: by 2002:a17:906:5307:b0:a09:589f:8853 with SMTP id h7-20020a170906530700b00a09589f8853mr2316220ejo.66.1700860957498;
        Fri, 24 Nov 2023 13:22:37 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id kg23-20020a17090776f700b00a04431e5a44sm2560631ejc.16.2023.11.24.13.22.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 13:22:37 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-54b1812ae1fso182109a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:22:36 -0800 (PST)
X-Received: by 2002:a50:d715:0:b0:548:564d:959a with SMTP id
 t21-20020a50d715000000b00548564d959amr2756303edi.3.1700860956448; Fri, 24 Nov
 2023 13:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20231124060200.GR38156@ZenIV> <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-2-viro@zeniv.linux.org.uk>
In-Reply-To: <20231124060422.576198-2-viro@zeniv.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Nov 2023 13:22:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGKvjHCtJ6W4pQ0_h_k9fiFQ8V2GpM=BqYnB2X=SJ+XQ@mail.gmail.com>
Message-ID: <CAHk-=whGKvjHCtJ6W4pQ0_h_k9fiFQ8V2GpM=BqYnB2X=SJ+XQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/21] coda_flag_children(): cope with dentries turning negative
To:     Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 at 22:04, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ->d_lock on parent does not stabilize ->d_inode of child.
> We don't do much with that inode in there, but we need
> at least to avoid struct inode getting freed under us...

Gaah. We've gone back and forth on this. Being non-preemptible is
already equivalent to rcu read locking.

From Documentation/RCU/rcu_dereference.rst:

                            With the new consolidated
        RCU flavors, an RCU read-side critical section is entered
        using rcu_read_lock(), anything that disables bottom halves,
        anything that disables interrupts, or anything that disables
        preemption.

so I actually think the coda code is already mostly fine, because that
parent spin_lock may not stabilize d_child per se, but it *does* imply
a RCU read lock.

So I think you should drop the rcu_read_lock/rcu_read_unlock from that patch.

But that

                struct inode *inode = d_inode_rcu(de);

conversion is required to get a stable inode pointer.

So half of this patch is unnecessary.

Adding Paul to the cc just to verify that the docs are up-to-date and
that we're still good here.

Because we've gone back-and-forth on the "spinlocks are an implied RCU
read-side critical section" a couple of times.

                  Linus
