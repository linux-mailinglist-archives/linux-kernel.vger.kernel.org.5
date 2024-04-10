Return-Path: <linux-kernel+bounces-138733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF47689F9DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E045B27A01
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F7E15EFAE;
	Wed, 10 Apr 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HyGuA7aN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4xJUkqSe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4DE15B12A;
	Wed, 10 Apr 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758645; cv=none; b=o2bRg+vCO4BM2cU2JAE4QiOQNulAyFw8c1XqVff0Qu20bdM2hA56ed7pfIC2rD8br/7yTNaRDp7IdtqBiw1jOiH7M/qP1CLZhMJkuxZ2q9NYRpiYQHkfmUskL+OniJ3mwG7ceaEfeEvnJNmVZEXzwkNYEcBj9f9GYAVVqSYeXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758645; c=relaxed/simple;
	bh=iiLXM1gHb2fTzL1lNsUML+2NbfICPf9BJeU7hfbuI6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h4z6HxxZPtBzaJB3RZXrPINYq/omKg3Yt0SOavIO4mmjbW9kGWzMHgTJCffhjh39OQh4nfhV6osPG+vFv489qoAYXKjhBwuWvL8hFIfCHu+RWZDU5XTqL6DjmtSckXmKTnohAqwnOYzBV2kKTs87bRvJQ7DaHXhRzcIqYOk9UuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HyGuA7aN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4xJUkqSe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712758642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dKudWSPi1Iu7TxLjPm3UxpQgYscfG9LL8/XF7l+GrvA=;
	b=HyGuA7aNqIHvi+4YBZ2QTOZarh53jTI7l8pcSR0KU9yTM0x6W08XWU/pG67KKgdebK+sIX
	FwjoVZmyg7O6xEUcvy+MO47yD03ffWBG/lff3YyabpnGJKHwoaheyhwW5IP8k9wEfXefaF
	mYA/SjvfDZJZ+GKi2/1UsSyopdwaYdea5VK+/9Nr6IAnCdWrbNvA+4ezEc0FS8/ORLA2Ae
	0koMqYMoes8RWFR8DrFeCRaZJ93fDlcnb2QUW9W+gXdKfhuFJpYMazyq1XlKIkYJx1OGKA
	7GcCYStS4+NRnOcXxE9Xnrn+uwyydjRUi4I/lXtbSu2V6sqJgXLpz/ph/JC4Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712758642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dKudWSPi1Iu7TxLjPm3UxpQgYscfG9LL8/XF7l+GrvA=;
	b=4xJUkqSelu6YTEbO70Sq2RQ639AxhkKBi91Xaeg78LxGCFeiiaamNADOI/cbtpAQXtMwxa
	U0veKRge4GuNBODg==
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 liusong@linux.alibaba.com, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 yaoma@linux.alibaba.com
Subject: Re: [PATCHv12 1/4] genirq: Provide a snapshot mechanism for
 interrupt statistics
In-Reply-To: <f3c7ef07-8fad-4ef6-9095-16e4bd734477@linux.alibaba.com>
References: <20240306125208.71803-1-yaoma@linux.alibaba.com>
 <20240306125208.71803-2-yaoma@linux.alibaba.com> <87frvu7t85.ffs@tglx>
 <f3c7ef07-8fad-4ef6-9095-16e4bd734477@linux.alibaba.com>
Date: Wed, 10 Apr 2024 16:17:21 +0200
Message-ID: <875xwp480e.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 10 2024 at 14:45, Bitao Hu wrote:
> On 2024/4/9 17:58, Thomas Gleixner wrote:
> By the way, what do you think of my reason for using printk() instead of
> pr_crit()? Should I change this part of the code in v13?

Either way is fine. Just put a proper explanation into the change log if
you stick with printk().

Thanks,

        tglx

