Return-Path: <linux-kernel+bounces-36112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46084839BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3C59B271AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A484E1D8;
	Tue, 23 Jan 2024 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WWMLuXO4"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC222080
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047578; cv=none; b=pFGN0e0Pyf5nH0a3eA+Df0dF6OWjPE4k4xMcNxYa325WfEigjtC+UGC0LCo+4adgrkrVkbaTpDCD2Ix7sEIYUVqoMahdUYFcpouIb8BmUpjQ6ZI9oXcK1RP4KWy+cGmlrKbdCFECqwjjFjphokABzX3yHW2OAiZF0YaB5r8eYA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047578; c=relaxed/simple;
	bh=meSKnuOdhgy7gcRPOlUjLkTPmz4xSbL8Ff1ES37ltmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiNOKfoB7ltHuAuqYG42Rp9ADpAGgC5+ILL4b8GCF62JiZKXMx0SpYJJwat2wakfM77HZX8pI2LIYVBXH+yXrkxVB3SkHQytlERnVpodh1zG+bV1vOXkMUr75jyv0pMNsWJam6wKdeJuYEn2YiUApOZFnS4sDh91eZwqRpF6yIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WWMLuXO4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so2692537b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706047576; x=1706652376; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vq5AuVtFfbnm7KmCdFym6eR8lK3cF/V0+/5wIAUspAY=;
        b=WWMLuXO47WtsxAtO0ouCUYsiaKqfKOoDTwi2/1mbK1WUL9585n790X5N0aou5bseB7
         gWcD7ep3SaFCp9cdeagKQPX9z4fuDhRjivd+2FWY6Cew2ymqjyzoEvvk8zdx+wyJiszh
         11Wv/fT9PcRAZ/199Cwcf8l3iMpnfF20eQCnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047576; x=1706652376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq5AuVtFfbnm7KmCdFym6eR8lK3cF/V0+/5wIAUspAY=;
        b=cljOYjgZMwqe+7TH0ufm2fOi4rxRH+yQu3KHuhMWue30+/y6uizYsixahyrvIY1oUL
         MHOYlrAvmqskMbDtnW1j7DQ8phCVeHjf1M0KJhO2Uy/x+GE1NJiDLGqg5C8Q2JrTYjUQ
         w6vhvoYgMZkJ/N+5vQY1omDr0ocxmqqbf12NSXcmMPSZDU4CldENxD3IX8+/mc41UBW7
         gEi4tX7Uf60Owa5cDxAyO81LVTnJoDEuvWuIM9HRshWHiiDixErqAWI94GsLbf22GAnw
         qL5OaJUqUZSE7bLF1dwq54fzc4s5ygy3jmmXfyucncbuW1klLVJCVXvRQ8cpZEyHq63y
         884g==
X-Gm-Message-State: AOJu0YwVqQzMEg9HARxsmNvy9TSubGwyDNIJZQkUgUKxNXrP1pzgIlWg
	YlOpogKQXhAUWYq0XwOmEYBy5ORdicnBflS4lhJphtqwzOm1w87i2mVxwP/80A==
X-Google-Smtp-Source: AGHT+IEdVicNP58IhFXYtzEbHaHvo9B2Vu+JPgRZ94CmAr/MeKEbwhzMtBto0WE4UQD2qQdKhczlCw==
X-Received: by 2002:a05:6a00:99d:b0:6db:c9d2:12de with SMTP id u29-20020a056a00099d00b006dbc9d212demr4353111pfg.49.1706047576571;
        Tue, 23 Jan 2024 14:06:16 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:81da:d4e1:ee51:c4d6])
        by smtp.gmail.com with UTF8SMTPSA id m6-20020a62f206000000b006dd897cd81csm95631pfh.53.2024.01.23.14.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 14:06:16 -0800 (PST)
Date: Tue, 23 Jan 2024 14:06:14 -0800
From: Brian Norris <briannorris@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chrome-platform@lists.linux.dev,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] firmware: coreboot: Generate aliases for coreboot
 modules
Message-ID: <ZbA4VthTMPT7BSRo@google.com>
References: <20240112131857.900734-1-nfraprado@collabora.com>
 <20240112131857.900734-3-nfraprado@collabora.com>
 <ZaQVScQ2AYquG-Zr@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZaQVScQ2AYquG-Zr@smile.fi.intel.com>

On Sun, Jan 14, 2024 at 07:09:29PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 12, 2024 at 10:18:31AM -0300, Nícolas F. R. A. Prado wrote:
> > Generate aliases for coreboot modules to allow automatic module probing.
> 
> ...
> 
> > (no changes since v1)
> 
> Same Q as per v1.

I don't have v1 in my inbox, and this wasn't addressed in v3 either. But
copy/pasted off the archives:

"Don't you want to have a driver data or so associated with this?"

These drivers are super simple, and I doubt they will end up with
multiple tags per driver, so it seems unlikely we'd ever need it.
Additionally, struct coreboot_device already includes the tag
information, so anything that could be included in driver data could be
parsed out by the driver at probe time, if absolutely needed.

Brian

