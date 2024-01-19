Return-Path: <linux-kernel+bounces-31006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F515832766
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73C7285763
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA713C46B;
	Fri, 19 Jan 2024 10:11:02 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3905333CE9;
	Fri, 19 Jan 2024 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659062; cv=none; b=TjcFj+FFaKaQP/P64g6bPyZlw4jGdsmc/mmdiXwdmMIJby80aa8Enwxxz3saHhMaBty7y4sb5GwAbPXr/YwS2wqEabS5mxxP45BgWJZ6aSFoTOZ+g4W6DWsMRpoZAVoF9zlN3qzFNwZZ0gGt+fahG3eQ+i0zCFMUkFoMaVGv2As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659062; c=relaxed/simple;
	bh=xKEw9678oSQ6tKsP7zZqBVKIhlRFGOiGErV4yWGJiXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAaIsBPiWwnQL4c4dBx2NFejSys5Ai6zO0w9WaTNO3o/B6oDq17Rrq08R32N+4E8YoaOHkeKtWqa4lZS5cUxOFdOCITCmhtL40Zpt1Kze+W7TVfBUQEqid5BQlQVYxD7Yhhmh0Osp/t2EA5KroGdzkpmipX89vZyjUSP0fkH6gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rQlpx-0002e0-QA; Fri, 19 Jan 2024 11:10:57 +0100
Message-ID: <4aa18f12-4fd8-4c26-bf4f-96f934e5d3bc@leemhuis.info>
Date: Fri, 19 Jan 2024 11:10:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v4 4/4] selftests/mm: add tests for HWPOISON hugetlbfs
 read
Content-Language: en-US, de-DE
To: Linux Regressions <regressions@lists.linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230713001833.3778937-1-jiaqiyan@google.com>
 <20230713001833.3778937-5-jiaqiyan@google.com>
 <be3976b5-0a9c-41c6-8160-88e6c1e5d63e@collabora.com>
 <CACw3F51WvZDVCpVg9j4j8WmnmAFOsnK+FZDDoVqhgLqVwhPTCA@mail.gmail.com>
 <e68488e4-764e-4b25-8a47-05bf8976bd19@collabora.com>
 <079335ab-190f-41f7-b832-6ffe7528fd8b@collabora.com>
 <772a2c59-7616-4ec7-9050-17d3abf0b6eb@collabora.com>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <772a2c59-7616-4ec7-9050-17d3abf0b6eb@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705659060;8f826fe6;
X-HE-SMSGID: 1rQlpx-0002e0-QA

On 12.01.24 07:16, Muhammad Usama Anjum wrote:
> On 1/10/24 3:15 PM, Muhammad Usama Anjum wrote:
>> On 1/10/24 11:49 AM, Muhammad Usama Anjum wrote:
>>> On 1/6/24 2:13 AM, Jiaqi Yan wrote:
>>>> On Thu, Jan 4, 2024 at 10:27 PM Muhammad Usama Anjum
>>>> <usama.anjum@collabora.com> wrote:
>>>>>
>>>>> I'm trying to convert this test to TAP as I think the failures sometimes go
>>>>> unnoticed on CI systems if we only depend on the return value of the
>>>>> application. I've enabled the following configurations which aren't already
>>>>> present in tools/testing/selftests/mm/config:
>>>>> CONFIG_MEMORY_FAILURE=y
>>>>> CONFIG_HWPOISON_INJECT=m

> #regzbot title: hugetlbfs hwpoison handling
> #regzbot introduced: a08c7193e4f1
> #regzbot monitor:
> https://lore.kernel.org/all/20240111191655.295530-1-sidhartha.kumar@oracle.com

#regzbot fix: fs/hugetlbfs/inode.c: mm/memory-failure.c: fix hugetlbfs
hwpoison handling
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


