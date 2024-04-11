Return-Path: <linux-kernel+bounces-141613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5FA8A20B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E13F1C2285E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EA4335DB;
	Thu, 11 Apr 2024 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z71l2dp4"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096F112E6C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869929; cv=none; b=HDumMT/V85JBOoKe8l/NZ6DAQwq7chHH++vaKbc6SaBxBCB0WIyBVpQ/fGmjVALM0tXgIN+AMPL7ZIp8QJHE1+KJnSD4bFTlPEl8+oUA6katBQ886VUmKKd34OoC+LuFtW11bL+UMJ4FgatoB6H1pCFMKPIPtoMy0Y1wZe9L+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869929; c=relaxed/simple;
	bh=oZ8v4ePupLUg5etGiqmx+FUpnfb/FSvL2oIBZ3dpBF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFZNUENG9qcS5VALncQbEBirSUDkTIIrZ6JTiDV9t9ZexUbU7DnghtIAeQUBslSst5Ktaha6ymWzqitTIS5mAkL5swjWlTeU79+wHR72OH4wK0aox+nz4f8HziSae2Tbgxwib18kWSP5HhCiISvE96g1eXsQPrkR57rrqflXwU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z71l2dp4; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d67d1073easo4906439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712869926; x=1713474726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5pYTo5GXTImg/khPgJCEyjaHMOI7shV0+j3Qu01jLxQ=;
        b=Z71l2dp4zBg50YT78pSktQuj+BIpC7oQRpK4pXcc00gjGGLss4phYREA5p7h2g+Bkm
         yeeveCMZ94FT9oIQneSFjSnmjgUpRdHgv8aC+Mz0B0vnAkBY9oQlO+kwQ0aRr/sfwefV
         hbUtTAHNN8G8w2QeHmLIKL43X8xw2MJni4ZS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869926; x=1713474726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pYTo5GXTImg/khPgJCEyjaHMOI7shV0+j3Qu01jLxQ=;
        b=xCoP/DjUjCDXMKKq58hoeIogTA2FRdziTQo2+RvKRsAe+BQy6ALZGAm2HYDshj0+tz
         69Y6PTpXsxdX/75UiYR7rh0ANtufFDZ2j+GTDABy4jJDwFmcFDJwfmg323K/hRk8w7ZZ
         ISMns8whS3Hx4NgkVPxeqURf08p4jkHiLaH+Swt6m61yi1oKSeplyO30RwWb0OOmtPuM
         7UnezJd0sriuMAFyixrrhW+XJ/PPxIRkM7Bdglh/VgoeHkc8cXblDQpOIg2QY6QE09eW
         dtDb7whsSnV5ZkwADJvwebyQp6FNxGbJPUJdrYalLFJ8uaMKCD752YFaO//pwNWTNXo8
         2B9A==
X-Gm-Message-State: AOJu0Yx3yp+V98qW6Q7x8FKax5Xav+QRVPPqxo7PzlsZQtMBbNpTsaGE
	KVmB7kRKnfK5tQhVW33OjfR2KBSY8m4XfbOfrDoudM0c8iCpc+HM1VD9OPC5MjA=
X-Google-Smtp-Source: AGHT+IGlRvKJzo56yTLwyjOFSWmLeGDpwy6jNHfGtSQrurgovx+V4MNpJI/2H+yHyG38tJbXWUo9yw==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr1190271iop.1.1712869926226;
        Thu, 11 Apr 2024 14:12:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bt3-20020a056638430300b0047ee01746f1sm615787jab.120.2024.04.11.14.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 14:12:05 -0700 (PDT)
Message-ID: <394f886d-ac00-4ad2-9bfa-b77db7bc5998@linuxfoundation.org>
Date: Thu, 11 Apr 2024 15:12:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests: timers: Fix posix_timers ksft_print_msg
 warning
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>,
 kernel-team@android.com, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240410232637.4135564-1-jstultz@google.com>
 <001f99f4-9463-451d-ac16-0cda91e37e67@linuxfoundation.org>
 <CANDhNCoXW2=1nGXYyck6e-CztCjDpC15_qwNk_+dOc8PvB-b4A@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANDhNCoXW2=1nGXYyck6e-CztCjDpC15_qwNk_+dOc8PvB-b4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/24 14:53, John Stultz wrote:
> On Thu, Apr 11, 2024 at 1:45 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 4/10/24 17:26, John Stultz wrote:
>>> After commit 6d029c25b71f ("selftests/timers/posix_timers:
>>
>> Tried to apply this for linux-kselftest next with Nathan's patch.
>> I can't find this commit in Linux 6.9-rc3? Is this is timers
>> tree?
> 
> Yes, it in tip/timers/urgent.
> 


Thank you. Assuming this is going through tip/timers/urgent

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


