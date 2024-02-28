Return-Path: <linux-kernel+bounces-84475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFB886A731
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B55285F40
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96481208B9;
	Wed, 28 Feb 2024 03:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KxZPePBs"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41661208AB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709090818; cv=none; b=JtDN448S9cvv33hJixwPl3tibVHcEt7p6MVkzXaBmAN75wZi1okcp4yGYIxFw/13KJizt5MfmZKxN2n6b2ps8lsETNLwy/Af9E+ARG5/PqHb9AgX5HmrFaYR2w5KKMAChNewAPI3Y89hRygT9EJMcWCIXUwnJfS5aP18jN/SIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709090818; c=relaxed/simple;
	bh=9sgBLMSmPHbQ6S/7FR8Z40PMJ1wgvAaZxVC6zH0FcJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hh+tZqVJQKvBZgsHoywNq0IWdQnbJ7gf+D08aio8JBbsbRB5oFGk5dwJgT7/DwhR88Zpjbq9eUEZ+0WRO00jwUY3vfZ7mBgx6bjaxcOhzWfA2Fe3Da2c14sDl9MeJVuyl/Wjv+ITLEk6Fe6lxfN11RT2QSuDWzCUbZc71Sa22F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KxZPePBs; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e4857d93ebso1516737a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709090816; x=1709695616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qmklizh5oLx0m7Lfl3aZkWW1kWh8OoR2QwqrAY+bquw=;
        b=KxZPePBsUxcSHPb+h0g+RZ1BeQGrHLToD+Hnf1ospGETW9UovXrNDVn6OVHfT0H5Xm
         HxaDFC5JUwk6ouiW86B7r/eEiESuNmPz/u3NtuCe5KrpWUZtdpqcGBv4VxN3KHD01s6s
         E8y31A+axwMZ26DLdxGMcCqbiHcg/tzT4k+Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709090816; x=1709695616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmklizh5oLx0m7Lfl3aZkWW1kWh8OoR2QwqrAY+bquw=;
        b=ZMPtBG5YhN5vUzivxnDJnawmaOWne/DHTBC85u0rpj9MyEC70bT9rn2lzhMdv4skYs
         /y/Hb3EPF6g3oHV7efC7wV4Od6SAo+trjXbekhiB8ud4E9g3Nku1AjTioTO4sh2OPu3G
         ODxoFVI0eLqgW6XixGDRCVXUUhTxJ9qxthmJdBrfndMZSNQr5f4ITZEnEJjq2RxGdzW3
         OdXnqyMoBk2xOqJ70xfWS8z17d5HXzt2cTvTrgF5XvMtjpf5yo0VIZVT+L5mQnL4qSGW
         7915aGvHq/KR0XSkc+Ks3GTdJDp8lj2rT0xN540Dg0wbmqQHVZRA4xwfQ189xZhtWrKs
         Ka1A==
X-Forwarded-Encrypted: i=1; AJvYcCX3kJPUsRUbDdDjwgFF2HqtiAHyF1Xhznk2YR1QDljvbbdTwutUU1y766LlJ45FIYiyLEYrVZ7QxD92sVvJCiQFBRRDBbUlQv7Lw2f/
X-Gm-Message-State: AOJu0YwJB6whLDBhy+dpVwndSsR7Lu5z4FN88nlofofscFmuBo1i+4Mn
	qRkWJoUototWyOhodcFbd/Oq+n4xapGK4kz4ZsqPeob0hML7PlonHEUubeVXaV0=
X-Google-Smtp-Source: AGHT+IGnHFbb1so2f7aoWSa1l04J123hGVtY9lQXTx7D+iBuFHn7258UTIDSgMfZ/We2JkEJbW8AQQ==
X-Received: by 2002:a9d:618a:0:b0:6d9:d582:1970 with SMTP id g10-20020a9d618a000000b006d9d5821970mr11885403otk.2.1709090816345;
        Tue, 27 Feb 2024 19:26:56 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t25-20020a05683014d900b006e49357f639sm1531000otq.77.2024.02.27.19.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 19:26:56 -0800 (PST)
Message-ID: <4eb24c55-6a8b-49bb-a54a-59f00b05b3a0@linuxfoundation.org>
Date: Tue, 27 Feb 2024 20:26:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the kunit-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Brendan Higgins <brendanhiggins@google.com>
Cc: David Gow <davidgow@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240228134818.7b6134dc@canb.auug.org.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240228134818.7b6134dc@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 19:48, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kunit-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 

> Caused by commit
> 
>    e00c5a9fa617 ("kunit: Annotate _MSG assertion variants with gnu printf specifiers")
> 
> Please fix all the current problems before applying a patch to warn
> about them.
> 
> I have used the kunit-next tree from next-20240227 for today.

This is my bad. I should have dropped this patch when I couldn't
apply the patch that fixed the drivers/gpu/drm/tests/drm_buddy_test.c

It is fixed now. I dropped the problem commit

e00c5a9fa617 ("kunit: Annotate _MSG assertion variants with gnu printf specifiers")

thanks,
-- Shuah

