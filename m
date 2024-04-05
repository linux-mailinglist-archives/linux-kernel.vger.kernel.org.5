Return-Path: <linux-kernel+bounces-132977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D94899CBF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F3E1F2214D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDFA16C877;
	Fri,  5 Apr 2024 12:18:37 +0000 (UTC)
Received: from mail.lichtvoll.de (lichtvoll.de [89.58.27.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304916D304;
	Fri,  5 Apr 2024 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.27.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319512; cv=none; b=j+fie7lfl2h7rLf1dRd+nhtXZJFlzC3IogcLvGjY43mvppzr4iTBo2BltXJtEKo5dAJ48bnDGtXgq9wWxt0BOnDOENW18J4sWywb1YlvuTdO/zkgDkeSS3A34tDaVk4D9NTiQ4wy9BgL6NgEIxWqSa1oinIRYEHt2zIahLyoYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319512; c=relaxed/simple;
	bh=/7/EHAFiwXfZnMJN7n05obC7Qsl6vUhibypEKOHsxEM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPXmWTNff8GMzTDM/mnAZkXMTOZsVK+5hg/JbACLNQ8f2Wj6WNrCGU6hZO1NAyghz4VDxvjCuvMEpgE5XqyndKYR5QoJPSh/1xcGfWpVyKJQNWuap9Rqli5TDLFPJaEBq356kPzar9n5qs9pxFFhG6B1jRIX11XjBNTaDGN4pZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=89.58.27.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id A95E5A199;
	Fri,  5 Apr 2024 12:18:18 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>
Subject:
 Re: [regression] 6.8.1: fails to hibernate with
 pm_runtime_force_suspend+0x0/0x120 returns -16
Date: Fri, 05 Apr 2024 14:18:18 +0200
Message-ID: <6035338.lOV4Wx5bFT@lichtvoll.de>
In-Reply-To: <12413606.O9o76ZdvQC@lichtvoll.de>
References:
 <2325246.ElGaqSPkdT@lichtvoll.de> <6034738.lOV4Wx5bFT@lichtvoll.de>
 <12413606.O9o76ZdvQC@lichtvoll.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Martin Steigerwald - 05.04.24, 13:54:34 CEST:
> > The plot thickens, now 6.7.12 as compared to 6.7.11 which failed
> > hibernation with busy work queues=C2=B9 and 6.7.9 + bcachefs downgrade
> > fixes
>=20
> > fails hibernation with the same error message than 6.8.1:
> [=E2=80=A6]
>=20
> > Not doing it today or probably the weekend, but now I have some
> > actionable git bisect plan without bisecting between major kernel
> > releases which as I have been told between 6.7 an 6.8-rc1 can lead to
> > non working modeset graphics on AMD Ryzen in between.
> >=20
> > It seems now I only need to git bisect between 6.7.11 and 6.7.12 to
> > find the patch that breaks hibernation on 6.8.1 as well. However
> > first I will briefly check whether 6.8.4 hibernates okay.
>=20
> 6.8.4 is still affected and fails hibernation with the same error
> message.

Also this time it is just the ThinkPad T14 AMD Gen 1 with a Lenovo USB
mouse. No second monitor, no USB hub, no nothing else attached.

Should have tested with such a minimal setup to begin with to limit the
test case to a minimum.

=2D-=20
Martin



