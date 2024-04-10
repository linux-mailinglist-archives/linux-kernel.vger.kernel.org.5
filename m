Return-Path: <linux-kernel+bounces-138303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B916789EF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6491C221D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE5D159570;
	Wed, 10 Apr 2024 10:06:37 +0000 (UTC)
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E6B15921C;
	Wed, 10 Apr 2024 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743594; cv=none; b=VmnKqw/CxMGyCDJ1HW23E7P2WaDCnSG0sGg6F53SGNOiR+i+ts95+ZsEroptfUNUKeyWXOoDpRrmwwhvwknWHbkDUm70IGxyvVadljP60xeUADzNKVXP+lFfci1KxkzScjzRONJv7t4dcKk8bzeOfRsBSkTD14nRPZL+QJrG/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743594; c=relaxed/simple;
	bh=qq6Gj78ByCcmQz9pkgcXLmKST3QI/Lgubl2twGOpDX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIarMM04RlyBC4ay3XVPaefvOXO/x0JPFpY9FA3DFjGlDQy7DCbM+vRiBRC39xGApt7KZDebKcQbo+/D9Q8XXcplKeT3b1LgK2CF6qHhgiw5MJraiiwp9Iu7FAOqtvfczADP2ZM/CoCBMTY02hkldy8j/myKLkinWiThj4HV/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 43A9eulG028859;
	Wed, 10 Apr 2024 04:40:56 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 43A9etKk028858;
	Wed, 10 Apr 2024 04:40:55 -0500
Date: Wed, 10 Apr 2024 04:40:55 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmorris@namei.org
Subject: Re: [PATCH v3 03/12] TSEM global declarations.
Message-ID: <20240410094054.GA28636@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240401105015.27614-1-greg@enjellic.com> <20240401105015.27614-4-greg@enjellic.com> <fd838651-5b05-4c4c-a930-e86fd568bbc5@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd838651-5b05-4c4c-a930-e86fd568bbc5@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 10 Apr 2024 04:40:56 -0500 (CDT)

On Mon, Apr 01, 2024 at 11:24:27AM -0700, Casey Schaufler wrote:

Good morning Casey, I hope your day is starting well, thanks for taking
the time to review the code.

> On 4/1/2024 3:50 AM, Greg Wettstein wrote:
> > From: "Dr. Greg" <greg@enjellic.com>
> >
> > TSEM is designed, from a functional perspective, to be entirely contained in
> > its own directory.
> >
> > TSEM uses a single global header file, tsem.h, to define the
> > enumeration types, structure definitions and functions that are
> > referenced across all of the compilation units that implement the
> > LSM.

> I've called out several things explicitly below. As a general
> comment, you are keeping copies of data that you ought to be
> providing pointers to in many instances. This is going to cause
> problems with kernel data size, performance and data accuracy. Based
> on the form of data you're defining I'm guessing your code is
> several times larger than it needs to be. As I mentioned earlier,
> it's impossible to say for sure, given the separation of data
> definition from code.

Keeping retention copies of the data that characterize the security
event descriptions is required by the TSEM architecture and we believe
decreases the overall impact on kernel memory consumption as compared
to directly using the arguments to the event handlers

The issue, at large, is that the security event parameters need to be
maintained for the lifespan of the event description.  In the case of
internally modeled namespaces, the lifespan is the life of the
namespace, in the case of externally modeled namespaces, the lifespan
is until the security event description is exported to the trust
orchestrator.

The only guaranteed lifespan of the characterizing parameters passed
to the security event handlers is the execution life of the handler.
In the case of scalar values, by definition, the lifespan is the life
of the stack frame used for the handler, so event specific space is
required for those.  Pointers to structures would need to have their
reference counts, if available, increased in order to persist the
structure through the lifetime of the event description.

Given the dynamics of Linux kernel development, particularly security,
it seemed patently unwise for an LSM to start pinning structures for
its own convenience and for indefinite lifetimes.

The common security relevant structures, that are passed by pointer
reference to the event handlers, contain a lot of information that is
not security relevent.  Using a dedicated structure to contain the
security relevant information results in less memory being consumed
than if the entire structure were to be retained.

For example, here are size comparisons between TSEM versions of
retention structures and system native versions that would need to be
pinned, with size in bytes.

structure       native          TSEM
---------       ------          ----
cred            184             48
file            464             248
inode           1112            64
dentry          312             176
path            16              104
sock            1248            80

So there is a substantive savings, in all but the path case, by only
retaining security relevant characteristics.

TSEM ends up defining a large number of structures secondary to the
fact that there is a significant difference in the type of information
that needs to be retained across all of the serviced event handlers.
There are no independent memory allocations for these structures, as
they are held in a union in the tsem_event structure, so the
allocation cost for any of these structures is the single allocation
cost of the enclosing event description structure.

The size of the tsem_event structure that characterizes any security
event is currently 866 bytes, a value that seems to be on par with
other major kernel data structures.

We use kmem_cache based allocation for the event structures with
atomic events handled by use of a pre-allocated magazine, with the
magazine being asynchronously refilled with a workqueue.  Given its
use throughout the kernel, the kmem_cache infrastructure would seem to
be highly optimized and the best available for this sort of allocation
workload.

The cost associated with atomic event allocations is a spinlock held
over a critical region that locates an available bit in the magazine
index bit vector, three assignment operations and a set_bit()
operation.

Hopefully this addresses the issue of memory consumption and
performance.

We would be open to any specific observations as to how the accuracy
of the retained information suffers in our implementation.

