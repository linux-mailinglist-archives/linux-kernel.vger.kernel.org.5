Return-Path: <linux-kernel+bounces-21669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 822F182929A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26104B258BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A2D613D;
	Wed, 10 Jan 2024 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DHSnZh3t"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486F6107
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bc09844f29so3238828b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 19:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704855729; x=1705460529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFPPL62mMn6CtToI83E7n0O2MKG6z8XFWD/fwB1/NlU=;
        b=DHSnZh3tGvlnBeb03baGyYE2KF0nK9sxE706qvS9tVzeza9FwtmhZie6vJzhexDRRK
         nXHIwDp622mYdBdCozr+mfxrq6/AdcXC/ttC6OlQEJYAsEpva6SmClF52QEZ57LnIZbN
         59xRxIL9BIe0gMKD/qVT81X51IDG8YJw1Rez0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704855729; x=1705460529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFPPL62mMn6CtToI83E7n0O2MKG6z8XFWD/fwB1/NlU=;
        b=cXIULHX7l2kCbdgweWpT6wO76CxZ3fog0O+ftbbX8SGv7Nxis2qBMza0Vr8K061IzZ
         LoHGfUygICxHb32R7cPkzTqV8Ja7UjfLss9jFh4cdvUoci20HPOtSXrvSfq3bYnmUemN
         zWvc5dUJZAjOpGRQgXO1gt9YUdg+b9gSuYcCW0KS/TpckCWQtxIma9dNQDPf9QFwUg30
         cJMXb2np5GCxcUJu+jp4YWXJ4+ywJKpWP1LBe+KknWZpdmgPf6cFkPEcpsk6NrKooiDH
         6HDRMxOJiyUUAKspy9hsw8c2ZGiUqXcW3Ef0zmrH9NDL0nNPPxQWfpR2Eflh1+imylJV
         CYFg==
X-Gm-Message-State: AOJu0YxljzWp0y4AKL1y/YfMkgMEOfagUk4mNPyfHjFvJf66Jd5DEx//
	kBPlIpmYx/vQwBfwNKvqOcu9Vayq9HEW
X-Google-Smtp-Source: AGHT+IFBMS98ev18K5CCqSy+R0w7E8zpE02hjacSLoes1p0CoPx0LYl4OIw0a8QDivY2BnRe7IVZHg==
X-Received: by 2002:a05:6808:11ce:b0:3b8:94c0:87fb with SMTP id p14-20020a05680811ce00b003b894c087fbmr440439oiv.9.1704855729132;
        Tue, 09 Jan 2024 19:02:09 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b1d0:e755:54c2:4518])
        by smtp.gmail.com with ESMTPSA id s7-20020a056a00178700b006d9b93ca5e2sm2442043pfg.146.2024.01.09.19.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 19:02:08 -0800 (PST)
Date: Wed, 10 Jan 2024 12:02:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Miguel Ojeda <ojeda@kernel.org>, Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] Compiler Attributes: counted_by: bump compiler versions
Message-ID: <20240110030202.GB1282549@google.com>
References: <20240109133633.1103876-1-senozhatsky@chromium.org>
 <20240109153249.GA205400@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109153249.GA205400@dev-arch.thelio-3990X>

On (24/01/09 08:32), Nathan Chancellor wrote:
> 
> I should probably go through and try to update all the other
> review.llvm.org links to GitHub as well...

It might be something wrong only with the counted_by() link
(https://reviews.llvm.org/D148381) as other reviews.llvm.org
links seem to be working fine.

I randomly tested https://reviews.llvm.org/D75044 and
https://reviews.llvm.org/D123515 and they don't 404, unlike
counted_by() link.

