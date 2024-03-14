Return-Path: <linux-kernel+bounces-103780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4D887C465
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D441F21A92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F128763FD;
	Thu, 14 Mar 2024 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ko/VWB/I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tZR0FPOc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F56FE28;
	Thu, 14 Mar 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449140; cv=none; b=G8HWXB3SjLQl7v+ZH0N9krA21UnsRjExdW6qOBrZFfjqMstg4QUO3sgYcvREMxJ9OdzlXFV0S8dtMHMciEo1gWuoTw1jlXvGRX5sBGpwnPF73ULzFrC/7/Bd5DpOfyUcUI86w3zEirNMJT89uLYQ4ajGGUVRJZdzHfpEpvNF8gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449140; c=relaxed/simple;
	bh=O8DozmNrZ4VDRmyiSjzVDJqXlYrMmP08o1YadCXt0Ts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p/RtogEXBqMorT2nTLkbMfWyV4CJH6Zy9eB3zbCFZ2tOlFjsDAP3VnEtW1/465Wq0z8uzChjaa5zY+my5WQFVWQdKmIUb4xqWd47uLgMMvOPi2H/WGrNyc+OY8ci4r1y/v4sGsT4A+MHDLt3Vv5d1oB6GxqGohwCmJ8J9W4OfIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ko/VWB/I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tZR0FPOc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710449136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJy+NUZ8ACD5J2EIR57tnDEqsbwNo2P7mRbaWsqp06E=;
	b=Ko/VWB/IPyrGtliE6RtDoxypx/OyPJNFP+tpVuZcSyyChSkVkMYH+c30NGsI81y2yLLz4h
	vfO0CQeaWKgjNfnMAwF5jhxU9UVfd2sMNbviuMGCQqyioEz/YddwSdSxNRfn/PmeNvab53
	qGfV+FTpRDfMMcqL4TPmpdl7qtNkiunJjNomT7F94q0uFlJalFWCP+KbIGKq22zkWeSxPu
	sa9X2DHVEIrwCJclgItzFEz+LJpD7u8JCVndFwgziqTc/N3XTG7SsdTBnVHQmNrEdpRWBr
	WMQyxOoOLzy7OVlRsaV5f+ukgDtmV5XoM8ZHSrVWgC6kk37vMTcPXk/JBBh7og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710449136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJy+NUZ8ACD5J2EIR57tnDEqsbwNo2P7mRbaWsqp06E=;
	b=tZR0FPOcg/7trlG4MSqmxmcjUH0dg+fEKfbsPJL/zePo5/iPlnYngA1mla48M07AQY4pFl
	yLwQ1BU3pLB0DtDQ==
To: Florian Fainelli <f.fainelli@gmail.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Joel Fernandes <joel@joelfernandes.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, paulmck@kernel.org, mingo@kernel.org,
 rcu@vger.kernel.org, neeraj.upadhyay@amd.com, urezki@gmail.com,
 qiang.zhang1211@gmail.com, bigeasy@linutronix.de, chenzhongjin@huawei.com,
 yangjihong1@huawei.com, rostedt@goodmis.org, Justin Chen
 <justin.chen@broadcom.com>
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes
 for v6.9]
In-Reply-To: <de038bee-cecd-4e76-b0f4-5822b68e439d@gmail.com>
References: <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux>
 <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
 <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com>
 <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
 <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
 <ZfIuRMo8oKbR08Af@lothringen>
 <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
 <ZfLUU+XuQC7W79tf@lothringen>
 <d6c8e4fe-17bf-443d-a6f5-54470390e1fd@gmail.com>
 <ZfNHNvzpqf8DOZd8@boqun-archlinux>
 <de038bee-cecd-4e76-b0f4-5822b68e439d@gmail.com>
Date: Thu, 14 Mar 2024 21:45:36 +0100
Message-ID: <87v85olez3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 14 2024 at 12:09, Florian Fainelli wrote:
> On 3/14/24 11:51, Boqun Feng wrote:
>>>> 	trace_event=timer_migration:*,timer_start,timer_expire_entry,timer_cancel
>>>>
>>>> Though it's fairly possible that timer migration is not enabled at this point
>>>> as it's a late initcall. But we better not miss its traces otherwise.
>>>
>>> Here is another log with timer_migration:
>>>
>>> https://gist.github.com/ffainelli/237a5f9928850d6d8900d1f36da45aee
>> 
>> FWIW, the trace point is still not enabled:
>> 
>> [    0.000000] Failed to enable trace event: timer_migration:*
>> 
>> you need this commit in master:
>> 
>> 	36e40df35d2c "timer_migration: Add tracepoints"
>> 
>> , which is one commit later than 7ee988770326 AFAICT
>
> Argh, thanks Boqun, here is a new capture:
>
> https://gist.github.com/ffainelli/cb562c1a60ef8e0e69e7d42143c48e8f
>
> this one is does include the tmigr events. Thanks!

You need 8ca1836769d758e4fbf5851bb81e181c52193f5d too.

