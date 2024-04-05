Return-Path: <linux-kernel+bounces-133173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A9899FF1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3701F22626
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8861616F29C;
	Fri,  5 Apr 2024 14:38:31 +0000 (UTC)
Received: from mail.lichtvoll.de (lichtvoll.de [89.58.27.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016E216F27E;
	Fri,  5 Apr 2024 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.27.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327911; cv=none; b=n7SSHjvPqvVIonZMZbdVzFHDrV861beLWjCocsxwZnwFY1U1ypsv5M7n5LPWq3330v5UIRpibAjuc3dJi3lYkd+xOLXTWFKQO8aBkgfrJ3Ms3axNYs+bFP+efQF//H0VOUgN2Gfzn0HJJvNmEgITaocp7Os6CZiOK+hL+C8L5pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327911; c=relaxed/simple;
	bh=ha8MdiwTOidPbAsf5RIcUUL2CKYMBNElNFxN1UpQ9h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ilzZZybM9EeDGBmkBrY1IGu1rDPfTaqFFe4r/cx16lcBlkdGeNsUBE+ueo2+XjAxPVq8gBZrNIy77qyZXN6AQzblsBGWH7PyXlB+f/tZfEubMyojU/HCbpGTf+JQNtcOQ3gkXmafRmwPVBHvfh4tPKP3hDfaO8d+6CWXTgfo+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=89.58.27.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id AF255A286;
	Fri,  5 Apr 2024 14:38:26 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject:
 Re: [regression] 6.8.1 and 6.7.12: fails to hibernate with
 pm_runtime_force_suspend+0x0/0x120 returns -16
Date: Fri, 05 Apr 2024 16:38:23 +0200
Message-ID: <2181810.irdbgypaU6@lichtvoll.de>
In-Reply-To: <2024040512-defective-wreckage-f202@gregkh>
References:
 <2325246.ElGaqSPkdT@lichtvoll.de> <12414153.O9o76ZdvQC@lichtvoll.de>
 <2024040512-defective-wreckage-f202@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Greg KH - 05.04.24, 15:34:30 CEST:
> > I think ThinkPad T14 AMD Gen 1 or similar systems with Linux are not
> > that rare. I am surprised this is not hitting more people. Well maybe
> > it does and no one reported it here.
> > 
> > Well let's see what happens when 6.7.12 hits distribution kernels.
> > 
> > Anyway, I have an actionable git bisect between 6.7.11 and 6.7.12,
> > just not today. Maybe beginning of next week.
> 
> 6.7.y is end-of-life, I wouldn't worry too much about it, there's
> nothing we can do about it anymore, sorry.

Ah, I see. Thanks.

Still its a good short cut for bisection. Bisecting between 6.7.11 and 
6.7.12 should get much quicker results than bisecting between 6.7 and 6.8 
and as its the same error message in 6.8.1/6.8.4 and 6.7.12 it might be 
the same (backported) patch causing the issue.

-- 
Martin



