Return-Path: <linux-kernel+bounces-57566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA54F84DACC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46687B21C51
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83216997A;
	Thu,  8 Feb 2024 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhmnxkKq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CFE69312;
	Thu,  8 Feb 2024 07:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378295; cv=none; b=j0xf3vozDToM7Tt1hrUVanA0uNfhJEkkkbwEgw5DDh6vsYH1ozW4rW9F+OMPEXUOQFu1qfyMz5JCXQ3sZreY87c6mfVWlZCYTp2O7D7pqeE63z9eUKKeb01yO5pC/iJzoPzny7Nkx2sJHw0BvZAuxFlptIiGZd5PUi20Cj+aUkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378295; c=relaxed/simple;
	bh=w0JYTTbDylhH/2WBOTyAoRBXLxPATEaGQ6QDR/k3++A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yqz9V89t7yIINWeU0o6iCE8mIeTuTXQWY0SaZJa0raOd0eLToGpSufm4nL29J8Sgf5JQrKDfT4utviYRcjBelgdWAhK+PAfYpwFY0CkxCcS40MCLydaWrGxbRb03JmSXFdPTBrSIIEXFRfVnNwBtJWcgfT9YtI7EeFks9FjJRAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhmnxkKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CADC433F1;
	Thu,  8 Feb 2024 07:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707378294;
	bh=w0JYTTbDylhH/2WBOTyAoRBXLxPATEaGQ6QDR/k3++A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GhmnxkKqQ94zEoh0hLGsKyGG6s4MP7qMAcF/Tlz5ok1tg5gE4xLZlFpB5CWLoq4Cr
	 p/rMvudaqPULSzRiOXW592ZJRs0c7L/DRu563zCvTgYmwJWFtRZ1yYWenno1VpmFty
	 fznb2+zWC66vimbWjYKrhu7W8C06RmIZcQpZnvrG+FxKauEkK/X4LytC5V3KU/3afJ
	 vIXfUJzrD4e68+8FI4rhyWPi6ncqlFG2qMdUdI23O1PVSc7pT8cljs+M1KQzqFdcJx
	 pi34b0+qfjl0A+0vOYbmxlT9cAykyex9zVks4z7suydtsznh8pGAHQSJ5hvsH+3nZD
	 x3xlt8yXWQNUg==
Message-ID: <d10350d1-11e6-497f-9e81-d484bc0aece1@kernel.org>
Date: Thu, 8 Feb 2024 16:44:51 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: asm1064: correct count of reported ports
Content-Language: en-US
To: Andrey Melnikov <temnota.am@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <vbpzr7uqpfemb3qa6xy2fxioct44l5vugg2wkywyolfpzqcmau@jgrrhmk2scaj>
 <31d9b48d-320b-44b6-9ab5-d53f741dcc72@redhat.com>
 <CA+PODjozWG6iXcR01KE4N1DyTKeKXtravwanWS3Gtq8mEqutuA@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CA+PODjozWG6iXcR01KE4N1DyTKeKXtravwanWS3Gtq8mEqutuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/8/24 16:21, Andrey Melnikov wrote:
>>
>> Hi Andrey
>>
>> On 2/7/24 10:58, Andrey Jr. Melnikov wrote:
>>> The ASM1064 SATA host controller always reports wrongly,
>>> that it has 24 ports. But in reality, it only has four ports.
>>>
>>> before:
>>> ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
>>> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
>>> ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst
>>>
>>> after:
>>> ahci 0000:04:00.0: ASM1064 has only four ports
>>> ahci 0000:04:00.0: forcing port_map 0xffff0f -> 0xf
>>> ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
>>> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode
>>
>> This still says 24 ports, is that a copy & paste error in the commit msg ?
> 
> This is the raw value of the read-only Host Capability register, how
> should it be changed here? If silicon lies about its configuration -
> kerel prints what it sees from silicon.

This should print the actual number of ports that you forced with the port map
change:

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1a63200ea437..7cb3f137bc1b 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2637,7 +2637,7 @@ void ahci_print_info(struct ata_host *host, const char *scc_s)
                vers & 0xff,

                ((cap >> 8) & 0x1f) + 1,
-               (cap & 0x1f) + 1,
+               (cap & hpriv->saved_port_map) + 1,
                speed_s,
                impl,
                scc_s);


-- 
Damien Le Moal
Western Digital Research


