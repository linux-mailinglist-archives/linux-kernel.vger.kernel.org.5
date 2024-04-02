Return-Path: <linux-kernel+bounces-128733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51840895EC2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6621F25DBF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5B015E5D6;
	Tue,  2 Apr 2024 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RGIiCkie"
Received: from sonic301-9.consmr.mail.bf2.yahoo.com (sonic301-9.consmr.mail.bf2.yahoo.com [74.6.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7EA15AAA7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093746; cv=none; b=mW3PB35zJmeh3PiLWmtmcwwXp5DihqARha93ogHl+IBFy1uas9FJugz9+dpEt5p97gAz6HI6SwqmPgT2gX3w35lMJbXjreS0z0npLW7jzCVpmBds759M61WaiLEGo1Hin3V6YdIgUpzpI6lRq2fwhVFOO4y9ZaVOBErP0pRzckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093746; c=relaxed/simple;
	bh=jfjODZtrdr5z5bRLGc1rvkYKnqE8HTvLlVB9qtTeXEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCNyUzHEfG/2EDpAHG/oNcTWPO8Mt7ek4E02EHHh+42taJw0add5/4cbQADRGDsvVWqBhGRspsDHby+rq/7a2c0sZJwCbkxMBY1LtkXgdLCEEsS6D6maHZ3MLSbVH44cH7+aAwhGvXSso75MG+C8jnHq3BTqZlk1gNJT/m8Rq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=RGIiCkie; arc=none smtp.client-ip=74.6.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712093741; bh=/coxwr5/aTVYhaXJU4zctefdasEYE2MBd5NvNEochqo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=RGIiCkieBp3WC2VXaGDYwtDWn3pqodtAZtOw0csX4NKEkVuLA5Yj9+W4QliFpnNFLGA4KTUAhN4W9yOWr8VjGrAaw/rxSMsWKVVchFA4+AS6u7p4+jBDtl3F6QIIx2V0f+SAUf0q4YGV3d6ByYhwWU8OBZCpppd6M2hHU4P+03nEZka5jqU7gDfVzOMB10kbu3/JwjZWapejxMOx5CHnB1MlYURLBQUSWgvrTFvbjwuwQCcfsNN96TfFsXGvXVtftaaNLUP2DHAfF2dVfKssQfDNFZV4eEjRR+KV73rRPtWikRdMQnCr14b6vUXWfC69VbLLX6NiuKkxOGQ/ZOPANw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712093741; bh=GKYdJV/NW/afjvSHGsJrhTgVd5jUpvozerxWyddLiYd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TrmM90+ucB8+HjfAKXINmE1V4fA+2drqj7WtHkrMhFLmih4r9dGbp0NpVRn0Ch1Ku921Om0gFINMB3Y2CJ2xN5H8b5/TvyBZbBMG+/cGJkNSzaWauTZS1E0RZjgbJKDvpLp0brc2TECYMFcbWNU9SPDyN625SlcAMCsxXOFlv5RQVKvMD+Sw3fpBv6tp2yfrVUTChZHzGAWwIDzOKcU6YChWXi3Lz9gJ9Ra2P1SMApT43yVLKVHI9z9DPeVArnBVzFux361Qi96t3oDWUXxwC2VvQBPGEDUd0tZdfHx/MiJdC4JZB4ULrbv9OEbKCJr8LNX13mTFl3BJ6fnHrqu36Q==
X-YMail-OSG: gU1egNQVM1ntg2gu7NmQJ7SQo.SerYoTb3zvhb96MPCCHWG6RTPkrx7vVWadHak
 egAF1f7AudSGjedTNCJDJIWphvHJRI0vAMnvQSc5L35_bBXzaGdGT7EG1uwIFqjSmorENzvNXbzw
 qHVJ483wgs1fENS7paJ5VBdUibuD4HdB4beENdHnIEVVuuYoR1_Ie2zbWz8ay5G0LwdnVhFW4yZC
 _YK1MxsZdZwmN8ujS1iDXAKw2DWTU.YK1Yh458m2OXKVg50zH1xwRFYRz.iVN9iQk9h7QH0cYuhL
 Tbnizyfbb.IkWKQ47yVjKG.8PZgpKygrhhu4CT4dUrgYHBBTE9MgG1n6NFLir3Db9mQljJaC_5y0
 rE0FTdFt5XJS.RGf5z6mmOR4pdudcz7wjlccbzbBB3EG0oh5_iPy2HIrrFIEtLx9fO_NacBPqjtI
 y_peTh8pRavbRI36XFOAGveQiBs4Bhkw9R.1KkS0QM0ACtyOUxbqHDHPZMdG8YSnaE96JzBAbVOL
 1yOoFL81g73Fxl0IRANz6j4rB4j_vqSY1PpTg.ODC4nipYBrr1FtIbuKY5FfOWQKdSI1YNj46pGm
 M1CTDsBnIRPPIdJeoHA7KPROpLWuutUZLbnSRjOr4FoBmwDk3ZMv950yhdqo6Xfa7N1UJpZKKoGL
 erhRHWfGHKTzhT2Ncv2QPSNP930RMlRDn0MXTdQgzFiJFS77pUTv3YAKDZ7hhp0w6Q49j6eJMcBY
 _lVU.uOhc__PyQQw_IzIqIyYcCivkTiuleL4HzlP4b0T10vtN7SPtZH.n_zE3KZ_LCcGWUWP86dH
 vHqKZn443EPD_FNu6WfZqn1CYYnjLeTrReApnaOEL8R5EvTAqj1lWd5XoMFS86j8CGuzOD4LAy35
 pzR5KpT2ujPSJcEMRQT6LMxcjFMcT4PAMV3IW6OOidOIeybqQN35A9z1OAKs7pj7sswX7zGniOnW
 GoA8ZvJL7j.HMgLoj340wsDw02ymD9MM9yJHcHgt8pn7qxKBtpZSBTE8_6dmJ2gq.GC9ijLkt0CV
 eey8QvP1_lE0pAle6v8EIzm6yDZNBOVOjLETNonrbTq9Izt1d0RVHIT6yqPSvHDbFgBO2vvCdKbr
 x8CjryqfCrYa2KTuBi3bAp1OR4YJf9kugIgufnBXKPT0rK4K1NoIW2_scheRgby_kAEuTtah1wVh
 FVRNygb_gvBEpeJAnBK7PDnfcrWLX5FDW1HF.MKjQ4dRuK7HCf3vjAH9OfIXYtdr_LYFrwkKsOpq
 97kpxsI1NQ5PoWIrIbD2RQT0pESJBP2zGKj_bla7O53Ma9T1BIN8fxYANBMpibAylBlSj4Gjc67S
 tBQjQxOPlQkmGnQhjybAxJHBG3rDsr2ImJyI1kLFpx6llQ5dzYDWawFk9u1fM36DZS10wlFQOyE1
 0mgKzfyd7zXI31TogaCLlwacK3JFWv97LI7fb5tuKHkRh6CLKGzW0UX7jOsRZEPw8Idixx2bG3D9
 W0fju1ZPeMSXii8_1MXOFlJU_TolwoVhPn0DS9XPOSfieAEBfvoQ7jZmmSjfbxhnjVpGcfe1lxKD
 KbL3nXZsw_5ugDSaZfLL59V_l5OA2kCSLG3TUn8iUTQcMWK0_.QD9Q50SVuRCbjHwIZqsJk2Y7Qr
 bro5I6pnbzDWgQoF2Fa.y7mN546u6jBt9_Ry59_AdQ2RdRtK9Pl8y6N2PRfaCeYWkIzP1ZzCMr8Y
 sRiNIczT0mjw1QPlpYpcZCMpVcftXXfQ9g0yn0s5APRTSYKzf5.8i7PabkLw7tGUdMCl0aAtmNjL
 i.JxX7P9oCJL4tLgROrv7fJm10OEawE2hhhJTvjTRDAhY1vqXguVYsGTXt81hQnjhV7EJWvUkYfu
 yAZQYgc9M5I.5R0GCU3NFuf7.mqbnSXozxNH0.KBP5tk.7w.MXL11ZzNVpEc.YGC3VsPBHIUYl7f
 XoFe66a.dSSQusu8ldVYHbp8r0HB0nu0cGp5.RxRb8WFg9j6g0n3C39eoIuatF_E65AIShF7gkYU
 35te39TnCmEdnAAoQ8RkE8B4WqEcTHN7sz6hIa78ZtraD9bH9ENUxFVMBtUzciQtvm9WnOUZPEov
 F9Wf00MUPOiRBsm4Kgb2Kt8NfzKcunf8yGl19RDxxB92Vp7C58teL5qkMuIxNupsapCkOc6IEHJc
 UsSzKFyH3_wVxFzsUaQasNhQnpFgDw0Q7ACwC2tjzTwm9fL5VwUdKV9VPp2_gtg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 58764906-3ac0-4f04-b4f7-141949b17bab
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Tue, 2 Apr 2024 21:35:41 +0000
Received: by hermes--production-gq1-5c57879fdf-6xjwd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 766974917e70ff94558a1a598d7a119c;
          Tue, 02 Apr 2024 21:15:21 +0000 (UTC)
Message-ID: <42c5489c-5e5c-4648-b370-cbc14e86dbbc@schaufler-ca.com>
Date: Tue, 2 Apr 2024 14:15:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] Add primary TSEM implementation file.
To: Greg Wettstein <greg@enjellic.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20240401105015.27614-1-greg@enjellic.com>
 <20240401105015.27614-5-greg@enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240401105015.27614-5-greg@enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/1/2024 3:50 AM, Greg Wettstein wrote:
> From: "Dr. Greg" <greg@enjellic.com>
>
> The tsem.c file is the 'master' file in the TSEM implementation.
> It is responsible for initializing the LSM and providing
> the implementation of the security event handlers.
> ---
>  security/tsem/tsem.c | 2422 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 2422 insertions(+)
>  create mode 100644 security/tsem/tsem.c
>
> diff --git a/security/tsem/tsem.c b/security/tsem/tsem.c
> new file mode 100644
> index 000000000000..876ef1fa8012
> --- /dev/null
> +++ b/security/tsem/tsem.c
> @@ -0,0 +1,2422 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (C) 2024 Enjellic Systems Development, LLC
> + * Author: Dr. Greg Wettstein <greg@enjellic.com>
> + *
> + * This file is the primary implementation file for the tsem LSM.
> + *
> + * It implements initialization and setup functions that interpret
> + * kernel command-line arguments and prepares TSEM for operation.
> + *
> + * In addition it contains all of the TSEM specific security event
> + * handlers that are responsible for handling the LSM events that TSEM
> + * models.
> + *
> + * Each TSEM event handler calls the tsem_allocate_event() function to
> + * allocate a structure that will be used to describe the event.  The
> + * CELL union of this structure contains various structures that are
> + * used to hold these parameters.
> + *
> + * Since the event characterization parameters need to be retained for
> + * the lifetime of the tsem_event structure that is allocated.  In the
> + * case of internally modeled namespaces this lifespan is the lifetime
> + * of the security modeling namespace.  In the case of externally
> + * modeled namespaces, the lifespan is until the security event
> + * description is exported to an external trust orchestrator.
> + *
> + * In order to support this model, the event description structures
> + * are typically composed of a union over 'in' and 'out' structures.
> + * The 'in' structures are used to hold arguments to the event handler
> + * that may only be relevant for the duration of the call.  These
> + * values are translated into members of the 'out' structure that
> + * retain the values until the end of the lifetime of the tsem_event
> + * structure.
> + *
> + * Each TSEM event handler is responsible for allocating a tsem_event
> + * structure and populating the appropriate CELL structure with the
> + * input characteristics of the event.  The dispatch_event() function
> + * is called to handle the modeling of the event.  This function
> + * returns the permission value that is returned as the result of the
> + * LSM event handler.
> + *
> + * The dispatch_event() calls the tsem_event_init() function that is
> + * responsible for translating the input parameters into values that
> + * will be retained for the lifetime of the security event
> + * description.  The populated event description is then dispatched to
> + * either the tsem_model_event() or the tsem_export_event() for
> + * modeling by either the internal TMA or by a TMA associated with an
> + * external trust orchestrator.

I'm not in favor of this level of indirection. Funneling all the LSM hooks
into a dispatcher that fans out to a 1 to 1 (or near enough it doesn't make
a difference) set of event handlers is just wasteful of resources.

> + */
> +
> +#define LOCKED true
> +#define NOLOCK false

As you have these constants defined the first would indicate that
a lock is set, whereas the second indicates there is not a lock.
You should either pair LOCKED with UNLOCKED or LOCK with NOLOCK.
Or better yet, name your variables such that "true" and "false"
are reasonable descriptions of their states.

> +
> +#include <linux/magic.h>
> +#include <linux/mman.h>
> +#include <linux/binfmts.h>
> +#include <linux/bpf.h>
> +#include <linux/mount.h>
> +#include <linux/security.h>
> +
> +#include "tsem.h"
> +
> +static const struct lsm_id tsem_lsmid = {
> +	.name = "tsem",
> +	.id = LSM_ID_TSEM,
> +};
> +
> +struct lsm_blob_sizes tsem_blob_sizes __ro_after_init = {
> +	.lbs_task = sizeof(struct tsem_task),
> +	.lbs_inode = sizeof(struct tsem_inode),
> +	.lbs_ipc = sizeof(struct tsem_ipc),
> +	.lbs_xattr_count = 1
> +};
> +
> +enum tsem_action_type tsem_root_actions[TSEM_EVENT_CNT] = {
> +	TSEM_ACTION_EPERM	/* Undefined. */
> +};
> +
> +static atomic64_t task_instance;
> +
> +static struct tsem_model root_model = {
> +	.point_lock = __SPIN_LOCK_INITIALIZER(root_model.point_lock),
> +	.point_list = LIST_HEAD_INIT(root_model.point_list),
> +	.point_end_mutex = __MUTEX_INITIALIZER(root_model.point_end_mutex),
> +
> +	.trajectory_lock = __SPIN_LOCK_INITIALIZER(root_model.trajectory_lock),
> +	.trajectory_list = LIST_HEAD_INIT(root_model.trajectory_list),
> +	.trajectory_end_mutex = __MUTEX_INITIALIZER(root_model.trajectory_end_mutex),
> +
> +	.forensics_lock = __SPIN_LOCK_INITIALIZER(root_model.forensics_lock),
> +	.forensics_list = LIST_HEAD_INIT(root_model.forensics_list),
> +	.forensics_end_mutex = __MUTEX_INITIALIZER(root_model.forensics_end_mutex),
> +
> +	.pseudonym_mutex = __MUTEX_INITIALIZER(root_model.pseudonym_mutex),
> +	.pseudonym_list = LIST_HEAD_INIT(root_model.pseudonym_list),
> +
> +	.mount_mutex = __MUTEX_INITIALIZER(root_model.mount_mutex),
> +	.mount_list = LIST_HEAD_INIT(root_model.mount_list)
> +};
> +
> +static struct tsem_context root_context;
> +
> +DEFINE_STATIC_KEY_TRUE(tsem_not_ready);
> +
> +static bool tsem_available __ro_after_init;
> +
> +static unsigned int magazine_size __ro_after_init = TSEM_ROOT_MAGAZINE_SIZE;
> +
> +static enum mode_type {
> +	FULL_MODELING,
> +	NO_ROOT_MODELING,
> +	EXPORT_ONLY
> +} tsem_mode __ro_after_init;
> +
> +static char *default_hash_function __ro_after_init;
> +
> +const char * const tsem_names[TSEM_EVENT_CNT] = {
> +	"undefined",
> +	"bprm_committed_creds",
> +	"task_kill",
> +	"task_setpgid",
> +	"task_getpgid",
> +	"task_getsid",
> +	"task_setnice",
> +	"task_setioprio",
> +	"task_getioprio",
> +	"task_prlimit",
> +	"task_setrlimit",
> +	"task_setscheduler",
> +	"task_getscheduler",
> +	"task_prctl",
> +	"file_open",
> +	"mmap_file",
> +	"file_ioctl",
> +	"file_lock",
> +	"file_fcntl",
> +	"file_receive",
> +	"unix_stream_connect",
> +	"unix_may_send",
> +	"socket_create",
> +	"socket_connect",
> +	"socket_bind",
> +	"socket_accept",
> +	"socket_listen",
> +	"socket_socketpair",
> +	"socket_sendmsg",
> +	"socket_recvmsg",
> +	"socket_getsockname",
> +	"socket_getpeername",
> +	"socket_setsockopt",
> +	"socket_shutdown",
> +	"ptrace_traceme",
> +	"kernel_module_request",
> +	"kernel_load_data",
> +	"kernel_read_file",
> +	"sb_mount",
> +	"sb_umount",
> +	"sb_remount",
> +	"sb_pivotroot",
> +	"sb_statfs",
> +	"move_mount",
> +	"shm_associate",
> +	"shm_shmctl",
> +	"shm_shmat",
> +	"sem_associate",
> +	"sem_semctl",
> +	"sem_semop",
> +	"syslog",
> +	"settime",
> +	"quotactl",
> +	"quota_on",
> +	"msg_queue_associate",
> +	"msg_queue_msgctl",
> +	"msg_queue_msgsnd",
> +	"msg_queue_msgrcv",
> +	"ipc_permission",
> +	"key_alloc",
> +	"key_permission",
> +	"netlink_send",
> +	"inode_create",
> +	"inode_link",
> +	"inode_unlink",
> +	"inode_symlink",
> +	"inode_mkdir",
> +	"inode_rmdir",
> +	"inode_mknod",
> +	"inode_rename",
> +	"inode_setattr",
> +	"inode_getattr",
> +	"inode_setxattr",
> +	"inode_getxattr",
> +	"inode_listxattr",
> +	"inode_removexattr",
> +	"inode_killpriv",
> +	"tun_dev_create",
> +	"tun_dev_attach_queue",
> +	"tun_dev_attach",
> +	"tun_dev_open",
> +	"bpf",
> +	"bpf_map",
> +	"bpf_prog",
> +	"ptrace_access_check",
> +	"capable",
> +	"capget",
> +	"capset"
> +};

You can't seriously be counting on this being a mapping to tsem event numbers,
with the event numbers being defined elsewhere. You'll never be able to keep them
in sync. You probably want a structure here, with entries like

	{ "hook_name",	TSEM_EVENT_HOOK_NAME },


> +
> +static const unsigned long pseudo_filesystems[] = {
> +	PROC_SUPER_MAGIC,
> +	SYSFS_MAGIC,
> +	DEBUGFS_MAGIC,
> +	TMPFS_MAGIC,
> +	DEVPTS_SUPER_MAGIC,
> +	BINFMTFS_MAGIC,
> +	SECURITYFS_MAGIC,
> +	SELINUX_MAGIC,
> +	SMACK_MAGIC,
> +	CGROUP_SUPER_MAGIC,
> +	CGROUP2_SUPER_MAGIC,
> +	NSFS_MAGIC,
> +	EFIVARFS_MAGIC
> +};
> +
> +static int __init set_magazine_size(char *magazine_value)
> +{
> +	if (kstrtouint(magazine_value, 0, &magazine_size))
> +		pr_warn("tsem: Failed to parse root cache size.\n");
> +
> +	if (!magazine_size) {
> +		pr_warn("tsem: Forcing non-zero cache size.\n");
> +		magazine_size = TSEM_ROOT_MAGAZINE_SIZE;
> +	}
> +
> +	pr_info("tsem: Setting default root cache size to %u.\n",
> +		magazine_size);
> +	return 1;

Why isn't this a void function?

> +}
> +__setup("tsem_cache=", set_magazine_size);
> +
> +static int __init set_modeling_mode(char *mode_value)
> +{
> +	unsigned long mode = 0;
> +
> +	if (kstrtoul(mode_value, 0, &mode)) {
> +		pr_warn("tsem: Failed to parse modeling mode.\n");
> +		return 1;
> +	}
> +
> +	if (mode == 1)
> +		tsem_mode = NO_ROOT_MODELING;
> +	else if (mode == 2)
> +		tsem_mode = EXPORT_ONLY;
> +	else
> +		pr_warn("tsem: Unknown mode specified.\n");

If you're ever going to have additional "modes" you probably want
a switch() rather than cascading if()s.
You seem generally aggressive with defining meaningful constants.
It seems out of character that you're using integer mode values instead
of TSEM_MODE_CLOCKWISE and TSEM_MODE_WIDDERSHINS, or whatever the modes
are.

> +	return 1;

Repeating myself the once. If a function can only ever return
one value it should be a void function.

> +}
> +__setup("tsem_mode=", set_modeling_mode);
> +
> +static int __init set_default_hash_function(char *hash_function)
> +{
> +
> +	default_hash_function = hash_function;
> +	return 1;
> +}
> +__setup("tsem_digest=", set_default_hash_function);
> +
> +static bool bypass_event(void)
> +{
> +	if (tsem_mode == NO_ROOT_MODELING && !tsem_context(current)->id)
> +		return true;
> +	return false;
> +}
> +
> +static bool pseudo_filesystem(struct inode *inode)
> +{
> +	unsigned int lp;
> +
> +	for (lp = 0; lp < ARRAY_SIZE(pseudo_filesystems); ++lp)
> +		if (inode->i_sb->s_magic == pseudo_filesystems[lp])
> +			return true;
> +	return false;
> +}
> +
> +static int untrusted_task(struct tsem_event *ep)
> +{
> +	int retn = 0;
> +	struct tsem_context *ctx = tsem_context(current);
> +
> +	if (ctx->external) {
> +		retn = tsem_export_action(ep->event, ep->locked);
> +		if (retn)
> +			return retn;
> +	} else
> +		pr_warn("Untrusted event %s: model_ns=%lld, comm=%s, pid=%d\n",
> +			tsem_names[ep->event], ctx->id, current->comm,
> +			task_pid_nr(current));
> +
> +	if (ctx->actions[ep->event] == TSEM_ACTION_EPERM)
> +		retn = -EPERM;
> +	return retn;
> +}
> +
> +static int dispatch_event(struct tsem_event *ep)
> +{
> +	int retn = 0;
> +	struct tsem_context *ctx = tsem_context(current);
> +
> +	retn = tsem_event_init(ep);
> +	if (retn)
> +		return retn;
> +
> +	if (unlikely(tsem_task_untrusted(current)))
> +		return untrusted_task(ep);
> +
> +	if (!ctx->external)
> +		retn = tsem_model_event(ep);
> +	else
> +		retn = tsem_export_event(ep);
> +
> +	tsem_event_put(ep);
> +	return retn;
> +}
> +
> +static int tsem_file_open(struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +	if (unlikely(tsem_inode(inode)->status == TSEM_INODE_CONTROL_PLANE)) {
> +		if (capable(CAP_MAC_ADMIN))
> +			return 0;
> +		else
> +			return -EPERM;
> +	}
> +
> +	if (!S_ISREG(inode->i_mode))
> +		return 0;
> +	if (tsem_inode(inode)->status == TSEM_INODE_COLLECTING)
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_FILE_OPEN, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.file.in.file = file;
> +	ep->CELL.file.in.pseudo_file = pseudo_filesystem(inode);
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_mmap_file(struct file *file, unsigned long prot,
> +			  unsigned long flags, unsigned long extra)
> +{
> +	struct inode *inode = NULL;
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	if (!file && !(prot & PROT_EXEC))
> +		return 0;
> +	if (file) {
> +		inode = file_inode(file);
> +		if (!S_ISREG(inode->i_mode))
> +			return 0;
> +		if (pseudo_filesystem(inode))
> +			return 0;
> +	}
> +
> +	ep = tsem_event_allocate(TSEM_MMAP_FILE, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.mmap_file.anonymous = file == NULL ? 1 : 0;
> +	ep->CELL.mmap_file.file.in.file = file;
> +	ep->CELL.mmap_file.prot = prot;
> +	ep->CELL.mmap_file.flags = flags;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_file_ioctl(struct file *file, unsigned int cmd,
> +			   unsigned long arg)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_FILE_IOCTL, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.file.cmd = cmd;
> +	ep->CELL.file.in.file = file;
> +	ep->CELL.file.in.pseudo_file = pseudo_filesystem(file_inode(file));
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_file_lock(struct file *file, unsigned int cmd)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_FILE_LOCK, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.file.cmd = cmd;
> +	ep->CELL.file.in.file = file;
> +	ep->CELL.file.in.pseudo_file = pseudo_filesystem(file_inode(file));
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_file_fcntl(struct file *file, unsigned int cmd,
> +			   unsigned long arg)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_FILE_FCNTL, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.file.cmd = cmd;
> +	ep->CELL.file.in.file = file;
> +	ep->CELL.file.in.pseudo_file = pseudo_filesystem(file_inode(file));
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_file_receive(struct file *file)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_FILE_RECEIVE, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.file.in.file = file;
> +	ep->CELL.file.in.pseudo_file = pseudo_filesystem(file_inode(file));
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_task_alloc(struct task_struct *new, unsigned long flags)
> +{
> +	struct tsem_task *old_task = tsem_task(current);
> +	struct tsem_task *new_task = tsem_task(new);
> +
> +	new_task->instance = old_task->instance;
> +	new_task->p_instance = old_task->instance;
> +
> +	new_task->trust_status = old_task->trust_status;
> +	new_task->context = old_task->context;
> +	memcpy(new_task->task_id, old_task->task_id, HASH_MAX_DIGESTSIZE);
> +	memcpy(new_task->p_task_id, old_task->task_id, HASH_MAX_DIGESTSIZE);
> +
> +	if (!new_task->context->id)
> +		return 0;
> +
> +	kref_get(&new_task->context->kref);
> +	memcpy(new_task->task_key, old_task->task_key, HASH_MAX_DIGESTSIZE);
> +	return 0;
> +}
> +
> +static void tsem_task_free(struct task_struct *task)
> +{
> +	struct tsem_context *ctx = tsem_context(task);
> +
> +	if (!ctx->id)
> +		return;
> +	tsem_ns_put(ctx);

	if (ctx->id)
		tsem_ne_put(ctx);

One less line of code.

> +}
> +
> +static int tsem_task_kill(struct task_struct *target,
> +			  struct kernel_siginfo *info, int sig,
> +			  const struct cred *cred)
> +{
> +	bool cross_model;
> +	struct tsem_event *ep;
> +	struct tsem_context *src_ctx = tsem_context(current);
> +	struct tsem_context *tgt_ctx = tsem_context(target);
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	cross_model = src_ctx->id != tgt_ctx->id;
> +
> +	if (info != SEND_SIG_NOINFO && SI_FROMKERNEL(info))
> +		return 0;
> +	if (sig == SIGURG)
> +		return 0;
> +	if (!capable(CAP_MAC_ADMIN) &&
> +	    has_capability_noaudit(target, CAP_MAC_ADMIN))
> +		return -EPERM;
> +	if (!capable(CAP_MAC_ADMIN) && cross_model)
> +		return -EPERM;
> +
> +	ep = tsem_event_allocate(TSEM_TASK_KILL, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.task_kill.signal = sig;
> +	ep->CELL.task_kill.cross_model = cross_model;
> +	memcpy(ep->CELL.task_kill.target, tsem_task(target)->task_id,
> +	       tsem_digestsize());
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_ptrace_access_check(struct task_struct *child,
> +				    unsigned int mode)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_PTRACE_ACCESS_CHECK, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.task_kill.u.resource = mode;
> +	memcpy(ep->CELL.task_kill.target, tsem_task(child)->task_id,
> +	       tsem_digestsize());
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_ptrace_traceme(struct task_struct *parent)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_PTRACE_TRACEME, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	memcpy(ep->CELL.task_kill.source, tsem_task(parent)->task_id,
> +	       tsem_digestsize());
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_capget(const struct task_struct *target,
> +		       kernel_cap_t *effective, kernel_cap_t *inheritable,
> +		       kernel_cap_t *permitted)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_CAPGET, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.capability.effective = *effective;
> +	ep->CELL.capability.inheritable = *inheritable;
> +	ep->CELL.capability.permitted = *permitted;
> +	memcpy(ep->CELL.capability.target, tsem_task(target)->task_id,
> +	       tsem_digestsize());
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_capset(struct cred *new, const struct cred *old,
> +		       const kernel_cap_t *effective,
> +		       const kernel_cap_t *inheritable,
> +		       const kernel_cap_t *permitted)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_CAPSET, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.capability.effective = *effective;
> +	ep->CELL.capability.inheritable = *inheritable;
> +	ep->CELL.capability.permitted = *permitted;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_capable(const struct cred *cred, struct user_namespace *ns,
> +			int cap, unsigned int opts)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_CAPABLE, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.capability.cap = cap;
> +	ep->CELL.capability.opts = opts;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_task_setpgid(struct task_struct *p, pid_t pgid)
> +{
> +	struct tsem_event *ep;
> +	struct task_struct *src;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_TASK_SETPGID, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	memcpy(ep->CELL.task_kill.target, tsem_task(p)->task_id,
> +	       tsem_digestsize());
> +
> +	if (!pgid)
> +		memcpy(ep->CELL.task_kill.source, tsem_task(p)->task_id,
> +		       tsem_digestsize());
> +	else {
> +		rcu_read_lock();
> +		src = find_task_by_vpid(pgid);
> +		rcu_read_unlock();
> +		if (src)
> +			memcpy(ep->CELL.task_kill.source,
> +			       tsem_task(src)->task_id, tsem_digestsize());
> +	}
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_task_getpgid(struct task_struct *p)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_TASK_GETPGID, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	memcpy(ep->CELL.task_kill.target, tsem_task(p)->task_id,
> +	       tsem_digestsize());
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_task_getsid(struct task_struct *p)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_TASK_GETSID, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	memcpy(ep->CELL.task_kill.target, tsem_task(p)->task_id,
> +	       tsem_digestsize());
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_task_setnice(struct task_struct *p, int nice)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_TASK_SETNICE, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.task_kill.u.value = nice;
> +	memcpy(ep->CELL.task_kill.target, tsem_task(p)->task_id,
> +	       tsem_digestsize());
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_task_setioprio(struct task_struct *p, int ioprio)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_TASK_SETIOPRIO, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.task_kill.u.value = ioprio;
> +	memcpy(ep->CELL.task_kill.target, tsem_task(p)->task_id,
> +	       tsem_digestsize());
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_task_getioprio(struct task_struct *p)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_TASK_GETIOPRIO, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	memcpy(ep->CELL.task_kill.target, tsem_task(p)->task_id,
> +	       tsem_digestsize());
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_task_prlimit(const struct cred *cred, const struct cred *tcred,
> +			     unsigned int flags)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_TASK_PRLIMIT, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.task_prlimit.flags = flags;
> +	ep->CELL.task_prlimit.in.cred = cred;
> +	ep->CELL.task_prlimit.in.tcred = tcred;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_task_setrlimit(struct task_struct *p, unsigned int resource,
> +			       struct rlimit *new_rlim)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_TASK_SETRLIMIT, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.task_kill.u.resource = resource;
> +	ep->CELL.task_kill.cur = new_rlim->rlim_cur;
> +	ep->CELL.task_kill.max = new_rlim->rlim_max;
> +	memcpy(ep->CELL.task_kill.target, tsem_task(p)->task_id,
> +	       tsem_digestsize());
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_task_setscheduler(struct task_struct *p)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_TASK_SETSCHEDULER, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	memcpy(ep->CELL.task_kill.target, tsem_task(p)->task_id,
> +	       tsem_digestsize());
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_task_getscheduler(struct task_struct *p)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_TASK_GETSCHEDULER, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	memcpy(ep->CELL.task_kill.target, tsem_task(p)->task_id,
> +	       tsem_digestsize());
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> +			   unsigned long arg4, unsigned long arg5)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_TASK_PRCTL, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.task_prctl.option = option;
> +	ep->CELL.task_prctl.arg2 = arg2;
> +	ep->CELL.task_prctl.arg3 = arg3;
> +	ep->CELL.task_prctl.arg4 = arg4;
> +	ep->CELL.task_prctl.arg5 = arg5;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static void tsem_bprm_committed_creds(const struct linux_binprm *bprm)
> +{
> +	u8 task_id[HASH_MAX_DIGESTSIZE];
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return;
> +
> +	if (tsem_map_task(bprm->file, task_id))
> +		memset(task_id, 0xff, sizeof(task_id));
> +
> +	tsem_task(current)->instance = atomic64_inc_return(&task_instance);
> +	memcpy(tsem_task(current)->task_id, task_id, tsem_digestsize());
> +}
> +
> +static int tsem_inode_alloc_security(struct inode *inode)
> +{
> +	struct tsem_inode *tsip = tsem_inode(inode);
> +
> +	mutex_init(&tsip->digest_mutex);
> +	INIT_LIST_HEAD(&tsip->digest_list);
> +
> +	mutex_init(&tsip->create_mutex);
> +	INIT_LIST_HEAD(&tsip->create_list);
> +
> +	mutex_init(&tsip->instance_mutex);
> +	INIT_LIST_HEAD(&tsip->instance_list);
> +
> +	return 0;
> +}
> +
> +static int tsem_inode_init_security(struct inode *inode, struct inode *dir,
> +				    const struct qstr *qstr,
> +				    struct xattr *xattrs, int *xattr_count)
> +{
> +	u8 *owner = tsem_task(current)->task_id;
> +	struct tsem_inode *tsip = tsem_inode(inode);
> +	struct tsem_inode_instance *entry, *retn = NULL;
> +
> +	mutex_lock(&tsem_inode(dir)->create_mutex);
> +	list_for_each_entry(entry, &tsem_inode(dir)->create_list, list) {
> +		if (!memcmp(entry->owner, owner, tsem_digestsize()) &&
> +		    !strcmp(qstr->name, entry->pathname)) {
> +			retn = entry;
> +			break;
> +		}
> +	}
> +
> +	if (retn) {
> +		tsip->created = true;
> +		tsip->creator = retn->creator;
> +		tsip->instance = retn->instance;
> +		memcpy(tsip->owner, retn->owner, tsem_digestsize());
> +		list_del(&retn->list);
> +	}
> +	mutex_unlock(&tsem_inode(dir)->create_mutex);
> +
> +	if (!retn && S_ISREG(inode->i_mode))
> +		WARN_ONCE(true, "Cannot find inode ownership information.");
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static void _release_inode_instances(u64 id, struct tsem_inode *tsip)
> +{
> +	struct tsem_inode_instance *owner, *tmp_owner;
> +
> +	mutex_lock(&tsip->instance_mutex);
> +	list_for_each_entry_safe(owner, tmp_owner, &tsip->instance_list,
> +				 list) {
> +		if (id == owner->creator) {
> +			list_del(&owner->list);
> +			kfree(owner);
> +		}
> +	}
> +	mutex_unlock(&tsip->instance_mutex);
> +}
> +
> +static void tsem_inode_free_security(struct inode *inode)
> +{
> +	struct tsem_inode_instance *owner, *tmp_owner;
> +	struct tsem_inode_digest *digest, *tmp_digest;
> +	struct tsem_inode_entry *entry, *tmp_entry;
> +	struct tsem_context *ctx = tsem_context(current);
> +
> +	mutex_lock(&ctx->inode_mutex);
> +	list_for_each_entry_safe(entry, tmp_entry, &ctx->inode_list, list) {
> +		if (entry->tsip == tsem_inode(inode)) {
> +			list_del(&entry->list);
> +			_release_inode_instances(ctx->id, entry->tsip);
> +			kfree(entry);
> +		}
> +	}
> +	mutex_unlock(&ctx->inode_mutex);
> +
> +	list_for_each_entry_safe(digest, tmp_digest,
> +				 &tsem_inode(inode)->digest_list, list) {
> +		list_del(&digest->list);
> +		kfree(digest->name);
> +		kfree(digest);
> +	}
> +
> +	list_for_each_entry_safe(owner, tmp_owner,
> +				 &tsem_inode(inode)->create_list, list) {
> +		list_del(&owner->list);
> +		kfree(owner);
> +	}
> +
> +	list_for_each_entry_safe(owner, tmp_owner,
> +				 &tsem_inode(inode)->instance_list, list) {
> +		list_del(&owner->list);
> +		kfree(owner);
> +	}
> +}
> +
> +static int tsem_unix_stream_connect(struct sock *sock, struct sock *other,
> +				    struct sock *newsk)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_UNIX_STREAM_CONNECT, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.socket.in.socka = sock;
> +	ep->CELL.socket.in.sockb = other;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_unix_may_send(struct socket *sock, struct socket *other)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_UNIX_MAY_SEND, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.socket.in.socka = sock->sk;
> +	ep->CELL.socket.in.sockb = other->sk;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_socket_post_create(struct socket *sock, int family, int type,
> +				   int protocol, int kern)
> +{
> +	struct tsem_inode *tsip = tsem_inode(SOCK_INODE(sock));
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +
> +	memcpy(tsip->owner, tsem_task(current)->task_id, tsem_digestsize());
> +	return 0;
> +}
> +
> +static int tsem_socket_create(int family, int type, int protocol, int kern)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SOCKET_CREATE, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.socket.out.socka.family = family;
> +	ep->CELL.socket.out.socka.type = type;
> +	ep->CELL.socket.out.socka.protocol = protocol;
> +	ep->CELL.socket.out.socka.kern = kern;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_socket_connect(struct socket *sock, struct sockaddr *addr,
> +			     int addr_len)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SOCKET_CONNECT, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.socket.in.socka = sock->sk;
> +	ep->CELL.socket.in.addr = addr;
> +	ep->CELL.socket.value = addr_len;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_socket_bind(struct socket *sock, struct sockaddr *addr,
> +			    int addr_len)
> +
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SOCKET_BIND, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.socket.in.socka = sock->sk;
> +	ep->CELL.socket.in.addr = addr;
> +	ep->CELL.socket.value = addr_len;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_socket_accept(struct socket *sock, struct socket *newsock)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SOCKET_ACCEPT, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.socket.in.socka = sock->sk;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_socket_listen(struct socket *sock, int backlog)
> +
> +{
> +	struct sock *sk = sock->sk;
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SOCKET_LISTEN, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.socket.value = backlog;
> +	ep->CELL.socket.in.socka = sk;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_socket_socketpair(struct socket *socka, struct socket *sockb)
> +{
> +	struct sock *ska = socka->sk, *skb = sockb->sk;
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SOCKET_SOCKETPAIR, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.socket.in.socka = ska;
> +	ep->CELL.socket.in.sockb = skb;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_socket_sendmsg(struct socket *sock, struct msghdr *msgmsg,
> +			       int size)
> +{
> +	struct sock *sk = sock->sk;
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SOCKET_SENDMSG, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.socket.in.socka = sk;
> +	ep->CELL.socket.in.addr = msgmsg->msg_name;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_socket_recvmsg(struct socket *sock, struct msghdr *msgmsg,
> +			       int size, int flags)
> +{
> +	struct sock *sk = sock->sk;
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SOCKET_RECVMSG, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.socket.in.socka = sk;
> +	if (msgmsg->msg_name && msgmsg->msg_namelen > 0)
> +		ep->CELL.socket.in.addr = msgmsg->msg_name;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_socket_getsockname(struct socket *sock)
> +{
> +	struct sock *sk = sock->sk;
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SOCKET_GETSOCKNAME, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.socket.in.socka = sk;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_socket_getpeername(struct socket *sock)
> +{
> +	struct sock *sk = sock->sk;
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SOCKET_GETPEERNAME, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.socket.in.socka = sk;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_socket_setsockopt(struct socket *sock, int level, int optname)
> +{
> +	struct sock *sk = sock->sk;
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SOCKET_SETSOCKOPT, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.socket.value = level;
> +	ep->CELL.socket.optname = optname;
> +	ep->CELL.socket.in.socka = sk;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_socket_shutdown(struct socket *sock, int how)
> +{
> +	struct sock *sk = sock->sk;
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SOCKET_SHUTDOWN, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.socket.value = how;
> +	ep->CELL.socket.in.socka = sk;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_kernel_module_request(char *kmod_name)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_KERNEL_MODULE_REQUEST, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.kernel.in.kmod_name = kmod_name;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_kernel_load_data(enum kernel_load_data_id id, bool contents)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_KERNEL_LOAD_DATA, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.kernel.id = id;
> +	ep->CELL.kernel.contents = contents;
> +
> +	return dispatch_event(ep);
> +}
> +
> +
> +static int tsem_kernel_read_file(struct file *file,
> +				 enum kernel_read_file_id id, bool contents)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_KERNEL_READ_FILE, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.kernel.id = id;
> +	ep->CELL.kernel.contents = contents;
> +	ep->CELL.kernel.in.file = file;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_sb_mount(const char *dev_name, const struct path *path,
> +			 const char *type, unsigned long flags, void *data)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SB_MOUNT, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.sb.flags = flags;
> +	ep->CELL.sb.in.dev_name = dev_name;
> +	ep->CELL.sb.in.path = path;
> +	ep->CELL.sb.in.type = type;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static	int tsem_sb_umount(struct vfsmount *mnt, int flags)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SB_UMOUNT, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.sb.flags = flags;
> +	ep->CELL.sb.in.dentry = mnt->mnt_root;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_sb_remount(struct super_block *sb, void *mnt_opts)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SB_REMOUNT, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.sb.in.sb = sb;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_sb_pivotroot(const struct path *old_path,
> +			     const struct path *new_path)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SB_PIVOTROOT, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.sb.in.path = old_path;
> +	ep->CELL.sb.in.path2 = new_path;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_sb_statfs(struct dentry *dentry)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SB_STATFS, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.sb.in.dentry = dentry;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_move_mount(const struct path *from_path,
> +			   const struct path *to_path)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_MOVE_MOUNT, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.sb.in.path = from_path;
> +	ep->CELL.sb.in.path2 = to_path;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_shm_associate(struct kern_ipc_perm *perm, int shmflg)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SHM_ASSOCIATE, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.ipc.in.perm = perm;
> +	ep->CELL.ipc.value = shmflg;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_shm_shmctl(struct kern_ipc_perm *perm, int cmd)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SHM_SHMCTL, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.ipc.in.perm = perm;
> +	ep->CELL.ipc.value = cmd;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_shm_shmat(struct kern_ipc_perm *perm, char __user *shmaddr,
> +			  int shmflg)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SHM_SHMAT, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.ipc.in.perm = perm;
> +	ep->CELL.ipc.value = shmflg;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_sem_associate(struct kern_ipc_perm *perm, int semflg)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SEM_ASSOCIATE, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.ipc.in.perm = perm;
> +	ep->CELL.ipc.value = semflg;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_sem_semctl(struct kern_ipc_perm *perm, int cmd)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SEM_SEMCTL, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.ipc.in.perm = perm;
> +	ep->CELL.ipc.value = cmd;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_sem_semop(struct kern_ipc_perm *perm, struct sembuf *sops,
> +			  unsigned int nsops, int alter)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SEM_SEMOP, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.ipc.in.perm = perm;
> +	ep->CELL.ipc.nsops = nsops;
> +	ep->CELL.ipc.value = alter;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_syslog(int type)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SYSLOG, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.value = type;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_settime(const struct timespec64 *ts, const struct timezone *tz)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_SETTIME, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	if (ts) {
> +		ep->CELL.time.have_ts = true;
> +		ep->CELL.time.seconds = ts->tv_sec;
> +		ep->CELL.time.nsecs = ts->tv_nsec;
> +	}
> +	if (tz) {
> +		ep->CELL.time.have_tz = true;
> +		ep->CELL.time.minuteswest = tz->tz_minuteswest;
> +		ep->CELL.time.dsttime = tz->tz_dsttime;
> +	}
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_quotactl(int cmds, int type, int id,
> +			 const struct super_block *sb)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_QUOTACTL, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.quota.cmds = cmds;
> +	ep->CELL.quota.type = type;
> +	ep->CELL.quota.id = id;
> +	ep->CELL.quota.in.sb = sb;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_quota_on(struct dentry *dentry)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_QUOTA_ON, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.quota.in.dentry = dentry;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_msg_queue_associate(struct kern_ipc_perm *perm, int msqflg)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_MSG_QUEUE_ASSOCIATE, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.ipc.in.perm = perm;
> +	ep->CELL.ipc.value = msqflg;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_msg_queue_msgsnd(struct kern_ipc_perm *perm,
> +				 struct msg_msg *msgmsg, int msqflg)
> +
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_MSG_QUEUE_MSGSND, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.ipc.in.perm = perm;
> +	ep->CELL.ipc.value = msqflg;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_msg_queue_msgctl(struct kern_ipc_perm *perm, int cmd)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_MSG_QUEUE_MSGCTL, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.ipc.in.perm = perm;
> +	ep->CELL.ipc.value = cmd;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_msg_queue_msgrcv(struct kern_ipc_perm *perm,
> +				 struct msg_msg *msgmsg,
> +				 struct task_struct *target, long type,
> +				 int mode)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_MSG_QUEUE_MSGRCV, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.ipc.in.perm = perm;
> +	ep->CELL.ipc.in.target = target;
> +	ep->CELL.ipc.type = type;
> +	ep->CELL.ipc.value = mode;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_ipc_alloc(struct kern_ipc_perm *kipc)
> +{
> +	struct tsem_ipc *tipc = tsem_ipc(kipc);
> +
> +	memcpy(tipc->owner, tsem_task(current)->task_id, tsem_digestsize());
> +	return 0;
> +}
> +
> +static int tsem_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_IPC_PERMISSION, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.ipc.perm_flag = flag;
> +	ep->CELL.ipc.in.perm = ipcp;
> +
> +	return dispatch_event(ep);
> +}
> +
> +#ifdef CONFIG_KEYS
> +static int tsem_key_alloc(struct key *key, const struct cred *cred,
> +			  unsigned long flags)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_KEY_ALLOC, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.key.flags = flags;
> +	ep->CELL.key.in.cred = cred;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_key_permission(key_ref_t key_ref, const struct cred *cred,
> +			       unsigned int perm)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_KEY_PERMISSION, LOCKED);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.key.flags = perm;
> +	ep->CELL.key.in.cred = cred;
> +	ep->CELL.key.in.ref = key_ref;
> +
> +	return dispatch_event(ep);
> +}
> +#endif
> +
> +static int tsem_netlink_send(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_NETLINK_SEND, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.netlink.in.sock = sk;
> +	ep->CELL.netlink.in.parms = (struct netlink_skb_parms *) skb->cb;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_inode_create(struct inode *dir, struct dentry *dentry,
> +			     umode_t mode)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_INODE_CREATE, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.inode.in.dir = dir;
> +	ep->CELL.inode.in.dentry = dentry;
> +	ep->CELL.inode.mode = mode;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_inode_link(struct dentry *old_dentry, struct inode *dir,
> +			   struct dentry *new_dentry)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_INODE_LINK, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.inode.in.dir = dir;
> +	ep->CELL.inode.in.dentry = old_dentry;
> +	ep->CELL.inode.in.new_dentry = new_dentry;
> +	ep->CELL.inode.mode = 0;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_inode_unlink(struct inode *dir, struct dentry *dentry)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_INODE_UNLINK, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.inode.in.dir = dir;
> +	ep->CELL.inode.in.dentry = dentry;
> +	ep->CELL.inode.mode = 0;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_inode_symlink(struct inode *dir, struct dentry *dentry,
> +			      const char *old_name)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_INODE_SYMLINK, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.inode.in.dir = dir;
> +	ep->CELL.inode.in.dentry = dentry;
> +	ep->CELL.inode.in.old_name = old_name;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_inode_mkdir(struct inode *dir, struct dentry *dentry,
> +			    umode_t mode)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_INODE_MKDIR, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.inode.in.dir = dir;
> +	ep->CELL.inode.in.dentry = dentry;
> +	ep->CELL.inode.mode = mode;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_inode_rmdir(struct inode *dir, struct dentry *dentry)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_INODE_RMDIR, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.inode.in.dir = dir;
> +	ep->CELL.inode.in.dentry = dentry;
> +	ep->CELL.inode.mode = 0;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
> +			     struct inode *new_dir, struct dentry *new_dentry)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_INODE_RENAME, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.inode.in.dir = old_dir;
> +	ep->CELL.inode.in.new_dir = new_dir;
> +	ep->CELL.inode.in.dentry = old_dentry;
> +	ep->CELL.inode.in.new_dentry = new_dentry;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_inode_mknod(struct inode *dir, struct dentry *dentry,
> +			    umode_t mode, dev_t dev)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_INODE_MKNOD, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.inode.in.dir = dir;
> +	ep->CELL.inode.in.dentry = dentry;
> +	ep->CELL.inode.mode = mode;
> +	ep->CELL.inode.dev = dev;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_inode_setattr(struct mnt_idmap *idmap,
> +			      struct dentry *dentry, struct iattr *attr)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_INODE_SETATTR, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.inode_attr.in.dentry = dentry;
> +	ep->CELL.inode_attr.in.iattr = attr;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_inode_getattr(const struct path *path)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_INODE_GETATTR, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.inode_attr.in.path = path;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_inode_setxattr(struct mnt_idmap *idmap,
> +			       struct dentry *dentry, const char *name,
> +			       const void *value, size_t size, int flags)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_INODE_SETXATTR, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.inode_xattr.in.dentry = dentry;
> +	ep->CELL.inode_xattr.in.name = name;
> +	ep->CELL.inode_xattr.in.value = value;
> +	ep->CELL.inode_xattr.in.size = size;
> +	ep->CELL.inode_xattr.in.flags = flags;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_inode_getxattr(struct dentry *dentry, const char *name)
> +{
> +	struct tsem_event *ep = NULL;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_INODE_GETXATTR, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.inode_xattr.in.dentry = dentry;
> +	ep->CELL.inode_xattr.in.name = name;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_inode_listxattr(struct dentry *dentry)
> +{
> +	struct tsem_event *ep;
> +
> +	if (static_branch_unlikely(&tsem_not_ready))
> +		return 0;
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_INODE_LISTXATTR, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.inode_xattr.in.dentry = dentry;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_inode_removexattr(struct mnt_idmap *idmap,
> +				  struct dentry *dentry, const char *name)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_INODE_REMOVEXATTR, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.inode_xattr.in.dentry = dentry;
> +	ep->CELL.inode_xattr.in.name = name;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_INODE_KILLPRIV, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.inode.in.dentry = dentry;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_tun_dev_create(void)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_TUN_DEV_CREATE, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +	ep->no_params = true;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_tun_dev_attach_queue(void *security)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_TUN_DEV_ATTACH_QUEUE, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +	ep->no_params = true;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_tun_dev_attach(struct sock *sk, void *security)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_TUN_DEV_ATTACH, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.socket.in.socka = sk;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_tun_dev_open(void *security)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_TUN_DEV_OPEN, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +	ep->no_params = true;
> +
> +	return dispatch_event(ep);
> +}
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +static int tsem_bpf(int cmd, union bpf_attr *attr, unsigned int size)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_BPF, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.bpf.bpf.cmd = cmd;
> +	ep->CELL.bpf.bpf.size = size;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_bpf_map(struct bpf_map *map, fmode_t fmode)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_BPF_MAP, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.bpf.map.fmode = fmode;
> +	ep->CELL.bpf.map.map_type = map->map_type;
> +
> +	return dispatch_event(ep);
> +}
> +
> +static int tsem_bpf_prog(struct bpf_prog *prog)
> +{
> +	struct tsem_event *ep;
> +
> +	if (bypass_event())
> +		return 0;
> +
> +	ep = tsem_event_allocate(TSEM_BPF_PROG, NOLOCK);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	ep->CELL.bpf.prog.type = prog->type;
> +	ep->CELL.bpf.prog.attach_type = prog->expected_attach_type;
> +
> +	return dispatch_event(ep);
> +}
> +#endif
> +
> +static struct security_hook_list tsem_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(task_alloc, tsem_task_alloc),
> +	LSM_HOOK_INIT(task_free, tsem_task_free),
> +	LSM_HOOK_INIT(task_kill, tsem_task_kill),
> +	LSM_HOOK_INIT(task_setpgid, tsem_task_setpgid),
> +	LSM_HOOK_INIT(task_getpgid, tsem_task_getpgid),
> +	LSM_HOOK_INIT(task_getsid, tsem_task_getsid),
> +	LSM_HOOK_INIT(task_setnice, tsem_task_setnice),
> +	LSM_HOOK_INIT(task_setioprio, tsem_task_setioprio),
> +	LSM_HOOK_INIT(task_getioprio, tsem_task_getioprio),
> +	LSM_HOOK_INIT(task_prlimit, tsem_task_prlimit),
> +	LSM_HOOK_INIT(task_setrlimit, tsem_task_setrlimit),
> +	LSM_HOOK_INIT(task_setscheduler, tsem_task_setscheduler),
> +	LSM_HOOK_INIT(task_getscheduler, tsem_task_getscheduler),
> +	LSM_HOOK_INIT(task_prctl, tsem_task_prctl),
> +
> +	LSM_HOOK_INIT(ptrace_access_check, tsem_ptrace_access_check),
> +	LSM_HOOK_INIT(ptrace_traceme, tsem_ptrace_traceme),
> +
> +	LSM_HOOK_INIT(capget, tsem_capget),
> +	LSM_HOOK_INIT(capset, tsem_capset),
> +	LSM_HOOK_INIT(capable, tsem_capable),
> +
> +	LSM_HOOK_INIT(bprm_committed_creds, tsem_bprm_committed_creds),
> +
> +	LSM_HOOK_INIT(inode_alloc_security, tsem_inode_alloc_security),
> +	LSM_HOOK_INIT(inode_init_security, tsem_inode_init_security),
> +	LSM_HOOK_INIT(inode_free_security, tsem_inode_free_security),
> +
> +	LSM_HOOK_INIT(file_open, tsem_file_open),
> +	LSM_HOOK_INIT(mmap_file, tsem_mmap_file),
> +	LSM_HOOK_INIT(file_ioctl, tsem_file_ioctl),
> +	LSM_HOOK_INIT(file_lock, tsem_file_lock),
> +	LSM_HOOK_INIT(file_fcntl, tsem_file_fcntl),
> +	LSM_HOOK_INIT(file_receive, tsem_file_receive),
> +
> +	LSM_HOOK_INIT(unix_stream_connect, tsem_unix_stream_connect),
> +	LSM_HOOK_INIT(unix_may_send, tsem_unix_may_send),
> +
> +	LSM_HOOK_INIT(socket_post_create, tsem_socket_post_create),
> +	LSM_HOOK_INIT(socket_create, tsem_socket_create),
> +	LSM_HOOK_INIT(socket_connect, tsem_socket_connect),
> +	LSM_HOOK_INIT(socket_bind, tsem_socket_bind),
> +	LSM_HOOK_INIT(socket_accept, tsem_socket_accept),
> +	LSM_HOOK_INIT(socket_listen, tsem_socket_listen),
> +	LSM_HOOK_INIT(socket_socketpair, tsem_socket_socketpair),
> +	LSM_HOOK_INIT(socket_sendmsg, tsem_socket_sendmsg),
> +	LSM_HOOK_INIT(socket_recvmsg, tsem_socket_recvmsg),
> +	LSM_HOOK_INIT(socket_getsockname, tsem_socket_getsockname),
> +	LSM_HOOK_INIT(socket_getpeername, tsem_socket_getpeername),
> +	LSM_HOOK_INIT(socket_setsockopt, tsem_socket_setsockopt),
> +	LSM_HOOK_INIT(socket_shutdown, tsem_socket_shutdown),
> +
> +	LSM_HOOK_INIT(kernel_module_request, tsem_kernel_module_request),
> +	LSM_HOOK_INIT(kernel_load_data, tsem_kernel_load_data),
> +	LSM_HOOK_INIT(kernel_read_file, tsem_kernel_read_file),
> +
> +	LSM_HOOK_INIT(sb_mount, tsem_sb_mount),
> +	LSM_HOOK_INIT(sb_umount, tsem_sb_umount),
> +	LSM_HOOK_INIT(sb_remount, tsem_sb_remount),
> +	LSM_HOOK_INIT(sb_pivotroot, tsem_sb_pivotroot),
> +	LSM_HOOK_INIT(sb_statfs, tsem_sb_statfs),
> +	LSM_HOOK_INIT(move_mount, tsem_move_mount),
> +
> +	LSM_HOOK_INIT(shm_alloc_security, tsem_ipc_alloc),
> +	LSM_HOOK_INIT(shm_associate, tsem_shm_associate),
> +	LSM_HOOK_INIT(shm_shmctl, tsem_shm_shmctl),
> +	LSM_HOOK_INIT(shm_shmat, tsem_shm_shmat),
> +
> +	LSM_HOOK_INIT(sem_alloc_security, tsem_ipc_alloc),
> +	LSM_HOOK_INIT(sem_associate, tsem_sem_associate),
> +	LSM_HOOK_INIT(sem_semctl, tsem_sem_semctl),
> +	LSM_HOOK_INIT(sem_semop, tsem_sem_semop),
> +
> +	LSM_HOOK_INIT(syslog, tsem_syslog),
> +	LSM_HOOK_INIT(settime, tsem_settime),
> +
> +	LSM_HOOK_INIT(quotactl, tsem_quotactl),
> +	LSM_HOOK_INIT(quota_on, tsem_quota_on),
> +
> +	LSM_HOOK_INIT(msg_queue_alloc_security, tsem_ipc_alloc),
> +	LSM_HOOK_INIT(msg_queue_associate, tsem_msg_queue_associate),
> +	LSM_HOOK_INIT(msg_queue_msgctl, tsem_msg_queue_msgctl),
> +	LSM_HOOK_INIT(msg_queue_msgsnd, tsem_msg_queue_msgsnd),
> +	LSM_HOOK_INIT(msg_queue_msgrcv, tsem_msg_queue_msgrcv),
> +
> +	LSM_HOOK_INIT(ipc_permission, tsem_ipc_permission),
> +
> +#ifdef CONFIG_KEYS
> +	LSM_HOOK_INIT(key_alloc, tsem_key_alloc),
> +	LSM_HOOK_INIT(key_permission, tsem_key_permission),
> +#endif
> +
> +	LSM_HOOK_INIT(netlink_send, tsem_netlink_send),
> +
> +	LSM_HOOK_INIT(inode_create, tsem_inode_create),
> +	LSM_HOOK_INIT(inode_link, tsem_inode_link),
> +	LSM_HOOK_INIT(inode_unlink, tsem_inode_unlink),
> +	LSM_HOOK_INIT(inode_symlink, tsem_inode_symlink),
> +	LSM_HOOK_INIT(inode_mkdir, tsem_inode_mkdir),
> +	LSM_HOOK_INIT(inode_rmdir, tsem_inode_rmdir),
> +	LSM_HOOK_INIT(inode_mknod, tsem_inode_mknod),
> +	LSM_HOOK_INIT(inode_rename, tsem_inode_rename),
> +	LSM_HOOK_INIT(inode_setattr, tsem_inode_setattr),
> +	LSM_HOOK_INIT(inode_getattr, tsem_inode_getattr),
> +	LSM_HOOK_INIT(inode_setxattr, tsem_inode_setxattr),
> +	LSM_HOOK_INIT(inode_getxattr, tsem_inode_getxattr),
> +	LSM_HOOK_INIT(inode_listxattr, tsem_inode_listxattr),
> +	LSM_HOOK_INIT(inode_removexattr, tsem_inode_removexattr),
> +	LSM_HOOK_INIT(inode_killpriv, tsem_inode_killpriv),
> +
> +	LSM_HOOK_INIT(tun_dev_create, tsem_tun_dev_create),
> +	LSM_HOOK_INIT(tun_dev_attach_queue, tsem_tun_dev_attach_queue),
> +	LSM_HOOK_INIT(tun_dev_attach, tsem_tun_dev_attach),
> +	LSM_HOOK_INIT(tun_dev_open, tsem_tun_dev_open),
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +	LSM_HOOK_INIT(bpf, tsem_bpf),
> +	LSM_HOOK_INIT(bpf_map, tsem_bpf_map),
> +	LSM_HOOK_INIT(bpf_prog, tsem_bpf_prog)
> +#endif
> +};
> +
> +static int configure_root_digest(void)
> +{
> +	int retn = 0;
> +	char *digest = NULL;
> +	u8 zero_digest[HASH_MAX_DIGESTSIZE];
> +	struct crypto_shash *tfm;
> +	SHASH_DESC_ON_STACK(shash, tfm);
> +
> +	if (default_hash_function && crypto_has_shash(default_hash_function,
> +						      0, 0)) {
> +		digest = default_hash_function;
> +		pr_warn("tsem: Using digest %s from command-line.\n", digest);
> +	}
> +	if (!digest && default_hash_function)
> +		pr_warn("tsem: Unknown root digest %s, using sha256.\n",
> +			default_hash_function);
> +	if (!digest)
> +		digest = "sha256";
> +
> +	tsem_context(current)->digestname = kstrdup(digest, GFP_KERNEL);
> +	if (!tsem_context(current)->digestname)
> +		return -ENOMEM;
> +
> +	tfm = crypto_alloc_shash(digest, 0, 0);
> +	if (IS_ERR(tfm))
> +		return PTR_ERR(tfm);
> +
> +	shash->tfm = tfm;
> +	retn = crypto_shash_digest(shash, NULL, 0, zero_digest);
> +	if (retn)
> +		goto done;
> +
> +	tsem_context(current)->tfm = tfm;
> +	memcpy(root_context.zero_digest, zero_digest,
> +	       crypto_shash_digestsize(tfm));
> +
> + done:
> +	if (retn) {
> +		kfree(tsem_context(current)->digestname);
> +		crypto_free_shash(tfm);
> +	}
> +
> +	return retn;
> +}
> +
> +static int __init set_ready(void)
> +{
> +	int retn;
> +
> +	if (!tsem_available)
> +		return 0;
> +
> +	retn = configure_root_digest();
> +	if (retn)
> +		goto done;
> +
> +	retn = tsem_model_add_aggregate();
> +	if (retn)
> +		goto done;
> +
> +	retn = tsem_fs_init();
> +	if (retn)
> +		goto done;
> +
> +	if (tsem_mode == EXPORT_ONLY) {
> +		retn = tsem_ns_export_root(magazine_size);
> +		if (retn)
> +			goto done;
> +	}
> +
> +	pr_info("tsem: Now active.\n");
> +	static_branch_disable(&tsem_not_ready);
> +
> + done:
> +	return retn;
> +}
> +
> +late_initcall(set_ready);
> +
> +/**
> + * tesm_init() - Register Trusted Security Event Modeling LSM.
> + *
> + * This function is responsible for initializing the TSEM LSM.  It is
> + * invoked at the fs_initcall level.  In addition to configuring the
> + * LSM hooks this function initializes the Trusted Modeling Agent
> + * context including the event actions.  The cache from which
> + * the tsem_event description structures is also initialized.
> + *
> + * Return: If the TSEM LSM is successfully initialized a value of zero
> + *	   is returned.  A non-zero error code is returned if
> + *	   initialization fails.  Currently the only failure mode can
> + *	   come from the initialization of the tsem_event cache.
> + */
> +static int __init tsem_init(void)
> +{
> +	int retn;
> +	char *msg;
> +	struct tsem_task *tsk = tsem_task(current);
> +	struct tsem_context *ctx = &root_context;
> +	struct tsem_model *model = &root_model;
> +
> +	security_add_hooks(tsem_hooks, ARRAY_SIZE(tsem_hooks), &tsem_lsmid);
> +
> +	tsk->context = ctx;
> +	kref_init(&ctx->kref);
> +	kref_get(&ctx->kref);
> +
> +	mutex_init(&ctx->inode_mutex);
> +	INIT_LIST_HEAD(&ctx->inode_list);
> +
> +	root_context.model = &root_model;
> +
> +	retn = tsem_event_cache_init();
> +	if (retn)
> +		return retn;
> +	retn = tsem_event_magazine_allocate(ctx, magazine_size);
> +	if (retn)
> +		goto done;
> +
> +	memcpy(ctx->actions, tsem_root_actions, sizeof(tsem_root_actions));
> +
> +	retn = tsem_model_cache_init(model, magazine_size);
> +	if (retn)
> +		goto done;
> +
> +	retn = tsem_export_cache_init();
> +	if (retn)
> +		goto done;
> +
> +	switch (tsem_mode) {
> +	case FULL_MODELING:
> +		msg = "full";
> +		break;
> +	case NO_ROOT_MODELING:
> +		msg = "namespace only";
> +		break;
> +	case EXPORT_ONLY:
> +		msg = "export";
> +		break;
> +	}
> +	pr_info("tsem: Initialized %s modeling.\n", msg);
> +
> +	tsem_available = true;
> +	tsk->trust_status = TSEM_TASK_TRUSTED;
> +	retn = 0;
> +
> + done:
> +	if (retn) {
> +		tsem_event_magazine_free(ctx);
> +		tsem_model_magazine_free(model);
> +	}
> +	return retn;
> +}
> +
> +DEFINE_LSM(tsem) = {
> +	.name = "tsem",
> +	.init = tsem_init,
> +	.blobs = &tsem_blob_sizes,
> +};

