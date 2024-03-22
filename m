Return-Path: <linux-kernel+bounces-112108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FD68875D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2BF284A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78A882C7E;
	Fri, 22 Mar 2024 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NgDXZcnd"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974BC8174C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711150816; cv=none; b=q7jHphzkaaI+Xf1MvnB+pfEJfY9gHPl3aRNvRDMsuPbY3f+ND/6+oKnjaPZpZXE92QsyAmeFETNjqKy/7WPjZQ68PI4H1cr9eLBIxxcegjXZ8dlrbQ78I2Rz0LyAu/FtzBqFEuq/ueoI9qvbLkmWncpJMRWUUBIGKpMhobXYrYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711150816; c=relaxed/simple;
	bh=eH0fgxAZoZKG2nG1if5jwZQ6PXT1CXjSRf2Ajj7jhHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yta18KXSkXYL1ZZhkHf80Fr5jgeMjesq0YEITXggN8iPhhWcgU403yjQpmlNBM93CWnELBW+og9SHhWvy4ahFr82t+znL48Wat0caZwDXrfuAOzA8TTDFB75rusf48MBztD0ITdhyEg52jzc9aCUNBBn20gbqi34WqydywWdFm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NgDXZcnd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso1701228b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711150814; x=1711755614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01sC/xb6KwRYYgbeCF1XVs83Gl9AibN3LKeqo3B8YE0=;
        b=NgDXZcndmcTAqMjNZ8pZI5hhEanPOYZuuxwMQPLgril8EPJ+JCIQ2bu040ZgWjHGBU
         m6z6Kn0w0oS9MLsLzwVthTYOYHikywiY/AZOFSf5SJpGFzTBIll+SEBMjMCUUf+N2oE3
         A4RrnIhz6lV+lHq+9ow5WAE27r9QLWk6ktpDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711150814; x=1711755614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01sC/xb6KwRYYgbeCF1XVs83Gl9AibN3LKeqo3B8YE0=;
        b=ZBPC6CXw6DwDJrvxMwwNd9psCjQSos0jII52whlJCBcQKs6Nj9+jqVGdVLMlnc7oLO
         fNdS3V+3RnN25G0BYTQGRzZjAr8KxEnRmk74B3cHruChrhSA0gcqceIXPYRigmmFKqPX
         keGwWmefZe61aqakNUSJjyIwXC2jLhsM8o5qjrPlLpfDRJ5Vqc92JUla2ydKlTqs5lSb
         6zpfC8OVbo32W9SuxUgxZxbW4/ausM15DXMmVrf0Ee/79JsWkQPY1QrWFZNruq0DDk1c
         pYW08eJZyqLqO4RUCqFrMAc/Yn4qN88gyl5o5ZKOW1Bh+j85d7KVC5uZO/QZ+/YohvJ7
         RMbA==
X-Forwarded-Encrypted: i=1; AJvYcCWt4Ai/0DZ8t8yFCbfmI1Ow5iVZeviLwvkHgb2rRMiBHQTMqmF9zNK1rTTy5o/8b1GAi6XCcQ0nZ7L/p3d6rqxzT7cpE4GNfnC1ifZT
X-Gm-Message-State: AOJu0Yz9ZPt2QcbLeqVOnxUKMp8/oYtAZL/5ROzUIXBoUic85bGghQ8S
	AsQbXr2dbdJDX8Wi9yluaD9tkV2mVq66p6OHamg5JLhTUiRya3Gh+6/6olqD/w==
X-Google-Smtp-Source: AGHT+IEO+1pDKccyjXXftW8MfSWlcPCA31OAxKRwJX85EE5gxj3s3ysAHiqZdwAdKfFcLHWDAhqeiw==
X-Received: by 2002:a05:6a00:4b13:b0:6e7:1cd9:c032 with SMTP id kq19-20020a056a004b1300b006e71cd9c032mr592380pfb.6.1711150813958;
        Fri, 22 Mar 2024 16:40:13 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q18-20020a62e112000000b006e8f75d3b07sm310517pfh.181.2024.03.22.16.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 16:40:12 -0700 (PDT)
Date: Fri, 22 Mar 2024 16:40:11 -0700
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
Message-ID: <202403221622.6EA43547F@keescook>
References: <20240317150547.24910-1-weiguixiong@bytedance.com>
 <171079804927.224083.15609364452504732018.b4-ty@chromium.org>
 <20240318215612.GDZfi4fG52DTgra51p@fat_crate.local>
 <202403181644.690285D3@keescook>
 <20240319081640.GAZflJ6IBQ7TEKD2Ll@fat_crate.local>
 <202403190955.25E5E03E6@keescook>
 <20240322194658.GCZf3gMphnWeR9upN6@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322194658.GCZf3gMphnWeR9upN6@fat_crate.local>

On Fri, Mar 22, 2024 at 08:46:58PM +0100, Borislav Petkov wrote:
> On Tue, Mar 19, 2024 at 09:56:29AM -0700, Kees Cook wrote:
> > > Yes, please. Just send a Reviewed-by and it'll get picked up.
> > 
> > Okay, thanks!
> 
> Dammit, how did this commit land upstream and in stable?!

There are 2 related commits. This one ("... on walk_relocs") isn't in
Linus's tree nor stable.

(Thank you Ingo for taking it now.)

> Forgot to zap it from your tree and sent the branch to Linus anyway?
> 
> Kees, please refrain from taking tip patches in the future. You know how
> this works - get_maintainers.pl.

The earlier patch, commit aaa8736370db ("x86, relocs: Ignore relocations
in .notes section"), landed via my tree. It was sent out on Feb 22nd
(v1[1]) and got a suggestion from HPA and a Review from Juergen Gross.
I sent v2 Feb 27th[2] and it sat ignored for two weeks. Since it was a
10 year old kernel address exposure, I sent it to Linus on Mar 12th[3].

-Kees

[1] https://lore.kernel.org/all/20240222171840.work.027-kees@kernel.org/
[2] https://lore.kernel.org/all/20240227175746.it.649-kees@kernel.org/
[3] https://lore.kernel.org/lkml/202403111702.828C918E55@keescook/

-- 
Kees Cook

