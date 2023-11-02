Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2AC7DF62C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347444AbjKBPT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjKBPTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:19:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E4C136
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698938314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=98SZInoPVFDJdWu/s+LiLaIWnt7YESDa1OzrnjS0dgk=;
        b=VdQnQJ0XL1rvVZGw8sjv+OH4xiljEXpGuyeFMjwz3D3aVU5psh+6YsfomxQ52iCmntB/uF
        sHe3hbYxHICxA0yFnQkQxkp3qHXoMucNRsV9M1ssywkQq78Zu9eOiSgq3kGqhq8+2pzIFu
        ui0JxN4Ce8gPNmwBkW9A071mGho+OCs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-yNCxaXo9MpuP-BF09pLnQQ-1; Thu,
 02 Nov 2023 11:18:30 -0400
X-MC-Unique: yNCxaXo9MpuP-BF09pLnQQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CC253816B45;
        Thu,  2 Nov 2023 15:18:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.103])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7DACA492BE0;
        Thu,  2 Nov 2023 15:18:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  2 Nov 2023 16:17:27 +0100 (CET)
Date:   Thu, 2 Nov 2023 16:17:24 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 2/2] ptrace: Convert ptrace_attach() to use lock guards
Message-ID: <20231102151723.GB9680@redhat.com>
References: <20231102104429.025835330@infradead.org>
 <20231102110706.568467727@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102110706.568467727@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02, Peter Zijlstra wrote:
>
> Created as testing for the conditional guard infrastructure.

This patch scares me ;) I need to get used to guard/etc.
But looks correct.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>






> +			/* SEIZE doesn't trap tracee on attach */
> +			if (!seize)
> +				send_sig_info(SIGSTOP, SEND_SIG_PRIV, task);

This is offtopic, but with or without this patch it is a bit
ugly to drop ->siglock and take it again right after that.
We can do (later) a minor cleanup on top of this change.


--- x/kernel/ptrace.c	2023-11-02 16:03:37.646838530 +0100
+++ x/kernel/ptrace.c	2023-11-02 16:05:52.171052506 +0100
@@ -386,10 +386,14 @@
 	return 0;
 }
 
-static inline void ptrace_set_stopped(struct task_struct *task)
+static inline void ptrace_set_stopped(struct task_struct *task, bool seize)
 {
 	guard(spinlock)(&task->sighand->siglock);
 
+	/* SEIZE doesn't trap tracee on attach */
+	if (!seize)
+		send_signal_locked(SIGSTOP, SEND_SIG_PRIV, task, PIDTYPE_PID);
+
 	/*
 	 * If the task is already STOPPED, set JOBCTL_TRAP_STOP and
 	 * TRAPPING, and kick it so that it transits to TRACED.  TRAPPING
@@ -470,11 +474,6 @@
 			task->ptrace = flags;
 
 			ptrace_link(task, current);
-
-			/* SEIZE doesn't trap tracee on attach */
-			if (!seize)
-				send_sig_info(SIGSTOP, SEND_SIG_PRIV, task);
-
 			ptrace_set_stopped(task);
 		}
 	}

