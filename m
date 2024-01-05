Return-Path: <linux-kernel+bounces-18203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822C98259FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA6284EB7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7028935281;
	Fri,  5 Jan 2024 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="NRsoFtNP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3069A35EE7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T6BPx5Y7nzMpnh2;
	Fri,  5 Jan 2024 18:12:37 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4T6BPw3F4SzMpnPr;
	Fri,  5 Jan 2024 19:12:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1704478357;
	bh=7CcqvU+dm80k4/4DXMGXtl1qlVFCE19rwLyaDkrOPGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NRsoFtNP0tf+eAvgWVGPBL9wvlbAzS0BsOsJG6+txPx08INeRo0k/42aig9fnmPAr
	 xx/z5B17Ep+nb3jljzUgdjgXyk6h2ho/sIJNFwq6gGk8Mv2L+Jrn0K4DOdDdieACd7
	 bz5uzcdlc9xJJfygY0VJw6bL9xVNBJLJ4qqVVU+w=
Date: Fri, 5 Jan 2024 19:12:35 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: Re: [RFC PATCH v1 3/7] landlock: Log ruleset creation and release
Message-ID: <20240105.aiquux9Oox7l@digikod.net>
References: <20230921061641.273654-1-mic@digikod.net>
 <20230921061641.273654-4-mic@digikod.net>
 <CAHC9VhQTvFp+i=j7t+55EnG44xg=Pmvkh=Oq=e7ddJWDZXLeSA@mail.gmail.com>
 <20231221.eij3poa3Se4b@digikod.net>
 <CAHC9VhRiUOe9enkCOko0mGehxt+2tbJNGoJm=jmauhZSPFvzRg@mail.gmail.com>
 <20231229.aex0ijae2The@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231229.aex0ijae2The@digikod.net>
X-Infomaniak-Routing: alpha

On Fri, Dec 29, 2023 at 06:42:10PM +0100, Mickaël Salaün wrote:
> On Fri, Dec 22, 2023 at 05:42:35PM -0500, Paul Moore wrote:
> > On Thu, Dec 21, 2023 at 1:45 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > On Wed, Dec 20, 2023 at 04:22:15PM -0500, Paul Moore wrote:
> > > > On Thu, Sep 21, 2023 at 2:17 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > >
> > > > > Add audit support for ruleset/domain creation and release ...
> > 
> > ...

> > > For rule addition, several records per landlock_add_rule(2) call.
> > > Example with a path_beneath rule:
> > > - AUDIT_LANDLOCK_RULESET: "id=[ruleset ID] op=add_rule"
> > > - AUDIT_LANDLOCK_PATH: "scope=beneath path=[file path] dev= ino="
> > > - AUDIT_LANDLOCK_ACCESS: "type=fs rights=[bitmask]"
> > 
> > I worry that LANDLOCK_PATH is too much of a duplicate for the existing
> > PATH record.  Assuming the "scope=" field is important, could it live
> > in the LANDLOCK_ACCESS record and then you could do away with the
> > dedicated LANDLOCK_PATH record?  Oh, wait ... this is to record the
> > policy, not a individual access request, gotcha.  If that is the case
> > and RULESET, PATH, ACCESS are all used simply to record the policy
> > information I might suggest creation of an AUDIT_LANDLOCK_POLICY
> > record that captures all of the above.  If you think that is too
> > cumbersome, then perhaps you can do the object/access-specific record
> > type, e.g. AUDIT_LANDLOCK_POLICY_FS and AUDIT_LANDLOCK_POLICY_NET.
> 
> OK, what about this records for *one* rule addition event?
> 
> - AUDIT_LANDLOCK_RULE: "ruleset=[ruleset ID] rule_type=path_beneath
>   allowed_access=[bitmask]"
> - AUDIT_PATH: "path=[file path] dev= ino= ..."
> 
> However, because struct landlock_path_beneath_attr can evolve and get
> new fields which might be differents than the landlock_net_port_attr's
> ones, wouldn't it be wiser to use a dedicated AUDIT_LANDLOCK_RULE_FS or
> AUDIT_LANDLOCK_RULE_PATH_BENEATH record type? These names are getting a
> bit long though, but types match the UAPI.

Hmm, AUDIT_PATH is used when a syscall's argument is a path, but in the
case of Landlock, the arguments are file descriptors.

I can still export audit_copy_inode() to create a synthetic audit_names
struct, and export/call audit_log_name() to create an AUDIT_PATH entry
but I'm not sure it is the best approach. What would you prefer?
Should I use AUDIT_TYPE_NORMAL or create a new one?

[...]

> > > For denied FS access:
> > > - AUDIT_LANDLOCK_DENIAL: "id=[domain ID] op=mkdir"
> > > - AUDIT_LANDLOCK_PATH: "scope=exact path=[file path] dev= ino="
> > 
> > I would use a single record type, i.e. AUDIT_LANDLOCK_ACCESS, to
> > capture both access granted and denied events.  I'd also omit the
> > dedicated LANDLOCK_PATH record here in favor of the generic PATH
> > record (see my comments above).
> 
> Makes sense for the generic PATH record. We would get this:
> 
> - AUDIT_LANDLOCK_ACCESS: "domain=[domain ID] op=mkdir result=denied"
> - AUDIT_PATH: "path=[file path] dev= ino= ..."

