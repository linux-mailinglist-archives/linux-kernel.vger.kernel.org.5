Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C62784051
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbjHVMHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbjHVMHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E185B93
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692705996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rPF8JSm19Cq9ksmWlhIY7DVRMliMR17aW+7Sp8f/dzE=;
        b=a6C1eETYBFMxPv8N+bGwl0MGYRmYW7U4TR0SWkxnP6hMU+JU16WDC8wvQ6xhbEP3p3kFKC
        IbKwjbEMDaZpqjFA/z7XkW5nifDj6h5Cmvn3zxyOJhAFsBGWRdzAjD7VKY/CbaO73yzEaC
        85gIqRUb6Gq7U6uRLl3pfFksuD38Vi4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-6-V0eKxgMWay5v_zX-ymFg-1; Tue, 22 Aug 2023 08:06:32 -0400
X-MC-Unique: 6-V0eKxgMWay5v_zX-ymFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEEE3185A78B;
        Tue, 22 Aug 2023 12:06:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.88])
        by smtp.corp.redhat.com (Postfix) with SMTP id E9CA364687;
        Tue, 22 Aug 2023 12:06:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 22 Aug 2023 14:05:45 +0200 (CEST)
Date:   Tue, 22 Aug 2023 14:05:43 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Yonghong Song <yonghong.song@linux.dev>
Cc:     Yonghong Song <yhs@fb.com>, Kui-Feng Lee <kuifeng@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: task_group_seq_get_next: cleanup the usage of
 get/put_task_struct
Message-ID: <20230822120542.GA535@redhat.com>
References: <20230821150909.GA2431@redhat.com>
 <20230821200311.GA22497@redhat.com>
 <88ba3052-9e09-af0d-347e-2a8e8b043617@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ba3052-9e09-af0d-347e-2a8e8b043617@linux.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21, Yonghong Song wrote:
>
>
> On 8/21/23 1:03 PM, Oleg Nesterov wrote:
> >get_pid_task() makes no sense, the code does put_task_struct() soon after.
> >Use find_task_by_pid_ns() instead of find_pid_ns + get_pid_task and kill
> >kill put_task_struct(), this allows to do get_task_struct() only once
>
> remove the duplicated 'kill' in the above.

Done,

> LGTM.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Thanks, I'll send V2 with your ack included in a minute.

Oleg.

