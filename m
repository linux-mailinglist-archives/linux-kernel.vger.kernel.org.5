Return-Path: <linux-kernel+bounces-165934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FEB8B9396
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6181F222A2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A94F18E28;
	Thu,  2 May 2024 03:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l2BrBpXw"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024D14292
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714619375; cv=none; b=Y9kI8yq3KHZpZeC/pxlFc7VUDl2PsNuW5va+HQJboTiw0tZ5micu1gdTpVAdj5K6/ra7Lu2WKe8xY4ZsVMSd59WGaq1lim0TjDmN/3r8gwOCbnHYy64T+n8LKatLTzt5DRKf+04J4EgO+WIMXqvMmVbB/NCwc5OHL9n7yuJ6wT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714619375; c=relaxed/simple;
	bh=ObnqFPVJOTz/epn03UheMK7LRvxMU5jZn7hFT/Hpy60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvnqI6rn/8BrHWIwPYdLA8N1VfVLmXrOQVykdS2HlM2juoJujVUyR7zyVAMo6xPUc9BdYsBrdDMgTzWuoyiTyIHy3LqWfDdbPRXsoiqzS5z9APw8GUpW4491p4PtEcUYyDqPolsYwAbbguWH1Mh8uMWjB7PV6Ph+XmBZq5KTDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l2BrBpXw; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ee3a7cb9f1so2029611a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 20:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714619373; x=1715224173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EKgwrwTMRQLSvRu8Y+P7h6K1IEMLBlHp60PU8wkB+Tc=;
        b=l2BrBpXw99T0OxKVhwO4ObGOYxbOMQTp/p/8kX2aFnb3TBH+1OAebl3jhB/K6tkrqS
         JKH3YuHNX4Y9g9LeRcXRZ77UvyGg2A+FazA+ruEyJBxZhdMT7B89/yAHsoa9UwAhT4BJ
         FE3cZWFeqitKje5HfKBqRxmW9FEmmvyMWa2Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714619373; x=1715224173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKgwrwTMRQLSvRu8Y+P7h6K1IEMLBlHp60PU8wkB+Tc=;
        b=ldC5RozU5/Ag+6vSS4lgvjOvAbCFJDGVbpRoI6TvmXlFIVLqDp0v/LHFZDGqVeSq4b
         ORF8lDCIkHGdw6lxqPvMdMqV8gmOOCr6VtXffcCkEFWVCh05d2dIKXduvGt9G/jwpAw+
         r7wAghbGtyTaxJm2g2QRKWhFx/VsHS0H/MEk53IRmHcMCH6qA+DZaYg6s+RqKvhkRtyH
         X7jOEDH9DwijaN0GnHwEAD5UvWD2TFDakK61zMOcHONO1Kz/YGZIXQNt+JSmUiHzRuYk
         rGfQSB7d4YIf94bsodXEni/Wcl7iK1ZZe8ulLw8a9A5Nu1Q2YkxrBsnu4sjn/P9Wc/a2
         emvw==
X-Forwarded-Encrypted: i=1; AJvYcCX3OI7/ayZpjUrBSEa9UaQF9j6XX2q7F5vuiqBjaeS+vKdrSdZPZp/Ao/AQcHwdlO4FwUt2ZN1f79hjx6klTQYl/yNULGG8465C82ho
X-Gm-Message-State: AOJu0YzuaXU1a/CW+GGH4POSDcv4I9WGe60qxN8tFSVJBGVVS1EVEJQi
	9B6cSZsR5FH7aEv1QZSNOtrmoEPgDL+6yuEr5zkWzKfNdu/hiLQJ2UsQHMIDeY/6fvdl2TeYm48
	=
X-Google-Smtp-Source: AGHT+IF6cchS2nf9nvU4tH6sibgafgLKaNFYJ0b+TDZI9sKzN9Y5depOzEmZDH9tk2s/8AQg1mmTyQ==
X-Received: by 2002:a05:6871:d283:b0:22e:b736:7c18 with SMTP id pl3-20020a056871d28300b0022eb7367c18mr1224381oac.27.1714619373630;
        Wed, 01 May 2024 20:09:33 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u33-20020a634721000000b0060ec09873fbsm102002pga.7.2024.05.01.20.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 20:09:32 -0700 (PDT)
Date: Wed, 1 May 2024 20:09:31 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: rtlwifi: Remove unused structs and avoid
 multiple -Wfamnae warnings
Message-ID: <202405012008.38A5EB34F@keescook>
References: <ZjLFIa31BGPVCGh1@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjLFIa31BGPVCGh1@neat>

On Wed, May 01, 2024 at 04:41:37PM -0600, Gustavo A. R. Silva wrote:
> Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> So, remove unused structs and fix the following
> -Wflex-array-member-not-at-end warnings:

Heh. Yes! Very effective. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

