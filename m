Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965D9752543
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjGMOe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjGMOe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:34:58 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F692738;
        Thu, 13 Jul 2023 07:34:50 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4R1xvp0ry7z9ss7;
        Thu, 13 Jul 2023 16:34:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1689258886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOgLl0t5X3JmCAjENFRIGMn7YQO04jybNACbXkaCXBI=;
        b=ZX0FrhbyjxOcpR/ogupcfZZez3Csj5uMZjBQwaoPVVOXSnOYLNd/bntd4dRoGklJZEU5kK
        PW8vmvLTIt1z7I8aSLzFqj5jLJOXEpS+zaUGhhU3T2NCUEQDn4vhuubgwN1BWXzL5aIM0E
        8Qf2Rb6z8j+i/li/B+UrBWinLdMwdjE530baaub1LgxaQAFSwdBvxB1IQcWdukJyB7vyvT
        D1W6RYN2Uj1F2gAsa6XfYVlAP9CUdUVsHKohEA59w0bZwLVTpC8FuBOgtebO1xH5ld8RfV
        ABy/DwAHv54WUzp5auRVPzPzFZTmdq+7hjUauXLk3WzPfN4mRNDUn18j9fu1hA==
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>
Cc:     linux-mm@kvack.org, Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] memfd: remove racheting feature from vm.memfd_noexec
Date:   Fri, 14 Jul 2023 00:33:47 +1000
Message-ID: <20230713143406.14342-3-cyphar@cyphar.com>
In-Reply-To: <20230713143406.14342-1-cyphar@cyphar.com>
References: <20230713143406.14342-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4R1xvp0ry7z9ss7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sysctl has the very unusal behaviour of not allowing any user (even
CAP_SYS_ADMIN) to reduce the restriction setting, meaning that if you
were to set this sysctl to a more restrictive option in the host pidns
you would need to reboot your machine in order to reset it.

The justification given in [1] is that this is a security feature and
thus it should not be possible to disable. Aside from the fact that we
have plenty of security-related sysctls that can be disabled after being
enabled (fs.protected_symlinks for instance), the protection provided by
the sysctl is to stop users from being able to create a binary and then
execute it. A user with CAP_SYS_ADMIN can trivially do this without
memfd_create(2):

  % cat mount-memfd.c
  #include <fcntl.h>
  #include <string.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <unistd.h>
  #include <linux/mount.h>

  #define SHELLCODE "#!/bin/echo this file was executed from this totally private tmpfs:"

  int main(void)
  {
  	int fsfd = fsopen("tmpfs", FSOPEN_CLOEXEC);
  	assert(fsfd >= 0);
  	assert(!fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 2));

  	int dfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
  	assert(dfd >= 0);

  	int execfd = openat(dfd, "exe", O_CREAT | O_RDWR | O_CLOEXEC, 0782);
  	assert(execfd >= 0);
  	assert(write(execfd, SHELLCODE, strlen(SHELLCODE)) == strlen(SHELLCODE));
  	assert(!close(execfd));

  	char *execpath = NULL;
  	char *argv[] = { "bad-exe", NULL }, *envp[] = { NULL };
  	execfd = openat(dfd, "exe", O_PATH | O_CLOEXEC);
  	assert(execfd >= 0);
  	assert(asprintf(&execpath, "/proc/self/fd/%d", execfd) > 0);
  	assert(!execve(execpath, argv, envp));
  }
  % ./mount-memfd
  this file was executed from this totally private tmpfs: /proc/self/fd/5
  %

Given that it is possible for CAP_SYS_ADMIN users to create executable
binaries without memfd_create(2) and without touching the host
filesystem (not to mention the many other things a CAP_SYS_ADMIN process
would be able to do that would be equivalent or worse), it seems strange
to cause a fair amount of headache to admins when there doesn't appear
to be an actual security benefit to blocking this.

It should be noted that with this change, programs that can do an
unprivileged unshare(CLONE_NEWUSER) would be able to create an
executable memfd even if their current pidns didn't allow it. However,
the same sample program above can also be used in this scenario, meaning
that even with this consideration, blocking CAP_SYS_ADMIN makes little
sense:

  % unshare -rm ./mount-memfd
  this file was executed from this totally private tmpfs: /proc/self/fd/5

This simply further reinforces that locked-down environments need to
disallow CLONE_NEWUSER for unprivileged users (as is already the case in
most container environments).

[1]: https://lore.kernel.org/all/CABi2SkWnAgHK1i6iqSqPMYuNEhtHBkO8jUuCvmG3RmUB5TKHJw@mail.gmail.com/

Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: stable@vger.kernel.org # v6.3+
Fixes: 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 kernel/pid_sysctl.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
index b26e027fc9cd..8a22bc29ebb4 100644
--- a/kernel/pid_sysctl.h
+++ b/kernel/pid_sysctl.h
@@ -24,13 +24,6 @@ static int pid_mfd_noexec_dointvec_minmax(struct ctl_table *table,
 	if (ns != &init_pid_ns)
 		table_copy.data = &ns->memfd_noexec_scope;
 
-	/*
-	 * set minimum to current value, the effect is only bigger
-	 * value is accepted.
-	 */
-	if (*(int *)table_copy.data > *(int *)table_copy.extra1)
-		table_copy.extra1 = table_copy.data;
-
 	return proc_dointvec_minmax(&table_copy, write, buf, lenp, ppos);
 }
 
-- 
2.41.0

