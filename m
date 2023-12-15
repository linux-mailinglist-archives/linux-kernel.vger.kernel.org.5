Return-Path: <linux-kernel+bounces-1571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9DE815040
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0AF285E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBCA45BF2;
	Fri, 15 Dec 2023 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wLzyA2Ai";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HZqTHUC7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A396945BE1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702669188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcyJTwzRD6ZFeNFzISSaZIcUm8lkKFqGiYWHcX6xjis=;
	b=wLzyA2AigQbDtTqznVR9C0OEcdHnoVJ/+IHjKYttLOIMVoE06A2+qwqRkYgO4b1XHViqWy
	2dJG39jxo+T1BC3NMg+aLhjlateaoQfxqUmOt+OaFfE7qaJ3LXEsbXGLHGq18JuFf/snwA
	UmW9ndno71UMfIaw8DDg5g23mdmgyANhMiveHE/PFsZCsZwj+FJ2tAxAj91Gg+Jxrist+3
	NUiXZV4vRPzLM8n5kWTAdA/WffaopU3Eaz6S3Wc6sfEiy9bA2m4b6wgaONzeKu144tmO99
	OUSUf/egUkym0tywFEOOtSyee+DAMXCbgQElFx2xudqJ7z/OlZxlLh9NaQ64TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702669188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcyJTwzRD6ZFeNFzISSaZIcUm8lkKFqGiYWHcX6xjis=;
	b=HZqTHUC71Oj38kp7+eZPHiuAKQ9G7Q95NThHnWfkU0/Gtqf/N6VLOUzGVJApINMQAAo+qk
	SaDsfArhauICt5Dg==
To: wangxiaoming321 <xiaoming.wang@intel.com>, peterz@infradead.org,
 linux-kernel@vger.kernel.org
Cc: wangxiaoming321 <xiaoming.wang@intel.com>
Subject: Re: [PATCH] kernel/cpu: The number of CPUHP_AP_ONLINE_DYN (30) is
 too small that stops the new dynamic states hotplug.
In-Reply-To: <20231212025235.775986-1-xiaoming.wang@intel.com>
References: <20231212025235.775986-1-xiaoming.wang@intel.com>
Date: Fri, 15 Dec 2023 20:39:47 +0100
Message-ID: <87o7ermf0c.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 12 2023 at 10:52, wangxiaoming321 wrote:

The subject line has a two issues:

    1) the prefix is wrong. See
       https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject

       You find further information about changelogs there and in other
       parts of the documentation

    2) The sentence is too long and incomprehensible.

> 144: perf/x86/cstate:online
  ...
> 195: online

I have no idea what this number salad is trying to tell me. Changelogs
need to explain the problem they are trying to solve. This listing of
hotplug states is not an explanation and completely useless as it even
contains an entry which do not exist:

> 191: ia64/sep5:online

Even if it would exist a ia64 hotplug callback is hardly relevant on x86,
right?

Also the fixed entries e.g. workqueue and RCU/tree are irrelevant for
what you are trying to describe.

So what you really want to say is something like this:

   cpu/hotplug: Increase the number of dynamic states

   The dynamically allocatable hotplug state space can be exhausted by
   the existing drivers and infrastructure which install CPU hotplug
   states dynamically. That prevents new drivers and infrastructure from
   installing dynamically allocated states.

   Increase the size of the CPUHP_AP_ONLINE_DYN state by 10 to make
   room.

At least that's what I oracled out of your "changelog". Hmm?

Thanks,

        tglx

   

