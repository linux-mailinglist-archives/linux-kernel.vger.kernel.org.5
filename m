Return-Path: <linux-kernel+bounces-27100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6269482EA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D831C225B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEAD111BA;
	Tue, 16 Jan 2024 07:53:33 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1E7483;
	Tue, 16 Jan 2024 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.86.62) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 16 Jan
 2024 10:53:12 +0300
Subject: Re: [PATCH v3 2/2] usb: host: xhci-plat: Add support for
 XHCI_SG_TRB_CACHE_SIZE_QUIRK
To: Prashanth K <quic_prashk@quicinc.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Mathias Nyman <mathias.nyman@intel.com>
CC: Hans de Goede <hdegoede@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240116055816.1169821-1-quic_prashk@quicinc.com>
 <20240116055816.1169821-3-quic_prashk@quicinc.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <f0dd0455-e278-ee28-5463-34879ad9868c@omp.ru>
Date: Tue, 16 Jan 2024 10:53:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240116055816.1169821-3-quic_prashk@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/16/2024 07:33:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182664 [Jan 16 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.62 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.86.62
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/16/2024 07:39:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/16/2024 5:28:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/16/24 8:58 AM, Prashanth K wrote:

> Upstream commit bac1ec551434 ("usb: xhci: Set quirk for
> XHCI_SG_TRB_CACHE_SIZE_QUIRK") introduced a new quirk in XHCI

   It's xHCI. :-)

> which fixes XHC timeout, which was seen on synopsys XHCs while

   xHC.

> using SG buffers. Currently this quirk can only be set using
> xhci private data. But there are some drivers like dwc3/host.c
> which adds adds quirks using software node for xhci device.

   Double "adds".

> Hence set this xhci quirk by iterating over device properties.
> 
> Cc: <stable@vger.kernel.org> # 5.11
> Fixes: bac1ec551434 ("usb: xhci: Set quirk for XHCI_SG_TRB_CACHE_SIZE_QUIRK")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
[...]

MBR, Sergey

