Return-Path: <linux-kernel+bounces-94752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1B28744C5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384E428253B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9EC1CD16;
	Wed,  6 Mar 2024 23:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bwftwxeh"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB3B1C28F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769136; cv=none; b=U5Jd2lxnrVYB4ECkTohsQBkrhs0MVyoznbZJvMjxP2VUXhIfi824ZaIJC7UDI/DYmyNbOEgzflyhlVnxqWsvAUGFzvIJ49gNefAnMSVdlQwI2A5w5w07QvdSWA46E0fp9N8tUZ2JBd3I80R2CRUEVtM7IQjG2aNHxUcN47XoRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769136; c=relaxed/simple;
	bh=HKuLgTVFRKaKDoqvDomRm/dSKx0b/g4r+MceYXqEzKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGvz6mrasSVJ9wVkspPnp1Al1rD13S6FVBvolCJjrbWKW9e8SzpFXvdLYDB+Anh6XL5oDAPx59yoXyMp5E1gC4ce8rZ0auKje/RsjHOL0iqaRhf16Rt2pD+VyhCoFey1B6yGH/lqfVmkv7zpg+LnfgQIEnzJfw8/flDfBwvrFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bwftwxeh; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e125818649so191878a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709769134; x=1710373934; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZEAVZcoYSQFZcvaftM2f/g9GOC1c60DgaQV+1wgZreQ=;
        b=BwftwxehXmL5+X12BpMGO7AVdGn7ENPJuQO37XD8UvbxMs5R4ODUp+VOoF7Z5txQEh
         syS7pEzNr56D6Au2fD6GvaGI2VNwFl4rp22QJ2O2fwJYG/IxYGgmIDMvHBDP86/oK4i7
         roEAmc7XXuE35VIcYB13UGSySoCraUw+m+GTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709769134; x=1710373934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEAVZcoYSQFZcvaftM2f/g9GOC1c60DgaQV+1wgZreQ=;
        b=WzAFufCuefOvsMoUsmfmWuhrllLw3v1sK9GQXY5PCFSQX7j8JfYYqYuPtkLbOpit8d
         b6dVkMucAsfM43GDhf7AUumVuTQEhZdJr1Yd4swF++ArXZYIqgy0nCslGLdoblsiYGT4
         LG9iBQlfni56FQMmQyNpeL9BuJ2Ct5StQNHpwXHgvgVm5H4Kyi3NhXQORFgznKsqJhFl
         vbapFTMF0Iw+p15jYwcrDH9OKoz4uDZni9V2bei1pUHs80388JnyEqa5ah101tWB1cHd
         NdaT+tEWxcTABPiSfvIhKDQbVSDKMECnUB6LBRIBnlb0j7FN5BxXdDjlpA2EvPN8HCh8
         Tb3g==
X-Forwarded-Encrypted: i=1; AJvYcCU4JvAsr5WHbH9fJEC5GV2kIvSXEdZL8vN9FZYbGWa9S22qgV4skLzXuakPvpcb8nyKAO9IOaGfdKZxHzeqdSOh0BO9eSYowgkl2wVv
X-Gm-Message-State: AOJu0YxM7ZnXVRSIbL49U71JvUp63DUeUtFGw2vH+kNIQRHx4lwL6qVB
	B3krTnQAZn5Pd4X/7tY2z/o752Zj1o+V3w2BbI1GEP7K4cqsYHgMWgnnVy9jGF3g5OJlHc32pL4
	=
X-Google-Smtp-Source: AGHT+IGzQi4Hj1eR1TravKHp4tPRAiBWafpLp3PdehA3PNgOnJ+Bn3bpQz0p2gslmzv3nDrpdQZRtA==
X-Received: by 2002:a9d:6b13:0:b0:6e4:fa90:3c79 with SMTP id g19-20020a9d6b13000000b006e4fa903c79mr5596220otp.22.1709769134215;
        Wed, 06 Mar 2024 15:52:14 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c11-20020a63da0b000000b005bd980cca56sm11450066pgh.29.2024.03.06.15.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:52:13 -0800 (PST)
Date: Wed, 6 Mar 2024 15:52:13 -0800
From: Kees Cook <keescook@chromium.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: Change DEFINE_FLEX to take __counted_by member
Message-ID: <202403061551.00DAFE8B39@keescook>
References: <20240306010746.work.678-kees@kernel.org>
 <9c2990f0-7407-49c6-9e3a-b92de82ea437@embeddedor.com>
 <bd21f7dc-9f89-40ee-895e-601c80165225@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd21f7dc-9f89-40ee-895e-601c80165225@intel.com>

On Wed, Mar 06, 2024 at 08:06:29AM +0100, Przemek Kitszel wrote:
> On 3/6/24 04:25, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 05/03/24 19:07, Kees Cook wrote:
> > > The norm should be flexible array structures with __counted_by
> > > annotations, so DEFINE_FLEX() is updated to expect that. Rename
> > > the non-annotated version to DEFINE_RAW_FLEX(), and update the few
> > > existing users. Additionally add self-tests to validate syntax and
> > > size calculations.
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > 
> > [..]
> 
> Just a note that ice changes are purely mechanical, so this seems ok
> to go via linux-hardening tree. And changes per-se are fine too :)

Thanks!

> 
> > 
> > > +/**
> > > + * DEFINE_FLEX() - Define an on-stack instance of structure with a
> > > trailing
> > > + * flexible array member.
> > > + *
> > > + * @TYPE: structure type name, including "struct" keyword.
> > > + * @NAME: Name for a variable to define.
> > > + * @COUNTER: Name of the __counted_by member.
> > > + * @MEMBER: Name of the array member.
> > > + * @COUNT: Number of elements in the array; must be compile-time const.
> > > + *
> > > + * Define a zeroed, on-stack, instance of @TYPE structure with a
> > > trailing
> > > + * flexible array member.
> > > + * Use __struct_size(@NAME) to get compile-time size of it afterwards.
> > > + */
> > > +#define DEFINE_FLEX(TYPE, NAME, COUNTER, MEMBER, COUNT)    \
> > 
> > Probably, swapping COUNTER and MEMBER is better?
> 
> right now we have usage scenario (from Kunits):
> 	DEFINE_FLEX(struct foo, eight, counter, array, 8);
> 
> > 
> >      DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)
> 
> usage would become:
> 	DEFINE_FLEX(struct foo, eight, array, counter, 8);
> 
> which reads a bit better indeed, with the added benefit that we
> go from broader to more specific:
> whole struct -> array -> array size variable -> given array size
> 
> so +1 from me for the params swap

Sounds good. You and Gustavo have convinced me. :) I've sent a v2 now.

-- 
Kees Cook

