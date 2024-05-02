Return-Path: <linux-kernel+bounces-167052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BF88BA3E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6E11F24DE9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366F01CFBE;
	Thu,  2 May 2024 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QxFx9dvV"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA01CF8B
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692076; cv=none; b=EALwPIZJ675gq/HzzBzAwbgIoJ8QX5STlkHUzyEMFWvgFLdNtOBgEr74kvIVAgiHxegrX+VBdFILyhwccFZtSo7kBD1Hn3PjGSngcVshJ1FZDIYmyem9aLHvZ0pMuDS0ZAhwR3E702/e1p0TUwXdraPOIwhKSRvzZs6CjrKiPkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692076; c=relaxed/simple;
	bh=6YgtMXWABRT2OTs6qwyyj+LFyuPuM8VYCR4YovsE1KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma1V12gnuFY0JANwCpgdukc0dQ7QXYlK8g9+lEitdoiua8t7WyqD3Y78hmgh6xM2vld/8ucfsJF8ePeWUm29I5WJADtaFS932cmmNEIVWLDXTxuCxQRzhn2jf3tlVRkRYF4aWmYUezHdfyTByC5Oq1OkvTGbghG1u+PcJXFS8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QxFx9dvV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f447976de7so617615b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714692074; x=1715296874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb4bKEByKdlz4UZjReMUHUSYQEXXrh5q/y+c7lUVAhc=;
        b=QxFx9dvVfc9RrjAW8fvVc0SxoJ8B1jmxz1Jli7jWPt6QWk10CZkIbdjp83W4W4OgCn
         psyp5bx5xsIjZfQVpUK7/kgnbeLjvjv7K3ps/FU6NuJ7lKRQl9kOozsHAAlEWo6pbIKa
         1zfeaH3HrwwpFW4Yq532/alFlJ9CMYoElKWMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714692074; x=1715296874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb4bKEByKdlz4UZjReMUHUSYQEXXrh5q/y+c7lUVAhc=;
        b=OhrZnLG++BhUWCTaoNfH29LmABt8SSCbiD0RLhITiYwJOlGAEaTUTwqCSPP+nvcaao
         yshbAwHGjF+Sfaa8H01B/NF5p539D+kqUWOHCy05XG+ng2LY7kRwFF2vsqEBPGnCZfrJ
         eyU05FnHcuIboibw+HQjzEJAuepldrWLPM7B4se7U+S/eCcXnG8IzuyVu2mPNCxwZ1cZ
         Z8/MuZ3G5ipJHjClr+FdU//EUFYW1BlSt6Evns+OTjdE68B1LKh020qfLo745ee1jNLC
         uZ5wP9NXTMSDXADMQWlXOGBHHcnTD4zVoZFFqqX3meibiMfJfyTVQG3lRy+LjosCC4+Q
         g77g==
X-Forwarded-Encrypted: i=1; AJvYcCXwG+tuE9F6oZhxFptKh0IEfNYVKi7Sb3IfOmxxFwMcqzTp84rL65PvPTwy76r76zA/0MygXgV4Ogroap0QDV3ls/KUZXRX20toeEg/
X-Gm-Message-State: AOJu0YygLrV4xMqxtRTAwxIFAFEaX5/HRnZsYL6U12twFFz1ux0tL6vz
	N3Z9kiv8PGi/yAe5pizpwLvP43aFJnwFTzlNrry2FO3hOuLZ/JhDBcopa9orPw==
X-Google-Smtp-Source: AGHT+IErA5BfNjNMgVipEBvX/O4/Zlw4xwfnpXOv3ZrPWth9wG6pzC2gQkNN14O91XqQe1Da/qOaqw==
X-Received: by 2002:a05:6a20:7f96:b0:1a9:b2ee:5f72 with SMTP id d22-20020a056a207f9600b001a9b2ee5f72mr1455527pzj.36.1714692074451;
        Thu, 02 May 2024 16:21:14 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ls30-20020a056a00741e00b006f4123491d2sm1821750pfb.108.2024.05.02.16.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 16:21:13 -0700 (PDT)
Date: Thu, 2 May 2024 16:21:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Atwood <matthew.s.atwood@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/5] fs: Convert struct file::f_count to refcount_long_t
Message-ID: <202405021620.C8115568@keescook>
References: <20240502222252.work.690-kees@kernel.org>
 <20240502223341.1835070-5-keescook@chromium.org>
 <20240502224250.GM2118490@ZenIV>
 <202405021548.040579B1C@keescook>
 <20240502231228.GN2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502231228.GN2118490@ZenIV>

On Fri, May 03, 2024 at 12:12:28AM +0100, Al Viro wrote:
> On Thu, May 02, 2024 at 03:52:21PM -0700, Kees Cook wrote:
> 
> > As for semantics, what do you mean? Detecting dec-below-zero means we
> > catch underflow, and detected inc-from-zero means we catch resurrection
> > attempts. In both cases we avoid double-free, but we have already lost
> > to a potential dangling reference to a freed struct file. But just
> > letting f_count go bad seems dangerous.
> 
> Detected inc-from-zero can also mean an RCU lookup detecting a descriptor
> in the middle of getting closed.  And it's more subtle than that, actually,
> thanks to SLAB_TYPESAFE_BY_RCU for struct file.

But isn't that already handled by __get_file_rcu()? i.e. shouldn't it be
impossible for a simple get_file() to ever see a 0 f_count under normal
conditions?

-- 
Kees Cook

