Return-Path: <linux-kernel+bounces-83967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB7B86A0AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA19B22DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4D214A4CB;
	Tue, 27 Feb 2024 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og5V9PsC"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B60149E06
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709064776; cv=none; b=mFyfQT1NPwW05qVDC/O/AQxTaOikwtNo2lWWjnlMWiBhf+4zO8sI1J67Fg7RaE7ZPQbprZ34eY3yXj7HLsbcnnwhIdygRg886gzORNR3wOpwZQCIfT5Z8URIRiYPovnoV+wSeUbKdzy/jFXtUGEgg7m01hKSyVJzL6Vj3zqaHHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709064776; c=relaxed/simple;
	bh=FDmqjzO60Q8OrR7guOVB+g5v8pY6Y2fCRozeYYaZhOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKqxy0axrcEwSojrB9xaGgIAYsXjN0F0g9v6+EmimYpI9uN7aH9RYDZPMnvS96pSL1G7q8dDouWisQtDuB4LL9cyYtEy10vmlTGUXBwlzLgyJJsSB1rk5r9RIiHNYL062Tp7qRs0boWV2OijTaMrxMX5YEOROEGn/qlKiOs6dGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og5V9PsC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a43e705b183so5067466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709064773; x=1709669573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcLhI7SOzfDL6TZcUhIL0ITt+5YPCX+hAG9zA73+PiM=;
        b=Og5V9PsCywCQ/6Rn03CiYVhug+uUdN+R6QUksypS6JBmphBd2gPslzo1M4Q9YkLM99
         9/JgPoska/JzbmpkRRbvLA+66FfRhnKPSqa17ijjeuMbkHxWH5SUsCzfTVZSIOOGcFQU
         xORz2sg4W4349Bb1WHfNJ3hbo+bI4fqR6IDsFxUv5oHmnF7kLiqIYUtr65DxEbMqIyYL
         NPb9K+Mg0NYFBQ5w7nu+euc3FYCh9ASB8PBbqMkrljWMzSC7QvAc3l/1jr4G4zjSE5CX
         o3xKx0/3WpAp9JGkPM9ZcZQf+3SNTlgdmOGdvZ/pAhTxYR02DVcgDd32LPRi/7bWT9L+
         qgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709064773; x=1709669573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcLhI7SOzfDL6TZcUhIL0ITt+5YPCX+hAG9zA73+PiM=;
        b=LTVUMiZUpHC4ZNvHNTZJ3BhWceMvSABHp9qQJmLLm/lMuZ0fX6APqzHzDHjIM7sOoE
         /5Jww/C/OcbPtO//gKoXqCjRo4lL96sr6TTmFhMs7VXshOR4IJ21Ejy4XVezC8PAEHeA
         qP/zrWXTr1jFIphovnw1+KO41zFaETqQr6ImM3Edf7LhO8WDX0IrbRainh/KCgGROKxg
         JEU9MhXY+z7/zYSgAgGcXc+qXYeKhFSyoboerlaKVVBRosR+7gSYHb7LMN4Ahj5+r28e
         u2QtcdG0xH5i0nWlDhnpo5RPxA6+7ldx2ptYi3QYhQ/Gi4NF2Wov01Ezu4xJSci6OX6G
         UPjA==
X-Forwarded-Encrypted: i=1; AJvYcCWgA+CtQJdxExfWP28Lh3p64r/Z3uLbB8dh8qDynzx1ssR9OlUj+pnAUAkDo5kUOQqmiryMofmorvMfS04h0Q95vE8xrXrDXhbI5+hw
X-Gm-Message-State: AOJu0YwMQnli4qYL+33jf9CXV9DajyjF+9XulgHypuYJhKpIzvwcsndN
	liFMsHzfvRMq/M3LUu5mqxKWIR04yvKGpPkReeP7cxSz8kGzNqWT
X-Google-Smtp-Source: AGHT+IHwGyuUWcZpsCuJ8SOrNeKpFeSxRYrLn7Ff7b4cl/bcE/Asw0z0KAYCfoosb6RCR5Uvy6oDaQ==
X-Received: by 2002:a17:907:7808:b0:a3e:9a90:7f68 with SMTP id la8-20020a170907780800b00a3e9a907f68mr6250562ejc.7.1709064772994;
        Tue, 27 Feb 2024 12:12:52 -0800 (PST)
Received: from [192.168.0.102] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id cx6-20020a170907168600b00a43ecf3ab6bsm45716ejd.38.2024.02.27.12.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 12:12:52 -0800 (PST)
Message-ID: <3905a925-031f-4e98-8eee-ecf79ac1faa5@gmail.com>
Date: Tue, 27 Feb 2024 21:12:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] Staging: rtl8192e: Fix checkpatch warning for
 rtllib_softmac.c
To: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
 anjan@momi.ca
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240227044157.407379-1-tdavies@darkphysics.net>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240227044157.407379-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 05:41, Tree Davies wrote:
> This patch series attacks checkpatch camelcase variables warnings found in
> rtllib_softmac.c.
> Thank you in advance to reviewers.
> ~ Tree Davies
> 
> v2: Fixes a few alignment and commit messages which went over 75 chars.
> 
> Tree Davies (20):
>    Staging: rtl8192e: Rename function rtllib_rx_ADDBAReq()
>    Staging: rtl8192e: Rename variable NumRecvDataInPeriod
>    Staging: rtl8192e: Rename function SecIsInPMKIDList()
>    Staging: rtl8192e: Rename variable PMKIDList
>    Staging: rtl8192e: Rename variable Turbo_Enable
>    Staging: rtl8192e: Rename variable osCcxRmCap
>    Staging: rtl8192e: Rename variable bCkipSupported
>    Staging: rtl8192e: Rename variable bCcxRmEnable
>    Staging: rtl8192e: Rename variable CcxRmCapBuf
>    Staging: rtl8192e: Rename variable BssCcxVerNumber
>    Staging: rtl8192e: Rename variable CcxVerNumBuf
>    Staging: rtl8192e: Rename variable asRsn
>    Staging: rtl8192e: Rename variable AironetIeOui
>    Staging: rtl8192e: Rename variable osCcxAironetIE
>    Staging: rtl8192e: Rename variable CcxAironetBuf
>    Staging: rtl8192e: Rename varoable osCcxVerNum
>    Staging: rtl8192e: Rename varoable asSta
>    Staging: rtl8192e: Rename reference AllowAllDestAddrHandler
>    Staging: rtl8192e: Rename boolean variable bHalfWirelessN24GMode
>    Staging: rtl8192e: Rename function MgntQuery_MgntFrameTxRate
> 
>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |   2 +-
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |   6 +-
>   drivers/staging/rtl8192e/rtl819x_BAProc.c     |   2 +-
>   drivers/staging/rtl8192e/rtllib.h             |  25 ++--
>   drivers/staging/rtl8192e/rtllib_rx.c          |  30 ++--
>   drivers/staging/rtl8192e/rtllib_softmac.c     | 128 +++++++++---------
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c  |   4 +-
>   7 files changed, 99 insertions(+), 98 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

