Return-Path: <linux-kernel+bounces-83960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7548986A098
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D782840B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0F814A0A2;
	Tue, 27 Feb 2024 19:58:45 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B47149DEF;
	Tue, 27 Feb 2024 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709063925; cv=none; b=E+zlQX4q7SD65wRRNKRC3VozBIk5U5THQ00dQqPjB+Fp1ZYLwHInPYNWuAU44OWVJDBEy3tbjTgqx35NzMlkxE/9ry34m/CT/rqLESteFQjzdLDPYRws+R7IFCMigRitfKdmDJxSc86ZR2RbZLwTAYLVBbEHcdm/8Q7fsffORq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709063925; c=relaxed/simple;
	bh=P4sD4HUPQfVisayH8Xs+cN1CttbdVsl7C2KwjoNCd/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fMj/XdaBQvOHKavhYsDbB2k0/pIj7BIOcoPTBLrLi+sWwN8Rm/Acos/BvAYMaPb6sarMlhcfR5KxYhE/4gnJqI910tIXae9f4C1OpKzmnNMjAVrNMy6jeC1YfpaKqL72XfQOzGyC6qO+3eZynkpbVUY0ovk9Bg+wpmZLc618Ads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id F25BB1C100D;
	Tue, 27 Feb 2024 19:58:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 7918F2000F;
	Tue, 27 Feb 2024 19:58:31 +0000 (UTC)
Message-ID: <421ad59de37ac6bb52c95dde2e3d4bb28590ecca.camel@perches.com>
Subject: Re: [PATCH] wifi: brcm80211: handle pmk_op allocation failure
From: Joe Perches <joe@perches.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Duoming Zhou
	 <duoming@zju.edu.cn>, linux-kernel@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev, 
 linux-wireless@vger.kernel.org, justinstitt@google.com, john@keeping.me.uk,
  quic_alokad@quicinc.com, marcan@marcan.st, johannes.berg@intel.com, 
 linus.walleij@linaro.org, kvalo@kernel.org
Date: Tue, 27 Feb 2024 11:58:30 -0800
In-Reply-To: <d5ce0495-2f18-4176-90e5-7bba76132ea1@broadcom.com>
References: <20240227080613.34001-1-duoming@zju.edu.cn>
	 <87166784-79ab-4eb4-ad1e-af4bc31757b7@broadcom.com>
	 <b0a352781f58a829deadffbe2ef2085c97c6ab32.camel@perches.com>
	 <d5ce0495-2f18-4176-90e5-7bba76132ea1@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7918F2000F
X-Stat-Signature: 5ecpjek1crfwbbitof44ux9oq795j1oo
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX196uCPc1Mhr+W6xRTIiGgxS4/v22vRLx4Y=
X-HE-Tag: 1709063911-815136
X-HE-Meta: U2FsdGVkX1/eFvup7WVqYePDzElmDFKyTelnhnAvhZBAaG9nRU/946LUePwJqVPgeDaVi6NNnZR6oQ5clfR/7HRIIAmaPHKnpYGEEIGRjrY2lCmChwJGR31H8bfb2scA+M4gjeceuQGuY/5aJ9uylZKxYGL5j+aKZLSbbS3TF+s47nvl0d+diQafbBT9HSfzF/ZP+ZrBZvSqjXG6yPll4EYxlGDYjbJVJlPs26XPoitAuHsXlhwUfVh4XJ+M4NVI7xxvYaHi9+8DATgbWWEpgDt1zEpJunjTZ3QO/hYhjc1kVYX0BpvCZ9AuGGdPBCIGtBH6GYui4GbVkYfIjBK3Ud0zK5VmJiXC86GH85y2NT3aFEJ+zmRngH1mrQakLgJ9GFFEjdiIEAf+Dt6Nc+7YQG3vRcu0ZKtxeFUgaBxbkIi1YGl/ueclBzjntDxo38smjnqxAscgBXVOeoswPn0GSQ==

On Tue, 2024-02-27 at 20:40 +0100, Arend van Spriel wrote:
> On 2/27/2024 12:42 PM, Joe Perches wrote:
> > On Tue, 2024-02-27 at 12:21 +0100, Arend van Spriel wrote:
> > > On 2/27/2024 9:06 AM, Duoming Zhou wrote:
> > > > The kzalloc() in brcmf_pmksa_v3_op() will return null if the
> > > > physical memory has run out. As a result, if we dereference
> > > > the null value, the null pointer dereference bug will happen.
> > > >=20
> > > > Return -ENOMEM from brcmf_pmksa_v3_op() if kzalloc() fails
> > > > for pmk_op.
> > >=20
> > > NAK (see below)
> > >=20
> > > Also this issue was reported earlier by Joe Perches. Not sure if he
> > > wants to be mentioned as such.
> >=20
> > I think it's unimportant to be mentioned.
> >=20
> > I think it's more important that the code be researched
> > that the simple return of -ENOMEM the appropriate fix
> > and is handled by all possible callers of the function.
>=20
> Right. That is what I did after which I replied on Feb 18 to your email.
>=20
> https://lore.kernel.org/all/3e1f11b3-a689-4c8e-bfda-b43649db7106@broadcom=
com/
>=20

Right, I did that as well, but I didn't look up
the entire calling tree.

It likely works.  It's also likely better than
the write through of the null pointer.

