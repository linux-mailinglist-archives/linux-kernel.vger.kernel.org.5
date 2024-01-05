Return-Path: <linux-kernel+bounces-17706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 147C4825166
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB69A1F22471
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8203124B3A;
	Fri,  5 Jan 2024 10:01:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B13250E1;
	Fri,  5 Jan 2024 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.104] (178.176.73.147) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 5 Jan
 2024 13:01:18 +0300
Subject: Re: [PATCH] usb: typec: tipd: Separate reset for TPS6598x
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jai Luthra <j-luthra@ti.com>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>, Javier Carrasco
	<javier.carrasco@wolfvision.net>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rogerq@kernel.org>, <r-gunasekaran@ti.com>,
	<vigneshr@ti.com>, <d-gole@ti.com>
References: <20240105-next-tps-fix-v1-1-158cabaec168@ti.com>
 <78925337-0bba-ca7d-aeb1-2d5c53c565ea@omp.ru>
 <2024010559-passcode-bogus-2c97@gregkh>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <7f026dfe-d143-0d4c-6e3d-fe52ba49a6b7@omp.ru>
Date: Fri, 5 Jan 2024 13:01:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024010559-passcode-bogus-2c97@gregkh>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/05/2024 09:46:20
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 182464 [Jan 04 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_phishing_log_reg_50_60}
X-KSE-AntiSpam-Info: {Tracking_arrow_text}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;178.176.73.147:7.1.2;127.0.0.199:7.1.2;omp.ru:7.1.1;lore.kernel.org:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.73.147
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/05/2024 09:51:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/5/2024 9:01:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/5/24 12:34 PM, Greg Kroah-Hartman wrote:

[...]
>>> Some platforms like SK-AM62, SK-AM62A cannot boot up to prompt if
>>> TPS6598x is cold-reset during unconditionally on probe failures by
>>
>>    Hm, I can't parse this. During what?
> 
> See the thread that is listed here:
> 
>>> Closes: https://lore.kernel.org/linux-usb/vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws/

   I don't see how it helps with what seems to be a grammar issue...
Either a noun should follow "during" or that "during" just shouldn't
be there...

> thanks,
> 
> greg k-h

MBR, Sergey

