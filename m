Return-Path: <linux-kernel+bounces-134867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBE089B80B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9CA1C215BB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01F525632;
	Mon,  8 Apr 2024 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqC//ln1"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70AE25605
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712559580; cv=none; b=U9DobQjVRIQ0z5kdsJtoiOB7cQEfhXLnJHvmyPsl3Y616StKHKSA8J+zIkB2ic+xg3fTD34WpagrP/t9/F0wcG9vG9aFJdMleCv52CId+vDoDHmDfK+nrMCua8cqvE6QoZdzXK979RdR6xW+hIP55cUjNzl5/SmB2pR1xuv7/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712559580; c=relaxed/simple;
	bh=0QOtzhp5NY9//NCqlyLTz/1a9NR+gne2g/76+IEfCuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRbU7jbfhXmocwcviWRmIpcxtCW7prJF0qr4XXBtFbuiS6kUtSefy7kIzEu6HtUzOPqobj+CWhJDbFuHJpwyRC4r//d3mJwbvSAR1+PNyrbWJAfljTA5oFu7sTw91Dq9hSA9H6DUuvRbQw5RETwnrc4J82/7ty9BDkNWOrjTQVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqC//ln1; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5aa17c29ba0so972390eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 23:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712559578; x=1713164378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCEr2cx5IPfzKP/rtBUBDQh2yuOGjwBce0QBYz6Ak+M=;
        b=FqC//ln11MsCkwPuZVsLUE90bRB32bw8AV2TNmMhQV4PO43G6tW7PmRGUBRJHXauWK
         Pbtf6loUjZRhS7KufY1gJvD6/JpDxWh+9o2a+PBtBJwphlqbWfCTuRoimQt4DWovjBaf
         6FWbWcfgGKJXlDJwCbbihQHubgrqr+tdSkyS0FI+POD9tjmSbmNnbSq/w2xozEE0L2w4
         8yKqzl4jqYAq1RsVrwfD2GGKomCkv4NKi1QUNg0NgEBJ00/Xa3RFx/3RHWPe+T0pi8kW
         bmAAVkz7chqeU880qPaqm3y0QyBqegg9eag5MUX/U4iYJ9Wg5c4b0eg6PfusYuaZwT+V
         Krtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712559578; x=1713164378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCEr2cx5IPfzKP/rtBUBDQh2yuOGjwBce0QBYz6Ak+M=;
        b=JZgQzYW3sBcROGPAkxz3EYQpO9/MkUwxL+FovjbFmu/QVODOIi4Mf7xkqxKDyFc00p
         b40sWe1Gib1G9m+Cok8PTwn0cskcPw96pss2VuITLBGUrRvCFNd3aUYyjEaiJt46tNc9
         JYwCb8IwS3i7SdaAtgGZQeScMjvsyrbhVlSofHmo3nuhPwaD+ukG2JBmT5nTERxABFqK
         ZP7B4Mn5/ljwzsBD7ABQu7GQ9/KSUwThy+xrQMzvBhiKyLbEHV5YngQZGfNBOb/lTxb4
         ejD5Z3lr7ZQC0HhuajVMRKhsmaQDTXswXXbY2rHolLsqTZO/12GbDqeMsaRcAomPnRiU
         Y/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6enx3WBbnOLQR558DCla0mhZaxVEA+9Ota0cUGvMhGOmq6bXtsimRo7IYyotEeryiQK1xdENxbC6jTvjt5VE5FEUUEoPyN/tObmsJ
X-Gm-Message-State: AOJu0YynIYCsbH6WzuVeKrrvnwItqBsMkr6PPhV8cOD0dQ73E6v0Xqy/
	kLMxvrH6ciPtUFRecGbh2iCBOKO2OlInUnwdcBRy+LUkOuDggA3t
X-Google-Smtp-Source: AGHT+IEx5PJ2yKYCCaHumABbUwVRXbvIjUiw247eiLO7BZ0sJHD3NPMUXlH9q9Ji+FaIKIlDg0wtKQ==
X-Received: by 2002:a05:6359:428d:b0:186:f3f:324c with SMTP id kp13-20020a056359428d00b001860f3f324cmr5578512rwb.0.1712559577714;
        Sun, 07 Apr 2024 23:59:37 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id p20-20020a63f454000000b005f3d54c0a57sm5825754pgk.49.2024.04.07.23.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:59:37 -0700 (PDT)
Message-ID: <527e1ca6-9dda-4286-b51b-09184afd26ff@gmail.com>
Date: Mon, 8 Apr 2024 14:59:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/14] mm/ksm: remove get_ksm_page and related info
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Matthew Wilcox <willy@infradead.org>, Andrea Arcangeli
 <aarcange@redhat.com>, Izik Eidus <izik.eidus@ravellosystems.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ryncsn@gmail.com
Cc: Hugh Dickins <hughd@google.com>, Chris Wright <chrisw@sous-sol.org>
References: <20240325124904.398913-1-alexs@kernel.org>
 <20240325124904.398913-12-alexs@kernel.org>
 <15080b4f-ac9f-4f5f-9a27-d1773d015fdc@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <15080b4f-ac9f-4f5f-9a27-d1773d015fdc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/5/24 5:06 PM, David Hildenbrand wrote:
> On 25.03.24 13:48, alexs@kernel.org wrote:
>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>
>> Now since all caller are changed to ksm_get_folio, let's sync up the
>> related usages with ksm_get_folio, and remove get_ksm_page.
>>
>> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
>> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Chris Wright <chrisw@sous-sol.org>
>> ---
> 
> Move that after current #12, and then simply squash current 8,9,10,12

Looks a bit large, but will squash them. Thanks!

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

