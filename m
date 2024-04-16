Return-Path: <linux-kernel+bounces-147767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5670F8A7963
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11903284CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1F313AA42;
	Tue, 16 Apr 2024 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wje0YfYU"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D013A894
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713311680; cv=none; b=ohUZIeYvAqk0ugry6TAt65fYDbX9hOBUSFPbAy/HwfsSbTJh2/HLyYPAqV7j/P42gsWtoMYkbeSojtqdiWHgmXyVgFO+p6TFzH05Q7PU2PuHn9C3SME7leEYXIu9JTxYYqxqUQTgkITQXN+DZrluVfEyVnqOI1JIYY7DBKp4q9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713311680; c=relaxed/simple;
	bh=hH2IXYyLUNTbEsjK/nJ0ZXdazav3Fl1xtHqJ9wgCBnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgvOlEBA3MrADOw4DIUhZ7uZcEdSi9TSq/vUcLjRV8RR3Cdshr8csbJYRsFwpbFRARSerVOoFY3EW3xZ4NWBPlphnkkMnwMw/o6sKdWP4sW9gN9n5SeI1uxX8mBFVxInO9Ffck50hw/JJKgUUlpakORSWUHru2VkMoK5N67+Z74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wje0YfYU; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5acdbfa7a45so168514eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1713311679; x=1713916479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obsgGE9UFLqDe9yocWfnnIS1vPYUkOPTzraJi5WeXac=;
        b=Wje0YfYUJ1dXILWAc+P/+VzHGajVKGryx66ppM1cstwYXG09rAvCjBNbDq2YqdLZAa
         LTqDhlHo5bI3XAUwy8XB2dyRmQ+2sstJ4c/mrGdJ82sW8Dr8HO1gmGGKuz3nDXi3iGH0
         TYaecR1I9wZzkbbX2TVQqZsd7E7lxaqUSB0yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713311679; x=1713916479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obsgGE9UFLqDe9yocWfnnIS1vPYUkOPTzraJi5WeXac=;
        b=QUE3ZAgtUg59BWecP6aCvKytoQDJXuVfJUv/CPX6Bk0+RWZPH43o5xEzAnShlS+CHK
         YaeZlZOkJ1b7G549RtQdnEiMxfrocd19BS0VYfQyh5mRxP6TTwIZxwAid2uCLe5RjJLD
         drXpl8yHr+QatHl+0P/UHyuRytP4oUYlLOovUj5CEtt9dSg+OBcju39p0b6SkyPfVi5K
         pNt2dVx8gVDXcnCBFIam8dwb/aelXNEyPm0XP1o7ExBixdUxHsUNXlxaYPqCe+I6ndI/
         bAeEzU2KXXQI2igljdpr22HxOGksHcAZBjPL1UcYEVMN4q+ZXn+DYI9E+d73JwI3h5xA
         MvcQ==
X-Gm-Message-State: AOJu0YzFiSiaH/5UFydG+gVs25qT7cZVhK9um95P0KiSP9/yCfRIVOJW
	2RRNEGUGWzvzhfaoKUwBTCKi2y+oEjYjdDN4DlsZyeIP48sqFuN9nh7jrY2q/bI=
X-Google-Smtp-Source: AGHT+IEsQgTwtMYioYHBQ1PcHMqd6YIkQksO6j9NJ5r3RaWWFOGzzSrNerdFgtbO0QrPQRKF/sgE2Q==
X-Received: by 2002:a05:6830:22d6:b0:6ea:367a:f660 with SMTP id q22-20020a05683022d600b006ea367af660mr15557579otc.1.1713311678769;
        Tue, 16 Apr 2024 16:54:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id z20-20020a05683020d400b006eb7b744ad0sm1233916otq.71.2024.04.16.16.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 16:54:38 -0700 (PDT)
Message-ID: <ae01f203-ff71-48f9-b5cc-9497ac6e269f@linuxfoundation.org>
Date: Tue, 16 Apr 2024 17:54:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patch in the kselftest tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240415144358.086d0a74@canb.auug.org.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240415144358.086d0a74@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/24 22:43, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the tip tree as a different commit
> (but the same patch):
> 
>    398d99519758 ("selftests/perf_events: Test FASYNC with watermark wakeups.")
> 
> This is commit
> 
>    e224d1c1fb93 ("selftests/perf_events: Test FASYNC with watermark wakeups")
> 
> in the tip tree.
> 

Dropped the patch from linux-kselftest next.

thanks,
-- Shuah

