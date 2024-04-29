Return-Path: <linux-kernel+bounces-162727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 612948B5FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004FF1F25752
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E908626D;
	Mon, 29 Apr 2024 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="frNC7ypk"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3892B84E1A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410650; cv=none; b=hrtHrOrjMOwHLkRU7fA/awRzxwDWETDYFH+eTPRp+zJqNAV5oOQ8S7zyiXgWMpuOKGCeEqqJd3V8tlhXdMrX44FDH4dW6+L6bMnzT5VYhTHm2h1dlgrw0gRw5+nYV3Fg5nld728Vuuxf6MfAlbPDPAiZRsKwgPab3gXNGwGXUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410650; c=relaxed/simple;
	bh=0jNTl45Cs7ezsUWeAWbPmvCWgF+22Evr0a+0tU6atao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4uFtuO9eC/EtjeNm9hEbg3/OcOfp2CICu/Ue7rCCwVeLAwpoycq44lJ5PIIw56/LEmCtNZaZDWaPEzzKNu8rrsc1pmsZTAOsNfRZoTtxjsI6uy1VlPwo+NxVtqsl497+5LcDJyVGk3GJ1tsxJh3gE446UH6AYADQBsiByxoGmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=frNC7ypk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b07f6b38daso2082764a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714410647; x=1715015447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZRgSAbzG7KcvdiTauEibDNnc/WC+ObXBWTvwKd5YyQ=;
        b=frNC7ypk1oXy4cYOUkEh1xrUZaaHRoAmacK25JOYs6LaD2a0j0PVUxBhwPNtoo+kz0
         fNI89O/2zo91YhFv3vITF6WmgBZiQLg535I5N3VbhJjbTa+ZInayKi2hMpVb9Nku4A9W
         aCk06kZU1kUVBczu5Uddf++oFugHe8ZPo8JlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410647; x=1715015447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZRgSAbzG7KcvdiTauEibDNnc/WC+ObXBWTvwKd5YyQ=;
        b=OqP6BBheXuvxewecwHVxfa3SU+aX7wqQua3Tb2MFJPMeCuqNAeqQ0ZS/Pw9eJIPyEP
         /lJyj47vC/ThMriPkrst2c7+iPvEOi6AhY3ng4d//Gmh3Xbj2fvcg+wCvFVoiFulE8uY
         LEFmACyOYK1PHOwDEYG1YJUPYyPyqIXdcTk8VwyEZEg52ZhkEA22lF8HVNu2QQsZg0Bz
         VMpxc00Gv5BmLSLpjaMefy08mUzpaT2hTICYWfrJUIuq6sqmOEu/7pmrR/85gXDDLM6O
         pEPW+V4G2kxcrWL7OAFS+UF6wBdsN6G9PBwMOmwvPBF036ragUpNi9uRl6qRZ0WSmDhS
         ZsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnZA3bf8pg5NJs59zuYCnieJ4hDzKI/G2NUPtBAI2yFEo4FO2xIaNHQEUYbI4XSSdcv2GfUWka/euTjQLg4yqRaScB1sCsXsxPPaQZ
X-Gm-Message-State: AOJu0YxhZkR7MziOeuUVCtMnsQGW19VyL2eD7AVgDA8ih07/Px8n0yOO
	BZSVmS8FIDuVQZJfSoJXKoSKgpfvWA8D8SuYMOfXb2dW/RfGI+e/TRtx42HpgA==
X-Google-Smtp-Source: AGHT+IGj3Lb7QLmCDgTM2Q+YDthSN8UMWEbIVz5Z0H2XtkJT6q8gWsIvscYSHoZhP1Lgml101nzTDA==
X-Received: by 2002:a17:90b:270d:b0:2a2:6244:32b5 with SMTP id px13-20020a17090b270d00b002a2624432b5mr368408pjb.11.1714410647531;
        Mon, 29 Apr 2024 10:10:47 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090a668e00b002a6e67e197dsm19363447pjj.45.2024.04.29.10.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:10:46 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:10:46 -0700
From: Kees Cook <keescook@chromium.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] wifi: wil6210: wmi: Use __counted_by() in
 struct wmi_set_link_monitor_cmd and avoid -Wfamnae warning
Message-ID: <202404291008.51DB333F@keescook>
References: <ZgSTCmdP+omePvWg@neat>
 <171222554691.1806092.8730005090791383928.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171222554691.1806092.8730005090791383928.kvalo@kernel.org>

On Thu, Apr 04, 2024 at 10:12:28AM +0000, Kalle Valo wrote:
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
> > Prepare for the coming implementation by GCC and Clang of the
> > __counted_by attribute. Flexible array members annotated with
> > __counted_by can have their accesses bounds-checked at run-time
> > via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> > (for strcpy/memcpy-family functions).
> > 
> > Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> > getting ready to enable it globally.
> > 
> > So, use the `DEFINE_FLEX()` helper for an on-stack definition of
> > a flexible structure where the size of the flexible-array member
> > is known at compile-time, and refactor the rest of the code,
> > accordingly.
> > 
> > So, with these changes, fix the following warning:
> > drivers/net/wireless/ath/wil6210/wmi.c:4018:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > 
> > Link: https://github.com/KSPP/linux/issues/202
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Patch applied to ath-next branch of ath.git, thanks.
> 
> cbb0697e0ded wifi: wil6210: wmi: Use __counted_by() in struct wmi_set_link_monitor_cmd and avoid -Wfamnae warning

Hi,

I was just walking through our patch tracker and noticed that I don't
see this patch include in -next yet (as of next-20240429). Is there a
flush of the ath-next queue planned soon? Or did I miss some change?

Thanks!

-Kees

-- 
Kees Cook

