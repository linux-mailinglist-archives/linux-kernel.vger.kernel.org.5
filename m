Return-Path: <linux-kernel+bounces-96208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7417875898
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68470B21B92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2AF1386B8;
	Thu,  7 Mar 2024 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SNT5OhlX"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482022375B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843985; cv=none; b=jIpOkYwrPTBE3Sr8eueaxOYuCAca7zcwHzByzcp4onRcO3ZKtOpKVUR+JCAiPZ0bxKvSVMgyjT9Ay9nNVu7IkNIYvbDLKTQB7EoKystjhk9KPTU/x+lwDF2FIhgrQTAWwJNmBpQG6dZ2BfStWR7XRWB/L+qSCDZMgpnoKP7w1Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843985; c=relaxed/simple;
	bh=dyWm4RjylSQG08muffp92iywOIkbre6IrT/xHyvk9RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF9ZzCFHLQ1mRYIlYUFWj4dWV4hOTjwcP89S2lLD2op/nI2Vl5AXYCP16HIr4kjlPjFHIkPjP1oMhgFIW6+FIO2QTd1Wt2o/54ZnX7z8vTZ8Wn7UFYvqzzI/iqA6OiVW8vUsefGhH3rQ7TNc8cRYJ/z+LP/6F7LjyfsmDRokDgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SNT5OhlX; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1111522a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709843983; x=1710448783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T/awHnWQaWZNIpPPRQmySlAOWVfaQlUuw4o4SLb1zbo=;
        b=SNT5OhlXecu7QSXHuoy1tgm0jJs78nqYX4s/Fo27Y+QIgWiVJxaPb3IzRyLmK88kqp
         sLV0++cJWaUJ584+pW2VHz7Xy2VXXJvOrXotHyZjcxaRYMU0cxUcdur4yFqysFLvLvGO
         gNFTFS6xWOPW3y3s0ljVyoO7MoMnDIKEpxM8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709843983; x=1710448783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/awHnWQaWZNIpPPRQmySlAOWVfaQlUuw4o4SLb1zbo=;
        b=GecGyJEcz+9z0//zGqwWjj9OXL7U0S3xBrAM2lkluRNS3RK9fd2OZ6d8AsGsvqeS7L
         XAGk3RKFq4E+R+8bRrOMWUyRALUWahBTTl4wQ6OfVfGMNRde3pAXtqTXu4UeTvy/9j9N
         939mKhFOnwUot9Ygfxgh0yIRwy/r4+cmv+soMmUn8ZZ2M23EEYXvpF0+8DQH7jmhz3hK
         ObMJbHlvj0S3Po8Zm8WyDmryH48d4C3lyTpX2OJI+TcgMcnjUIA22mo7SeghfjNb3vrr
         hDPrabykNnEQGw+9FPh0zWHCv8ffkeVmR+/ijCe/XI1YeV4sxM6DUQIoDfqgr4rE1vpE
         GI5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAfLhRPmRX9UWQU9+igIdNCk9flilEXpTbK/AMDgKXcy+oAOw3yDQB3RC/e6YFOqJ0wRFB5+LkpTBPNM7CGdrKD/Jb8e8y8L4TacgV
X-Gm-Message-State: AOJu0YyEZ3SaEJUvKnmuwmqE+s++AIeJd41eAGQTcDCCBgI9gqPs6+2+
	iti5QxkCcUlikFkKUQg459tJFWDHWQK/WPtFYA3pBNTNou7lSfIYZdlJL//cZQ==
X-Google-Smtp-Source: AGHT+IG4XsM5EG/S8/upVVaLIDg/Uo9y95SL2R79DqwKGqmn0nsVPOTiFbhmWmBbpL+Owb1XHwrr+g==
X-Received: by 2002:a17:90a:2e02:b0:29a:ac9d:a69d with SMTP id q2-20020a17090a2e0200b0029aac9da69dmr18908999pjd.34.1709843983586;
        Thu, 07 Mar 2024 12:39:43 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v6-20020a17090abb8600b0029b9a0d9bb5sm1249279pjr.2.2024.03.07.12.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 12:39:43 -0800 (PST)
Date: Thu, 7 Mar 2024 12:39:42 -0800
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [Test Failure Report] exec: Test failures in execveat
Message-ID: <202403071238.AC7BD90@keescook>
References: <02c8bf8e-1934-44ab-a886-e065b37366a7@collabora.com>
 <202403051256.7A50FE28E7@keescook>
 <fd210d04-cc98-4e29-a051-bdb7e1367494@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd210d04-cc98-4e29-a051-bdb7e1367494@collabora.com>

On Thu, Mar 07, 2024 at 02:22:27PM +0500, Muhammad Usama Anjum wrote:
> I've tested this patch. Still getting same failures.

Okay, thanks for testing!

What environment are you testing under? It would seem like some unexpected
userspace conditions exist that the test isn't prepared for. (I was able
to reproduce one error with /bin/dash, for example, but not the others,
so something must be different in the set up.)

-Kees

-- 
Kees Cook

