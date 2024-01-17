Return-Path: <linux-kernel+bounces-29032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25783830745
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B719C1F25E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663D6200D4;
	Wed, 17 Jan 2024 13:43:36 +0000 (UTC)
Received: from abrecht.li (75-128-16-94.static.cable.fcom.ch [94.16.128.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0841EB57;
	Wed, 17 Jan 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.16.128.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705499016; cv=none; b=N0qAHtlihCoeQmFN3bFIKUxFnGfmYWVfGMxQXFZu5n5deGFaTMowAwKcME160KGO4Qa+R+6gIYgHf94O4diKilX6NYJXWXrGJv19EPU09JsaRaOcZVBdypTdK00N9YTqX/0ij6nT6SF1aIY93d9O/hqFT3oTnJwfGicvxCJkb6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705499016; c=relaxed/simple;
	bh=ave8t9vkikk78SpxRVYd/f2DVs9ehtdThblYaLi2WpQ=;
	h=DKIM-Filter:Received:MIME-Version:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=KNnV2I8KlkeJc7BLeLATHrp7J2kqvP7buzxx6vhpi5ioXfjQ+KVnalF7XP5Qnvu+womkeEuYndQVmHS5ajnvxwQZcdlQlaao0ESz12IWdqJnCg5RsMtazhexZNM9Mo0PrxeTmwWn7Wd6x8TXzn2CDlPOR5uhxbTUOZrTYP+Aft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nodmarc.danielabrecht.ch; spf=pass smtp.mailfrom=nodmarc.danielabrecht.ch; arc=none smtp.client-ip=94.16.128.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nodmarc.danielabrecht.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nodmarc.danielabrecht.ch
DKIM-Filter: OpenDKIM Filter v2.11.0 abrecht.li 5A8DD26B90E8
Received: from toucan.dmz.abrecht.li (unknown [IPv6:fc00:4::a3c:111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by abrecht.li (Postfix) with ESMTPSA id 5A8DD26B90E8;
	Wed, 17 Jan 2024 13:43:30 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Jan 2024 14:43:30 +0100
From: Daniel Abrecht <linux-sound@nodmarc.danielabrecht.ch>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core.c: Add "Unknown" and "Unknown Product" to
 dmi_blacklist
In-Reply-To: <473c1c2b-3426-4ec7-8319-dd08f3ae5a0c@perex.cz>
References: <78a54997daea2b327ad59d495bc33851@abrecht.li>
 <473c1c2b-3426-4ec7-8319-dd08f3ae5a0c@perex.cz>
Message-ID: <526ceb99c42913585364fd2ee1eba8db@nodmarc.danielabrecht.ch>
X-Sender: linux-sound@nodmarc.danielabrecht.ch
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Am 2024-01-17 13:20, schrieb Jaroslav Kysela:
> On 17. 01. 24 13:14, Daniel Abrecht wrote:
>> In U-Boot, the default for DMI vendor / product if not set is 
>> "Unknown"
>> and "Unknown Product".
>> See
>> https://source.denx.de/u-boot/u-boot/-/blob/v2023.10/lib/smbios.c?ref_type=tags#L272
>> 
>> This patch adds them to the dmi_blacklist.
>> 
>> Signed-off-by: Daniel Abrecht <public@danielabrecht.ch>
> 
> I think that there's a whitespace issue, but for the contents:
> 
> Acked-by: Jaroslav Kysela <perex@perex.cz>

Sorry about the whitespace thing. I'll try again.

