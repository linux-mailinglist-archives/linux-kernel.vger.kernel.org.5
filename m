Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB907BF23F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377755AbjJJFfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346623AbjJJFfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE6A92
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 22:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696916056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=of3RE6QBF1Jz2L+QOoIOgtERkMPSFMmd7Q1awSev4MA=;
        b=dqwlpkGwG+4/5UlYBlaSoEZsO5e7GCh/iP/PQ2nGvxCcmV8so74ob+iHZOZ/aCZCtYwXbJ
        o+n+nKVwohD5UrZclcn2aZLX8qUhf+8Gaq2fUcAl2NODtpg+iHsNsUzKDSll08fxoxFEf2
        KQ9QAkcEpZPLRAdUSmf/Z8v4Q4ssf0o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-gKgjwJR2PFeGP5MyItyf7g-1; Tue, 10 Oct 2023 01:34:14 -0400
X-MC-Unique: gKgjwJR2PFeGP5MyItyf7g-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6561b118866so66941296d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 22:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696916053; x=1697520853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=of3RE6QBF1Jz2L+QOoIOgtERkMPSFMmd7Q1awSev4MA=;
        b=igJXSOpwekoXVnBKktUa6/uRkOBzkykadB3Tnu9c+rid2De/5Rv2oRjUO/6gXBTJ8x
         waaI+GbWOEsbnfCM0UEjx2ISrwE0RRB/YHMkGRzFdO9pPmZKClOG+h2c9ms9FG9J1DXE
         xjlVRY9tPgqP04SKV6tshzjZSQP6OwABAuOSvppoRAVDerlxtcOSMjp0+U8L0dVx/bkF
         Dgysbsc4nsRYmQVrfbSDfbWSRxj7hZg8RZDocbaFB8AJ7vLoVhaFHJXU/J5FTSTmeWgB
         lmuM++5VzOwfT44VwFqes5oRue/GotzYJbogWYm2BmHYnbGvx7vMQR/v42hulGMuYc7G
         Uqlw==
X-Gm-Message-State: AOJu0Ywqkc7QtQZHHaqQ38FHnvlwX2fthmfF6k5HHa2cjdisJ78h+ikI
        F1dA06z4cfdzRJIRVkbUKJj2eE8LE6cx/R+gzcgfhqPZuInVO4lrBZy5CNbziZUq7F7iOshj5c4
        C+qSGNRARlRdPGwUGc5iPtwK6
X-Received: by 2002:a05:6214:328b:b0:658:2857:ed6a with SMTP id mu11-20020a056214328b00b006582857ed6amr18640315qvb.43.1696916053786;
        Mon, 09 Oct 2023 22:34:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0WC8L+ycQI+fYRdUbPG5RVHhmq4l5+bGDvYcdBpkAQmLcoaJrY3uknAihXVyU3c9vmCUmxQ==
X-Received: by 2002:a05:6214:328b:b0:658:2857:ed6a with SMTP id mu11-20020a056214328b00b006582857ed6amr18640303qvb.43.1696916053527;
        Mon, 09 Oct 2023 22:34:13 -0700 (PDT)
Received: from localhost.localdomain ([151.29.94.163])
        by smtp.gmail.com with ESMTPSA id j11-20020a0ce00b000000b0065d034d8f39sm4436584qvk.81.2023.10.09.22.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 22:34:13 -0700 (PDT)
Date:   Tue, 10 Oct 2023 07:34:08 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xia Fukun <xiafukun@huawei.com>
Subject: Re: [PATCH] cgroup/cpuset: Change nr_deadline_tasks to an atomic_t
 value
Message-ID: <ZSTiULEnD7SF9n7y@localhost.localdomain>
References: <20231009191515.3262292-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009191515.3262292-1-longman@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/10/23 15:15, Waiman Long wrote:
> The nr_deadline_tasks field in cpuset structure was introduced by
> commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
> in cpusets"). Unlike nr_migrate_dl_tasks which is only modified under
> cpuset_mutex, nr_deadline_tasks can be updated in various contexts
> under different locks. As a result, data races may happen that cause
> incorrect value to be stored in nr_deadline_tasks leading to incorrect

Could you please make an example of such data races?

Thanks!
Juri

