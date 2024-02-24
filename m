Return-Path: <linux-kernel+bounces-79547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209CD8623F9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABFC1C21BBE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF411BC3B;
	Sat, 24 Feb 2024 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HmdkCEdD"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8E1AAD0
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708767667; cv=none; b=RTOFPCeHlMgjya2ENPt7lloS/s7F8QpS/L+94axKMhjGRHRnxnWyzllGk11mxkY3UtVIOu175d7gjBZ7Ayt9og4hbrCw95ZikvlK//SsfwbAgS2nj/Mk3+barzKU7lxYo7rG7BXUva26yZr/hC7husbXCydDOuhvwksMwRfCqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708767667; c=relaxed/simple;
	bh=UEFxROxE6KP7hbsHlQuKhYmjvKut4tKaZLEG/90dHnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLo+9NtE76/xjI5FigUCyJ8dy0Q4DIWxPTMLB+Bx6KnO/Zmhv5KwvkadQ2pfvG2xnYD7T7LvTHCS0BNPTmJvKadP+ewhaYYY4Jt7njmBlsn0qlqPUHzk5k9iHwS2o2E9WGYkTNAGskLOR4WbWNjdm8G7k053gvLn14V/Ul06aE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=HmdkCEdD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4129f291fa7so477885e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708767663; x=1709372463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9v4R1LcjkjY5cWdbqRcV+KS7qfSyvUTSBFeDxDIrljY=;
        b=HmdkCEdDBEb0hUoPXbEx8PLuzMUGEp+YK5OOFbuDLvD4AuJz56an7hZApsCef3o7hH
         XR4Q0+Hwt+ARkoS65145mXVm8QpemZUbVvdFURaLbm8KbK4CW+gE+M/gZab8REYL4kWI
         Ja/EGOjPaXDjavbcZDaS310vFcCAUjUlu7Qc9HBYdvzy7eZEmLYu2hKHYiLNeNqsAM/R
         FBq2NY7nNa3OS38RipInsdZ3xPVyY7op8qo+X4ssGXp/URVRWtuOAtM2p+XXDNN44KFo
         lMKq6QdwffH31Wdsof+9MZRO/81LwWE3jNAWPSCcMQ7o1q5xSCKL8aA/0U0WyI22G54o
         RxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708767663; x=1709372463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9v4R1LcjkjY5cWdbqRcV+KS7qfSyvUTSBFeDxDIrljY=;
        b=dObSUVVUFI05em7gRYk0YiaFFBu3EmUOILPTTSYyDCA2PB9fnNBUKOSpaK0SKGNgop
         3MUQGjHoekZ1Ouk8aPEHWGgkeTHApDUWaJ47D74hvxQi8zTjjF4qDt7OoBh13+4VXvSv
         HCOp7jO8KqywJjWH6JwUylXb0ipL1JrjQ72ns6CRSaernIbMkkqqn4XZCptE/WxMZnjN
         KzNG38HJLRAarQBVkZQq5PVGKZC6DJIw1GJCUU42U3QDG4B1ihrb6NWMY3i0td6Oegdv
         6syrRsF8ExUZGh7bO8yxIS/WdK5gPjMnuilEqZGCHxfrDqlTqs94HUnsL9b+N+xu/1iD
         RHXg==
X-Forwarded-Encrypted: i=1; AJvYcCUhSxUf0XK81hUr40QY2QreCSDthP0HtiiX8CyoCOND1zE/bgeZk/Jgb/sdkzcCItMYPXUytSNWPIck8l8RruIALhSKAuqfTD9AuEQZ
X-Gm-Message-State: AOJu0YxgeAd+2gsi+NsQzWaaOt4wEzaNsIg950LAfFWRiJxik64tjsAT
	oWKYNgARyuOYzKM7UOME8Yn376DdqchTY02CzlwQf3pt1rNKqlUknwWkln5neg==
X-Google-Smtp-Source: AGHT+IEyK9H6qTd17qmPlYqNBSh17XoUaXYRRxKBzbl5Zs/nMraTHjuqZ5EBJfQ2dbtVFWQsGALWug==
X-Received: by 2002:a05:600c:1d07:b0:412:6015:3dc5 with SMTP id l7-20020a05600c1d0700b0041260153dc5mr1121291wms.14.1708767662930;
        Sat, 24 Feb 2024 01:41:02 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f14-20020adff98e000000b0033cf60e268fsm1509225wrr.116.2024.02.24.01.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 01:41:02 -0800 (PST)
Message-ID: <ff642d38-17b8-4b12-b2ff-a819b193b2e6@arista.com>
Date: Sat, 24 Feb 2024 09:40:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/10] net/tcp: Move tcp_inbound_hash() from
 headers
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Dmitry Safonov <0x7f454c46@gmail.com>
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
 <20240224-tcp-ao-tracepoints-v1-3-15f31b7f30a7@arista.com>
 <CANn89iKB3ov_rthyscWn=h4yxmhReXAJzHu9+dOdpzPA8F=C-w@mail.gmail.com>
Content-Language: en-US
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iKB3ov_rthyscWn=h4yxmhReXAJzHu9+dOdpzPA8F=C-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/24/24 09:30, Eric Dumazet wrote:
> On Sat, Feb 24, 2024 at 10:04 AM Dmitry Safonov <dima@arista.com> wrote:
>>
>> Two reasons:
>> 1. It's grown up enough
>> 2. In order to not do header spaghetti by including
>>    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
>>
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> Okay, but what about CONFIG_IPV6=m ?
> 
> I do not see any EXPORT_SYMBOL() in this patch.

Ouch. I keep forgetting about that case, will fix in v2.

Thanks,
             Dmitry


