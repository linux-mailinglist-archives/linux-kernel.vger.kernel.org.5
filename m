Return-Path: <linux-kernel+bounces-19913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EF7827695
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92861C21CCF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531E05467C;
	Mon,  8 Jan 2024 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kccll3Y2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6651755C2A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d409bcb0e7so6515765ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 09:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704735863; x=1705340663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x1abJydjZLln7hQl4E3lvrRUTA89HK7MRnwUoF4czmg=;
        b=kccll3Y2FdDLUo5tupbjJIUs4wG1s03ovzv6aHkTzill4M2c5vu+zc3OoJ9PM1sCDI
         zrv1M1pmLbfgwG+AJDcx+2SJRM92LNLnv3aZabxwW19N93nTLP/qY/tFQ9NYN7sAuEJ+
         XIiTX5kqFO1VdKKdOBckO35BzoST5D3ArXkMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704735863; x=1705340663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1abJydjZLln7hQl4E3lvrRUTA89HK7MRnwUoF4czmg=;
        b=dxgRROheQNhnTRHbTkaNMD7RlYRnBlZDaxjjHPJBBClwSZA8CDL+QFcPKhWPiywMye
         /YpdHz36j+ZCP+KpPcI4svx+cOQ055IZzWf52DPtYr/ZvCm3ODGJoRf7kdY+2fvTXI25
         ydXl1woVEtxWEgEqcd2I0PsOuEWNW/fCDCFkiSCFvPJ5rFSRZtrDK48AkuTp7Oc0C4SG
         q0u1gyQAMguyK56r/uOsLPMgttBHrvIWn0tkSev9I/zgV9SmaA5IBuND38eroCsUClaV
         iKfWXaCyxpvf+Jq1XLKqEbFcNRvwiG/M8/ZLwt03DdbT8H5LhC94Of/YA6Q7s7e2o1jw
         N0RQ==
X-Gm-Message-State: AOJu0Yxy3DNBNyvSxMRNNUokOIeutTY0DV5U/F10GZyvivz1LG5j+Rsp
	SeT4h9bEApO9a55P1UdCCvVUIrrL0ado
X-Google-Smtp-Source: AGHT+IEttQb3FycvV0cgJvko1q/TkbA531qRGLLKG9qbhqKwDtTLQgXePvr4WKDehTx840cKzwWrxA==
X-Received: by 2002:a17:902:b093:b0:1d0:6ffd:ae22 with SMTP id p19-20020a170902b09300b001d06ffdae22mr1611156plr.137.1704735863639;
        Mon, 08 Jan 2024 09:44:23 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx4-20020a056a001e0400b006daf1ded817sm136207pfb.209.2024.01.08.09.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 09:44:23 -0800 (PST)
Date: Mon, 8 Jan 2024 09:44:22 -0800
From: Kees Cook <keescook@chromium.org>
To: Jasper Niebuhr <yjnworkstation@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"luto@amacapital.net" <luto@amacapital.net>, hpa@zytor.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Post Compile-Time RandStruct
Message-ID: <202401080942.9729377F@keescook>
References: <CAMjCObt_VOWp9fz_onYesfpvLLiJqnzpQA8W1HfOpLc0_bNGog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMjCObt_VOWp9fz_onYesfpvLLiJqnzpQA8W1HfOpLc0_bNGog@mail.gmail.com>

On Fri, Dec 29, 2023 at 11:57:57AM +0100, Jasper Niebuhr wrote:
> Unfortunately, debug information turned out to be inaccurate and
> incomplete at times. Combined with the kernel's quadrillion edge
> cases, this prevented me from taking the prototype any further until
> the deadline. We can see this concept fully shine with, for example, a
> compiler plugin to log any accesses, instead of a tool that deals with
> debug info. The second part of the prototype (or a mature, later
> version of it) can be integrated into distro installers or run
> whenever the kernel is updated. Even integration into the kernel's
> boot process would be an option.

Have you tried the Clang implementation of randstruct? It has correct
DWARF info, AFAIK.

> Since I am now in the writing phase of my thesis (deadline mid
> January), I thought I'd share our thoughts to hopefully get some
> feedback. Do you think this approach solves some of the issues that
> RandStruct currently comes with? Can you see such a system actually
> being deployed once it's fully functional?

Most distros don't use randstruct because it doesn't really do much
given their identical kernel images, so I'd love to see this kind of
work happen at run-time, and I think distro images would embrace it.

I look forward to seeing the research!

-Kees

-- 
Kees Cook

