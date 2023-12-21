Return-Path: <linux-kernel+bounces-8959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4E481BE85
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B014B2406F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E3E6518D;
	Thu, 21 Dec 2023 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cx6A1Qsg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D296518A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Swzrf33jNzMqcgN;
	Thu, 21 Dec 2023 18:45:22 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Swzrd39yhz3Z;
	Thu, 21 Dec 2023 19:45:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1703184322;
	bh=EXsauPF/6y5U4q7Zy4qc2/K5W/Ae5AZN6LUc/21+7n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cx6A1QsgaKMcvMzeGhH2aucCyLOvrT2g8zhrSudRRcUupNq2RVVHNspOa7g6OjTha
	 voqoegstjYjHtLz5baP71+PDVi7Wk6CeZasQyHsevPCDPlhQJ8GG94pNr3ED89a+2y
	 MNX3UJTOOUDNLi4eRx33oG2/WeHuxEs7ofbSjho8=
Date: Thu, 21 Dec 2023 19:45:16 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/7] landlock: Log ruleset creation and release
Message-ID: <20231221.eij3poa3Se4b@digikod.net>
References: <20230921061641.273654-1-mic@digikod.net>
 <20230921061641.273654-4-mic@digikod.net>
 <CAHC9VhQTvFp+i=j7t+55EnG44xg=Pmvkh=Oq=e7ddJWDZXLeSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQTvFp+i=j7t+55EnG44xg=Pmvkh=Oq=e7ddJWDZXLeSA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Dec 20, 2023 at 04:22:15PM -0500, Paul Moore wrote:
> On Thu, Sep 21, 2023 at 2:17 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > Add audit support for ruleset/domain creation and release. Ruleset and
> > domain IDs are generated from the same 64-bit counter to avoid confusing
> > them. There is no need to hide the sequentiality to users that are
> > already allowed to read logs.  In the future, if these IDs were to be
> > viewable by unprivileged users, then we'll need to scramble them.
> >
> > Add a new AUDIT_LANDLOCK record type.
> 
> When adding new audit records we generally ask people to include
> examples taken from their testing to the commit description.

OK, I'll add that in the next series.

