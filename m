Return-Path: <linux-kernel+bounces-123474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE5089092A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BD51F2ABA8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB9B137925;
	Thu, 28 Mar 2024 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AxsHOXrN"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982595FBA7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653904; cv=none; b=mzH4duK8LokNic5VM+rWgWPYtFDfZ12CpDk0d0o8uFXiqZl3SYsMi6ULSledAWK7Nhxdzlc5DujQzccZ45/ruzbHmIAi2awVKW0Ug41s2+c1enW6AhT8GV+adfVZVR2X+hgBL01O7Fvlf/vmr9/IB35kP2Of9osqfak/uCjWKaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653904; c=relaxed/simple;
	bh=hBWOhLsL9Ye63hqwNmxZ7yS9NmFDcm9/Bynf03sExEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjDwAqv5SelUwZSCBJK93sKDuUiRdFCDws/5stTm/GqxjXwkToUnNQz1Qoo/4SG6Dz5rHyihg/VNtVWKiEcuqA2KWmtVTnh+kJBc/RedEFQfTxglH6xE/K4lWpRF6zGX2PAdLXKH28m3uvM2fi3jVSm53zWTYTFfcUY85th3z9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AxsHOXrN; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso12287539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711653901; x=1712258701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqfP/Sm/AvXF18rY9yxd2mEaaANtVKOU3PQdF/crOyM=;
        b=AxsHOXrN8eXJtyRLq2WYHrAAXYnnhKX1yzGNBM/sSZx93uwR1OpEDN2gAXjsll+c+3
         NuObr1aX/eVjAaI1/nTAJHyEKQAz1QA0Haq63J8QM2zInIPjPoB4FJc3X4nVFCrakZaT
         IlVubZLwsVb5S5nzALUOTh94c5sOYVJP0K8sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711653901; x=1712258701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqfP/Sm/AvXF18rY9yxd2mEaaANtVKOU3PQdF/crOyM=;
        b=emNr04ExAZV2CoEDQt8jhRvi7Q/MGvT7c4W0h2NEWvO6rI+xe82ytheUgyZEw/xGy3
         XlFEpCWClaEQBSrvYkpcKa1K1xjoXZ60eMzQ/nqs+fswYr8hFORB9SRIccKKkN2cGPyf
         m7d1qV2E2Pr7Xmtjh1SnVtZPqobW9DjBX+T/seVRgwq1F7CmCCMcKDI06jw3+eHfhafX
         iQKnDw1ZcdcncAcXxxLRiH65FTM7w/Gex4hoPKZSoj7dKN33gnLlb4cL8Uijl4eklXMx
         B7HKzzvMdZy9M6vDGZrS2EWtbiUHvdkUPKMgbZWFIEfC7OsNuXd8EfGGRhT6/hPmFzXf
         QWuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt4yz57AhjlGa8RixGGT+qUQW+nM/y9Bh8T3zLVtDtzDDVBGdD8xY7NbctfozVgEso8GC3ZqHdn+yKqfJkCRRax6vmDNOFU0CNgi5G
X-Gm-Message-State: AOJu0YzIYVYah8XgIwInvrCD2j8ivyD6FUDfFOTw5Vw1q5gXkvZ6QtFh
	t8AFW/6nLKuKubitWp29AgFAGpWXfIzfYF2h9lSOZwgXhVUbKlXLzWtIhVqm+PY=
X-Google-Smtp-Source: AGHT+IGtTTIf7AXmbvzvLto51rLUJUqYbsjFWVf0UyhyBamPjBVqlk4ueoMBV1jcCsOgdB203HW7fw==
X-Received: by 2002:a05:6602:5c7:b0:7d0:4d5a:51da with SMTP id w7-20020a05660205c700b007d04d5a51damr99957iox.2.1711653901688;
        Thu, 28 Mar 2024 12:25:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id f8-20020a056638168800b0047bedc27024sm515749jat.144.2024.03.28.12.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 12:25:01 -0700 (PDT)
Message-ID: <b5ad9249-8775-40fa-b770-810afdcfb8f7@linuxfoundation.org>
Date: Thu, 28 Mar 2024 13:25:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] selftests/resctrl: Simplify test cleanup functions
To: Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, "Yu, Fenghua" <fenghua.yu@intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1709018050.git.maciej.wieczor-retman@intel.com>
 <ac887a4a-5647-468a-9696-4a3909e42561@intel.com>
 <f7a81e14-7fb9-45bc-9885-383ab7a2e708@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f7a81e14-7fb9-45bc-9885-383ab7a2e708@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 17:08, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 2/27/2024 8:36 AM, Reinette Chatre wrote:
>> Hi Shuah,
>>
>> Could you please consider this series for inclusion? I do admit that
>> there has been a lot of resctrl selftest work recently. This should be
>> it for a while as new work is still being worked on.
>>

No worries about the number of patches. Thank you for the cleanups
and fixes.

Looks like there another series in the works :)

  selftests/resctrl: resctrl_val() related cleanups & improvements

>> Thank you very much.
>>
>> Reinette
> 
> I think we missed the cutoff for the previous merge window. Could you
> please consider this series for inclusion in preparation for
> the next merge window?
> 

Applied to linux-kselftest next for 6.10-rc1.

thanks,
-- Shuah

