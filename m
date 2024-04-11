Return-Path: <linux-kernel+bounces-141460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 859858A1E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A4F2916AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046E2137756;
	Thu, 11 Apr 2024 18:13:43 +0000 (UTC)
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECB7374F6;
	Thu, 11 Apr 2024 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859221; cv=none; b=JviZkvYryzXTyKjMaOBUOVqI+ygp+RzrKzK28zMLu0JLInmTmuOwCrF9Y8Sc74JHIYIErj2TiqRc5mQS5QeKg6jA+LmZHZMzUUnYUeuwvVsNj2KCXy4zmMtNNjAQj7twUTOWbuzJrfFQK0DPSDjlD9Elznil3/nj8S0u7k2rLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859221; c=relaxed/simple;
	bh=GQQfvGSWOqQfMYrm5fR/28TFtxeUHfEIp53brblj9og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6y/3cVbBGWjV+yCBBbWC3YNog6IhIE9hLCw0jafWA0h5NsP0KLtCJs0jJoDZI5UqhjbiFqfTVpoIwIg9qiYg9g4sRE1k28+ULDelFQTA+G0rH/1lxpRgbNuKSLepOvOYeZy5ocjGfQzfUvhHEmpU4/bPg48b45EXrFDA4Auo6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 43BIDMgI018526;
	Thu, 11 Apr 2024 13:13:22 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 43BIDLjk018525;
	Thu, 11 Apr 2024 13:13:21 -0500
Date: Thu, 11 Apr 2024 13:13:21 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Greg Wettstein <greg@enjellic.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v3 04/12] Add primary TSEM implementation file.
Message-ID: <20240411181321.GA18451@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240401105015.27614-1-greg@enjellic.com> <20240401105015.27614-5-greg@enjellic.com> <42c5489c-5e5c-4648-b370-cbc14e86dbbc@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42c5489c-5e5c-4648-b370-cbc14e86dbbc@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 11 Apr 2024 13:13:22 -0500 (CDT)

On Tue, Apr 02, 2024 at 02:15:18PM -0700, Casey Schaufler wrote:

Good morning, I hope the day is going well.

> On 4/1/2024 3:50 AM, Greg Wettstein wrote:
> > From: "Dr. Greg" <greg@enjellic.com>
> >
> > The tsem.c file is the 'master' file in the TSEM implementation.
> > It is responsible for initializing the LSM and providing
> > the implementation of the security event handlers.
> > ---
> >  security/tsem/tsem.c | 2422 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 2422 insertions(+)
> >  create mode 100644 security/tsem/tsem.c
> >
> > diff --git a/security/tsem/tsem.c b/security/tsem/tsem.c
> > new file mode 100644
> > index 000000000000..876ef1fa8012
> > --- /dev/null
> > +++ b/security/tsem/tsem.c
> > @@ -0,0 +1,2422 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +/*
> > + * Copyright (C) 2024 Enjellic Systems Development, LLC
> > + * Author: Dr. Greg Wettstein <greg@enjellic.com>
> > + *
> > + * This file is the primary implementation file for the tsem LSM.
> > + *
> > + * It implements initialization and setup functions that interpret
> > + * kernel command-line arguments and prepares TSEM for operation.
> > + *
> > + * In addition it contains all of the TSEM specific security event
> > + * handlers that are responsible for handling the LSM events that TSEM
> > + * models.
> > + *
> > + * Each TSEM event handler calls the tsem_allocate_event() function to
> > + * allocate a structure that will be used to describe the event.  The
> > + * CELL union of this structure contains various structures that are
> > + * used to hold these parameters.
> > + *
> > + * Since the event characterization parameters need to be retained for
> > + * the lifetime of the tsem_event structure that is allocated.  In the
> > + * case of internally modeled namespaces this lifespan is the lifetime
> > + * of the security modeling namespace.  In the case of externally
> > + * modeled namespaces, the lifespan is until the security event
> > + * description is exported to an external trust orchestrator.
> > + *
> > + * In order to support this model, the event description structures
> > + * are typically composed of a union over 'in' and 'out' structures.
> > + * The 'in' structures are used to hold arguments to the event handler
> > + * that may only be relevant for the duration of the call.  These
> > + * values are translated into members of the 'out' structure that
> > + * retain the values until the end of the lifetime of the tsem_event
> > + * structure.
> > + *
> > + * Each TSEM event handler is responsible for allocating a tsem_event
> > + * structure and populating the appropriate CELL structure with the
> > + * input characteristics of the event.  The dispatch_event() function
> > + * is called to handle the modeling of the event.  This function
> > + * returns the permission value that is returned as the result of the
> > + * LSM event handler.
> > + *
> > + * The dispatch_event() calls the tsem_event_init() function that is
> > + * responsible for translating the input parameters into values that
> > + * will be retained for the lifetime of the security event
> > + * description.  The populated event description is then dispatched to
> > + * either the tsem_model_event() or the tsem_export_event() for
> > + * modeling by either the internal TMA or by a TMA associated with an
> > + * external trust orchestrator.

> I'm not in favor of this level of indirection. Funneling all the LSM
> hooks into a dispatcher that fans out to a 1 to 1 (or near enough it
> doesn't make a difference) set of event handlers is just wasteful of
> resources.

You may have written that based on the documentation and before you
got to the dispatch_event() function, here it is for the benefit of
everyone following along at home:

static int dispatch_event(struct tsem_event *ep)
{
	int retn = 0;
	struct tsem_context *ctx = tsem_context(current);

	retn = tsem_event_init(ep);
	if (retn)
		return retn;

	if (unlikely(tsem_task_untrusted(current)))
		return untrusted_task(ep);

	if (!ctx->external)
		retn = tsem_model_event(ep);
	else
		retn = tsem_export_event(ep);

	tsem_event_put(ep);
	return retn;
}

We didn't implement a separate function in order to implement the
fanout, we implemented a separate dispatch function to consolidate
common functionality so that we didn't have to replicate it 86 times.

Would you advocate that we cut and paste the above into every handler?

We have no objections to doing so but issues about code size and the
like have been raised previously.

> > + */
> > +
> > +#define LOCKED true
> > +#define NOLOCK false

