Return-Path: <linux-kernel+bounces-117916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1579B88B399
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D4E4B2D63D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C29D45038;
	Mon, 25 Mar 2024 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L+RWwUSs"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCA843AD0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398215; cv=none; b=nipLDxvX8tEnbi8qIlB/u5Ir5WciEWhY2coHmDZdv/ZdpCd/eJDuv6KooQbCHv32bL2IrwyQmmYleT+76NnTp5btm3YoVOUN8nJQJcVVa8yC5wxHan/a1166I4LvJuDIvchrEzp+HE9sYdY8WzBvWm3QAne/vjOrTVAuPqKPMH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398215; c=relaxed/simple;
	bh=djlD7tau3k00wMX+dK31hRg61bxmwmEQAIExPL8zNcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeJ/CWQvyeZZJViUXnnl1FJkUwEdgEqJkigOsmx7M47uFRmU0G7GiLsiKznnuIy2F475C/7tcyK/nAmwCnoAw2vExH4qa3mul+hFA+BHaiwiFPQ0ja4PAgoLBdk5E+M9RDoDTNg2rHDYUz/Gu8Uo3Lk0FEoVDQZxCsHdY2l/JM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L+RWwUSs; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29c75e348afso3449334a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711398213; x=1712003013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dM3EPEaKQfGkhSj0Etyez8qPrSpeJ3+UqIPmySxZhp0=;
        b=L+RWwUSsyNMEqkcu+B1y1TWbc6N8k3asGKBTd3jSvcVSWaWh5QHmzNnRh4JLtZ4xfV
         EXO84RL21FM3LQB4tlp6DH8PWJ/DvMSSRx44JC8tzlWW2yCT+QtgAXEKZR+hvPXHsMnU
         xggX5F4Q4odPv/gOZQ+qD3Sdqlixb/GKRGH2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711398213; x=1712003013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dM3EPEaKQfGkhSj0Etyez8qPrSpeJ3+UqIPmySxZhp0=;
        b=QxEyRY9q+akDmQPzOBKfO/np0uCVGN503CD55jHqFZHcq2aHoX6sOWiEqF5USXos3o
         9wLD6843IlklEGlAZ9uy3g2U7E399K2yNsH9B4hDiRyw6S6Ivl24GXtngEq1XaGnAwKw
         ROFyTVVPBhFz5KolT/NepP7SUn6pkMI1ztOA5bQ2GN8Ob3LVPSjB4Q2P/01Hnq4vfObK
         KcX1F9v1lrPT0k6RwgtVTwq5ktGinxmBj8Y4xMsBVbiQfDImT5gHPfpdOm4/nVPxHkb4
         Z9JtHfKNylqunXy3U3cQScUuXQIKRaYsUy50ZuGA7EFmctvcdXSgtBbyqeBP6njD3MLf
         BRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHs2EmxPYKzT/UncZdW1aFe0uSNoJTzDVK38wCW52k0a7AEIJwwKRDAAH+ebgyVLucVIe+mGv7F4a3W79ZxNl/m0f26wJYHLJg0Zfs
X-Gm-Message-State: AOJu0YwyiNk5CBCisatKHQqoaNhS4QtSYChSLxPRMK+XjrtTXA6dJmT3
	IDyKMZsQqn5j0fHoMz4SZF90DYMWhzJCI7y1cP+Ej3wQ7H8Pnrs0Y0zbU2p19w==
X-Google-Smtp-Source: AGHT+IHFt/Mv8XMPx3PmeNEQzhnSPIf0PbzFwS8Yi41rpSzdwhBsUhVQrNgbrGh4nSZ3MPE2PseKBQ==
X-Received: by 2002:a17:90a:dc06:b0:29f:ef34:3004 with SMTP id i6-20020a17090adc0600b0029fef343004mr5745538pjv.43.1711398213361;
        Mon, 25 Mar 2024 13:23:33 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ph13-20020a17090b3bcd00b0029951d04dc4sm6840886pjb.54.2024.03.25.13.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:23:32 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:23:31 -0700
From: Kees Cook <keescook@chromium.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, Guixiong Wei <weiguixiong@bytedance.com>,
	jgross@suse.com, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
	gregkh@linuxfoundation.org, tony.luck@intel.com,
	adobriyan@gmail.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86, relocs: Ignore relocations in .notes section on
 walk_relocs
Message-ID: <202403251318.EA2603C8@keescook>
References: <20240317150547.24910-1-weiguixiong@bytedance.com>
 <171079804927.224083.15609364452504732018.b4-ty@chromium.org>
 <20240318215612.GDZfi4fG52DTgra51p@fat_crate.local>
 <202403181644.690285D3@keescook>
 <20240319081640.GAZflJ6IBQ7TEKD2Ll@fat_crate.local>
 <202403190955.25E5E03E6@keescook>
 <20240322194658.GCZf3gMphnWeR9upN6@fat_crate.local>
 <202403221622.6EA43547F@keescook>
 <20240323103827.GAZf6xI94u8F9LGBIL@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323103827.GAZf6xI94u8F9LGBIL@fat_crate.local>

On Sat, Mar 23, 2024 at 11:38:27AM +0100, Borislav Petkov wrote:
> On Fri, Mar 22, 2024 at 04:40:11PM -0700, Kees Cook wrote:
> > The earlier patch, commit aaa8736370db ("x86, relocs: Ignore relocations
> > in .notes section"), landed via my tree. It was sent out on Feb 22nd
> > (v1[1]) and got a suggestion from HPA and a Review from Juergen Gross.
> > I sent v2 Feb 27th[2] and it sat ignored for two weeks.
> 
> s/ignored for two weeks/missed in the avalance of patches/
> 
> > Since it was a 10 year old kernel address exposure, I sent it to Linus
> > on Mar 12th[3].
> 
> So is there some unwritten understanding somewhere which says that you
> should take tip patches through your tree?
> 
> Maybe I've missed it.
> 
> If there isn't, should we agree on something?
> 
> Because there clearly is a need for clarification here...

Yeah, happy to figure this out. How should I handle x86 patches that
maintainers haven't responded to when they have security bug fix
implications? For all the security hardening stuff I usually just ping
every few weeks, but those don't usually tend to be urgent.

In this case, I felt like since it was a trivial fix, HPA had already
implied it was a sensible change, and Juergen had reviewed it, it seemed
like it wouldn't be disruptive to take it, given the timing of the merge
window, etc.

-- 
Kees Cook