> > ---
> >  security/tsem/tsem.h | 2278 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 2278 insertions(+)
> >  create mode 100644 security/tsem/tsem.h
> >
> > diff --git a/security/tsem/tsem.h b/security/tsem/tsem.h
> > new file mode 100644
> > index 000000000000..d1d3e847a550
> > --- /dev/null
> > +++ b/security/tsem/tsem.h
> > @@ -0,0 +1,2278 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +/*
> > + * Copyright (C) 2024 Enjellic Systems Development, LLC
> > + * Author: Dr. Greg Wettstein <greg@enjellic.com>
> > + *
> > + * This is the single include file that documents all of the externally
> > + * visible types and functions that are used by TSEM.  This file is
> > + * currently organized into four major sections in the following order;
> > + *
> > + * includes used by all compilation units
> > + * CPP definitions
> > + * enumeration types
> > + * structure definitions
> > + * function declarations
> > + * inline encapsulation functions.
> > + *
> > + * Include files that are referenced by more than a single compilation
> > + * should be included in this file.  Includes that are needed to
> > + * satisfy compilation requirements for only a single file should be
> > + * included in the file needing that include.
> > + *
> > + * Understanding the overall implementation and architecture of TSEM
> > + * will be facilitated by reviewing the documentation in this file.
> > + */
> > +
> > +#include <linux/wait.h>
> > +#include <linux/kref.h>
> > +#include <linux/lsm_hooks.h>
> > +#include <linux/capability.h>
> > +#include <crypto/hash.h>
> > +#include <crypto/hash_info.h>
> > +#include <net/af_unix.h>
> > +
> > +/*
> > + * The number of 'slots' in the structure magazines that are used to
> > + * satisfy modeling of security events that are called in atomic context.
> > + */
> > +#define TSEM_ROOT_MAGAZINE_SIZE    128
> > +#define TSEM_MAGAZINE_SIZE_INTERNAL 32
> > +#define TSEM_MAGAZINE_SIZE_EXTERNAL 128
> > +
> > +/**
> > + * enum tsem_event_type - Ordinal value for a security event.
> > + * @TSEM_BPRM_COMMITTED_CREDS: Ordinal value for bprm_committed_creds.
> > + * @TSEM_TASK_KILL: Ordinal value for task kill.
> > + * @....: Remainder follows with a similar naming format that has
> > + *        TSEM_ prep ended to the raw LSM security hook name.
> > + * @TSEM_EVENT_CNT: The final ordinal value is used to define the
> > + *             length of the following arrays that are indexed
> > + *             by the ordinal value of the hook:
> > + *
> > + * This enumeration is used to designate an ordinal value for each
> > + * security event, ie. LSM hook/event handler, that TSEM is
> > + * implementing modeling for.  This value is used to identify the
> > + * handler that is either having its event description being exported
> > + * to an external trust orchestrator or modeled by the internal TMA
> > + * implementation.
> > + *
> > + * The primary use of this enumeration is to conditionalize code paths
> > + * based on the security hook being processed and to index the
> > + * tsem_names array and the array that defines the action that is to
> > + * be taken in response to an event that generates a permissions
> > + * violation.
> > + */
> > +enum tsem_event_type {
> > +   TSEM_BPRM_COMMITTING_CREDS = 1,
> > +   TSEM_TASK_KILL,
> > +   TSEM_TASK_SETPGID,
> > +   TSEM_TASK_GETPGID,
> > +   TSEM_TASK_GETSID,
> > +   TSEM_TASK_SETNICE,
> > +   TSEM_TASK_SETIOPRIO,
> > +   TSEM_TASK_GETIOPRIO,
> > +   TSEM_TASK_PRLIMIT,
> > +   TSEM_TASK_SETRLIMIT,
> > +   TSEM_TASK_SETSCHEDULER,
> > +   TSEM_TASK_GETSCHEDULER,
> > +   TSEM_TASK_PRCTL,
> > +   TSEM_FILE_OPEN,
> > +   TSEM_MMAP_FILE,
> > +   TSEM_FILE_IOCTL,
> > +   TSEM_FILE_LOCK,
> > +   TSEM_FILE_FCNTL,
> > +   TSEM_FILE_RECEIVE,
> > +   TSEM_UNIX_STREAM_CONNECT,
> > +   TSEM_UNIX_MAY_SEND,
> > +   TSEM_SOCKET_CREATE,
> > +   TSEM_SOCKET_CONNECT,
> > +   TSEM_SOCKET_BIND,
> > +   TSEM_SOCKET_ACCEPT,
> > +   TSEM_SOCKET_LISTEN,
> > +   TSEM_SOCKET_SOCKETPAIR,
> > +   TSEM_SOCKET_SENDMSG,
> > +   TSEM_SOCKET_RECVMSG,
> > +   TSEM_SOCKET_GETSOCKNAME,
> > +   TSEM_SOCKET_GETPEERNAME,
> > +   TSEM_SOCKET_SETSOCKOPT,
> > +   TSEM_SOCKET_SHUTDOWN,
> > +   TSEM_PTRACE_TRACEME,
> > +   TSEM_KERNEL_MODULE_REQUEST,
> > +   TSEM_KERNEL_LOAD_DATA,
> > +   TSEM_KERNEL_READ_FILE,
> > +   TSEM_SB_MOUNT,
> > +   TSEM_SB_UMOUNT,
> > +   TSEM_SB_REMOUNT,
> > +   TSEM_SB_PIVOTROOT,
> > +   TSEM_SB_STATFS,
> > +   TSEM_MOVE_MOUNT,
> > +   TSEM_SHM_ASSOCIATE,
> > +   TSEM_SHM_SHMCTL,
> > +   TSEM_SHM_SHMAT,
> > +   TSEM_SEM_ASSOCIATE,
> > +   TSEM_SEM_SEMCTL,
> > +   TSEM_SEM_SEMOP,
> > +   TSEM_SYSLOG,
> > +   TSEM_SETTIME,
> > +   TSEM_QUOTACTL,
> > +   TSEM_QUOTA_ON,
> > +   TSEM_MSG_QUEUE_ASSOCIATE,
> > +   TSEM_MSG_QUEUE_MSGCTL,
> > +   TSEM_MSG_QUEUE_MSGSND,
> > +   TSEM_MSG_QUEUE_MSGRCV,
> > +   TSEM_IPC_PERMISSION,
> > +   TSEM_KEY_ALLOC,
> > +   TSEM_KEY_PERMISSION,
> > +   TSEM_NETLINK_SEND,
> > +   TSEM_INODE_CREATE,
> > +   TSEM_INODE_LINK,
> > +   TSEM_INODE_UNLINK,
> > +   TSEM_INODE_SYMLINK,
> > +   TSEM_INODE_MKDIR,
> > +   TSEM_INODE_RMDIR,
> > +   TSEM_INODE_MKNOD,
> > +   TSEM_INODE_RENAME,
> > +   TSEM_INODE_SETATTR,
> > +   TSEM_INODE_GETATTR,
> > +   TSEM_INODE_SETXATTR,
> > +   TSEM_INODE_GETXATTR,
> > +   TSEM_INODE_LISTXATTR,
> > +   TSEM_INODE_REMOVEXATTR,
> > +   TSEM_INODE_KILLPRIV,
> > +   TSEM_TUN_DEV_CREATE,
> > +   TSEM_TUN_DEV_ATTACH_QUEUE,
> > +   TSEM_TUN_DEV_ATTACH,
> > +   TSEM_TUN_DEV_OPEN,
> > +   TSEM_BPF,
> > +   TSEM_BPF_MAP,
> > +   TSEM_BPF_PROG,
> > +   TSEM_PTRACE_ACCESS_CHECK,
> > +   TSEM_CAPABLE,
> > +   TSEM_CAPGET,
> > +   TSEM_CAPSET,
> > +   TSEM_EVENT_CNT
> > +};

> This looks like a lurking maintenance problem for both TSEM
> and the LSM infrastructure. New hooks are added regularly. Hooks
> that have outlived their usefulness are routinely deleted. The
> mount infrastructure rewrite is a good example of why there needs
> to be flexibility in hook lifetimes.
> 
> You might consider generating this mapping in tsem_init() rather
> than hard coding it. Alas, no easy way to do that comes to mind. :(

It is an issue, and as you correctly note, probably difficult to
address, other than through coordinated maintenance.

In essence, TSEM treats the security event handlers as the independent
variables of a model that characterizes the security state of an
execution environment.  If the hooks change, by definition the model
changes, we understand and are prepared to cope with that.  Paul has
made it very clear, multiple times, that there are no expectations of
API stability in the security system.

Among the entities we are working with are groups that desire a 10-20
year guarantee of a strictly defined security behavior for their
platforms and workloads, so a kernel release based API isn't a
constraint.  Other groups re-validate their workload on every kernel
release so a new security model, consistent with the kernel
implementation, would derive from their unit testing and CI/CD
pipelines.

> > +
> > +/**
> > + * enum tsem_action_type - Ordinal value for security responses.
> > + * @TSEM_ACTION_LOG: Ordinal value to indicate that a security event
> > + *              that results in a model permissions violation
> > + *              should be logged.
> > + * @TSEM_ACTION_EPERM: Ordinal value to indicate that a security event
> > + *                generating a model permissions violation should
> > + *                return -EPERM to the caller.
> > + *
> > + * This enumeration type is used to designate what type of action is
> > + * to be taken when the processing of a security event hook results in
> > + * a model violation.  The TSEM_ACTION_LOG and TSEM_ACTION_EPERM
> > + * translate into the classical concepts of logging or enforcing
> > + * actions used by other mandatory access control architectures.
> > + */
> > +enum tsem_action_type {
> > +   TSEM_ACTION_LOG = 0,
> > +   TSEM_ACTION_EPERM,
> > +   TSEM_ACTION_CNT
> > +};
> > +
> > +/**
> > + * enum tsem_control_type - Ordinal values for TSEM control actions.
> > + * @TSEM_CONTROL_INTERNAL: This ordinal value is set when the first
> > + *                    word of an argument string written to the
> > + *                    control file is the word 'internal'.  This
> > + *                    designates that the security namespace will
> > + *                    be modeled by the internal TMA.
> > + * @TSEM_CONTROL_EXTERNAL: This ordinal value is set when the first
> > + *                    word of an argument string written to the
> > + *                    control file is the word 'external'.  This
> > + *                    designates that the security namespace will
> > + *                    be model by an external TMA.
> > + * @TSEM_CONTROL_ENFORCE: This ordinal value is set when the word
> > + *                   'enforce' is written to the control file.
> > + *                   This indicates that model is to be placed
> > + *                   in 'enforcing' mode and security events that
> > + *                   result in model violations will return EPERM.
> > + * @TSEM_CONTROL_SEAL: This ordinal value is set when the word 'seal'
> > + *                is written to the control file.  This indicates
> > + *                that the model for security domain will treat
> > + *                all security events that do not conform to the
> > + *                model as 'forensics' events.
> > + * @TSEM_CONTROL_TRUSTED: This ordinal value is used when the first
> > + *                   word of an argument string written to the
> > + *                   control file is the word 'trusted'.  This
> > + *                   is interpreted as a directive to set the
> > + *                   trust status of the task that executed the
> > + *                   security event to be trusted.
> > + * @TSEM_CONTROL_UNTRUSTED: This ordinal value is used when the first
> > + *                     word of an argument string written to the
> > + *                     control file is the word 'untrusted'.
> > + *                     This is interpreted as a directive to set
> > + *                     the trust status of the task that executed
> > + *                     the security event to be untrusted.
> > + * @TSEM_CONTROL_MAP_STATE: This ordinal value is used when the first
> > + *                     word of an argument string written to the
> > + *                     control file is the word 'state'.  The
> > + *                     argument to this directive will be an
> > + *                     ASCII hexadecimally encoded string of the
> > + *                     current model's digest size that will be
> > + *                     treated as a security state point for
> > + *                     inclusion in the security model for the
> > + *                     security domain/namespace.
> > + * @TSEM_CONTROL_MAP_PSEUDONYM: This ordinal value is used when the
> > + *                         first word of an argument string
> > + *                         written to the control file is the
> > + *                         word 'pseudonym'.  The argument to
> > + *                         this directive will be an ASCII
> > + *                         hexadecimally encoded string of the
> > + *                         current model's digest size that will
> > + *                         be treated as a pseudonym directive
> > + *                         for the security domain/namespace.
> > + * TSEM_CONTROL_MAP_BASE: This ordinal value is used when the first
> > + *                   word of an argument string written to the
> > + *                   control file is the word 'base'.  The
> > + *                   argument to this directive will be an ASCII
> > + *                   hexadecimally encoded string of the current
> > + *                   model's digest size that will be treated as
> > + *                   the base value for the computation of the
> > + *                   functional values (measurement and state) of
> > + *                   the security domain/namespace.
> > +
> > + * This enumeration type is used to designate what type of control
> > + * action is to be implemented when arguments are written to the TSEM
> > + * control file (/sys/kernel/security/tsem/control).  The ordinal
> > + * values govern the processing of the command and the interpretation
> > + * of the rest of the command argument string.
> > + */
> > +enum tsem_control_type {
> > +   TSEM_CONTROL_INTERNAL = 0,
> > +   TSEM_CONTROL_EXTERNAL,
> > +   TSEM_CONTROL_EXPORT,
> > +   TSEM_CONTROL_ENFORCE,
> > +   TSEM_CONTROL_SEAL,
> > +   TSEM_CONTROL_TRUSTED,
> > +   TSEM_CONTROL_UNTRUSTED,
> > +   TSEM_CONTROL_MAP_STATE,
> > +   TSEM_CONTROL_MAP_PSEUDONYM,
> > +   TSEM_CONTROL_MAP_BASE
> > +};
> > +
> > +/**
> > + * enum tsem_ns_reference - Ordinal value for DAC namespace reference.
> > + * @TSEM_NS_INITIAL: This ordinal value indicates that the uid/gid
> > + *              values should be interpreted against the initial
> > + *              user namespace.
> > + * @TSEM_NS_CURRENT: This ordinal value indicates that the uid/gid
> > + *              values should be interpreted against the user
> > + *              namespace that is in effect for the process being
> > + *              modeled.
> > + *
> > + * This enumeration type is used to indicate what user namespace
> > + * should be referenced when the uid/gid values are interpreted for
> > + * the creation of either the COE or CELL identities.  The enumeration
> > + * ordinal passed to the tsem_ns_create() function, to configure the
> > + * security domain/namespace, is set by the nsref argument to either
> > + * the 'internal' or 'external' control commands.
> > + */
> > +enum tsem_ns_reference {
> > +   TSEM_NS_INITIAL = 1,
> > +   TSEM_NS_CURRENT
> > +};
> > +
> > +/**
> > + * enum tsem_task_trust - Ordinal value describing task trust status.
> > + * @TSEM_TASK_TRUSTED: This ordinal value indicates that the task has
> > + *                not executed a security event that has resulted
> > + *                in a security behavior not described by the
> > + *                security model the task is being governed by.
> > + * @TSEM_TASK_UNTRUSTED: This ordinal value indicates that the task
> > + *                   has requested the execution of a security event
> > + *                   that resulted in a security behavior not
> > + *                   permitted by the security model the task is
> > + *                   being governed by.
> > + * @TSEM_TASK_TRUST_PENDING: This ordinal value indicates that the setting
> > + *                      of the task trust status is pending a response
> > + *                      from an external TMA.

> This formatting is hideous, not to mention inconsistent.

It is a TAB interpretation problem somewhere, the header file after
patching, has all of the comments stacked appropriately.

We will untabify the file to prevent further issues.

> > + *
> > + * This enumeration type is used to specify the three different trust
> > + * states that a task can be in.  The trust status of a task is
> > + * regulated by the trust_status member of struct tsem_task.  A task
> > + * carrying the status of TSEM_TASK_TRUSTED means that it has
> > + * not requested the execution of any security events that are
> > + * inconsistent with the security model that the task is running in.
> > + *
> > + * If a task requests execution of a security event that is
> > + * inconsistent with the security model it is operating in, and the
> > + * domain is running in 'sealed' mode, the task trust status is set to
> > + * TSEM_TASK_UNTRUSTED.  This value is 'sticky' in that it will be
> > + * propagated to any child tasks that are spawned from an untrusted
> > + * task.
> > + *
> > + * In the case of an externally modeled security domain/namespace, the
> > + * task trust status cannot be determined until the modeling of the
> > + * security event has been completed.  The tsem_export_event()
> > + * function sets the trust status TSEM_TASK_TRUST_PENDING and then
> > + * places the task into an interruptible sleep state.
> > + *
> > + * Only two events will cause the task to be removed from sleep state.
> > + * Either the task is killed or a control message is written to the
> > + * TSEM control file that specifies the trust status of the task.  See
> > + * the description of the TSEM_CONTROL_TRUSTED and
> > + * TSEM_CONTROL_UNTRUSTED enumeration types.
> > + */
> > +enum tsem_task_trust {
> > +   TSEM_TASK_TRUSTED = 1,
> > +   TSEM_TASK_UNTRUSTED = 2,
> > +   TSEM_TASK_TRUST_PENDING = 4
> > +};

> Where's number 3? Surely you're not using an enum in bit mask
> operations.

As a matter of fact we are.  For example, if you refer to the end of
the header file under review:

static inline bool tsem_task_untrusted(struct task_struct *task)
{
        return tsem_task(task)->trust_status & ~TSEM_TASK_TRUSTED;
}

Our reading of the C standard is that an enumerated constant can be
used in any situation where a standard integer value can be used, but
perhaps we misunderstand the standard.

Before we ventured down this path, we did a survey of the contents of
include/linux looking for enumerated constants that contain either of
the following two idioms:

NAME = (1 << N)

or

NAME = BIT(N)

There are a total of 68 such files, with the following notable
examples:

ata.h           bio.h           blk-integrity.h         blk-mq.h
blkdev.h        bpf.f           btf.h                   cacheinfo.h
cgroup.h        console.h       fs.h                    io.h
io-pgtable.h    iocontext.h     ioport.h                irq.h
irqdomain.h     irqreturn.h     libata.h                memcontrol.h
migrate.h       mm.h            mm_types.h              mmzone.h
skbuff.h        tcp.h           tpm.h                   workqueue.h

We would be interested in understanding why our use of this pattern
would be inconsistent with existing uses.

> > +
> > +/**
> > + * enum tsem_inode_state - Ordinal value for inode reference state.
> > + * @TSEM_INODE_COLLECTING: This ordinal value indicates that the inode
> > + *                    is being opened in order to compute the
> > + *                    digest of the file.
> > + * @TSEM_INODE_COLLECTED: This ordinal value indicates that the digest
> > + *                   file for the contents of the file referenced
> > + *                   by the inode has been collected and is
> > + *                   available in the digest cache attached to
> > + *                   the inode.
> > + * @TSEM_INODE_CONTROL_PLANE: The associated inode represents a TSEM
> > + *                        control plane file that should be
> > + *                       bypassed for security tests such as
> > + *                       the TSEM_FILE_OPEN event.
> > + *
> > + * This enumeration type is used to specify the status of the inode.
> > + * The primary purpose of this enumeration is so that the recursive
> > + * call to the TSEM_FILE_OPEN hook, caused by the kernel opening the
> > + * file to compute the checksum, can be bypassed when the digest
> > + * value of the file is being computed for inclusion in an event
> > + * description.
> > + *
> > + * The state value of the inode is carried in struct tsem_inode and is
> > + * set and interrogated by the event.c:add_file_digest() function.  If
> > + * the status of the inode is TSEM_INODE_COLLECTED and the iversion of
> > + * the inode is the same as it was at collection time, the cached
> > + * value for the currently active namespace digest function is
> > + * returned.
> > + *
> > + * If the test for the relevancy of the cached digest value fails the
> > + * status of the inode is set to TSEM_INODE_COLLECTING.  The
> > + * tsem_file_open() function will check the inode status when it is
> > + * invoked by the integrity_kernel_read() function and if it is
> > + * set to 'COLLECTING', a successful permissions check is returned so
> > + * that the kernel can open the file and compute its digest.
> > + *
> > + * The TSEM_INODE_CONTROL_PLANE value is used to indicate that the
> > + * attached inode is part of the TSEM control plane.  This allows
> > + * security events referencing this inode to bypass event processing
> > + * in order to avoid a 'Heisenberg deadlock' situation.
> > + */
> > +enum tsem_inode_state {
> > +   TSEM_INODE_COLLECTING = 1,
> > +   TSEM_INODE_COLLECTED,
> > +   TSEM_INODE_CONTROL_PLANE
> > +};
> > +
> > +/**
> > + * struct tsem_task - TSEM task control structure.
> > + * @tma_for_ns: The context identity number of the namespace that
> > + *         the task has control over if any.
> > + * @instance: The instance number of the task.  The global task
> > + *       instance number is incremented each time the
> > + *       bprm_committed_creds handler is invoked to compute the
> > + *       TASK_ID of a process.   This instance number represents
> > + *       the total number of unique instances of a specific body
> > + *       of executable code has been requested.
> > + * @p_instance: The instance number of the parent process to the
> > + *         process represented by an instance of this structure.
> > + *         This value allows an execution heirarchy of executable
> > + *         code to be established.
> > + * @trust_status: The enumeration type that specifies the trust state of
> > + *           the process.
> > + * @task_id: The TSEM task identity (TASK_ID) of the process.
> > + * @p_task_id: The TASK_ID of the parent process to the process
> > + *        represented by an instance of this structure.
> > + * @task_key: A security model specific digest value that is used to
> > + *       authenticate a task that is running as a trust
> > + *       orchestrator to a task that is under the control of the
> > + *       orchestrator.
> > + * @context: A pointer to the tsem_context structure that defines the
> > + *      modeling context that the task is running under.
> > +
> > + * This structure is represents the TSEM security state of a task.  It
> > + * is automatically created when the task control structure is
> > + * allocated for the creation of a new task.
> > + *
> > + * The trust_status member of structure determines whether or not the
> > + * task is in a condition to be trusted.  It represents whether or not
> > + * the task has requested execution of a security event that is
> > + * inconsistent with the security model that the task is running
> > + * under.  Reference the tsem_trust_status enumeration type for more
> > + * information on this member.  The trust status value is propagated
> > + * to any child tasks that are spawned from a task.
> > + *
> > + * The value of task_id member is generated by the
> > + * tsem_bprm_committed_creds() function that computes the task
> > + * identity based TSEM TASK_ID generative function.  This task_id
> > + * value is used in the computation of the security state point values
> > + * in combination with the COE and CELL mappings for this event.
> > + * The task_id digest creates security state points that are specific
> > + * to the executable code that was used to initiate the task.
> > + *
> > + * The instance member of the structure is used to temporally
> > + * disambiguate instances of the same task_id.  A single 64-bit
> > + * counter is used to generate the instance.  This counter is
> > + * incremented and assigned to the instance member of the structure
> > + * at the same tame the TASK_ID value is computed.
> > + *
> > + * The task_key member holds the authentication key that will be used
> > + * to authenticate a process that is requesting the ability to set the
> > + * trust status of a process.  This value is generated for the task
> > + * structure of the trust orchestrator when a security modeling
> > + * namespace is created by the orchestrator.
> > + *
> > + * The context member of the structure contains a pointer to the
> > + * tsem_context structure allocated when a security modeling namespace
> > + * is created by the tsem_ns_create() function.  This structure will
> > + * contain all of the information needed to define how the task is to
> > + * have its security behavior modeled.
> > + */
> > +struct tsem_task {
> > +   u64 tma_for_ns;
> > +   u64 instance;
> > +   u64 p_instance;
> > +   enum tsem_task_trust trust_status;
> > +   u8 task_id[HASH_MAX_DIGESTSIZE];
> > +   u8 p_task_id[HASH_MAX_DIGESTSIZE];
> > +   u8 task_key[HASH_MAX_DIGESTSIZE];
> > +   struct tsem_context *context;
> > +};
> > +
> > +/**
> > + * struct tsem_context - TSEM modeling context description.
> > + * @kref: Reference count for the context.
> > + * @work: Work structure for asynchronous release of the context.
> > + * @id: The index number of the context.
> > + * @sealed: A status variable indicating whether or not the
> > + *     modeling context can be modified.
> > + * @use_current_ns: Status variable indicating which user namespace
> > + *             should be used for resolution of uid/gid values.
> > + *             A true value indicates that the user namespace
> > + *             the process is running under should be used.
> > + * @actions: An array of enum tsem_action_type variables indicating
> > + *      the type of response that should be returned in
> > + *      response to the modeling of a security event that
> > + *      is inconsistent with the model being used for the
> > + *      security context.
> > + * @digestname: A pointer to a null-terminated buffer containing the
> > + *         name of the digest function that is to be used for
> > + *         this security context.
> > + * @zero_digest: The digest value for a 'zero-length' digest value.
> > + * @tfm: A pointer to the digest transformation structure that is to
> > + *  generate cryptographic checksums for the modeling context.
> > + * @inode_mutex: The lock that protects the inode_list that tracks
> > + *          inodes created in the context of a security modeling
> > + *          namespace.
> > + * @inode_list: The list of inodes created in a security modeling
> > + *         namespace protected by the inode_mutex member of
> > + *         this structure.
> > + * @magazine_size: The number of struct tsem_event structures that
> > + *            are held in reserve for security event handlers that
> > + *            are called in atomic context.
> > + * @magazine_lock: The spinlock that protects access to the event
> > + *            magazine.
> > + * @magazine_index: The bitmap that is used to track the magazine slots
> > + *             that have been allocated.
> > + * @ws: An array of work structures that are used to refill the event
> > + * magazine slots.
> > + * @magazine: An array of pointers to tsem_event structures that are
> > + *       pre-allocated for security handlers that are called in
> > + *       atomic context.
> > + * @model: If the modeling context is implemented with a kernel based
> > + *    trusted model agent this pointer will point to the struct
> > + *    tsem_model structure that maintains the state of the
> > + *    security model.
> > + * @external: If the modeling context is implemented with an external
> > + *       modeling agent this pointer will point to the
> > + *       tsem_external structure that implements the interface to
> > + *            the trust orchestrator that is managing the security
> > + *       modeling namespace represented by this structure.
> > + *
> > + * This structure is used to represent the state of a TSEM security
> > + * modeling namespace.  A pointer to this structure is stored in the
> > + * struct tsem_task structure.
> > + *
> > + * This structure is allocated by the tsem_ns_create() function in
> > + * response to a TSEM control request.  This structure maintains all
> > + * of the information that describes the security modeling namespace
> > + * that is not specific to the type of namespace, ie. external or
> > + * internal that is being implemented.
> > + *
> > + * The id member is a 64-bit counter that cannot feasibly be
> > + * overflowed and that is incremented for each namespace that is
> > + * created.  The root modeling namespace has a value of zero so the
> > + * TSEM code uses a pattern of testing this value for non-zero status
> > + * as an indication of whether or not the task is running in a
> > + * subordinate modeling namespace.
> > + *
> > + * Each security modeling namespace can have an independent
> > + * cryptographic digest function that is used as the compression
> > + * function for generating the security coefficients, and other
> > + * entities, that are used to model security events that occur in a
> > + * namespace.  A single struct tfm is allocated for this digest
> > + * function at the time that the tsem_context structure is created and
> > + * is maintained in this structure for subsequent use during event
> > + * processing.
> > + *
> > + * Each cryptographic digest function has a 'zero message' value that
> > + * is the result of the initialization and closure of a hash function
> > + * that has no other input.  This zero digest value is computed at the
> > + * time of the creation of the array.  This digest value is returned
> > + * for files with zero sizes, have pseudonyms declared for them or
> > + * that reside on pseudo-filesystems.
> > +
> > + * The actions array contains a specification of how each security
> > + * event should be handled in the event that a TMA detects a
> > + * security event inconsistent with the model designated for the
> > + * security modeling namespace.  This array allows the specification
> > + * of whether the events should be enforcing or logging.
> > + *
> > + * Each security event that is processed requires a struct tsem_event
> > + * structure that drives either the internal modeling of an event or
> > + * its export to an external modeling agent.  Some security event
> > + * hooks are called while a task is running in atomic context. Since
> > + * memory cannot be allocated while a process is in atomic context, a
> > + * magazine of these structures is maintained by this structure for
> > + * security events that run in atomic context.  The size of this
> > + * magazine is dynamic and is configurable for each security modeling
> > + *
> > + * When a tsem_event structure is allocated for an atomic event a
> > + * request for the refill of the slot that is vacated is dispatched to
> > + * an asynchronous workqueue.  The ws member of this structure points
> > + * to an array of work structures for this refill capability, one for
> > + * each slot in the magazine.
> > + *
> > + * All of this infrastructure is generic for each security modeling
> > + * namespace.  How the security modeling is done is governed by the
> > + * model and externally defined members of this structure.  These
> > + * members point to data structures that either maintain the security
> > + * model state for an in kernel trusted modeling agent or handle the
> > + * export of the event to an external trust orchestrator.
> > + *
> > + * Each task that is created in a non-root security modeling namespace
> > + * increments the reference count maintained in the kref member of
> > + * this structure in the tsem_task_alloc() function.  The
> > + * tsem_task_free() function decrements this reference count.  When
> > + * the reference count expires, ie. when the last task using the
> > + * modeling namespace exits, an asynchronous workqueue request is
> > + * dispatched to dispose of the context.  The work member of this
> > + * structure is used to reference that workqueue.
> > + */
> > +struct tsem_context {
> > +   struct kref kref;
> > +   struct work_struct work;
> > +
> > +   u64 id;
> > +   bool sealed;
> > +   bool use_current_ns;
> > +
> > +   enum tsem_action_type actions[TSEM_EVENT_CNT];
> > +
> > +   char *digestname;
> > +   u8 zero_digest[HASH_MAX_DIGESTSIZE];
> > +   struct crypto_shash *tfm;
> > +
> > +   struct mutex inode_mutex;
> > +   struct list_head inode_list;
> > +
> > +   unsigned int magazine_size;
> > +   spinlock_t magazine_lock;
> > +   unsigned long *magazine_index;
> > +   struct tsem_work *ws;
> > +   struct tsem_event **magazine;
> > +
> > +   struct tsem_model *model;
> > +   struct tsem_external *external;
> > +};

> I'm concerned about the number of locks you're maintaining.  I'm far
> from the world's expert on locking, but I see a whole lot of
> potential for contention and conflict with existing inode locking.

As devotees of Wolfgang Amadeus Mozart, we would argue that there are
just as many locks as are required... :-)

