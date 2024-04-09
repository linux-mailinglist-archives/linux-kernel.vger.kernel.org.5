Return-Path: <linux-kernel+bounces-137719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C35F89E657
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC6FB22CEA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E0E158DDA;
	Tue,  9 Apr 2024 23:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zcbj2GTY"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD2158DAA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706403; cv=none; b=kPc8hb6FzQqp8Kgd84hV7GIdN7lUWJVhWpcQpOlhgbSLO2NH5pzIneQ7sgLCbY+UdIOHtBM9jbkqHDpIPcBeUTzSXbgjMpBJuB+HR/DFguBjSMFsGWCNGFR4Eer9Zwbs25L1VG9YM/LsC3QqMmEHu6niIActUs4Swxao/X848Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706403; c=relaxed/simple;
	bh=jNSBzWXhZJZfc+eIqIw5Gr2uSmaIhh7uL5umKj2kPfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQDBC1IS4NUG51XMQf9e39agMGQ2qFmjvZHwbIjeiZuiKMR7Y/hZQuAsH7jezma4oWbFOmCWC5EagC7pFM4vxD4dS6VW7YHaivN68pvMxCqhbc3lndvWNwNUB/qZWQ7YXbsrUqtmv6C2NOsPxfSUTcfV7/DCV+5/luxXbJDxBso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zcbj2GTY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e3e56c9d2cso29275205ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712706401; x=1713311201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAaMW4DkptdB8vkfU6X0XRhtKwrtwp59dGPucd4k3xk=;
        b=Zcbj2GTYCWEyQONPzz/ca0ax9BEJU1j4H7WYHwfusA7b5HiFO9dim32PdP+GMBk5J6
         F4KNg1gEmgOZRBdhrZiOpTA/FgmX9lllGLX6bKUFLv51je9iNs1Hkp3EDgAu5cE57ilu
         YnFG7kKgqjPXzUn7HT/Iye17drfYtVGU1m2p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712706401; x=1713311201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAaMW4DkptdB8vkfU6X0XRhtKwrtwp59dGPucd4k3xk=;
        b=iPl5mz3E83/EoYKjtCfcxY8ftu8W3NcufXUN1lNUfnXQ9gZMauUGAD0D/vDt5CeHvh
         Dsb2AYCObl379sAgZNxKgoMT5vUzmwk71+LO+njZUXtCp1Rcq1yvbeuDFBlSmne1DRgo
         QfjDYHVBDuVx7cy7WQu9e9WIe4n/e+l5tDJ6X2ZNcgCkhlWb/sQKcbn+e9YjuyCu9dW6
         KdsZGWBoEadeylZY0Ro6SwoNNnKBBfiPAnBM6BHlcdBAJ7UimZS7FM53wcOvDgyFjGPl
         g1XVE+qwK2FfrC+zI0fe0CXLtpYV18SRd1FgdONVXH0JLgXeyTj44Lni9h9YgMzNlloo
         qohw==
X-Forwarded-Encrypted: i=1; AJvYcCU0pGsFt5Ul2mUugHUIbZtFPXvmGClZM2ppLDBR7Nn5kR44SG7WnCNlmrb95tbtkR6Hn0h3+xrV/iB2AnsfmvkvjXt/UT912ITaTF86
X-Gm-Message-State: AOJu0YyxZESbCRtJtnQUdElZpCDBAFRgJaa6Uq+v8JSzqyNA+BX0s7t9
	RD7srz8Y9RzvlfA6U0ESPRLD96+q9DHRLEcBxokCvvLaDLPyWpXNw9xmp5AD9A==
X-Google-Smtp-Source: AGHT+IGINmKk+cI6DD2WQ7SjjT99R0HHKYxf0CC6JwcygaTUpcCJ8LVus266jgna/DTBfAx9a5m9Ow==
X-Received: by 2002:a17:902:eb8f:b0:1e3:cf18:7344 with SMTP id q15-20020a170902eb8f00b001e3cf187344mr1829767plg.11.1712706401500;
        Tue, 09 Apr 2024 16:46:41 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902eb4d00b001e2086fddecsm9497419pli.139.2024.04.09.16.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 16:46:41 -0700 (PDT)
Date: Tue, 9 Apr 2024 16:46:40 -0700
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: kselftest_harness: Print empty string, not
 empty fmt on PASS/FAIL
Message-ID: <202404091644.9CFF82A@keescook>
References: <20240409224256.1581292-1-seanjc@google.com>
 <20240409160920.3bfe3eeb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409160920.3bfe3eeb@kernel.org>

On Tue, Apr 09, 2024 at 04:09:20PM -0700, Jakub Kicinski wrote:
> On Tue,  9 Apr 2024 15:42:56 -0700 Sean Christopherson wrote:
> > -	ksft_test_result_code(t->exit_code, test_name,
> > -			      diagnostic ? "%s" : "", diagnostic);
> > +	ksft_test_result_code(t->exit_code, test_name, "%s", diagnostic);
> 
> Have you tested that to make sure it doesn't change the output?
> 
> .. warning: ^^ leading question ;)

Probably should be just this, without changing the NULL init?

	ksft_test_result_code(t->exit_code, test_name, "%s",
			      diagnostic ?: "");

-- 
Kees Cook

