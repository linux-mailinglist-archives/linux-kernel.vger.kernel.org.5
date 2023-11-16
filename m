Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BADE7EDDAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbjKPJfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKPJfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:35:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6793C1AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700127339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oT3FKeKOYFdxsNmBZiHx2Wl1tcSnqa0OXvMm3OIn0us=;
        b=Mh/Dh1ExJX2JAmTc5ugAaG0EFQf3Ld9m/TpiTkOG9FHVPmKEv5VffoDk2FU/4/jzkWnmZX
        nMd6oMrhEvhQo9q51xyxBhMa/s1E3cAZjuLdlcm3iGuMTpPB+L+GWLG3CsNOKSV7oitWVS
        P1+xLb4Dx/qzBMD8ZTHI8qPX0W66yAA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-UTKNFgOMMlq5-jI4bGryqQ-1; Thu,
 16 Nov 2023 04:35:35 -0500
X-MC-Unique: UTKNFgOMMlq5-jI4bGryqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55A863811F38;
        Thu, 16 Nov 2023 09:35:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id 452A82166B27;
        Thu, 16 Nov 2023 09:35:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 16 Nov 2023 10:34:31 +0100 (CET)
Date:   Thu, 16 Nov 2023 10:34:28 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Yonghong Song <yonghong.song@linux.dev>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 1/3] bpf: task_group_seq_get_next: use __next_thread()
 rather than next_thread()
Message-ID: <20231116093428.GA18748@redhat.com>
References: <20231114163234.GA890@redhat.com>
 <34440ea4-3780-45e4-9e7c-1b36b535171b@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34440ea4-3780-45e4-9e7c-1b36b535171b@linux.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15, Yonghong Song wrote:
>
> On 11/14/23 11:32 AM, Oleg Nesterov wrote:
> >@@ -70,15 +70,13 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
> >  		return NULL;
> >  retry:
> >-	task = next_thread(task);
> >+	task = __next_thread(task);
> >+	if (!task)
> >+		return NULL;
> >  	next_tid = __task_pid_nr_ns(task, PIDTYPE_PID, common->ns);
> >-	if (!next_tid || next_tid == common->pid) {
> >-		/* Run out of tasks of a process.  The tasks of a
> >-		 * thread_group are linked as circular linked list.
> >-		 */
> >-		return NULL;
> >-	}
> >+	if (!next_tid)
> >+		goto retry;
>
> Look at the code. Looks like next_tid should never be 0

...

> pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
>                         struct pid_namespace *ns)
> {
>         pid_t nr = 0;
>
>         rcu_read_lock();
>         if (!ns)
>                 ns = task_active_pid_ns(current);
>         nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
                                          ^^^^^^^^^^^^^^^^^^^^^^^^^

Please note that task_pid_ptr(task, type)) can return NULL if this
task has already exited and called detach_pid().

detach_pid() does __change_pid(task, type, NULL), please note the

	*pid_ptr = new; // NULL in this case

assignment in __change_pid().

IOW. The problem is not that ns can change, the problem is that
task->thread_pid (and other pid links) can be NULL, and in this
case pid_nr_ns() returns zero.


This code should be rewritten from the very beginning, it should
not rely on pid_nr. If nothing else common->pid and/or pid_visiting
can be reused. But currently my only concern is next_thread().

> Other than above, the change looks good to me.

Thanks for review!

Oleg.

