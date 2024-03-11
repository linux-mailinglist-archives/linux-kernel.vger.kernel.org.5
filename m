Return-Path: <linux-kernel+bounces-99156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7917687842D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F076B282FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B9945943;
	Mon, 11 Mar 2024 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="uvhuxONZ"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B486C4436E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172197; cv=none; b=oYpgqVLkdHsCnwua92fF5X7s7wuW0iBu+sXTTaKDPDy43fFzLfccNx3Bv0Fcbe/KJG3tZ5DyK2jLheR4rDUcrfj/316SXYJxM1Vcgd7FCLaY0heQ308boDYRzVRceY6szdtSFXuBVSOdSSZE4mWQgTct1FE8iIlBdSZLpIdiKRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172197; c=relaxed/simple;
	bh=540orTLqH26liId0CGC0Q/FWP36fwWOz7fNBb2i9ZjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2oA3vY/5M0VNIdBCZrYJUgQwQlIS9zu0APnU7y1YeVw69LyBULvJl6jPRTv1DIhURIUkFyBPaZlFE8rJEV3iY8gXdv+fHt3Su5bmywOfDrXEEMPf2JP9GRxyeHOlndYAyriIDok+kkNp2r/LAKiLUDzILGjJdDAk7Vm3nkPsnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=uvhuxONZ; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c213690558so1485359b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710172195; x=1710776995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+Wtwgm/ud4Teqcm7McoWzRYdR5joosf5QXB8q6Nk6I=;
        b=uvhuxONZedNAo3GtDxK6XQvovopD1Ijh+J/vIb3ZBiqmUccQhKBatJbWSpR5kwqkBA
         JSjTWLqNc7z6WZmFjhAGmNXr4PrYPQJfEUtMQXbNiBHHEaY9zHnUx8jAiPyKC5SD5Zr+
         YxVZX5XpADeS+HqOthRmlOlpj03iZAyxN74IwxAcCMPDfSwGQq0PTwgeEpmr+sEClimm
         VOhVjGrPUx+USHJOzmre8LagfPio2IsZb9JhmcBXp1dz0NrljxrH8x6M/X2MttUPX8wX
         E3U2Kl5uTojOt0Dy1EOLn4taPG7obOwct0HX5JOH6POlCu51F5IStcN3X7nNgjr+iRaF
         2bHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710172195; x=1710776995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+Wtwgm/ud4Teqcm7McoWzRYdR5joosf5QXB8q6Nk6I=;
        b=mtubS2DXKvMjk9lRHe2MdL+0+t5VJ3eJF67UFPvurwI8BqKx8M8rsChA84OrHYgU3S
         3BJnbccsbdyW8Q7ejKSvvXcRHXf2o744rM9SK+bYfj/xNeBvPHB3djBGLRPrZUBHx0zd
         VmixyGUgkV0kq32DLFX2EasNjKdKfEPf7IAc32OoIrpZ96sYcfc8tDZh6vGynbBixJNy
         nxgcBavf7t/C2GdKKOPb872xrjParH5KqZWiu3/j2kOmHeD7qAzigZQclzTV0ecq1nFK
         wAl612eiwtjxg6PpAJoPPAZhKU9g5myKWCfTVeud6g9iOX/Fq3kBGjqukPXNQaFrMICO
         8K9w==
X-Forwarded-Encrypted: i=1; AJvYcCVmZwToG0GaD/wxBpIUs0oE2wH/DqGwYpkVCROhvZoYUo19dYT2hg3t7UjV3JlOQWoghwSfgeH2rbJ7BhWP6xmduXpwjwNOtUQBtLy/
X-Gm-Message-State: AOJu0YyS06xgL29GWSKimjp5EiEEEjp4CRRouSPcsjm4/0mZGXdv3omI
	n3enleS3XXtEG2fPicNaEHhbSWAvQclhgCTVUsb/L2MS/ilWZNaexdN3zhRqqQU=
X-Google-Smtp-Source: AGHT+IGn/4xKoBd1SYHfu6mVj6p5jAAE0MdJYK4ZZdUXmc3Vj7qqayvCjJPox671NbLnFAYatzWyPg==
X-Received: by 2002:a05:6808:1406:b0:3c2:2cd7:2417 with SMTP id w6-20020a056808140600b003c22cd72417mr8036293oiv.36.1710172194760;
        Mon, 11 Mar 2024 08:49:54 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id b17-20020a637151000000b005cfbf96c733sm4509856pgn.30.2024.03.11.08.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:49:54 -0700 (PDT)
Date: Mon, 11 Mar 2024 08:49:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ajay Sharma
 <sharmaajay@microsoft.com>, Leon Romanovsky <leon@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, KY Srinivasan <kys@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
Message-ID: <20240311084952.643dba6e@hermes.local>
In-Reply-To: <20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240307072923.6cc8a2ba@kernel.org>
	<DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
	<20240307090145.2fc7aa2e@kernel.org>
	<CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
	<20240308112244.391b3779@kernel.org>
	<20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Mar 2024 21:19:50 -0700
Shradha Gupta <shradhagupta@linux.microsoft.com> wrote:

> On Fri, Mar 08, 2024 at 11:22:44AM -0800, Jakub Kicinski wrote:
> > On Fri, 8 Mar 2024 18:51:58 +0000 Haiyang Zhang wrote:  
> > > > Dynamic is a bit of an exaggeration, right? On a well-configured system
> > > > each CPU should use a single queue assigned thru XPS. And for manual
> > > > debug bpftrace should serve the purpose quite well.    
> > > 
> > > Some programs, like irqbalancer can dynamically change the CPU affinity, 
> > > so we want to add the per-CPU counters for better understanding of the CPU 
> > > usage.  
> > 
> > Do you have experimental data showing this making a difference
> > in production?  
> Sure, will try to get that data for this discussion
> > 
> > Seems unlikely, but if it does work we should enable it for all
> > devices, no driver by driver.  
> You mean, if the usecase seems valid we should try to extend the framework
> mentioned by Rahul (https://lore.kernel.org/lkml/20240307072923.6cc8a2ba@kernel.org/)
> to include these stats as well?
> Will explore this a bit more and update. Thanks.
> 

Remember, statistics aren't free, and even per-cpu stats end up taking cache space.

