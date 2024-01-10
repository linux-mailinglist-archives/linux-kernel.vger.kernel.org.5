Return-Path: <linux-kernel+bounces-21675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A080F8292A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 057C8B25A66
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C62D6FB8;
	Wed, 10 Jan 2024 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YEm1dQMY"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2AC6FD7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ceb02e2a56so1594635a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 19:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704856087; x=1705460887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAST3+ovgIXLtw+hGTF5zWstYPXDCThnu2Wi7q/0Obg=;
        b=YEm1dQMY63L7aI6DYZQYENWYK62wEYWnWd2uqQXMeyEEmnkVa4jYp0SjkQusKcKISB
         UzRenqqiFPH7QzW5FBiZAYzQUy6iUDMSi7ShjTgmdPX1UZwwLbqvmXT2bgomi4FWrqhA
         h0ptG8Dh2SVrndLpo4DFq2jvp6ICd3tf8igTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704856087; x=1705460887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAST3+ovgIXLtw+hGTF5zWstYPXDCThnu2Wi7q/0Obg=;
        b=W0+53rBwi5X2gSV8QzgEAcA+KkHiq/9M8iOYL+WreiYeMItxgMvZK2EFdD7R9SW6um
         JLwI2nSeFjAtoswOjGq5tO9xpscURmrO50iDyBO9cWXELDQhYmUlkqKI8uAvKL6a9em2
         1XSml9DN1kZIaT6L1HeUB1JexoTXmSUi7sfnX4V82ZnFMNLFb7VpGbOLSTyvYjBs9nta
         7NrJrAp3YNhFh8TVTlIO1266+V4aG4xghgjVQGxXGUxEGLz+8S2c8w/VyABV/inZPsYg
         ckFmR/6K7JjRDGdWj5jRidvgiywG+6pSQhTx1oUp2iEkxNuBkT+uXW0NGx0qFdZ/kBMd
         E8wQ==
X-Gm-Message-State: AOJu0YzMg3iVDKdaScTJ8thgV0yFj0BwK5xLwy5BUSDYhlQgq471XU+1
	mKg55ag2z/9z6B+kD28iUEsczl/rfCgS
X-Google-Smtp-Source: AGHT+IELTTb3rRiLIGo4JLtmWafjDdjYVKaF9RO5ET+SuDZnOI7c8JC2l/ZA0HQ5BoJQ8RxwkSh+6w==
X-Received: by 2002:a05:6a21:3396:b0:199:939b:c446 with SMTP id yy22-20020a056a21339600b00199939bc446mr235287pzb.28.1704856087048;
        Tue, 09 Jan 2024 19:08:07 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b1d0:e755:54c2:4518])
        by smtp.gmail.com with ESMTPSA id jh7-20020a170903328700b001d5087c5e7csm2515002plb.92.2024.01.09.19.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 19:08:06 -0800 (PST)
Date: Wed, 10 Jan 2024 12:08:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Miguel Ojeda <ojeda@kernel.org>, Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCHv2 2/2] Compiler Attributes: counted_by: fixup clang URL
Message-ID: <20240110030802.GC1282549@google.com>
References: <e1c27b64ae7abe2ebe647be11b71cf1bca84f677.1704855495.git.senozhatsky@chromium.org>
 <b7babeb9c5b14af9189f0d6225673e6e9a8f4ad3.1704855496.git.senozhatsky@chromium.org>
 <20240110030258.GB3624259@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110030258.GB3624259@dev-arch.thelio-3990X>

On (24/01/09 20:02), Nathan Chancellor wrote:
> On Wed, Jan 10, 2024 at 11:58:18AM +0900, Sergey Senozhatsky wrote:
> > The URL in question 404 now, fix it up (and switch to github).
> > 
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> I sent a patch series today for the rest of the tree, which includes a
> link to what happened here:

Thanks!

