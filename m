Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBE57E9243
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjKLTbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKLTbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:31:12 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B6F1BFF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:31:09 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc28719cb0so4188375ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699817468; x=1700422268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzFJuUGfBUEtLSbesGkaOvhbrhz4J+HNV0n1NIbu48Q=;
        b=Rq0WZjq/qVer/rTupVtbfNJ/ktglLwU4D9bDL2aFr87hpDqBrrWfLdMhmUrw6Pugr5
         NTmoyFkPQi4ILqKuYEh046JEx9wcrsl1AO434ZkxMHUynqF5tc8tucgyuOkK2f35Iybc
         SGY23ubmGu/SpaC1bneCOGewV9drG4KgBtpqoeVPrqy7ptkDFCJAaEXjan/TWV7Q5lhs
         zqaK0ydMOkZ9aqOjs+5xjru27rH8OZ/YEYMiwXu8yVeiAfPYlJRpEaQxztOexWuFZQBc
         TI/K9uj3MsUrcxApByDAhJcTZKMwM0BzDraQe9gZAp1lD34UpOLvI2QxSHSBTK0mD9Md
         UL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699817468; x=1700422268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzFJuUGfBUEtLSbesGkaOvhbrhz4J+HNV0n1NIbu48Q=;
        b=IOpIVWHrOvi/vwmyE2lfnMTCOtofJySbVJ4EqMreXZbw9UBebDTKKlGOmmQzp2qd6F
         QWWiN7Fg9VkwsGAEeRiTyvi8yt9J1DlFSoDEwqeqGkCkrNy5bMnoZoZMp+HucNuBJcOz
         h0mxhxT/VJkZ8j3cr0JRlhY+Rk3JNBONbQTuN7Fcxp1ZxSHGc/URfMhGj5CeM0yBxkDC
         rMzzcpnhM907SId/FhOIHZcRJsrYE+dSFiRblSaIWF+SYfQ/QV4r0/cvjRDqy8YU52JV
         cwch1ElzoZPTw6lThQYk6/Ddvt+FJmcqLwfSPHs04G5F+eTXHcGyfZl0ffDg0Vn5I1l6
         8hVQ==
X-Gm-Message-State: AOJu0YwdsP1CoSdmceXjPlUqgeqHbeA7BC4lnqBfOlXj+IolfVoE5e3b
        2ZTEqfJwSBWEEZN9zTGXMdQ=
X-Google-Smtp-Source: AGHT+IFulHMIU/Yyc0thfpPh6YGQSJusSRQr9V/spq+JErFJlqd3wqRSJ4GK7+x04tyMrw5ylrvONw==
X-Received: by 2002:a17:902:ecd2:b0:1cc:27fa:1fb7 with SMTP id a18-20020a170902ecd200b001cc27fa1fb7mr6714140plh.5.1699817468534;
        Sun, 12 Nov 2023 11:31:08 -0800 (PST)
Received: from abhinav.. ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001c465bedaccsm2860248pls.83.2023.11.12.11.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 11:31:08 -0800 (PST)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        mst@redhat.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH v4] Fixing directly deferencing a __rcu pointer warning
Date:   Mon, 13 Nov 2023 01:00:55 +0530
Message-Id: <20231112193055.2072382-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <202311031320.c3ebc782-oliver.sang@intel.com>
References: <202311031320.c3ebc782-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the sparse warning with this message 
"dereference of noderef expression" , in this context 
it means about directly dereferencing a pointer tagged 
with __rcu annotation.

Dereferencing the pointers tagged with __rcu directly should
always be avoided according to the docs. There is a rcu helper
function rcu_dereference(...) to use when dereferencing a __rcu
pointer inside rcu read side critical sections. This function
returns the non __rcu tagged pointer which can be dereferenced
just like a normal pointer.

I tested with `lockdep` enabled, with these config options
`CONFIG_PROVE_RCU` and `CONFIG_PROVE_LOCKING` enabled and it 
booted just fine. To confirm if lockdep was really enabled 
I found these paths inside the qemu virtual envirnoment.
/proc/lockdep
/proc/lockdep_chains
/proc/lockdep_stat
/proc/locks
/proc/lock_stats

I tested the above kernel using qemu with this command
qemu-system-x86_64 \
        -m 2G \
        -smp 2 \
        -kernel /home/abhinav/linux_work/linux/arch/x86/boot/bzImage \
        -append "console=ttyS0 root=/dev/sda earlyprintk=serial   net.ifnames=0" \
        -drive file=/home/abhinav/linux_work/boot_images/bullseye.img,format=raw \
        -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
        -net nic,model=e1000 \
        -enable-kvm \
        -nographic \
        -pidfile vm.pid \
        2>&1 | tee vm.log

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---

Link to original patch
 https://lore.kernel.org/all/20231025222811.855336-1-singhabhinav9051571833@gmail.com/

Change from original -> v2 :
 1. removed the null check before dereferencing the dereferenced rcu
    pointer at line 2372.
 2. added rcu_dereference(...) at line 2694

Changes from v2 -> v3
 1. added rcu_dereference(...) at line 2693

Changes from v3 -> v4
 1. added rcu_read_lock() and rcu_read_unlock() before and after
rcu_defereference() function to avoid race condition.

 kernel/fork.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..bb049b611015 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2369,9 +2369,14 @@ __latent_entropy struct task_struct *copy_process(
 
 	retval = -EAGAIN;
 	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
-		if (p->real_cred->user != INIT_USER &&
-		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
+		rcu_read_lock();
+		if (rcu_dereference(p->real_cred)->user != INIT_USER &&
+		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN)) {
+			rcu_read_unlock();
 			goto bad_fork_cleanup_count;
+		} else {
+			rcu_read_unlock();
+		}
 	}
 	current->flags &= ~PF_NPROC_EXCEEDED;
 
@@ -2690,9 +2695,11 @@ __latent_entropy struct task_struct *copy_process(
 			 * tasklist_lock with adding child to the process tree
 			 * for propagate_has_child_subreaper optimization.
 			 */
-			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
-							 p->real_parent->signal->is_child_subreaper;
-			list_add_tail(&p->sibling, &p->real_parent->children);
+			rcu_read_lock();
+			p->signal->has_child_subreaper = rcu_dereference(p->real_parent)->signal->has_child_subreaper ||
+							rcu_dereference(p->real_parent)->signal->is_child_subreaper;
+			list_add_tail(&p->sibling, &rcu_dereference(p->real_parent)->children);
+			rcu_read_unlock();
 			list_add_tail_rcu(&p->tasks, &init_task.tasks);
 			attach_pid(p, PIDTYPE_TGID);
 			attach_pid(p, PIDTYPE_PGID);
-- 
2.39.2

