Return-Path: <linux-kernel+bounces-40753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E7583E54F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC601C24CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C4725631;
	Fri, 26 Jan 2024 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kt96DcjK"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9CC2511A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307849; cv=none; b=KOEBqpdohgfKn3XSU16EchBh7H5tJd/KqR319PWZQ6886mIYHI1qqQtIDEf7TxWOwm5HveiyBsj/1lL08u8CRQsa3+RvHWbpvlWL8UttM8lG4LSkrvTyVlI6Q7c5sMpdFDut0P+h7I2EiP1APWhXoGsnPjr3wBN6UGVT6mkaIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307849; c=relaxed/simple;
	bh=SsDgh1/qxxOxnOUHCoY8liFdv/cFob22r3vkkHPCNeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdR/8aEj14a6rPB5lE/5KAdueKqJwdebFyD6WXfXlgsG1LvumVorUZqOG2VWtxJu5p8DAr8eZAI/Yad2xizAR9XX4sPQhxhYDm+4e0wLse6rwbYJ+xoHEvNs2rraWjxfmbAcsAejHjXljpD02zmFwKgEM57fitc27qzYt9nwhmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kt96DcjK; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59a1948acf1so165192eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706307847; x=1706912647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNjTDm/3nOOc9T42E39x/f5ugwNL2q1NFWZyO0YlL50=;
        b=Kt96DcjK3cfx8NVJMZSKaS2+OmVa3OLMqxLSpQPJXFc5+eG5lbFEHgHJRH5OIX5hYg
         hhVTCs4Tn7K51YboRGX+6cdlTc3zAnfcoPK44BSQ9C/hyy3T5VZjBhmAI2mD3ShAuyFq
         ebT29hesbCSJnfbJy0Ii5IJIfroKF04a6oTRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706307847; x=1706912647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNjTDm/3nOOc9T42E39x/f5ugwNL2q1NFWZyO0YlL50=;
        b=mxiZdqc8rHQ9zRciq0Umjv4sd4VkdPQOuco2lIk3oiRjnqM0AL+L95I1Y3344S84xp
         WExhoIWW1LLeCvGWeWaHOMXmscfSTVH2DwYgvioneqqyYLz8PPhal06uR2jVQaLHB+Mr
         P7x6xHzXFtHh6d5HjxpprB+kUdICENVM1viYBIxUDg1aK+GPR3hvePa0hlM45zDe20Bq
         kGMF9VkvuKch7Rl31gB3bcnxM1WszBOsGu9ObJtWS5NaPe/IGnPpkXMevoNi6T/pYcjJ
         cRSrK+mKgc5GQMRZBxDJH2/t5gmoNcxJV1h/yKkHqGAJRdF4Vw9AzIu7CiM7ucAcz0rP
         yz8A==
X-Gm-Message-State: AOJu0YzLAeluEydgIBOPtyppgyRAcymHXdJ8O95d5VJ7F8uH6nqGtPTW
	dVu0kmmluBkcBwjxL1J2e0dKUxhq4TZHWxC5HnsXGKCUEkMJtLV76ZNGMiSXjQ==
X-Google-Smtp-Source: AGHT+IGEnDcQTS7SnNR20li28GjLAf5EqupkVycmod63G3cSQkdng4abOodjIVFtLG7ZlpnwuWu1PQ==
X-Received: by 2002:a05:6358:52c9:b0:176:cdb1:4414 with SMTP id z9-20020a05635852c900b00176cdb14414mr453949rwz.18.1706307846694;
        Fri, 26 Jan 2024 14:24:06 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p17-20020a056a0026d100b006d9accac5c4sm1602142pfw.35.2024.01.26.14.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:24:06 -0800 (PST)
Date: Fri, 26 Jan 2024 14:24:05 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Enable -Wstringop-overflow globally
Message-ID: <202401261423.7AF702239@keescook>
References: <Za6JwRpknVIlfhPF@work>
 <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
 <4907a7a3-8533-480a-bc3c-488573e18e66@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4907a7a3-8533-480a-bc3c-488573e18e66@embeddedor.com>

On Fri, Jan 26, 2024 at 03:30:20PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 1/26/24 15:22, Linus Torvalds wrote:
> > On Mon, 22 Jan 2024 at 07:29, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
> > > 
> > > Enable -Wstringop-overflow globally
> > 
> > I suspect I'll have to revert this.
> > 
> > On arm64, I get a "writing 16 bytes into a region of size 0" in the Xe driver
> > 
> >     drivers/gpu/drm/xe/xe_gt_pagefault.c:340
> > 
> > but I haven't looked into it much yet.
> > 
> > It's not some gcc-11 issue, though, this is with gcc version 13.2.1
> > 
> > It looks like the kernel test robot reported this too (for s390), at
> > 
> >      https://lore.kernel.org/all/202401161031.hjGJHMiJ-lkp@intel.com/T/
> > 
> > and in that case it was gcc-13.2.0.
> > 
> > So I don't think the issue is about gcc-11 at all, but about other
> > random details.
> 
> Let me take a look.

I think xe has some other weird problems too. This may be related (under
allocating):

./drivers/gpu/drm/xe/xe_vm.c: In function 'xe_vma_create':
./drivers/gpu/drm/xe/xe_vm.c:806:21: warning: allocation of insufficient size '224' for type 'struct xe_vma' with size '368' [-Walloc-size]
  806 |                 vma = kzalloc(sizeof(*vma) - sizeof(struct xe_userptr),
      |                     ^


-- 
Kees Cook

