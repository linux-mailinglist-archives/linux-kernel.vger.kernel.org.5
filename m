Return-Path: <linux-kernel+bounces-30392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA78831E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E41A1C21055
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED19A2C844;
	Thu, 18 Jan 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="E91rWm+Y"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C423F2C842
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597471; cv=none; b=KcCg1x83krIrijjrXXSTKRWQGqanD9JNDa/oAnleQOoszeWSQib2d7DE8JODHyTzsn/l45sHrNb8dTvOrv2Q8EjteWxlGNyD57TGB7VU03BA+/a0H6E+vYST3hOoLDcXbDIRDhlyKdpnCc0NxEiIcjN+K2+4gRIGWIvmToWFdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597471; c=relaxed/simple;
	bh=g/rRRWlnTFqnEs2SFfwruUS/ClIg0NzA+8JMI1zfBgU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=nRzILxMmJeThWA3IEFCPzWfsmXXfn+O8N0Iy2jlXp+vcIC1t+rjYpMKNq1Ihg1T/KmZ21QRsdnMKxWzZUpRt9DSQouvh6fLbP9cjrrCVRGzIGw4k3vwAuF3rBB+V1Hvl4H1a5yXxYxTfa6+3OJxFL2Sxmz2wU8p1XAD5qiP74Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=E91rWm+Y; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-337b8da1f49so2748604f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1705597468; x=1706202268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Spf2iYyM2yyAQqYpbtyryjRjyyX6h/O61i58Cf5ljuM=;
        b=E91rWm+YSP/bcx6/NlUa7zuWBMkAjpAEWdGYFu6Af5yqV4m8rAIxry8YlglUil0uxx
         MYo39f/7mQwFeRZOpN+tMq/4ncpUN3RbaahUCesR/7OvHi/5QGMoPoXNngCCbDFJGaos
         XvkteUP4JQVjtbJFZ3FlaYimXL4Xr/27Ue5PVvJuowQnmumggxdgelzgEPOYGCHUPQUJ
         mMzu3C3o4cmCzORgMvTn9/4U+1ZsF3aj2x0Z5ifkE2eaZoFKWpIzAwyt6e8jmrm1Bxfb
         eCULs6JOovXx/w5nDJyGMoAq0WBid3G/keE0ZyKfd4URbwdTNG/Olvz1zEe6B7cC9Fsv
         gmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705597468; x=1706202268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Spf2iYyM2yyAQqYpbtyryjRjyyX6h/O61i58Cf5ljuM=;
        b=src8ED+2o3NLt+nmBHz+mBNCmwamrH3DiqKFBzNry5WD2ZyfGrpJLvGeRgKfA2UWci
         pbOZCXwQ5g+X5k3z43r51KMIkEFPImTIRso2c61KYd8sk1s2B5FX5p1LzY4jTlSSyVRK
         CKV5UVaJgwiDjCVKS/FcyA3YM3E8ifZvafrbOPXL/f9bwH0C3WeVhcR+LnjnDkG8rR+a
         5xpG1H54EaYZ/1wVKgr5bw0Nmu5f8szZvO+ZBi+hvdErkUUOwrmVKzDGcXknlYOYrUzV
         ZSICqMbl2cUhxZrgo6FgCo8mCW1AWKlUjLT3UFo4I+uf4gKzrWAKdSXVeDSlzUp1b3+z
         XmEg==
X-Gm-Message-State: AOJu0Yy8k6VoXnDkscp/3JyYjPqfBUSTgv+CAHLldQ1RANs3COB5txBD
	xy/DirRj50ikVy4Ms9THGjFkxcQcvXyLHtqtTjQ3reYsj1RQPsodJ83bbrEczA==
X-Google-Smtp-Source: AGHT+IH3FQC5AzBxXr/WrOnNom9+bRpYrvzb1p86jgCnhI7ov37Cf1NcCipvj61hKcTHgrF3bHv7XA==
X-Received: by 2002:a05:6000:18a:b0:337:b057:c1d4 with SMTP id p10-20020a056000018a00b00337b057c1d4mr474170wrx.215.1705597468020;
        Thu, 18 Jan 2024 09:04:28 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id q9-20020adff789000000b00337d6aa3912sm1021082wrp.10.2024.01.18.09.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 09:04:27 -0800 (PST)
Message-ID: <358faa27-3ea3-4e63-a76f-7b5deeed756d@arista.com>
Date: Thu, 18 Jan 2024 17:04:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] selftests/net: A couple of typos fixes in
 key-management test
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>,
 Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
 <20240118085129.6313054b@kernel.org>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20240118085129.6313054b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 16:51, Jakub Kicinski wrote:
> On Thu, 18 Jan 2024 02:51:33 +0000 Dmitry Safonov wrote:
>> Two typo fixes, noticed by Mohammad's review.
>> And a fix for an issue that got uncovered.
> 
> Somewhat unrelated to these fixes but related to the tcp_ao selftests
> in general - could you please also add a config file so that it's
> easy to build a minimal kernel for running the tests?
> 
> Something like:
> 
>   make defconfig
>   make kvm_guest.config
>   make tools/testing/selftests/net/tcp_ao/config

Yep, sounds good to me.
I'll take as a base tools/testing/selftests/net/config and add any
needed config options on the top.

> should give us a suitable config. Differently put it'd be great to have
> a config we can pass to vmtest or virtme-ng and run the tests.

Will check that it works with them.

Thanks,
             Dmitry


