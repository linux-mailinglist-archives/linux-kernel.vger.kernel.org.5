Return-Path: <linux-kernel+bounces-167797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6189D8BAF49
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939951C22499
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A474A99C;
	Fri,  3 May 2024 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="EEwiSmqj"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956A51E4B1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748089; cv=none; b=iE0Dv71eLDfeYte6oETIelPEIzFSIDqtgrnsGOr5tReGFqEMYtVVjSuVLqqbDzye3FlPIAR/6AoUucbog6gLtAsMyQRTjiw5ZNb2vWFrpYGV2mGKFlAQLavWDI5PPLXvn5du2iqEgH4j+Mqm7x1F5majO+xbEZCps4KfFQsemc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748089; c=relaxed/simple;
	bh=v8kH573V3nLbemGi4DJG1xZ2+1X080JwmMxd/o2exl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEzRZu50kQBnTZ3iq1BvbRoRehSvVQTBFRQb4ImfshtblDdSQ7XwEqt9ecMl6+6HZkdbKrQ9umatrwTwUbII15E3tyBLOBkUvQNKLJqmtJ9Jy7Pe9mmKNI1uOeoOo5hrpplwVu8aPsGJVQd7Weridv0yb8vjeVz0ZSkNet6joI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=EEwiSmqj; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78f056f928eso677911985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1714748085; x=1715352885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgnwKfJB3kJ01AY0EqJ3oTDVPySeG9MAN3LYuEwZg9o=;
        b=EEwiSmqjvyH5JN2HY4xW0QKQOg+lpi1pQvJgTLsC87Y+HFMnsNh7FgPPC7eJg9qeh3
         AMQPv2ya26IUuKrfVZ2J1Xn6UPovwODBeUFEvY1xmndCtlLOM6wASzBoAOYE3xaoi0Qs
         B0y6L9WwMkf7gzlSKrf9KsMAc3N/jlokt7G3utma1AbkSDvna1mVTF4T1cO/idwv8sDz
         BSXLF3zGHdFovluYeCibhLrIrbuyuZQFPtF3vgmk4IT/Qxc6OfmDGmHicEsWhhgGI7qJ
         mKASZKT1aFmJ1opiLtTPCeCC5qUCthpJJVZmQkhS/uoHz3v/Cvf9L1u0Tx2CIA5Q40La
         bUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714748085; x=1715352885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgnwKfJB3kJ01AY0EqJ3oTDVPySeG9MAN3LYuEwZg9o=;
        b=w6tpMnclyginO1zTZqopv8JhnaPgkDUVFPlldQ9tzeMa7cgf/8UA+Bg0ZyOpLG00Zs
         0MMLAvOT68z5zCWPgTyRXHIjQVTGodLD/4rElmEV5sTfKqo9l3o4ku7mzFk6/wLXC1Lz
         6WSQQcwjHJG1BjOWtqlZSgxmBBbOIqSejh6+HltaKfuhOJuV7zTJtizu0YsjP7QVMMfS
         5uwBzBmFbUkk0YID9sjW4gUMWS96L2rB4nL8CHTeXFsnfBu4skgRCs+RT3zfi8Mh+x/5
         JNohiIqlX30Ky57MqWnp1bzkgvlpEVnY0xPx7zgZpbF0Ny21viS9cNygtuSE7G29yW3b
         yidw==
X-Forwarded-Encrypted: i=1; AJvYcCUAHm19dkIF8E1BGAgk5XQe20kCVFrWrxOQY/HmkH5GTvVunyC+B0Tzm24QI++OVIghZuoqOvkacvCRGecRfI3682quMJY78RrWu2pT
X-Gm-Message-State: AOJu0Ywv0ux3bG6G0nI4yN7noB29Ir/xlDdjA2LbZwpXHXarfe6xievt
	dsQPZGmrptUsUxEjrYnqPCL7FRtJBGJHS2HDtzs4k7MLt9xRsKH8zNxJzqVQADc=
X-Google-Smtp-Source: AGHT+IEtOZyEr24VbO8xFLGbBcJxGsTi5hvCM74iUWTfb4RSHWb9Vplkpo+dXXpzeArp6XXpPQ0+mQ==
X-Received: by 2002:a05:620a:3b8a:b0:78d:61a4:6955 with SMTP id ye10-20020a05620a3b8a00b0078d61a46955mr2685812qkn.67.1714748085468;
        Fri, 03 May 2024 07:54:45 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id p18-20020a05620a22f200b0078edc0a447dsm1297062qki.68.2024.05.03.07.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 07:54:44 -0700 (PDT)
Date: Fri, 3 May 2024 10:54:44 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, nphamcs@gmail.com,
	corbet@lwn.net, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/1] cgroup: Add documentation for missing zswap
 memory.stat
Message-ID: <20240503145444.GC2538005@cmpxchg.org>
References: <20240502185307.3942173-1-usamaarif642@gmail.com>
 <20240502185307.3942173-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502185307.3942173-2-usamaarif642@gmail.com>

On Thu, May 02, 2024 at 07:50:24PM +0100, Usama Arif wrote:
> This includes zswpin, zswpout and zswpwb.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

