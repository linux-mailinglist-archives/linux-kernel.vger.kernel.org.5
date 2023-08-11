Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE4077881C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjHKHX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjHKHXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:23:25 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07A422683;
        Fri, 11 Aug 2023 00:23:22 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 37B7LwGk004128;
        Fri, 11 Aug 2023 02:21:58 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 37B7Lv6R004127;
        Fri, 11 Aug 2023 02:21:57 -0500
Date:   Fri, 11 Aug 2023 02:21:57 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH 05/13] Add primary TSEM implementation file.
Message-ID: <20230811072157.GA4059@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com> <20230710102319.19716-6-greg@enjellic.com> <d7ea58ea-32a8-26b9-79f2-dd0656e1aa1e@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7ea58ea-32a8-26b9-79f2-dd0656e1aa1e@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 11 Aug 2023 02:21:58 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 02:00:12PM -0700, Casey Schaufler wrote:

Thank you for this review.

> On 7/10/2023 3:23 AM, Dr. Greg wrote:
> > The tsem.c file is the 'master' file in the TSEM implementation.
> > It is responsible for initializing the LSM and providing
> > implementions of the security event hooks implemented by TSEM.
> >
> > In addition to initializing the LSM, the set_ready() function
> > implements a secondary initialization that is used to to indicate
> > that security event modeling can begin.  This is required
> > secondary to the fact that the cryptographic API's do not become
> > ready until after the 'fs' phase of system initialization is
> > complete.
> >
> > This file also handles the implementation of kernel command-line
> > parameters that are used to configure the root security modeling
> > namespace.
> >
> > The 'tsem_mode' parameter, if set to a value of 1, causes modeling
> > to be not conducted for the root security modeling namespace.
> > One use case is to allow development platform to develop security
> > models without the overhead of full platform modeling.
> >
> > The 'tsem_digest' parameter is used to set the cryptographic hash
> > function that is used to generate security state coefficients in
> > the root model.  TSEM can use any cryptographic hash function
> > implemented in the kernel, on a namespace by namespace basis.
> > Subordinate modeling namespaces can select their hash function
> > as part of the namespace creation process but the 'tsem_digest'
> > parameter has to be used to set the function for the root
> > modeling namespace.
> >
> > The hash function used in the root modeling namespace but be
> > compiled into the kernel since the function is used before module
> > loading becomes available.  The TSEM kernel configuration selects
> > the SHA256 function to be included as the default cryptographic
> > modeling function.
> >
> > The 'tsem_cache' variable sets the size of the pre-allocated
> > structures that are used for security event modeling in the root
> > modeling namespace.  This cache is used to support the modeling
> > and export of events that run in atomic context.  The cache size
> > can be set independently for each subordinate security modeling
> > on a namespace by namespace basis.
> >
> > This file also contains the implementation of the tsem_names
> > array that contains the ASCII text names that are assigned to
> > each security event handler.  This name is used as one of the
> > characteristics in the security state points that are generated.
> > This array is also used to provide symbolic names for the export
> > of security event descriptions, either through the TSEM control
> > plane or for export to external trust orchestrators.
> >
> > Signed-off-by: Greg Wettstein <greg@enjellic.com>
> > ---
> >  security/tsem/tsem.c | 1987 ++++++++++++++++++++++++++++++++++++++++++

> Please use kernel doc comments throughout.

At this point we have standardized on using kernel doc comments for
externally visible entities only but we will take a gander at this
file to see if we have missed anything.

> I've made a few minor comments below, but you need to break this up
> somehow for review. Also, having the data definitions elsewhere
> makes review tough.

We will defer to this issue being covered elsewhere.

