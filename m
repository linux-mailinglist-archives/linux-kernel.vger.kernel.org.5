Return-Path: <linux-kernel+bounces-43381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124C68412F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DD3287E79
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDC8179AB;
	Mon, 29 Jan 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eurxFM7V"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C414AAA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554917; cv=none; b=KU0kL6k5qA3rBqplOG4La2dX1UsHoHyXJi6eHfi6tUrmBNOD2/jlotnc4mIwEeubCkmmM5SkAL/g72hqkBylJpt4RH5xHr9U5pRqjKnxxyAtd7/9L8Vwm6qp4MGMrbn7Et85tp30untCfDiBuihBFWsz7P8DsJUHLktYC+3zxj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554917; c=relaxed/simple;
	bh=rXwL8ZgyJFSpC9k+Ab0i+1OiFs1s/8BDF4WGUL9Hg6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1KxrgDxPBwPwmO37JoF9a/brIAMrIr36qdtLw+uN5IbO6u2xFbnwthhL71kpzAjplpFABfMoKgCJ57kA2jt76LPqMs0od4JbZ5pKpu84q+A7vn4xTl+LTa1oM0GJIiDfTQvxtTBQAA8i7dLUXHLfEahkK+qWoUJT4R1IKGcUYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eurxFM7V; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso41513639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1706554915; x=1707159715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jSJF+OOAXf610xBVp3jRjdPIYKqNvKf0pGO5qcf0N64=;
        b=eurxFM7VnQTBJ8zpsfhmcGS/aQtMga5QJZ8+lTwOelHJVP8klRaNvcY7IOSFAcauw1
         w+d0rbXi2qIFker9Eurtzh/9PnG79zH+T02ytq5AQLlJ4GYIxK54g1WuE1Zog2amVhQG
         nBTnPVPxCxTMYThDPWevHrGdTKC4ykFnkX2dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706554915; x=1707159715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSJF+OOAXf610xBVp3jRjdPIYKqNvKf0pGO5qcf0N64=;
        b=wpNKqyzBufe9gf7Jg1QYTKXwViM+jeFOeF+6CoYWmAUIkmHTzM6oK5KQ8774+POQWM
         sHCoPcfVqYVD8eqtQFDMRzBUKqCUEAaYdCHWCtLXwDgOp1r79cFGcKFqlkstzz/JNR8p
         MgMldaQQyBW1rPa/wmwZ7l0NVkZNqnJiAqUlB8AFsOf2vDzcMH2A1xOSdJUybNM8GiWO
         KO+GjpZJfu8Ksz6AL9sNyRkQeKmjNRUeGFHPYF3aTf0JnjE92SJ+lWk4Lv5OV/Wp5GwC
         UmxEe/BGtfAPM/5a+1csSdfHuO++e+oe9yvMoq5JBzQMX754ohIR1MW9Q7LccAQy9hFn
         pK/w==
X-Gm-Message-State: AOJu0YwUGFviLUn/873Nv9B9OkyDSb6sDlRgXZ7tA9zaYYWaWGr68K8h
	pz7e0YSGi0hAHsm0bCIOo75Wyy946ZVew78CjHD5h4+nMyrSiIHDDrrFWXRNRM8=
X-Google-Smtp-Source: AGHT+IHO4inrLZ+LmjpobsSd6xvDcDGhMatpnyJ1hPtxg7GuwS+LDjEPtsGiqtzMaR6hLvhp4a7WQA==
X-Received: by 2002:a5e:8e0b:0:b0:7bf:dba0:7f78 with SMTP id a11-20020a5e8e0b000000b007bfdba07f78mr6571295ion.0.1706554914874;
        Mon, 29 Jan 2024 11:01:54 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id f35-20020a0284a6000000b0046f1caefc72sm1949458jai.114.2024.01.29.11.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 11:01:54 -0800 (PST)
Message-ID: <c29848d6-29ca-4338-bbdc-abdc71cdd5f4@linuxfoundation.org>
Date: Mon, 29 Jan 2024 12:01:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the kselftest-fixes tree with the
 mm-hotfixes tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>, Shuah Khan <shuah@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Hu.Yadi" <hu.yadi@h3c.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240129085301.5458880a@canb.auug.org.au>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240129085301.5458880a@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/28/24 14:53, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kselftest-fixes tree got a conflict in:
> 
>    tools/testing/selftests/core/close_range_test.c
> 
> between commit:
> 
>    27a593e3f13a ("selftests: core: include linux/close_range.h for CLOSE_RANGE_* macros")
> 
> from the mm-hotfixes-unstable branch of the mm-hotfixes tree and commit:
> 
>    b5a8a6de69bc ("selftests/core: Fix build issue with CLOSE_RANGE_UNSHARE")
> 
> from the kselftest-fixes tree.
> 
> I fixed it up (basically the same patch, I used the former which kept
> the blank line) and can carry the fix as necessary. This is now fixed
> as far as linux-next is concerned, but any non trivial conflicts should
> be mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.
> 

Thank you Stephen.

Andrew, would you like me to drop this commit? I was planning to send
pull request with this in later on today, but if you prefer, I can
drop this commit and the send the PR.

thanks,
-- Shuah

