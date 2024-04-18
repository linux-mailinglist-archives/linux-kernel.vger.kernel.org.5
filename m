Return-Path: <linux-kernel+bounces-150139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9AC8A9AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07D1B2144C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB840145B34;
	Thu, 18 Apr 2024 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0+BqKj5"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1484D02;
	Thu, 18 Apr 2024 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445904; cv=none; b=ADHOBQS5N22tjmzYgc7tgVhwypVU+TIY6qO2sryd2hH3nyjKRwzltyl1LuFSACI0Nmpns2VEhd5NzFpP+tUuFuF5t0UFAIT9nFsQkd6B/5Yv/nuM5oYmBi+f3ZVs7UhXrupor5nXluQqeN4Fm2Iw0aV12BxHDzcvQQ3r78I92r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445904; c=relaxed/simple;
	bh=iiylYS4xkEyE6BY66mqdSi98AxDK5kma6xVkGJlBkms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpwfv2GTa/4JsB7O2bb9q75XAmpEHFzQ5sNvWMHDWuA1dRKKiDU25oC2E58X4EKY0f92aq5OfqLb4aBkDW5fdUKzw4wHqSsAdMUPTp11sDyLd2zCRcM8RgL4xYvKTVndC49nyAhUswHECYeqUf9ohz3Ia0d1wEUDZn27zMP/sWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0+BqKj5; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5e152c757a5so452660a12.2;
        Thu, 18 Apr 2024 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713445902; x=1714050702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aH1ycRnJl2DyuElBHXYZMGKIwlTzwH1Z6KsoIshfpnA=;
        b=O0+BqKj5VkMj/XAh3m0iOEYa9novjrDrhbRu1D8Ml+tMT2xY3vaQdcNv98us7Fltir
         pRLXRy8fIAef2xfBexNObz9Y+PdC3r5jFx7IyBoCzc61GalwfdG6A9yb+qvCwRk1Yl8H
         72XaRRvOBswHm/ZAYCVToveGQnUd/j5iomOskD2nvTBYxNbEs1CTSt+/Sgj/tPH+rrPR
         h9aXZ1i43PdI4apidhPl5hSm9o4lmg7fz5amS+Eew0X3xSNWI4G+2+zes8sJfz0BTn01
         pUqsyxrbafZK6Hi5m/hapxSa0GThcoVP4y0hLdZlt48srAdU8SRX8Rje9P8hdf6svtCR
         ALMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713445902; x=1714050702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aH1ycRnJl2DyuElBHXYZMGKIwlTzwH1Z6KsoIshfpnA=;
        b=l6KLBG8CmbvM4DD3ELBDyircpu38H3G41qzrCZDbzf76zPwkwpeMTOcesDRBS3Q3bt
         6e1SJQUuPdmJmnZN2pDQccwHw8H7M6IGfN4Mhdn9YXEI3MtyDkPKNqPrKoYRWZJFDln0
         Uyqn7x65E3dCkmAs4So+IH1DYVk7zZ3WIbAlpy1aLYidLYXhhnect3OpZ6zwkJpfPhGV
         kUkLo1OqoOUdVaD2jsVX8J4dkniQ8E+iPoy8Ddk7V1mldd/J84QWyBfy0gCT0S6pdbB3
         tDuowcxHJVvu9Lzwzxw9nduNvS1FSu8tmQjGS+wTRgJoCtY4inqzs6VmNo8369ieWgAC
         VcEg==
X-Forwarded-Encrypted: i=1; AJvYcCW5AV1TEAyTUf8fKlcNomYEfd1K++XAZMAUDG9gGO0ek43BUocCkIrYvLPLjAnOuMtC6UtB/8WfdWHElQvZyQ76II/FsMcvkEAMwskTBIn32HEWyT1RgNgSkkzq9HHIS2a/SL2tEs+2
X-Gm-Message-State: AOJu0YxoW5dSalHN348D3d56vDuQPhtQB4rnQNa+INdSDEpXJz8LWmG3
	htD3yfZBNrbQp5SRRjIrlj6nExsvNlt2OyOnk09xC01DAvk9J+Xf
X-Google-Smtp-Source: AGHT+IFG8A/2coA6M18Zs50JxM6PmNtZz6/L011Cn6c44On2bnIqw6pQ2h/cRl19O7jH+XxcXAhqdQ==
X-Received: by 2002:a05:6a20:2445:b0:1a7:7358:f108 with SMTP id t5-20020a056a20244500b001a77358f108mr3705675pzc.24.1713445902033;
        Thu, 18 Apr 2024 06:11:42 -0700 (PDT)
Received: from [192.168.0.107] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id g21-20020a63e615000000b005f75f325db4sm1379307pgh.29.2024.04.18.06.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 06:11:41 -0700 (PDT)
Message-ID: <6ee54e25-a9a6-4cb2-a2cc-92570ab7ace5@gmail.com>
Date: Thu, 18 Apr 2024 20:11:35 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: workqueue: Inline WQ_* flag pattern
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Naohiro.Aota@wdc.com, frederic@kernel.org, jiangshanlai@gmail.com,
 kent.overstreet@linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
 tj@kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <20240418072100.30670-2-bagasdotme@gmail.com>
 <6875fb17-f781-4594-803a-c11969f36022@gmail.com>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <6875fb17-f781-4594-803a-c11969f36022@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/24 15:23, Akira Yokosawa wrote:
> [+Cc: Jon]
> 
> On Thu, 18 Apr 2024 14:21:01 +0700, Bagas Sanjaya wrote:
>> - * For detailed information on %WQ_* flags, please refer to
>> + * For detailed information on ``WQ_*`` flags, please refer to
>>   * Documentation/core-api/workqueue.rst.
>>   *
>>   * RETURNS:
> 
> In my opinion, reST-specific clutters like these should be avoided in
> kernel-doc comments as far as possible.
> 
> Instead, I think you can educate kernel-doc (script) so that "*" is
> allowed in the %CONSTANT pattern, meaning %WQ_* can be converted
> to ``WQ_*`` in reST.
> 
> For similar changes made against the @param pattern, see commits
> 69fc23efc7e5 ("kernel-doc: Add unary operator * to $type_param_ref")
> and 8aaf297a0dd6 ("docs: scripts: kernel-doc: accept bitwise negation
> like ~@var").
> 

Thanks for the idea!

-- 
An old man doll... just what I always wanted! - Clara


