Return-Path: <linux-kernel+bounces-31837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DEA83354E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 16:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50810284970
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B73610962;
	Sat, 20 Jan 2024 15:47:50 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E2510940;
	Sat, 20 Jan 2024 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705765669; cv=none; b=DsTmUEhHlD3u2GY0gDbtyqlzTrXlZfy/OWYrjn70BR/V3Twinv6BRJqZ0J5R4XFy+/ncqKEp8FOnI6Qv6alrT5A9P9M2iWu7IRfEyX+lqCLPDQH9cKBu3vcG6sM6BWlCXzqAdlFF2xxr3mMcvdx11AMFOH+rnyB/NK41ygdvW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705765669; c=relaxed/simple;
	bh=RnvXs7bo/rdTIXPT7lSd2VKAht41wNfcvQHpSdhnJvI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gfhS8I+TKnd5Zu4Xg1C4Xusc/GQaGuKUDG/Ir2WY6Tv6rmk1/ZmzUgxqco4hvX0Hl+wKPlUVdKPTao3Rv1AoEhuEqioRe+s1895RwJ6+hLK6elEY/f0VcZhg9R+mvOiUZjhMcMqs+7Gy+D9Xk4qP5vweg14QuU8JGRhBNBtp/G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rRDZQ-0004DJ-V9; Sat, 20 Jan 2024 16:47:45 +0100
Message-ID: <836bec0b-16f9-4a18-9299-a3ae0783bf9a@leemhuis.info>
Date: Sat, 20 Jan 2024 16:47:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220809142457.4751229f@imladris.surriel.com>
 <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
Content-Language: en-US, de-DE
In-Reply-To: <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705765667;5b990cef;
X-HE-SMSGID: 1rRDZQ-0004DJ-V9

On 16.01.24 12:53, Jiri Slaby wrote:

> On 09. 08. 22, 20:24, Rik van Riel wrote:
>> Align larger anonymous memory mappings on THP boundaries by
>> going through thp_get_unmapped_area if THPs are enabled for
>> the current process.
>>
>> With this patch, larger anonymous mappings are now THP aligned.
>> When a malloc library allocates a 2MB or larger arena, that
>> arena can now be mapped with THPs right from the start, which
>> can result in better TLB hit rates and execution time.
> 
> This appears to break 32bit processes on x86_64 (at least). In
> particular, 32bit kernel or firefox builds in our build system.
> 
> Reverting this on top of 6.7 makes it work again.
> 
> Downstream report:
>  https://bugzilla.suse.com/show_bug.cgi?id=1218841
> [...]

Trying this again, sorry for the noise:

#regzbot ^introduced efa7df3e3bb5
#regzbot title mm: huge_memory: 32 bit systems or compat userspace broke
#regzbot link: https://bugzilla.suse.com/show_bug.cgi?id=1218841
#regzbot fix: mm: huge_memory: don't force huge page alignment on 32 bit
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

