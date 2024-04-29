Return-Path: <linux-kernel+bounces-162815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C2A8B60E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B311C20D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E0212839E;
	Mon, 29 Apr 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lsuajCu9"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371471727
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414186; cv=none; b=qKrG2MdtiF+DvPFlJln/sPK0x1LKrsmOsRvIJ5Z9kd/NKphWpAWtB7CieukIqyyzN9VWx9RKTFqvRI4qPFkSDYI8mldyWjUG3NBR3Klr3NZmBMaOQyEoUIXdhdnt43khKxWo6PFjLOluXs5KTHnnIT0B8salEkPlSrNaDeH5W64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414186; c=relaxed/simple;
	bh=Z2LOlsSUnMgywQTJQ+7IHJraqyXovy/jnHsooFxUr2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgYpqKPQHKmMyRHvFWVq2Xx/gLPHnHWF+QOa7gzLij0BmOJ3lde0HIL4i+xah/INsYjtNGqZIibrUwRzEph/fXSxnaf9YaeNp8MSceIKY+tR2fAVCHBVS1x0KjEMdfft+gB//wabwcwU/ni2LwZIHIgu3A6u2CmGjUwcdKv4ddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lsuajCu9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1eab16dcfd8so40913735ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714414185; x=1715018985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+37QTrLTPLr7Kc5c3JRWh1bRwAteHaqsrzK+UmsL3Bk=;
        b=lsuajCu9lzKisZS0vlaiK3l5CfrLPvM3MsxE/vnIpIx4TJCjD5I+Hh1uo8HaxWmdTY
         N04Wn1cCkUUmtK0GaLpxqw9x3ymfL1bVgJ3U7Yh+OCwBQN/1bMZfDiLzQDjPQOEbVE51
         fy37YznGKXXXAyGK4sdIIr9ks+PrxxlCl64U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714414185; x=1715018985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+37QTrLTPLr7Kc5c3JRWh1bRwAteHaqsrzK+UmsL3Bk=;
        b=QRCnLDfn6OVuUBoj9nomu1EpjYS8cFH0Y0XcGrbgbDBbZ7PCG8FCk1G1fQNkMfrOUb
         IgiuyTzz6dxEoqPuQ5jxdebTYksz1upLzvytVhSoVdK1dzXU/Ig5YrWIiGEFuDarMCQ9
         k3H1zxJ2rHN3WrJxO8wp1qbm8vN7JsgT/TwCO1Cp34243gjsEEiVLSxAxOTh02Xhw94N
         IOibKuH/cZfztr0956jwI5eVOTIKB3K/Yqt2RXNMslAIKTUeW6j0VFZsOZKloTA+QbnE
         CPa7MbfQofEF5B9ikVALU3IbjKUesUvCkyrTnSNa/MnhI/VmQNHW1VdhGwefwfF4jgie
         i9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpQaU9zTFAGLCCe+k2I7MJIbqmPPdFbxsMt0h5e+TtaMHnb/O5fk3yf2akYWFeTgd0x1DQLlg/dVRDZfmLTeqd8TorbSY5KIn4+lCd
X-Gm-Message-State: AOJu0YzHsebfZnr3D24tDr06cYJ3ztbBXMcckHbWvEoEAc4ASKmppT22
	BLuVA9rOpo2h28TE6dL/SUiydtbSxA3dYZa32swJZNGqFLCZyBg6kx6XxgTG0A==
X-Google-Smtp-Source: AGHT+IF8MAuCWI9xQ1t4CFM/UvinhLq/MLyEW/f0X3d0CRIcumGhC4JUlpaad0Aw8KATz6oAmbvB4Q==
X-Received: by 2002:a17:903:22c5:b0:1eb:e40:3e07 with SMTP id y5-20020a17090322c500b001eb0e403e07mr9620367plg.62.1714414184798;
        Mon, 29 Apr 2024 11:09:44 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902704800b001e868e29fabsm20585009plt.251.2024.04.29.11.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:09:44 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:09:43 -0700
From: Kees Cook <keescook@chromium.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] wifi: wil6210: wmi: Use __counted_by() in
 struct wmi_set_link_monitor_cmd and avoid -Wfamnae warning
Message-ID: <202404291109.331E1704@keescook>
References: <ZgSTCmdP+omePvWg@neat>
 <171222554691.1806092.8730005090791383928.kvalo@kernel.org>
 <202404291008.51DB333F@keescook>
 <877cggqdwb.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cggqdwb.fsf@kernel.org>

On Mon, Apr 29, 2024 at 08:25:56PM +0300, Kalle Valo wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Thu, Apr 04, 2024 at 10:12:28AM +0000, Kalle Valo wrote:
> >
> >> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> >> 
> >> > Prepare for the coming implementation by GCC and Clang of the
> >> > __counted_by attribute. Flexible array members annotated with
> >> > __counted_by can have their accesses bounds-checked at run-time
> >> > via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> >> > (for strcpy/memcpy-family functions).
> >> > 
> >> > Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> >> > getting ready to enable it globally.
> >> > 
> >> > So, use the `DEFINE_FLEX()` helper for an on-stack definition of
> >> > a flexible structure where the size of the flexible-array member
> >> > is known at compile-time, and refactor the rest of the code,
> >> > accordingly.
> >> > 
> >> > So, with these changes, fix the following warning:
> >> > drivers/net/wireless/ath/wil6210/wmi.c:4018:49: warning: structure
> >> > containing a flexible array member is not at the end of another
> >> > structure [-Wflex-array-member-not-at-end]
> >> > 
> >> > Link: https://github.com/KSPP/linux/issues/202
> >> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >> > Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> >> > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> >> 
> >> Patch applied to ath-next branch of ath.git, thanks.
> >> 
> >> cbb0697e0ded wifi: wil6210: wmi: Use __counted_by() in struct
> >> wmi_set_link_monitor_cmd and avoid -Wfamnae warning
> >
> > Hi,
> >
> > I was just walking through our patch tracker and noticed that I don't
> > see this patch include in -next yet (as of next-20240429). Is there a
> > flush of the ath-next queue planned soon? Or did I miss some change?
> 
> Yeah, wireless-next was pulled last week so most likely we will create
> ath-next pull request this week.
> 
> BTW we are planning to move ath.git to a new location, rename branches
> etc. I think we'll see if we can also setup it so that it can be pulled
> to linux-next, so that you don't need to ask this every time ;)
> 
> (Just joking of course, there a lot of benefits from having the tree in
> linux-next)

Ah-ha! Thanks. Yeah, sorry if I keep asking about that. It's different
from other trees, so it doesn't stick in my head. :) I should keep
better notes!

-- 
Kees Cook

