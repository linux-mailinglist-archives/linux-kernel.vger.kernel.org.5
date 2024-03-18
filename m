Return-Path: <linux-kernel+bounces-106830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911B087F43C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D921C21A02
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765985F873;
	Mon, 18 Mar 2024 23:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ji56pQvZ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5AE5F861
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710805795; cv=none; b=Urx7P4zX5ijT4r/rhjDdxBgoasjb16/xyUDn5UBHVCtpUsURXEcXzzutg3m7N8F4hUoRc28TtZiU2hwvtYP2HbVyHheirGWjSsidI/iWB+IQzwlMUTWFDpax8ENCgp0BaMZoTwDaTCDtTo+tGP6WKgCFviJA5IoppqEwjVbwGR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710805795; c=relaxed/simple;
	bh=++8AIV7HG9payGSZCdI/YJMOMZaQDxTnyhPn9woYAqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYf6BaW0NAkJ5VivFv6GOSrcZXzmETyXgvHx4C36yWWX9uy2/a9GrPs8aEfRn5i/ptWjpsDv8E4OsjawQmbfwaOqgvge39WvmiFsUqHlO5+EJMXa+qykDac9PDWr/zSZ1edSyzQg3M3S535F9C3bE43sQPcideBXSWNhnQ5d9zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ji56pQvZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e00d1e13a2so11378625ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710805794; x=1711410594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vRkn/Ffa0kshb8/M23HImClN08sGjJ63GvS/V4Rk06I=;
        b=Ji56pQvZ6h5OLs7A0WB7yG6lpmLOpokga+eqJ3c0hKX/ZqYE52I00W7mz9On+kHujD
         JCm3PMUN221eD3/7vixTYaK1WLLzWWMQ7mhRL4RETfbR5LchPzRZCosc231qtTiYLcRA
         ofajvl6qH54rt0bj1TLrk3vRsRwFM3qXtaCfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710805794; x=1711410594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRkn/Ffa0kshb8/M23HImClN08sGjJ63GvS/V4Rk06I=;
        b=C/tE0UeuhGW0n/wLPhzY5CBeBW9VaOq1EKviCpXlqS4fDFk2KvrAA0L8KAwXirioxx
         5gvCUlpAI4L/OJTwsSi01F81+GHNXbm4YXErH1Mt38alXFV7N+h6XJDR8nplrqpuPNsp
         gcFykosz6x7si6GICshN63qNDUfTEQiAMSzWXt7lttYDGH8RujZc60fGXbAwcr1N336M
         j59TAUeGouUk5Nr/MVisdpnhwfp5el/RHMbEpXNUwwN38XG8sz6nHoCmZPExrUH/hoTP
         JPGWdEF7InpKYZzbqJPyyHOKx+HqhgPeYqbGgYpvtq2CWN/dCKOqYq2+xf6uIvHK2Plt
         GPTw==
X-Forwarded-Encrypted: i=1; AJvYcCUtACRecxtco5haq7QBiHd3k5N2BvHV8cJRcZoEkP+IuRk+TDPHEIYczWpuaNKac8/YCQj0Bo6of0rL/UJSRiEa15/Qm/WelVQEiBN6
X-Gm-Message-State: AOJu0YxuMj2wVg774nuxwczkvl0O/ww9zcx4rHCDWYKd/AG8FhNgFxXo
	Zi/AImw4oQLxU16ZazFk3hVbJj/lQxZJB95nI+SjUUgYY9VbgYc1P5iayTqQHw==
X-Google-Smtp-Source: AGHT+IHuA2onb1wnKM9PYOhYyVkXUleXOMB2F2xCC/G7R18UXwREYPkQdg9dME1Kl1WX8TGqOzk0Hg==
X-Received: by 2002:a17:903:2448:b0:1e0:766:abe4 with SMTP id l8-20020a170903244800b001e00766abe4mr7899286pls.46.1710805793852;
        Mon, 18 Mar 2024 16:49:53 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902c40500b001dd635551f1sm9921941plk.255.2024.03.18.16.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 16:49:53 -0700 (PDT)
Date: Mon, 18 Mar 2024 16:49:52 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: cmd-db: replace deprecated strncpy with memcpy
Message-ID: <202403181646.667970F76@keescook>
References: <20240314-strncpy-drivers-soc-qcom-cmd-db-c-v1-1-70f5d5e70732@google.com>
 <202403181443.F4021C9F63@keescook>
 <CAFhGd8qJ+Sks33cgEie_cvj-YrAUUiLrA7wY42eWQ2Xr++C4Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhGd8qJ+Sks33cgEie_cvj-YrAUUiLrA7wY42eWQ2Xr++C4Pw@mail.gmail.com>

On Mon, Mar 18, 2024 at 03:47:38PM -0700, Justin Stitt wrote:
> Gotcha, I was operating under the assumption that we needed to know
> the size of id at compile time. Apparently __builtin_object_size(_, 1)
> will return SIZE_T_MAX if we don't know the size of something. Sending
> a v2.

Yeah, it only requires to know the compile-time size of the destination
buffer.

-- 
Kees Cook

