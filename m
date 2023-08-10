Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED85776E44
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 04:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjHJC6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 22:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHJC6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 22:58:49 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 687D11704;
        Wed,  9 Aug 2023 19:58:47 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 37A2vvLH019794;
        Wed, 9 Aug 2023 21:57:57 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 37A2vuja019793;
        Wed, 9 Aug 2023 21:57:56 -0500
Date:   Wed, 9 Aug 2023 21:57:56 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH 04/13] Add TSEM master header file.
Message-ID: <20230810025755.GA19781@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com> <20230710102319.19716-5-greg@enjellic.com> <77075160-cee8-8eb2-ca0a-c0db53db3800@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77075160-cee8-8eb2-ca0a-c0db53db3800@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 09 Aug 2023 21:57:57 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 01:39:22PM -0700, Casey Schaufler wrote:

Hi Casey, thank you for the review comments.

> On 7/10/2023 3:23 AM, Dr. Greg wrote:
> > TSEM is designed, from a functional perspective, to be contained
> > entirely in its own directory.
> >
> > The tsem.h header file defines the enumeration types, structure
> > definitions and externally visiable functions that are referenced
> > by all of the compilation units of the TSEM LSM implementation in
> > that directory.

> Extensive documentation notwithstanding, it's impossible to review
> the data structures and constants without the code that goes along
> with them.

Big picture, I couldn't resist passing along an actual quote from my
mentor in Computer Science and modeling theory.  An algebraic
topologist by training who had Robert Ellis once briefly convinced
that it could be proven that it was possible to comb the hair on a
coconut, who also did significant work in data structures:

	"If one carefully studies and understands the data structures
	acted upon, including a description of their character, role
	and importance; the code itself, upon simple examination,
	will speak clearly, eloquently and stridently with respect to
	its intent and purpose for existence."

:-)

We approached the patch series from the perspective of tsem.h being a
reference document for the compilation units.

The rules are pretty simple.  Any structure, variable or function with
a tsem_ prefix, in some form of appropriate capitalization, can be
found quickly in tsem.h, along with what we hope is a complete
description on how and why the entity is implemented.

We were somewhat influenced by SMACK that uses a single include file
for its globally visible state.

Other LSM's seem to use multiple include files, is that a preferred
approach?

The tsem_event structure is the poster child of the challenges
associated with the latter model.  It gets used by all eight compilation
units so its declaration is going to be isolated from its use in most
cases.

This model seems to inevitably come down to something like 'common.h'
which puts you sort of back to where things started.

We may have missed it but I don't see anything in the kernel
developers guide with respect best practices for introducing blocks of
entire sub-system code.

Recommendations welcome.

> > The structure and enumeration types are extensively documented
> > and are the recommended starting point for understanding TSEM
> > implementation and functionality.
> >
> > Signed-off-by: Greg Wettstein <greg@enjellic.com>
> > ---
> >  security/tsem/tsem.h | 1516 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 1516 insertions(+)
> >  create mode 100644 security/tsem/tsem.h
> >
> > diff --git a/security/tsem/tsem.h b/security/tsem/tsem.h
> > new file mode 100644
> > index 000000000000..03915f47529b
> > --- /dev/null
> > +++ b/security/tsem/tsem.h
> > @@ -0,0 +1,1516 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +/*
> > + * Copyright (C) 2023 Enjellic Systems Development, LLC
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
> > +#include <uapi/linux/in.h>
> > +#include <uapi/linux/in6.h>
> > +#include <linux/wait.h>
> > +#include <linux/kref.h>
> > +#include <linux/lsm_hooks.h>
> > +#include <linux/capability.h>
> > +#include <crypto/hash.h>
> > +#include <crypto/hash_info.h>
> > +#include <net/af_unix.h>
> > +
> > +/* The capability needed to manage TSEM. */
> > +#define TSEM_CONTROL_CAPABILITY CAP_ML

> Why would you do this? You gave the capability a name that even you
> don't want to use.

A simple placeholder that allows the capability used to control
security modeling to be set in one place, and one place only, until
the debate over the capability issue is settled.

We never envisioned this define lasting beyond the initial reviews.

