Return-Path: <linux-kernel+bounces-168107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 944048BB3C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DDD1C238FB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA481581FD;
	Fri,  3 May 2024 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FqSlnwW0"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868AF154C19
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763579; cv=none; b=CKsxUbui5cXhgSovBzevSRp5xuU32q48TzSAiIFnLUiSbVSc6b84KC76TeryjX0w47/BlJkjycYxYt8Ae9Z3iQDwfJKVv+oTtqCy2kPAkDgJI8W1pn/yllhKM0Obnhude/B+oniLRd9B2DKkzO9ZTMcwvIrOx1MWkDipuApFcIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763579; c=relaxed/simple;
	bh=IKLI/Q78RF9vVx/YNe7wLdlLEK7x6bEXRB/vPUdT3wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkHk8O+tpGnsjXbEDGnhu8Q7X8PH9KoKVBXcmZpGc5dY+fChNUX28XwFIp8MKOFoSGMT0PPu5XFAtweuwqEly1gmLs9MXneTlx3nzyBer5y82tgw+q97vgMuyZa6jhOb+hkTfENnKHKalDO7v1KHGOTSK3fOEInA8Yo92kzNwzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FqSlnwW0; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d9c78d1087so62148739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714763577; x=1715368377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRFjxSyK4Qq5KgEaM3tSc2tgl3ftVperAuW9pNscAzY=;
        b=FqSlnwW0XPXoF59LD+Sgdo5WKNnTnvh3nx7Hirad8Vwmjb9gkuBEYSHDeimXi8zpNb
         Uhf4Nms/vy+JgftFkQzelYUkvbx3IP0cqmVeTuIHLkd5oMY6kc8tSJfE12xn5/gU39cc
         QM4d7a2NXO7zlYBJzCBDnqjhXs65Yif01xrSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714763577; x=1715368377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRFjxSyK4Qq5KgEaM3tSc2tgl3ftVperAuW9pNscAzY=;
        b=bCibS+hVAipOkUuFyigJ+2zX32GdqcIz8b3KyCeEepIw8Dtoaue82eEFD6U6WUA3m0
         XoN16hjCC1aNAS5by7ukA8j6+c7u4BxCx+G3Q2Q6LGBIQgpeJeMeH0clm8jIgeG017d/
         xUlR/AtnqP7TlWBWz3Yp2YK+U1R215Moz8lVtQp0ag8Pv5K0Z91FPxWy4YIwN9i2GB4I
         1L0QbmTh5TvsZMlZomSh1xeg0oaI/Upmso95+FscmCzrG65Ss6Oy3VnjUy7kcKDyAsYB
         Zq4hJR8g/xAd/b2aEtEMq4T/PnIDdTCQOX5Q6Rtrc5NsXWWQZNIVNsE0nixnu9MNLizm
         jCRw==
X-Forwarded-Encrypted: i=1; AJvYcCUg8OYldh6FIS/5aIKg+Kc1t/0TcLr1LTSCW+MMXKJk9CM+uupXmBpn5WAFTO14t5LDa5korUMygzoSRXuZVhKy1P7o32k1c+W3rNYp
X-Gm-Message-State: AOJu0Ywn6RUzcb6fNUX10bYN3nPks4aFzXWjT5UCyNPyfvEMzKYlx0Ez
	2X1VhS7zETK2Rl0LuqxBVQHz4P9hicnq/9SLZXx5OqKfJ8HGcBBEyOM4Mt35MGQ=
X-Google-Smtp-Source: AGHT+IFeCr1sXlKuk6y/+HaEO2vkq/lW4xsCt4vEoT13BLeE623tRhqnA0qvoG5XspHJUW7YimhDEg==
X-Received: by 2002:a5d:860e:0:b0:7d9:eeb8:ddeb with SMTP id f14-20020a5d860e000000b007d9eeb8ddebmr3581267iol.2.1714763577683;
        Fri, 03 May 2024 12:12:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g6-20020a056602150600b007deeb2d7c4csm786391iow.12.2024.05.03.12.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 12:12:57 -0700 (PDT)
Message-ID: <5bdb08a2-0740-4ea0-be24-a948332d60ac@linuxfoundation.org>
Date: Fri, 3 May 2024 13:12:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 5/5] ring-buffer/selftest: Add ring-buffer mapping
 test
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com,
 rdunlap@infradead.org, rppt@kernel.org, david@redhat.com,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430111354.637356-1-vdonnefort@google.com>
 <20240430111354.637356-6-vdonnefort@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430111354.637356-6-vdonnefort@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 05:13, Vincent Donnefort wrote:
> This test maps a ring-buffer and validate the meta-page after reset and
> after emitting few events.
> 

Changelog needs to be imperative - refer to the following:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Update the change log and describe what the test does and include
test output.

If the test requires root privileges - make sure add a check to skip
when a normal use runs the test.

The rest looks good.

thanks,
-- Shuah

