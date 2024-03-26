Return-Path: <linux-kernel+bounces-119779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D2388CCE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD86B1F83305
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9998713CC67;
	Tue, 26 Mar 2024 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SFKwvYbt"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AEE13CC65
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480630; cv=none; b=rIYIeK91h83+wV2WpkHmQrg1Gpg22ojH/FjP5bDsoB15/vkfEvMfY58/j6q7ilBHpD8SOiuwhcxtTT2pWj1/W76YIvzaf4Nt9hS1u4/EMwFaqkkbDxdiXszyjoiedsytagT7ucEL0U07mbblh1Lw1Bk7C+vVFHoSF3D2wF87Rp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480630; c=relaxed/simple;
	bh=d5oiFHuXdlxBu9o91T6TmgxwTU7ItEYzvBVBFxokMdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1+MVxhvhehu9xHt5+e7vacRDs94/eqB+L9tpH+gEvgpAfheDROOlKDhVZ4fe4M2z8x/tCiLOZPzyhshvpG226c4Gh2XlEU8g2ohF24PCB76wupa9R7khsAEAgCPqtkAgw+Fzavkya++GzGh9NBrdVoJUzpo+8ycgIWe+Ou4M4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SFKwvYbt; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3688dcc5055so419975ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711480627; x=1712085427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aAgAdxoAWBggRCLmNhHzURpQUXyex1VS2og6I0eJHg4=;
        b=SFKwvYbtiHIg9dmQJc36AJa97p5dNiJUIsXe5/J5phY0QkI7AJnz8O3z5wd+tvllSi
         N32lGwd03I0cGdX+rcHl5v8303HpKd3q6eNfB8cYd9S5FMEesU9Gz//SnBjj8fGgsn+g
         5gkU+fqUlbk2BUeZ1kqbkW1AfNjWyqIqfUFno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480627; x=1712085427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAgAdxoAWBggRCLmNhHzURpQUXyex1VS2og6I0eJHg4=;
        b=e1L0oncVbazWEh0y5YZEo2KiZnZRr6RL5YBddEz9ak5Mz1tukTmq8WoWTYFOObHH7o
         T/4b3xj5zIlF9V4iytqScCcZJ9JJnvtDZJXaO8eM3EId1oOTgCWXA85efq1P0R+P4MSw
         4/367CxDsDVLkrlH5jC6s1sR624eZ1L+gDwa+Nd7oHg0KbO/K3Q5Q8z5CFnyAwexDoVt
         4iXM8nscXydNy2jIetmgS8vmF3ZIm2r+yFyXVjlB19FKjdAJ/LFpZJJLG6R2Cofxnw5M
         tUoP3zVlBhzR2FAktnP2XEsSZmFlUO20WsaENZuNSitsHHfuKDZIT1tRGqiZ+T+cC0yU
         Draw==
X-Gm-Message-State: AOJu0Yx8yHDIwIJ/GJAyHBVQQaEqMWZ7lT6zrGiihJa+RWRhjEyj5g9L
	vK5SNHNS3TdagrLcLK7p4nvRFAVBqmGCUXxA/dn3jt/2ccJijgWyUo0txMcKsgo=
X-Google-Smtp-Source: AGHT+IERj3hrIyDnCZJ5UcMAXz2os4t+ojmXAKvLHG/6knoGZCHVaoWkXymnVBqCdt4RsIW8XSrQPw==
X-Received: by 2002:a92:c9c6:0:b0:368:80b8:36fa with SMTP id k6-20020a92c9c6000000b0036880b836famr8573443ilq.2.1711480627401;
        Tue, 26 Mar 2024 12:17:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m18-20020a92c532000000b00368984422e1sm927267ili.23.2024.03.26.12.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 12:17:07 -0700 (PDT)
Message-ID: <0cee99af-f058-47a0-9119-94cc9a37e88b@linuxfoundation.org>
Date: Tue, 26 Mar 2024 13:17:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kselftest/clone3: Make test names for set_tid test
 stable
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325-kselftest-clone3-set-tid-v3-1-6fdd91506e53@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240325-kselftest-clone3-set-tid-v3-1-6fdd91506e53@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 08:29, Mark Brown wrote:
> The test results reported for the clone3_set_tid tests interact poorly with
> automation for running kselftest since the reported test names include TIDs
> dynamically allocated at runtime. A lot of automation for running kselftest
> will compare runs by looking at the test name to identify if the same test
> is being run so changing names make it look like the testsuite has been
> updated to include new tests. This makes the results display less clearly
> and breaks cases like bisection.
> 
> Address this by providing a brief description of the tests and logging that
> along with the stable parameters for the test currently logged. The TIDs
> are already logged separately in existing logging except for the final test
> which has a new log message added. We also tweak the formatting of the
> logging of expected/actual values for clarity.
> 
> There are still issues with the logging of skipped tests (many are simply
> not logged at all when skipped and all are logged with different names) but
> these are less disruptive since the skips are all based on not being run as
> root, a condition likely to be stable for a given test system.
> 
> Acked-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v3:
> - Rebase onto v6.9-rc1.
> - This is the second release I've posted this for with no changes or
>    review comments.
> - Link to v2: https://lore.kernel.org/r/20240122-kselftest-clone3-set-tid-v2-1-72af5d7dbae8@kernel.org
> 

Thank you for patience. Applied now to linux-kselftest fixes for
next rc.

thanks,
-- Shuah


