Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97A67EDDC7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjKPJkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjKPJkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:40:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3AD101
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700127599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LLXIUTXD0M2uVOySxASo8TWbR7mxoyT6p6/agsN7zes=;
        b=fSKx9Y9Vpew2O9f6R9sjyayhbjx/P8KzYvizrfQ6RmcWgvc5dSjH1simT+0xsS8eqKg5px
        svqLdWugLwZ3DZbQesuENDa3AIHm9S+FuJHSJTR7VGtBTJP65BwDscG3E9nqFVqyYebPdy
        2+maN+mKVU33ZKwzrnxZKnzQUFkF/U4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426--r7ZKUlaPpu-Zo4m0k70mA-1; Thu,
 16 Nov 2023 04:39:55 -0500
X-MC-Unique: -r7ZKUlaPpu-Zo4m0k70mA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39F783C11C66;
        Thu, 16 Nov 2023 09:39:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5C859492BFD;
        Thu, 16 Nov 2023 09:39:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 16 Nov 2023 10:38:51 +0100 (CET)
Date:   Thu, 16 Nov 2023 10:38:48 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Yonghong Song <yonghong.song@linux.dev>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 3/3] bpf: bpf_iter_task_next: use next_task(kit->task)
 rather than next_task(kit->pos)
Message-ID: <20231116093848.GB18748@redhat.com>
References: <20231114163239.GA903@redhat.com>
 <9dfbc7ce-49cc-4519-88cf-93d6b72e5ff6@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dfbc7ce-49cc-4519-88cf-93d6b72e5ff6@linux.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16, Yonghong Song wrote:
>
> On 11/14/23 11:32 AM, Oleg Nesterov wrote:
> >This looks more clear and simplifies the code. While at it, remove the
> >unnecessary initialization of pos/task at the start of bpf_iter_task_new().
> >
> >Note that we can even kill kit->task, we can just use pos->group_leader,
> >but I don't understand the BUILD_BUG_ON() checks in bpf_iter_task_new().
>
> Let us keep kit->task, which is used in later function
> bpf_iter_task_next(). The patch looks good to me.

Yes, but it can use pos->group_leader instead of kit->task.
But I agree, lets keep kit->task.

> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Thanks!

Oleg.

