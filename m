Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2C5788D26
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343941AbjHYQUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343952AbjHYQU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD521991
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692980380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=uiJ7/zCtGwucjs2wTp8G7jQHFGUDEyW7zcPa/oNYiWc=;
        b=WBN0jTeKNfCxXSd9zU7ePEwTPoVSysWZNSNV2p385sjDJcf5t7hyZ5PyAgagoCVuUiDN04
        A0nLbOwVS3CNGLOFRc/HVUy1kd+NheD08PUOlEWRsEkgf18LwUqQ9eKPIOMYItOcVgjjjH
        6s0+Cg7WnCCmx1RiwIVbgk6+3xzrbmM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-tqRQ3ruHMdKCN4LotaAvyQ-1; Fri, 25 Aug 2023 12:19:35 -0400
X-MC-Unique: tqRQ3ruHMdKCN4LotaAvyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22929185A78F;
        Fri, 25 Aug 2023 16:19:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id F24F62166B26;
        Fri, 25 Aug 2023 16:19:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 25 Aug 2023 18:18:47 +0200 (CEST)
Date:   Fri, 25 Aug 2023 18:18:42 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yonghong Song <yhs@fb.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] bpf: task_group_seq_get_next: use __next_thread()
Message-ID: <20230825161842.GA16750@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compile tested, 1-5 need the review from bpf maintainers, quite possibly
I did some silly mistakes. I tried to cleanup this code because I could
not look at it, but it has other problems and imo should be rewritten.

6/6 obviously depends on

	[PATCH 1/2] introduce __next_thread(), fix next_tid() vs exec() race
	https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/

which was not merged yet.

To simplify the review, this is the code after 6/6:

	static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_common *common,
							   u32 *tid,
							   bool skip_if_dup_files)
	{
		struct task_struct *task;
		struct pid *pid;
		u32 next_tid;

		if (!*tid) {
			/* The first time, the iterator calls this function. */
			pid = find_pid_ns(common->pid, common->ns);
			task = get_pid_task(pid, PIDTYPE_TGID);
			if (!task)
				return NULL;

			*tid = common->pid;
			common->pid_visiting = common->pid;

			return task;
		}

		/* If the control returns to user space and comes back to the
		 * kernel again, *tid and common->pid_visiting should be the
		 * same for task_seq_start() to pick up the correct task.
		 */
		if (*tid == common->pid_visiting) {
			pid = find_pid_ns(common->pid_visiting, common->ns);
			task = get_pid_task(pid, PIDTYPE_PID);

			return task;
		}

		task = find_task_by_pid_ns(common->pid_visiting, common->ns);
		if (!task)
			return NULL;

	retry:
		task = __next_thread(task);
		if (!task)
			return NULL;

		next_tid = __task_pid_nr_ns(task, PIDTYPE_PID, common->ns);
		if (!next_tid)
			goto retry;

		if (skip_if_dup_files && task->files == task->group_leader->files)
			goto retry;

		*tid = common->pid_visiting = next_tid;
		get_task_struct(task);
		return task;
	}

Oleg.

