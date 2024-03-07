Return-Path: <linux-kernel+bounces-96193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AEC875855
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41A11F21B19
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6C81386CB;
	Thu,  7 Mar 2024 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gIvHZBzh"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85E7130E48
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843270; cv=none; b=LmNvVuH0wHy1L2gh68e/zrp4bOiSG/Hdy4bCsMS1Y2mhbJqr0gyrFD4AXQwHiJ6pcmdGtAN2viT6+RUYhI5Xui6+09ewmyd6J5tU9ukwDib+bx3fxtPqnPA4fAP3wwX2Y+2Y1yT9vYlBYuWvtB6FzMiITD2s4KvmAUOBzwCqHLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843270; c=relaxed/simple;
	bh=PpJyDwWIL2vSG+aCO9RrwWN5pozRht5JZlxyvyX4U10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hQNrijQ2gZoOqezzFyk3fWGxbRBL6F8g8hG97Lr76h1tnR/PUsxWNX4kzwIkPqN5LWlJBptlXI6Y8iTkcjLJesx1r66xWwDzDrMCcw1Ii2E4Is7duQwcgyKcaYsOqlNDOOpdFn2+WlPn7h/DtGi5ecQ0aEdbm4IfYU7kQRGha3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gIvHZBzh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609a1063919so24852997b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709843268; x=1710448068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=chSC2pZv+hcOkTZmm/t1zZxe+FTdRWOu1T96ZyxWt3E=;
        b=gIvHZBzhTC4J88q7LQ6qDBeaz+k/DCck0wkP/wH3d2Aqu446h16FckxFyhP6DnC+36
         OkLL+vnVbL1WOfFQI3QEaA9JYq5AbC5zlBI/r2KkTqjKYiBXDKziqGXgFmV1vi/pixm7
         bGh+N0FtIBs7WxT6jXaKDXT8Z9Z3/XBXkMk+lh5b/L7x67U7FFlgeDk4bZP5mm0oNtYn
         KSWHEcxw+0HWpXk3kBKzojH1e/igsLWDy9dYXppt9LQZ3/P/z+srRVHcb4+adR5OHWYK
         DtNKfos4wGIJgG0khJG90mHGDC3lDfoPjreOUM5mqvsQRJcoxtCvF5W0FLXFQNqD7gJE
         Tgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709843268; x=1710448068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chSC2pZv+hcOkTZmm/t1zZxe+FTdRWOu1T96ZyxWt3E=;
        b=lC0R3gSGB8OipymjrRp3cTCIwRBESs9j7AL49iUr9KouLS471ViRY9+aOtMwZEJWOJ
         qcS5C9sk/esZPHh4g7upjU287DLlCOTFmOPbRf4OhvkZHArmnvs6If5f0TYV8MCFrwUa
         CU09zwgA6XhMfLZxc27Ffb22DyyssJXdugRymz96OpwJUCwumlokCj7ZlR1jCWvAfvoA
         14CTaRwxmyy4zbfU3byGh+xeqocKujLkf5jGGVNS0D+V0rb3AbR78+lICWrMVqJ62PA9
         Q0JF/dGFGsi+5MIg1T14HLDP5d2Wovcrxhb+RW1NgwfmRKE3Kt+B507FweA+zHVoQFRC
         RhSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS9fuyxvLHG8lw4Vsgzl8FmmuD44Pt9I9Bh+t5Ymwn15uQdApfMwyL+guaix4or/oELW3EJUgtS6Awc1RilfKrUW5Dcb9VdNy7Kmow
X-Gm-Message-State: AOJu0YznrT84EETCYdxJhI9PlfbRmR9DqcmGcXssIrJGGy0jn8C08k6o
	aJZcxaKE4+H7Ncf4vXoQpDU4jayWVJKxiOOoOlAv2oJsQe1T6H8rgHkK3SO+CnruV0x5lgq0zlQ
	hooFWbHA0XFkFU+LvWg==
X-Google-Smtp-Source: AGHT+IFTT1OGsSLJa8Haf9ZMonPRGBBE0gN7hzSylYNaonZDzLqJHga59YTrDvVijT48cQtbb9tyXsm2dRp19qFP
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:3702:b0:608:1b39:245c with
 SMTP id fv2-20020a05690c370200b006081b39245cmr5389081ywb.9.1709843267801;
 Thu, 07 Mar 2024 12:27:47 -0800 (PST)
Date: Thu, 7 Mar 2024 20:27:45 +0000
In-Reply-To: <j3zncd7dxc6kzk5sdytqulkk76cluq6zctklpasa3y4ig3vwku@ibabr336aqv6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-4-yosryahmed@google.com> <j3zncd7dxc6kzk5sdytqulkk76cluq6zctklpasa3y4ig3vwku@ibabr336aqv6>
Message-ID: <ZeojMwHh8O73bw23@google.com>
Subject: Re: [RFC PATCH 3/3] x86/mm: cleanup prctl_enable_tagged_addr()
 nr_bits error checking
From: Yosry Ahmed <yosryahmed@google.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024 at 07:31:44PM +0200, Kirill A. Shutemov wrote:
> On Thu, Mar 07, 2024 at 01:39:16PM +0000, Yosry Ahmed wrote:
> > In prctl_enable_tagged_addr(), we check that nr_bits is in the correct
> > range, but we do so in a twisted if/else block where the correct case is
> > sandwiched between two error cases doing exactly the same thing.
> > 
> > Simplify the if condition and pull the correct case outside with the
> > rest of the success code path.
> 
> I'm okay either way.
> 
> I structured the code this way as I had separate patch that adds also
> LAM_U48. But it is unlikely to get upstreamed.

I see, thanks for the context. For now, I think this makes the code a
little bit clearer.

