Return-Path: <linux-kernel+bounces-102582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C209C87B437
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41761C21A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E22459B57;
	Wed, 13 Mar 2024 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mDIlLO93"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A69859B43
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710367821; cv=none; b=iN+PJ4Nw4KEhAK1inqVcaPlYkZDHsoJQ/arKcydLgACfOlsGbsWSPrLlOrhDwSYYcaYp6tqFY/jfzNJ4BLiDL83gTa8yHi3e5q2CDtHXbEGl1MmmvwZMeJbvaajSGwGyap6/sFTAIBHOdGBYiQ802OnjxD2By4ljXGc50eZDaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710367821; c=relaxed/simple;
	bh=G7WnWN0sS77GFvtJh/eSBeZOL2g3lWCyHdmf+zU/TvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsbEyiYivZkhK93ADcUoc/0bJKGvLWD380h+NGu4pYiLM2jeYOHIGDqC+N51TxsNQG6237uW/5jdvGM/yfhhF5mMKmnWKeMtbdiFgyUKZ2CWJdq7x5yvvm15IeZHh4aAN1rZY/rUy7y77vyCG89nH6WF7gf1eQesDoDQxm+JCYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mDIlLO93; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Tw4Sq2vKPz6Cl4Pd;
	Wed, 13 Mar 2024 22:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1710367817; x=1712959818; bh=QQJMlgP56N7rXjX31zXaJf43
	BsG8SkIAMHm4Wi+TRMk=; b=mDIlLO937fImNgwXd5PEtVK0N7LEYsg9eVCWEAQq
	ZoEOrNcT+Fk//wYTY+GUyqihlXUPaGCc0rRQC4N3nQ7o4NxXm25jT+81e3XcexGk
	uOuJNLjDEacsh7huMD8HWjuwLgX2vHUM6//ExfDGOfb1Gf+84r4eVxxyA8QPgRqn
	0gfZmBU8sniEik+OE+2JZfuhgR7RcFC6nx7EkyjYNa9GQxWzp7mldNgnW0CqHPPO
	LN1U4RrjSvVMjLttqlIHe4L5ULEI9OINV/HqkDI1hD8rCPf/sgroVKNHICxeKXfR
	FgJ/dhgyY0frXWDtb7K9rcP6Vh1HkJvxsmcZy/Us5pEXXQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id V5FYab1wQ-Sh; Wed, 13 Mar 2024 22:10:17 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Tw4Sn3b4Xz6ClL9N;
	Wed, 13 Mar 2024 22:10:17 +0000 (UTC)
Message-ID: <436fb309-1f6f-4279-8c33-121fd76a7129@acm.org>
Date: Wed, 13 Mar 2024 15:10:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: sysfs: Fix reference leak in
 sysfs_break_active_protection()
Content-Language: en-US
To: Alan Stern <stern@rowland.harvard.edu>, Tejun Heo <tj@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Kernel development list <linux-kernel@vger.kernel.org>
References: <CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com>
 <e9d710fc-eace-44de-b3cc-1117c3575ef7@rowland.harvard.edu>
 <2024030428-graph-harmful-1597@gregkh>
 <416a8311-c725-419a-8b22-74c80207347f@rowland.harvard.edu>
 <9c2484f4-df62-4d23-97a2-55a160eba55f@rowland.harvard.edu>
 <ZfIKwFSmw-ACj_jO@slm.duckdns.org>
 <8a4d3f0f-c5e3-4b70-a188-0ca433f9e6f9@rowland.harvard.edu>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8a4d3f0f-c5e3-4b70-a188-0ca433f9e6f9@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/24 14:43, Alan Stern wrote:
> The sysfs_break_active_protection() routine has an obvious reference
> leak in its error path.  If the call to kernfs_find_and_get() fails then
> kn will be NULL, so the companion sysfs_unbreak_active_protection()
> routine won't get called (and would only cause an access violation by
> trying to dereference kn->parent if it was called).  As a result, the
> reference to kobj acquired at the start of the function will never be
> released.
> 
> Fix the leak by adding an explicit kobject_put() call when kn is NULL.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

