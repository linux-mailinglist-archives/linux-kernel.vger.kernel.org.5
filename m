Return-Path: <linux-kernel+bounces-147390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81AB8A7345
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96F11C227A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB33137C5B;
	Tue, 16 Apr 2024 18:31:25 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18B6137C40;
	Tue, 16 Apr 2024 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292284; cv=none; b=F3/6lF6OsP9Vr8vVM1XXRYPN1KtXIIsdQ8fTDM4d9alu2rykyiC0TrCXkPWM2j7NR4/B/pQ3L+yYPDTQ85oTeJUSvnN9/xYT6ZfWS1i7YyD8RSB2KtJb1sF8PnG/O3oW19MS6GvxJZkvguf2L9h/WNhat0A9QJklUcwbDL06KOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292284; c=relaxed/simple;
	bh=/Na9l2ivxSvkNzZUwFSCU/eyawwR+kJMXlCaVep2nwc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NJzDnp4FdXYIplmfFhA/Lk11F9TcCxlucJvURpGh1bAs+SY9usxPvgIIhLchR1eOjg1wGQoOcOsTrSKCyHYK8rQuudi4NrzXriKxgukPt+czZL9WcjBn64mUXLYtPQaLhoCiwpgYgi13VVtXWn4zVfMIo7CVlMEmZPDOKgF7wVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.81.200) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 16 Apr
 2024 21:31:10 +0300
Subject: Re: [PATCH 3/3] media: tuners: tuner_simple: fix error code handling
 in simple_tuner_attach()
To: Roman Smirnov <r.smirnov@omp.ru>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Jia-Ju Bai
	<baijiaju1990@gmail.com>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20240416114509.198069-1-r.smirnov@omp.ru>
 <20240416114509.198069-3-r.smirnov@omp.ru>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <5b888996-9086-93f6-ec08-1ffbd2a67002@omp.ru>
Date: Tue, 16 Apr 2024 21:31:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240416114509.198069-3-r.smirnov@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 04/16/2024 18:12:36
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 184744 [Apr 16 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 17 0.3.17
 f2153f38d75b12894d9cf445f96cd15c9ef63a9d
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.200 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.200
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/16/2024 18:16:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/16/2024 4:06:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Hello!

   Should have been "tuner-simple:" in the subject... :-)

On 4/16/24 2:45 PM, Roman Smirnov wrote:

> simple_tuner_attach() uses the hybrid_tuner_request_state() macro.
> It may return the error code -ENOMEM, but the function handle
> the value 0 instead.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Fixes: b9302fa7ed97 ("media: tuners: fix error return code of hybrid_tuner_request_state()")
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey

