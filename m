Return-Path: <linux-kernel+bounces-47456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5456D844E30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F8BB23D33
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122073D69;
	Thu,  1 Feb 2024 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="AZ7tWp9I"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B61920E4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748657; cv=none; b=YG8uOocnvjJM5zciPWyhygInIflGLcdxsR/nnkQagHo7qMLY18xBYOxZqnhzHTaWQR3BSthCE3SfkLHZhfPrltn+RcFzqJL8eQkNrUpRl3k+CiyXWtqmMeOO/qGNRuEKaeKB+XBn8CBOK8Tf6ApUZsMRDxx4sX6Vl2rBEcRIJ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748657; c=relaxed/simple;
	bh=XZQLhspgaac8EKJt3UtGlkFBkuh8GnfQWYDEl3tEpQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXPIQXRBNPJVLj+c3Iy8iTx2SIZ2GOnLw9eOgNYb29H3p4Da9ObWXlGaUtUi5WkWoAgE08lkt3QhyQOT50h9u9QAZ5frekkv/3v2RUvL5CLRG/+n+ofowdJ1XUtN/AaSAhZqY/I5JZ6N8hNPnG7Oj9rWHlcDZDDKMGajWhp8VD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=AZ7tWp9I; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40eac352733so3570625e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1706748654; x=1707353454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKEA71u3pftlUrSqH7d5VbqQPbuwLLPKZG+NlmyTmv4=;
        b=AZ7tWp9IF6BxUKvoDtO065rWGkHWtcDROozPOPMTokQXUrMHh/dnWDrAosRAhLrSC4
         ss/w4C55GEVbPyuBaaItTpO9mY57UT5/oQwIxPXPF+EDOBdLlypz4DXy1L6B8Cmn0Wv0
         zL3Fy9XpjzyZOTkWhKgFyDhJ2YV43VyOGTFpVj+OiZZoYnSWlguJCxZm0cB/Ezipu+sp
         PLxHadVkQHsF1Kv+NcNYqKLXIzALAE/CjAMt2LSJYc1X4t/2s25BZzst5fZ269pNXXOO
         mD6idPxV8iCDTyTd8ucCdkiZXWb4ima8c16pzRbrdTiZ+k7yrJ44sMULqXvlcpcxQU9L
         muEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706748654; x=1707353454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKEA71u3pftlUrSqH7d5VbqQPbuwLLPKZG+NlmyTmv4=;
        b=ZAzA5SJMem7z7dJw5jPQ4Ib8pKEvdBcC5vSK/9pp/KKLytdFMXqFqbRrxdaiQ7Mt+Z
         B8pjKK3fyuBBfh4zJ0u47OGYEI1FpQGlVEOEioopHKWPdu43JPRiw8uv59cq2K6lNxX8
         h0I9uoera7c0bN6bBDNxm5b3p23XU8xa6Iyedar/nPGI+I8Sln3GDEsJNXai//X4feHK
         PSn7YUSD3eGo1EtZszWNwz5Crjf8/tYpsMX3shkMP2apseXxgxJOhSHgFSvpFtx6y+pi
         Qed8c2XX5KSKmdYxcu8q2M+Qy9zTXMk37qO3AONo85azgqOAjYLo8n3EhqfTk1htKZq6
         EYQg==
X-Gm-Message-State: AOJu0YxA7qyDaT8MqwkaWvYa7PjQbQtvvsfbZRcgrGFYKYM94zDfDs/Q
	8Z5ssyhkmcz89tFdV/nr6GXurSUAGD9FKrz4yrPF0H3o4dHiJLz412W7HXtozA==
X-Google-Smtp-Source: AGHT+IHzTxTmQ+ew/IS1FMUvvzVSB5BlAQzJOagiimmrUHrj61Tr8KS7LRZYVK+JV/WOKKI3Rzc1XQ==
X-Received: by 2002:a05:600c:3515:b0:40f:b0d8:525c with SMTP id h21-20020a05600c351500b0040fb0d8525cmr2465314wmq.24.1706748653894;
        Wed, 31 Jan 2024 16:50:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWqySveUJNoo72PeRCL1XFpn7QU7z4DBramd0U8AF7esiG7rVQa0GU2m5bEgQ2PtalSDbxJQWPSRq51gB/o4rxpSGnG41hphKXyEr60W57DIV9unckgH5sYf//8nBenP8fyq+l8S/twO+gouRmrqABb+zW05x5rI9g0hHPMPtbslURBgc/iV9YxgACqA1fScNeN2LniETqkJDlVpHJMTNKEUl4WeZS0rskB893TDojKb9TskCpZg+AyB1baKvrXT+U6OyEzumPW8NrUgTVxq8e87jM3HHMeT0Q8fDmjxgt0hke/8LiAQwgf4rPMqXvcuUi9RqNNqXVLGHhr0XFYSmsPki/k1SB3OHezbUYI
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c354b00b0040efcd70cc2sm2862183wmq.45.2024.01.31.16.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 16:50:53 -0800 (PST)
Message-ID: <e88d5133-94a9-42e7-af7f-3086a6a3da7c@arista.com>
Date: Thu, 1 Feb 2024 00:50:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] selftests/net: A couple of typos fixes in
 key-management/rst tests
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>,
 Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
 <20240131163630.31309ee0@kernel.org>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20240131163630.31309ee0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/24 00:36, Jakub Kicinski wrote:
> On Tue, 30 Jan 2024 03:51:51 +0000 Dmitry Safonov wrote:
>> Two typo fixes, noticed by Mohammad's review.
>> And a fix for an issue that got uncovered.
> 
> I can confirm that all tests pass now :)
> Thank you!

Thanks Jakub!

Please, let me know if there will be other issues with tcp-ao tests :)

Going to work on tracepoints and some other TCP-AO stuff for net-next.

Thanks,
             Dmitry


