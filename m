Return-Path: <linux-kernel+bounces-119833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2C788CD7C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00D61F653F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987CE13D252;
	Tue, 26 Mar 2024 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WXaoxIQq"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFBC13C804
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482554; cv=none; b=UzhTlmrg2gNgylaLvKdcWrgxdJkh/rzHSp04DdRgEWIAx/J85KkBCYgyb8FpKLTrWAeDBim2bENmY1y1ft2quQJugJKQMuDe/3ZSDsxqsyH8TkHnjgvEboiXJN+EciuB0aReCuJsNLH0AuB0lh8gJF53ijWA1F1zWQOvZftjJUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482554; c=relaxed/simple;
	bh=ckIAyLQl5mq51v12U33D/Ha/ZKgjrWdTuDjM1X+ZMIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXEUoyUCpJPS34PCeAbFkHkksvJeEW9siW8XQew5/psLbU8X6pBpXxDap48JZsZ9TOUhVAnu926yLPYAs5VgaF0aD85v1ySBJ+S4qk35W3/j0OUcOxPR8/YSP/w/cRuhqzyrPnKqXakiK+aYHHmUFZcwY4Bg/b8GdVyEl9iNlfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WXaoxIQq; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c86e6f649aso45285939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711482552; x=1712087352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CiANCJrg/wRMLPS+Tm1vUgemn4LO4mSL7aK+8H//EqY=;
        b=WXaoxIQqaM98i2aCaKG1CXVdG9T66N85m1rd1MIC+bgH4UtyblpZOLcuoRLU5fs2S6
         gErkcytQbU7zfdmIQpomF3Cr4WYps6zspV9u6+QaPwVpeUQkrEk4a5Xi4VOeRHR2XiE5
         Xd5gG8fCYdeNpJl6bKwrwR4sLswTH65TYFKNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711482552; x=1712087352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CiANCJrg/wRMLPS+Tm1vUgemn4LO4mSL7aK+8H//EqY=;
        b=o3y9bZj0EVDNeVJtCpL/F0fj87pAVCNO5xtap/LChGz437tfDpFBSE8LnyoBVEoT92
         g6pNE5hzVP81IhtCdCIR/7+tuuAVUbUG0UpmD+8tTIDphsD74tCr0MBv/Sut7aRY/rtW
         4yOp2jarI0bcZp1oUNt702HgG0rU1DKUYbyle+/ZQp+q17DpSs0CyWC4duNms5uTvyZB
         D13ja/fXprGmEBHPERdd1ZE5xdsHW0zw/ZDnWBR5M9MA3PD9gIlu9IBEUCoQ7yYxWMHD
         BtDBysauEztyXF7nK0MVP0ySEiHvGT/0qCF9hn8TXW9GKas/zrOgWoRK9C78lwsyRNhT
         pM1A==
X-Forwarded-Encrypted: i=1; AJvYcCXj9XWTyGZRqPCQ8S0wIbwDFVvEtqgn0dmmnKfa+15p5Mu5xmggD5PgjkoDQLckP7T6ni1Cd028Ct4koPuFsU6aTNG3EbbIzOSdhAnM
X-Gm-Message-State: AOJu0YyxEAEV6HvE2CPaye/OrnESYvZeAu6Gp7P60LZFXJtFc3O7bIiy
	X0ECJijWySPIIY1YhTplQyaCcrDzRe9BAorr/EHOurxTXZUt2bwpGvaanQTqBCc=
X-Google-Smtp-Source: AGHT+IGa8PwsF4Gc4Jfzc/5pVDeCx6+YWmIQj5bTrUxyJHndqjf4XpTOeOLeEaqgdiSKQz2W7xIYeA==
X-Received: by 2002:a5e:834c:0:b0:7d0:6728:66eb with SMTP id y12-20020a5e834c000000b007d0672866ebmr3473863iom.1.1711482552185;
        Tue, 26 Mar 2024 12:49:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id eq27-20020a0566384e3b00b004772b93a134sm2824161jab.3.2024.03.26.12.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 12:49:11 -0700 (PDT)
Message-ID: <6b0e9e08-62c3-4fed-95d8-185ceb4ce67f@linuxfoundation.org>
Date: Tue, 26 Mar 2024 13:49:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] kselftest/tty: Improve integration with automated
 systems
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Michal Sekletar <msekleta@redhat.com>, linux-serial@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240306-kselftest-tty-tname-v1-0-33505b31629e@kernel.org>
 <2024030633-managing-identical-9b92@gregkh>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2024030633-managing-identical-9b92@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/24 15:51, Greg Kroah-Hartman wrote:
> On Wed, Mar 06, 2024 at 07:21:24PM +0000, Mark Brown wrote:
>> This cleans up the output of the tty_tstamp_update selftest to play a
>> bit more nicely with automated systems parsing the test output.
>>
>> To do this I've also added a new helper ksft_test_result() which takes a
>> KSFT_ code as a report, this is something I've wanted on other occasions
>> but restructured things to avoid needing it.  This time I figured I'd
>> just add it since it keeps coming up.
>>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Thank you. Applied to linux-kselftest next for 6.10-rc1.

thanks,
-- Shuah

