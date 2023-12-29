Return-Path: <linux-kernel+bounces-13188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDBB8200E0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92A20B20F84
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDF412B87;
	Fri, 29 Dec 2023 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zqv3s5U2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7B12B7F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T1t4653dHzMpxkL;
	Fri, 29 Dec 2023 17:42:14 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4T1t452rQczMpnPq;
	Fri, 29 Dec 2023 18:42:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1703871734;
	bh=yxUY4HvifwhIdQDXg0BhIWNVhCeEvKiRMKXW9dHUAkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zqv3s5U2HPz37FjM7fzezy6GWh/AQT6c6R25U+YkBFAHGq1Pao+byQ3p6+HTADsJd
	 mQBqjyvSepPqq67JXLV4uDF/HAdupaGSaJYukGJ9mjtu3vly2Gyg4PUT2zVCJphvsw
	 +4agC2B9d83cbjy36nWJPi0Z7n2g4Re4viJoFu7U=
Date: Fri, 29 Dec 2023 18:42:06 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/7] landlock: Log ruleset creation and release
Message-ID: <20231229.aex0ijae2The@digikod.net>
References: <20230921061641.273654-1-mic@digikod.net>
 <20230921061641.273654-4-mic@digikod.net>
 <CAHC9VhQTvFp+i=j7t+55EnG44xg=Pmvkh=Oq=e7ddJWDZXLeSA@mail.gmail.com>
 <20231221.eij3poa3Se4b@digikod.net>
 <CAHC9VhRiUOe9enkCOko0mGehxt+2tbJNGoJm=jmauhZSPFvzRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRiUOe9enkCOko0mGehxt+2tbJNGoJm=jmauhZSPFvzRg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Dec 22, 2023 at 05:42:35PM -0500, Paul Moore wrote:
> On Thu, Dec 21, 2023 at 1:45 PM Mickaël Salaün <mic@digikod.net> wrote:
> > On Wed, Dec 20, 2023 at 04:22:15PM -0500, Paul Moore wrote:
> > > On Thu, Sep 21, 2023 at 2:17 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > >
> > > > Add audit support for ruleset/domain creation and release ...
> 
> ...
> 
> > > > +/* Inspired by dump_common_audit_data(). */
> > > > +static void log_task(struct audit_buffer *const ab)
> > > > +{
> > > > +       /* 16 bytes (TASK_COMM_LEN) */
> > > > +       char comm[sizeof(current->comm)];
> > > > +
> > > > +       /*
> > > > +        * Uses task_pid_nr() instead of task_tgid_nr() because of how
> > > > +        * credentials and Landlock work.
> > > > +        */
> > > > +       audit_log_format(ab, "tid=%d comm=", task_pid_nr(current));
> > > > +       audit_log_untrustedstring(ab,
> > > > +                                 memcpy(comm, current->comm, sizeof(comm)));
> > > > +}
> > >
> > > Depending on how log_task() is used, it may be redundant with respect
> > > to the existing SYSCALL record.  Yes, there is already redundancy with
> > > the AVC record, but that is a legacy problem and not something we can
> > > easily fix, but given that the Landlock records are new we have an
> > > opportunity to do things properly :)
> >
> > Indeed, it would make it simpler too. I wasn't sure how standalone a
> > record should be, but I guess there tools should be able to look for a
> > set of related records (e.g. event with a SYSCALL record matching a PID
> > and a LANDLOCK record).
> 
> I believe ausearch will output the entire event when it matches on a
> field in one of the event's records.

Right, and the man page talks about that.

