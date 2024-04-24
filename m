Return-Path: <linux-kernel+bounces-157400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A388B1108
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13EDB23B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D4816D323;
	Wed, 24 Apr 2024 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZISOdoRM"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C66C15A480;
	Wed, 24 Apr 2024 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979894; cv=none; b=O2kbuNxlRXzHckPsMtfs9JnUFYbqMDSiSby4xfDjnkAD+VNf1gSvjPyUgST2s+edcwJt0PmG+Ds94uYIlbWr0M+sLXr9gUAoZxwpNOypkqBReKQMWB2OwqZSrZvlDQk2H1jyCZMeHgIeuUqkKZpRIozosrV2hIaXLHK0MD+xE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979894; c=relaxed/simple;
	bh=rXO3sEX01JpfgsKRjjf3oJK0CYpvvHHrNEzGfMNAC1U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/wDtb726aMGxNRmuSgr83r/BQQeNpFCEKp4UCKelQ94PWjIFvFXTv43OkpdnewQek0fCMjjuSyTgGJPh0e5w+vT61lYvREV3uugvWPhZGJa12WX2MEFWndY/hSBXWn2w9d5U4FQ+JXd1YzIG6UM33oBQxggIWZhKuMPEuLPCWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZISOdoRM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PjkRDjS5p+wbHqIhSv+aLp0kv1BX9+QFVr8INC/8Zrs=;
	t=1713979892; x=1715189492; b=ZISOdoRMMfqWwAXNwhvadpwN5DzLUfDuTy4Pfw0TUWEQjlo
	Wqkz9AkoR5LhSuOZ6pdRJoVp3s8uCHIE1398a3uxZjJ0r0LBW8DXK3YPac1h9AkNe5RObkS4sZnx4
	MApKBDDZcmsT7gj75ybjmmLZTdTf5y7bq4LK7/XPE/BtlSFzVP+CqJu2Mc2AVcnwBaycOfVVncnuT
	ZRKMPrdrUrzuWBYJnFcT07Bcf+mw+1tuLxre1h1noRqwwuJZdfYevAz00xO1YKhTXRA0XNx4c4VS3
	AdPqM836Smk9Tu2ZhLWLWlnRlryEEcyQkevAEgeWFCnnkcyayPy+tVNx1lsbj/Jw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzgSu-00000003mBY-3LwP;
	Wed, 24 Apr 2024 19:31:28 +0200
Message-ID: <df15843e830d1be0137eb43402a334faf895d2be.camel@sipsolutions.net>
Subject: Re: 6.9.0-rc2+ kernel hangs on boot (bisected, maybe LED related)
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, Linux regressions mailing list
	 <regressions@lists.linux.dev>, Lee Jones <lee@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org, Miri
	Korenblit <miriam.rachel.korenblit@intel.com>
Date: Wed, 24 Apr 2024 19:31:26 +0200
In-Reply-To: <6eba2967-e2de-d9f1-3794-01cf4e88c56c@candelatech.com>
References: <30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com>
	 <30819e01-43ce-638f-0cc6-067d6a8d03c7@candelatech.com>
	 <89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com>
	 <20240411070718.GD6194@google.com>
	 <de43c7e1-7e8c-bdbe-f59e-7632c21da24a@candelatech.com>
	 <8736ebc8881e1e0cabfbbf033725a3123a5e8e90.camel@sipsolutions.net>
	 <bc420f3a-5809-4c4a-80ad-ccd8a46853b6@leemhuis.info>
	 <8ab88be5de30bcbd0d1cac3cfde6b2085dcfc8fb.camel@sipsolutions.net>
	 <0197efe8-828b-43ae-85c9-5d521913a289@leemhuis.info>
	 <6eba2967-e2de-d9f1-3794-01cf4e88c56c@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Ben,

On Wed, 2024-04-24 at 10:26 -0700, Ben Greear wrote:
>=20
> This patch makes the problem go away in my testbed with 24 Intel
> iwlwifi radios.  My guess is that it is just papering over the problem,

Agree, there seems to be some locking issue with LED stuff, but I'm not
sure where, and the driver doesn't even hold any locks here.

> but maybe good enough?

For all I care, yes. We explicitly do this last, from a worker that
holds no locks in the driver ... so it's odd. Looking at the history of
it, it seems that it was originally _nowait(), but then in 3.6 I changed
it because of some backport concerns. Though then I also moved it out of
the locked section.

> Would you like me to submit as official
> patch to linux-wireless?

Sure.

johannes

