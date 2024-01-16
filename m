Return-Path: <linux-kernel+bounces-27271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9673982ED07
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BE2B22AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1054B18ED1;
	Tue, 16 Jan 2024 10:50:15 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C468134D5;
	Tue, 16 Jan 2024 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rPh1A-0001CR-Cv; Tue, 16 Jan 2024 11:50:04 +0100
Message-ID: <e3f1d31a-1e53-4a4e-bc5e-529b9205c72c@leemhuis.info>
Date: Tue, 16 Jan 2024 11:50:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] fs/ntfs3: Use kvfree to free memory allocated by kvmalloc
Content-Language: en-US, de-DE
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Giovanni Santini <giovannisantini93@yahoo.it>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <667a5bc4-8cb5-47ce-a7f1-749479b25bec@paragon-software.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <667a5bc4-8cb5-47ce-a7f1-749479b25bec@paragon-software.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705402212;60d95378;
X-HE-SMSGID: 1rPh1A-0001CR-Cv

[/me jumps in here with something unrelated after unsuccessfully trying
to contact Konstantin in the past weeks]

On 16.01.24 09:26, Konstantin Komarov wrote:
> 
> Signed-off-by: Konstantin Komarov
> <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/attrlist.c | 4 ++--
>  fs/ntfs3/bitmap.c   | 4 ++--
>  fs/ntfs3/frecord.c  | 4 ++--
>  fs/ntfs3/super.c    | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)> [...]

Hi Konstantin, glad you are still around. If you have a minute, could
you please take a look at the following bisected regression report? It
sounds there is something really wrong here:

https://bugzilla.kernel.org/show_bug.cgi?id=218180

In short:

"""
> The problem I am facing is the following:
> 1. I mount an NTFS partition via NTFS3
> 2. I create a file
> 3. I write to the file
> 4. The file is empty
> 5. I remount the partition
> 6. The file has the changes I made before the remount
>
> I can avoid the remount by doing:
> sudo sysctl vm.drop_caches=3
"""

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

