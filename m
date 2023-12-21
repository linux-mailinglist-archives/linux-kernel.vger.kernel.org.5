Return-Path: <linux-kernel+bounces-8997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A52E381BF1A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B1F1F22741
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3475651B6;
	Thu, 21 Dec 2023 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="gbsSrKQa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC38651AD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SwzvM3WT2zMpvn6;
	Thu, 21 Dec 2023 18:47:43 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SwzvL5s6czMpnPc;
	Thu, 21 Dec 2023 19:47:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1703184463;
	bh=ihKZ9/9Nu3FIEKBVZmn+cxwP3cY4ydFvIOriawEZ2hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbsSrKQanKGS3Ae+aAOHcqWLg0yMM0rw7tT7KBVY5SgpIATiyZEcunKvxxOZRvjr3
	 HUTtTk3stKPVbVsKxw+85VKhKCEfRj/1AmIw0d4ucDykcothCQlU0z0j3OdMYWbAYP
	 5hYxetvpLbFWyuHxO4wToNrwvu14YRJe8UdWl840=
Date: Thu, 21 Dec 2023 19:47:40 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 5/7] landlock: Log file-related requests
Message-ID: <20231221.inae1eThoeva@digikod.net>
References: <20230921061641.273654-1-mic@digikod.net>
 <20230921061641.273654-6-mic@digikod.net>
 <CAHC9VhQJPXJQCmXPUxOE3wXArUcgfDi98FO=VhRBgBgdueyAOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQJPXJQCmXPUxOE3wXArUcgfDi98FO=VhRBgBgdueyAOQ@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Dec 20, 2023 at 04:22:33PM -0500, Paul Moore wrote:
> On Thu, Sep 21, 2023 at 2:17 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > Add audit support for mkdir, mknod, symlink, unlink, rmdir, truncate,
> > and open requests.
> >
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  security/landlock/audit.c | 114 ++++++++++++++++++++++++++++++++++++++
> >  security/landlock/audit.h |  32 +++++++++++
> >  security/landlock/fs.c    |  62 ++++++++++++++++++---
> >  3 files changed, 199 insertions(+), 9 deletions(-)
> >
> > diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> > index d9589d07e126..148fc0fafef4 100644
> > --- a/security/landlock/audit.c
> > +++ b/security/landlock/audit.c
> > @@ -14,6 +14,25 @@
> >
> >  atomic64_t ruleset_and_domain_counter = ATOMIC64_INIT(0);
> >
> > +static const char *op_to_string(enum landlock_operation operation)
> > +{
> > +       const char *const desc[] = {
> > +               [0] = "",
> > +               [LANDLOCK_OP_MKDIR] = "mkdir",
> > +               [LANDLOCK_OP_MKNOD] = "mknod",
> > +               [LANDLOCK_OP_SYMLINK] = "symlink",
> > +               [LANDLOCK_OP_UNLINK] = "unlink",
> > +               [LANDLOCK_OP_RMDIR] = "rmdir",
> > +               [LANDLOCK_OP_TRUNCATE] = "truncate",
> > +               [LANDLOCK_OP_OPEN] = "open",
> > +       };
> 
> If you're going to be using a single AUDIT_LANDLOCK record type, do
> you want to somehow encode that the above are access/permission
> requests in the "op=" field name?

I'll use several audit record types, one for a denial and others for the
related kernel objects. See my other reply.

> 
> > +static void
> > +log_request(const int error, struct landlock_request *const request,
> > +           const struct landlock_ruleset *const domain,
> > +           const access_mask_t access_request,
> > +           const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
> > +{
> > +       struct audit_buffer *ab;
> > +
> > +       if (WARN_ON_ONCE(!error))
> > +               return;
> > +       if (WARN_ON_ONCE(!request))
> > +               return;
> > +       if (WARN_ON_ONCE(!domain || !domain->hierarchy))
> > +               return;
> > +
> > +       /* Uses GFP_ATOMIC to not sleep. */
> > +       ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
> > +                            AUDIT_LANDLOCK);
> > +       if (!ab)
> > +               return;
> > +
> > +       update_request(request, domain, access_request, layer_masks);
> > +
> > +       log_task(ab);
> > +       audit_log_format(ab, " domain=%llu op=%s errno=%d missing-fs-accesses=",
> > +                        request->youngest_domain,
> > +                        op_to_string(request->operation), -error);
> > +       log_accesses(ab, request->missing_access);
> > +       audit_log_lsm_data(ab, &request->audit);
> > +       audit_log_end(ab);
> > +}
> 
> See my previous comments about record format consistency.

right

> 
> --
> paul-moore.com
> 

