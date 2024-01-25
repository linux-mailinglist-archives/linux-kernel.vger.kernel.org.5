Return-Path: <linux-kernel+bounces-39397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE5283D05E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DBD291B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1D412B8C;
	Thu, 25 Jan 2024 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sc1LdxnK"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E7912B82
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 23:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224176; cv=none; b=QviY57uMBMF7QBfBpBtMBwM4fq4R/r/5Q+XmumyhVs7zi0LLfxBU1JrjMeV/Dlhiw03FrwWDY4YlqeGG80sA8PJe2bPB9VZvhGxVMd5YwSH01P+30+liEK+Y2W+Ey3OjN5/Qi0wQFdvL12HbGZ2q7zDgdUa/Hd4E3QCdbw9Ttig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224176; c=relaxed/simple;
	bh=ePte//PcvI+POPvm5pOf9eY2yfLLJls6I8UsfkKqq8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPytuPU/dVVjB888gdRe3G5BamtY8ZP0cjHO017s96QhoJBrOpc6gMiIWq4WR/IKlNi/jCeCYPbfAG1iiIBnU45I0IlCu6rg5OMZxoviwWlGaJeOyBNgSI0wb/PmY9gkOUpZjmoxKFo69HIhzh7VwVZUFp98rtAyH3Ez4AlhWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Sc1LdxnK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ddc1b30458so198247b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706224173; x=1706828973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NNidztSseW3f6ox0VaVwn+MmYmXjLmRwN6RuC1S6ZnI=;
        b=Sc1LdxnKDEn2FUa7jyeJmOK2uxPNAJtUNZ/lP0ZinbliSf5uNrZrpDjZYKSn6ia5z/
         uJ5bsNh51b3g6TcZpf5adCBpke/Fe/rX1kCUfmIBlcuNgtyxQ13JjKyzGbI/CqVgxhj4
         zRJmXZxPyfE5KbS9d6cuxhcFaQBnjBhcoET08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706224173; x=1706828973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNidztSseW3f6ox0VaVwn+MmYmXjLmRwN6RuC1S6ZnI=;
        b=GI6UvFQR1f/ltkv1qKqdhTmBmmAzns1SjRidEtWq5pogloub7n4GJ3OHnL9jZggIYH
         CEZSS1fEWTfWCashwZSs6DZPG6oUZ55HocXb+xrh8wXh7zE2+RmxsdA04duHvVeIn7J2
         9TnN5XbzxdSXHvBzadvvazsVNY4JC9kEnD8ZM4c7L3TfkPow9z7bMLeDuVzbsNmaYCMF
         3/Cjhn8OJ5Mo5V8Bn0cKZTO7ngFAZsMW1umDrCw7ZpfyS9QYGckJCcX7VCOzDp/FQt/j
         2osHLX2vohj37rl7FjqsgPIeXIs9xgjWGD2deMT3OB5AceoEaHkAHKBokz2cssUtUgzl
         u+eQ==
X-Gm-Message-State: AOJu0YxjbrvSOhJNxXd5UGR7KWo9FNTaAcfooTkknB0Ky++0CKfyYPkv
	VxIPHfnx8Me77ZzuXICppQX1NEK9nSqMnXdXocT5IqAF7b9U56DXPxcXGCU79Q==
X-Google-Smtp-Source: AGHT+IH4wMIY5onoDuNtmQW2qW/oiyEguJjb8r1Cdunh6LBtNU0O2EKFQ/LepjR7KIf8EtqHsgZMQA==
X-Received: by 2002:a05:6a20:1616:b0:19b:5cf9:45ac with SMTP id l22-20020a056a20161600b0019b5cf945acmr452465pzj.81.1706224173278;
        Thu, 25 Jan 2024 15:09:33 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m66-20020a633f45000000b005cdfb0a11e1sm27205pga.88.2024.01.25.15.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 15:09:32 -0800 (PST)
Date: Thu, 25 Jan 2024 15:09:20 -0800
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: akpm@linux-foundation.org, masahiroy@kernel.org, nicolas@fjasle.eu,
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 09/11] fortify: Drop Clang version check for 12.0.1 or
 newer
Message-ID: <202401251509.70789B5D@keescook>
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
 <20240125-bump-min-llvm-ver-to-13-0-1-v1-9-f5ff9bda41c5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125-bump-min-llvm-ver-to-13-0-1-v1-9-f5ff9bda41c5@kernel.org>

On Thu, Jan 25, 2024 at 03:55:15PM -0700, Nathan Chancellor wrote:
> Now that the minimum supported version of LLVM for building the kernel
> has been bumped to 13.0.1, this condition is always true, as the build
> will fail during the configuration stage for older LLVM versions. Remove
> it.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

