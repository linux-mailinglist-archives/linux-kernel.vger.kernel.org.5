Return-Path: <linux-kernel+bounces-162622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3488B5E28
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C56AB25927
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE39C82D7F;
	Mon, 29 Apr 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Emn2PVfn"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C282C76
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405986; cv=none; b=BvcB2PukQle4rUKM8wIwOHmnjAncMMIagChiebqenVvH50EyJ6NzquEZSv2jgZ3PhREoMshXP2PR+CteKLZ86J5Bt9dmyi6VJ44oNs71aHpIoNIVDfnrtifKMlYgDDAfjw2d7AtArPWPoFw6eGhPwj3si3EvK/Y1WKBAJIUOYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405986; c=relaxed/simple;
	bh=+Gy9RwHGHJ0e5OL0NRMNvIMDKmFymnkkxx/hxNe5NF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e90nvZ5zB+zvEXpS69vQ8hyZSHxQLidOv+0dxfk/VytmuoQGKl65odbzC4m30f/ms2WolSSuutu9RI8eWglQu3d3uvuDzEM0BkOfKe4UBl3yOXTNevdEp/GFWe79R8GrK+sFHWp7iIVVrYHH5H5Hn1bhau5KXm2slSZDT3WDaR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Emn2PVfn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e5715a9ebdso38512965ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714405984; x=1715010784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5eP7J5rmRXvh7SkF0EcLKfWbbg6AxsrY7JazBQWQacI=;
        b=Emn2PVfns7oQ4XMJIYQqzUWBqou6AgdnUACrmBS+XqDnaxepDVoVbWZ8KhD1MvfkKy
         M3m4qduT79bcDh6/QTn9REeUzp5eSMqbn4apWFfWfeSUVDx/P86qLyhD7dktPVcNEQAE
         ryOjsLieB8qHUwqyHPy+k+XD6aKnsL9lMn+Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714405984; x=1715010784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5eP7J5rmRXvh7SkF0EcLKfWbbg6AxsrY7JazBQWQacI=;
        b=hWqomZn2Sun3NSbZ2PgqEYnizE6p36PIZH0b+QB8amOH0Zd8rMrtXiocH6RAhg2rGE
         DKVRYczlfeAjt3M+vMQc6BZ0gu7ywH4m6VzHT+hhIRgLI2Nf5i+qTFNj18SQQoAaK+St
         nADpkfv7CLNGxn/7MBA7V8mHDCNnBXHevPVhIt+Z1HXZ0tMjkfjRPBPE69kbmwFIenP6
         K0zYDE6tl7DEfalLq1YKGfJhjSNwQFKX6oymIDxuHhzF6cSnDiMEKRe783VsPtVfPR01
         y7qPKfH+w9sNM5CU/XvDUdZMsymym6vq5XzlP/WJUmEK9MANnSYEcBZ9prarrxCnHhky
         Q0mA==
X-Forwarded-Encrypted: i=1; AJvYcCXldm1TiDqjf8Xe1HAXDMSPeOUMXH7tkm6fMzb0JtVA6WRALlHTFssnyqduVlcQ4YJjj0w7LdALc64QMUlIVcIK51Lrr1pnva+cylCI
X-Gm-Message-State: AOJu0YyY28Prt3FdPoTiQjeF+GrNj8Uz6vDGnoqQIHjlSP+LX1Dc8mw3
	/VQ/Jprj+yu43nC9cEVknUIq0ZwLTtnnIAgVrGYaKnRhcio+MKWyHdRDnHB/cg==
X-Google-Smtp-Source: AGHT+IHSqyOxeblKePjbJ2HI0zhUUlfn734QZma9y5m9jhA8eDudR1ftPfekBbvZQWW6+1i/in1j4Q==
X-Received: by 2002:a17:902:c950:b0:1e2:65b3:de68 with SMTP id i16-20020a170902c95000b001e265b3de68mr12287764pla.19.1714405984267;
        Mon, 29 Apr 2024 08:53:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090276ca00b001dd69aca213sm20332520plt.270.2024.04.29.08.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:53:03 -0700 (PDT)
Date: Mon, 29 Apr 2024 08:53:03 -0700
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 6/9] selftests/harness: Constify fixture variants
Message-ID: <202404290853.858A4626@keescook>
References: <20240429130931.2394118-1-mic@digikod.net>
 <20240429130931.2394118-7-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429130931.2394118-7-mic@digikod.net>

On Mon, Apr 29, 2024 at 03:09:28PM +0200, Mickaël Salaün wrote:
> FIXTURE_VARIANT_ADD() types are passed as const pointers to
> FIXTURE_TEARDOWN().  Make that explicit by constifying the variants
> declarations.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Will Drewry <wad@chromium.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

