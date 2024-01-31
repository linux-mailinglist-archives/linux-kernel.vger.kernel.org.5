Return-Path: <linux-kernel+bounces-45564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3081843272
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E552D1C20AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235D4EA4;
	Wed, 31 Jan 2024 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VxCi3/Oo"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FAE7F6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663019; cv=none; b=PlwLlbPn5DHa9IsAEw1nsAqEFLqF8vwm24Hkf+I0QxvsoCrfTd48ierpdElFxiXlaH5u+sDc3mklq3PbUC8jo3/DqmnpD9iuuNtnfv8ZKsbHyCr9SViDNzQWI6vaI3sfNUr6rjg4jhgbGjEwH+TZenNaP8vVc+Y2e2iZ63WNNDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663019; c=relaxed/simple;
	bh=P78vGUOWmwxj9VBECZrWmjs6oXLrY+Vvok6borasUtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIDLbfJjFd1MinqUBNvADaSPN2MWAgW7F7U18/sY4zJwGQdxWAlB44xxpCIJ1Zdda8OXEtbcoIcF7MruCb90A8OG/cI7rLJvtgSa+NRIrs2sIGM1vVi55f7NOxSdtDTz+3gqz9JjzPUuBsnK9DwtFV3QjYc7c4lfPuSGysrKdLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VxCi3/Oo; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d8b519e438so2384846a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706663017; x=1707267817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2R32HEq+vuywQM3UpPUw4pXHTl87m8EtCirJzA1KJU=;
        b=VxCi3/OoOwrtxuptL8/gwy+5bffKeETSiV24dhMtNzv1Lva8GadgpvOr31M628qjVn
         ffGjTkc5FMccmN5/8BjrTIQusb7LhVYDpxyfS5K0S5n5y+gUkwS8DDpyKW8SRhRGdhHr
         BeOMLGwAqQOyVUspVRPqa4VaxMRJTPbn04XF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706663017; x=1707267817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2R32HEq+vuywQM3UpPUw4pXHTl87m8EtCirJzA1KJU=;
        b=Xg0gD8H6ULXV6Fe8WaJRn69LheqF82OfVzpjwuE8lYKxfUjIi6R6KvTG8YaFe0z5DY
         NvjsGhgagrUAOACPxCoTKvd59OfOer1eF4/PCWbhhVZTtf82mS1xNFZJTIStllv4H1NW
         QQu4LWJDgp9pSLq/YUvcH/KfbzaazUz2a6wz+VvIZAiIjRY0xER2nn9e4F7d8uIi5ruQ
         djAfQ7Gc8Ft+w2AMJdcsMHVzv4oMVvmIrFVlRDdHj1nHgpsk2Lyay56qy+PIRKnPlwl1
         UlCFxokgUOf15szKxZAfx9DEiUttGTrFMrhHEWv2ULiyIXXQhXIO+MD/DNXzKY5oBAR+
         hNHA==
X-Gm-Message-State: AOJu0Ywbpob66z5NArGOaTYzxhbOlnbzgE+Op9PoIVBJDsuTI6hj28Y7
	zh7Wr3Jq3lmuXrNxl7606Lgfwhwj25+8CeuzjzBKvqDCMdYdQgpW5JnGhtVInw==
X-Google-Smtp-Source: AGHT+IEKiaWAQq80mzMmGk3FsT9xgGBpJXc6jj4P5Q0pB8PIHdIt+jqHenmTSFx9QlPLTVK+SS6fFQ==
X-Received: by 2002:a05:6a20:24a4:b0:19c:b10a:61d0 with SMTP id m36-20020a056a2024a400b0019cb10a61d0mr107912pzd.25.1706663017109;
        Tue, 30 Jan 2024 17:03:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW0yxdv61U9Ph0riM4nwnLHvOyV1MA4icW7D10rIuc9crwin1on/sLBscuwTNdBEeyNKzEpEjWMdc0wLygUtXNLZtYKFw9bQsJ6UoyY5Cfr0jayAwMCmxWcIBj/aAsSEv1llXSMeuTysFl9uSgIs2C6MPAn2RTmsTq6Olkm/2KjHgVThpzm7n56mgUXAlbzNjp1A4e+ArpicjaVcAwPLzJhFWgVtimZL45//dx4BPfYPXGFhEpYBePAs6gPtn00wNFWBQ==
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709028f8500b001d7222d8caasm7831874plo.50.2024.01.30.17.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:03:36 -0800 (PST)
Date: Wed, 31 Jan 2024 10:03:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] mm: zswap: cleanups
Message-ID: <20240131010331.GB9406@google.com>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <ZbiwW5BJhFeGc2Bd@google.com>
 <20240130122131.GA9406@google.com>
 <20240130155201.GC772725@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130155201.GC772725@cmpxchg.org>

On (24/01/30 10:52), Johannes Weiner wrote:
> On Tue, Jan 30, 2024 at 09:21:31PM +0900, Sergey Senozhatsky wrote:
> > On (24/01/30 08:16), Yosry Ahmed wrote:
> > > Hey Johannes,
> > > 
> > > On Mon, Jan 29, 2024 at 08:36:36PM -0500, Johannes Weiner wrote:
> > > > Cleanups and maintenance items that accumulated while reviewing zswap
> > > > patches. Based on akpm/mm-unstable + the UAF fix I sent just now.
> > > 
> > > Patches 1 to 9 LGTM, thanks for the great cleanups!
> > > 
> > > I am less excited about patches 10 to 20 though. Don't get me wrong, I
> > > am all of logically ordering the code. However, it feels like in this
> > > case, we will introduce unnecessary layers in the git history in a lot
> > 
> > This also can complicate cherry-picking of patches to stable, prod, .etc
> 
> I'm sensitive to that argument, because we run our own kernel at Meta
> as well.

Well, it was less of an argument and more of a "let's consider that too".

> But moves are pretty easy. The code doesn't actually change, just the
> line offsets. So patch will mostly work with offset warnings. And if
> not, it's easy to fix up and verify. Refactoring and API restructuring
> (folios e.g.) make it much harder when it comes to this.

If pros of doing it are more significant that cons, then OK.
Either way I'm not against the patches.