> 
> > > > +void landlock_log_create_ruleset(struct landlock_ruleset *const ruleset)
> > > > +{
> > > > +       struct audit_buffer *ab;
> > > > +
> > > > +       WARN_ON_ONCE(ruleset->id);
> > > > +
> > > > +       ab = audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_LANDLOCK);
> > > > +       if (!ab)
> > > > +               /* audit_log_lost() call */
> > > > +               return;
> > > > +
> > > > +       ruleset->id = atomic64_inc_return(&ruleset_and_domain_counter);
> > > > +       log_task(ab);
> > > > +       audit_log_format(ab,
> > > > +                        " op=create-ruleset ruleset=%llu handled_access_fs=",
> > > > +                        ruleset->id);
> > >
> > > "handled_access_fs" seems a bit long for a field name, is there any
> > > reason why it couldn't simply be "access_fs" or something similar?
> >
> > "handled_access_fs" is from the landlock_create_ruleset(2) API, so I'd
> > like to use the same name.
> 
> Okay, that's a reasonable reason.
> 
> > However, because the types of handled access
> > rights for a ruleset will expand (e.g. we now have a
> > handled_access_net), I'm wondering if it would be better to keep this
> > (growing) one-line record or if we should use several records for a
> > ruleset creation (i.e. one line per type of handled access righs).
> 
> I think it would be better to have a single record for rulesets rather
> than multiple records all dealing with rulesets.

I guess you mean to not create multiple record types specific to ruleset
creation. Reusing existing record types (e.g. path) should be OK even
for a ruleset creation. However, as proposed below, we might still want
a LANDLOCK_ACCESS record type (that can be reused for denied accesses).

> 
> > > > +               id = ruleset->hierarchy->id;
> > > > +               WARN_ON_ONCE(ruleset->id);
> > > > +       } else {
> > > > +               name = "ruleset";
> > > > +               id = ruleset->id;
> > > > +       }
> > > > +       WARN_ON_ONCE(!id);
> > > > +
> > > > +       /*
> > > > +        * Because this might be called by kernel threads, logging
> > > > +        * related task information with log_task() would be useless.
> > > > +        */
> > > > +       audit_log_format(ab, "op=release-%s %s=%llu", name, name, id);
> > >
> > > This starts to get a little tricky.  The general guidance is that for
> > > a given audit record type, e.g. AUDIT_LANDLOCK, there should be no
> > > change in presence or ordering of fields, yet in
> > > landlock_log_create_ruleset() we log the permission information and
> > > here in landlock_log_release_ruleset() we do not.  The easy fix is to
> > > record the permission information here as well, or simply use a
> > > "handled_access_fs=?" placeholder.  Something to keep in mind as you
> > > move forward.
> >
> > OK, I used different "op" to specify the related fields, but I should
> > use a dedicated record type when it makes sense instead. My reasoning
> > was that it would be easier to filter on one or two record types, but
> > I like the fixed set of fields per record type.
> >
> > I plan to add a few record types, something like that:
> >
> > For a ruleset creation event, several grouped records:
> > - AUDIT_LANDLOCK_RULESET: "id=[new ruleset ID] op=create"
> > - AUDIT_LANDLOCK_ACCESS: "type=[fs or net] rights=[bitmask]"
> 
> I'm guessing that LANDLOCK_RULESET would be for policy changes, and
> LANDLOCK_ACCESS would be for individual access grants or denials?  If
> so, that looks reasonable.

I was thinking about using LANDLOCK_ACCESS for both ruleset creation and
denied accesses. That would mkae a ruleset creation event easier to
parse and more flexible. Does that look good?

Otherwise, we can use this instead:

- AUDIT_LANDLOCK_RULESET: "ruleset=[new ruleset ID]
  handled_access_fs=[bitmask] handled_access_net=[bitmask]"

> 
> > For rule addition, several records per landlock_add_rule(2) call.
> > Example with a path_beneath rule:
> > - AUDIT_LANDLOCK_RULESET: "id=[ruleset ID] op=add_rule"
> > - AUDIT_LANDLOCK_PATH: "scope=beneath path=[file path] dev= ino="
> > - AUDIT_LANDLOCK_ACCESS: "type=fs rights=[bitmask]"
> 
> I worry that LANDLOCK_PATH is too much of a duplicate for the existing
> PATH record.  Assuming the "scope=" field is important, could it live
> in the LANDLOCK_ACCESS record and then you could do away with the
> dedicated LANDLOCK_PATH record?  Oh, wait ... this is to record the
> policy, not a individual access request, gotcha.  If that is the case
> and RULESET, PATH, ACCESS are all used simply to record the policy
> information I might suggest creation of an AUDIT_LANDLOCK_POLICY
> record that captures all of the above.  If you think that is too
> cumbersome, then perhaps you can do the object/access-specific record
> type, e.g. AUDIT_LANDLOCK_POLICY_FS and AUDIT_LANDLOCK_POLICY_NET.

