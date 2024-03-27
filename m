Return-Path: <linux-kernel+bounces-121486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6C888E8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C621F2F970
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E44147C7D;
	Wed, 27 Mar 2024 15:15:18 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C35C13BC10
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552517; cv=none; b=Oc995ZUeGzZhXN4oHLi+4EjtUTHj1tG75ylu8X7CNz8NVBmilX4QR3NIY0Ou8xF8pKlQAOUK1J45vRFK2BqK6BoAePr1xS0VoMcQJlVZBbmoLw67HgKuVJ/n5HjndBL6131nPTqjO6zf+44jcSHMXsSGROfzjPXqyuEuETee2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552517; c=relaxed/simple;
	bh=FB9KijKmhBySPWMwoOs2QzeggUljSCO/bu79JB0xETo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Hxc0qLFw0Ze1Srx6by7pDQ4tfkKEFhEekK8Mcg0U3vrwHCondns6yzoZVdFnhNaJIJZMHFv3wtw7AuMsYo5+NXpRy4BRlO1tbkN1tlzLXjCbPgSgzlnk8iI0x4qKeycA3k/tXLLVCxG+S+J3iywjXcJLAXlXneWzIhoZRZD7Od4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.86.12) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 27 Mar
 2024 18:15:09 +0300
Subject: Re: [PATCH v2] udf: udftime: prevent overflow in
 udf_disk_stamp_to_time()
To: Roman Smirnov <r.smirnov@omp.ru>, Jan Kara <jack@suse.com>
CC: <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Jan Kara
	<jack@suse.cz>
References: <20240327132755.13945-1-r.smirnov@omp.ru>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <703e52b1-82f0-13fb-94b8-2d6ff16598e8@omp.ru>
Date: Wed, 27 Mar 2024 18:15:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240327132755.13945-1-r.smirnov@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 03/27/2024 14:57:27
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 184448 [Mar 27 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 13 0.3.13
 9d58e50253d512f89cb08f71c87c671a2d0a1bca
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.86.12
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/27/2024 15:01:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/27/2024 10:50:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 3/27/24 4:27 PM, Roman Smirnov wrote:

> An overflow can occur in a situation where src.centiseconds
> takes the value of 255. This situation is unlikely, but there
> is no validation check anywere in the code.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey

