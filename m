Return-Path: <linux-kernel+bounces-163127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A866E8B661F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BAD281E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB93194C6C;
	Mon, 29 Apr 2024 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0wOqLas"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698517BB1A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432612; cv=none; b=lHS1qVZBAn9RcFOSalQRwr/dB+G/QXg5QqKLKHPese/+rxhx209yp4TrV2/DQIN9rdGdvt3OQ8DonJE+bsb/8UAdONvQpJeuen3xuwB+NsTi9oJBvipcnIKwwIDfWrucj+szDXMUxuHmY2S44rNWrnGYzKI994bITPRXlsawd0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432612; c=relaxed/simple;
	bh=mfLx3YYQYDI2fQfZd7hxAX01vHPJP0y0RCss9IRqtlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqRVtJ/eOusQZ2dzC61Bbm2qdqDBMUrPPvED8NrGUy97sN+mWsGJjuL2aLjHcZdrahEAxDMUWfBGphgICV14BcQdouaJctosz17FhxPEsYUgiYKLvIPv/lFVtx+6DnL6sZC34Zj8u7AUEP3ccpWiMiuBApG1gdNJ5q2GDVOjlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0wOqLas; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714432610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mfLx3YYQYDI2fQfZd7hxAX01vHPJP0y0RCss9IRqtlc=;
	b=E0wOqLaszoUyt59CBJS68HokxjfappOiQdKBruBnRzPKBnGME/Zy5catXlKyFlj8NJ4tZA
	bs4EUr1D4O2/eidhcJ9ELap1CvL0UfoWxDKr/wEvO1PcoHAMrvBO6X/GRDxcOHnqkRZCtu
	OxG0hwxrW0ylvcrRnemOvwmRFknGCIk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-0YsiVCZwP92iXS5qL2KrMA-1; Mon, 29 Apr 2024 19:16:48 -0400
X-MC-Unique: 0YsiVCZwP92iXS5qL2KrMA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d396a57ea5so4337732a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714432607; x=1715037407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfLx3YYQYDI2fQfZd7hxAX01vHPJP0y0RCss9IRqtlc=;
        b=pEts/YjyMqTqOYFP02IeGUmOA5/IEbhGouUMBMYNqUGYnsNx3kbxjZ/UOxU+d3kWjU
         Vv1U1z3dcHZsVUtFFYsLp7+YYHlZuBHMbAhcwU06F3LrZZTHu2XpMHKHQ2mSOnALhC33
         D8cBzXP+SWVq85BOIJPT/KFqfGHz6bEaAjCiu13GDHQSPHqDdthT3XVyfv4QI9tt9jw4
         mdzZLeIyNTYYNOTmxCYB5HtVsR67JKXw4pt01QoDJIzzv4uVyrg6btVr9kTtrcWLNkYo
         nex7xDAty7390dvSC4176ndfBU4AFqXzXYkp4MivcUBPJQa9zuLPW8KMbWfR1YAUFjB7
         ERyA==
X-Forwarded-Encrypted: i=1; AJvYcCUYAiX0TV+ebFyOAjQ32zFKmOSdF7TN1JUI2DQKm9CC/cVvvqsMc6IUSH30H3+14gYMu9+snqw/ODw1+fOREvfGbYHuG2mxkKsXkDAO
X-Gm-Message-State: AOJu0Yyeqx9RW7Hn21z1IYSIHM0OBX0qzYSYST2f1TH0jX6y3TYlsQTm
	p+2LZo4YTdbVXWnoqOpxJNFUFlC7zbBpYzX22FrT4ZoUhtf9KDJOyyxhUN0cydB4IrlZbUx24ki
	5P0UZPz8dHoR2a1zo5+hfkMPLkwbgRnY9ijk3ZhT3dXAxk5MvF4h8QwdYOm9oyCJVIU137pWWG0
	NlPSrlWXqJFrdQ8WCch4pjzdWBgmuQBTWgMIz8
X-Received: by 2002:a05:6a21:3d89:b0:1ad:ab1:9816 with SMTP id bj9-20020a056a213d8900b001ad0ab19816mr11473221pzc.22.1714432607709;
        Mon, 29 Apr 2024 16:16:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUZvpgPpaOa7H3d2aoUN1Xb/LVQlTAnMr5zKAT1c4HSshzaCk3AJvVbkJJT4xPOcLPr0FgQhO+FGEq+TsZz1w=
X-Received: by 2002:a05:6a21:3d89:b0:1ad:ab1:9816 with SMTP id
 bj9-20020a056a213d8900b001ad0ab19816mr11473202pzc.22.1714432607350; Mon, 29
 Apr 2024 16:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426154138.64643-1-lyude@redhat.com> <20240429182318.189668-1-lyude@redhat.com>
In-Reply-To: <20240429182318.189668-1-lyude@redhat.com>
From: David Airlie <airlied@redhat.com>
Date: Tue, 30 Apr 2024 09:16:35 +1000
Message-ID: <CAMwc25pVJccw6vJtzo9N5qPeKBOpnVTSpQn0TPt9bYx_ECcXqg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/nouveau/firmware: Fix SG_DEBUG error with nvkm_firmware_ctor()
To: Lyude Paul <lyude@redhat.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	Karol Herbst <kherbst@redhat.com>, Danilo Krummrich <dakr@redhat.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Ben Skeggs <bskeggs@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> V2:
> * Fixup explanation as the prior one was bogus

For v2 of both patches,

Reviewed-by: Dave Airlie <airlied@redhat.com>

Please apply to drm-misc-fixes

Dave.


