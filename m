Return-Path: <linux-kernel+bounces-2155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278798158BC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 11:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4871E1C24A5B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB8D156C1;
	Sat, 16 Dec 2023 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="0ZVmXE/4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from forwardcorp1c.mail.yandex.net (forwardcorp1c.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080F13B13C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:42a6:0:640:15f4:0])
	by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id B4F8A63EF3;
	Sat, 16 Dec 2023 13:56:19 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b420::1:5] (unknown [2a02:6b8:b081:b420::1:5])
	by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 5ujVwk0GZSw0-6QmN5sH6;
	Sat, 16 Dec 2023 13:56:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1702724179;
	bh=Fuy3Sm2Bbbg7oqE+fIfRFZIUBKDsQ8RDgilEfezRrnk=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=0ZVmXE/4OG4GhQL/7q/6FyQu9HSL4qTJsJcBM7D8v/UiAYoajrgaT2I6e44docTvn
	 BK0OdgVlZxHjRKJQPlxtJuFPi84P3RXzf+AkoHmHZjGm5Q52dZw8QBINZ6bEQ9WbTX
	 HL7f5v6hUgNLekfycm4HeDn/QKdufoxEYlND+17s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <039b8ba2-09c8-487d-b2ef-f74d6ab4e489@yandex-team.ru>
Date: Sat, 16 Dec 2023 13:56:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/split_lock: add split lock counter
To: Dave Hansen <dave.hansen@intel.com>
Cc: den-plotnikov@yandex-team.ru, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 x86@kernel.org
References: <20231215140113.57173-1-davydov-max@yandex-team.ru>
 <195da6ff-3086-4eff-9b91-b28918a11af9@intel.com>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <195da6ff-3086-4eff-9b91-b28918a11af9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/15/23 21:16, Dave Hansen wrote:
> On 12/15/23 06:01, Maksim Davydov wrote:
>> Provides per task split locks counter to monitor split locks rate
>> in the system. It can be helpful in split locks monitoring to get a clear
>> sense of which process causing split locks and how many of them have
>> happened by the moment. For instance, it might be used by cloud providers
>> who can't control guest executable code and want to make decisions based
>> on the rate value like ratelimiting or notifing the split lock origins.
> Have you considered doing this with tracing instead?
>
> It seems a _little_ silly for everyone to pay the cost of having that
> counter around.
No, it just seemed like a good idea to make a simple machine-readable
interface based on the existing flag (reported_split_lock).
What if this interface is made together with the appropriate CONFIG flag
(default false)? Thus it won't affect those who don't need it.

-- 
Best regards,
Maksim Davydov


