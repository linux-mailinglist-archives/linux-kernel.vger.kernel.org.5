Return-Path: <linux-kernel+bounces-164249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0048B7B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA9E1C229E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C23514374C;
	Tue, 30 Apr 2024 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dCJFfiu8"
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370527711D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490692; cv=none; b=IJXRHy4fGrkH9899VzN/wYGJLqEGJHGjgdkr3T1iDZW2IoZasj/wPpZFceeNhF7oXXTQIxHkiCevZ7sV8+g8WHwPPinBJoW9U0NsP8a0mXV/ThXgQjRvi8gUql1psMNPEn7fBj4U4fC1gjp8coFh/WbeG0K25ZStOg/cjtlBhWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490692; c=relaxed/simple;
	bh=o9tw+r7HiK2cyxfIdnEKxzsdQ/OTiilNikfU3NSHVe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlMuWviOUxmzIH2aaIxiB2S0CyLw96R9NU/pWRGliL0G2Vq9dsJZTtlSiJo4RQa+IFyOtt809bTD2oNy3FemSZhp+Aw+yB2/M5fxR3jEYyucI6YpZ2qWXuukokAAEU07nmuj/jZpAOwd+mt4GrdDx9zgdrZcWWZJXmy9o64mgjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dCJFfiu8; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VTPBl21DwzwK5;
	Tue, 30 Apr 2024 17:24:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714490687;
	bh=o9tw+r7HiK2cyxfIdnEKxzsdQ/OTiilNikfU3NSHVe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCJFfiu8WGMiQ53xbHZ1FW9HOnnmCs2WrkKqstQM5CEf2ab5pQQD3GVv0pmnZJhDL
	 8iD3bq+qImade0+0Vrdhs95JQMZcSwWLhABsB10SZlyjgeIzvySVt3evyecmyS2MXX
	 wTmyf48w/uMNYgOBvz59alNnwDz6EJDyGZ02RIDg=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VTPBk2xCtzhtX;
	Tue, 30 Apr 2024 17:24:46 +0200 (CEST)
Date: Tue, 30 Apr 2024 17:24:45 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev, netdev@vger.kernel.org, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Jann Horn <jannh@google.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v2] landlock: Add abstract unix socket connect
 restrictions
Message-ID: <20240411.ahgeefeiNg4i@digikod.net>
References: <ZgX5TRTrSDPrJFfF@tahera-OptiPlex-5000>
 <20240401.ieC2uqua5sha@digikod.net>
 <ZhcRnhVKFUgCleDi@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhcRnhVKFUgCleDi@tahera-OptiPlex-5000>
X-Infomaniak-Routing: alpha

On Wed, Apr 10, 2024 at 04:24:30PM -0600, Tahera Fahimi wrote:
> On Tue, Apr 02, 2024 at 11:53:09AM +0200, Mickaël Salaün wrote:
> > Thanks for this patch.  Please CC the netdev mailing list too, they may
> > be interested by this feature. I also added a few folks that previously
> > showed their interest for this feature.
> > 
> > On Thu, Mar 28, 2024 at 05:12:13PM -0600, TaheraFahimi wrote:
> > > Abstract unix sockets are used for local interprocess communication without
> > > relying on filesystem. Since landlock has no restriction for connecting to
> > > a UNIX socket in the abstract namespace, a sandboxed process can connect to
> > > a socket outside the sandboxed environment. Access to such sockets should
> > > be scoped the same way ptrace access is limited.
> > 
> > This is good but it would be better to explain that Landlock doesn't
> > currently control abstract unix sockets and that it would make sense for
> > a sandbox.
> > 
> > 
> > > 
> > > For a landlocked process to be allowed to connect to a target process, it
> > > must have a subset of the target process’s rules (the connecting socket
> > > must be in a sub-domain of the listening socket). This patch adds a new
> > > LSM hook for connect function in unix socket with the related access rights.
> > 
> > Because of compatibility reasons, and because Landlock should be
> > flexible, we need to extend the user space interface.  As explained in
> > the GitHub issue, we need to add a new "scoped" field to the
> > landlock_ruleset_attr struct. This field will optionally contain a
> > LANDLOCK_RULESET_SCOPED_ABSTRACT_UNIX_SOCKET flag to specify that this
> > ruleset will deny any connection from within the sandbox to its parents
> > (i.e. any parent sandbox or not-sandboxed processes).

> Thanks for the feedback. Here is what I understood, please correct me if
> I am wrong. First, I should add another field to the
> landlock_ruleset_attr (a field like handled_access_net, but for the unix
> sockets) with a flag LANDLOCK_ACCESS_UNIX_CONNECT (it is a flag like
> LANDLOCK_ACCESS_NET_CONNECT_TCP but fot the unix sockets connect).

That was the initial idea, but after thinking more about it and talking
with some users, I now think we can get a more generic interface.

Because unix sockets, signals, and other IPCs are fully controlled by
the kernel (contrary to inet sockets that get out of the system), we can
add ingress and egress control according to the source and the
destination.

To control the direction we could add an
LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE and a
LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND rights (these names are a bit
long but at least explicit).  To control the source and destination, it
makes sense to use Landlock domain (i.e. sandboxes):
LANDLOCK_DOMAIN_HIERARCHY_PARENT, LANDLOCK_DOMAIN_HIERARCHY_SELF, and
LANDLOCK_DOMAIN_HIERARCHY_CHILD.  This could be used by extending the
landlock_ruleset_attr type and adding a new
landlock_domain_hierarchy_attr type:

struct landlock_ruleset_attr ruleset_attr = {
  .handled_access_dom = LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE | \
                        LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND,
}

// Allows sending data to and receiving data from processes in the same
// domain or a child domain, through abstract unix sockets.
struct landlock_domain_hierarchy_attr dom_attr = {
  .allowed_access = LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE | \
                    LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND,
  .relationship = LANDLOCK_DOMAIN_HIERARCHY_SELF | \
                  LANDLOCK_DOMAIN_HIERARCHY_CHILD,
};

It should also work with other kind of IPCs:
* LANDLOCK_ACCESS_DOM_UNIX_PATHNAME_RECEIVE/SEND (signal)
* LANDLOCK_ACCESS_DOM_SIGNAL_RECEIVE/SEND (signal)
* LANDLOCK_ACCESS_DOM_XSI_RECEIVE/SEND (XSI message queue)
* LANDLOCK_ACCESS_DOM_MQ_RECEIVE/SEND (POSIX message queue)
* LANDLOCK_ACCESS_DOM_PTRACE_RECEIVE/SEND (ptrace, which would be
  limited)

What do you think?

