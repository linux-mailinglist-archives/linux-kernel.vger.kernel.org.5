Return-Path: <linux-kernel+bounces-82601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6C18686E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E481C2858D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE450125D5;
	Tue, 27 Feb 2024 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B+93MRha"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EAF1BC40
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000598; cv=none; b=tNrUkv23kPXza44dP3Bz6vz3tiIcIbrD6mMNOeqpEPVTV6gH+Ne8GL4/W2nSPk1aWu0muMYabe8T+WgxztDEm3sciKwgunuyQQAy5/f/5QIuAy3s/wWaQxMhbfV6YbrotfA8A1fwix6AR4ZJBjBBK/aCLf/6AsJqPAHfOMSjIus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000598; c=relaxed/simple;
	bh=lj+342i91tukvDJc+7mQyuceOT3OFF987/6AJGtJA74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDWCT+VvqKZ9KTZMQYPe/5vC5BKq/sgx4skyJFTLxAV5BHDfyQSbWwOHxhLfaMtAO+LLsaVODhQm386lNcZhOQDxmwknPdoXxinXt/kBuODOg6Z4fp7wVmZTFjvzWWvmOkLMEXpEa2a7bZUET1GaHxTxCq7Lsda6Kb8ok8EiIXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B+93MRha; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc49b00bdbso32633635ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709000596; x=1709605396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=memibgJZNOyBXI4CIvwtBXRp9WBttR7QAtL1A6J1jew=;
        b=B+93MRhafM3EcMzEgLJ2NrnA/NK+cO99KuZuBDVrK+lYY7WHQuw2ynskWHA9W27/yy
         jrRdW+7LoCjBP448TErolBOSSL/H1RxM7t8UbTszbeZFeB3x6vOrkZ6KBny6O2KpQRB4
         DeRUBKRg6cUUa5d1nB2tFG+31Q2FfQGs5h6Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709000596; x=1709605396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=memibgJZNOyBXI4CIvwtBXRp9WBttR7QAtL1A6J1jew=;
        b=rCPG6kztOdT4XfBwgnWjWZ7voeijpC8IaWXo2Jg8wvg8B1Zqa4Q35x6OqufYqJ8Zj4
         2TayPARaWMlrlSQ6v/JhZW0pU40jFB1gzbZToOnOPLGQ1Xb9Iw6x5eBKwuB1rslrgwIo
         yW+JWVt0iaYgTLDwP0TRjqS2VJfzg4kbT48Whv9EhT50B8wzFws6phzGJiOSLzqWDelu
         MWKogkKkpHB65rvZ5PNBCdutfZFtS4QMxRD3VzrQZEN9hBOKAPB5fip/R3V2MxzDpdVj
         tDioHafGYLr1Z1aG2h6rqPFfyIRRCwSPGrRFDQuviHe7LAcHmdfJc71HVEVtkVhsXJPn
         Wz3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuz2+UxqfWHBAjAMCJmnGnsdXnlSoTyczb4bF8MJ40/t1rcvm/cFNTo8O+yNWwL8pZcpdR37EJq1ge8uJpvkiPaH6YzUKWXDCUs1a0
X-Gm-Message-State: AOJu0Yxrsu/ifXpaZT0PNHqQcECWc6YiNfREQPsHF7biqw3fhBuil2aT
	nJEA4zZcXfX9tE4itd1XfHyCj757SCCVjWHa3464nwc3d5ktxpF901Iw13IRPPhbDHdfA1KDBXU
	=
X-Google-Smtp-Source: AGHT+IFplsJJIA7+1tesLzAlhF8/AJorGVOwn8v8Uyrd5ZzwmXskYJ3krHczx70GyhRbNqa7HaaPyg==
X-Received: by 2002:a17:902:f542:b0:1dc:a40c:31c6 with SMTP id h2-20020a170902f54200b001dca40c31c6mr4656751plf.25.1709000596048;
        Mon, 26 Feb 2024 18:23:16 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mn12-20020a1709030a4c00b001dca6d1d574sm343800plb.302.2024.02.26.18.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 18:23:15 -0800 (PST)
Date: Mon, 26 Feb 2024 18:23:15 -0800
From: Kees Cook <keescook@chromium.org>
To: Jan Bujak <j@exia.io>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, ebiederm@xmission.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
Message-ID: <202402261821.F2812C9475@keescook>
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
 <CAKbZUD2=W0Ng=rFVDn3UwSxtGQ5c13tRwkpqm54pPCJO0BraWA@mail.gmail.com>
 <f2ee9602-0a32-4f0c-a69b-274916abe27f@exia.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ee9602-0a32-4f0c-a69b-274916abe27f@exia.io>

On Tue, Jan 23, 2024 at 12:23:27AM +0900, Jan Bujak wrote:
> On 1/22/24 23:54, Pedro Falcato wrote:
> > Hi!
> > 
> > Where did you get that linker script?
> > 
> > FWIW, I catched this possible issue in review, and this was already
> > discussed (see my email and Eric's reply):
> > https://lore.kernel.org/all/CAKbZUD3E2if8Sncy+M2YKncc_Zh08-86W6U5wR0ZMazShxbHHA@mail.gmail.com/
> > 
> > This was my original testcase
> > (https://github.com/heatd/elf-bug-questionmark), which convinced the
> > loader to map .data over a cleared .bss. Your bug seems similar, but
> > does the inverse: maps .bss over .data.
> > 
> 
> I wrote the linker script myself from scratch.

Do you still need this addressed, or have you been able to adjust the
linker script? (I ask to try to assess the priority of needing to fix
this behavior change...)

-Kees

-- 
Kees Cook