If needed, we could write at length with respect to our locking
philosophy, but in general we follow a standard of using a lock to
protect each list that is implemented.

In the case of the atomic allocation magazines, we use a spinlock on
the magazine index, failure to do so results in memory corruption and
a blizzard of null pointer de-reference traps.

The tsem_model structure, documented below, does contain a number of
locks specific to the lists that describe the security state of a
model.  We use a spinlock to protect those lists and transition the
spinlock to a mutex to limit the list traversal length.  Those list
traversals are only accessed by the trust orchestrator controlling the
namespace to extract the security characteristics of the model being
implemented, certainly not a system level hot path.

If you have any specific examples of excessively hot paths we would
review the handling of those.

> > +
> > +/**
> > + * struct tsem_model - TSEM internal TMA description.
> > + * @have_aggregate: Flag variable to indicate whether or not the
> > + *             hardware aggregate value has been injected into
> > + *             the model.
> > + * @base: The base value that is to be used in computing the
> > + *   security state coefficients for the model.
> > + * @measurement: The time dependent linear extension state of the
> > + *          security state coefficients that have been
> > + *          experienced in the model.
> > + * @state: The time independent functional description of the security
> > + *    model.
> > + * @point_lock: The spinlock that protects access to the list of
> > + *         security state coefficients in the model.
> > + * @point_list: A pointer to the list of security state coefficients
> > + *         in the model protected by the point_lock.
> > + * @point_end_mutex: The mutex that is used to protect the end of the
> > + *              list of security state coefficients that will
> > + *              be exported.
> > + * @point_end: A pointer to the end of the list of security state
> > + *        coefficients that will be traversed by a call to the
> > + *        control plane.
> > + * @trajectory_lock: The spinlock used to protect the list of security
> > + *              event descriptions in the model.
> > + * @trajectory_list: A pointer to the list of descriptions of the
> > + *              security events that have been recorded in this
> > + *              model.
> > + * @trajectory_end_mutex: The mutex that protects the end of the list
> > + *                   of security event descriptions.
> > + * @trajectory_end: A pointer to the end of the list of security event
> > + *             descriptions that will be traversed by a call to
> > + *             the control plane.
> > + * @forensics_lock: The spinlock used to protect the list of security
> > + *             event descriptions that are considered invalid by
> > + *             the model being enforced.
> > + * @forensics_list: A pointer to the list of descriptions of security
> > + *             events that are considered invalid by the security
> > + *             model being enforced.
> > + * @forensics_end_mutex: The mutex that protects the end of the list
> > + *                  of security event descriptions that are
> > + *                  considered invalid by the current model.
> > + * @forensics_end: A pointer to the end of the list of security event
> > + *            descriptions, that are considered invalid, that are
> > + *            to be traversed by a call to the control plane.
> > + * @pseudonym_mutex: The mutex lock that protects the list of file
> > + *              digest pseudonyms for the current model.
> > + * @pseudonum_list: A pointer to the list of file digest pseudonyms
> > + *             that have been declared for the current model.
> > + * @magazine_size: The number of struct tsem_event_point structures that
> > + *            are held in reserve for security event hooks that
> > + *            are called in atomic context.
> > + * @magazine_lock: The spinlock that protects access to the event
> > + *            magazine for the security context.
> > + * @magazine_index: The bitmap that is used to track the magazine slots
> > + *             that have been allocated.
> > + * @ws: An array of work structures that are used to refill the magazine
> > + * slots.
> > + * @magazine: An array of pointers to struct tsem_event_point structures that
> > + *       are pre-allocated for security hooks called in atomic
> > + *       context.
> > + *
> > + * If a call to the tsem_ns_create() function specifies that a kernel
> > + * based trusted modeling agent is to be used to implement the
> > + * security namespace model, a pointer to this structure is placed in
> > + * the struct tsem_context structure.  This structure is used to
> > + * maintain the state of the kernel based model.
> > + *
> > + * There are two primary functional values that are maintained by the
> > + * model.  The measurement member of this structure represents the
> > + * time dependent linear extension sum of the security state
> > + * coefficients that have been assigned to security events that have
> > + * occurred in the context of the model.  This is a measurement
> > + * that has been classically maintained by a Trusted Platform Module.
> > + *
> > + * This classic integrity measurement is subject to scheduling
> > + * dependencies and may be invariant from run to run of the model.  It
> > + * is of primary use in verifying the order of security events that
> > + * have occurred in the model.
> > + *
> > + * The state member of this structure represents a time independent
> > + * linear extension sum of the security state coefficients that have
> > + * been generated in the model.  It represents a functional value
> > + * for the security state of the model being enforced.
> > + *
> > + * Both of these measurements are dependent on the platform hardware
> > + * aggregate value and the base point that has been defined for the
> > + * define.
> > + *
> > + * A non-NULL representation of the hardware aggregate value is only
> > + * available if the platform has a TPM.  The have_aggregate member of
> > + * this structure is a flag variable that indicates whether or not the
> > + * aggregate value has been injected into the model.
> > + *
> > + * The base member of this structure contains a model specific
> > + * coefficient that is used to perturb each security state coefficient
> > + * generated in the model.  This value is designed to serve as a
> > + * 'freshness' value for a verifying party to the model.
> > + *
> > + * There are three primary model lists maintain by this structure:
> > + *
> > + * * security state points
> > + * * security trajectory events
> > + * * security forensics events
> > + *
> > + * Similar members are maintained in this structure to support each of
> > + * these lists.
> > + *
> > + * All three lists are extension only and are protected by a spinlock
> > + * that can be held in atomic context.  This spinlock is only held for
> > + * the period of time required to extend the list.
> > + *
> > + * Calls by the control plane to interrogate the lists require the
> > + * traversal of the list that is ill-suited for a spinlock.  As a
> > + * result each list type has a mutex associated with it that protects
> > + * a pointer to the end of the list, an endpoint that is determined at
> > + * the start of a call to the control plane.
> > + *
> > + * The list spinlock is used at the start of the control plane call to
> > + * capture the end of the list that is then protected by the mutex.
> > + * In essence this is used to transition protection of the list from
> > + * the spinlock to the mutex.
> > + *
> > + * The kernel based modeling agent has support for maintaining a
> > + * constant digest value for files, that by function, do not have a
> > + * fixed digest value, such as log files or files residing on a
> > + * pseudo-filesystem.  The pseudonym_list member of this structure
> > + * points to the list of these designations.  The pseudonym_mutex
> > + * structure protects this list.
> > + *
> > + * Like the struct tsem_context structure the tsem_model structure
> > + * maintains a magazine of structures that are used to service
> > + * security events that are called in atomic context.  The magazine
> > + * maintained by this structure is a list of struct tsem_event_point
> > + * structures that are used to describe the security state
> > + * coefficients held by the model.
> > + *
> > + * The description of struct tsem_context details the implementation
> > + * of the magazine which is identical to the implementation for this
> > + * structure, with the exception of the type of structures that are
> > + * held in reserve.
> > + */
> > +struct tsem_model {
> > +   bool have_aggregate;
> > +
> > +   u8 base[HASH_MAX_DIGESTSIZE];
> > +   u8 measurement[HASH_MAX_DIGESTSIZE];
> > +   u8 state[HASH_MAX_DIGESTSIZE];
> > +
> > +   spinlock_t point_lock;
> > +   struct list_head point_list;
> > +   struct mutex point_end_mutex;
> > +   struct list_head *point_end;
> > +   unsigned int point_count;
> > +
> > +   spinlock_t trajectory_lock;
> > +   struct list_head trajectory_list;
> > +   struct mutex trajectory_end_mutex;
> > +   struct list_head *trajectory_end;
> > +
> > +   spinlock_t forensics_lock;
> > +   struct list_head forensics_list;
> > +   struct mutex forensics_end_mutex;
> > +   struct list_head *forensics_end;
> > +
> > +   struct mutex pseudonym_mutex;
> > +   struct list_head pseudonym_list;
> > +
> > +   struct mutex mount_mutex;
> > +   struct list_head mount_list;
> > +
> > +   unsigned int magazine_size;
> > +   spinlock_t magazine_lock;
> > +   unsigned long *magazine_index;
> > +   struct tsem_work *ws;
> > +   struct tsem_event_point **magazine;
> > +};
> > +
> > +/**
> > + * struct tsem_external - TSEM external TMA description.
> > + * @export_only: A flag variable used to indicate that the security
> > + *          namespace is running in export only mode that
> > + *          simply presents the events to the external trust
> > + *          orchestrator.
> > + * @export_lock: The spinlock that protects access to the export_list
> > + *          member of this structure.
> > + * @export_list: A pointer to the list of events waiting to be
> > + *          exported to the trust orchestrator for the security
> > + *          modeling namespace.  The structure type that is
> > + *          linked by this list is the struct export_event
> > + *          structure that is private to the export.c compilation
> > + *          unit.
> > + * @dentry: A pointer to the dentry describing the pseudo-file in the
> > + *     /sys/kernel/security/tsem/external_tma directory that is
> > + *     being used to export security event descriptions to the
> > + *     external trust orchestrator for the security modeling
> > + *     namespace.
> > + * @have_event: A flag variable to indicate that is work queued
> > + *         on the export pseudo-file for the security modeling
> > + *         namespace.
> > + * @wq: The work queue used to implement polling for the security
> > + * event export file.
> > + * @magazine_size: The number of struct export_event structures that
> > + *            are held in reserve for security event hooks that
> > + *            are called in atomic context.
> > + * @magazine_lock: The spinlock that protects access to the event
> > + *            magazine for the security modeling domain.
> > + * @magazine_index: The bitmap that is used to track the magazine slots
> > + *             that have been allocated.
> > + * @ws: An array of work structures that are used to refill the magazine
> > + * slots.
> > + * @magazine: An array of pointers to struct export_event structures that
> > + *       are pre-allocated for security hooks called in atomic
> > + *       context.
> > + *
> > + * If an externally modeled security modeling namespace is created
> > + * a structure of this type is allocated for the namespace and placed
> > + * in the struct tsem_context structure.
> > + *
> > + * The primary purpose of this structure is to manage event
> > + * descriptions that are being transmitted to the trust orchestrator
> > + * associated with the security modeling namespace.  The pseudo-file
> > + * will be as follows:
> > + *
> > + * /sys/kernel/security/tsem/external_tma/N
> > + *
> > + * Where N is the context id number of the modeling namespace.
> > + *
> > + * The dentry member of this structure is used to represent the
> > + * pseudo-file that is created when the external modeled namespace is
> > + * created.
> > + *
> > + * This list of events waiting to be received by the trust
> > + * orchestrator is maintained in the export_list member of this
> > + * structure.  Additions or removals from the list hold the spinlock
> > + * described by the export_lock member of this structure.
> > + *
> > + * The wq member of this structure is used to implement a workqueue
> > + * to support polling for events on the export control file.  The
> > + * have_event flag is set to indicate to the polling call that
> > + * security events are available for export.
> > + *
> > + * When a security event description is exported the calling task is
> > + * scheduled away to allow the trust orchestrator to process the
> > + * event.  This obviously creates issues for security events that are
> > + * called in atomic context.
> > + *
> > + * Security events in atomic context are exported as an async_event
> > + * rather than a simple event.  The trust orchestrator has the option
> > + * of killing the workload that deviated from the security model or
> > + * signaling a violation of the model.
> > + *
> > + * To support the export of asynchronous events, magazine
> > + * infrastructure, similar to the event and model structure magazines,
> > + * is maintained by this structure for the external modeling
> > + * namespace.
> > + */
> > +struct tsem_external {
> > +   bool export_only;
> > +
> > +   spinlock_t export_lock;
> > +   struct list_head export_list;
> > +   struct dentry *dentry;
> > +   bool have_event;
> > +   wait_queue_head_t wq;
> > +
> > +   unsigned int magazine_size;
> > +   spinlock_t magazine_lock;
> > +   unsigned long *magazine_index;
> > +   struct tsem_work *ws;
> > +   struct export_event **magazine;
> > +};
> > +
> > +/**
> > + * struct tsem_work - TSEM magazine refill work structure.
> > + * @index: The index number of the slot in the structure magazine that
> > + *    is being refilled.
> > + * @u: A union that holds pointers to the structure whose magazine is
> > + *     being refilled.
> > + * @work: The work structure that manages the workqueue being used to
> > + *   refill the magazine entry.
> > + *
> > + * As has been previously documented for the struct tsem_context,
> > + * struct tsem_model and struct tsem_external structures, there is a
> > + * need to maintain a magazine of these structures in order to allow
> > + * the processing of security events that are called in atomic
> > + * context.  An array of this structure type is embedded in each of
> > + * those structures to manage the asynchronous refill of the slot in
> > + * the magazine that was used to handle an atomic security event.
> > + *
> > + * The index member of this structure points to the slot in the
> > + * magazine that this work item is referencing.
> > + *
> > + * The structure that the refill work is being done for is maintained
> > + * in the respective structure pointer in the u member of this
> > + * structure.
> > + *
> > + * The work member of this structure is used to reference the
> > + * asynchronous work request that is being submitted for the refill.
> > + */
> > +struct tsem_work {
> > +   unsigned int index;
> > +   union {
> > +           struct tsem_context *ctx;
> > +           struct tsem_model *model;
> > +           struct tsem_external *ext;
> > +   } u;
> > +   struct work_struct work;
> > +};
> > +
> > +/**
> > + * struct tsem_COE - TSEM context of execution definition structure.
> > + * @uid: The numeric user identity that the COE is running with.
> > + * @euid: The effective user identity that the COE is running with.
> > + * @suid: The saved user identity possessed by the COE.
> > + * @gid: The group identity that the COE is running with.
> > + * @egid: The effective group identity that the COE possesses.
> > + * @sgid: The saved group identity of the COE.
> > + * @fsuid: The filesystem user identity that the COE is running with.
> > + * @fsgid: The filesystem group identity that the COE is running with.
> > + * @capeff: This union is used to implement access to the effective
> > + *     capability set the COE is running with.  The mask value
> > + *     is used to assign to the structure with the value member
> > + *     used to extract the 64 bit value for export and
> > + *     computation.
> > + * @securebits: In a file capabilities implementation this value
> > + *         specifies potential handling for process running with
> > + *         a UID value of 0.
> > + *
> > + * A security state coefficient is computed from two primary entities:
> > + * the COE and the CELL identities.  This structure is used to carry
> > + * and encapsulate the characteristics of the context of execution
> > + * (COE) that will be used to generate the COE identity.
> > + *
> > + * The numeric values for discretionary access controls, ie. uid, gid,
> > + * are determined by which user namespace the security modeling
> > + * namespace is configured to reference.  The reference will be either
> > + * the initial user namespace or the user namespace that the context
> > + * of execution is running in.  This reference can be set on a per
> > + * security model namespace basis.
> > + */
> > +struct tsem_COE {
> > +   uid_t uid;
> > +   uid_t euid;
> > +   uid_t suid;
> > +
> > +   gid_t gid;
> > +   gid_t egid;
> > +   gid_t sgid;
> > +
> > +   uid_t fsuid;
> > +   gid_t fsgid;
> > +
> > +   union {
> > +           kernel_cap_t mask;
> > +           u64 value;
> > +   } capeff;
> > +
> > +   unsigned int securebits;
> > +};

