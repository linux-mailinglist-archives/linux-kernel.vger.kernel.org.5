Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890D87E7FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjKJR6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjKJR4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:56:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F28B527F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 00:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699605106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvwm8Zn22AXacglWGsXzntpmbjMrm/qepljzJqi7EKM=;
        b=h/b7EVy8Q1sIGUTs5hk9UZBqx0yt3CBR2AHTKW60NIlmRwiyPAST9CJuPnwBd3zCpO3tGs
        RA6oIHAsCx2xE5SftAhKt32ks03+J2EdsP1GMwBkOln53zVnUM/3qjkqD7/xjQGMoft+if
        /tmK07RCZFsQKLic/Ohda2ZT/AjxHwk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-VAiY79xYMsOHg94TPTDuFA-1; Fri, 10 Nov 2023 03:31:44 -0500
X-MC-Unique: VAiY79xYMsOHg94TPTDuFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB6EB85A58A;
        Fri, 10 Nov 2023 08:31:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5382B25C1;
        Fri, 10 Nov 2023 08:31:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 10 Nov 2023 09:30:41 +0100 (CET)
Date:   Fri, 10 Nov 2023 09:30:37 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Zizhi Wo <wozizhi@huawei.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jlayton@kernel.org, dchinner@redhat.com,
        adobriyan@gmail.com, yang.lee@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yangerkun@huawei.com
Subject: Re: [PATCH next V3] proc: support file->f_pos checking in mem_lseek
Message-ID: <20231110083037.GA3381@redhat.com>
References: <20231110151928.2667204-1-wozizhi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110151928.2667204-1-wozizhi@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10, Zizhi Wo wrote:
>
> From: WoZ1zh1 <wozizhi@huawei.com>
>
> In mem_lseek, file->f_pos may overflow. And it's not a problem that
> mem_open set file mode with FMODE_UNSIGNED_OFFSET(memory_lseek). However,
> another file use mem_lseek do lseek can have not FMODE_UNSIGNED_OFFSET
> (kpageflags_proc_ops/proc_pagemap_operations...), so in order to prevent
> file->f_pos updated to an abnormal number, fix it by checking overflow and
> FMODE_UNSIGNED_OFFSET.

I am wondering if we can do something like the patch below instead...

but I agree that the "proc_lseek == mem_lseek" in proc_reg_open()
looks ugly.

Oleg.

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 532dc9d240f7..af7e6b1e17fe 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -496,6 +496,8 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 
 	if (!pde->proc_ops->proc_lseek)
 		file->f_mode &= ~FMODE_LSEEK;
+	else if (pde->proc_ops->proc_lseek == mem_lseek)
+		file->f_mode |= FMODE_UNSIGNED_OFFSET;
 
 	if (pde_is_permanent(pde)) {
 		open = pde->proc_ops->proc_open;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3dd5be96691b..729b28ad1a96 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1748,7 +1748,9 @@ static int pagemap_open(struct inode *inode, struct file *file)
 	mm = proc_mem_open(inode, PTRACE_MODE_READ);
 	if (IS_ERR(mm))
 		return PTR_ERR(mm);
+
 	file->private_data = mm;
+	file->f_mode |= FMODE_UNSIGNED_OFFSET;
 	return 0;
 }
 

