Return-Path: <linux-kernel+bounces-8948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCEC81BE6D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1431C24B55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8129164AAD;
	Thu, 21 Dec 2023 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Jz8p7OLm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EF31F601
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SwzsQ3Q0nzMqGk7;
	Thu, 21 Dec 2023 18:46:02 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SwzsP3FQGzMpnPr;
	Thu, 21 Dec 2023 19:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1703184362;
	bh=deZ4ghKKW+5Po8LBWBxHHxYPzl2S7/Qg+OvXDshhnrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jz8p7OLmX78jTpuk4kL02zFarFURPfJdjmw6+227t89uuSC68b28T/PC/SkASES5u
	 ckyTHkqqxniGinRQFpTFRYcLcqT9KoaXxnRqoFX1DR45RdqCqjlda9qA/c1f5TelyL
	 djbtHsneUnctKlH+l2sewJbAGYIsN/7/Nz9my3pY=
Date: Thu, 21 Dec 2023 19:45:58 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 4/7] landlock: Log domain creation and enforcement
Message-ID: <20231221.doe8Aebae8vi@digikod.net>
References: <20230921061641.273654-1-mic@digikod.net>
 <20230921061641.273654-5-mic@digikod.net>
 <CAHC9VhQ3fqq6bP=eco1hk=AoMa=5QNyXHCzNw5RZt92y9Z7T2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ3fqq6bP=eco1hk=AoMa=5QNyXHCzNw5RZt92y9Z7T2g@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Dec 20, 2023 at 04:22:22PM -0500, Paul Moore wrote:
> On Thu, Sep 21, 2023 at 2:17 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > Add audit support for domain creation, i.e. task self-restriction.
> >
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  security/landlock/audit.c    | 24 ++++++++++++++++++++++++
> >  security/landlock/audit.h    |  8 ++++++++
> >  security/landlock/syscalls.c |  4 ++++
> >  3 files changed, 36 insertions(+)
> >
> > diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> > index f58bd529784a..d9589d07e126 100644
> > --- a/security/landlock/audit.c
> > +++ b/security/landlock/audit.c
> > @@ -84,6 +84,30 @@ void landlock_log_create_ruleset(struct landlock_ruleset *const ruleset)
> >         audit_log_end(ab);
> >  }
> >
> > +void landlock_log_restrict_self(struct landlock_ruleset *const domain,
> > +                               struct landlock_ruleset *const ruleset)
> > +{
> > +       struct audit_buffer *ab;
> > +
> > +       WARN_ON_ONCE(domain->id);
> > +       WARN_ON_ONCE(!ruleset->id);
> > +
> > +       ab = audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_LANDLOCK);
> > +       if (!ab)
> > +               /* audit_log_lost() call */
> > +               return;
> > +
> > +       domain->hierarchy->id =
> > +               atomic64_inc_return(&ruleset_and_domain_counter);
> > +       log_task(ab);
> > +       audit_log_format(ab, " op=restrict-self domain=%llu ruleset=%llu",
> > +                        domain->hierarchy->id, ruleset->id);
> 
> If domain creation and self restriction are the same, I would suggest
> going with "op=create-domain" so it better matches "op=release-domain"
> in patch 3/7.

OK, I'll do something more consistent.

> 
> Also see my previous comment about consistency between AUDIT_LANDLOCK records.
> 
> > +       audit_log_format(
> > +               ab, " parent=%llu",
> > +               domain->hierarchy->parent ? domain->hierarchy->parent->id : 0);
> > +       audit_log_end(ab);
> > +}
> 
> --
> paul-moore.com
> 

