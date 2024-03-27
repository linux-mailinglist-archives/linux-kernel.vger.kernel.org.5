Return-Path: <linux-kernel+bounces-121895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA7088EF08
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5B81F36653
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6CE152525;
	Wed, 27 Mar 2024 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8oGhhGj"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492814F138
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566810; cv=none; b=eJ+tgPtJDMeyiYV2JXuFVJikqZxtmoxl2hADmp8/Z5JOOT2pjZmFPN9+d5EbZd8QGKKRc212N0nFFTFxpeozGMVNxmSlqjzIoY9Z0SQQ65sRAkFEKjeR+LnX+rTKcFL5OFlw2fm7FfWojNZEagHEr/TW/rlYamalLWDoWox81ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566810; c=relaxed/simple;
	bh=AOr5jmDe+7IUVT1JcnkAgfe0iSFoQ6Rm98g8VbVUXJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdKAuVtHu26WQQLlqVmv+gYBG0hYO76eE70PWdx5is4HzC7JAXrTpTckBndr7/52/d9+nAUThZCfd5axNcGLRpVOt7iukXCnCQlvv67RC7c30Psa2+4cqF8+IYPMxXpHogpMseWknFDWChpcu8vykKRhiNHaL5ZABHALR9Cg1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8oGhhGj; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbc649c275so127089b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711566808; x=1712171608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApXXhv3UWIeELY0teQK//GdogJ+SWaFmwt8VGFJJU9o=;
        b=C8oGhhGjJBdeVKj7vjYitprnS0LVnbuxfegUk8FqR36G//GU6qAPZCz7rUnSIRj62a
         j1ay/OvFNqJTqUyX6IMmA8GWzdJJFZDzK27tBDrJXrGXlt30SF2GhqS/2G+DZ5iP3i/3
         9JiSmTbWv6o0xcVRaQgLAnYkHh9XMMBywsclkDaHxMQFfTfnbAse6eGWPWIJNrRLXRQ2
         nE3H3JBEhBoloT68iAYtmk34+VkkaSbfljwEjXzesGZl9OrWVB3kXGXmKLzSvTcIQAGF
         6XgyfBqUGNG2T1DZv5udpUzucVzzS3KBh6HOJ6YeQ0GwhTIZg6MOIYpGiK2J17PqVJRk
         eQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566808; x=1712171608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApXXhv3UWIeELY0teQK//GdogJ+SWaFmwt8VGFJJU9o=;
        b=kX37bEY+Cqo8u4F2gL9AR6L+B4dsu90599J/c6pTlpv9kro/L/tjtSlQEmY3uJ9akO
         ekg+Bu0OyZmna0o7GPukinHv3z+iSE1yOniLpuhXaewZI6EhK6uSSvSchTY4LJos/9dG
         wuBEickYllhKfUctXw69stu03ezz/BhLVexUqaeVofOtnjboV+PFL2bwIh65oIPSZ0kr
         Jym/C/tNkZoO/et24nQV8rewRgzXfgnFzKDDrYxuK/OQw2crf2I+7mV5mrVENfndKw4N
         +nV+l5NtLbqv/TBCrcfr4Y7jiYbYp62vMwk/hql7Hd5ZxbEdcmIIazcULPv6RLyGJBg+
         c5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5WLpp8jJhkgwer4NpgWtJ2r15imlj4mUOS8Ci+IvV7lYzJoCGL7G/tck0q4wrpo/cVA4NZQUoq0afCJVHds3sZupMmgR+pt0BuC1u
X-Gm-Message-State: AOJu0YxJqPg7IRU/BjHzTk05GGpqV5ElEoChBbqV34HbQbVBHH1hS7Ew
	sAtL3rtNHjn5wFQbrUgoiLYxnp5BGMskZCnnQIRagBoNNA+c8RpP
X-Google-Smtp-Source: AGHT+IF+UlL5cdcNCyTgQlp270nnJnrfc5qgK3T7ZwYqc54hifRqCipV//l+Fc1hXqndAT6VS1TCGw==
X-Received: by 2002:a05:6808:8fc:b0:3c3:d48e:ca9a with SMTP id d28-20020a05680808fc00b003c3d48eca9amr761410oic.51.1711566807948;
        Wed, 27 Mar 2024 12:13:27 -0700 (PDT)
Received: from ?IPV6:2a06:c701:736b:f200:f38a:32d3:e6f6:959? ([2a06:c701:736b:f200:f38a:32d3:e6f6:959])
        by smtp.gmail.com with ESMTPSA id gd14-20020a05622a5c0e00b0042f21fe66f7sm5071744qtb.73.2024.03.27.12.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 12:13:27 -0700 (PDT)
Message-ID: <c5c3fe31-2c68-4eec-9f4a-0c0bc8428461@gmail.com>
Date: Wed, 27 Mar 2024 21:13:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] staging: pi433: Fix includes, comments & macros.
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, elder@linaro.org, robh@kernel.org,
 parthiban.veerasooran@microchip.com, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240327063156.96307-1-ikobh7@gmail.com>
 <ZgQavKRkO0gt6Qdt@smile.fi.intel.com>
Content-Language: en-US
From: Shahar Avidar <ikobh7@gmail.com>
In-Reply-To: <ZgQavKRkO0gt6Qdt@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/03/2024 15:10, Andy Shevchenko wrote:
> It's your responsibility to carry on the given tags for unchanged patches.
> I believe I gave a tag to two out of three patches.

Sure.
Thank you again for your time.
V3 was just sent with the reviewed-by tag.

-- 
Regards,

Shahar


