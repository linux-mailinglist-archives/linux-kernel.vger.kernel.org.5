Return-Path: <linux-kernel+bounces-119950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C4088CF51
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422C1340B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644FB13D60B;
	Tue, 26 Mar 2024 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PQ8q0PNr"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61212126F15
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485968; cv=none; b=B0fSY1+FWD5ZrocjJUiK5JDNBRDz/Fe32OAFoWC6ZiBX3aXokUcBZLnTSbF9x+HOCtKtoB6hucEvyPcxgdjx2y2vIShrMqTV9aRZFuSnshmoIcM5zyh5mdVcQX9bphYyV0dCcZhVWwKIsWa1GNdGhJUOGnlw3VjEOKQl7m4RZeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485968; c=relaxed/simple;
	bh=uEDRqCJhhsVJuG1lHyDzprVktcDpniqReLT6wXFu5VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqSfPnFlOSt8Y4Kb9ussEylKxr13Ge1OJixFr+BbyHH/Ju80MdcLeEhCtVw6aNDEZOVZeLYAA9nDDYAXcrQakmtvg/Sh2Q1f4qITvEady/ROkY7i6CPJDd5TH0nN9sKlOT/QPZ2H/v27qHMVGk3sJGVIrXet+N0uBxqIm8I9ags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PQ8q0PNr; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso35681539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711485963; x=1712090763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJxbjA701dwsdP2q2KPyD0sBjpjzuhiGe9ACSutvT/g=;
        b=PQ8q0PNrl10WPs9Ih0bUQJpFi/hUKbVwCdPK/gWb//ISl++RbF6ddE0edQJmODaYjh
         4O10XNOjPai9pPfDk/c7xqgTW/FkI5j81FV4RdTuF+CI/245D8BZXk0BTWJ3Ntw5uBIs
         05gNNf0AfLBU6WxBwjGpkn+y7uwU2wXdf/Ti4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485963; x=1712090763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJxbjA701dwsdP2q2KPyD0sBjpjzuhiGe9ACSutvT/g=;
        b=pL4FTaeUdEiUPBNTyXz0ePEHRKWTh+2Br4jpT93PAhygctqyt5WJGttOAXJltO8GtO
         G2C4wk8MWYLm1KYp2zZHbsIJ7vNQbNeOdCsEGXJ57ERla5LDKHcVdQIkGhpVYLi1K2mM
         6O/nPWsLqAIiuLm5iVoIvQbyvWbx7r2XR0mSB8hojN73yLilEzlYBh5JHRdYIza9N6+3
         KN10MvO25o9JMz5k72JFxCM4F3zFT/zQ8Hk2/3R0iQNjhiKPRFsITj5I78pmCddx2+3W
         75k7Mz01CVUUtWc0PWVUAFy3yuo4WNSjiM1KK2peualtIIykZraAhMbphmjsERqy4UTS
         0O4w==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0UzJkUO8mUtIm/k1dZkt18wsT2Kjkqx2BN/pb4DCKUFpIiLLxoIeq4tlM8qOskNpfWzoUn3CNSp/92j8YftrGWwcmN05d2WlDJtr
X-Gm-Message-State: AOJu0YxtFEP5RHcqVVopLBURBAT7BZFTT77xxuSwynXPuKUk4IjvSEgI
	g3xuFB9xyLW8WJbqGHJjEq/uU/Frztcedmv7CwHYss8gTfmxbfL7T+M3rB5gBxM=
X-Google-Smtp-Source: AGHT+IFnLbenFAcC5hMRhgWI6w1Lf3ppFDQZj2WhN2OHomt36Dv64FHl5a4Au0OxgKw4A7fv4kfWNA==
X-Received: by 2002:a05:6e02:1fea:b0:368:a043:4a26 with SMTP id dt10-20020a056e021fea00b00368a0434a26mr3689428ilb.3.1711485963436;
        Tue, 26 Mar 2024 13:46:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id z9-20020a92bf09000000b003687fba7541sm2287115ilh.79.2024.03.26.13.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:46:03 -0700 (PDT)
Message-ID: <fa109cff-5326-4f94-aa3b-d83827d5f968@linuxfoundation.org>
Date: Tue, 26 Mar 2024 14:46:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/exec: execveat: Improve debug reporting
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Kees Cook <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>
Cc: Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240313185606.work.073-kees@kernel.org>
 <1dd87e89-2306-4669-844f-ffe9e56523b6@collabora.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <1dd87e89-2306-4669-844f-ffe9e56523b6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 02:54, Muhammad Usama Anjum wrote:
> On 3/13/24 11:56 PM, Kees Cook wrote:
>> Children processes were reporting their status, duplicating the
>> parent's. Remove that, and add some additional details about the test
>> execution.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kselftest@vger.kernel.org
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 

Applied to linux-kselftest fixes for the next rc.

thanks,
-- Shuah


