Return-Path: <linux-kernel+bounces-24613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDC782BF29
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDAC28521B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD7B67E7B;
	Fri, 12 Jan 2024 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAh+8zBT"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EDB5D905;
	Fri, 12 Jan 2024 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3e6c86868so53334245ad.1;
        Fri, 12 Jan 2024 03:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705058603; x=1705663403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8svh4pfQOjLe6OwUzI4aKaVoJeRMFzcZfH1Er2Cd4io=;
        b=EAh+8zBT4D1JM0CqsIdWHRuvNtG1xKDNDHTyawUaSy9zvPoZMqe+s4xb51MOZQMHGY
         WA6LeChRkDuqRW8H30/yKGEGcHcTGaIb+p2dP7RmFU4zUyOruR2bWKxT4WqDtHJ5m/d5
         2gyEO4QMla3XrTONFuCj8ZkcRvldx+p+RvDDnBsTT1YOpVA71HWmGztcox/qaQ/y7dJ2
         frN83PgqsfCO+wgnfg78Ct1dAWmkCrCFZiHPDBb/3JyyIgCsr17XEbvU/zCC9tmjDUur
         H1Kjn78nJyvXBgVN9SskFEM1cx6BJAjc2dLf4/CyGGWBhLaMm05SYXLjXnB6vSSmYh5e
         UeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705058603; x=1705663403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8svh4pfQOjLe6OwUzI4aKaVoJeRMFzcZfH1Er2Cd4io=;
        b=tQ+SO64D+gMHAfsG9qDcJy+72KjXEd0OtckZbJeBPxRiOAZpt8ypeKiUEDemmMhkDI
         KWefWVVHI5Lx7ns4tU6PILEWfiEQ2bHOlOXPRQCDjgnh5bodk0faXxNhb4v+j6VUqgZB
         xBNuZcrLj0kDWwIgCEpVYbYEpbvbApws0gRPEMUVACfd5IhRmyIpda0I3+pDKk17fHmr
         6kjwHIQcUZx9w9j1sxDc7v9TdjeSX2kb9jK3m/5PXexXWqQJODskM4PgqFHWRHLyKZhN
         tv24oSk9kTOVGXZMAdPiP01wFBHERLz4BPly5ii4G6XEaNo/07cV6sRILtMqcVyDo+Ef
         71vA==
X-Gm-Message-State: AOJu0Yw+6o7WlaBCAu/+74HD/E66pFNEctdQn1TFAPvVJHhoK4a9Misd
	3y1HX3jg8wJyZzBq2gTOYhs=
X-Google-Smtp-Source: AGHT+IEc9DhkJgFchpWYcM9yxJH6Ny5hAE9JXDddeR+bkGx9zvNjwNVn/SZFIgVZzQkM2tRvvrmZ1A==
X-Received: by 2002:a17:903:1cc:b0:1d4:cca4:7e81 with SMTP id e12-20020a17090301cc00b001d4cca47e81mr868787plh.64.1705058602869;
        Fri, 12 Jan 2024 03:23:22 -0800 (PST)
Received: from ?IPV6:2001:250:206:d960:3c0f:44ea:933a:2c8f? ([2001:250:206:d960:3c0f:44ea:933a:2c8f])
        by smtp.gmail.com with ESMTPSA id iw10-20020a170903044a00b001d494f3d9cesm2904645plb.128.2024.01.12.03.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 03:23:22 -0800 (PST)
Message-ID: <060d729a-259c-4cfd-b785-17986e3e735f@gmail.com>
Date: Fri, 12 Jan 2024 19:23:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: core: Fix atomicity violation in uart_tiocmget
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Tony Lindgren <tony@atomide.com>,
 l.sanfilippo@kunbus.com, tglx@linutronix.de,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>, baijiaju1990@outlook.com,
 stable@vger.kernel.org
References: <20240112075732.16730-1-2045gemini@gmail.com>
 <87msta7vbe.fsf@jogness.linutronix.de>
 <4a52df23-71c3-59c7-fee4-e7cde526d249@linux.intel.com>
From: Gui-Dong Han <2045gemini@gmail.com>
In-Reply-To: <4a52df23-71c3-59c7-fee4-e7cde526d249@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

You are correct about the 'Fixes' tag. It should indeed be c5f4644e6c8b 
("[PATCH] Serial: Adjust serial locking"). I will update this in the 
patch v2.


Regarding the issue found in Linux 5.17, I mistakenly used git blame 
which led to the incorrect identification of commit 559c7ff4e324. The 
issue indeed exists in Linux 5.17 and I acknowledge the error in tracing 
the commit.

In uart_tiocmget(), the result variable is stable. However, there's a 
risk of inconsistency due to the updates in uart_update_mctrl(). 
Consider a scenario where uart_tiocmget() reads uport->mctrl into result 
before entering the critical section. If uart_update_mctrl() updates 
port->mctrl and calls set_mctrl concurrently, the subsequent execution 
of result |= uport->ops->get_mctrl(uport); in uart_tiocmget() might 
yield an inaccurate result. This happens because result contains the old 
value of port->mctrl, which no longer matches the updated state 
retrieved by get_mctrl.

Thanks,

Han


