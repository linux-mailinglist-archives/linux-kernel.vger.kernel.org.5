Return-Path: <linux-kernel+bounces-103928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A808F87C6A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49255B21473
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD07428E6;
	Fri, 15 Mar 2024 00:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Chv9uULO"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800B1870
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710461098; cv=none; b=rJVfR/jThlvCuKuCjwTWwgbmYVMr7NHxT0m/rtpLT6Upj6fDbO3X7Ug9KqZqBWel8Kxi8vLt72wrMr19tk75zfPRGvlmxdcJqo3oUMqMjzWMKwjPDZbTVuFNTbGsVhSSbPC72Y2I6TymiCyBYuTTl+oBjkmVpAf4/kE0b88zypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710461098; c=relaxed/simple;
	bh=lZxH4qDoOuSKkw34WohIqvnRKcz78paoufgDSVaeres=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jl3OFsnYJhyPgmAfY3tyspaKn+0eWUrzHIoztpVopAOmo9Z8ykRnXTs8PszzDnQ2KkW5x2v2+j2jrRoLBELefD4aq6r/4gWyW6L0LxZrcWfL7lEVML6FE3Q59xkg9f0q9Q0z4wGBDISNBRZ8AYuZbq7UUcLZVAEV62FYiSowW/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Chv9uULO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1deddb82b43so84585ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710461096; x=1711065896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaLBA6xE/xcwIs3I7VfamqyjFNC18Y8qVrSwI7Sizo8=;
        b=Chv9uULOynZTPNgZrZCf08uzllQEyeUrU6G/fSFMEVEHk6qPql29JgradyQit1XHNE
         H8p67DqE2tCOof8Dq+sw5tHCGZFcNs6o+WY0A6jl+tUcRBjNAQKz/3YIU21RgadFSAQA
         LJTbhOIzUeIaKSLq2eaoYpOWfAko9bxcWB+d8K7Z28s7OhIEZsqzhNicLVTEXeWkE7Bz
         ffTUrNnl3O2ppRnFA8LnDJliLnXbYJbYZS1Oq/lirEP/If0Y74GHbRGad1CCQJ/RhxDD
         TiiOBg7qyBXJ1bVQiRBM0X4SUDdV+xbknFE5PfUx7gUZLzjlQw4mAnXJnGAUZMu8tYRR
         HcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710461096; x=1711065896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaLBA6xE/xcwIs3I7VfamqyjFNC18Y8qVrSwI7Sizo8=;
        b=dvhNmS6LjltxyzGqMRspWeUbl0q9QqU55uRWz2bVEfqHshq5iFkfxGLYt1lDjqAEb6
         RO61Pk9sgc2EMvLRblF6+HtSI61V3UogTZpEFeo7fwMBsGwYRgUaX0S4ZAKtejyWiXwT
         1XCLgu9ITm9oxa852bpZPumCi8INDrrTgMwhYSCU/u/2hoCJ2ZPj48SaU0+Hfe8FzO1d
         v899yw2AKDFJFTXViPJmdZ653Bs6vFg1kBHkrVNugxte3752EZJfBPZuhGNIlQqxtiPM
         fTXJHcRYa91Wtsp9TaX27cs6yJO7SD4sA6LAzbV+ORTUE2nYtsKnG8k9AQM50UhZmcZA
         POcw==
X-Forwarded-Encrypted: i=1; AJvYcCU44QLXNX7Ebye9mvyaMqkPm89GKgwJgbtXbZt0TBuIGQprtsSqKIm6ZIEKmyaO6KB1EnYQuPORIasqAU0PCuoY+Fg7rCMVSryrRWhD
X-Gm-Message-State: AOJu0Yz1q11lbgbIGFylX1/1fkpj6kJAlnWE0v2+GmAoxJXVxPdU+yOX
	wdZwn9yuZJjl9Aa8K+I6byyHtwfRH0am7+9hniVjrhhKQJICjOzSCAgcb+SmmYFWfqp6QT5mORR
	tyr7XiaSW+864d3e65iorT9zFjsfcuFw5wGPE
X-Google-Smtp-Source: AGHT+IHUwvjlGAsabpVqnTTXLxe6zN9TQ5kg2Phormp+5yVyMiu7aaYDAigienoyIOLHTQBLZHl3y/XRow1pJsTHL6A=
X-Received: by 2002:a17:902:ccd2:b0:1dd:7d67:dad0 with SMTP id
 z18-20020a170902ccd200b001dd7d67dad0mr75463ple.3.1710461095800; Thu, 14 Mar
 2024 17:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312075349.977-1-rex.nie@jaguarmicro.com> <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com>
In-Reply-To: <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 14 Mar 2024 17:04:44 -0700
Message-ID: <CALPaoChnAt9+2=iVzpownX-bN+mb3Ujn_C=_QS2qsAph=LPSiA@mail.gmail.com>
Subject: Re: 32bit resctrl? (was Re: [PATCH v2] fs/resctrl: fix domid loss
 precision issue)
To: Rex Nie <rex.nie@jaguarmicro.com>
Cc: james.morse@arm.com, "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Borislav Petkov <bp@alien8.de>, fenghua.yu@intel.com, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	Reinette Chatre <reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rex,

On Thu, Mar 14, 2024 at 8:25=E2=80=AFAM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> +x86 maintainers, Tony, Babu, Peter
>
> Hi Everybody,
>
> On 3/12/2024 12:53 AM, Rex Nie wrote:
> > Below statement from mkdir_mondata_subdir function will loss precision,
> > because it assigns int to 14 bits bitfield.
> >       priv.u.domid =3D d->id;
> >
> > On some platforms(e.g.,x86), the max cache_id is the amount of L3 cache=
s,
> > so it is not in the range of 0x3fff. But some platforms use higher
> > cache_id, e.g., arm uses cache_id as locator for cache MSC. This will
> > cause below issue if cache_id > 0x3fff likes:
> > /sys/fs/resctrl/mon_groups/p1/mon_data/mon_L3_1048564 # cat llc_occupan=
cy

This domain ID seems unreadable in decimal and I'm wondering whether
it's the best value to use to identify the domain. Does this system
have over 1 million L3 domains?

Thanks!
-Peter

