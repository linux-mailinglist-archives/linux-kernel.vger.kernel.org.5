Return-Path: <linux-kernel+bounces-123009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632968900FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A081C2B19A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9988060B;
	Thu, 28 Mar 2024 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3SzPdnH"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38568847C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634346; cv=none; b=rKhCyV17rbunN0uRNkB6Q0WhweoAJ91ZnKOi3fEnoqkSTHL/+5sHZLcNvP0zjcFjGrzypgg9acSInMxUKsLFbUiqwcaJTupqTVbZ1pMTdE6+TAkxzD27HQ4IA0yZM/rPbSSE1m2PG/un0asMGObjIzNMoKxUg0XIvxpHnGnhrsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634346; c=relaxed/simple;
	bh=NK7LET77latJxFetZ4zO1WlQhyaBRI6+mpEFOHPiO1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/1s5FWptl7uWecyrP6a0n21aUvqNeA0vk9jCtYWjZrAJtG+xZRkBFKQq+iQHxhrB2aiv+UPZF0DoDqjK1dmqcRShBeTw57WNDSyejThFhUIJWR5gGyCiJn7HTCBw0m9NRjITXPDFLDcP5nScK3UPbsvF1IcF1yfLwf0pCUAnk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u3SzPdnH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-413f8c8192eso75065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711634343; x=1712239143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UhSlWCplow3q0UiENwQXBqJUPqprxyAeOLjfYZq98Wg=;
        b=u3SzPdnHOelpWdOjkfNoyINnyjT1lHSr693ZDRQuVdkUCe3RoVv6Lm9ZRjHqvddDyI
         rHNCCkzKsEpurUYawiOefeDOUieGigBXO8nZ//SBY/DS31ny7roWiDZsO3S2Sb5BRLDJ
         TPIIKvuduUIi6CnVurDExWnTvMyUuxWJSpoAa0NpCweenpo5Mi3sG2fMkJpRk2z/fh2A
         Bv61hgGqT1vVmBJS7/urKaainLbdvj9fA45zh7gtteQuo8x1IMtuwjL0vFT0PqUxUQL4
         oQziwsUJoUPOe7pXV/ezTMyhKgZbz6XKkGa02C1c66QGtmp8v8sRLpyp+u76orr/1GBj
         Dnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634343; x=1712239143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhSlWCplow3q0UiENwQXBqJUPqprxyAeOLjfYZq98Wg=;
        b=J1fmYhRc+KaTPfbc5vwF5hBtxY7o0mm9yZh8dY712QVCINGtR/8xomFkj9UILqQuSY
         aL4XJn8rakB/708TEIJt0TF7iQv4X5t5Aum7y2FVLF4syH3/CiJWUhnSrsgji+R+l3w4
         cI2i0erYrXfGzm3DZZN1WtobFQ7jFtK4BZXTih7Koe3BUJNKYeJILuJewvJ1GpjNkgw6
         G3sRNByD8kdpwQPKhvSuQ9kBbNwWdG7qQneC22+L6RLtCmz7iimX1iAss44UHoilfogo
         F+KACRVGn4IovpfZELxEX5rsJZOeJQwel3j9YJgVQGKcPhNhDaRibm5Hq2Uh3wX4WaCe
         /IIA==
X-Forwarded-Encrypted: i=1; AJvYcCUUf2K0UX9LDij7V+5lJQitypxhPXLk/AWw593jeN5fl8/QWnx3Op0WGN3oSlZehmrV+toaE2Bot2wkU+snqXnZnP+5xWLBadkgf0XC
X-Gm-Message-State: AOJu0YzN94huC3do+kwAyxtwQEGnJDeA5F3L4aTzeo7U24Rdhrb6v0bS
	++YFiHU56guYvYl+pLZU/sZdSIgbIJ73xmkBM03eeHJvynSE/fjVh44OW2A6aw==
X-Google-Smtp-Source: AGHT+IFkjqEo9WYWh9uwV7qW8tTZm/X3G1itWmwY9D+9DsKXDmdQqm31owW8ZokBAn+BbbDZkcRWnw==
X-Received: by 2002:a05:600c:3584:b0:414:daa3:c192 with SMTP id p4-20020a05600c358400b00414daa3c192mr213991wmq.0.1711634343417;
        Thu, 28 Mar 2024 06:59:03 -0700 (PDT)
Received: from google.com (248.199.140.34.bc.googleusercontent.com. [34.140.199.248])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b0041469869d11sm5499477wmq.47.2024.03.28.06.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 06:59:02 -0700 (PDT)
Date: Thu, 28 Mar 2024 13:59:00 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, qperret@google.com, qwandor@google.com,
	suzuki.poulose@arm.com, tabba@google.com, will@kernel.org,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH 2/2] KVM: arm64: Allow only the specified FF-A calls to
 be forwarded to TZ
Message-ID: <ZgV3pGvUhaK5otUL@google.com>
References: <20240322124303.309423-1-sebastianene@google.com>
 <20240322124303.309423-2-sebastianene@google.com>
 <Zf45eDs8Bd1UQ94Z@linux.dev>
 <ZgFgI0Ky2m4MUbw-@google.com>
 <ZgKKcurtndJaIwAV@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgKKcurtndJaIwAV@linux.dev>

On Tue, Mar 26, 2024 at 01:42:26AM -0700, Oliver Upton wrote:
> On Mon, Mar 25, 2024 at 11:29:39AM +0000, Sebastian Ene wrote:
> > On Fri, Mar 22, 2024 at 07:07:52PM -0700, Oliver Upton wrote:
> > > On Fri, Mar 22, 2024 at 12:43:03PM +0000, Sebastian Ene wrote:
> > > > The previous logic used a deny list to filter the FF-A calls. Because of
> > > > this, some of the calls escaped the check and they were forwarded by
> > > > default to Trustzone. (eg. FFA_MSG_SEND_DIRECT_REQ was denied but the 64
> > > > bit version of the call was not).
> > > > Modify the logic to use an allowlist and allow only the calls specified in
> > > > the filter function to be proxied to TZ from the hypervisor.
> > 
> > Hi Oliver,
> > 
> > > 
> > > I had discussed this with Will back when the feature was upstreamed and
> > > he said there's a lot of off-label calls that necessitate a denylist
> > > implementation. Has anything changed to give us confidence that we can
> > > be restrictive, at least on the FF-A range?
> > > 
> > 
> > I remember your proposal for having an allowlist instead. The current change makes
> > sense if we have https://lore.kernel.org/kvmarm/20240322124303.309423-1-sebastianene@google.com/
> > which opens the window for more FF-A calls to be forwarded to TZ.
> 
> Got it. Last time I didn't catch the level of abuse we expect to endure
> from vendors, but now it seems we will not support non-conforming calls
> that appear in standardized SMC ranges.
> 
> Adding mention of this to the changelog might be a good idea then.
> 

That's a good point. I didn't create a changelog for this but I should
add one and specify this.

> -- 
> Thanks,
> Oliver

Thanks,
Sebastian

