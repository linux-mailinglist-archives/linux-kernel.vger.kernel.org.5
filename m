Return-Path: <linux-kernel+bounces-106825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B6287F433
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4041F22A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030335F86B;
	Mon, 18 Mar 2024 23:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UP+WJbvt"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E403B59B64
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710805549; cv=none; b=NV4E4UZ8XQqMIEaDY/X3G0okG+vWa3l8uANbGhd0KXF/Vp6DaPo9APFYc2kjMd3WV41PFZjpMpcbwAoj+8cwTK9iDvGnambdWB0WWNpUo2nHRUKrGzvVnxyHRAPJipAbJHIRU+9ro3pSsgZOMn+xGrJ9rHAXHDvP/0EHvTJmWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710805549; c=relaxed/simple;
	bh=ddIX1pX8PUKYlrEFSGxj4dp81Coz+WVwDW5gqZgq2IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acaePTSfetzeNVI9DyxAhRGljJL5uR7drXCXPH5cOSLt5MvTsFiBSfrYYDi1OnaIWuAyO04BljIkRGKsQNnfCik+u6ouj0ZzJQ8mInOXNs9WDdySUoidIS8ycjiNvG+hMUgXrBxHmLGmsJptQ1tBV/YdD39ljWroMFaS9UBm52s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UP+WJbvt; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a21b920209so2012963eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710805547; x=1711410347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EyNKKJaFo0RNnDw1cX76A1V9oBiLwk9MCVF82VfEr8Q=;
        b=UP+WJbvt4DkTE/aSDfcB2mZPHNKGKPI21xQbR4yaLTSXHLgFLohjYywOc1ESA/2dDW
         eUGQWwXJqlBMmtf8kuDJvvyrYKtErkTttlhTVESunE6AEFIkFFNv6YaFtLzmjpFyP8x2
         e1FWvDbKSQ8KM4wciG+pl3yMNLU8Ga6Swmcsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710805547; x=1711410347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyNKKJaFo0RNnDw1cX76A1V9oBiLwk9MCVF82VfEr8Q=;
        b=SBwvB78f2+9nsyqUjpXh0Y+64DKv9RQd/9D6f5d3EyAn/zxYrZIsB3j2DLWXDBCo5n
         yTITY6bNjRbBjhFzsJoF2sP6+D/7uryJvBgR4me+++d5muPX9K8suKwAIrw0ktjbYvp4
         U+S2EMYkf7s88p4pMFPV45juvQJpD5JQx6L4F9yNt158a6Rn1XvHZyheVgq2HmAlqUIN
         bphcCHj5mZTGy0Gf1wDx/9o2NdW9kTC1iFbLgNCDs4IJsb4YkyCaLnYkKBCXB8lgBC80
         zqUncVNyoGazwrQgQRnneKzHHpnKDM6AJ4XpxPTwNQJLT6k3f5zWG6deKx6J9h9YEsB4
         PrAw==
X-Forwarded-Encrypted: i=1; AJvYcCWjpYbQDGVqWf1bnDu/kANHQwfRJlVbgHpPku2/4p1IghbbrTF6L/fPluU0R4mvNNIm/HNxzIFC6yEZ+FeF+0OvWG5bh8Q5zZ7wMGIT
X-Gm-Message-State: AOJu0Yxzbkt4RM2muypaX0FtPEELUEylDsyJLu0MUVPZQlUYM0SpdiFA
	wjcCelu6W433aFHsOmwok4zTMdtxlN8pe2YBnNGltUXJSAZfmHqWxBld316S+XDMJh9UkOmkPSU
	=
X-Google-Smtp-Source: AGHT+IHuGsFZKeGKS+5IfIvaZGbwZxy1NkSSfWwS6FkEclzsGrRPwV1rjWc4/CqC4usYaEiXM+0A2w==
X-Received: by 2002:a05:6870:3926:b0:220:9f8c:b97b with SMTP id b38-20020a056870392600b002209f8cb97bmr16205988oap.4.1710805547072;
        Mon, 18 Mar 2024 16:45:47 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q20-20020a62ae14000000b006e6c38cbe96sm8493254pff.29.2024.03.18.16.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 16:45:46 -0700 (PDT)
Date: Mon, 18 Mar 2024 16:45:45 -0700
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
Message-ID: <202403181644.690285D3@keescook>
References: <20240317150547.24910-1-weiguixiong@bytedance.com>
 <171079804927.224083.15609364452504732018.b4-ty@chromium.org>
 <20240318215612.GDZfi4fG52DTgra51p@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318215612.GDZfi4fG52DTgra51p@fat_crate.local>

On Mon, Mar 18, 2024 at 10:56:12PM +0100, Borislav Petkov wrote:
> On Mon, Mar 18, 2024 at 02:40:50PM -0700, Kees Cook wrote:
> > Applied to for-next/hardening
> 
> Why?
> 
> This is a patch that should go through the tip tree, if at all.

The commit it refs to landed via -hardening, so I was taking the
responsibility of landing this fix too. But it's fine to go via
-tip if you prefer?

-- 
Kees Cook

