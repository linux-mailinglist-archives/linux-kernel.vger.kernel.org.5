Return-Path: <linux-kernel+bounces-8323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B78981B5AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF52285FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05E56EB5F;
	Thu, 21 Dec 2023 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="GkwhSoJP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2AA2206F;
	Thu, 21 Dec 2023 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.27] (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 467E32FC004D;
	Thu, 21 Dec 2023 13:21:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1703161260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaTXdxxi1qEmCPfc18xKCwxA9qIyX/tmNomXuvnbtvo=;
	b=GkwhSoJP79bqpFsKzA7v/FduanVrV1FlmEb12tG4qGDT0z7ZDIiJZMVdYZEyzHiSyPwoX8
	YPpPrNVfibGUxTrWHcWQtmm2YVpRE3zdv1mISQ77YHtCR6nnpvqoXHBtIDN5OtyIPYXU9R
	Z8Puf/uaE6aN9OVFLVxZIw9TOlKLHdQ=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <4aa4b757-13eb-4653-99eb-16aec7c8a3d9@tuxedocomputers.com>
Date: Thu, 21 Dec 2023 13:20:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Werner Sembach <wse@tuxedocomputers.com>
Subject: Re: [PATCH] thunderbolt: Reduce retry timeout to speed up boot for
 some devices
To: Greg KH <greg@kroah.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231220150956.230227-1-wse@tuxedocomputers.com>
 <2e00a0dc-5911-44ee-8c50-a8482eb44197@tuxedocomputers.com>
 <2023122012-spruce-unsteady-e187@gregkh>
Content-Language: de-DE, en-US
In-Reply-To: <2023122012-spruce-unsteady-e187@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 20.12.23 um 17:04 schrieb Greg KH:
> On Wed, Dec 20, 2023 at 04:23:15PM +0100, Werner Sembach wrote:
>> Am 20.12.23 um 16:09 schrieb Werner Sembach:
>>> This is a followup to "thunderbolt: Workaround an IOMMU fault on certain
>>> systems with Intel Maple Ridge".
>>>
>>> It seems like the timeout can be reduced to 250ms. This reduces the overall
>>> delay caused by the retires to ~1s. This is about the time other things
>>> being initialized in parallel need anyway*, so like this the effective boot
>>> time is no longer compromised.
>>>
>>> *I only had a single device available for my measurements: A Clevo X170KM-G
>>> desktop replacement notebook.
>>>
>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> I wonder if this could also land in stable? Or would it be to risky?
> If it's really a bugfix now, why would it _not_ be relevant for stable?

edit: Sorry if this is the 3rd time I send this, I got mail server 
errors (hopefully fixed now) and am not sure if it reached out

Because it changes a timeout that could cause issues if set to low: This 
Patch sets to to 250ms. Set to 50ms it causes issues, currently it's 
2000ms, 2 people tested that 250ms is enough, but i don't know if this 
is a big enough sample size for stable.

The advantage is significantly faster boot time on affected devices 
(~12s down to ~3s), however they do already work fine without it.

Kind regards,

Werner

>
> thanks,
>
> greg k-h

