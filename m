Return-Path: <linux-kernel+bounces-168423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CBC8BB866
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCD81F22888
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7770A84DF9;
	Fri,  3 May 2024 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SdYacVJU"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AE450297
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779820; cv=none; b=oQKAyc6RC9hMwiraz7Uz4t75zMHyCoQiK4S3+KIQXz86YlsUP0D0Iw2iPOg9UNnXk/Cl3pEp2exXlpIge7mEW8cSGLneGhUpaR69wDIbJCwvuBdZbytrg2Kb1Uci4IRYWX/PJb/D3xBhjvQQHHa9n91wsHcWHdvg43kglutptjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779820; c=relaxed/simple;
	bh=ktX1OkI7+PiUxrOJuKaZuk+OtoCLIWD+flahzW9oG5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWJP3wEOtcS33V9o5TCmB8Ai/GELiTQYuohYUcpr2LabElhIcArcIo+o74/m/otKqtVOFobw9j1AlzuSX3j9ktNkJXoXdgnXtz6opHlmSDpWPiXBdXBg81GFhoeCI0OQjKeSQiQw+37gnq9S8i2PiAQIptU4fz4zvJMYXfB5WZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SdYacVJU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ecff927a45so1786255ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 16:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714779819; x=1715384619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hP+dUWCvJXqFCm1BZPWTzdhC4tLQMbPhbpvfeYsuGgg=;
        b=SdYacVJU97ZnydpaoaSXhhoQH906Qx0WAlrqeufIeFODF2C3vGDGF8AbUBgCSZuZX8
         hOnPuMILEFjuxORODyvoDfoTTCCt19fQ6rZxtKnHI3oWsLQid7nufa8sZgwkItz9FQaj
         hA7X11pCf602lHDNIWE+8I4+6V+/aQTce/LlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714779819; x=1715384619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP+dUWCvJXqFCm1BZPWTzdhC4tLQMbPhbpvfeYsuGgg=;
        b=VbQiEAjo3OiXrQHbiWswbbyF5ql8+y09g0XG7SFHodVuCwtjwTBlJNquRwi7PyJ/Bg
         9cp/fLqyQcDVjXdEGSrjj4n49FinJudoQ33gqNG7fWPKAoxSejp/V8r+b0X14EsO8OiS
         cGEL1Qo9pRKcY6ktFBcO28iGnOP0aOYqkhNYOVvC7Z08iZQKpgUREOveb5qoWuuUiFwh
         itflOJ+AeMbum3cb1tqjEAqKIchBc0QhdfnpDkvdzLzXM29DG/kUyMhLCJvTzJZu6Q7t
         Ptthx49xCe6QRJdEaTRMPs247WP0t331RPlMdOgs0BaVKa1m6LxSiARO3kG61DRFuZWz
         QacQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKKSbEghqhU/CG7SPgv1vbkGeWP2s3/cDwCbkq8ifVcMFmGaJJIzY1bbSICFc4/Pq2DGQuzcAJexuNPRUSJTQMZTWNxwph+7XR+SJY
X-Gm-Message-State: AOJu0YxBylIr9bl9XscqEmsn54CX7X5TFhhZITx29q0rpBhpTBGWbLsU
	dTEvhG162lzSxIkOG60sS/417VyX/PVs2jQKPsSKXxFVhEA0EG8kdqE9jZ4kjg==
X-Google-Smtp-Source: AGHT+IEygCbwCpI7xjb71AoumHXdf2ry+30qYYFJd6deEDKA0dH5g8yyZFHZPXGPeG6dZEA2I8WycA==
X-Received: by 2002:a17:902:c948:b0:1eb:61a4:a2bc with SMTP id i8-20020a170902c94800b001eb61a4a2bcmr5466122pla.43.1714779818868;
        Fri, 03 May 2024 16:43:38 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001e2b4f513e1sm3819248plh.106.2024.05.03.16.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 16:43:38 -0700 (PDT)
Date: Fri, 3 May 2024 16:43:37 -0700
From: Kees Cook <keescook@chromium.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	ebiederm@xmission.com, j.granados@samsung.com, allen.lkml@gmail.com
Subject: Re: [PATCH v3] fs/coredump: Enable dynamic configuration of max file
 note size
Message-ID: <202405031634.77B223D8@keescook>
References: <20240502235603.19290-1-apais@linux.microsoft.com>
 <ZjVAJOsC-EtlIXd6@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjVAJOsC-EtlIXd6@bombadil.infradead.org>

On Fri, May 03, 2024 at 12:51:00PM -0700, Luis Chamberlain wrote:
> Thanks for the cleanups, this is certainly now in the right direction.
> Generic long term growth questions below.
> 
> On Thu, May 02, 2024 at 11:56:03PM +0000, Allen Pais wrote:
> > Why is this being done?
> > We have observed that during a crash when there are more than 65k mmaps
> > in memory, the existing fixed limit on the size of the ELF notes section
> > becomes a bottleneck. The notes section quickly reaches its capacity,
> 
> I'm not well versed here on how core dumps associate mmaps to ELF notes
> section, can you elaborate? Does each new mmap potentially peg
> information on ELF notes section? Where do we standardize on this? Does
> it also change depending on any criteria of the mmap?

This is all in fs/binfmt_elf.c, fill_note_info(). There's a dump for
each thread's info, and then fill_files_note() (which is what this code
is adjusting) which writes out every filename for any file-map VMAs. The
format of NT_FILE record is documented above fill_files_note(). So, it
all depends on the count of VMAs and length of filenames.

> Depending on the above, we might want to be proactive to get a sense of
> when we want to go beyond the new 16 MiB max cap on new mmaps for instance.
> How many mmaps can we have anyway too?

INT_MAX :)

I'm fine with the new 16MiB max for the coredump. If we really need to
go beyond this, we might need to avoid building the entire thing in
memory, and instead move it all into write_note_info() directly, but I'm
not interested in that refactor unless we have an overwhelmingly good
reason to do so.

-- 
Kees Cook

