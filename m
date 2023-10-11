Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB707C5AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345928AbjJKSBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjJKSBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:01:08 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB5194
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:01:04 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-58530660c1bso54093a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697047264; x=1697652064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+DWGMBxP+X45X3NzNtwuI8J+qvPFiJhuYh3mGuN+4Y=;
        b=NtXkhzo6LO2lFL/WcUETASNsHUREqn0/g5VAmIBc3Th67by7Aqwow9qnRpP12DMhck
         Lgo7PQhBMShJLySxuUI0Q+QnYt5hLCup2bPP/1krjLbWeVS1GP5pV/8LZrsFFVr8aHl6
         M6bv1pEac7nI5wL5myKe6lVHFHa/qABoe1kyGnc6aXkxwG4/v/4uDd82yzBEBAQ0H32d
         xjw2aq79HerVBvpMgjU+o/h4qdQD8+lUCP7clsn95QVavxtE9PmjCXRZ/6mkD0n976uM
         ne3PZniVdhjo0nFlLcYUfjiqxAT+vGtr9gvBbVTS5O3DU8+vIhJdutDXdkVS1Pgh7oml
         +R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697047264; x=1697652064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+DWGMBxP+X45X3NzNtwuI8J+qvPFiJhuYh3mGuN+4Y=;
        b=VAhqO3SKFgY2NBS2ykZBkFMp/dEM7CIZT3Jir9iPqpIgUGmiKTcDV+thPcT/RTTItK
         nfmYI1nNu4ZjnlqrrTTA7gZPoBehaQwjxgtI6fW89Ooot2hngIfqC4TVjTlmv5fXzeBy
         l/m2gIp6DmVzTcXsGKuOMZtdsVz6XTJUEZl6oYj4eE+cT8OIEAkX85m14Ndj0WkSo7TJ
         EC8zPuKyXy71v1xTSvpNfUuFsGCHW3kfyDpyOip08B/LoCvK1tQwFsjS0vVA8mH1vzKw
         0ledZ/E36nherhHAY+Rf1/SoIa8pQYmojneGA1pNDdjro+xDxGeeTyjFMYP8qDxDPoW2
         gAow==
X-Gm-Message-State: AOJu0Yyj5eKJlIIHlSzgjPW6tC9rQsSem/1QCy3HcbVTgqR/SksIQSiq
        ZHpY9Fd4e2pTfHLwS02geIzHOLjSkw4Ysw==
X-Google-Smtp-Source: AGHT+IGkqLhyk3oyzH+Hu7kZ7pieBGNQ3+eycDmqdFOkXR4RRfzAJ7dTAFgFlQdHrc6gbVBzcW98hymL+VJROQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:704d:0:b0:581:8024:fe01 with SMTP id
 a13-20020a63704d000000b005818024fe01mr330395pgn.3.1697047264093; Wed, 11 Oct
 2023 11:01:04 -0700 (PDT)
Date:   Wed, 11 Oct 2023 18:01:01 +0000
In-Reply-To: <20231010000929.450702-3-roman.gushchin@linux.dev>
Mime-Version: 1.0
References: <20231010000929.450702-1-roman.gushchin@linux.dev> <20231010000929.450702-3-roman.gushchin@linux.dev>
Message-ID: <20231011180101.o2ha6awrupojcu6h@google.com>
Subject: Re: [PATCH v2 2/5] mm: kmem: add direct objcg pointer to task_struct
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:09:26PM -0700, Roman Gushchin wrote:
[...]
> +static void mem_cgroup_kmem_attach(struct cgroup_taskset *tset)
> +{
> +	struct task_struct *task;
> +	struct cgroup_subsys_state *css;
> +
> +	cgroup_taskset_for_each(task, css, tset) {
> +		/* atomically set the update bit */
> +		set_bit(0, (unsigned long *)&current->objcg);

task instead of current ??

> +	}
> +}
