Return-Path: <linux-kernel+bounces-56617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3882F84CCA5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D8028778C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4D47CF3D;
	Wed,  7 Feb 2024 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V1u3i4D4"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B67CF02
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315937; cv=none; b=BduyGYZOq6F2KrYXIIml9IJEgUjuHilGGkUw7PIPp3c5r4MoWKGdgIZ6/h81j8ZbRO5nc2s8unkfcldRJDEPpf4PpqzthjQBcqDVmzVSnNhs/Nzo/WpZPF4Qy6ANUTNAYf055tbwACMNwbdqAYxfUvfIXU3DCsc8XJkSMtzQwR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315937; c=relaxed/simple;
	bh=YOOfDCDKRyHiEDZVQRysOqlslMv9uBFs7/uEKQIlLR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CANwAshai5bxm7IW79TXeVMUH+p+tlSnIJ01f4YVO9724aTd/kMTukfNOOFtim07eDj5v5ujCa4JxdC1Ne6gsuEDd0THzLGQ3wdcLHl51B5ecyoMHG8J7MB9K/jjmouInRjAVNEH+YICMCRvjNl39DBt/HIr/dze5RqOGhFdNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V1u3i4D4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d74045c463so6621285ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707315935; x=1707920735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OYwgf7EQVS6kgUofsqdrhhqlkfda6mSImwNoXN3rr6o=;
        b=V1u3i4D4OEzTYXD0UQjP99wxwtkfzUyHvVVVWVoMntteoPlGQOUfq6DOgT8zx9P0yQ
         7VH2Zp3DAeeqeb18kGs1PlgfQ7JXOpIMo77dF0FAvnp8jFeaS58+hLWpNu7YA6tMjxi+
         4Bt6BefQpO5hA5cTJ9PCsfLViEGF/rIAP0XyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315935; x=1707920735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYwgf7EQVS6kgUofsqdrhhqlkfda6mSImwNoXN3rr6o=;
        b=G2RQ/RzatMQzIZ3MjYTouC1Hya+7mg3cSNVZrNdHvq2hLHyxagxBQvAl+huZSbwPTX
         +rryU4bFZ82zo38HUk3XX9MFA8AJLfpyjGAyev60GHILQlWWx0CDXQG/qxcRWTsWifJl
         1W1qDjrJKpsjE/jV3kcH2+ByJalUs7saPd1Nr+3mvq6rJzL3dNhpv7KoML8cyce7iDNB
         KP2h8U+ln4b+p5PasZqKDStHa+So8RgJs++OV0wqLvSsnRTDpq40SQTtJ1gEhSioZiFF
         bgVWxKiAIajWtVHM3RLS0UTQFz++1B6htcH/KgZ8JyxtBg+zxso9cR+jhehdE24n1Urq
         1tPA==
X-Gm-Message-State: AOJu0YzUPLCc5q9zQfrCHUH4egmhzel13XLaIxThpX2hWSi7ZhHMY/A0
	qAQHXIEjDRRStw+C2XOi5FEfQ7l0cNrYc0UeyJEo3qYQAGlJ/LVzbymwsIaJcg==
X-Google-Smtp-Source: AGHT+IHtarD8VIYNcqSebLjYXxu0VCGT1d/rJ3q8SLpLEvP4B5mIheZlHlscxHKlyoy1Vubw/2cnDA==
X-Received: by 2002:a17:903:2c9:b0:1d4:4df7:22ab with SMTP id s9-20020a17090302c900b001d44df722abmr5903706plk.55.1707315934840;
        Wed, 07 Feb 2024 06:25:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/ODWqYd00OkA7mJwb1/z7CtnnyIbVHYpzeZA9GZfzzER+2IAvqyAyAHn48eLuwcYPv7EvsrVq/SJnPAApUIAj/EBfI1tcqbAXRjWumX3t2FxzCUTkPNf954DGqlvHYNgBwmI43Jd8eGHPZ4Q5chSXv3p9PiznWPMITF8/UE1S7jSstARn1ciWcxPOdMdAEFnUxbJuM4k82yr6lb5gGMmwExTVDDbjSdSr1pi1fNQFrHKyUh3ErjIKzdJxLbrw6h5kL1kHsq+zPHFNITfe3AHM0VFJ55lQC+YWQcfKiNY2uOBSlWshVJvyAuOWECfbxYcLC1eK1mcGPizBRTtgO3lSKTmQ7Tg9Qu7otMjb6LgnJ8ZKen59kc+gcyjUPH8Q
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b001d9aa663282sm1470017plg.266.2024.02.07.06.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:25:34 -0800 (PST)
Date: Wed, 7 Feb 2024 06:25:33 -0800
From: Kees Cook <keescook@chromium.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] tomoyo: replace current->in_execve flag with
 security_execve_abort() hook
Message-ID: <202402070625.57945D6995@keescook>
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <2a901d27-dba5-4ff4-9e47-373c54965253@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a901d27-dba5-4ff4-9e47-373c54965253@I-love.SAKURA.ne.jp>

On Sat, Feb 03, 2024 at 07:53:17PM +0900, Tetsuo Handa wrote:
> TOMOYO was using current->in_execve flag in order to restore previous state
> when previous execve() request failed. Since security_execve_abort() hook
> was added, switch to use it.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

With the kern-doc fixed, this looks good. (I can fix up the kern-doc if
this goes via my tree.)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

