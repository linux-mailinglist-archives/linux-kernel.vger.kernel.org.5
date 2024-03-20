Return-Path: <linux-kernel+bounces-108836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C848810AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D481F24431
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B033D393;
	Wed, 20 Mar 2024 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="JLKYxriM"
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11D52F72;
	Wed, 20 Mar 2024 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933202; cv=none; b=E4RqzMOJ9C0wdO/pubwENom24nTsz56oW+FT+G7ZyuYS1z97g1zkASnnzlvz0GFoJ5T22xAB6AwHIRD9VBEkEcxFb4wniueGlGeVO383SEcr0r7dv14B2gMXDHSgOwa2jq/NpS8hEtLgU4XJbqFqy0L6mBeAPi3ys+4CjqIL+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933202; c=relaxed/simple;
	bh=KkoXZqXTiQUiGpG1SwuWDZlorVWMeQ5IO4olyeGPWfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lk8O7zMarLa5w/9ybDlcfyNaadbpZmw+Dk7VyyTvuckOAXtSvdixDvIgtAVydgv9JuRpH7ay5DmLPgS0Umnwonu+75uVpdYV4oNXc0bn9uyOmfEtFQ7bf32dtoIHwh/rdQ3cpo0TiQN/gyMb+8ceTKnB+D7yxG8HNHb29dHFelI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=JLKYxriM; arc=none smtp.client-ip=166.84.1.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by l2mail1.panix.com (Postfix) with ESMTPS id 4V056g2b3gzDQ2;
	Wed, 20 Mar 2024 06:53:31 -0400 (EDT)
Received: from [192.168.126.36] (ip70-164-218-85.oc.oc.cox.net [70.164.218.85])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4V056R00Fnz1Cjt;
	Wed, 20 Mar 2024 06:53:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1710932000; bh=KkoXZqXTiQUiGpG1SwuWDZlorVWMeQ5IO4olyeGPWfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JLKYxriMX7zMfvqajAhu61lGwcXTSuYM5aom+l91dfXJe3yVu9xu8UsWUMZ9f5/MV
	 /QEFLVN2rd5UPVcICEuTm09jLSfe9A0GRsK5HpkZADZ0S56IdZa7Lj7W5hIafYkES8
	 YtqIk/BREIuLPvxDgftxek5C/jIc02y7B+VPfdbc=
Message-ID: <fba7503a-7947-4487-95e6-9d41d636b075@panix.com>
Date: Wed, 20 Mar 2024 03:53:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Fix various races in UCSI
To: "Christian A. Ehrhardt" <lk@c--e.de>, linux-kernel@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Prashant Malani <pmalani@chromium.org>, Jameson Thies <jthies@google.com>,
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 =?UTF-8?Q?Samuel_=C4=8Cavoj?= <samuel@cavoj.net>, linux-usb@vger.kernel.org
References: <20240320073927.1641788-1-lk@c--e.de>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20240320073927.1641788-1-lk@c--e.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Applied (cleanly) onto 6.8.1; I'll be testing over the next few days, 
but a few connects/disconnects mixed in with suspend/resume cycles shows 
no obvious issues (and everything seems to work).

Dell XPS 9320, BIOS 2.10.0

-K

On 3/20/24 00:39, Christian A. Ehrhardt wrote:
> Fix various races in UCSI code:
> - The EVENT_PENDING bit should be cleared under the PPM lock to
>    avoid spurious re-checking of the connector status.
> - The initial connector change notification during init may be
>    lost which can cause a stuck UCSI controller. Observed by me
>    and others during resume or after module reload.
> - Unsupported commands must be ACKed. This was uncovered by the
>    recent change from Jameson Thies that did sent unsupported commands.
> - The DELL quirk still isn't quite complete and I've found a more
>    elegant way to handle this. A connector change ack _is_ accepted
>    on affected systems if it is bundled with a command ack.
> - If we do two consecutive resets or the controller is already
>    reset at boog the second reset might complete early because the
>    reset complete bit is already set. ucsi_ccg.c has a work around
>    for this but it looks like an more general issue to me.
> 
> NOTE:
> As a result of these individual fixes we could think about the
> question if there are additional cases where we send some type
> of command to the PPM while the bit that indicates its completion
> is already set in CCI. And in fact there is one more case where
> this can happen: The ack command that clears the connector change
> is sent directly after the ack command for the previous command.
> It might be possible to simply ack the connector change along with
> the first command ucsi_handle_connector_change() and not at the
> end. AFAICS the connector lock should protect us from races that
> might arise out of this.
> 
> Christian A. Ehrhardt (5):
>    usb: typec: ucsi: Clear EVENT_PENDING under PPM lock
>    usb: typec: ucsi: Check for notifications after init
>    usb: typec: ucsi: Ack unsupported commands
>    usb: typec: ucsi_acpi: Refactor and fix DELL quirk
>    usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE before reset
> 
>   drivers/usb/typec/ucsi/ucsi.c      | 56 ++++++++++++++++++++--
>   drivers/usb/typec/ucsi/ucsi_acpi.c | 75 +++++++++++++-----------------
>   2 files changed, 84 insertions(+), 47 deletions(-)
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

