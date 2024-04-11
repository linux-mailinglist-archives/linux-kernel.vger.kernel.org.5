Return-Path: <linux-kernel+bounces-141435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DC08A1E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BE628BF6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F8E4087B;
	Thu, 11 Apr 2024 17:56:18 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB03F9CB;
	Thu, 11 Apr 2024 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858178; cv=none; b=X6LOUcOhz92wtEtM5KTIfO8/WjqJrJTl3uoF61Ctd8PUj5W7nSBJQBoakEvw51CTxhC3B17XpfNtUiitLrRxe2FbfyyL+Pv4bkYwi2Ai5O7AkmGZhPWp94JXiid7SgUt2hDAbNyO6oJjUML/uOroRWL+Pg8yYMh+HZ9PcW/jI9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858178; c=relaxed/simple;
	bh=lM0JrKFMnVWxg7ZhHZ22iVaZdtHVDJwtbdyMIQClsJE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qQgVoFqopLieJDhrleqRKAdMtMlPUsndOB3zAUqrzGK+z277k2OeJriA0Bhe/p2qzezDuqIBpK5IXUY9P90mxoupgDgjPujsOz33aXRg/sB/SfDsnM972cjQI3Cutb0DKTgAUJ+7YTuQ+2w3Lyb6wVDlKG42A043eBxve7/tZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.74.224) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 11 Apr
 2024 20:56:08 +0300
Subject: Re: [PATCH net 4/4] net: ravb: Fix RX byte accounting for jumbo
 packets
To: Paul Barker <paul.barker.ct@bp.renesas.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240411114434.26186-1-paul.barker.ct@bp.renesas.com>
 <20240411114434.26186-5-paul.barker.ct@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <bdaf93f3-099a-8f4a-4db1-53293f6fb9d6@omp.ru>
Date: Thu, 11 Apr 2024 20:56:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240411114434.26186-5-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 04/11/2024 17:36:52
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 184678 [Apr 11 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 16 0.3.16
 6e64c33514fcbd07e515710c86ba61de7f56194e
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.224
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/11/2024 17:40:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/11/2024 10:51:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 4/11/24 2:44 PM, Paul Barker wrote:

> The RX byte accounting for jumbo packets was changed to fix a potential
> use-after-free bug. However, that fix used the wrong variable and so
> only accounted for the number of bytes in the final descriptor, not the
> number of bytes in the whole packet.
> 
> To fix this, we can simply update our stats with the correct number of
> bytes before calling napi_gro_receive().
> 
> Also rename pkt_len to desc_len in ravb_rx_gbeth() to avoid any future
> confusion. The variable name pkt_len is correct in ravb_rx_rcar() as
> that function does not handle packets spanning multiple descriptors.
> 
> Fixes: 5a5a3e564de6 ("ravb: Fix potential use-after-free in ravb_rx_gbeth()")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey

