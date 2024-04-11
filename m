Return-Path: <linux-kernel+bounces-141580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF18A2047
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0018D1C214F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B41C292;
	Thu, 11 Apr 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bTjlyc0+"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD7B524C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867684; cv=none; b=WWqWnPzt8Cz4A4oa//nUD2Mg5LonLdDgoM1sRPe+xiTkaSCeeELw82Unk+7z2CzRctGDVFZPrRDMylXQutvOfak2jy0HAHN9K4vV4REbcPhIq8xuHnr3wu8xJV6G4jxUea7xr8tecpCMKDXE/8AIMKxerjGFCwnbAGiLW5UioPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867684; c=relaxed/simple;
	bh=pvL1Zd6rBjAA4vL2Y6BHYHDyyPCV5v1Mwu3xdblacAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+Ax++7QC97Yqky1n6Wl/C5BcSwGorvdKcmcri7c5lCG5Oq9SWx2C1x1iYtGiMr24kZTT4LghGScyiPNmcWClprPBgHhECp2zmjPrUssi9ftFMF2URx0334Z5p5BhMdAcYIgecayK8JdPzca94YuvpmK5kzZTtnInOfKEI9fNiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bTjlyc0+; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d67d1073easo4287439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712867681; x=1713472481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFQrioCTLKkhRptmdIkcvOHp0QHA+wFxGV+r5aMx7Jc=;
        b=bTjlyc0+HwIIU3VomJCm/sp5XJCC1sMADa5lN7A5qtvEbwPtYvg+8o1tHea8RYsHQ2
         R47nBePXMNAhTBkL7MWvgucXNCUGUuPerMQJV5i90gkpaiaN3fh911nT8JwpJZsPWIqc
         BZDjmHrEYIwDzMors5j0dljGB4K8MbrjLhy02eQEmKae9derjbntvhClh3pFq+YdtrnT
         nRu+Dw/fe/uTkC19oM8kNai/jo3x/UuKvkeJqlNeEBq+mn15q4H7v8bWoSZu0/9Nq/GG
         gUeEdvNkC4OTWTHY6p+We5mHpJ37IgVMDa1pmluxBJ9wcAJe8wKSHCCDqF+Yt45+UXcB
         tghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712867681; x=1713472481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFQrioCTLKkhRptmdIkcvOHp0QHA+wFxGV+r5aMx7Jc=;
        b=pJjbs6ovh95c9RJWmThUaBsaS8INMQqMsFDCxGUveLrHa66oryluM/jjU9fx2GxSmI
         EV8AEitWYyDseonfkHpWqswUP34cclFZxI8UYzhEYKqhTDwsYrexnyfgsLf0DNXQECAc
         mHVRZbdxnHTYqbM99guXCVW8lvxg+2bwd0z++c11Dkz7cFNBfGcJCsMKceBxAN7SksB6
         WQPqRjN74NgmADDv+Gnyq7HiNcdyoCOBWGqtEWBDKt7jAVqf+wLSMjUpGlEoYAGcJevT
         5rXf9eVq+zz+V7nZ0MOsJbwZNryHApl+/hqP+xpm+hgdDttO1zNsbjiDeho9aQpPd6q3
         2uaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZASnitwUxMla79JyW0gBTfbdeIR90BjSXG9gW9xcE/PXmbpNA97Bi4HzV4UmgipMM8jTRkuYVn/k7QFXjCi13dgBOF37jFJaMn/ZZ
X-Gm-Message-State: AOJu0YxXEol4Cakpbwir46XLTbOaDO1dnE+7uM9rc0/59fHLLMF/TFvR
	hEZ+jcT5QVgzI3jmiA7OFBvpJSzm/8zAlQM3xG+wjs9LIx8nqkA4hyZT+gJnKyBzz5m04zB2ZUp
	9
X-Google-Smtp-Source: AGHT+IH2/BSQLLGqgAq5/+W7YHGk2rJZKu3FRGNYECp9/GB8j1FiT0Mhj+rId81twI/jAAZAKwpqwg==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr980356iof.0.1712867681396;
        Thu, 11 Apr 2024 13:34:41 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u20-20020a056638135400b00482ba6c8fe7sm602849jad.116.2024.04.11.13.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 13:34:40 -0700 (PDT)
Message-ID: <2378b252-678c-44a2-9303-a0450a4cea4c@kernel.dk>
Date: Thu, 11 Apr 2024 14:34:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit e57bf9cda9cd ("timerfd: convert to ->read_iter()") breaks
 booting on debian stable (bookworm, 12.5)
Content-Language: en-US
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
References: <fa36ba8c12e0243c717ba33d3fec29cf9f107556.camel@web.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <fa36ba8c12e0243c717ba33d3fec29cf9f107556.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/24 2:31 PM, Bert Karwatzki wrote:
> Since linux-next-20240411 the booting process on debian stable hangs during the
> init messages. I bisected this to commit e57bf9cda9cd, and reverting this commit
> in linux-next-20240411 fixes the issue. I'm running debian stable (amd64) on an
> MSI Alpha 15 laptop with 64G ram and the following hardware:

Thanks, this is known:

https://lore.kernel.org/linux-fsdevel/20240409152438.77960-1-axboe@kernel.dk/T/#m07fe27b781a2e558ee6d260e317b79e72f401321

and the current trees have the right commit. Tomorrow's linux-next should
be fine again, sorry about that.

-- 
Jens Axboe



