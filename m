Return-Path: <linux-kernel+bounces-45681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CFF843405
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45401C2481E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9E1DDB8;
	Wed, 31 Jan 2024 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Yzg4GlwO"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23933D304
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668690; cv=none; b=cXSI/ZoPChuv4d1abgEVS9bquF5RvvyBmHSEmiN8IS+HjghXFIkTJ9ywgQRsbz1lSTILptDpw3RLbPd1ytYHDcGvUXaqKeih6oKHV0OvJHaQ7AY4J2ScvlSrCzAT3kBGvJLvPvrM7vXU2tAU12G+vWy9GNCMvkIWv5zsHYazpRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668690; c=relaxed/simple;
	bh=LGO4BdOvNZmc1lXwuOScKvZxhDaPx77tpjeDFBkTccE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXPjPk6cuYWE8h7v9/zpcMAjKsAfRlicXwQLS6AJ/F4Vvlthha75PCftx+rVEk8teyVeZ5dsvXN2YRmsJP4tBy//zfGXb+asWFjQw9+PfkXGkmU9ge5sPQVsOLInbVs3vOVDxuxqzLKGnp0pC1NFW/pshN03tFuh8EaLxhjd11I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Yzg4GlwO; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso5847704e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706668687; x=1707273487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=19aDwrdmn+mJoidoEhiPwZ55uaYowtebYP59bRAkETQ=;
        b=Yzg4GlwOoMM4n+vHoEGBxFzylZoVRgG01TGpQUShGA9DOW9WS4iUyDquoJ2qAGz4ul
         FxAOvyl/DG5nPoxarEWLKsUTRKhPSBdVXwlDVc8b0TP0Z5Zs87SguJ2kk49kNpoRIoRu
         E9MGGP8BoOnCdmDOIUNjP1FggdrpWSaQPuAaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706668687; x=1707273487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19aDwrdmn+mJoidoEhiPwZ55uaYowtebYP59bRAkETQ=;
        b=n2BqHccFzXbZPTxF3fsH6Mr6+pZdKx28JcacbEt27ni/4UFL2dxomJFgpZDXdzFbDn
         bFJ6xh+BqRipmOMUuRTHTejUZ2qx2PBqj+h3fcl9zr7qBiF9eIDRT+t28rP/D73NcFS4
         uiMPdNKNIc/sPU0xxKs2oOB4Y4rGKZ9+YBBU8ls4klL80OUdtt4RNRA2X3ul3NQM1+0O
         xjAvVttVjdwNVHYeKaddkPRweq2UjrOxbSVGWKoAFwVrewaoJb87UtdfPcNL89XYp/sL
         Bi+cIcuGIlDINgZ9IDlMf8LPEYpLdir+GPRksKkpxrhcg/BeoQh2ZS1SoFsr8e2YsMvb
         8UDQ==
X-Gm-Message-State: AOJu0YxD1VdT7CkjcgZYR7q7TO/bJ1y6d2ZKelRoGkPNGoRNfxxf/idB
	dKVdXo0Y2ITkm9Q0mXfyIE6xJ6XWy40if3EXHHazYNouqJLJyGkTuy//JcZ3p9pfvT69Orp3213
	+6iHihA==
X-Google-Smtp-Source: AGHT+IG4otHkOssX3PlGcH1HcP7HrdGmyRUEZMOZT8Wc493XHHmd9bRioyUM6+dQRmD086RlP5xJig==
X-Received: by 2002:ac2:4d9a:0:b0:511:1b51:cecd with SMTP id g26-20020ac24d9a000000b005111b51cecdmr317238lfe.5.1706668686833;
        Tue, 30 Jan 2024 18:38:06 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id b13-20020ac2410d000000b00510166b9e9csm1655175lfi.212.2024.01.30.18.38.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 18:38:05 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cf5917f049so36921811fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:38:05 -0800 (PST)
X-Received: by 2002:a2e:9c17:0:b0:2cf:2ba3:e3d7 with SMTP id
 s23-20020a2e9c17000000b002cf2ba3e3d7mr195592lji.8.1706668685355; Tue, 30 Jan
 2024 18:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-6-torvalds@linux-foundation.org> <20240131011246.GP2087318@ZenIV>
In-Reply-To: <20240131011246.GP2087318@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 18:37:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wie3VgLatmR4J_VpnyJR-qKppz=gnDfxEa9Gyy-7cH7HQ@mail.gmail.com>
Message-ID: <CAHk-=wie3VgLatmR4J_VpnyJR-qKppz=gnDfxEa9Gyy-7cH7HQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] eventfs: clean up dentry ops and add revalidate function
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 17:12, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > + *
> > + * Note that d_revalidate is called potentially under RCU,
> > + * so it can't take the eventfs mutex etc. It's fine - if
> > + * we open a file just as it's marked dead, things will
> > + * still work just fine, and just see the old stale case.
>
> Looks like use after free, unless freeing ei is RCU-delayed...

We hold the ref to the ei in the very dentry that is doing d_revalidate().

So it should be fine. The race is with eventfs marking the ei
'is_freed' (under the mutex that we don't hold here), but when that
happens and we end up still using the dentry, the ei is still there,
all the operations are just going to fail.

             Linus

