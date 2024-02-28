Return-Path: <linux-kernel+bounces-85679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1311F86B92F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F20A28B774
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEF014534C;
	Wed, 28 Feb 2024 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z+RAqYC8"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F33B73509
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709152785; cv=none; b=DabboPSixr8zm9O8KUefIXTThwJVPdobZ185Eef9mo+PMFLVIPbiwuB3LDCO40KoP/jJnZjeknY2qvLU1t39DHPrVlbuUEVwnJEvlwoWBLh5YQIZiP92+OXd13CVu2IMMeD1clUhPDYXBeiDdbto8iDF7K09vyVOYEqjNwPi0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709152785; c=relaxed/simple;
	bh=XGVStHb8y9qSUzs6dep3cN+bk9roRYQbeBfT9knwOIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXFPOs+gjOUqSook8+y2hA9k8vUM4OT1mV7OuBWMXpzLDfokbIumy8iawiACw/Fe81KzuNIvhldf9d84TTdiH/N4P2DUWbtnbMj/nT1fx0SLydnm83HvLkYNIenPotAg+tI9M3+EVoORERNUjCHOB6txlZnFC+EnI2CsBKeVKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z+RAqYC8; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29a6dcfdd30so94272a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709152783; x=1709757583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SN804jzc01partIzI2Ah9KqFEvJhnq4W2RCgOUJ5uBM=;
        b=Z+RAqYC8bhY+Qxcw9SbQHP87crJA7xuaQFtcaNfTgLfz1rt4zEXSYFwnq/Jih+eUb0
         IjwlVjWTDjDGm2jXdmPvmKyy6PgqoK+GiAiRrxkRbGLF3A34FjlciQyR2qcCQiuHi5Cv
         uxBawJSMUjH58ZAmNbqVPjUdI/KkssKYTsJyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709152783; x=1709757583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SN804jzc01partIzI2Ah9KqFEvJhnq4W2RCgOUJ5uBM=;
        b=CBm1DJE1a+3/fPvfXdIiyqbBSqO92TeHmDUwLAL17Ne3WNdt2FH/V3kNoiW3dKqIHE
         yK+id4Pk0U+9M5rXfjPKdRc4pecPaXTkAjVovhAX8KW33QN7F6w4efhTcyYwQE6NZKMv
         sIrqWrfZYZxggBqFdWe/Yy9XfGQBPC8icSzP+AsOeuGzNe25Cqxnj9CwGgW9Gk110Hmh
         JjJ1BOn4FJMoOvsexldYg3lhmmY+SQu3VVIvKRX3FdFdFBZT8yFiVTUz7GDz6xUs3rZ2
         PkcG/LZwFcHovQVDVilvyEBLliOTd4tWXlLxPeC8jAyK60FJ3WH+RyQZn3WpZKuQdLma
         EozQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNvWzl3pujHl/0nqzwmaXD9RLGYV0XHErpMPXB43/U6LTKnDsh5Lw00t77dQz+GKtjzj0DG5wW427suN9veT+BOn495o9fmU/kW7EQ
X-Gm-Message-State: AOJu0Yy75IuF9mo8sTS1quI5MFD/WE68zIaI/9hjcfnGrmkhDwE0AIUv
	kb5kB2oEmvyvjbEJo6nosAXsjOMDCBNgC+dGjO+CJpGEwl/WJ6rAz3LkW6PnjQ==
X-Google-Smtp-Source: AGHT+IFLfWxA/Th4MZy8uxTVg4Aj3LQW9lYFKKfkZwp409nzeV0dHtSQ5wDsY3J6R2HhEBTSJ2b2OQ==
X-Received: by 2002:a17:90b:314e:b0:299:4a63:9e50 with SMTP id ip14-20020a17090b314e00b002994a639e50mr298019pjb.14.1709152783512;
        Wed, 28 Feb 2024 12:39:43 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090a4a8400b00299a0efa221sm29805pjh.35.2024.02.28.12.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 12:39:42 -0800 (PST)
Date: Wed, 28 Feb 2024 12:39:42 -0800
From: Kees Cook <keescook@chromium.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 000/122] 5.10.211-rc1 review
Message-ID: <202402281231.F7A20FCE@keescook>
References: <20240227131558.694096204@linuxfoundation.org>
 <Zd53aNc1aFrCYxFd@codewreck.org>
 <2024022804-askew-stung-cba8@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022804-askew-stung-cba8@gregkh>

On Wed, Feb 28, 2024 at 07:06:38AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 28, 2024 at 08:59:36AM +0900, Dominique Martinet wrote:
> > Greg Kroah-Hartman wrote on Tue, Feb 27, 2024 at 02:26:01PM +0100:
> > > Kees Cook <keescook@chromium.org>
> > >     net: dev: Convert sa_data to flexible array in struct sockaddr
> > > (ca13c2b1e9e4b5d982c2f1e75f28b1586e5c0f7f in this tree,
> > > b5f0de6df6dce8d641ef58ef7012f3304dffb9a1 upstream)
> > 
> > This commit breaks build of some 3rd party wireless module we use here
> > (because sizeof(sa->sa_data) no longer works and needs to use
> > sa_data_min)

Just FYI, it's possible that things using sizeof(sa->sa_data) were buggy
to begin with since the struct size isn't actually dictated by that size
(it's only the minimum possible size).

> > With that said I guess it really is a dependency on the arp_req_get
> > overflow, so probably necessary evil, and I don't think we explicitly
> > pretend to preserve APIs for 3rd party modules so this is probably
> > fine... The new warnings that poped up (and were reported in other
> > messages) a probably worth checking though.
> 
> We NEVER preserve in-kernel APIs for any out-of-tree code as obviously,
> we have no idea what out-of-tree code is actually using, so it would be
> impossible to do so.
> 
> Also, it's odd that a driver is hit by this as no in-kernel driver was,
> so perhaps it's using the wrong api to start with :)

The reason is that most drivers don't want this size (see above) and
all the in-tree code that did need adjustment got adjusted (visible in
the referenced patch). :) But that's the risk of an out-of-tree driver:
it doesn't get those fixes automatically.

Out of curiosity, which drivers broke and what's needed to get them into
upstream (or at least staging)?

-Kees

-- 
Kees Cook

