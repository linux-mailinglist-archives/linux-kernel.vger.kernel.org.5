Return-Path: <linux-kernel+bounces-83773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C76A869E50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4608828C0BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CC34EB46;
	Tue, 27 Feb 2024 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fnzfJaTV"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A84E1DD
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056390; cv=none; b=iiIbr+ygjD5kAEcph844unCFZ4LJPqa1N3z1obDC08oQrPro5us0KaQ5X6R2gQARA4Y4Xv6hCUi76M1K1Ol651QiGH1YEEfn81eLOEmDnwqdvyUFdY15v4BeDOXqtWQwA4Uh6AEH2GphesPloBGQDd3t9LCoQDDw+bPgCZXFDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056390; c=relaxed/simple;
	bh=johZxZO1BLynAj27mgUIzBpZBiX+HwYZwRJmg+3qXYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJNugQXatnj00UMk53K1D6lVJ2Nv36QJ4Z6xBHDP1Vavs2yWGDLBLK+DCW4IqkIhyyf4QLchyWkljkXgWomTDY20Vr8wCRguT6NsYOG3qgqlfJglW+YC63gTaiyROPIlu/mxYewfjOIdQ1vAG8zDIyBA4c99yqH2uRrGu0dCrjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fnzfJaTV; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3652762edcfso12411115ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709056388; x=1709661188; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CUGpOInHfB6oXANt5lLDq7+qRlwHtdSo25I/C8lV/gE=;
        b=fnzfJaTV+nyhUr76UkWyLKrcOOPungxNguphO43afBIlEVFU+Cc/5p5nJwrBoL9Qrw
         mHB2NFHK2adkUqhP89PfRpY3gy5QBXjpty+EPFU39fQxUmFjDkENVOxmpujboasLI//j
         JlUR6rRHNMFesLJaIf2hlJmnSRN3XNM98IKHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709056388; x=1709661188;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUGpOInHfB6oXANt5lLDq7+qRlwHtdSo25I/C8lV/gE=;
        b=TXw1aEXEy3eCzA1JGaPPHshBKmUlWT2Nz4abSDmB3dVx/ntA0lNwmJRaTZaWVpblY+
         y0/Ic1zOdcu8llEDwwUF8G2SkDX+uBIaRZ0Mifc5y21orvYSbJH+8w3C+fOOv+I6XwoD
         koK8ee6cfpdYY0uSqc1zqphQlwJ21KGbouNB/hy0eBZVQXoReLRymi5qMXg0zuBMudZ/
         EzmqQUlthT9dTRS1Jp2Rpd5IuP1gRDC6UJNTcgdM3kww/3ey8bhKtUKzUnhCM8OjbLRy
         vQAGPVblJw/+lBA+j1GRfn1h6Xqm5IP3L9czVg8AqFLi4UsazHjcGjzZ2sHwFqvw/wll
         Mvlw==
X-Forwarded-Encrypted: i=1; AJvYcCXUOanOJg3Ofte236U4yvMDAByR2OywjkY4H7w1p459tn3nOM9n575CAsacGKtNyGN1PDl33SttXaLCWVKeEc3R+NaTFBTpVZVLKIcH
X-Gm-Message-State: AOJu0YyxpTim0c2C9Y+U4uW/SpPYWnpGje+/A5V+vLBv0NgYVllgteMU
	DuDv0aLKgEEQwIYtdrqsDii6Bq0C+g2qP0sSD+Yvxt07OQdYxVoHx7GTYh9RjA==
X-Google-Smtp-Source: AGHT+IEhVBgpTHrn9Ciy4eW8hD0nPWBOmU5d2rRoCerXInpxX852iX7CB7uYxZsaZhGPfs7otbQ+Cg==
X-Received: by 2002:a05:6e02:118a:b0:363:c919:2716 with SMTP id y10-20020a056e02118a00b00363c9192716mr9374131ili.20.1709056387901;
        Tue, 27 Feb 2024 09:53:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ld18-20020a056a004f9200b006e533074414sm3593917pfb.21.2024.02.27.09.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:53:07 -0800 (PST)
Date: Tue, 27 Feb 2024 09:53:06 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: Borislav Petkov <bp@alien8.de>, Guixiong Wei <guixiongwei@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Kristen Carlson Accardi <kristen@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Guixiong Wei <weiguixiong@bytedance.com>,
	Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Chris Wright <chrisw@sous-sol.org>,
	Jeremy Fitzhardinge <jeremy@xensource.com>,
	Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86, relocs: Ignore relocations in .notes section
Message-ID: <202402270952.93228D6@keescook>
References: <20240222171840.work.027-kees@kernel.org>
 <0443c7c2-1c3f-4cf8-940d-88306956832a@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0443c7c2-1c3f-4cf8-940d-88306956832a@suse.com>

On Tue, Feb 27, 2024 at 05:13:35PM +0100, Jürgen Groß wrote:
> ... a test of "sec_applies->shdr.sh_type == SHT_NOTE" work as well?

Oh yeah! Thanks. I'll send a v2.

-- 
Kees Cook

