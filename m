Return-Path: <linux-kernel+bounces-22281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA918829BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A419B27A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44824495C8;
	Wed, 10 Jan 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="rgs21n+s"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37AC48CEE;
	Wed, 10 Jan 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 9B8652FC0057;
	Wed, 10 Jan 2024 14:51:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1704894704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45PF4SKouCDbeha7fnHOqQp65vlx3cmuT9w/Tvpf/YY=;
	b=rgs21n+sRKB7C+ayhXpDXTrqzvo0Luly1w7G34zfcM9HUxfrG5fXNFLB0V7bELGpLMvHn8
	SRfNuSzXKJ6QQ2xqJMmqzgEUyOZsfRxiz7RvB7jbAA2oxqymxScVTk13AzKeZTeAobWXas
	VYgRhZjeEs/EcO6t3Suw5bghQuiACe8=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <dd140606-6786-4c4f-9e39-448a4df72bb5@tuxedocomputers.com>
Date: Wed, 10 Jan 2024 14:51:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] i8042: Add forcenorestore quirk to leave
 controller untouched even on s3
Content-Language: en-US
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: hdegoede@redhat.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240104183118.779778-1-wse@tuxedocomputers.com>
 <20240104183118.779778-2-wse@tuxedocomputers.com>
 <ZZ2_KMGdokHNWcNL@google.com>
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <ZZ2_KMGdokHNWcNL@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 09.01.24 um 22:48 schrieb Dmitry Torokhov:
> Hi Werner,
>
> On Thu, Jan 04, 2024 at 07:31:17PM +0100, Werner Sembach wrote:
>> On s3 resume the i8042 driver tries to restore the controller to a known
>> state by reinitializing things, however this can confuse the controller
>> with different effects. Mostly occasionally unresponsive keyboards after
>> resume.
>>
>> These issues do not rise on s0ix resume as here the controller is assumed
>> to preserved its state from before suspend.
>>
>> This patch adds a quirk for devices where the reinitialization on s3 resume
>> is not needed and might be harmful as described above. It does this by
>> using the s0ix resume code path at selected locations.
>>
>> This new quirk goes beyond what the preexisting reset=never quirk does,
>> which only skips some reinitialization steps.
> I think the original change mentioned not only issues on resume, but
> also after boot, which this one does not address, at least directly, so
> I am not sure if this patch is the proper replacement.

The original change introduced issues after boot and fixed issues after resume.

The new quirk fixes the issues after resume without introducing issues after boot.

The issues after boot where only affecting the NHxxRZQ and the N1xxCU iirc.

>
> I would also like to understand better what exact step is troublesome,
> as I would be surprised if any interaction with the keyboard
> controller while suspending causes the issue to manifest. Is it enough,
> by chance, to skip restoring MUX mode and reset?

SERIO_QUIRK_NOMUX and SERIO_QUIRK_RESET_ALWAYS are required in the old fix for 
the resume issues to go away (I don't know if SERIO_QUIRK_NOLOOP and 
SERIO_QUIRK_NOPNP are required, I threw them in just in case because we were 
running them already on the device, so they where somewhat "field proven" to not 
break things).

However while SERIO_QUIRK_NOMUX and SERIO_QUIRK_RESET_ALWAYS for themself did 
not individually introduce the boot problem, in combination they did.

That was all I was able to find out back when I tested the old quirks.

>
> Also, shoudl this system use s2idle by chance?
N1xxCU is s3 only (intel 10th gen clevo)
>
> Thanks.
>