> As you have these constants defined the first would indicate that a
> lock is set, whereas the second indicates there is not a lock.  You
> should either pair LOCKED with UNLOCKED or LOCK with NOLOCK.  Or
> better yet, name your variables such that "true" and "false" are
> reasonable descriptions of their states.

We will change the constants to LOCK and NOLOCK, makes more sense.

> > +
> > +#include <linux/magic.h>
> > +#include <linux/mman.h>
> > +#include <linux/binfmts.h>
> > +#include <linux/bpf.h>
> > +#include <linux/mount.h>
> > +#include <linux/security.h>
> > +
> > +#include "tsem.h"
> > +
> > +static const struct lsm_id tsem_lsmid = {
> > +	.name = "tsem",
> > +	.id = LSM_ID_TSEM,
> > +};
> > +
> > +struct lsm_blob_sizes tsem_blob_sizes __ro_after_init = {
> > +	.lbs_task = sizeof(struct tsem_task),
> > +	.lbs_inode = sizeof(struct tsem_inode),
> > +	.lbs_ipc = sizeof(struct tsem_ipc),
> > +	.lbs_xattr_count = 1
> > +};
> > +
> > +enum tsem_action_type tsem_root_actions[TSEM_EVENT_CNT] = {
> > +	TSEM_ACTION_EPERM	/* Undefined. */
> > +};
> > +
> > +static atomic64_t task_instance;
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
> > +	.pseudonym_list = LIST_HEAD_INIT(root_model.pseudonym_list),
> > +
> > +	.mount_mutex = __MUTEX_INITIALIZER(root_model.mount_mutex),
> > +	.mount_list = LIST_HEAD_INIT(root_model.mount_list)
> > +};
> > +
> > +static struct tsem_context root_context;
> > +
> > +DEFINE_STATIC_KEY_TRUE(tsem_not_ready);
> > +
> > +static bool tsem_available __ro_after_init;
> > +
> > +static unsigned int magazine_size __ro_after_init = TSEM_ROOT_MAGAZINE_SIZE;
> > +
> > +static enum mode_type {
> > +	FULL_MODELING,
> > +	NO_ROOT_MODELING,
> > +	EXPORT_ONLY
> > +} tsem_mode __ro_after_init;
> > +
> > +static char *default_hash_function __ro_after_init;
> > +
> > +const char * const tsem_names[TSEM_EVENT_CNT] = {
> > +	"undefined",
> > +	"bprm_committed_creds",
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
> > +	"bpf_prog",
> > +	"ptrace_access_check",
> > +	"capable",
> > +	"capget",
> > +	"capset"
> > +};

> You can't seriously be counting on this being a mapping to tsem
> event numbers, with the event numbers being defined
> elsewhere. You'll never be able to keep them in sync. You probably
> want a structure here, with entries like
>
> 	{ "hook_name",	TSEM_EVENT_HOOK_NAME },

It is clumsy but it doesn't seem like there is a good fix for the
issue, other than documentation.

The tsem_event_type enumeration constants are used to index the array
of event names, so it doesn't seem like including the event type as
part of a structure, in that array, buys us much, we would never have
a purpose for referencing the type value in the array.

We will place the enumerated event name as a comment alongside each
event name.  We will also stick a comment on both the enumerated type
and the description name indicating the requirement that if one
changes the other needs to change as well.

> > +
> > +static const unsigned long pseudo_filesystems[] = {
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

> Why isn't this a void function?

Change:
static int __init set_magazine_size(char *magazine_value)
To:
static void __init set_magazine_size(char *magazine_value)

And delete 'return 1';

Then:

make security/tsem/tsem.o
  CALL    scripts/checksyscalls.sh
  Descend objtool
  INSTALL libsubcmd_headers
  CC      security/tsem/tsem.o
In file included from ./include/linux/printk.h:6,
                 from ./include/asm-generic/bug.h:22,
                 from ./arch/x86/include/asm/bug.h:87,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/mm.h:6,
                 from ./include/linux/mman.h:5,
                 from security/tsem/tsem.c:56:
security/tsem/tsem.c:238:24: error: initialization of 'int (*)(char *)' from incompatible pointer type 'void (*)(char *)' [-Werror=incompatible-pointer-types]
  238 | __setup("tsem_cache=", set_magazine_size);
      |                        ^~~~~~~~~~~~~~~~~
/include/linux/init.h:343:32: note: in definition of macro '__setup_param'
  343 |   = { __setup_str_##unique_id, fn, early }
      |                                ^~
security/tsem/tsem.c:238:1: note: in expansion of macro '__setup'
  238 | __setup("tsem_cache=", set_magazine_size);
      | ^~~~~~~
security/tsem/tsem.c:238:24: note: (near initialization for '__setup_set_magazine_size.setup_func')
  238 | __setup("tsem_cache=", set_magazine_size);
      |                        ^~~~~~~~~~~~~~~~~
/include/linux/init.h:343:32: note: in definition of macro '__setup_param'
  343 |   = { __setup_str_##unique_id, fn, early }
      |                                ^~
security/tsem/tsem.c:238:1: note: in expansion of macro '__setup'
  238 | __setup("tsem_cache=", set_magazine_size);
      | ^~~~~~~
cc1: some warnings being treated as errors
make[4]: *** [security/tsem/tsem.o] Error 1
make[3]: *** [security/tsem] Error 2
make[2]: *** [security] Error 2
make[1]: *** [.] Error 2
make: *** [__sub-make] Error 2

Compilation exited abnormally with code 2 at Wed Apr 10 12:12:46

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
> > +		tsem_mode = NO_ROOT_MODELING;
> > +	else if (mode == 2)
> > +		tsem_mode = EXPORT_ONLY;
> > +	else
> > +		pr_warn("tsem: Unknown mode specified.\n");
> > +}
> > +__setup("tsem_mode=", set_modeling_mode);
> > +

> If you're ever going to have additional "modes" you probably want a
> switch() rather than cascading if()s.  You seem generally aggressive
> with defining meaningful constants.  It seems out of character that
> you're using integer mode values instead of TSEM_MODE_CLOCKWISE and
> TSEM_MODE_WIDDERSHINS, or whatever the modes are.

After thinking a bit, the following may simplify things even more,
with the addition of NO_MODE to the mode_type enumeration.

static int __init set_modeling_mode(char *mode_value)
{
	unsigned long mode = 0;

	if (kstrtoul(mode_value, 0, &mode)) {
		pr_warn("tsem: Failed to parse modeling mode.\n");
		return 1;
	}

	if (mode >= NO_MODE)
		pr_warn("tsem: Unknown mode specified.\n");
	else
		tsem_mode = mode;
	return 1;
}

> Repeating myself the once. If a function can only ever return
> one value it should be a void function.

It would appear, from above, that the __setup() macro assumes a value
returning function.

> > +static int __init set_default_hash_function(char *hash_function)
> > +{
> > +
> > +	default_hash_function = hash_function;
> > +	return 1;
> > +}
> > +__setup("tsem_digest=", set_default_hash_function);
> > +
> > +static bool bypass_event(void)
> > +{
> > +	if (tsem_mode == NO_ROOT_MODELING && !tsem_context(current)->id)
> > +		return true;
> > +	return false;
> > +}
> > +
> > +static bool pseudo_filesystem(struct inode *inode)
> > +{
> > +	unsigned int lp;
> > +
> > +	for (lp = 0; lp < ARRAY_SIZE(pseudo_filesystems); ++lp)
> > +		if (inode->i_sb->s_magic == pseudo_filesystems[lp])
> > +			return true;
> > +	return false;
> > +}
> > +
> > +static int untrusted_task(struct tsem_event *ep)
> > +{
> > +	int retn = 0;
> > +	struct tsem_context *ctx = tsem_context(current);
> > +
> > +	if (ctx->external) {
> > +		retn = tsem_export_action(ep->event, ep->locked);
> > +		if (retn)
> > +			return retn;
> > +	} else
> > +		pr_warn("Untrusted event %s: model_ns=%lld, comm=%s, pid=%d\n",
> > +			tsem_names[ep->event], ctx->id, current->comm,
> > +			task_pid_nr(current));
> > +
> > +	if (ctx->actions[ep->event] == TSEM_ACTION_EPERM)
> > +		retn = -EPERM;
> > +	return retn;
> > +}
> > +
> > +static int dispatch_event(struct tsem_event *ep)
> > +{
> > +	int retn = 0;
> > +	struct tsem_context *ctx = tsem_context(current);
> > +
> > +	retn = tsem_event_init(ep);
> > +	if (retn)
> > +		return retn;
> > +
> > +	if (unlikely(tsem_task_untrusted(current)))
> > +		return untrusted_task(ep);
> > +
> > +	if (!ctx->external)
> > +		retn = tsem_model_event(ep);
> > +	else
> > +		retn = tsem_export_event(ep);
> > +
> > +	tsem_event_put(ep);
> > +	return retn;
> > +}
> > +
> > +static int tsem_file_open(struct file *file)
> > +{
> > +	struct inode *inode = file_inode(file);
> > +	struct tsem_event *ep;
> > +
> > +	if (static_branch_unlikely(&tsem_not_ready))
> > +		return 0;
> > +	if (bypass_event())
> > +		return 0;
> > +	if (unlikely(tsem_inode(inode)->status == TSEM_INODE_CONTROL_PLANE)) {
> > +		if (capable(CAP_MAC_ADMIN))
> > +			return 0;
> > +		else
> > +			return -EPERM;
> > +	}
> > +
> > +	if (!S_ISREG(inode->i_mode))
> > +		return 0;
> > +	if (tsem_inode(inode)->status == TSEM_INODE_COLLECTING)
> > +		return 0;
> > +
> > +	ep = tsem_event_allocate(TSEM_FILE_OPEN, NOLOCK);
> > +	if (!ep)
> > +		return -ENOMEM;
> > +
> > +	ep->CELL.file.in.file = file;
> > +	ep->CELL.file.in.pseudo_file = pseudo_filesystem(inode);
> > +
> > +	return dispatch_event(ep);
> > +}
> > +
> > +static int tsem_mmap_file(struct file *file, unsigned long prot,
> > +			  unsigned long flags, unsigned long extra)
> > +{
> > +	struct inode *inode = NULL;
> > +	struct tsem_event *ep;
> > +
> > +	if (static_branch_unlikely(&tsem_not_ready))
> > +		return 0;
> > +	if (bypass_event())
> > +		return 0;
> > +
> > +	if (!file && !(prot & PROT_EXEC))
> > +		return 0;
> > +	if (file) {
> > +		inode = file_inode(file);
> > +		if (!S_ISREG(inode->i_mode))
> > +			return 0;
> > +		if (pseudo_filesystem(inode))
> > +			return 0;
> > +	}
> > +
> > +	ep = tsem_event_allocate(TSEM_MMAP_FILE, NOLOCK);
> > +	if (!ep)
> > +		return -ENOMEM;
> > +
> > +	ep->CELL.mmap_file.anonymous = file == NULL ? 1 : 0;
> > +	ep->CELL.mmap_file.file.in.file = file;
> > +	ep->CELL.mmap_file.prot = prot;
> > +	ep->CELL.mmap_file.flags = flags;
> > +
> > +	return dispatch_event(ep);
> > +}
> > +
> > +static int tsem_file_ioctl(struct file *file, unsigned int cmd,
> > +			   unsigned long arg)
> > +{
> > +	struct tsem_event *ep;
> > +
> > +	if (bypass_event())
> > +		return 0;
> > +
> > +	ep = tsem_event_allocate(TSEM_FILE_IOCTL, NOLOCK);
> > +	if (!ep)
> > +		return -ENOMEM;
> > +
> > +	ep->CELL.file.cmd = cmd;
> > +	ep->CELL.file.in.file = file;
> > +	ep->CELL.file.in.pseudo_file = pseudo_filesystem(file_inode(file));
> > +
> > +	return dispatch_event(ep);
> > +}
> > +
> > +static int tsem_file_lock(struct file *file, unsigned int cmd)
> > +{
> > +	struct tsem_event *ep;
> > +
> > +	if (bypass_event())
> > +		return 0;
> > +
> > +	ep = tsem_event_allocate(TSEM_FILE_LOCK, NOLOCK);
> > +	if (!ep)
> > +		return -ENOMEM;
> > +
> > +	ep->CELL.file.cmd = cmd;
> > +	ep->CELL.file.in.file = file;
> > +	ep->CELL.file.in.pseudo_file = pseudo_filesystem(file_inode(file));
> > +
> > +	return dispatch_event(ep);
> > +}
> > +
> > +static int tsem_file_fcntl(struct file *file, unsigned int cmd,
> > +			   unsigned long arg)
> > +{
> > +	struct tsem_event *ep;
> > +
> > +	if (static_branch_unlikely(&tsem_not_ready))
> > +		return 0;
> > +	if (bypass_event())
> > +		return 0;
> > +
> > +	ep = tsem_event_allocate(TSEM_FILE_FCNTL, NOLOCK);
> > +	if (!ep)
> > +		return -ENOMEM;
> > +
> > +	ep->CELL.file.cmd = cmd;
> > +	ep->CELL.file.in.file = file;
> > +	ep->CELL.file.in.pseudo_file = pseudo_filesystem(file_inode(file));
> > +
> > +	return dispatch_event(ep);
> > +}
> > +
> > +static int tsem_file_receive(struct file *file)
> > +{
> > +	struct tsem_event *ep;
> > +
> > +	if (bypass_event())
> > +		return 0;
> > +
> > +	ep = tsem_event_allocate(TSEM_FILE_RECEIVE, NOLOCK);
> > +	if (!ep)
> > +		return -ENOMEM;
> > +
> > +	ep->CELL.file.in.file = file;
> > +	ep->CELL.file.in.pseudo_file = pseudo_filesystem(file_inode(file));
> > +
> > +	return dispatch_event(ep);
> > +}
> > +
> > +static int tsem_task_alloc(struct task_struct *new, unsigned long flags)
> > +{
> > +	struct tsem_task *old_task = tsem_task(current);
> > +	struct tsem_task *new_task = tsem_task(new);
> > +
> > +	new_task->instance = old_task->instance;
> > +	new_task->p_instance = old_task->instance;
> > +
> > +	new_task->trust_status = old_task->trust_status;
> > +	new_task->context = old_task->context;
> > +	memcpy(new_task->task_id, old_task->task_id, HASH_MAX_DIGESTSIZE);
> > +	memcpy(new_task->p_task_id, old_task->task_id, HASH_MAX_DIGESTSIZE);
> > +
> > +	if (!new_task->context->id)
> > +		return 0;
> > +
> > +	kref_get(&new_task->context->kref);
> > +	memcpy(new_task->task_key, old_task->task_key, HASH_MAX_DIGESTSIZE);
> > +	return 0;
> > +}
> > +
> > +static void tsem_task_free(struct task_struct *task)
> > +{
> > +	struct tsem_context *ctx = tsem_context(task);
> > +
> > +	if (!ctx->id)
> > +		return;
> > +	tsem_ns_put(ctx);

> 	if (ctx->id)
> 		tsem_ne_put(ctx);
> 
> One less line of code.

Good catch, we usually try to spot those opportunities.

.. [ code lacking review comments removed ] ...

Again, thank you for the comments, we appreciate them.

Have a good remainder of the week.

As always,
Dr. Greg

   The Quixote Project - Flailing at the Travails of Cybersecurity
		  https://github.com/Quixote-Project