OK, what about this records for *one* rule addition event?

- AUDIT_LANDLOCK_RULE: "ruleset=[ruleset ID] rule_type=path_beneath
  allowed_access=[bitmask]"
- AUDIT_PATH: "path=[file path] dev= ino= ..."

However, because struct landlock_path_beneath_attr can evolve and get
new fields which might be differents than the landlock_net_port_attr's
ones, wouldn't it be wiser to use a dedicated AUDIT_LANDLOCK_RULE_FS or
AUDIT_LANDLOCK_RULE_PATH_BENEATH record type? These names are getting a
bit long though, but types match the UAPI.

> 
> You also shouldn't reuse the "type=" field.  Steve gets grumpy when
> people reuse field names for different things.  You can find a
> reasonably complete list of fields here:
> https://github.com/linux-audit/audit-documentation/blob/main/specs/fields/field-dictionary.csv

OK

> 
> > For domain creation/restriction:
> > - AUDIT_LANDLOCK_DOMAIN: "id=[new domain ID] op=create"
> > - AUDIT_LANDLOCK_RULESET: "id=[ruleset ID] op=use"
> 
> I imagine you could capture this in the policy record type?

What about this?

- AUDIT_LANDLOCK_RESTRICT: "ruleset=[ruleset ID] domain=[new domain ID]
  restrict_type=self"

> 
> > For ruleset release:
> > - AUDIT_LANDLOCK_RULESET: "id=[ruleset ID] op=release"
> >
> > For domain release:
> > - AUDIT_LANDLOCK_DOMAIN: "id=[domain ID] op=release"
> 
> Same with the above two.

- AUDIT_LANDLOCK_RELEASE: "id=[ruleset or domain ID]
  release_type=[ruleset or domain]"

The issue with this record is that the "id" field is not the same as for
AUDIT_LANDLOCK_{RESTRICT,RULE}... To have "domain" or "ruleset" fields,
a dedicated record type would be cleaner:
AUDIT_LANDLOCK_RELEASE_{RULESET,DOMAIN}.

> 
> > For denied FS access:
> > - AUDIT_LANDLOCK_DENIAL: "id=[domain ID] op=mkdir"
> > - AUDIT_LANDLOCK_PATH: "scope=exact path=[file path] dev= ino="
> 
> I would use a single record type, i.e. AUDIT_LANDLOCK_ACCESS, to
> capture both access granted and denied events.  I'd also omit the
> dedicated LANDLOCK_PATH record here in favor of the generic PATH
> record (see my comments above).

Makes sense for the generic PATH record. We would get this:

- AUDIT_LANDLOCK_ACCESS: "domain=[domain ID] op=mkdir result=denied"
- AUDIT_PATH: "path=[file path] dev= ino= ..."

> 
> > For denied net access:
> > - AUDIT_LANDLOCK_DENIAL: "id=[domain ID] op=connect"
> > - AUDIT_LANDLOCK_PORT: "port="
> 
> I would look at the SOCKADDR record type instead of introducing a new
> LANDLOCK_PORT type.

Good, this is already filled so I don't have to do anything except the
AUDIT_LANDLOCK_ACCESS record.

However, I'm wondering if it would be OK to create a synthetic sockaddr
struct to generate a sockaddr audit record when adding a new net_port
rule. In this case, we'd have to fill the fill the source and
destination addresses with fake values (zeros?) and the source and
destination ports with the rule's port. The pros is that it would not
add a new record type but the cons is that it will probably not work
with future net_port rule properties. It would also be inconsistent with
AUDIT_LANDLOCK_ACCESS.

What about this instead?

- AUDIT_LANDLOCK_RULE: "ruleset=[ruleset ID] rule_type=net_port
  allowed_access=[bitmask]"
- AUDIT_LANDLOCK_PORT: "port=[port number]"

> 
> > I guess it will still be OK to expand a record type with new appended
> > fields right? For instance, could we append a "flags" field to a
> > AUDIT_LANDLOCK_RULESET record (because it may not make sense to create a
> > dedicated record type for that)?
> 
> Of course, one can always add fields to an existing record type with
> the understanding that they MUST be added to the end.
> 
> -- 
> paul-moore.com
> 

