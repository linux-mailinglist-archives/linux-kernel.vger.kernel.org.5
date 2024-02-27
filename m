Return-Path: <linux-kernel+bounces-83651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ED9869CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A794E286CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F02219ED;
	Tue, 27 Feb 2024 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xg0jJgD5"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB8200DB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052646; cv=none; b=kaHfpHA7Lbi8zeAlFIgxsFH/svFz7bGMCz7bFd/oDpaKJ8A5vp3eZl9ltMFRKkwuXGcxEXIR2+bG5yVPzv1SvFqCoDrchaxIsdAFCrv9cti/XFFHxx8XxARsk09VwbiwxXASuvY0dEZ0OaDo2ztHxiZYLEuTMArkwdt99orS1pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052646; c=relaxed/simple;
	bh=JZiZB7SeymVQjyoZ3I3h+TPhPreTAgThGsE/ai3dA+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NISPt6BHBDKR8aSObZnpyUmSIHtm+LcIk/udF2+QAmDYSpcd8cX0XLaTetcMVJOfs8hnn0JcjvdGUcm1wL5thBlwByaA3a19lfYI2s/xCqLOUono4dJqtKWc1uu2hGjORviHAMGhr+/Z2EkWF/u20Z419k9JTxJOIyNjbTK/n7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xg0jJgD5; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so5849535a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709052640; x=1709657440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZiZB7SeymVQjyoZ3I3h+TPhPreTAgThGsE/ai3dA+w=;
        b=Xg0jJgD5c3vfvMdkPnlrJ+e7CA+kjRBJuK/jQKt1BUSvrp4GKz/PQzx9xTAojB3WTL
         MiGsF0BibBwVLZsDrqdvag4nWA2cu+q/n2M/PwvHUHeljfaUH0CSLMPSiIfKFR7ECh4I
         0+2O06pTIGoTt4vSwT6CfB3IX25eCb5tRgGNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052640; x=1709657440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZiZB7SeymVQjyoZ3I3h+TPhPreTAgThGsE/ai3dA+w=;
        b=uJb4HzHTz7Y4pDu1FEPulG/OPWZ43LVwueUSFKx1lwSMPCUfEwB7Bzeh4R4PnrQgQW
         D3TwjRpQUGdLpcAyqsycmmj0W/ezHLifHFEQU2wqxnwDErQONQ8BHX3Fy7k0lF7AGv/8
         eH0ZfgxAQNhEEQ7JgOUgb3Oza0xC2kqSCX3pCSY3iP8uM9I6u1zvF6Src5qHlgerOn2i
         8/8TCBsjoHUi+Tv+3SH/wU5k7X/OtEk1OXR3zUl9Gzx7QKRcJsQ7czs/JHCceXIpHcAB
         h2ST1WzoW8/hYXzT+Exz8rnuq8MPlkIXi2RCSfMJnEUi+dev9Uee7wALlTmIsKkebdq9
         NQiw==
X-Forwarded-Encrypted: i=1; AJvYcCXMMEAaJnrcHshEi2GM5hvdiZdKVNe8R7ltu8qsovzqOa0mBugYHaVRSXML45lCCFMWMS+ZPaK6R5c+O5snD2W3tXuudgV8nzwpMWhy
X-Gm-Message-State: AOJu0YyULWjLVCqWj0aBjfd4Fp8GdfOk8fnMHolv7qCdBgVDlibYMgam
	F4w/LseZsS1P3zmcM0YO5BUQmXX/KRo2Bl5dosGr69MUanDOst+uafNkm6hRzI+MG4COB/cZbxc
	bdG1Q
X-Google-Smtp-Source: AGHT+IESoTEu36nzmQQ0byb31AA1eydTY4KYjLtKBSrxByX1Qj57cSIJM3yGt26wYXtGfCs3nE8l2w==
X-Received: by 2002:aa7:d0ca:0:b0:564:dd13:56e9 with SMTP id u10-20020aa7d0ca000000b00564dd1356e9mr6919069edo.29.1709052640488;
        Tue, 27 Feb 2024 08:50:40 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id j21-20020aa7de95000000b005661a50b7c5sm920466edv.13.2024.02.27.08.50.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 08:50:40 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so72085e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:50:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSP178wdP1ojWQZRXfes/OK+WrORcw4n13ZNeG/k+N8IRFT/tEJzXHiPtmnyJN/yBoGFjJrNEI5TkXNzimxbYb47nMejilSelXDddV
X-Received: by 2002:a05:600c:1e02:b0:412:b008:fe7c with SMTP id
 ay2-20020a05600c1e0200b00412b008fe7cmr90371wmb.5.1709052639020; Tue, 27 Feb
 2024 08:50:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <20240223223958.3887423-2-hsinyi@chromium.org>
 <87wmqqjmt9.fsf@intel.com>
In-Reply-To: <87wmqqjmt9.fsf@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 27 Feb 2024 08:50:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W+fRDOS01LKkeq-k12mj6jnFu5LOc9jAE3LA5w2ubo5g@mail.gmail.com>
Message-ID: <CAD=FV=W+fRDOS01LKkeq-k12mj6jnFu5LOc9jAE3LA5w2ubo5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm_edid: Add a function to get EDID base block
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 27, 2024 at 1:09=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Fri, 23 Feb 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > It's found that some panels have variants that they share the same pane=
l id
> > although their EDID and names are different. Besides panel id, now we n=
eed
> > the hash of entire EDID base block to distinguish these panel variants.
> >
> > Add drm_edid_get_base_block to returns the EDID base block, so caller c=
an
> > further use it to get panel id and/or the hash.
>
> Please reconsider the whole approach here.
>
> Please let's not add single-use special case functions to read an EDID
> base block.
>
> Please consider reading the whole EDID, using the regular EDID reading
> functions, and use that instead.
>
> Most likely you'll only have 1-2 blocks anyway. And you might consider
> caching the EDID in struct panel_edp if reading the entire EDID is too
> slow. (And if it is, this is probably sensible even if the EDID only
> consists of one block.)

That makes a lot of sense! Not quite sure why I didn't just read the
whole EDID in the first place when trying to get the panel ID.

-Doug

