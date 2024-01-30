Return-Path: <linux-kernel+bounces-45100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF83842BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04B41C24A82
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B1F1586FD;
	Tue, 30 Jan 2024 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XYdxOR83"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3131586E6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639004; cv=none; b=mjhpo1VUvx3E1FTj0z9xMoAjjSEaMZO0SNVahdMbhCHi1o96JzNiGIgCc0OHaZdlbBMV9c+lfhMl2YAt8Qy4yRmCchNgqJx+axyMXS7smE1ziOdJxnz74FvINSMtc0AFB+m+l2ALZV18KUxsaZYddCoHndoVGkcG7U6urM6bTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639004; c=relaxed/simple;
	bh=tFEQWdC7qrSSJgBCf20kPWPQDzbsJc6pm+yZ/F2PHFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9AtL44WjImmtXwO5AjeFb5K8nGuSQiYDGzt7NaEeN41kUPd9Lu7wpsp05DOLTl61VYIX+SJA4OzULMZVve1sd/s/Knv2C++7VvSw/223xW9Eh3YqpYRjjoPvYHGpja7EwwNvn+I4569HhYtunUdZndFIeTTRL9EqU5ukTf4+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=XYdxOR83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80550C433F1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:23:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XYdxOR83"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706639001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1sYTIAW5AD0V6cAd7FYqCUf83efZ/AKDlxt6jV+ahg=;
	b=XYdxOR83o3fjVUXRBl2LHiTynqtTjbuyX8Eem5XyqKjN+YSj3Byfn976C0o7ZoHqEblhO6
	I3LBkfUibJxhG5ki09Ye4Z5Gd8YFqEoZEPd/ywIn74nEhlGIGg4GgK+VGLxRz2j1FtBaat
	j0wIzUyd1RAAQRd+PViJfiobx3nIgfU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2a289956 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Tue, 30 Jan 2024 18:23:21 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6002317a427so35468667b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:23:21 -0800 (PST)
X-Gm-Message-State: AOJu0Yy8JJpQDew8P9p0Qvp+4AVSLv+bCq/PBumOW82nFOYy02irNrxY
	ZG5dAIa+VeYbe6NiQvmtZnotDbpq19HJxfZ71J4SpFx+kolvY7yIM/9/d45lnAdMGl9dPZZUj8E
	WhLatgcF1ClaRcwv/zMtl5SvzVQ8=
X-Google-Smtp-Source: AGHT+IGi+WlDvpLs2+MvJdIHiXkSf7f0bSNRyfDDxLgLxGnU1DguC3rTf0plwcLWwoQNFno4Xm7PUCK5ZV4FyiWGbrE=
X-Received: by 2002:a81:8a85:0:b0:600:11f6:2c28 with SMTP id
 a127-20020a818a85000000b0060011f62c28mr6977021ywg.37.1706638999894; Tue, 30
 Jan 2024 10:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
 <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <a076974c-e2c7-43c9-9858-71c913361cea@intel.com>
In-Reply-To: <a076974c-e2c7-43c9-9858-71c913361cea@intel.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 30 Jan 2024 19:23:07 +0100
X-Gmail-Original-Message-ID: <CAHmME9qEaJvaV2OVhpqPNnu4YmD-GgbqeePZPjZwA-XiHkeTmg@mail.gmail.com>
Message-ID: <CAHmME9qEaJvaV2OVhpqPNnu4YmD-GgbqeePZPjZwA-XiHkeTmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"x86@kernel.org" <x86@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Nakajima, Jun" <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 6:58=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 1/30/24 09:49, Jason A. Donenfeld wrote:
> >> Anybody disagree?
> > Yes, I disagree. I made a trivial test that shows RDSEED breaks easily
> > in a busy loop. So at the very least, your statement holds true only
> > for RDRAND.
>
> Well, darn. :)
>
> Any chance you could share some more information about the environment
> where you're seeing this?  It'd be good to reconcile what you're seeing
> with how the hardware is expected to behave.

That is already in this thread already. Maybe catch up on the whole
thing and then jump back in?
https://lore.kernel.org/all/Zbjw5hRHr_E6k18r@zx2c4.com/

