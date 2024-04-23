Return-Path: <linux-kernel+bounces-155319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3418AE8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68014285E26
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9BA137C3C;
	Tue, 23 Apr 2024 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="PPABboEJ"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB3C136E1A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880733; cv=none; b=HP3xGLxp+jv/vASWhxv3q1viADLlgDB/47qZOBbb5mIWmnWHNYTVqIyDGeOBp8WJFO3W+OTniJ2dUeiFnqBwDnWjM1JvHC6q3LX+0d9bF564M3HfidSC7gbQYhq/vcE0GNY9V8YHsGN41sXoXuyAa3+AkvUJeQCPjkw/mFH8/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880733; c=relaxed/simple;
	bh=dkyhFZxSFK/ufXtmRabwl0V5jznUX4WTx+N7+111Dbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnun65evSZRdSfw0zFZFMBmptOoLmsZdltnjhyNa46YY7yHXZ6k8w9TPl5aMTN+7hjdIpZ8kf8Fc8aFF7Qk7reyNh+nkWNoHeWcVbtd78JYYwruQZHkOhkWTRGox4CskghKKMxH1ISm1P9dk97qdopj//HIhYoxSZdmo8wM31Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=PPABboEJ; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ad28c0b85eso1779787eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1713880729; x=1714485529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqStfhzOnysXibrgT2E48MrpzZWIctM3Wmz+RM/fc7I=;
        b=PPABboEJfEuSSbQCuKBcn38jtuIXVO898wnREhOT59fHsA6k7HI34Nk5amBZRh7Axe
         IWVTuL7WBbGdLgGnLfxeiYbb9xIlECz9MziXxeH1IMUiV6iL0WymvvyTdvRRSbAqlwkM
         ZBdzNoxZdTWsavn8u69mlvdf1jeK50OdZ7fgyEYM18SoxboEN7yeBnUsSJpEaFm4l2fW
         B1LTe0xvI5WRA+xm66gZIuWB/jtVSv2GRiNn5FJUUVaSdUgNXgTIxcRfUtbDcMN05StK
         WghJr47GIt40ZPfudIF+GTACUmmS32f3VbUuQjR0c4BPS7cJT7mWBfOB7x6QSvToiCCh
         NWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713880729; x=1714485529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqStfhzOnysXibrgT2E48MrpzZWIctM3Wmz+RM/fc7I=;
        b=cESn3dWSD71ZmYZRVkuEsFmHiiOiRQ/O5iKT0ISmjJgT5t8S6Rsyp2fqIm623yEj8y
         d0cW3/yPlIVeM7kAzERH5RfMYjLYSM4DmOFx88YIeJ0O+2CJubCZStCLo9GovP3SnDJw
         d7Cqc+yA5oE0I2Ib3CpsC87alv9fRBDl/mIhOxTWF4uWWiGp5qyj10IyMJSFYFr8Knxd
         cjFkXNNFd6bgzbhD4HMEv4785JcGBUwqbVMwbXATWAJeZ5Dy3pAFkwHpEFTIzrVbWa0b
         x7ckdeij0MQrxOfZSuXRsgCnihDHL30kvzrqtKJkK7aQoneCLCsSlVGJ53+Xu1OSc2m9
         /kgg==
X-Forwarded-Encrypted: i=1; AJvYcCXyN0DPMOWjSKhPmOiOElUZXElczawJkuK1piNW79vr7V6wDo+uz4jor/xhLs5Fe1Q23uGmLu5tYY0/T/sAIWxK21p/3uWEvGc+uWY4
X-Gm-Message-State: AOJu0Yw0zkQQ3fDg8fryIb1D2H4juP02S/iPh+3nuy5/fxQoaSBkQ7Fh
	gkaEQgCBlWmYIhLZwaHZf9/K9R1zDjfub5iWLHwo6KiPnscT8BndhzKDbenqyBCnvAv/sh2ngs4
	c
X-Google-Smtp-Source: AGHT+IFwG9XJlDFqbvMmAOd4uyTY8SGLMaYeyX3/gPYvOni0T7+MH5srQSPCfT8gzXzv2lH9r8NbMA==
X-Received: by 2002:a05:6358:4b02:b0:186:22a0:299d with SMTP id kr2-20020a0563584b0200b0018622a0299dmr17564312rwc.27.1713880729494;
        Tue, 23 Apr 2024 06:58:49 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id kd11-20020a05622a268b00b00432bb012607sm5202815qtb.47.2024.04.23.06.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 06:58:48 -0700 (PDT)
Date: Tue, 23 Apr 2024 09:58:44 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: rearrange node_stat_item to put memcg stats at
 start
Message-ID: <20240423135844.GA21141@cmpxchg.org>
References: <20240423051826.791934-1-shakeel.butt@linux.dev>
 <20240423051826.791934-2-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423051826.791934-2-shakeel.butt@linux.dev>

On Mon, Apr 22, 2024 at 10:18:23PM -0700, Shakeel Butt wrote:
> At the moment the memcg stats are sized based on the size of enum
> node_stat_item but not all fields in node_stat_item corresponds to memcg
> stats. So, rearrage the contents of node_stat_item such that all the
> memcg specific stats are at the top and then the later patches will make
> sure that the memcg code will not waste space for non-memcg stats.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

This series is a great idea and the savings speak for themselves.

But rearranging and splitting vmstats along the memcg-nomemcg line
seems like an undue burden on the non-memcg codebase and interface.

- It messes with user-visible /proc/vmstat ordering, and sets things
  up to do so on an ongoing basis as stats are added to memcg.

- It also separates related stats (like the workingset ones) in
  /proc/vmstat when memcg only accounts a subset.

Would it make more sense to have a translation table inside memcg?
Like we have with memcg1_events.

