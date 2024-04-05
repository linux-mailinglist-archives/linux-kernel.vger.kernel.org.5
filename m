Return-Path: <linux-kernel+bounces-132957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A8F899C78
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351B51C22EC5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB8216C867;
	Fri,  5 Apr 2024 12:11:16 +0000 (UTC)
Received: from mail.lichtvoll.de (lichtvoll.de [89.58.27.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4236E16C848;
	Fri,  5 Apr 2024 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.27.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319076; cv=none; b=u1ih0yLgiqnQAk7YwN/Cd/AowQAEpPZ3V0YBkI/dy4oKK3Z2T1U4wZdDU3bjWANBdTcgTXkiq1dbZjq+ViwRL1rIRxJPgeR+cpyjz/vnRvPKhu/T9dF+gWFrhRvFg0zhqskM6YHgZxaDTEx28BLx+yW296k8JhufIr5odXGTagk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319076; c=relaxed/simple;
	bh=IdzR1y2QIYzGNLja2EK6IzKu8gw7dJV0V1YeBsnEZ+w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1b3zbP+r1n2kCnuNj4xKh8B4RiiMDgMEZ0QpqQillQ1lj3gPZL1m2xqytWwcUXOYRAQXMkyBwjFWAoyJF9VhIDmUigAXdzjZLj11H5H7Gc/ferDLzpw7P3evmo5vsd4g1NDKKwsJOgWq7kdJHE16eXBK0xmP11cUHAco0AtJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=89.58.27.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 23BF1A178;
	Fri,  5 Apr 2024 12:11:12 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>
Subject:
 Re: [regression] 6.8.1 and 6.7.12: fails to hibernate with
 pm_runtime_force_suspend+0x0/0x120 returns -16
Date: Fri, 05 Apr 2024 14:11:11 +0200
Message-ID: <12414153.O9o76ZdvQC@lichtvoll.de>
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
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Martin Steigerwald - 05.04.24, 13:54:34 CEST:
> > Not doing it today or probably the weekend, but now I have some
> > actionable git bisect plan without bisecting between major kernel
> > releases which as I have been told between 6.7 an 6.8-rc1 can lead to
> > non working modeset graphics on AMD Ryzen in between.
> > 
> > It seems now I only need to git bisect between 6.7.11 and 6.7.12 to
> > find the patch that breaks hibernation on 6.8.1 as well. However
> > first I will briefly check whether 6.8.4 hibernates okay.
> 
> 6.8.4 is still affected and fails hibernation with the same error
> message.

Both kernels also fail to reboot the machine. Runit says:

- runit: system reboot

And then nothing anymore.

It is not just hibernation.

I think ThinkPad T14 AMD Gen 1 or similar systems with Linux are not that 
rare. I am surprised this is not hitting more people. Well maybe it does 
and no one reported it here.

Well let's see what happens when 6.7.12 hits distribution kernels.

Anyway, I have an actionable git bisect between 6.7.11 and 6.7.12, just 
not today. Maybe beginning of next week.

-- 
Martin



