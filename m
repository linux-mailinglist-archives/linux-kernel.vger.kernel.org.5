Return-Path: <linux-kernel+bounces-98015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C0E877359
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B644F1C21016
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5599C46449;
	Sat,  9 Mar 2024 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I281U3DH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980CE4595A;
	Sat,  9 Mar 2024 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009656; cv=none; b=QyxZaQjzDWsJbqqZbmEkZhrVwH3Zlupk9hnp2vNr8yAUbsy0r6DPNzDtQXUP8fgJS1p5R+aa3wFjqBV70dSgWRaifOdCGPmtzlhsal/I1HU8AP4cjm3SfaAVkhGhsiFP4GJarTwk3mgrtyWWBIoycLy+/mn4USrUSVBb3d14kbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009656; c=relaxed/simple;
	bh=iFIjbYvr0QvzfMFGnrmtWfaFnK1GBevJBvSy4qoaWBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHmhA4vc4XLZl+41cCPT6eK2ehaa3B81gTQeqywhGgAksNO7kTqICGFYm2jII3fTp2sxkmIsPYrMXwH3CmSdueaGmR0QG9USUPJIvqS0omGo8rva3eqPRzrTA2bwRk77rHkOabx8KrX4WUBEwpGS895v4lkcm82BToCIJhb6qR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I281U3DH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C230FC433F1;
	Sat,  9 Mar 2024 18:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710009656;
	bh=iFIjbYvr0QvzfMFGnrmtWfaFnK1GBevJBvSy4qoaWBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I281U3DH181gohn+rf8spyJhZXc57TZ8kM6bT0/z1D0hVY3T2QQZ3f2LrbOK+6ioH
	 HMK7xg8sCs5/rJg2frxrgbSrOU0Z+DBievnLkmyjpbmhHK0VPOcHQerRld8uORBGuQ
	 xPSDyzKki1o2J07nyOkGHHHbSCju/WyjrcCCVziaoNrB3XJUOwyR8U13e4CJSCTrHh
	 MIyYOk8z/okD7Q5CIlgxjdIsctuKwTqx4jR41elFPOfjFhbi43U4nqX74gxJtzUSZh
	 qv2ABaM48fS4yitV0bAZP60CDoN8EDR4Hxadw8tncQV3PZCgymBMA4Mv+tbrFYWGDe
	 +S1U3hx0lkisA==
Date: Sat, 9 Mar 2024 10:40:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+65bb09a7208ce3d4a633@syzkaller.appspotmail.com>, Petr
 Machata <petrm@nvidia.com>, davem@davemloft.net, dsahern@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] kernel BUG in __nla_validate_parse
Message-ID: <20240309104054.5f058be3@kernel.org>
In-Reply-To: <CANn89iKLAOJ+HG_y7M27-tx+9HSLUyDaf_NtrJMjs2bZ52KZbA@mail.gmail.com>
References: <00000000000088981b06133bc07b@google.com>
	<CANn89iKLAOJ+HG_y7M27-tx+9HSLUyDaf_NtrJMjs2bZ52KZbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Mar 2024 16:25:18 +0100 Eric Dumazet wrote:
> On Sat, Mar 9, 2024 at 4:13=E2=80=AFPM syzbot
> > ..
> Petr, can you take a look ?
>=20
> Thanks !
>=20
>=20
> commit 2118f9390d83cf942de8b34faf3d35b54f9f4eee
> Author: Petr Machata <petrm@nvidia.com>
> Date:   Wed Mar 6 13:49:15 2024 +0100
>=20
>     net: nexthop: Adjust netlink policy parsing for a new attribute

Yeah

+static const struct nla_policy rtm_nh_policy_del[] =3D {
+       [NHA_ID]                =3D { .type =3D NLA_U32 },
+};

+       err =3D nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
+                         rtm_nh_policy_del, extack);

The policy size must be >=3D max_attr (NHA_MAX).

