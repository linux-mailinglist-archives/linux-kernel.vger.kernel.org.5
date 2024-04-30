Return-Path: <linux-kernel+bounces-164554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673568B7F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC381C22F59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C52D20326;
	Tue, 30 Apr 2024 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DeMrA98n"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D2F175560
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499368; cv=none; b=pTA4aQ3/XQnLeyHDHctchRxZQBZ49rEBNhuOipAGTmdpTcO+I01aemk7hndKoU/QNyqkoxAGUM1wkHpo0PZvHkqj3ip5QzW+x3Cwx02tsjWOLKFtCAm4COONrsX5OyI/lKV945q7MnIc82pYJugmDryiYqXikGZ+QA22MSf7W/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499368; c=relaxed/simple;
	bh=VFo6owDRX4b3ZWugSBJHygd6JuE30wLsH9HXlOwRwbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtDJGwTBGFc0wbopztdd7O3rQH/j4zsw/cSrQuFhaIfEIxSjsB8rtVMVJ0VeKRuk3H9DuUM0ctsCd2RK0ihkDwZdVS3xIRQ8FMQQgp8VnfunyFDkaxvzBqN4kU0vnwppdgJvTT8qULr9Z0uUU9SdiwKPOXviHwxLioBPJlWqtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DeMrA98n; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 30 Apr 2024 10:49:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714499363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPJon94WVPTCJVxAuwEzMFjgEeJu/W5zYuiZ8N8gwdE=;
	b=DeMrA98nCGYXATxJeF3wx0DmqLgugaO1+GZRkfQf58xLwmlOH5vQIilQzcUHN3h/58EfUd
	nXesSNChK8Jgr0r+NHyJq+d/ZhBANoWk2e0ks40G+b3nTNMPTv04DyzncucEmQAtNTF0zJ
	W5az2Zf0YENBLvcJUS8gtUTvQ3782V0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	"T . J . Mercier" <tjmercier@google.com>, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] memcg: reduce memory for the lruvec and memcg
 stats
Message-ID: <xr63kemkwanxcesjqy7as32q2oxjlehkti4ruhedea3mm56wby@p7etbh4yibrb>
References: <20240430060612.2171650-1-shakeel.butt@linux.dev>
 <20240430060612.2171650-5-shakeel.butt@linux.dev>
 <CAJD7tkZnXY+Nbip8e6c7WC4qoYC21x=MHop_hT4NqYLKL8Fp6Q@mail.gmail.com>
 <u3okwix7ovvzzfossbmfalwpq23qa3bmv3secg7tpjk7ghyemq@w3ngvr526rc2>
 <CAJD7tkZh-bLHQhaPsU7h1WUmK3xwHVoacVcR=P55i+7d0FzfFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZh-bLHQhaPsU7h1WUmK3xwHVoacVcR=P55i+7d0FzfFw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 30, 2024 at 10:41:01AM -0700, Yosry Ahmed wrote:
> On Tue, Apr 30, 2024 at 10:38 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Tue, Apr 30, 2024 at 01:41:38AM -0700, Yosry Ahmed wrote:
> > > On Mon, Apr 29, 2024 at 11:06 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
[...]
> > >
> > > nit: we could return here if (i < 0) like you did in
> > > memcg_page_state() and others below, less indentation. Same for
> > > lruvec_page_state_local().
> > >
> >
> > I have fixed this in the following patch which adds warnings.
> 
> Yeah I saw that after reviewing this one.
> 
> FWIW, *if* you respin this, fixing this here would reduce the diff
> noise in the patch that adds the warnings.

Yeah, if I need to respin, I will change this.