> 
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  include/uapi/linux/audit.h   |   1 +
> >  security/landlock/Makefile   |   2 +
> >  security/landlock/audit.c    | 119 +++++++++++++++++++++++++++++++++++
> >  security/landlock/audit.h    |  35 +++++++++++
> >  security/landlock/ruleset.c  |   6 ++
> >  security/landlock/ruleset.h  |  10 +++
> >  security/landlock/syscalls.c |   8 +++
> >  7 files changed, 181 insertions(+)
> >  create mode 100644 security/landlock/audit.c
> >  create mode 100644 security/landlock/audit.h
> 
> ...
> 
> > diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> > new file mode 100644
> > index 000000000000..f58bd529784a
> > --- /dev/null
> > +++ b/security/landlock/audit.c
> > @@ -0,0 +1,119 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Landlock LSM - Audit helpers
> > + *
> > + * Copyright © 2023 Microsoft Corporation
> > + */
> > +
> > +#include <linux/atomic.h>
> > +#include <linux/audit.h>
> > +#include <linux/lsm_audit.h>
> > +
> > +#include "audit.h"
> > +#include "cred.h"
> > +
> > +atomic64_t ruleset_and_domain_counter = ATOMIC64_INIT(0);
> > +
> > +#define BIT_INDEX(bit) HWEIGHT(bit - 1)
> > +
> > +static void log_accesses(struct audit_buffer *const ab,
> > +                        const access_mask_t accesses)
> > +{
> > +       const char *const desc[] = {
> > +               [BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] = "execute",
> > +               [BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] = "write_file",
> > +               [BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] = "read_file",
> > +               [BIT_INDEX(LANDLOCK_ACCESS_FS_READ_DIR)] = "read_dir",
> > +               [BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_DIR)] = "remove_dir",
> > +               [BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_FILE)] = "remove_file",
> > +               [BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_CHAR)] = "make_char",
> > +               [BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_DIR)] = "make_dir",
> > +               [BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_REG)] = "make_reg",
> > +               [BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_SOCK)] = "make_sock",
> > +               [BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_FIFO)] = "make_fifo",
> > +               [BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_BLOCK)] = "make_block",
> > +               [BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_SYM)] = "make_sym",
> > +               [BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "refer",
> > +               [BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "truncate",
> > +       };
> > +       const unsigned long access_mask = accesses;
> > +       unsigned long access_bit;
> > +       bool is_first = true;
> > +
> > +       BUILD_BUG_ON(ARRAY_SIZE(desc) != LANDLOCK_NUM_ACCESS_FS);
> > +
> > +       for_each_set_bit(access_bit, &access_mask, ARRAY_SIZE(desc)) {
> > +               audit_log_format(ab, "%s%s", is_first ? "" : ",",
> > +                                desc[access_bit]);
> > +               is_first = false;
> > +       }
> > +}
> > +
> > +/* Inspired by dump_common_audit_data(). */
> > +static void log_task(struct audit_buffer *const ab)
> > +{
> > +       /* 16 bytes (TASK_COMM_LEN) */
> > +       char comm[sizeof(current->comm)];
> > +
> > +       /*
> > +        * Uses task_pid_nr() instead of task_tgid_nr() because of how
> > +        * credentials and Landlock work.
> > +        */
> > +       audit_log_format(ab, "tid=%d comm=", task_pid_nr(current));
> > +       audit_log_untrustedstring(ab,
> > +                                 memcpy(comm, current->comm, sizeof(comm)));
> > +}
> 
> Depending on how log_task() is used, it may be redundant with respect
> to the existing SYSCALL record.  Yes, there is already redundancy with
> the AVC record, but that is a legacy problem and not something we can
> easily fix, but given that the Landlock records are new we have an
> opportunity to do things properly :)

Indeed, it would make it simpler too. I wasn't sure how standalone a
record should be, but I guess there tools should be able to look for a
set of related records (e.g. event with a SYSCALL record matching a PID
and a LANDLOCK record).

> 
> > +void landlock_log_create_ruleset(struct landlock_ruleset *const ruleset)
> > +{
> > +       struct audit_buffer *ab;
> > +
> > +       WARN_ON_ONCE(ruleset->id);
> > +
> > +       ab = audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_LANDLOCK);
> > +       if (!ab)
> > +               /* audit_log_lost() call */
> > +               return;
> > +
> > +       ruleset->id = atomic64_inc_return(&ruleset_and_domain_counter);
> > +       log_task(ab);
> > +       audit_log_format(ab,
> > +                        " op=create-ruleset ruleset=%llu handled_access_fs=",
> > +                        ruleset->id);
> 
> "handled_access_fs" seems a bit long for a field name, is there any
> reason why it couldn't simply be "access_fs" or something similar?

"handled_access_fs" is from the landlock_create_ruleset(2) API, so I'd
like to use the same name. However, because the types of handled access
rights for a ruleset will expand (e.g. we now have a
handled_access_net), I'm wondering if it would be better to keep this
(growing) one-line record or if we should use several records for a
ruleset creation (i.e. one line per type of handled access righs).

