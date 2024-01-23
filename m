Return-Path: <linux-kernel+bounces-35949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3342839912
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C351F2D53E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883141292E5;
	Tue, 23 Jan 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GIoAAIw0"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0D7128396
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036427; cv=none; b=TiTO6M+g2zuK/2drOQQnJv2aRB9QD7cwpC3zt6k0+rH+GHrEMFY7BsshD28YixXM0aNOG5JetIaZOEa65bL9nK5TL/CL4+/yCvPdF3pfTZ8sCFe1gR5L5vEl24wAQEu7itDwVp4hnDYtOS29Aa4Okz6XpLUWQyhfv7xZI8wLbiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036427; c=relaxed/simple;
	bh=QA2id3LqrmzYn8QBWvElp2X+uoIvf8x5U798DnB4uyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVURW+6ZPQZu7ldDv0AMma+pKEB0+VrkzXLZ4Fjk+ef6qAcrBPmaQhqNNwHcUXYkOTEvzv4i7o++d9IT2mabvgR1GMbLC5u95l6vZXgBfJ4FDhgpYOOEs2PwlPBil2+gg/cB+aEX+XEcANNXEjeePDZW2iKn6iZyVNsNIZaalg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GIoAAIw0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d70a98c189so26954525ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706036413; x=1706641213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/9FKmxWiB2vAaSsWA6W2r8jqoqGItDODorFRWTWYx3M=;
        b=GIoAAIw05UWSdUYUcUatVeO4/MxIT2iTCSbCVHD6OubrG91JqJiPuDMggzxlFyy4qx
         bd7vuTTEBRrsyydNn+Xe36GcZlHdHVS2MpRb1u5BDGgMakhyd/3eK54yQ8K6luDW3wXl
         JB3GS7XcXCt2r3IP/O5Rz4esZlvgk0YoNrHcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036413; x=1706641213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9FKmxWiB2vAaSsWA6W2r8jqoqGItDODorFRWTWYx3M=;
        b=gEoMLZ/HRsvfO4rEEyPiNTeBS9yKA6VCtrpE1UxvzwacceuBzimhWvpHUo3c/oV6Sy
         itpP7HZV4jDbUK7JU9pRuloANQ2IXJ/DmFS+BuvxVo7V9r0b3CLyQaHQGXpKOb26d3du
         8TFUzYxCNIOoVfqS/cioqDZrAMpebVIUae+EzpAyXL5Hpnahp+UyxUbw67NcZCR03iZa
         Wrlp5vUj3uGtQI/yiWFCEluWHSdn7Rx1RIlIdrr1RnwULPuvraKzeyHFaakJegtBlQiQ
         53T17DcM07koasfUrKGad9VgaPqT4cZPI/KQJhYT+kOQC7jyFaAObmkVpoSIZO7oMhc6
         58jA==
X-Gm-Message-State: AOJu0YypefzdJo/EHwGv96UgWPip0J2oWu0K0kfI+XIxOw8R9S7qrzBG
	Dxad8JSVYvCyF86BB5pxfmUfz7+oVoCx8bNWreaH0J5oLGhKznA/9KBOW9AG2g==
X-Google-Smtp-Source: AGHT+IFYzOSitLgL/rGq5zi5+lqRnkbBRykkzfae4VthDo4FdSuOL5OnOrjVVJKPwbxtn27UKcZ0FA==
X-Received: by 2002:a17:902:ea0a:b0:1d7:2bd6:23e3 with SMTP id s10-20020a170902ea0a00b001d72bd623e3mr4394412plg.5.1706036413360;
        Tue, 23 Jan 2024 11:00:13 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mp11-20020a170902fd0b00b001d75ea44323sm2836158plb.21.2024.01.23.11.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:00:13 -0800 (PST)
Date: Tue, 23 Jan 2024 11:00:12 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Vasily Averin <vasily.averin@linux.dev>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 34/82] ipc: Refactor intentional wrap-around calculation
Message-ID: <202401231058.5C5248DC3@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-34-keescook@chromium.org>
 <CAHk-=whS7FSbBoo1gxe+83twO2JeGNsUKMhAcfWymw9auqBvjg@mail.gmail.com>
 <202401221713.3FCABC9290@keescook>
 <CAHk-=wgMPVv-mDxA2qcywpLCRLojtaKmP13h7bVo4m=XN202xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMPVv-mDxA2qcywpLCRLojtaKmP13h7bVo4m=XN202xA@mail.gmail.com>

On Tue, Jan 23, 2024 at 10:06:12AM -0800, Linus Torvalds wrote:
> So:
> 
>  - get rid of that commit message that is lying garbage
> 
>  - fix the so-called "sanitizer".
> 
>  - stop calling the unsigned wrap-around a "sanitizer" and talking
> about "undefined behavior" in the same sentence, since it's neither.
> 
> Do you really not see why I think that thing is actively *WRONG*?

Yes -- I was trying to head off the confusion about what the larger goal
is (trapping unexpected wrap-around) so that people don't assume I'm
talking about Undefined Behavior (we don't have any UB arithmetic in the
kernel, very intentionally). I did not succeed! I'll rewrite it all.

-- 
Kees Cook

