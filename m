Return-Path: <linux-kernel+bounces-57434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C25D84D908
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53A11F23E3B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F3E1DDD5;
	Thu,  8 Feb 2024 03:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="JgT7ETV0"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD0720300
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362958; cv=none; b=WOzctoOmBLPACZKsdhNMRKu93wm+Xn5n/xybih5q0IPx/igHceegNU6bQ/vNhVTD8MCLQioFw7133mjP6qbu5xhFZy43ixT5qJ3DIxdYc6ANg9jJsUMI0SzIbv7b33mw6t7XAyvkMO79k38QV7bu6YAjI8S85Oen+W1SdY/mlyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362958; c=relaxed/simple;
	bh=+RMz7BchTGB3NbO7kStTe5FPVRHU4BfvDpQ58MUHTxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ub+MhN0QbWbLpV7i7iYQdZXBkbJQgkSkRxjM7Yy5zah68f1+7H0PYXvPfhIC+0Wa/NO+sWHMlY9bDyvCSoXwW3ZKZ7IJijTvWHPFFUUMUrR3oPErrhEFSr2LAXDsvUxIu1bZjTyu0U8+g1pdBYoW8tCPv5uO607cYgSOU7NRtH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=JgT7ETV0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55fc7f63639so1620638a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 19:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1707362953; x=1707967753; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q97AdgGADpUKr5sEUfHXMUPIzat7eITV2ZUFt3wg+fo=;
        b=JgT7ETV0gW3FVoOvZeYb2JZhL1plMORPJ/l5ZoHhwmdE3KybF/ZszBM1k+VDW8fIqn
         SLMUSfNb0PjNjAx8MizD9gRufrxyxQMdI/Ye27qh8rsgkud30MXxpLN9E8a0pM2gvlLz
         DW72jil7n6DUiE8I2pKWoXIRv9yZ/oRuymN9b5a7PqdKllMYN41r9y0pUwxOSGDaZiOh
         d78ToiffDsS+gqW5I5v7+h0p91/Fy+enXaFkjjkmPGtbIHGITFBghJ8JrBUO3rWnWf//
         NSHY0fZaaSA59b9FZ232B1uZhxVdfMykMLvRAN5dayRKdNKOuuEEh/Vq365/HcmsDnyu
         XWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362953; x=1707967753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q97AdgGADpUKr5sEUfHXMUPIzat7eITV2ZUFt3wg+fo=;
        b=ZnP3uJVI+okDvxhy7mQ5s2KyRsYkrDWTGa+PngdDQqjd1+bCVKTAz8VUDoZ2ly5Y+S
         AiqX9YDbCHlphWZaGPJ1z4YJezHnaph97wPXivdehusyiZ/Kbgr+aKlVzrSjDzenvdfM
         yMmVYo4llwCAySEJM/UYZfQ55y9d/GReK8XNhKo3qyT383SMzUakvrLQg4YZ6fdDY/i7
         0RFPCuZGC4d2P7yTgCAc0o4wtzwUHwvWhZoaKhfpH2DkC0/WM87G72IVgVCEbC3UA3we
         nHjWuim/K0r6gsYD+O6UWB8RjZTxnw1CEMHXMtys/nMpLzcw77DWxaZ4PAB2PDN3lhKY
         HTMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbCazPeFqUVbA1KT1mUE97HqS1KfwskexxEpE85x8bnq+rzrYvwTgbddvnlT/4+OIgjxORpaK4FMcBpdWMYulVbexTrtVyCmPiKZ2v
X-Gm-Message-State: AOJu0Yzl2XXOT89BXgoMJ+ss/jmVy4650CUUvF0Q+41/OBREyi1O95pk
	g3yKLIYdN8nNm0nVoNGqY5G2cM6CkY4WOMkrDdMluPjBInGOmD//Rhy+PoH1wTw=
X-Google-Smtp-Source: AGHT+IGYzvXSLmylemDM1WdchwzVSHq5qTZWVDllnE8fJELaURELtDZhsVd/KF0ZXzPIft+h+B+bDQ==
X-Received: by 2002:a17:906:3086:b0:a38:15d8:9385 with SMTP id 6-20020a170906308600b00a3815d89385mr5226208ejv.52.1707362953314;
        Wed, 07 Feb 2024 19:29:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyZKOXd+GYLf6roADIeGg3HGZIS2V2hWuBBbHKXWYiv9TArrHxBPKciwDv3ItTYyCElznAZgBPtUthdhyEnpAwEoq9fo7A4No34CyUT/a00MZ2xTvpNCGWjLy3GNppsP9bUE7TklBCNHVPr3+Q3SzzARLpGiEpHh47YMDCgkSG0ckTyV5EL+C5qIvT3LwQiKcLftsafA==
Received: from localhost ([2a02:8071:6401:180:f8f5:527f:9670:eba8])
        by smtp.gmail.com with ESMTPSA id op3-20020a170906bce300b00a37669280d1sm1429879ejb.141.2024.02.07.19.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:29:12 -0800 (PST)
Date: Thu, 8 Feb 2024 04:29:08 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.com>
Subject: Re: [External] Re: [PATCH] mm/z3fold: remove unneeded spinlock
Message-ID: <20240208032908.GB185687@cmpxchg.org>
References: <20240204125404.2112384-1-hezhongkun.hzk@bytedance.com>
 <Zb_bhO8Z_d7VUCdJ@casper.infradead.org>
 <CACSyD1MEM+KnNMimmbdSFXOsok9S=vN=DxzS9x90_6+pt5qjFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1MEM+KnNMimmbdSFXOsok9S=vN=DxzS9x90_6+pt5qjFA@mail.gmail.com>

On Mon, Feb 05, 2024 at 09:08:05AM +0800, Zhongkun He wrote:
> On Mon, Feb 5, 2024 at 2:46 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Feb 04, 2024 at 08:54:04PM +0800, Zhongkun He wrote:
> > > There is no need to use spinlock in this section, so
> > > remove it.
> >
> > I don't know this code at all, but the idiom is (relatively) common.
> > It waits until anybody _currently_ holding the lock has released it.
> >
> > That would, eg, make it safe to free the 'pool' memory.
> >
> > > -     spin_lock(&pool->lock);
> > > -     spin_unlock(&pool->lock);
> >
> 
> no,  please see the commit 'e774a7bc7f0adb'.
> 
>         spin_lock(&pool->lock);
> -       if (!list_empty(&page->lru))
> -               list_del_init(&page->lru);
>         spin_unlock(&pool->lock);
> 
> The original purpose of this lock was to protect  page->lru,
> which was removed now, so the spinlock is unnecessary.

But pool->lock protects other stuff too? This doesn't rule out that
there is some other ordering dependency on cycling the lock before
freeing the entry. The person who would know best is the maintainer of
this code, Vitaly. Let's CC him.