> >  1 file changed, 1987 insertions(+)
> >  create mode 100644 security/tsem/tsem.c
> >
> > diff --git a/security/tsem/tsem.c b/security/tsem/tsem.c
> > new file mode 100644
> > index 000000000000..8ec630354240
> > --- /dev/null
> > +++ b/security/tsem/tsem.c
> > @@ -0,0 +1,1987 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +/*
> > + * Copyright (C) 2023 Enjellic Systems Development, LLC
> > + * Author: Dr. Greg Wettstein <greg@enjellic.com>
> > + *
> > + * TSEM initialization infrastructure.
> > + */
> > +#define TRAPPED_MSG_LENGTH 128
> > +
> > +#define LOCKED true
> > +#define NOLOCK false
> > +
> > +#include <linux/magic.h>
> > +#include <linux/mman.h>
> > +#include <linux/binfmts.h>
> > +#include <linux/bpf.h>
> > +#include <linux/ipv6.h>
> > +
> > +#include "tsem.h"
> > +
> > +struct lsm_blob_sizes tsem_blob_sizes __ro_after_init = {
> > +	.lbs_task = sizeof(struct tsem_task),

> Do you really want this for the task? It would seem you might want
> to use the cred blob instead.

We would be interested in why you believe the cred blob to be superior.

For those reading along at home the 'struct tsem_task' is as follows:

struct tsem_task {
	u64 tma_for_ns;
	enum tsem_task_trust trust_status;
	u8 task_id[HASH_MAX_DIGESTSIZE];
	u8 task_key[HASH_MAX_DIGESTSIZE];
	struct tsem_context *context;
};

Credentials seem to imply some type of permission.  We look at this
basket of information as relevant to determining how the task will be
modeled and whether or not the task has deviated from its model definition.

> > +	.lbs_inode = sizeof(struct tsem_inode)
> > +};
> > +
> > +enum tsem_action_type tsem_root_actions[TSEM_EVENT_CNT] = {
> > +	TSEM_ACTION_EPERM	/* Undefined. */
> > +};
> > +
> > +static struct tsem_model root_model = {
> > +	.point_lock = __SPIN_LOCK_INITIALIZER(root_model.point_lock),
> > +	.point_list = LIST_HEAD_INIT(root_model.point_list),
> > +	.point_end_mutex = __MUTEX_INITIALIZER(root_model.point_end_mutex),
> > +
> > +	.trajectory_lock = __SPIN_LOCK_INITIALIZER(root_model.trajectory_lock),
> > +	.trajectory_list = LIST_HEAD_INIT(root_model.trajectory_list),
> > +	.trajectory_end_mutex = __MUTEX_INITIALIZER(root_model.trajectory_end_mutex),
> > +
> > +	.forensics_lock = __SPIN_LOCK_INITIALIZER(root_model.forensics_lock),
> > +	.forensics_list = LIST_HEAD_INIT(root_model.forensics_list),
> > +	.forensics_end_mutex = __MUTEX_INITIALIZER(root_model.forensics_end_mutex),
> > +
> > +	.pseudonym_mutex = __MUTEX_INITIALIZER(root_model.pseudonym_mutex),
> > +	.pseudonym_list = LIST_HEAD_INIT(root_model.pseudonym_list)
> > +};
> > +
> > +static struct tsem_context root_context;
> > +
> > +static int tsem_ready __ro_after_init;
> > +
> > +static bool tsem_available __ro_after_init;
> > +
> > +static unsigned int magazine_size __ro_after_init = TSEM_ROOT_MAGAZINE_SIZE;
> > +
> > +static bool no_root_modeling __ro_after_init;
> > +
> > +static char *default_hash_function __ro_after_init;
> > +
> > +static int __init set_magazine_size(char *magazine_value)
> > +{
> > +	if (kstrtouint(magazine_value, 0, &magazine_size))
> > +		pr_warn("tsem: Failed to parse root cache size.\n");
> > +
> > +	if (!magazine_size) {
> > +		pr_warn("tsem: Forcing non-zero cache size.\n");
> > +		magazine_size = TSEM_ROOT_MAGAZINE_SIZE;
> > +	}
> > +
> > +	pr_info("tsem: Setting default root cache size to %u.\n",
> > +		magazine_size);
> > +	return 1;
> > +}
> > +__setup("tsem_cache=", set_magazine_size);
> > +
> > +static int __init set_modeling_mode(char *mode_value)
> > +{
> > +	unsigned long mode = 0;
> > +
> > +	if (kstrtoul(mode_value, 0, &mode)) {
> > +		pr_warn("tsem: Failed to parse modeling mode.\n");
> > +		return 1;
> > +	}
> > +
> > +	if (mode == 1)
> > +		no_root_modeling = true;
> > +	else
> > +		pr_warn("tsem: Unknown mode specified.\n");
> > +	return 1;
> > +}
> > +__setup("tsem_mode=", set_modeling_mode);
> > +
> > +static int __init set_default_hash_function(char *hash_function)
> > +{
> > +
> > +	default_hash_function = hash_function;
> > +	return 1;
> > +}
> > +__setup("tsem_digest=", set_default_hash_function);
> > +
> > +const char * const tsem_names[TSEM_EVENT_CNT] = {
> > +	"undefined",
> > +	"bprm_set_creds",
> > +	"generic_event",
> > +	"task_kill",
> > +	"task_setpgid",
> > +	"task_getpgid",
> > +	"task_getsid",
> > +	"task_setnice",
> > +	"task_setioprio",
> > +	"task_getioprio",
> > +	"task_prlimit",
> > +	"task_setrlimit",
> > +	"task_setscheduler",
> > +	"task_getscheduler",
> > +	"task_prctl",
> > +	"file_open",
> > +	"mmap_file",
> > +	"file_ioctl",
> > +	"file_lock",
> > +	"file_fcntl",
> > +	"file_receive",
> > +	"unix_stream_connect",
> > +	"unix_may_send",
> > +	"socket_create",
> > +	"socket_connect",
> > +	"socket_bind",
> > +	"socket_accept",
> > +	"socket_listen",
> > +	"socket_socketpair",
> > +	"socket_sendmsg",
> > +	"socket_recvmsg",
> > +	"socket_getsockname",
> > +	"socket_getpeername",
> > +	"socket_setsockopt",
> > +	"socket_shutdown",
> > +	"ptrace_traceme",
> > +	"kernel_module_request",
> > +	"kernel_load_data",
> > +	"kernel_read_file",
> > +	"sb_mount",
> > +	"sb_umount",
> > +	"sb_remount",
> > +	"sb_pivotroot",
> > +	"sb_statfs",
> > +	"move_mount",
> > +	"shm_associate",
> > +	"shm_shmctl",
> > +	"shm_shmat",
> > +	"sem_associate",
> > +	"sem_semctl",
> > +	"sem_semop",
> > +	"syslog",
> > +	"settime",
> > +	"quotactl",
> > +	"quota_on",
> > +	"msg_queue_associate",
> > +	"msg_queue_msgctl",
> > +	"msg_queue_msgsnd",
> > +	"msg_queue_msgrcv",
> > +	"ipc_permission",
> > +	"key_alloc",
> > +	"key_permission",
> > +	"netlink_send",
> > +	"inode_create",
> > +	"inode_link",
> > +	"inode_unlink",
> > +	"inode_symlink",
> > +	"inode_mkdir",
> > +	"inode_rmdir",
> > +	"inode_mknod",
> > +	"inode_rename",
> > +	"inode_setattr",
> > +	"inode_getattr",
> > +	"inode_setxattr",
> > +	"inode_getxattr",
> > +	"inode_listxattr",
> > +	"inode_removexattr",
> > +	"inode_killpriv",
> > +	"tun_dev_create",
> > +	"tun_dev_attach_queue",
> > +	"tun_dev_attach",
> > +	"tun_dev_open",
> > +	"bpf",
> > +	"bpf_map",
> > +	"bpf_prog"
> > +};
> > +
> > +static const int pseudo_filesystems[] = {
> > +	PROC_SUPER_MAGIC,
> > +	SYSFS_MAGIC,
> > +	DEBUGFS_MAGIC,
> > +	TMPFS_MAGIC,
> > +	DEVPTS_SUPER_MAGIC,
> > +	BINFMTFS_MAGIC,
> > +	SECURITYFS_MAGIC,
> > +	SELINUX_MAGIC,
> > +	SMACK_MAGIC,
> > +	CGROUP_SUPER_MAGIC,
> > +	CGROUP2_SUPER_MAGIC,
> > +	NSFS_MAGIC,
> > +	EFIVARFS_MAGIC
> > +};
> > +
> > +static bool bypass_inode(struct inode *inode)
> > +{
> > +	bool retn = true;
> > +
> > +	unsigned int lp;
> > +
> > +	if (!S_ISREG(inode->i_mode))
> > +		goto done;
> > +
> > +	for (lp = 0; lp < ARRAY_SIZE(pseudo_filesystems); ++lp)
> > +		if (inode->i_sb->s_magic == pseudo_filesystems[lp])
> > +			goto done;
> > +	retn = false;
> > +
> > + done:
> > +	return retn;
> > +}
> > +
> > +static int event_action(struct tsem_context *ctx, enum tsem_event_type event)
> > +{
> > +	int retn = 0;
> > +
> > +	if (tsem_task_trusted(current))
> > +		return retn;
> > +
> > +	if (ctx->actions[event] == TSEM_ACTION_EPERM)
> > +		retn = -EPERM;
> > +
> > +	return retn;
> > +}
> > +
> > +static int return_trapped_task(enum tsem_event_type event, char *msg,

> Why isn't this simply "trapped_task()"?

Probably because at the time the code was written we were thinking of
it as a declarative name for what the function did, ie. it returns the
permission value for a task that has been trapped by a security event
handler because the task was considered to be in an untrusted state.

Since it is consistently used as an argument to the return command we
will drop the return_ prefix.

> > +			       bool locked)
> > +{
> > +	int retn;
> > +	struct tsem_context *ctx = tsem_context(current);
> > +
> > +	pr_warn("Untrusted %s: comm=%s, pid=%d, parameters='%s'\n",
> > +		tsem_names[event], current->comm, task_pid_nr(current), msg);
> > +
> > +	if (ctx->external) {
> > +		retn = tsem_export_action(event, locked);
> > +		if (retn)
> > +			return retn;
> > +	}
> > +
> > +	return event_action(ctx, event);
> > +}
> > +
> > +static int return_trapped_inode(enum tsem_event_type event,

> Again, really odd function name.

Same reasoning as above and we will drop the return_ prefix.

> ... and that's all I have time for.

We do appreciate all modicum's of time that people are willing to
extend to this.

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
