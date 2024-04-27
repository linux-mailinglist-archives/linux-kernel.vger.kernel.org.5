Return-Path: <linux-kernel+bounces-160838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF0E8B436B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 03:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457E11C21E5C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B352E62C;
	Sat, 27 Apr 2024 01:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NTrlNAsR"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943ED2570
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 01:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714180522; cv=none; b=R7Qe2Ar0IJZBbw70XxG2I5SawmyvFnEZaGQnf4//eF8fxzowU5u0g3CTzMnVEnIQJI70R3ciMGtm66LSUx0zllovXCF5plAB15bKAqwSTWcRiBMzhcULS3N6CjumCrRTAkfgv0wf+HafTr+wUQdyd//ecZVyUqtZtS2PoM6/qfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714180522; c=relaxed/simple;
	bh=LYF/0EjxExzZ7UQI2Z9XnIu4tPB09xytMqOIKCPsi4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxMCVLKtbyKoD06R2dXwyPKm+cpZhZF4N8DPB9ly6vTAebzHM5ORq0nBqF4Li/StwGvfNtan/mfqYJkfhOjKLNs6RZ3ohTIa/S85f36uYtb46yfi6nqeLz0KOyfOyyMCqesPqgCG8fUW1m4BkFQatEFi46BEMz/ZgETjKoh1K70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NTrlNAsR; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 26 Apr 2024 18:15:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714180518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7onvPrSnv4zk2ACGNhrsA4mgLdVhUxihzE/0ThcanU8=;
	b=NTrlNAsRURAWfw5UqZv5+bw43WmHjK6ABGB2u11bVCshH9h87ma5dT/Ybbaf2gmjGCOqdh
	4Q73lcmI0pobOAT+nNUba+ukZ3Dq3/Nm81/gNhnwoMLE9sbUxl3LL/iJJ428/qqiRjHjlR
	/kjEMjI1qJRumv0bLfk6WLZ9B9PsXb4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] memcg: reduce memory size of
 mem_cgroup_events_index
Message-ID: <lyxw3jphvncnfgenvpocl2srs2vtm4frmv7yyieel544apwaub@mrddepkseafr>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-2-shakeel.butt@linux.dev>
 <CAJD7tkYsz+v9z=3N3dCUFP-9L3RazVkQU_6Cuy0o8-0Ouq-S5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYsz+v9z=3N3dCUFP-9L3RazVkQU_6Cuy0o8-0Ouq-S5g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 26, 2024 at 05:42:48PM -0700, Yosry Ahmed wrote:
> On Fri, Apr 26, 2024 at 5:37 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > mem_cgroup_events_index is a translation table to get the right index of
> > the memcg relevant entry for the general vm_event_item. At the moment,
> > it is defined as integer array. However on a typical system the max
> > entry of vm_event_item (NR_VM_EVENT_ITEMS) is 113, so we don't need to
> > use int as storage type of the array. For now just use int8_t as type
> > and add a BUILD_BUG_ON() and will switch to short once NR_VM_EVENT_ITEMS
> > touches 127.
> 
> Any reason not to use uint8_t (or simply u8) and U8_MAX (instead of
> the hardcoded 127)?
> 

Just to keep the error check simple i.e. (index < 0). If we hit 127 then
we can switch to uint8_t and S8_MAX as error. Though 127 should be
replaced by S8_MAX. Somehow I was grep'ing for INT8*MAX variants.
Anyways if there is more support for uint8_t, I will change otherwise I
will keep as is.