> 
> > +       log_accesses(ab, ruleset->fs_access_masks[ruleset->num_layers - 1]);
> > +       audit_log_end(ab);
> > +}
> > +
> > +/*
> > + * This is useful to know when a domain or a ruleset will never show again in
> > + * the audit log.
> > + */
> > +void landlock_log_release_ruleset(const struct landlock_ruleset *const ruleset)
> > +{
> > +       struct audit_buffer *ab;
> > +       const char *name;
> > +       u64 id;
> > +
> > +       ab = audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_LANDLOCK);
> > +       if (!ab)
> > +               /* audit_log_lost() call */
> > +               return;
> > +
> > +       /* It should either be a domain or a ruleset. */
> > +       if (ruleset->hierarchy) {
> > +               name = "domain";
> 
> Perhaps I missed it, but I didn't see an audit record with
> "op=create-domain", is there one?  If there is no audit record for
> creating a Landlock domain, why do we care about releasing a Landlock
> domain?
> 
> [NOTE: I see that domain creation is audited in patch 4, I would
> suggest reworking the patchset so the ruleset auditing is in one
> patch, domain auditing another ... or just squash the two patches.
> Either approach would be preferable to this approach.]

Domain creation is indeed recorded with the restrict_self operation from
the next patch. I'll rework and extend these patches to get something
more consistent.

> 
> > +               id = ruleset->hierarchy->id;
> > +               WARN_ON_ONCE(ruleset->id);
> > +       } else {
> > +               name = "ruleset";
> > +               id = ruleset->id;
> > +       }
> > +       WARN_ON_ONCE(!id);
> > +
> > +       /*
> > +        * Because this might be called by kernel threads, logging
> > +        * related task information with log_task() would be useless.
> > +        */
> > +       audit_log_format(ab, "op=release-%s %s=%llu", name, name, id);
> 
> This starts to get a little tricky.  The general guidance is that for
> a given audit record type, e.g. AUDIT_LANDLOCK, there should be no
> change in presence or ordering of fields, yet in
> landlock_log_create_ruleset() we log the permission information and
> here in landlock_log_release_ruleset() we do not.  The easy fix is to
> record the permission information here as well, or simply use a
> "handled_access_fs=?" placeholder.  Something to keep in mind as you
> move forward.

OK, I used different "op" to specify the related fields, but I should
use a dedicated record type when it makes sense instead. My reasoning
was that it would be easier to filter on one or two record types, but
I like the fixed set of fields per record type.

I plan to add a few record types, something like that:

For a ruleset creation event, several grouped records:
- AUDIT_LANDLOCK_RULESET: "id=[new ruleset ID] op=create"
- AUDIT_LANDLOCK_ACCESS: "type=[fs or net] rights=[bitmask]"

For rule addition, several records per landlock_add_rule(2) call.
Example with a path_beneath rule:
- AUDIT_LANDLOCK_RULESET: "id=[ruleset ID] op=add_rule"
- AUDIT_LANDLOCK_PATH: "scope=beneath path=[file path] dev= ino="
- AUDIT_LANDLOCK_ACCESS: "type=fs rights=[bitmask]"

Example with a net_port rule:
- AUDIT_LANDLOCK_RULESET: "id=[ruleset ID] op=add_rule"
- AUDIT_LANDLOCK_PORT: "port="
- AUDIT_LANDLOCK_ACCESS: "type=net rights=[bitmask]"

For domain creation/restriction:
- AUDIT_LANDLOCK_DOMAIN: "id=[new domain ID] op=create"
- AUDIT_LANDLOCK_RULESET: "id=[ruleset ID] op=use"

For ruleset release:
- AUDIT_LANDLOCK_RULESET: "id=[ruleset ID] op=release"

For domain release:
- AUDIT_LANDLOCK_DOMAIN: "id=[domain ID] op=release"

For denied FS access:
- AUDIT_LANDLOCK_DENIAL: "id=[domain ID] op=mkdir"
- AUDIT_LANDLOCK_PATH: "scope=exact path=[file path] dev= ino="

For denied net access:
- AUDIT_LANDLOCK_DENIAL: "id=[domain ID] op=connect"
- AUDIT_LANDLOCK_PORT: "port="

It may not be worth it to differenciate between domain and ruleset for
audit though.

What do you think?

I guess it will still be OK to expand a record type with new appended
fields right? For instance, could we append a "flags" field to a
AUDIT_LANDLOCK_RULESET record (because it may not make sense to create a
dedicated record type for that)?

> 
> > +       audit_log_end(ab);
> > +}
> 
> --
> paul-moore.com

