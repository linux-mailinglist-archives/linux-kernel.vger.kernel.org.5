Return-Path: <linux-kernel+bounces-31804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDE88334DA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 14:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55715B21F34
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE03F9DB;
	Sat, 20 Jan 2024 13:43:32 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC143D2F3;
	Sat, 20 Jan 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705758212; cv=none; b=Wah23tFOtafropAFbCe3n9/8dUzngRgE6vkxilyliEt/eSxhArc7uF4AfqOGfPDfRMx/1zZu+9sFK/O2zJfAWL1y7glIOF4yvUsf/AZbar6GUjApoX5mndR+YlzgpmF/xwlwcXXNEgbeAcKWSEBguEd/RH6b2MLiQPwuX0iKyKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705758212; c=relaxed/simple;
	bh=yGToMj6xL5+OFD6gPjwQuDaD9+PnrjiyrotRyA00P68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnIuP6ONPyZP8EwbQ3GHl3esCLj80CQ+wcuJl/8Gj2+CDw045w696KpMld10acoUX98Ierk9dSNaQIEPbvsZxnQ/2J6QKB+ZeN1YsBp6MrqMDqRAUgLdp6ACj6pJRrbxiin2/j71MuiCyNU0zSlRt5pBSTvx+V0KtLEY8+UzJVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rRBd3-00033K-Ov; Sat, 20 Jan 2024 14:43:21 +0100
Message-ID: <4b26d509-f104-44a9-830c-e00b8496a64a@leemhuis.info>
Date: Sat, 20 Jan 2024 14:43:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
Content-Language: en-US, de-DE
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220809142457.4751229f@imladris.surriel.com>
 <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705758210;122eecd4;
X-HE-SMSGID: 1rRBd3-00033K-Ov

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
#regzbot ^introduced efa7df3e3bb5
#regzbot title mm: huge_memory: 32 bit systems or compat
userspace broke
#regzbot link: https://bugzilla.suse.com/show_bug.cgi?id=1218841
#regzbot fix: mm: huge_memory: don't force huge page alignment on 32 bit
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

