Return-Path: <linux-kernel+bounces-35844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE6883973A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FEE71F2B36C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A5281214;
	Tue, 23 Jan 2024 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SXl8Q/ec"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F208120A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033194; cv=none; b=KXXBM8X/YdSzjcqeQAx8s8pyofBPjNrm9KxPfLZQGPmSHFGeBvDVp9EXRAQnTShK+9aLGaPPKWDfrfOYLRImb6CdlCC5nZYDQRCeEj0MoB3RBiubhZWK8tX7QpdyoIZbTI7GNjiVrVhkHlE4zhc2sKLnceVAqIq0nAiseoPH4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033194; c=relaxed/simple;
	bh=DSKd2JcJ2/mza9EM+Xnm+jdVYiFpr3Vkuf4kEF/SCIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNBOifAECOqZCM5Fa0yWiDOn7eaNMIuDIliOX2oEftKK9khXPfvCYcGUSiXryopLIFLN9PwVhT+YiR6oaicDpoBjoO3lTqs+hNqO5247GwvvUnYLCPV3dUrR0OHtwhPvk8QqtMmKmxAu2FyTkkWVLIR2eE2zNkBHxMQ2cjFYWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SXl8Q/ec; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a3a875f7fso5091673a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706033191; x=1706637991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sPOVFQl2tkZfe3QyiMSbVqeq8qtXQuoltOLEZXEAb4Y=;
        b=SXl8Q/ecMZB/UMQysXz88PMxEHev6hL077NpL5gsMW0TCuAY6Qi4bOPVjKrRIksIgR
         x2PfsxlrYyrbtec2IZKHXirj/fN+YmY2ITshai5EaHMNKEezjye6HWUsAwvkgJ6KEQ1Y
         wkDBxgZphwqfTAI2QGvHisqkiDS+3EfNAzQp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706033191; x=1706637991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPOVFQl2tkZfe3QyiMSbVqeq8qtXQuoltOLEZXEAb4Y=;
        b=e97DUPTzNvWWPrvxVjDLyjwV6FVQMtWO+1qd6vzwZyf7iAd7dhPLYldu6q7GQznYFO
         QYPjEAkrYIaSmGJoFbwAhivLLCWx0vJdMsruCgjOLwvgcFKWe086n1ZOVkoeenQNGIap
         2TiHs69qIB2D9OkDG0dxPuNseVx9zAvnitZ8Ueag1HkcPZ2k2qCzKItl0wzjPPSZxOII
         Uv9SxAm5IfsIVingyGRkZJcwNKYxfGqDGWHaC2sjHXdpBMNvBe7+h6E+i1dpMoRR+R6Y
         mPLM5BUxeBlnj8f46UCVGoBx2OxX4XYZdss4pWhvCdOqI/7pnLBasFqbRDUSCL3HYt+6
         vyCQ==
X-Gm-Message-State: AOJu0YzzqU31KgjEzSrPpoqHjj/PDfOUZjHJJXBhUE9PRxPRRbfYtO7T
	J60XYWvx5H8txSpM8hFgTgQfTOED95dnAoPOr106Xd+5z32DV4f/oObSlN+ifsD9QgnZIljE1B7
	jOKPMlQ==
X-Google-Smtp-Source: AGHT+IGuCpCKRJ4FDd1KtYXNPnslibBkt0oY7DoecV/2/jGdZ6Krdp+ioznD2JIKYpXi+We222DN4Q==
X-Received: by 2002:aa7:dd44:0:b0:558:251b:3bd1 with SMTP id o4-20020aa7dd44000000b00558251b3bd1mr1078528edw.37.1706033191009;
        Tue, 23 Jan 2024 10:06:31 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id x9-20020aa7cd89000000b00558e0481b2fsm14224968edv.47.2024.01.23.10.06.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:06:30 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40ea5653f6bso43304865e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:06:30 -0800 (PST)
X-Received: by 2002:a05:600c:42cb:b0:40e:4ab9:70df with SMTP id
 j11-20020a05600c42cb00b0040e4ab970dfmr368030wme.245.1706033189635; Tue, 23
 Jan 2024 10:06:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-34-keescook@chromium.org>
 <CAHk-=whS7FSbBoo1gxe+83twO2JeGNsUKMhAcfWymw9auqBvjg@mail.gmail.com> <202401221713.3FCABC9290@keescook>
In-Reply-To: <202401221713.3FCABC9290@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jan 2024 10:06:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgMPVv-mDxA2qcywpLCRLojtaKmP13h7bVo4m=XN202xA@mail.gmail.com>
Message-ID: <CAHk-=wgMPVv-mDxA2qcywpLCRLojtaKmP13h7bVo4m=XN202xA@mail.gmail.com>
Subject: Re: [PATCH 34/82] ipc: Refactor intentional wrap-around calculation
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mark Brown <broonie@kernel.org>, 
	Mike Kravetz <mike.kravetz@oracle.com>, Vasily Averin <vasily.averin@linux.dev>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 17:38, Kees Cook <keescook@chromium.org> wrote:
>
> I've tried to find the right balance between not enough details and too
> much. I guess I got it wrong.

My complaint isn't about the level of detail.

My complaint is about how the commit log IS ACTIVELY MISLEADING
GARBAGE and does not match the actual patch in any way, shape, or
form.

It talks about completely irrelevant issues that simply have nothing
to do with it.

It talks about undefined behavior and about a "unsigned wrap-around
sanitizer[2]", which is nonsensical, since there is no undefined
behavior to sanitize. It literally gives a link to a github "issue"
for that claim, but when you follow the link, it's actually about
*signed* overflow, which is something entirely different.

And honestly, the patch itself is garbage. The code is fine. Any
"sanitizer" that complains about that code is pure and utter shite.

Really.

If you actually have some real "detect unsigned wraparound" tool
(NOTE: that is *NOT* undefined behavior, and that is *NOT* a
"sanitizer", it's at most some helpful checker), then such a tool had
better recognize the perfectly fine traditional idiom for this, which
is to do the addition and check that the result is smaller. Like the
code does.

See what I'm saying? The patch is garbage. Any sanitizer that would
complain about the old code is garbage. And the commit message is
worse than garbage, it is actively misleading to the point that I'd
call it lying, trying to confuse the issues by bringing up things that
are utterly and entirely irrelevant to the patch.

So:

 - get rid of that commit message that is lying garbage

 - fix the so-called "sanitizer".

 - stop calling the unsigned wrap-around a "sanitizer" and talking
about "undefined behavior" in the same sentence, since it's neither.

Do you really not see why I think that thing is actively *WRONG*?

           Linus

