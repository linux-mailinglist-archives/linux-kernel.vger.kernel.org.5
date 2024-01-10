Return-Path: <linux-kernel+bounces-21662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4628682928D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B52C288081
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456C02579;
	Wed, 10 Jan 2024 02:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FPm+94mZ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F34A1870
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d54b763d15so15381095ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 18:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704855380; x=1705460180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Cqsu0sVJlmIzMpcIruHiSjowcwNftxKzZNL1LWKgYE=;
        b=FPm+94mZHeke6GkUW3YdzzIhmKooBc1EEhE6dcDtgS+C73yWAxJBFBz2BYSVTlOz+1
         7GM7sLjC7YYHfvFeBqr2GINGVHtn/vd60gzcUebyQfaPRTMnlCSXEcz+N8qVUvm8QWGF
         As1cftU+lYuDLb/v8Zs5pWM0ZgpW22RNfChXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704855380; x=1705460180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Cqsu0sVJlmIzMpcIruHiSjowcwNftxKzZNL1LWKgYE=;
        b=ASVRE6XV1UJQcDd/DE40eP0b5F3bye4yFkbbBY5bG1WHn9HrmC/kKrDzQ7/1TB9p96
         4tYWlLp2MdX6Q9ua+IDClSJTo0s77jBMSvW1F84cQxin9Q1GjCncPz3psvLK1lRbu19e
         FYuHOoeH/LtVH3YnDxS13hDSbaXM4Z8pDF2eO/GQQxw4WOf0IeFDUIv7fnIIIPny3v++
         pkZdPDprLWTryHZM5ODMYgt8pW+jTbjXCW6sNA7LHWbWyhqxglQtMAiUJNUae2bFfQlC
         Z/1EXpP8JcbwsXJOXy3kLgKqkSBLz7wzxGlB3Qf9fhtuQdbPNDkmtzf3DzKKV+YFJCAM
         ZDUg==
X-Gm-Message-State: AOJu0Yyw5+czVpVjabMj1lbxnDFpYn3TrFkASAf7BLqvfDFwbSqX+TgT
	V8cwQ7xX1/oV/Wso/2RwQV/UUKoQoHXs6FiRfiwuheTJ1Q==
X-Google-Smtp-Source: AGHT+IEngKshpq/yhOR1WVK0GZhLIsH5bOdw67YXV/WIQFr2uAaYISZM9GXBETQxfJL/bytuG/mwLA==
X-Received: by 2002:a17:903:32c7:b0:1d4:c97f:e6e4 with SMTP id i7-20020a17090332c700b001d4c97fe6e4mr349227plr.80.1704855379715;
        Tue, 09 Jan 2024 18:56:19 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b1d0:e755:54c2:4518])
        by smtp.gmail.com with ESMTPSA id jg5-20020a17090326c500b001d4ac461a6fsm2521332plb.86.2024.01.09.18.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 18:56:19 -0800 (PST)
Date: Wed, 10 Jan 2024 11:56:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Kees Cook <keescook@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] Compiler Attributes: counted_by: bump compiler versions
Message-ID: <20240110025614.GA1282549@google.com>
References: <20240109133633.1103876-1-senozhatsky@chromium.org>
 <20240109153249.GA205400@dev-arch.thelio-3990X>
 <CANiq72kjHCh-inyv1aU=eNca1-+E0_85MGU-8qbZZtzbC_VwOQ@mail.gmail.com>
 <20240109195652.GA1253215@dev-arch.thelio-3990X>
 <202401091311.08D6FF677@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401091311.08D6FF677@keescook>

On (24/01/09 13:12), Kees Cook wrote:
> > If I understand the doucmentation at [1] correctly, the first round of
> > testing starts with -rc1 and ends with -rc2, so if the feature is not
> > merged by -rc2, it won't make that release cycle. I think counted_by
> > might be a hard sell even after -rc1 because the feature is not exactly
> > small but it is also not expansive (it is relatively self contained
> > from what I can tell). So I think your plan is reasonable.
> > 
> > Another alternative would be to split this patch in to three distinct
> > patches, not sure if that would be overkill for this though.
> > 
> > 1. Update the clang review link from reviews.llvm.org to github.com
> > 2. Update the GCC version from 14 to 15.
> > 3. Update the Clang version from 18 to 19.
> > 
> > The first two patches could be picked up immediately and the third one
> > could be sat on to see how the review and acceptance process works out
> > over the next couple of weeks. Up to you/Sergey. Thanks for taking a
> > look!
> 
> Yeah, I think either the above split or just wait until the Clang 18
> cut, since we've got a while before the next kernel merge window.

Thanks everyone for the comments!

I'd probably prefer to split the patch and take the obvious and
trivial fixups now, and once clang -rc2 is tagged we can return
to clang min version requirement (if we won't forget :))

