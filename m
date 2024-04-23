Return-Path: <linux-kernel+bounces-155747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7DF8AF68C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D8D1F25024
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5004A13D8BA;
	Tue, 23 Apr 2024 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="VTFxq/O1"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355AD23775
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897050; cv=none; b=VbLl8wptu6pAC+fmVQCjhqDDkRtnsH1GBWpG+QC0EfLJUErA8fVdi1/iBu/6pv7zR7wQIRIDwXYPGo+3l9AeWwFoIHYxZ+zB+KN9c+xGjGI9pmd9cYlCvd1iiyBA9KR9NiIjLF/jIY3nCLGlegrjANAciZcTzezZzetq5YIzTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897050; c=relaxed/simple;
	bh=vQ0qVpLoELxurtwdSwHJ8s6ASXY/fbOZLy9yuSYAhGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EibNtnW1+Tvk3VZPTd+E2mQ6EN4sONmnuKbHJJZasJoNkBd2g9eDZ6J3JSPBX40405C8Iioh+SNEVy8tJWNK+5F3KuMSPdkr14J0NCKaylHr6/ZdZ4A5IGp7vh+kC/fCZ6iLGiROJsKwajnB+vY6zrhTq8B1mSzz30WvzDm+hHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=VTFxq/O1; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36b31df33a7so29764455ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1713897047; x=1714501847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=awLc1C3yYWNbYWsTKFvaBZcSVTtx96/uP8a0BM23tGo=;
        b=VTFxq/O1MItcVLW15x6nNmbUw4kqtAU2+wgifUjYf5CeRCtYR2L0nYDw+yx8TeIRSB
         EuLnVdsp5mbGjo8rExv+1u21mv5uxee54YyPeEI86M//HywW5MD4r3Fr7vUGzWbPxCji
         ML1WQ2p7t3O/mCK0B/VLH8KYXtazZd5VOHCDOGUl7ySMKC5E5GOhJX47iA6jhhPh8YW0
         hNOuYhHOlZ0rWCNRRzNJYx1HvlXL6DN1wREGqewpa7EuvECpoodkODNy4em9SsjjSpdB
         +lYBG9KWY2cyFz+NeUenHB7v+BNSpZ/ZMm6YjqsJ93F7bu68tAMEaSejLwF6aeQwswze
         Hzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713897047; x=1714501847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awLc1C3yYWNbYWsTKFvaBZcSVTtx96/uP8a0BM23tGo=;
        b=jHedvWO5+luZm/OxHT4HpsLLR0I/rjvxVr0SAeU/Rm3KvOijNhmb9PjJ+jLZTcPO4p
         iMRQdLW9O9CNhkxhPU+rd4ubKXT6QgNYTvRPX+b7r7ZK+RXJsmpwSeSHSKX30DQd17Ju
         FydPd3LNtw2KJXo7YqQIwWwws0oB/pH5hLVyIkxEGzyd2JvsPois6YNGu633CLmHC0BT
         S7WUq2k7rQ9Qgy1yWxCkgd956t462zWLQNUR3qDXuofxi6VgxU9XsFgJVNLg/pl8KD1l
         sUUWxPGSWQcYpp6CyP/ooBqcMY5m1Eou1XWP38NwiXLEziX+DaDZ9ocSxA+EJiwFA0mP
         ZKTw==
X-Forwarded-Encrypted: i=1; AJvYcCUtemPOo9mm23RixeWXSuH0gUWd9O/8C3kOAheBvPk/GbDX+35JU6OgRXTl3+DyjgnWmwl4Xyv5UKMeszIIEZGL+Eo6Pac1yFlJ98eg
X-Gm-Message-State: AOJu0Yztw32RlbktJymQ4ER9/SNj/trutzon4WQoeZcJoSCYPQN/lkr4
	djGeke1o3chbzeNmThe1LfOWovqGmR8tjwN2qaztacZHzoJJ0mbVAUsqG4dPEkQ=
X-Google-Smtp-Source: AGHT+IFijJhS19rqZtDgL0G2e5AzqIci+oG/GPCMeu1J34lQhcoYfcF6F7HQfVUuwUkInu9DWaTY6w==
X-Received: by 2002:a05:6e02:12c5:b0:36b:3af7:42d8 with SMTP id i5-20020a056e0212c500b0036b3af742d8mr430742ilm.4.1713897047079;
        Tue, 23 Apr 2024 11:30:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9cfb])
        by smtp.gmail.com with ESMTPSA id y19-20020a0cd993000000b0069b53e6cc5bsm5368080qvj.94.2024.04.23.11.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 11:30:46 -0700 (PDT)
Date: Tue, 23 Apr 2024 14:30:41 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: rearrange node_stat_item to put memcg stats at
 start
Message-ID: <20240423183041.GA318022@cmpxchg.org>
References: <20240423051826.791934-1-shakeel.butt@linux.dev>
 <20240423051826.791934-2-shakeel.butt@linux.dev>
 <20240423135844.GA21141@cmpxchg.org>
 <cupqywok4kl3cxotmpnfrlcsxhkaj7lbo6viehvxlltv3qkt7g@nxxplmgbcfyi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cupqywok4kl3cxotmpnfrlcsxhkaj7lbo6viehvxlltv3qkt7g@nxxplmgbcfyi>

On Tue, Apr 23, 2024 at 10:44:07AM -0700, Shakeel Butt wrote:
> On Tue, Apr 23, 2024 at 09:58:44AM -0400, Johannes Weiner wrote:
> > On Mon, Apr 22, 2024 at 10:18:23PM -0700, Shakeel Butt wrote:
> > > At the moment the memcg stats are sized based on the size of enum
> > > node_stat_item but not all fields in node_stat_item corresponds to memcg
> > > stats. So, rearrage the contents of node_stat_item such that all the
> > > memcg specific stats are at the top and then the later patches will make
> > > sure that the memcg code will not waste space for non-memcg stats.
> > > 
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > 
> > This series is a great idea and the savings speak for themselves.
> > 
> > But rearranging and splitting vmstats along the memcg-nomemcg line
> > seems like an undue burden on the non-memcg codebase and interface.
> > 
> > - It messes with user-visible /proc/vmstat ordering, and sets things
> >   up to do so on an ongoing basis as stats are added to memcg.
> > 
> > - It also separates related stats (like the workingset ones) in
> >   /proc/vmstat when memcg only accounts a subset.
> > 
> > Would it make more sense to have a translation table inside memcg?
> > Like we have with memcg1_events.
> 
> Thanks for taking a look. I will look into the translation table
> approach. The reason I went with this approach was that I am in parallel
> looking into rearranging fields of important MM structs and also enums
> to improve cache locality. For example, the field NR_SWAPCACHE is always
> accessed together with NR_FILE_PAGES, so it makes sense to have them on
> same cacheline. So, is the rearrangement of vmstats a big NO or a little
> bit here and there is fine unlike what I did with this patch?

I'm curious what other folks think.

The cache optimization is a stronger argument, IMO, because it
directly benefits the users of /proc/vmstat. And it would be fairly
self contained inside the node_stat_item enum - "ordered for cache".

I was more hesitant about imposing a memcg requirement on the generic
vmstat ordering.

