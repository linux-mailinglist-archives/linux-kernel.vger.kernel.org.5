Return-Path: <linux-kernel+bounces-143371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085CA8A37B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A01C1C216AF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430F15219A;
	Fri, 12 Apr 2024 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAtQmbIR"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92C14EC53;
	Fri, 12 Apr 2024 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956179; cv=none; b=ogZtxx7yzr8B+7LoLVogcyN8vj4umRDiAyYuEh/w9at8u4TW6aux6a1VgHZY+qk3t3ukfe6Tdu672Cd+cQNzbIbxR5gJgFXDNeoRHf7lGj1FFVx199UrwsCQaV0TeQySzlBPF8KqAGsuXGj03CMbnM+BHnvRV9y5WUDx2VeDWKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956179; c=relaxed/simple;
	bh=rzHWCIbqi4sjL6QSVhQQP9hv8/lAhUyduMHxTP3Ob+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZwHUFRARD/RNERvp1XpMT63qxEN2fYY4+sSs62KBV3mZAM7GpDW5CIGWM/6gSZbT608EhtgENxOBt333a4PeJgg9pjx2++AFnyCx2Rkj1BHnfOb0nIGepRUi3lD5oYvq8xsbE55mkg2MYVM49cDcEPhLQ4AuKkjmVciVsPfH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAtQmbIR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed267f2936so1119362b3a.3;
        Fri, 12 Apr 2024 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712956177; x=1713560977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZUh90Dyj5cgS/eWYY+eYS2MnnSGiUd+1OfcQIu3cf0=;
        b=KAtQmbIRJKwoy2p5ItkhaozUOhvqOmT3uHO8YigWnKTAVjtISOpCmlXwroi/XwpcwI
         6e5d0shQFpD1L76eFa/Us09BtYrRFmRXTT0dV5MVdL6L7RZrmw3mmPg/akNvHHrZx0vK
         lJUAenv4kpetzBXNNUwENBEmLmfiJ8RyxI1hvsxvuwob9c4aPmpuxILMsZwHdUx//zpB
         YcA81RSXWRVcL1QnH5B19qY7EMDDUwksybgQiNuc4HrdOwnAL4HotmnbTDakjx1JehIs
         xpJZNiptGqX2/tz8vjMH6/qxOJZ85i6kxpXmlj4cf/x3ieREOcqYXUammJBzrR0fUt/Y
         XBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712956177; x=1713560977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZUh90Dyj5cgS/eWYY+eYS2MnnSGiUd+1OfcQIu3cf0=;
        b=T5pcLFFb+KNVyHgc/98oX/Dcn5YPEX358c4S7AUqxxWtutSgVSsD01wU3K7+O0Mtvf
         bl5oTMek7i6vmGWhL0f3OWLf9TGLiqiH1z9h/gV5Xj2WHtVji5FmOzdE+8DdShOzVroh
         5i6VNoUg9tAAB8Dnprl89bJabAOCATtHGXosaQKe710c4ClianM41ARovE6VFUVwfUF6
         63ifSJAZzaEQhqxhRPA3o/FGMoat+8mwcAbnrHWFmHjpLfJGk58MwNffe6vkaL7dLy0U
         G18ba7zlR5SVYhAa6C/LWCqi9/Sj0uWH/1CL30ZYkVQojjYq/1sgDZwbc/C7QDPpD6LB
         VaYw==
X-Forwarded-Encrypted: i=1; AJvYcCVfyYxlcevHuCKWvl10LlT1bDhy9bW1DvKZcct45cXDJPdp0/cGOqHiX9iV9SOXijpvruXUyhyYuBWFiEHsYZnvsvAw8m+5mqspFzc526URC2G9aIjixqE5w7gQVvCLZD7gn4ah
X-Gm-Message-State: AOJu0Yyoygbd+hiQKr9t1law2TKy/lA8mm5iTbP+SPC1oad0wKhWLaRX
	pTdC7i4RHaODEFMNymqgDc2lz5/Qtyi5SIpwib5bE9SjimAPpHeZ
X-Google-Smtp-Source: AGHT+IFql085XmFCXINlD8eahD3OqMfgHE67+Jg7ozVjWl5Nt0N43ZZPfeydfN8/Hb+LCkQntMev5g==
X-Received: by 2002:a17:902:db08:b0:1e1:a54:1fe8 with SMTP id m8-20020a170902db0800b001e10a541fe8mr4048740plx.53.1712956177068;
        Fri, 12 Apr 2024 14:09:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id lh15-20020a170903290f00b001dd0c5d5227sm3429123plb.193.2024.04.12.14.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 14:09:36 -0700 (PDT)
Message-ID: <cdb1f2e6-dbe0-4a19-b111-5dd8dbd5d44a@gmail.com>
Date: Fri, 12 Apr 2024 14:09:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmasp: fix memory leak when bringing down if
To: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 "open list:BROADCOM ASP 2.0 ETHERNET DRIVER"
 <bcm-kernel-feedback-list@broadcom.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20240412181631.3488324-1-justin.chen@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240412181631.3488324-1-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/24 11:16, Justin Chen wrote:
> When bringing down the TX rings we flush the rings but forget to
> reclaimed the flushed packets. This lead to a memory leak since we
> do not free the dma mapped buffers. This also leads to tx control
> block corruption when bringing down the interface for power
> management.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


