Return-Path: <linux-kernel+bounces-130422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0298977DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1902D284886
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A024C153BCB;
	Wed,  3 Apr 2024 18:10:26 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57CF1534E6;
	Wed,  3 Apr 2024 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167826; cv=none; b=jbE26ftL9CC4M0QPifkvzUy0WsxOeV4OKG3ynEG8LKFh99sMdB30ZQVRqMdy5l4psg0DCexNXp+ltBJ/EbEzGUqetuSbevCoUIfQFUSL7zG4d62pVQ3AV9Mwm9Dk2iXo9+0IDO4bXtIMdi5qj5NRrnbjtW6ke1JZYENb+9/oF0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167826; c=relaxed/simple;
	bh=qfxMNQ3oAv6Ey3qWHOduRuntmEUDmzlDBJDhK71hVjg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EjhML/5fx6gkjEGM2/4x3Ec5vzKGk8nC5ndLnkhD40bMyXtvYvRWSvuEuq4kOPHBj2RaDQzPghYOeqcqauw8R6pCKnLrJuevTzBbW6fDwMcROKYVj5LHo08PC/UDewCOuiXhl4WJz5AtmwmDogfVL4bxY5renbTYS4CqEuqN1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.79.246) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 3 Apr
 2024 21:10:10 +0300
Subject: Re: [PATCH AUTOSEL 6.8 02/28] usb: storage: sddr55: fix sloppy typing
 in sddr55_{read|write}_data()
To: Sasha Levin <sashal@kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
CC: Karina Yankevich <k.yankevich@omp.ru>, Alan Stern
	<stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-usb@vger.kernel.org>, <usb-storage@lists.one-eyed-alien.net>
References: <20240403171656.335224-1-sashal@kernel.org>
 <20240403171656.335224-2-sashal@kernel.org>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <cc6ee73c-fdb7-46bd-4f02-f342db846e4e@omp.ru>
Date: Wed, 3 Apr 2024 21:10:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240403171656.335224-2-sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 04/03/2024 17:51:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 184562 [Apr 03 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 14 0.3.14
 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	lore.kernel.org:7.1.1;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.79.246
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/03/2024 17:56:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/3/2024 3:47:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 4/3/24 8:16 PM, Sasha Levin wrote:

> From: Karina Yankevich <k.yankevich@omp.ru>
> 
> [ Upstream commit d6429a3555fb29f380c5841a12f5ac3f7444af03 ]
> 
> In sddr55_{read|write}_data(), the address variables are needlessly typed
> as *unsigned long* -- which is 32-bit type on the 32-bit arches and 64-bit
> type on the 64-bit arches; those variables' value should fit into just 3
> command bytes and consists of 10-bit block # (or at least the max block #
> seems to be 1023) and 4-/5-bit page # within a block, so 32-bit *unsigned*
> *int* type should be more than enough...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> [Sergey: rewrote the patch subject/description]
> 
> Signed-off-by: Karina Yankevich <k.yankevich@omp.ru>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> Link: https://lore.kernel.org/r/4c9485f2-0bfc-591b-bfe7-2059289b554e@omp.ru
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

[...]

   I doubt this is worth pulling into the stable kernels, it
does not fix any serious issue...

MBR, Sergey

