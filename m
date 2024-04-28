Return-Path: <linux-kernel+bounces-161322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8C08B4AAB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF60D1C20D41
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601C5524AF;
	Sun, 28 Apr 2024 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZdDV4fD"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C023DE;
	Sun, 28 Apr 2024 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714292004; cv=none; b=IN6/W8DZskR4sBwwTDsRlct/fY3LON3jE1GNrpRE6DqCEmgugmlK24ztdkKpdRCOPTajQieBoBJQPu76h/SIQ+nCcIQQCvyuSvTudnpKa0xy8E5/DLhlVkd7//lRbrJLQYnW+6rpBmcvgWK3SDhEJJ97PjhLvHAgrgIv2B8gDtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714292004; c=relaxed/simple;
	bh=cHNvbidJD/XF0dsQm6FL1s2RtNKPzmHuykBLedwjSl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUa6MAHtF/rJpg0IK7tW9IrQZZLC1IlZwpaL7i7A/ZMhlooJ6FMW3NWFvat1IA7Ngg3zjuzH0oQh1UGZx56w0HF1Dtxu9ORI5Q0nxkKrcl8qzf5wvZvUH+DqjTOg0u5cO7K0OOpB5M3TlJNKW6VC01txBmELPQxtS/zdhF4CsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZdDV4fD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-347c197a464so2650616f8f.2;
        Sun, 28 Apr 2024 01:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714292001; x=1714896801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRkNie6sOvoPrIKey0CE+VC9dg5CI8noygkEt7aEQHU=;
        b=fZdDV4fD6rF8R0vl6xJsvqKK0k1lulZ/vUWY9GhbHOeB6c/WXkZuDdhTMkEkzOw50a
         1jUZw623UrY6wxFUHx5a/iw84/j/O3lNbUXVv1fn7M8nCIKWe8raMWqgdoTu02uiQgpj
         TYIvue4gsSYTd1XMNzQBFDZRRv8gvNrqdNTjZTsgZAx7/eU+88UgwaV9KQ0k2GD40W13
         HzHYPKq4lPh9M46EqwMsnJ2satp5Hg991iB/lakJK2hl9hgqLE2xCEvybqBt5Wj28KvC
         3QE4DhtXORxA2k6/aC6JpuSfA73TMDFRetlcl1BaxEs/UnYr4jWbSIIsezU3ZaxMjM2c
         0W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714292001; x=1714896801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRkNie6sOvoPrIKey0CE+VC9dg5CI8noygkEt7aEQHU=;
        b=WQsl9gjSLPzP7ETii2K2wx0/XCJWWUm1jvVuiGeUca4TbyOM9TWmNCC/QFlmX11IhW
         l76H2rC/N5RVANvSeZlBpbvr9TXLzQes+a19Eh+KlLqB9SGP1NxyIOU2zdeB5w42tULd
         Se5aOnT766fvQ1hE3bPe6QlLrmAd4H9k44LWZ1Y2Aa2Q4+ZeTmGmI+CdexsE4pSKh89s
         F03QnN4dvRQFjSfVr3GLYFtKPUwD68jTY2HV42xnejZzB2s5MzfPEwBi4uO3upVNn8Yc
         t7+T/rG5+pKem8apTVjCVoMLwaW8TYmowJGjjAsHiSGjY0q/UJqrAY36Mz0H5HPEgZj0
         rD2Q==
X-Gm-Message-State: AOJu0YxQ8wfTgjUlFYEity/dsdReRS+rbrjOgwLlRb/96pgXOvWlJtsa
	IRSjhuQBYejn41ab+MY1X+49f0jKNymn9P4K2dwC/IpdI6B3TIJJlntUvR+f
X-Google-Smtp-Source: AGHT+IF4o2mDxQEZaJAQAFe0e8PuZQJsqA/5KurjSBqtod/of8BVDAjoewXRzwJxQ8gslNieBIZufg==
X-Received: by 2002:a5d:6108:0:b0:34c:719e:67a5 with SMTP id v8-20020a5d6108000000b0034c719e67a5mr3604714wrt.9.1714292001175;
        Sun, 28 Apr 2024 01:13:21 -0700 (PDT)
Received: from gmail.com (1F2EF175.nat.pool.telekom.hu. [31.46.241.117])
        by smtp.gmail.com with ESMTPSA id e37-20020a5d5965000000b0034ca55b8e61sm3202736wri.20.2024.04.28.01.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 01:13:20 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 28 Apr 2024 10:13:18 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Phil Auld <pauld@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org
Subject: Re: [tip: sched/urgent] sched/isolation: Fix boot crash when maxcpus
 < first housekeeping CPU
Message-ID: <Zi4FHsc51wNhdSW4@gmail.com>
References: <20240413141746.GA10008@redhat.com>
 <171398910207.10875.4426725644764756607.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171398910207.10875.4426725644764756607.tip-bot2@tip-bot2>


* tip-bot2 for Oleg Nesterov <tip-bot2@linutronix.de> wrote:

> Another corner case is "nohz_full=0" on a machine with a single CPU or with
> the maxcpus=1 kernel argument. In this case non_housekeeping_mask is empty
> and tick_nohz_full_setup() makes no sense. And indeed, the kernel hits the
> WARN_ON(tick_nohz_full_running) in tick_sched_do_timer().
> 
> And how should the kernel interpret the "nohz_full=" parameter? It should
> be silently ignored, but currently cpulist_parse() happily returns the
> empty cpumask and this leads to the same problem.
> 
> Change housekeeping_setup() to check cpumask_empty(non_housekeeping_mask)
> and do nothing in this case.

So arguably the user meant NOHZ_FULL to be turned off - but it is de-facto 
already turned off by the fact that there's only a single CPU available, 
right?

Thanks,

	Ingo

