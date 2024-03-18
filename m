Return-Path: <linux-kernel+bounces-106823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694DE87F42E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6FA280628
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368E5F870;
	Mon, 18 Mar 2024 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LCWzjlg+"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2645F85B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710805234; cv=none; b=AIIzwK/kiY0agfQ8aEhBVXq8W96ZCF/fsdyAav7hmMUZvY+hfEAUf2d4RR5EatkeQzJ10JdeQ4BQA7lrpY85ey/7F8smTg7sAKARIXC3HSKYePTIHFmE1o0Pevgk6mcAzui4mYWHdmVfZngjL6WUwRCysebXiFqP2X6tqMDCvX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710805234; c=relaxed/simple;
	bh=Yijpf6hdcX9Zz+at/Pl05PNPDv5yz2KSyc2hARlGVyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BS1WJA0FL24wNK9aYcCpGTw7K2hoCvIzurLpFNC/IFu18PwYGBbBUn7fTEhj1EUOgLFF1d/QpvUrCqBq8pafG7XtGOemhwlhvweDOOCdGLQLTrS3oxEwz5m0kDQacRIHugXL5Rs9rMtkmJzrRYfvdfB4iTCTYiADUWZ3V7H60nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LCWzjlg+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e034607879so8506965ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710805232; x=1711410032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qGVjXx+j07fAtzWyhzuz39ABH1ricioExB9tBdSnz3U=;
        b=LCWzjlg+zokALRFDsK+PmKtA9cJKjFrbsPh5Q76Wk+vIfEd3TCLdznZ4ulGLVJRVke
         IVY0QTj71Q4/89HFogbjEJVNrVwm5+1/7u0ilJJD/KTFAu0ytxpDmJmhu1PyfZFl39mM
         0OOH+UAkCncaOGAYAPcnA11gKT0DIOXlP/36U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710805232; x=1711410032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGVjXx+j07fAtzWyhzuz39ABH1ricioExB9tBdSnz3U=;
        b=IDRxKj1NK2IXSBfWZJ4sf3YWN1BgBq+0bjdZ4KpeQBcXQ10RIVPKTMctt5/DPWxOtk
         4NLgf9tPCEt33hT7mhSQ2ZXCZIqYPW+s+Jk+5xH3NnavrNGLBIccNFBH/rDL6CCUB4UY
         QTEHNvekghqU60ePB4zZ0lLbR6UrLEMkm6VpdpTJQmbAkcZm0EOlnCoja/W0I4MhUasj
         P8tIF4JWxVTSKSPIh+ymZxBYS+15UTQMZygT4fzcX0GT5ekJNH677I/mP5JBG1CFyByO
         Mh5w4+jOrx4SIGospey1juOXGsbllXL4vhMmKZCV6cUSDZngpVLk6YJA7/I1RhbjwsA/
         VPSA==
X-Forwarded-Encrypted: i=1; AJvYcCVt9GhJbOmGbgcXV6W61fvW4wC1lSECbl36O/3//271Ejzn1e2dR32/2Ewnn0lw9f8b4FhAS4LJOlUHlmzGF39CmICDCEkdnTy0aDuf
X-Gm-Message-State: AOJu0YxFc0wdICObOUuTYkfdndqjCc1yhJ+BzFXjEuNLvWTuifRylEO2
	QJYJ4ydAQ0zjZIHO4jJn2FW4yQTVHeGigOvoQ9RU3VcRnYsxDZGaslUJzAE5Dg==
X-Google-Smtp-Source: AGHT+IE6ZJkwZUoHdQ1XKk7dfD4fL/GhYshEq7O4lP3zklm4arTM8pnOn3Dx/fJ9+Pp6EnYJuQnZ2g==
X-Received: by 2002:a17:902:b68e:b0:1e0:f8:17ca with SMTP id c14-20020a170902b68e00b001e000f817camr1076507pls.39.1710805231878;
        Mon, 18 Mar 2024 16:40:31 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902a50700b001e0287592casm2566226plq.295.2024.03.18.16.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 16:40:31 -0700 (PDT)
Date: Mon, 18 Mar 2024 16:40:30 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/x86/rapl: Prefer struct_size over open coded
 arithmetic
Message-ID: <202403181635.46CBABD994@keescook>
References: <20240317164442.6729-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317164442.6729-1-erick.archer@gmx.com>

On Sun, Mar 17, 2024 at 05:44:42PM +0100, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "rapl_pmus" variable is a pointer to "struct rapl_pmus" and
> this structure ends in a flexible array:
> 
> struct rapl_pmus {
> 	[...]
> 	struct rapl_pmu *pmus[] __counted_by(maxdie);
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + count * size" in
> the kzalloc() function.
> 
> This way, the code is more readable and safer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

I was inspired to come up with a Coccinelle script to find this pattern.
This seems to do it, though it also removes the blank line. I'm not sure
how to stop it from doing that. I'm running this treewide to see if I
can find others...

// Options: --no-includes --include-headers

@allocation@
type SIZE_TYPE;
identifier SIZE;
type PTR_TYPE;
PTR_TYPE *PTR;
identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
@@

	SIZE_TYPE SIZE;
	...
	PTR = ALLOC(..., SIZE, ...)

@structure@
type allocation.PTR_TYPE;
type FLEX_TYPE;
identifier FLEX;
@@

	PTR_TYPE {
		...
 		FLEX_TYPE FLEX[];
		...
	};

@single_shot_sizing@
type allocation.SIZE_TYPE;
identifier allocation.SIZE;
type allocation.PTR_TYPE;
PTR_TYPE *allocation.PTR;
identifier allocation.ALLOC;
type structure.FLEX_TYPE;
identifier structure.FLEX;
expression COUNT;
@@

- 	SIZE_TYPE SIZE;
 	... when != SIZE
-	SIZE = (\(sizeof(*PTR)\|sizeof(PTR_TYPE)\) + ((COUNT) * \(sizeof(*PTR->FLEX)\|sizeof(PTR->FLEX[0])\|sizeof(FLEX_TYPE)\)));
 	... when != SIZE
 	PTR = ALLOC(...,
-			SIZE
+			struct_size(PTR, FLEX, COUNT)
 			, ...)
 	... when != SIZE

@reused_sizing@
type allocation.SIZE_TYPE;
identifier allocation.SIZE;
type allocation.PTR_TYPE;
PTR_TYPE *allocation.PTR;
identifier allocation.ALLOC;
type structure.FLEX_TYPE;
identifier structure.FLEX;
expression COUNT;
@@

  	SIZE_TYPE SIZE;
 	...
	SIZE =
-		(\(sizeof(*PTR)\|sizeof(PTR_TYPE)\) + ((COUNT) * \(sizeof(*PTR->FLEX)\|sizeof(PTR->FLEX[0])\|sizeof(FLEX_TYPE)\)))
+		struct_size(PTR, FLEX, COUNT)
	;
 	... when != SIZE
 	PTR = ALLOC(..., SIZE , ...)


-- 
Kees Cook

