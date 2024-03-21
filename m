Return-Path: <linux-kernel+bounces-109826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FE088562B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34D6282853
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6C63065B;
	Thu, 21 Mar 2024 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJiYw/tB"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061412B81
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711011914; cv=none; b=pjURebPsktZoiVKcMdkBJwF/G/F8N8GTvyU8g2TEQVCEdyzUkbISR4BjP+b9KSubCph1rfc6ed34zgvdqt7n2YKMJ2FXST65eRNOmkYvLAuZ2qAh+DCWf0dhBX1yO1TNr51nvClypAkyf39fdLHe90Uf3id1BQ0t7lRDFG7eTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711011914; c=relaxed/simple;
	bh=RbLg7MaGJOGAFV1mwvCqAprC6ZR81N7GmJHstjv4J1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOoUZUrJOhQNJ1LLRtmBRoj2gTiPDXcc712yW3leSnpLEViM3bYJ4sxmc/obAqqevN7e148HHgPH57d6ytXxvMS7THrCbNmmER63VUxoTmABarqpzmJKm+tXQyzYAwdQ1lcSFFup6dkgVBy6ye2xbvkCd0gsJ4kuP/ExZ1yVEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJiYw/tB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3417a3151c5so338364f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711011911; x=1711616711; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wMfCNckqVrAsywyGK5R6R9q4bGSZNnDSiYwDwMnWypQ=;
        b=mJiYw/tB4Hq+hvoGw4xb8TSxmND/YaTrXS6F/5fM4b1yIpVrq7z1wGWY+CnWZ9980y
         LUAfngXERB2u2yaVIHUS0dlPeONbfOJyMkxE62FPJptksBGpF3k2Fw18LZgFgUPId8Le
         aH8T2+2lm8Q/if6npCaYLePH+A77hLR9Fef1EYkJgpQorFCLgdF5vXZjwmMpyq96cIuN
         JHDT972xyl/lHxv9+pck4m9udwPEzEvmla+8dFAfEeCNBIeGqk0jScp0q0rVDdj8YYAd
         v7+SLVyrk+mYA4u0IX8Qjb//Iotz3TqkqVdp1GFt0flNQS3Bqu0LksneZwtnaKqmTDeI
         5XlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711011911; x=1711616711;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMfCNckqVrAsywyGK5R6R9q4bGSZNnDSiYwDwMnWypQ=;
        b=vZqJrxWe0Q2CwJYyDg0DALY0J1TNXFl1OWWCQGY30pv0WawWjzRC0rFKKl38W6Ojqi
         /81kLmZsFbBc/3IhNxbOnLQWmIHT0+Bg9Z8fseXQfmhQuqDjPO+NJ0WnQOOxXaCVX18q
         YKA7EY0K54LVpOvRSmGrZPMmebpSJD4TMe4YHopNvQ2jsvgvn8Gel+vMYbpK/wJ/f4aL
         E8BauNdC1gJW/QW856TOp6TBHx8r/ubXBptKZrPifz4IPw7/PZy3IziltGzXVpvK54DH
         wIEdqb5KBm43YTCirBCxPbWnJ04lxid1XJcx+z9QxxI7H8GSoB2h7QK9h2bsblO31+xB
         QKWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFNTMFDTNGy77nNsmhPfBvbElAaWIRQYNr6M+is9lwkLrxLjrfSHB+Hx0HtJgjNAwghhy9DIEEGGIXvnfBWQrQua9tn0fESeiAJ+l4
X-Gm-Message-State: AOJu0Yx8mjk/juNpz1QiqbAGNtSexUjFvudmg0dsJkdkjmjBnH1C4nFW
	+pjdOisBG6kXwGYcLYL28lsc/bU2dEsfR+WsvyiATzI9BWFiOeve
X-Google-Smtp-Source: AGHT+IH+ROSk1wmGVxObe+F0ZhpT6q9s51tpK3sDwL+XsxPaqJXNv5PR0KUhiyT+WBMNX8iI1yqgtA==
X-Received: by 2002:adf:f38f:0:b0:33e:69a5:68f9 with SMTP id m15-20020adff38f000000b0033e69a568f9mr5375345wro.17.1711011910984;
        Thu, 21 Mar 2024 02:05:10 -0700 (PDT)
Received: from gmail.com (1F2EF04C.nat.pool.telekom.hu. [31.46.240.76])
        by smtp.gmail.com with ESMTPSA id z18-20020adfec92000000b0033e7de97214sm16642393wrn.40.2024.03.21.02.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 02:05:10 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 21 Mar 2024 10:05:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Joan Bruguera =?iso-8859-1?Q?Mic=F3?= <joanbrugueram@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] x86/bpf: Fix IP for relocating call depth accounting
Message-ID: <Zfv4RGwe5+h0zNI5@gmail.com>
References: <20240316232104.368561-1-joanbrugueram@gmail.com>
 <20240316232104.368561-3-joanbrugueram@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240316232104.368561-3-joanbrugueram@gmail.com>


* Joan Bruguera Micó <joanbrugueram@gmail.com> wrote:

> The recently introduced support for %rip-relative relocations in the
> call thunk template assumes that the code is being patched in-place,
> so the destination of the relocation matches the address of the code.
> This is not true for the call depth accounting emitted by the BPF JIT,
> so the calculated address is wrong and usually causes a page fault.
> 
> Pass the destination IP when the BPF JIT emits call depth accounting.
> 
> Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in call thunk template")
> Signed-off-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
> ---
>  arch/x86/include/asm/alternative.h |  4 ++--
>  arch/x86/kernel/callthunks.c       |  4 ++--

For the generic x86 changes - I guess you want to push this upstream via 
the networking tree:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