> Why do you need this? Can't you use a cred pointer instead?

Referring to our comments at the start of the review, there is no
guarantee that the structure backing the cred pointer is going to be
around after the event is experienced.

Consider a security modeling namespace that may have hundreds of
processes that come and go.  Each process that ends up generating a
unique security state coefficient has a set of credentials that needs
to be maintained after the process terminates.

Using a dedicated structure to hold the security relevant credential
characteristics provides a 76% efficiency increase in consumed memory
for each credential representation over the use of a standard
credential structure for retention.

> > +
> > +/**
> > + * struct tsem_inode_cell - TSEM inode information.
> > + * @uid: The numeric user identity assigned to the inode.
> > + * @gid: The numeric group identity assigned to the inode.
> > + * @mode: The discretionary access mode for the file.
> > + * @s_magic: The magic number of the filesystem that the file resides
> > + *      in.
> > + * @s_id: The name of the block device supporting the filesystem the
> > + *   inode is on.
> > + * @s_uuid: The uuid of the filesystem that contains the inode.
> > + *
> > + * This structure defines the characteristics of an inode that is
> > + * referenced by a security event.
> > + */
> > +struct tsem_inode_cell {
> > +   uid_t uid;
> > +   gid_t gid;
> > +   umode_t mode;
> > +   u32 s_magic;
> > +   u8 s_id[32];
> > +   u8 s_uuid[16];
> > +};

