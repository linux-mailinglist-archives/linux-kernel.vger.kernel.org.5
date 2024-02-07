Return-Path: <linux-kernel+bounces-56844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE74384D026
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFE51C21214
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAD082D64;
	Wed,  7 Feb 2024 17:48:27 +0000 (UTC)
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289D82893;
	Wed,  7 Feb 2024 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328107; cv=none; b=S4mEChw2aGzbhimwDlpwBN8K89Yw9m3GATctGBa+X/5sAJHuJk58SUigb/H5PAS1zjG+EXAT4jvQ0EMQs+ZazBSE9CesyJ07mh35k5T9xgXDODqvguv91FBpu1dVUBpKwwWIabB0GLbPK78jQ5+9xEwapxeOVYm6f+WE/SrkoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328107; c=relaxed/simple;
	bh=o02pz7pJZXwRjYcyMIyVbmF68R2luuR2jXPAGpeEw/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfQ1ACnMBjDCp9zhwPx9rsKq0Jwe/t1Mkpj3QikbuZAjWGYjuT77pRMd0fO/riZncRnEXqlKEiDZQ7cvZt8JSHf+05LkN6Mm0Xcm3F3m1XAxFbO6f1OLjJAzwOsKLYXnG1xMoHLiQH6wUvOnhQEXyK2C0bZyE/yNKToc/uwVFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from [IPV6:2a01:e34:ec1e:c710:ccdf:3390:9661:e9c9] (unknown [IPv6:2a01:e34:ec1e:c710:ccdf:3390:9661:e9c9])
	(Authenticated sender: lagiraudiere@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 9B4FF13F8B8;
	Wed,  7 Feb 2024 18:48:14 +0100 (CET)
Message-ID: <4879c094-5fdc-4fe4-a7ba-21168d7b2afe@free.fr>
Date: Wed, 7 Feb 2024 18:48:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ALSA: hda/realtek: cs35l41: Fix internal speaker
 support for ASUS UM3402 with missing DSD
Content-Language: fr-FR, en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 linux-sound <linux-sound@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 patches <patches@opensource.cirrus.com>
References: <726559913.576332068.1707239153891.JavaMail.zimbra@free.fr>
 <87o7cs5r29.wl-tiwai@suse.de>
 <1366935939.585144512.1707316246651.JavaMail.zimbra@free.fr>
 <87jzng5mzv.wl-tiwai@suse.de>
From: =?UTF-8?Q?Jean-Lo=C3=AFc_Charroud?= <lagiraudiere+linux@free.fr>
In-Reply-To: <87jzng5mzv.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/02/2024 à 16:10, Takashi Iwai a écrit :
> Jean-Loïc Charroud wrote:
>> Fix device ID for "ASUS UM3402" and "ASUS UM6702RA/RC".
> This change is only about the string in the table, not the actual
> behavior, right?

Well, not sure it doesn't matter.
Before the device ID were swapped, my syslog reported :
     cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Error: ACPI _DSD
     Properties are missing for HID CSC3551.
And then, after the patch 51d976079976c800ef19ed1b542602fcf63f0edb, it
reports :
     cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Failed property
     cirrus,dev-index: -22
So, as it looks like a regression, it makes me think that the model name
may be checked along the device ID...

> The name string there is only for debug info, so
> it's no big problem even if it's not 100% right.
> That is, this can be again split to another patch -- with the
> additional Fixes tag to the commit that introduced the entries.
> 
>> Add DSD values for "ASUS UM3402" to cs35l41_config_table[].
> ... and this one is the mandatory fix for your device.  It should be
> the patch 1.  Then we'll have two more, one for correcting the entry
> names, and another for sorting the entries.
I already submitted that last one
> 
> I'm a bit picky, but now you see how the things work.
> Divide-and-conquer is the basic strategy.
Yes, but not smooth, as I have to workaround my broken mailer...

regards
Loïc

