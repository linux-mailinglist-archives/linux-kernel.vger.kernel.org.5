Return-Path: <linux-kernel+bounces-56183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2577D84C717
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25DF286AB7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CFF20DCC;
	Wed,  7 Feb 2024 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hnmakqU+"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F920DCD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297533; cv=none; b=gv7zujmmz5IEfH4CAX7FDfFk8CCCao5dPRMSHVhEvNnCDhL5Jy98Jn6aTuaMar02Sv+x3T46RahrQ8/DExs/TmU8003/VWFuY09dBjBAiQ6TlDbBHFYRImTR31ajD2csOUx3P8/FdupSExI14JO0854jdnEoLvkFyncvze626UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297533; c=relaxed/simple;
	bh=1jfkXzEU42XrNlTOrYgVxpel0/h+5EUT5MRCBrv1Wg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCgkpcTloVje7cOfumWqbLAGANhWpSGR7BYvHCC0HvFWw8yLgdv1oKLbv1WgSnPqgg2HrF//cX6kubn2vgBQACegEWfgnRedzkCvCTbw5TqUb9NTDZNgdE+m3sWIep3LReVIDEwFM8pcIiE/p0Xx7KtXItlXr+FuAAt69QTIP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hnmakqU+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7393de183so3411765ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707297531; x=1707902331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dvvwDnpbjNBn+9NOt2kovthLIHMOsqPt4VSpCq5q/E8=;
        b=hnmakqU+26C6QwLJ7B2JkS7tm5s2QTRJfGk1/u1AKMqeEU+mrJ7DVII+9NCs3eNLfx
         fGo8qUikwF8I0XfYXj/LnwO5PjbOwG8wrAy5+54E9NuJ73pBhNxArbBPPna8a748SmdM
         BvFc3JGy93ACt5BSQd5dp94Xw5n6elTafzG8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297531; x=1707902331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvvwDnpbjNBn+9NOt2kovthLIHMOsqPt4VSpCq5q/E8=;
        b=DqBrR+ac97ukFMojHnFVZOzvS+KtEnv5sjRK8cHQWDm/gGGcBGMKZeykt9m51xwpd1
         dwL84p+1/2nQV0YTaMaco0rMfAOJstFHt56IQ4ER93jPSoORjqoQ8qRVn/FZhhf6LvbR
         8A9yivtRzlDQ22lTAvdbbtr/5dllVEyIwlooODkbXkxkGTTydJG1qLvOkeQlyLno4dwq
         vMisN8e8VqKSivtwnMUAEcRUiOhU0QLQ42eWvmNTM/W06cMlGxw/O+5W5/+w/eEO3DIQ
         V3JYVLVdYfVxjbOi4BhU65uYJue0AYbtCFS5E3RYB/cMyj6+Ayq/PLm1FxAz3kYHoERA
         8CUA==
X-Gm-Message-State: AOJu0YxgldXh5DgHdbuB5jSsrfYb56IpoHUhhjjuM5qyDyd6eqfmBvqT
	76okMx51cUuPExkpCcJ8yTKxh16DiCHwZk96HGc0lEF/KkOGX3iXWcAmZEOPQg==
X-Google-Smtp-Source: AGHT+IEFQALsTSc/iApggEuMndGposLY0LsIv3nQL6+uN09l4rY630QyTpJ4hUME2/Vgo02gZWcpOQ==
X-Received: by 2002:a17:903:987:b0:1d9:2369:d0f8 with SMTP id mb7-20020a170903098700b001d92369d0f8mr4423261plb.9.1707297531344;
        Wed, 07 Feb 2024 01:18:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/ljlKv0gnPptnrgqIOdlLMqVbp7UOFuc0CZtBwpmV0aWypPzVcmXrY3WBHqm4Mbgx1//7mxmWJbFePvmMV/FTz9PAzADgmUMWZQ34w2gzb4jtCtkpNV8kl3qGM37sfq883PJL/ytuxw0IsOhFZVhK4IfN1Y/WRnzeenWktf/CAT0lT0I+jfJEtbWZLxpeIN3u+7Kl8PA0/8QDWMMXUniGiCzYC0fbR4lklo1idbnRDUFcqeskrWWlSD4upPNso+SSC8RA6GniQ5DFaOue32MDKW9Tx45fEUFMlVdge9S0823TrVJ7FLJd61HJW84kuvsIPkdklHic03dqBZDSGFl7BqsqXaCsee2VsBzedyaeZ4hlLiIXHlRDwIleVMoZZQRDkKCdiuHm6aHAtpLikEKbpAJfp06iWzzwJFTroo5+yj3GozHdax5Z
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ld12-20020a170902facc00b001d7233dc459sm952236plb.76.2024.02.07.01.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:18:50 -0800 (PST)
Date: Wed, 7 Feb 2024 01:18:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v3 3/4] string: Allow 2-argument strscpy_pad()
Message-ID: <202402070115.2C86687F@keescook>
References: <20240206142027.make.107-kees@kernel.org>
 <20240206142221.2208763-3-keescook@chromium.org>
 <20240207005151.lyrtgqd4wekolwe7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207005151.lyrtgqd4wekolwe7@google.com>

On Wed, Feb 07, 2024 at 12:51:51AM +0000, Justin Stitt wrote:
> Hi,
> 
> On Tue, Feb 06, 2024 at 06:22:18AM -0800, Kees Cook wrote:
> > Similar to strscpy(), update strscpy_pad()'s 3rd argument to be
> > optional when the destination is a compile-time known size array.
> 
> This patch is diff'd against Patch 1/4 in this series, right? I wonder
> why you split them up. If I hadn't literally just read that patch I
> would be mildly confused.
> 
> I suppose one reason may be that 1/4 is a standalone change with a high
> percentage chance of landing whilst this overloading magic may not land
> as easily?

I viewed it as a distinct logical change. I could certainly combine
them, but I think it's easier to review the conversion from function to
macro without needing to consider anything else. No behavioral changes
are expected, etc.

But if they were together, there's a little more cognitive load to keep
the func/macro conversion in mind while looking at the optional arg
magic, etc.

I don't think it's a strict rule or anything; it just felt like the
right thing to do to split them up.

> At any rate,
> Reviewed-by: Justin Stitt <justinstitt@google.com>

Thanks!

-Kees

-- 
Kees Cook