> > +
> > +/*
> > + * The number of 'slots' in the structure magazines that are used to
> > + * satisfy modeling of security events that are called in atomic context.
> > + */
> > +#define TSEM_ROOT_MAGAZINE_SIZE	96
> > +#define TSEM_MAGAZINE_SIZE_INTERNAL 16
> > +#define TSEM_MAGAZINE_SIZE_EXTERNAL 96
> > +
> > +/**
> > + * enum tsem_event_type - Ordinal value for a security event.
> > + * @TSEM_BPRM_SET_CREDS: Ordinal value for bprm_creds_for_exec.
> > + * @TSEM_GENERIC_EVENT: Ordinal value for a generically modeled event.
> > + * @TSEM_TASK_KILL: Ordinal value for task kill.
> > + * @....: Remainder follows with a similar naming format that has
> > + *        TSEM_ prep ended to the raw LSM security hook name.
> > + * @TSEM_EVENT_CNT: The final ordinal value is used to define the
> > + *		    length of the following arrays that are indexed
> > + *		    by the ordinal value of the hook:
> > + *
> > + * This enumeration is used to designate an ordinal value for each
> > + * security event, ie. LSM hook, that TSEM is implementing modeling
> > + * for.  This value is used to identify the hook that is either having
> > + * its event description being exported to an external Trusted Modeling
> > + * Agent (TMA) or modeled by the internal TMA implementation.
> > + *
> > + * The primary use of this enumeration is to conditionalize code paths
> > + * based on the security hook being processed and to index the
> > + * tsem_names array and the array that defines the action that is to
> > + * be taken in response to an event that generates a permissions
> > + * violation.
> > + */
> > +enum tsem_event_type {
> > +	TSEM_BPRM_SET_CREDS = 1,
> > +	TSEM_GENERIC_EVENT,
> > +	TSEM_TASK_KILL,
> > +	TSEM_TASK_SETPGID,
> > +	TSEM_TASK_GETPGID,
> > +	TSEM_TASK_GETSID,
> > +	TSEM_TASK_SETNICE,
> > +	TSEM_TASK_SETIOPRIO,
> > +	TSEM_TASK_GETIOPRIO,
> > +	TSEM_TASK_PRLIMIT,
> > +	TSEM_TASK_SETRLIMIT,
> > +	TSEM_TASK_SETSCHEDULER,
> > +	TSEM_TASK_GETSCHEDULER,
> > +	TSEM_TASK_PRCTL,
> > +	TSEM_FILE_OPEN,
> > +	TSEM_MMAP_FILE,
> > +	TSEM_FILE_IOCTL,
> > +	TSEM_FILE_LOCK,
> > +	TSEM_FILE_FCNTL,
> > +	TSEM_FILE_RECEIVE,
> > +	TSEM_UNIX_STREAM_CONNECT,
> > +	TSEM_UNIX_MAY_SEND,
> > +	TSEM_SOCKET_CREATE,
> > +	TSEM_SOCKET_CONNECT,
> > +	TSEM_SOCKET_BIND,
> > +	TSEM_SOCKET_ACCEPT,
> > +	TSEM_SOCKET_LISTEN,
> > +	TSEM_SOCKET_SOCKETPAIR,
> > +	TSEM_SOCKET_SENDMSG,
> > +	TSEM_SOCKET_RECVMSG,
> > +	TSEM_SOCKET_GETSOCKNAME,
> > +	TSEM_SOCKET_GETPEERNAME,
> > +	TSEM_SOCKET_SETSOCKOPT,
> > +	TSEM_SOCKET_SHUTDOWN,
> > +	TSEM_PTRACE_TRACEME,
> > +	TSEM_KERNEL_MODULE_REQUEST,
> > +	TSEM_KERNEL_LOAD_DATA,
> > +	TSEM_KERNEL_READ_FILE,
> > +	TSEM_SB_MOUNT,
> > +	TSEM_SB_UMOUNT,
> > +	TSEM_SB_REMOUNT,
> > +	TSEM_SB_PIVOTROOT,
> > +	TSEM_SB_STATFS,
> > +	TSEM_MOVE_MOUNT,
> > +	TSEM_SHM_ASSOCIATE,
> > +	TSEM_SHM_SHMCTL,
> > +	TSEM_SHM_SHMAT,
> > +	TSEM_SEM_ASSOCIATE,
> > +	TSEM_SEM_SEMCTL,
> > +	TSEM_SEM_SEMOP,
> > +	TSEM_SYSLOG,
> > +	TSEM_SETTIME,
> > +	TSEM_QUOTACTL,
> > +	TSEM_QUOTA_ON,
> > +	TSEM_MSG_QUEUE_ASSOCIATE,
> > +	TSEM_MSG_QUEUE_MSGCTL,
> > +	TSEM_MSG_QUEUE_MSGSND,
> > +	TSEM_MSG_QUEUE_MSGRCV,
> > +	TSEM_IPC_PERMISSION,
> > +	TSEM_KEY_ALLOC,
> > +	TSEM_KEY_PERMISSION,
> > +	TSEM_NETLINK_SEND,
> > +	TSEM_INODE_CREATE,
> > +	TSEM_INODE_LINK,
> > +	TSEM_INODE_UNLINK,
> > +	TSEM_INODE_SYMLINK,
> > +	TSEM_INODE_MKDIR,
> > +	TSEM_INODE_RMDIR,
> > +	TSEM_INODE_MKNOD,
> > +	TSEM_INODE_RENAME,
> > +	TSEM_INODE_SETATTR,
> > +	TSEM_INODE_GETATTR,
> > +	TSEM_INODE_SETXATTR,
> > +	TSEM_INODE_GETXATTR,
> > +	TSEM_INODE_LISTXATTR,
> > +	TSEM_INODE_REMOVEXATTR,
> > +	TSEM_INODE_KILLPRIV,
> > +	TSEM_TUN_DEV_CREATE,
> > +	TSEM_TUN_DEV_ATTACH_QUEUE,
> > +	TSEM_TUN_DEV_ATTACH,
> > +	TSEM_TUN_DEV_OPEN,
> > +	TSEM_BPF,
> > +	TSEM_BPF_MAP,
> > +	TSEM_BPF_PROG,
> > +	TSEM_EVENT_CNT
> > +};
> > +
> > +/**
> > + * enum tsem_action_type - Ordinal value for security responses.
> > + * @TSEM_ACTION_LOG: Ordinal value to indicate that a security event
> > + *		     that results in a model permissions violation
> > + *		     should be logged.
> > + * @TSEM_ACTION_EPERM: Ordinal value to indicate that a security event
> > + *		       generating a model permissions violation should
> > + *		       return -EPERM to the caller.
> > + *
> > + * This enumeration type is used to designate what type of action is
> > + * to be taken when the processing of a security event hook results in
> > + * a model violation.  The TSEM_ACTION_LOG and TSEM_ACTION_EPERM
> > + * translate into the classical concepts of logging or enforcing
> > + * actions used by other mandatory access control architectures.
> > + */
> > +enum tsem_action_type {
> > +	TSEM_ACTION_LOG = 0,
> > +	TSEM_ACTION_EPERM,
> > +	TSEM_ACTION_CNT
> > +};
> > +
> > +/**
> > + * enum tsem_control_type - Ordinal values for TSEM control actions.
> > + * @TSEM_CONTROL_INTERNAL: This ordinal value is set when the first
> > + *			   word of an argument string written to the
> > + *			   control file is the word 'internal'.  This
> > + *			   designates that the security namespace will
> > + *			   be modeled by the internal TMA.
> > + * @TSEM_CONTROL_EXTERNAL: This ordinal value is set when the first
> > + *			   word of an argument string written to the
> > + *			   control file is the word 'external'.  This
> > + *			   designates that the security namespace will
> > + *			   be model by an external TMA.
> > + * @TSEM_CONTROL_ENFORCE: This ordinal value is set when the word
> > + *			  'enforce' is written to the control file.
> > + *			  This indicates that model is to be placed
> > + *			  in 'enforcing' mode and security events that
> > + *			  result in model violations will return EPERM.
> > + * @TSEM_CONTROL_SEAL: This ordinal value is set when the word 'seal'
> > + *		       is written to the control file.  This indicates
> > + *		       that the model for security domain will treat
> > + *		       all security events that do not conform to the
> > + *		       model as 'forensics' events.
> > + * @TSEM_CONTROL_TRUSTED: This ordinal value is used when the first
> > + *			  word of an argument string written to the
> > + *			  control file is the word 'trusted'.  This
> > + *			  is interpreted as a directive to set the
> > + *			  trust status of the task that executed the
> > + *			  security event to be trusted.
> > + * @TSEM_CONTROL_UNTRUSTED: This ordinal value is used when the first
> > + *			    word of an argument string written to the
> > + *			    control file is the word 'untrusted'.
> > + *			    This is interpreted as a directive to set
> > + *			    the trust status of the task that executed
> > + *			    the security event to be untrusted.
> > + * @TSEM_CONTROL_MAP_STATE: This ordinal value is used when the first
> > + *			    word of an argument string written to the
> > + *			    control file is the word 'state'.  The
> > + *			    argument to this directive will be an
> > + *			    ASCII hexadecimally encoded string of the
> > + *			    current model's digest size that will be
> > + *			    treated as a security state point for
> > + *			    inclusion in the security model for the
> > + *			    security domain/namespace.
> > + * @TSEM_CONTROL_MAP_PSEUDONYM: This ordinal value is used when the
> > + *				first word of an argument string
> > + *				written to the control file is the
> > + *				word 'pseudonym'.  The argument to
> > + *				this directive will be an ASCII
> > + *				hexadecimally encoded string of the
> > + *				current model's digest size that will
> > + *				be treated as a pseudonym directive
> > + *				for the security domain/namespace.
> > + * TSEM_CONTROL_MAP_BASE: This ordinal value is used when the first
> > + *			  word of an argument string written to the
> > + *			  control file is the word 'base'.  The
> > + *			  argument to this directive will be an ASCII
> > + *			  hexadecimally encoded string of the current
> > + *			  model's digest size that will be treated as
> > + *			  the base value for the computation of the
> > + *			  functional values (measurement and state) of
> > + *			  the security domain/namespace.
> > +
> > + * This enumeration type is used to designate what type of control
> > + * action is to be implemented when arguments are written to the TSEM
> > + * control file (/sys/kernel/security/tsem/control).  The ordinal
> > + * values govern the processing of the command and the interpretation
> > + * of the rest of the command argument string.
> > + */
> > +enum tsem_control_type {
> > +	TSEM_CONTROL_INTERNAL = 0,
> > +	TSEM_CONTROL_EXTERNAL,
> > +	TSEM_CONTROL_ENFORCE,
> > +	TSEM_CONTROL_SEAL,
> > +	TSEM_CONTROL_TRUSTED,
> > +	TSEM_CONTROL_UNTRUSTED,
> > +	TSEM_CONTROL_MAP_STATE,
> > +	TSEM_CONTROL_MAP_PSEUDONYM,
> > +	TSEM_CONTROL_MAP_BASE
> > +};
> > +
> > +/**
> > + * enum tsem_ns_reference - Ordinal value for DAC namespace reference.
> > + * @TSEM_NS_INITIAL: This ordinal value indicates that the uid/gid
> > + *		     values should be interpreted against the initial
> > + *		     user namespace.
> > + * @TSEM_NS_CURRENT: This ordinal value indicates that the uid/gid
> > + *		     values should be interpreted against the user
> > + *		     namespace that is in effect for the process being
> > + *		     modeled.
> > + *
> > + * This enumeration type is used to indicate what user namespace
> > + * should be referenced when the uid/gid values are interpreted for
> > + * the creation of either the COE or CELL identities.  The enumeration
> > + * ordinal passed to the tsem_ns_create() function, to configure the
> > + * security domain/namespace, is set by the nsref argument to either
> > + * the 'internal' or 'external' control commands.
> > + */
> > +enum tsem_ns_reference {
> > +	TSEM_NS_INITIAL = 1,
> > +	TSEM_NS_CURRENT
> > +};
> > +
> > +/**
> > + * enum tsem_task_trust - Ordinal value describing task trust status.
> > + * @TSEM_TASK_TRUSTED: This ordinal value indicates that the task has
> > + *		       not executed a security event that has resulted
> > + *		       in a security behavior not described by the
> > + *		       security model the task is being governed by.
> > + * @TSEM_TASK_UNTRUSTED: This ordinal value indicates that the task
> > + *		          has requested the execution of a security event
> > + *		          that resulted in a security behavior not
> > + *		          permitted by the security model the task is
> > + *		          being governed by.
> > + * @TSEM_TASK_TRUST_PENDING: This ordinal value indicates that the setting
> > + *			     of the task trust status is pending a response
> > + *		             from an external TMA.
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
> > +	TSEM_TASK_TRUSTED = 1,
> > +	TSEM_TASK_UNTRUSTED = 2,
> > +	TSEM_TASK_TRUST_PENDING = 4

> What happened to 3?

The enumerations represent bit values used in the 'trust_status'
member of the tsem_task structure.

If a task thinks that it has a trust status value of three it would
indicate the task needs massive doses of chlorpromazine.

> > +};
> > +
> > +/**
> > + * enum tsem_inode_state - Ordinal value for inode reference state.
> > + * @TSEM_INODE_COLLECTING: This ordinal value indicates that the uid/gid
> > + *			   values should be interpreted against the initial
> > + *			   user namespace.
> > + * @TSEM_INODE_COLLECTED: This ordinal value indicates that the uid/gid
> > + *			  values should be interpreted against the user
> > + *			  namespace that is in effect for the process being
> > + *		          modeled.
> > + *
> > + * This enumeration type is used to specify the status of the inode
> > + * that is having a digest value computed on the file that it is
> > + * referencing.  The purpose of this enumeration is so that the
> > + * recursive call to the TSEM_FILE_OPEN hook, caused by the kernel
> > + * opening the file to compute the checksum, can be bypassed.
> > + *
> > + * The state value of the inode is carried in struct tsem_inode and is
> > + * set and interrogated by the add_file_digest() function.  If the
> > + * status of the inode is TSEM_INODE_COLLECTED and the iversion of the
> > + * inode is the same as the collection time, the cached value for
> > + * currently active model digest is returned.
> > +
> > + * If the test for the relevancy of the cached digest value fails the
> > + * status of the inode is set to TSEM_INODE_COLLECTING.  The
> > + * tsem_file_open() function will check the inode status when it is
> > + * invoked by the integrity_kernel_read() function and if it is
> > + * set to 'collecting', a successful permissions check is returned so
> > + * that the kernel can open the file and compute its digest.
> > + */
> > +enum tsem_inode_state {
> > +	TSEM_INODE_COLLECTING = 1,
> > +	TSEM_INODE_COLLECTED
> > +};
> > +
> > +/**
> > + * struct tsem_task - TSEM task control structure.
> > + * @tma_for_ns: The context identity number of the namespace that
> > + *		the task has control over if any.
> > + * @trust_status: The enumeration type that specifies the trust state of
> > + *		  the process.
> > + * @task_id: The hash specific digest that identifies the process.
> > + * @task_key: A hash specific digest value that is used to
> > + *	      authenticate a task that is running as a trust
> > + *	      orchestrator to a task that is under the control of the
> > + *	      orchestrator.
> > + * @context: A pointer to the tsem_context structure that defines the
> > + *	     modeling context that the task is running under.
> > + *
> > + * This structure is one of the two primary control structures that
> > + * are implemented through the LSM blob functionality.  It is
> > + * automatically created when the task control structure is allocated
> > + * for a new task that is being created.  It's role is to control the
> > + * status of the task with respect to its security model.
> > + *
> > + * The trust_status member of structure determines whether or not the
> > + * task is in a condition to be trusted.  It represents whether or not
> > + * the task has requested execution of a security event that is
> > + * inconsistent with the model that the task is running under.
> > + * Reference the tsem_trust_status enumeration type for more
> > + * information on this member.  The trust status value is propagated
> > + * to any child tasks that are spawned from a task.
> > + *
> > + * The digest value that the task_id member contains is generated by
> > + * the tsem_tsem_bprm_creds_for_exec() function that computes the
> > + * task identity based on the COE identity and the CELL identity of
> > + * the executable that is being started.  This task_id value is used
> > + * in the computation of the security state point values in
> > + * combination with the COE and CELL identities for this event.  The
> > + * task_id digest creates security state points that are specific to
> > + * the executable file that was used to start the task.
> > + *
> > + * The task_key member holds the authentication key that will be used
> > + * to authenticate a process that is requesting the ability to set the
> > + * trust status of a process.  This value is generated for the task
> > + * structure of the trust orchestrator when a security modeling
> > + * namespace is created by the orchestrator.
> > + *
> > + * As an additional protection, the creation of a namespace causes the
> > + * context id of the created namespace to be placed in the task that
> > + * will serve as the trust orchestrator for the namespace.  This
> > + * context id must match the context id of a process that a trust
> > + * control request is being sent to.  Like the authentication key
> > + * this value is not propagated on task allocation so only the task
> > + * that has nominated the security modeling namespace will have
> > + * possession of the necessary credentials to control it.
> > + *
> > + * The context member of the structure contains a pointer to the
> > + * tsem_context structure allocated when a security modeling namespace
> > + * is created by the tsem_ns_create() function.  This structure will
> > + * contain all of the information needed to define how the task is to
> > + * have its security behavior modeled.
> > + */
> > +struct tsem_task {
> > +	u64 tma_for_ns;
> > +	enum tsem_task_trust trust_status;
> > +	u8 task_id[HASH_MAX_DIGESTSIZE];
> > +	u8 task_key[HASH_MAX_DIGESTSIZE];
> > +	struct tsem_context *context;
> > +};
> > +
> > +/**
> > + * struct tsem_context - TSEM modeling context description.
> > + * @kref: Reference count for the context.
> > + * @work: Work structure for delayed release of the context.
> > + * @id: The index number of the context.
> > + * @sealed: Status variable indicating whether or not the
> > + *	    modeling context can be modified.
> > + * @use_current_ns: Status variable indicating which user namespace
> > + *		    should be used for resolution of uid/gid values.
> > + * @actions: An array of enum tsem_action_type variables indicating
> > + *	     the type of response that should be returned in
> > + *	     response to the modeling of a security event that
> > + *	     is inconsistent with the model being used for the
> > + *	     security context.
> > + * @digestname: A pointer to a null-terminated buffer containing the
> > + *		name of the digest function that is to be used for
> > + *		this security context.
> > + * @zero_digest: The digest value for a 'zero-length' digest value.
> > + * @tfm: A pointer to the digest transformation structure that is to
> > + *	 be used for this context.
> > + * @magazine_size: The number of struct tsem_event structures that
> > + *		   are held in reserve for security event hooks that
> > + *		   are called in atomic context.
> > + * @magazine_lock: The spinlock that protects access to the event
> > + *		   magazine for the security context.
> > + * @magazine_index: The bitmap that is used to track the magazine slots
> > + *		    that have been allocated.
> > + * @ws: An array of work structures that are used to refill the magazine
> > + *	slots.
> > + * @magazine: An array of pointers to struct tsem_event structures that
> > + *	      are pre-allocated for security hooks called in atomic
> > + *	      context.
> > + * @model: If the modeling context is implemented with a kernel based
> > + *	   trusted model agent this pointer will point to the struct
> > + *	   tsem_model structure that maintains the state of the
> > + *	   security model.
> > + * @external: If the modeling context is implemented with an external
> > + *	      modeling agent this pointer will point to the struct
> > + *	      tsem_external structure that implements the interface to
> > + *	      the external trusted modeling agent.
> > +
> > + * This structure is used to represent the state of a TSEM security
> > + * modeling namespace.  A pointer to this structure is stored in the
> > + * struct tsem_task structure.
> > + *
> > + * This structure is allocated by the tsem_ns_create() function in
> > + * response to a TSEM control request.  This structure maintains all
> > + * of the information that describes the security modeling namespace
> > + * that is not specific to the type of namespace, ie. external or
> > + * internal that is being implemented.
> > +
> > + * The id member is a 64-bit counter that cannot feasibly be
> > + * overflowed and that is incremented for each namespace creation that
> > + * is created.  The root modeling namespace has a value of zero so the
> > + * TSEM code uses a pattern of testing this value for non-zero status
> > + * as an indication of whether or not the task is running in a
> > + * subordinate modeling namespace.
> > +
> > + * Each security modeling namespace can have an independent
> > + * cryptographic digest function that is used as the compression
> > + * function for generating the digest values that are used to model
> > + * the security events that occur in a namespace.  A single struct tfm
> > + * is allocated for this digest function at the time that the
> > + * tsem_context structure is created and is maintained in this
> > + * structure for subsequent use during event processing.
> > +
> > + * Each cryptographic digest function has a 'zero message' value that
> > + * is the result of the initialization and closure of a hash function
> > + * that has no other input.  This zero digest value is computed at the
> > + * time of the creation of the array.  This digest value is returned
> > + * for files with zero sizes or that have pseudonyms declared for
> > + * them.
> > + *
> > + * The actions array contains a specification of how each security
> > + * event should be handled in the event that the model detects a
> > + * security event consistent with the model designated for the
> > + * namespace.  This array allows the specification of whether the
> > + * model should be enforcing or logging.  Currently the specification
> > + * is all or nothing for all of the events, with plans to make the
> > + * actions individually configurable.
> > +
> > + * Each security event that is processed requires a struct tsem_event
> > + * structure that drives either the internal modeling of an event or
> > + * its export to an external modeling agent.  Some security event
> > + * hooks are called while a task is running in atomic context. Since
> > + * memory cannot be allocated while a process is in atomic context, a
> > + * magazine of these structures is maintained by this structure for
> > + * security events that run in atomic context.  The size of this
> > + * magazine is dynamic and is configurable for each security modeling
> > + * namespace that is created.
> > + *
> > + * When a tsem_event structure is allocated for an atomic event a
> > + * request for the refill of the slot that is vacated is dispatched to
> > + * an asynchronous workqueue.  The ws member of this structure points
> > + * to an array of work structures for this refill capability, one for
> > + * each slot in the magazine.
> > + *
> > + * All of this infrastructure is generic for each security modeling
> > + * namespace.  How the security modeling is done is governed by the
> > + * model and external members of this structure.  These members point
> > + * to data structures that either maintain the security model state
> > + * for an in kernel trusted modeling agent or handle the export of the
> > + * event to an external trusted modeling agent.
> > + *
> > + * Each task that is created in a non-root security modeling namespace
> > + * increments the reference count maintained in the kref member of
> > + * this structure in the tsem_task_alloc() function.  The
> > + * tsem_task_free() function decrements this reference count.  When
> > + * the reference count expires, ie. when the last task using the
> > + * modeling namespace exits, an asynchronous workqueue request is
> > + * dispatched to dispose of the context.  The work member of this
> > + * structure is used to reference that workqueue request.
> > + */
> > +struct tsem_context {
> > +	struct kref kref;
> > +	struct work_struct work;
> > +
> > +	u64 id;
> > +	bool sealed;
> > +	bool use_current_ns;
> > +
> > +	enum tsem_action_type actions[TSEM_EVENT_CNT];
> > +
> > +	char *digestname;
> > +	u8 zero_digest[HASH_MAX_DIGESTSIZE];
> > +	struct crypto_shash *tfm;
> > +
> > +	unsigned int magazine_size;
> > +	spinlock_t magazine_lock;
> > +	unsigned long *magazine_index;
> > +	struct tsem_work *ws;
> > +	struct tsem_event **magazine;
> > +
> > +	struct tsem_model *model;
> > +	struct tsem_external *external;
> > +};

> Odd use of whitespace in the structure definition.

It is a carry over from our userspace coding style.  As a team we have
found it helpful to visually segregate members of a structure that
have a common and distinct purpose.

FWIW, it would seem that include/linux/sched.h seems to embrace
a similar concept for 'struct task_struct'.

[ ... rest of tsem.h trimmed ... ]

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
