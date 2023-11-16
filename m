Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594117EDA46
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344822AbjKPDeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKPDeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:34:23 -0500
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AEC8F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:34:17 -0800 (PST)
Message-ID: <95c2b494-ce8a-422b-918e-8ae4853ab9f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700105656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7hfj98r1RUf05ReDEmwIF2LjiRP9glPD+KMKS9nDF6Y=;
        b=DzCdVATezfQ6/FLY6Xis/fjn0jTfNE3hQu4QmbGPYsqE7r/+w2L5JDZOKfJFx5EwtKa2Ts
        1f7IUl/yzPCu8arnh7SYex5MWFoaDV3o/2ea9hkaE6dAD4uly8WEx9p1CK+1fyn1v3LicS
        2UdxZz0IBb3sX0fJRuXCy4t/fY15fu8=
Date:   Wed, 15 Nov 2023 22:34:10 -0500
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] bpf: bpf_iter_task_next: use __next_thread() rather
 than next_thread()
Content-Language: en-GB
To:     Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20231114163237.GA897@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231114163237.GA897@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/14/23 11:32 AM, Oleg Nesterov wrote:
> Lockless use of next_thread() should be avoided, kernel/bpf/task_iter.c
> is the last user and the usage is wrong.
>
> bpf_iter_task_next() can loop forever, "kit->pos == kit->task" can never
> happen if kit->pos execs. Change this code to use __next_thread().
>
> With or without this change the usage of kit->pos/task and next_task()
> doesn't look nice, see the next patch.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

