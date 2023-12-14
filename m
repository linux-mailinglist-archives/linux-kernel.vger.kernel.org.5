Return-Path: <linux-kernel+bounces-139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAAC813CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C78282518
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29166D1B6;
	Thu, 14 Dec 2023 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NkoL1B81"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593F454279
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d347b4d676so27660935ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 13:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702589951; x=1703194751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9p8Ajf3tFQXbwC42EgP/DdM/mZur4gEPrUVHC58JLk=;
        b=NkoL1B812AhnfwtL7DSfU4lFuIy9AvKrpEdo6WxTSeg70wXMdYo8BejFrKl5mwkgXr
         CoiaMKY+91+hQBQyj19hRCpw2NaLwL/4xycLOBTwuGjCYMFU95FjKBj0PipVAPmdXH+T
         Uv/E9iRxMGgBGOLQFvu5z35z4cc2d6jk0FHOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702589951; x=1703194751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9p8Ajf3tFQXbwC42EgP/DdM/mZur4gEPrUVHC58JLk=;
        b=kK8qcDid/iDU7bX4jcBbmtjF3DVpcynjFPHWIEICBBV94eo7ix18qDTHEGrrEyfeX1
         aVyotwu91mzfwfDcDyccDfcJ9mScwZgc92wmiXNjT7gtKZDOpYZKC7ruXZtwPifWqZJs
         XblNNMBVtg7neM0gu62HjUvl3g+kBfi4CY6jawMHH98w6roOrmZcy7U4kdwl90guqHwF
         cisBZ7yz9PIr78ovFm0GimR4hJdL0fA9U6Lhp7iPaAChyyzsNdFnn8byHw1ehL4sDR+G
         E3bwhkm5sNquJ4FbWSTTk5Z/0nie0LgVQyFxLHNiA0/OhwX363S4fGr0XF01IBHKIEK2
         rXKQ==
X-Gm-Message-State: AOJu0YyOpXHlZczrCbgsWULHCyXj688N4A9KJtDGlLUMnOu8ifhxHcpx
	kYJjNYAsTqjLUVasxkm2t6GEmg==
X-Google-Smtp-Source: AGHT+IEU6ftrI0VMvvVDF5jJLD9KtjtMPRzjUvkB4CgdFRkuRurVj+l8UJlY1TjY65o9czmfNcLAvQ==
X-Received: by 2002:a17:902:ecc4:b0:1d3:6b17:67c0 with SMTP id a4-20020a170902ecc400b001d36b1767c0mr1775536plh.75.1702589950824;
        Thu, 14 Dec 2023 13:39:10 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g16-20020a1709029f9000b001d3561680aasm3191596plq.82.2023.12.14.13.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 13:39:10 -0800 (PST)
Date: Thu, 14 Dec 2023 13:39:09 -0800
From: Kees Cook <keescook@chromium.org>
To: tanzirh@google.com
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] lib/string: shrink lib/string.i via IWYU
Message-ID: <202312141338.CAA7708BC4@keescook>
References: <20231214-libstringheader-v2-0-0f195dcff204@google.com>
 <20231214-libstringheader-v2-2-0f195dcff204@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214-libstringheader-v2-2-0f195dcff204@google.com>

On Thu, Dec 14, 2023 at 09:06:13PM +0000, tanzirh@google.com wrote:
> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list changing indirect includes to direct includes.
> IWYU is implemented using the IWYUScripts github repository which is a tool that is
> currently undergoing development. These changes seek to improve build times.
> 
> This change to lib/string.c resulted in a preprocessed size of
> lib/string.i from 26371 lines to 5259 lines (-80%) for the x86
> defconfig.
> 
> Link: https://github.com/ClangBuiltLinux/IWYUScripts
> 

nit: Please drop this blank line to keep your tags together.

> Signed-off-by: Tanzir Hasan <tanzirh@google.com>

I'm glad to see such a big difference with just a little header
tweaking. I look forward to more like this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