> ... and can't you use inode/file pointers?

Again, we would have to pin the inodes or file references just for the
purposes of TSEM.

TSEM enjoys a 95% savings, per inode, through the use of an
independent representation of the security relevant characteristics of
an inode.  Our entire security event description structure is 23%
smaller than a kernel inode description structure.

The TSEM representation of the security state of a file is 47% smaller
than the native file description.

> > +
> > +/**
> > + * struct tsem_inode_entry - Reference to a directory inode with temp files.
> > + * @list: List of directory inodes for a security modeling namespace
> > + *   that have had an inode created under the directory.
> > + * @tsip: A pointer to the TSEM security description of a temporary
> > + *   file that was createdunder a directory entry.
> > + *
> > + * This structure is used to implement a list of directory inodes that
> > + * have had temporary files created under them in a security modeling
> > + * namespace.  This list is used to allow the instance identifiers
> > + * for inodes to be removed when the security modeling namespace
> > + * terminates or when the directory in which temporary files had been
> > + * created is removed.
> > + */
> > +
> > +struct tsem_inode_entry {
> > +   struct list_head list;
> > +   struct tsem_inode *tsip;
> > +};
> > +
> > +/**
> > + * struct tsem_inode_instance - Instance information for a created inode.
> > + * @list: List of inode owners.
> > + * @creator: The id number of the security modeling namespace that is
> > + *      creating an inode.
> > + * @instance: The instance number of an inode being created under a
> > + *       given directory.
> > + * @owner: The TASK_ID of the process creating the inode.
> > + * @pathname: A pointer to allocated memory holding the null-terminated
> > + *       pathname for the inode.
> > + *
> > + * This structure is used to convey information about the owner and
> > + * instance number of an inode created in a security modeling namespace.
> > + *
> > + * This structure serves three distinct purposes.
> > + *
> > + * A linked list of these structures is used to convey ownership and
> > + * instance information about a created inode from the
> > + * tsem_inode_create() function to the tsem_inode_init_security()
> > + * function, so that this information can be attached to the inode via
> > + * the tsem_inode structure.
> > + *
> > + * Secondly, a linked list of inode ownership information is
> > + * maintained for inodes that are created in a security modeling
> > + * namespace and used as mountpoints.  This list is maintained in the
> > + * security model description for the namespace.  Since the inode that
> > + * is 'covering' the mountpoint is different than the inode describing
> > + * the directory created for the mountpoint, the ownership information
> > + * for the inode needs to carried as a characteristic of the model.
> > + *
> > + * The final use of this structure is to track the instance numbers of
> > + * an inode created by a TASK_ID.  This list is carried by the
> > + * directory in which temporary files and directories are created.
> > + *
> > + */
> > +struct tsem_inode_instance {
> > +   struct list_head list;
> > +
> > +   u64 creator;
> > +   u64 instance;
> > +   u8 owner[HASH_MAX_DIGESTSIZE];
> > +   char *pathname;
> > +};
> > +
> > +/**
> > + * struct tsem_path - TSEM path information.
> > + * @created: A flag to indicate that the path was created in the
> > + *      context of the current security modeling namespace.
> > + * @creator: The id of the security modeling namespace that created
> > + *      the path.
> > + * @instance: The instance number of an inode that was created.
> > + * @owner: The TASK_ID of the process that created the path.
> > + * @dev: The device number that the filesystem is mounted on.
> > + * @pathname: An allocated and null-terminated buffer containing the
> > + *       path from the root directory to the file.
> > + *
> > + * The tsem_path structure is used to carry information about the
> > + * pathname and ownership of a filesystem object that is an argument
> > + * to a security event handler.
> > + */
> > +struct tsem_path {
> > +   bool created;
> > +   u64 creator;
> > +   u64 instance;
> > +   u8 owner[HASH_MAX_DIGESTSIZE];
> > +
> > +   dev_t dev;
> > +   char *pathname;
> > +};
> > +
> > +/**
> > + * struct tsem_dentry - TSEM dentry definition.
> > + * @have_inode: A flag variable to indicate that the dentry has an
> > + *         inode associated with it.
> > + * @inode: The TSEM characteristics of the inode associated with a dentry.
> > + * @path: The path definition for the dentry.
> > + *
> > + * This structure is used to contain the TSEM representation of a
> > + * dentry.
> > + */
> > +struct tsem_dentry {
> > +   bool have_inode;
> > +   struct tsem_inode_cell inode;
> > +   struct tsem_path path;
> > +};
> > +
> > +/**
> > + * struct tsem_inode_args - Arguments for inode security handlers.
> > + * @mode: The access mode requested for an inode being created.
> > + * @dev: For the inode_mknod handler, the device specification for
> > + *  device node being created.
> > + * @in.old_name: In the case of the tsem_inode_symlink handler, this
> > + *          member contains a pointer to the filename of the target
> > + *          of the symbolic link.
> > + * @in.dir: For handlers processing rename or movement of an inode,
> > + *     the inode of the directory that contains the inode to be moved.
> > + * @in.new_dir: For handlers processing the rename or movement of an
> > + *         inode, the inode of the directory that will contain
> > + *         the destination inode.
> > + * @in.dentry: The dentry argument to inode event handlers that take
> > + *        a dentry.
> > + * @in.new_dentry: In the case of handlers that result in a new dentry
> > + *            a pointer to that dentry.
> > + * @out.old_name: In the case of the tsem_inode_symlink handler this
> > + *           member contains a pointer to a copy of the name of
> > + *           the target of symbolic link.  This second
> > + *           representation is used to avoid warnings about the
> > + *           use of a constant character pointer in the arguments
> > + *           to the handler.
> > + * @out.dir: The TSEM representation of the inode representing a directory
> > + *      that the security handler is acting on.
> > + * @out.new_dir: For inode movements or renames, the TSEM representation
> > + *          of the new_dir argument.
> > + * @out.dentry: The TSEM representation of the dentry argument to a
> > + *         security handler.
> > + * @out.new_dentry: For inode movements or renames, the
> > + *             representation of the new location of the inode.
> > + *
> > + * This structure is used to carry input parameters and their
> > + * retained and translated TSEM equivalent for LSM security handlers
> > + * that are acting on inodes and/or dentries.
> > + */
> > +struct tsem_inode_args {
> > +   umode_t mode;
> > +   dev_t dev;
> > +
> > +   union {
> > +           struct {
> > +                   const char *old_name;
> > +                   struct inode *dir;
> > +                   struct inode *new_dir;
> > +                   struct dentry *dentry;
> > +                   struct dentry *new_dentry;
> > +           } in;
> > +
> > +           struct {
> > +                   char *old_name;
> > +                   struct tsem_inode_cell dir;
> > +                   struct tsem_inode_cell new_dir;
> > +                   struct tsem_dentry dentry;
> > +                   struct tsem_dentry new_dentry;
> > +           } out;
> > +   };
> > +};
> > +
> > +/**
> > + * struct tsem_file_args - TSEM file argument description.
> > + * @cmd: The command argument for security handlers that take a
> > + *       command type arguement, ie. file_ioctl, file_fcntl, file_lock
> > + *  handlers.
> > + * @in.pseudo_file: A flag indicating that the file was on a
> > + *             pseudo-filesystem and will not have a digest value.
> > + * @in.file: A structure to the file that will be modeled.
> > + * @out.path: The TSEM representation of the pathname to a file.
> > + * @out.inode: The TSEM representation of the inode that backs a file
> > + *        description
> > + * @out.flags: The flags value from the file structure.
> > + * @out.digest: The cryptographic checksum of the contents of the file.
> > + *
> > + * This structure is used to carry the input file description and
> > + * their TSEM retention values for security event handles that are
> > + * provided with a struct file pointer.
> > + */
> > +struct tsem_file_args {
> > +   unsigned int cmd;
> > +
> > +   union {
> > +           struct {
> > +                   bool pseudo_file;
> > +                   struct file *file;
> > +           } in;
> > +
> > +           struct {
> > +                   struct tsem_path path;
> > +                   struct tsem_inode_cell inode;
> > +                   unsigned int flags;
> > +                   u8 digest[HASH_MAX_DIGESTSIZE];
> > +           } out;
> > +
> > +   };
> > +};
> > +
> > +/**
> > + * struct tsem_mmap_file_args - TSEM memory mapping arguments.
> > + * @anonymous: A flag variable to indicate whether or not the mapping
> > + *        is file backed or anonymous.
> > + * @file: If the handler is being called for a file backed mapping this
> > + *   structure will be populated with the TSEM description of the
> > + *   file.
> > + * @prot: The protections that are being requested for the mapping.
> > + * @flags: The control flags to the memory mapping call.
> > + *
> > + * This structure is used to encapsulate the arguments provided to the
> > + * tsem_mmap_file security event handler.  The anonymous member of
> > + * this structure is used internally by TSEM to indicate that the
> > + * file pointer to the call was NULL, thus indicating that the mapping
> > + * is for anonymous memory.
> > + */
> > +struct tsem_mmap_file_args {
> > +   u32 anonymous;
> > +   struct tsem_file_args file;
> > +   u32 prot;
> > +   u32 flags;
> > +};
> > +
> > +/**
> > + * struct tsem_socket - TSEM socket information
> > + * @family: The family name of the socket whose creation is being
> > + *     requested.
> > + * @type: The type of the socket being created.
> > + * @protocol: The protocol family of the socket being created.
> > + * @kern: A flag variable to indicate whether or not the socket being
> > + *   created is kernel or userspace based.
> > + * @owner: The TASK_ID of the task that created the socket.
> > + *
> > + * This structure is used to encapsulate socket information for
> > + * security handlers that take a socket description as an argument.
> > + */
> > +struct tsem_socket {
> > +   int family;
> > +   int type;
> > +   int protocol;
> > +   int kern;
> > +   u8 owner[HASH_MAX_DIGESTSIZE];
> > +};

> ... and for most of what you have here it looks like you're
> duplicating information you can point to.

Once again, only for the kernel operational lifetime of the data
structure.

In the example above, our socket description also retains the TASK_ID
of the process that generated the creation of the socket.  That
TASK_ID is particularly important with respect to forensically
identifying and tracking network behavior on a host.

[ unreviewed code trimmed ]

Please do not consider your concerns on memory usage lost.  They have
provoked a considerable amount of thought and discussion on our part
on how to diminish the memory footprint for internally modeled
namespaces.  At this point we would limit such changes to future
releases of TSEM.

Once again, thank you for your comments and observations.

As always,
Dr. Greg

   The Quixote Project - Flailing at the Travails of Cybersecurity
                  https://github.com/Quixote-Project

