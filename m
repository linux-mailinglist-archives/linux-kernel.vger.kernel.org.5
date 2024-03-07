Return-Path: <linux-kernel+bounces-96362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D49875B08
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA9F1C212AB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C94D3EA93;
	Thu,  7 Mar 2024 23:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICptk1FP"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E78339BF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853725; cv=none; b=Oy8tkiPbIMWq8mMHEF7MsOUCrkTcYSN9Q1xqIRB4dPrzISAAFQftz0nfvK8st3k/qL5sg+yk5TNdMMBcD60lBRR8/LZo+4I9bqSfTSx4XfQ8RunRCxCu/pKa3Ym6tIHoh+J6RreZ3hjxnL98leSLaCiWm2Q7DeLKHKWuV3ux1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853725; c=relaxed/simple;
	bh=FIppr601zKlJPo7n//Aa9KFNnMCMYv3+aWfxsYfg6kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIuf8g2tJu2iCcLFwFIuPHNIPxpFpX4VeJOc8Pvz2ElS6lLK2E0/1BHTz2xuNW6qaSUGEeYHgWbQ6IEPO+DSB2VilIiYqLaS/FoHEwQTHQuX/GWTgmeZKA7acjeaI/wsvWz+Pahkx7BLejS9Fh7vRoQEmD/XB0cEYIpCw1yMFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ICptk1FP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a458eb7db13so221443366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 15:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709853722; x=1710458522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FIppr601zKlJPo7n//Aa9KFNnMCMYv3+aWfxsYfg6kU=;
        b=ICptk1FPbdyzlonRog3ZwAdVwDfl5awMLEGrcHvtKAsHMdOYKFOJepLkr8+OOvIrIi
         UPoLFr1OHO3Co7eTgBqofJnRDbg7mx/SM/4unEfji2ODFFAv7qOBb9fn33mW9fIMSGTz
         g5KeRczbwUTXVwcmn7/67XXTW8OPespLbC9rs7Dy6C3TYYCN3vfDb89Nc/HsPldAzNc+
         T7N01aB3rGVNGWCaAfYWtIxo8ArURngbwN+KJ0i8wX5gJr1TrR96z5+VcX0IilxRu4Z/
         mUFGkpg/+uvrIQ8wU3Zv09cNltD4Q1srbUZUffBYVhfYKAa81nEvrtOU6JpZ17tehekV
         fQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709853722; x=1710458522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIppr601zKlJPo7n//Aa9KFNnMCMYv3+aWfxsYfg6kU=;
        b=uwZufCMJ2fwXr53Bn+/emRG72bbYjy9X+cu1x7VdtG/76Rjw/2ZgrkOsJlc4ZH0kIO
         hW+S1bk7wKfZnOJv5jZhtXoEf7sU7/DiwJo70eVkXXQCbS4UIf3A3K8+nES+8UYIbDrb
         yPsKD2GHk1IggQreOBAB2l7vpvqStDHtYUzXGDqdmC9LyyljLLhnrI2coP8aoQH/FZs6
         ufGGlID2my94suNt1u2uL5ocfxegFjaeELhmMaPdrseAKPelnoC3oksohYzF2cPVqIN1
         isfpl073dsaUIiBH3g1T8iy+jeUr+O6UxHhQ0c4QJhuhMx5AK1IgPCkktiX3TB2nDDCv
         AkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkqOWyybyg5fJTIBQw/1mJU/bw+G6BbqOCXt/26hKw8YLWu0/Hm9HTGAR9czby7Gi3tynY/nbEkc0v3/7nz0c7i2NrPMpe6p937D9K
X-Gm-Message-State: AOJu0YyogYbS0KJcY9FV8BFIfFrFI9cgO8zBqhN2qt+mA7MhGj8M9jd/
	BfUgVbjNms9kGTbq/t9jSwUgvgiBSZT8pZ36OZPrP1+POUaL+v4AOFOy+hHXGYMoEoa6gAQrMjV
	sXaDShwcNno7XMvpyGGd4Gwo4t+fjrhyZPFWB
X-Google-Smtp-Source: AGHT+IGs6cBZirSbIjDVHagkMHbZEIBy3LYPTmRSjlILDsGvjPP4a6urpFSh+hStC25URtHHhZOTzlOc7ZAG5uvnF5I=
X-Received: by 2002:a17:906:340e:b0:a45:baeb:3b3f with SMTP id
 c14-20020a170906340e00b00a45baeb3b3fmr4240984ejb.25.1709853722062; Thu, 07
 Mar 2024 15:22:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-2-yosryahmed@google.com> <ba8a51fe-7b22-46b1-be5f-1e4c837d085c@intel.com>
 <ZeomquHvZs9-BKKK@google.com>
In-Reply-To: <ZeomquHvZs9-BKKK@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 7 Mar 2024 15:21:26 -0800
Message-ID: <CAJD7tkZMiRDF4jXK6yQh+cZdC7uJsTMfAXrPaC0TkTFQCoe7Tg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] x86/mm: fix LAM cr3 mask inconsistency during
 context switch
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > The "set_" naming bugs me in both of the sites that get modified here.
> > I'd be with a new name that fits better, if we can think of one.
>
> Is it because it's not clear we are updating cpu_tlbstate (in which case
> I think update_cpu_tlbstate_lam() is an improvement), or is it because
> the function returns a value now? If the latter we can put "return" in
> the name somewhere, or keep the function void and pass in an output
> parameter.

Or we can avoid returning a value from the helper and avoid passing an
mm. The callers would be more verbose, they'll have to call
mm_lam_cr3_mask() and mm_untag_mask() and pass the results into the
helper (set_tlbstate_lam_mode() or update_cpu_tlbstate_lam()). Another
advantage of this is that we can move the READ_ONCE to
switch_mm_irqs_off() and keep the comment here.

WDYT?

