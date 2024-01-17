Return-Path: <linux-kernel+bounces-28571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76880830029
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154F11F264FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9473C4404;
	Wed, 17 Jan 2024 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+zMi+1k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25018C1B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705473066; cv=none; b=NE4guQ5JI6+CvA4Nh+BoJePstdImT7OsbKo4xt9XR4b4Fux4YfTM7jNhjkeKFXxnSOsk4XFcwlCDp/sJb0FZPutTqDRzOyoZOzxavO9L0aj3wWheOgI4caXJfaqdZmgr84VQMAENsR6PPsSPI4qUG/ajaxMVyHH8Pfn52pP7ZHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705473066; c=relaxed/simple;
	bh=xuqbdmvl9lCw8IH5mVuShkyHEa0QF98r9fLMLUrlE80=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Q223QSEEvviUcHykVZpuchS8lyJCSurcCNIDAvub/jpkJZ6/udO4v/MkVMpWEeiqGRwoHVRpJEqIlEPPnO5l3UvYudtwDjU60tB6dzZNYGEE+aMrN1QkFH4qcYAemg238PLsR7FqfkiV1giR47hHGuikJS2TKy3X/e9IkU5dqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+zMi+1k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705473059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxiOO8w88rWledmaRoeFUmYXRXhztfaSOi7NyQWmNYk=;
	b=W+zMi+1k9OdaVbNYKZ4v7id9snyynYbITKn54GAXpmrrVSpPlOAVb5y3bc+4r3hYI2+qQo
	bTsis2PruCbM9OeW73jEfUuL8ou98hqXKuutzRQiUPlBU1LlpUf6HcuNbB0elhequ9pGPN
	Fj0/EbhVwTRHI1jN1ayEhjGRZzYGRR0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-8p9HWv2wMQGpDSzlKEjH3Q-1; Wed, 17 Jan 2024 01:30:57 -0500
X-MC-Unique: 8p9HWv2wMQGpDSzlKEjH3Q-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68179ca2e57so18280796d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705473056; x=1706077856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxiOO8w88rWledmaRoeFUmYXRXhztfaSOi7NyQWmNYk=;
        b=T6VwEoOOBDmEt/iFVTSkV3hAOM+jDIhKkn6Nqd3FqN8ecNrQ7q93aJUUSaORs0t7R1
         yZqgvAiFm/b/ebAZ2Bc8XQ2cnU2ivDeZjgkecagFLSwMNQCkSNZ1zN7z/98NAImoprzw
         OcfBQ6UNEaiSIVAulE046AmOFUxPlGoULLCOCZJABs79iTiKzdL0SjVqprdMqPn7qTlM
         gGH25F74hGcMOsH6XtZoC8MhiZbNWQbRUh1wh5O6b3Mcn74ZNqrulquS0E+soEwLi6ur
         Wjqzcc4jQw4k/0teKe+VBuYKY7+JrFEVSKut+SFw7Rnn1P9JJrWmcbPJjCnsphkt5O9E
         uh4g==
X-Gm-Message-State: AOJu0Yw87eMCtBD3e9e4mo/eHq0RXkNoeiKWfxaaimqup4Jq3lNiZ6cn
	wAp1TY96nHush8y93nl/0t6g/3jKfxiCG54rlEAYL7KqwH7jXecE75j04RPbLpon+VQ5DO2NgMm
	NaMp2p6mR1dzySk0t+znL63Fh1AEXr2JB
X-Received: by 2002:ad4:5d6a:0:b0:680:b48c:b54b with SMTP id fn10-20020ad45d6a000000b00680b48cb54bmr11146726qvb.102.1705473056760;
        Tue, 16 Jan 2024 22:30:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2GplJGaFxrXJ/X+uhNLOl6Slr6TDjgFHOphZ878h+fUERTtk0O6cNXHzF9cPdHxwpi5kdEg==
X-Received: by 2002:ad4:5d6a:0:b0:680:b48c:b54b with SMTP id fn10-20020ad45d6a000000b00680b48cb54bmr11146717qvb.102.1705473056478;
        Tue, 16 Jan 2024 22:30:56 -0800 (PST)
Received: from localhost.localdomain ([151.29.130.8])
        by smtp.gmail.com with ESMTPSA id t12-20020a0cde0c000000b006816edd1979sm1115431qvk.140.2024.01.16.22.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 22:30:56 -0800 (PST)
Date: Wed, 17 Jan 2024 07:30:52 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] kernel/workqueue: Bind rescuer to unbound
 cpumask for WQ_UNBOUND
Message-ID: <Zad0HDaH2YxAnqD6@localhost.localdomain>
References: <20240116161929.232885-1-juri.lelli@redhat.com>
 <20240116161929.232885-3-juri.lelli@redhat.com>
 <ZabPXiT8WoLyLoyk@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZabPXiT8WoLyLoyk@slm.duckdns.org>

Hello,

On 16/01/24 08:47, Tejun Heo wrote:
> On Tue, Jan 16, 2024 at 05:19:27PM +0100, Juri Lelli wrote:
> > At the time they are created unbound workqueues rescuers currently use
> > cpu_possible_mask as their affinity, but this can be too wide in case a
> > workqueue unbound mask has been set as a subset of cpu_possible_mask.
> > 
> > Make new rescuers use their associated workqueue unbound cpumask from
> > the start.
> > 
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> 
> Apply 1-2 to wq/for-6.9.

Thank you!

Best,
Juri


