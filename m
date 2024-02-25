Return-Path: <linux-kernel+bounces-80236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9D7862C5D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6871C20AA6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A2D18B1A;
	Sun, 25 Feb 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j/WsUxsI"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A07B1862E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708882845; cv=none; b=LIy23qTPGJTpuU98g9Au0mC1uYW/VeyvGLks7DdSWz+BzJ0L0mBSxfi6a0YmALJ+Ls42KxO4IDyjwhJ0NhvRlMvOzLkHvy1icoiiOBCAw444tOUf/Wx2kS7D3HlyfXGHIcBnat2p0PeVwTsl7K2qMfKqCG4SR1rsIwCMErPlW+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708882845; c=relaxed/simple;
	bh=M5ueI4rE4FkA0cMsA2V/WQsiAfStdcGMf7luW6cgZjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ3Ol+G+7k0z4uPnZJvNmokWvzMWNAWguF7HGvkEaSCjRFsi22QK5t8bcd6Gh4vIzRibKWehmW0SbKe6jWJ1av06hwcgJkO9/vr0D4lftQqDxQwx37nO5a9r33Szwfwomr5OC3fd1hzHz3CYzciFETCNyRw/eOdptiD8s4PO1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j/WsUxsI; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e2d83d2568so2062875a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 09:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708882843; x=1709487643; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=im7JPg/kdSuHr65BMEB/5JgpND5OUK4g3Oon83ZAQbE=;
        b=j/WsUxsIHnSGXSNX9juM07N/s6+qZ2lFzvRCsuK4yzy5v6BqGlN6adGBRUVC6aQvkH
         q+kbNL/Cjhf69HcINJ1UlsoWM4zkfbE/hCHJR7MNHfIQWKa9C019QpDT1K+ru2Ti9+xJ
         IiRQzk/F9MshO5kOVd24JPn9wgrxWea9kGDPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708882843; x=1709487643;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=im7JPg/kdSuHr65BMEB/5JgpND5OUK4g3Oon83ZAQbE=;
        b=mOtladzVNhi5zByIgVxeeHssPMjQMYchlY2OvymNC66miv+9Qwa6FZMLf+8YfbDT95
         xSv3L67A5GX6PQxWVDnNrXMPp1BFbWsbEd0qEv+eNiqGFktvOXAzRZlJeyoOSdGTwwyf
         WWoF37GVSjzue1v3XapPzr7G89K1JOba2ouu8gBSUCc9FduuIHUFQh3e2g/b77fHzbNa
         Z88zfOgInfr1bGklCUIQbQIFZKScLBzpGCzGAIzymQLbMzQvKLob2ELhKHRxuQ+ihJs/
         V9Jzt/FTMoyMRmH76uGa2QjG3cw12zvuaU62Pl3sEjB9NHx6Crm4lezWAYNeuB53LUGu
         bR4g==
X-Forwarded-Encrypted: i=1; AJvYcCU/abqGVnylQHT+xNaVWbO8IdZ8NRs3ru6kXzXbffQk+S8ybRcHzPUY1r5UNLekUOotAjw56g8i718W3LNZTkve3oLqS1gFy8i2ti2J
X-Gm-Message-State: AOJu0YzSAOZVTcEjkX+QchDZN1bW8E3JbgTDuovjDDI90uO6Sn5PNIer
	UBTsNxGqvAyQpMGbBup7rdTAj1s5CtD6IGG72xbOHG+XjBEbZTCHTagJipZrbGxG0raagD1LfhA
	=
X-Google-Smtp-Source: AGHT+IG1ii6o0hewhZOta9UOelNTuMqxYGm5gx1XBmzTSnwG7wWQcfGg2tbZQy7lNoWTwkw+EDPmxw==
X-Received: by 2002:a05:6358:190a:b0:17b:2bc6:e843 with SMTP id w10-20020a056358190a00b0017b2bc6e843mr7852953rwm.18.1708882843251;
        Sun, 25 Feb 2024 09:40:43 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e1-20020a635001000000b0059b2316be86sm2556856pgb.46.2024.02.25.09.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:40:42 -0800 (PST)
Date: Sun, 25 Feb 2024 09:40:41 -0800
From: Kees Cook <keescook@chromium.org>
To: Allen <allen.lkml@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCHSET wq/for-6.9,6.10] workqueue: Implement
 disable/enable_work()
Message-ID: <202402250940.15C634D27@keescook>
References: <20240216180559.208276-1-tj@kernel.org>
 <ZdUK1jhMUSyC7yUj@slm.duckdns.org>
 <CAJhGHyC8Y7QU3TWDA1jz3D5VB3BDG9JcZ4XB_9rft1UiMF7uYw@mail.gmail.com>
 <ZdWMd2rHjCEUOfAp@slm.duckdns.org>
 <CAOMdWS+7=qD9e=Q+Rv65rMXJ1uc_KPVN43uWrJ+xUdoXoV-D4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMdWS+7=qD9e=Q+Rv65rMXJ1uc_KPVN43uWrJ+xUdoXoV-D4Q@mail.gmail.com>

On Wed, Feb 21, 2024 at 09:03:47AM -0800, Allen wrote:
> Tejun,
> 
> > > For 0001-00010:
> > >
> > > Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
> >
> > Applied 0001-0010 to wq/for-6.9.
> >
> > Thanks.
> 
> I have rebased the conversion work based on
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git disable_work-v1
> 
> 0001-dma-Convert-from-tasklet-to-BH-workqueue.patch
> 0002-IB-Convert-from-tasklet-to-BH-workqueue.patch
> 0003-USB-Convert-from-tasklet-to-BH-workqueue.patch
> 0004-mailbox-Convert-from-tasklet-to-BH-workqueue.patch
> 0005-ipmi-Convert-from-tasklet-to-BH-workqueue.patch
> 0006-s390-Convert-from-tasklet-to-BH-workqueue.patch
> 0007-drivers-media-Convert-from-tasklet-to-BH-workqueue.patch
> 0008-mmc-Convert-from-tasklet-to-BH-workqueue.patch
> 
> Patches: https://github.com/allenpais/for-6.9-bh-conversions
> KSPP Issue: refactor all tasklet users into other APIs · Issue #94 ·
> https://github.com/KSPP/linux/issues/94
> 
> I am working on drivers/crypto/* and drivers/net/*. This might a
> day or two more. Please provide guidance on the types of testing I
> should perform.

Great! What's the plan for these? Will they go to subsystem maintainers
after the next merge window, or is Tejun carrying them?

-Kees

-- 
Kees Cook

