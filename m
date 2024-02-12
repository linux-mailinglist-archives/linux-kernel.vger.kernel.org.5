Return-Path: <linux-kernel+bounces-62457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDAE85210D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040231F233A3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E7D4DA09;
	Mon, 12 Feb 2024 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="McKPaw6D"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93964D595
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775778; cv=none; b=nr8OYcSzuP1fMzaD7RtmOO5gTRyKw6f21mGfx1J0IBBtkKcTkCaSWFxJK2eiWoQZ/3boriaXOKMUKSRwY8QYct3N5bUpLsRO/lln3BJ1kP++XgUQXKnQYjQukTht8+1SpROiFYpYiRGrBIy9LQ31zLldBdXgcCBX/SSQRP4HLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775778; c=relaxed/simple;
	bh=MLwsSr8MVdCOcLFBS21ndz8l0PLPcDhM3Y/oMOTG9R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4ucp8x4CZegGWKjgOlUYeivNSrLItPDDm3kg/sMJCdJXec2zh1dcbLIptcD8DyKepezFHJT0Lg2hhsOCxHSayKhX7mooJ9wjjlL53uaPBtwFDZ6O0sxP9tNnXuOWpDzIx9XkH7b+mq3aftPF9HLVfMBeexxK+T9Y+gqK/4aZlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=McKPaw6D; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e0507eb60cso2357289b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707775775; x=1708380575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ijXS7mVIfD783iJTrvPPuV7zXdag7eKduahqAMiyRM0=;
        b=McKPaw6DXrLHk5gwQBi14gC36WdNjtcbjXr9Th2EFwu0ozmdj7lEErt39knzyI8Xab
         LnwmO2ExgK9SP7FJMmoMQ7RHPXTi/Ojr5ZV5bzkLM1etG1wyHznlqcwn17cJNooraMEr
         4TUICGFhrt+cmBpJCKl5JPPp7Lwa35J06fFTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775775; x=1708380575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijXS7mVIfD783iJTrvPPuV7zXdag7eKduahqAMiyRM0=;
        b=KUG4sXvHvLOEM6OeL9kPPBLOSMe8JqQ2pyZ1X6QLgdFzu/buxmZEG3GqZVj2l38GHk
         hjJczGGLuRUEd/bCKoRFbgwUijQnlnheqm+usAH8cvdAom/sDYbBShApfsF0zmOvd+a+
         KP+3xWSbK+gjCPl6YOrzqokWLIro9wu9UDMo+o3FxXM3CW9dwcwn2D9VCWrmlEsDDEV0
         /TRKmWQ6swKLzNLO31xJP0GmjSUIql66ORQF7ygmQK0m0KMZje0nk6jTsx4I3/DhjZGn
         dCJHY2QZuZBhhVTVC6lOv787AQ28FHXciIohHuqdC6h70FzHQEdOOhUEOIcqlXr29xnY
         dRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbEAoG9u67kDwpBXzeNGgI5hg2Mw7okgItpmYu91oJy3WnW5DKYpzQPN7OKO3WDFgPPHr9qeaVND1W+aBF16XM1+t8BvgNOn9ibFw7
X-Gm-Message-State: AOJu0Yyd3yhzM/J5eXTPintZbYU4aUedWOxmjX27ylOugTP5S73h4K1g
	PUyBl42hgh/Dsdom+QHMYysGcY9E7xDdG3i8VvllTnGVcd9vheaPxmOPC+VtJQ==
X-Google-Smtp-Source: AGHT+IGA33xPlWYbMt4sAOWVxNiiyT8AtvIRLrUgOdMPx/2TUza3Dw0PHn4w0vzmkstDOUwhjqvlRA==
X-Received: by 2002:a05:6a00:4b4b:b0:6e0:38bf:28ea with SMTP id kr11-20020a056a004b4b00b006e038bf28eamr9682776pfb.19.1707775775255;
        Mon, 12 Feb 2024 14:09:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWl2GHEiI0AdIONJv9vhuo053+zvHgdgwx2XCGWS00mxsRzMcqr79bvNvUDgm4zurDDPMyzknMUHE2JzbpNpXpoosUywUuK8+h2bt63JzaaMKGW1JwFkeicTqkQnrh5yEsbUY0YSJ9KrvTBoJzdixbEQwXGnB+rBT4smOkRhcG3knPCxp5C5Jmu74qY0nq9EOrAW9CVttjK3LBzv7FXCoZ4NIj+hpsuYoReG76UiKrBEUUslqfsnPDWvWLiRaZARKurLT/uPwecyFHzGa6QZBFqZs39g9QQqpxCzlP8crYc3dvxjzW95a7CEQmZMA/pIwcZPD5PznKyfGa8Zhcgw0jBETK3W3wOxPJtobmxnoIUltdfffu2zdolE4WS8qneSd0RnuJLbI5CvSmPksggXAwQBpfSjRow/luRjT5t5fi3EKG34lljK3UsZFrf0AkYedTEG9gAWsrElOEfr7wZM5qD7lSBcnghPDc+He4vk1wG8a5maN3KWnNAGd+yJsjmlKHKiL+qgyACU3Fg05QbSZFvSZd6uhF47cH0mgzLEvbZkIOeKyDesE+6SMGVzhaye/ANoj1+hPzMhSl83im0D8wWkdtCJDUU2vzlrmLvKYfLJiddjBonHbV/5oYtsnKbHKN/bNLryZfRlo9iikMEMkFOG66/DD474EblIazqjnz+eJ2I+/Y0Ckt0lhGrr+wBx8jty7dK/PqWEs0w6x4fR57/eWmImaXyVs560HpVnn2GeDvdhGi+5z5+oWyrXLZk6iiM3POqqyDmPB1WSIt4UIf4AcFzh4CPCLUhblFuFGpuXoLl+L4J6dKCityjp3TPGWiqEsnhNWQc2mHIyvo0b0MnVXLerlFLm42viHQ9Z5HAM+GGR652A441koINmwJaGpt7XPVtNyqMHOqcfZXeHjNAEA7U5qEHKP4qfh1GXbEP2E96JLV6bsx8oqiMe2FTQg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78712000000b006db9604bf8csm5978722pfo.131.2024.02.12.14.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:09:34 -0800 (PST)
Date: Mon, 12 Feb 2024 14:09:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v3 01/35] lib/string_helpers: Add flags param to
 string_get_size()
Message-ID: <202402121408.5C98241E@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-2-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:47PM -0800, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> The new flags parameter allows controlling
>  - Whether or not the units suffix is separated by a space, for
>    compatibility with sort -h
>  - Whether or not to append a B suffix - we're not always printing
>    bytes.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

If there is a v4, please include some short examples with the .h bit
field documentation. It's pretty obvious right now but these kinds of
things have a habit of growing, so let's set a good example for
documenting the flags.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

