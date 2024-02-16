Return-Path: <linux-kernel+bounces-68200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419C6857723
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E751C223FC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F1F1798A;
	Fri, 16 Feb 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD/y4WVK"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB21862F;
	Fri, 16 Feb 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070284; cv=none; b=AdloBJTre22CrdaANU3zN3XPbGgIq60sy+qKXPODw/7VUlsMgq8Hud5X8Vn1H4KZuYI7ORIXjsf9mmIp4qQIf6DmEvin86inNkPZ2RK/uFuuPL1h8OYN9phiHfbganv27UN/KP2S7HLkKh5rZ/KbB5mi23IQobvglMhD8aQgPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070284; c=relaxed/simple;
	bh=IMCn/KbRTTOy8sVJnXNQvVorjuMToZu3rWEVAtMRjPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsbrQ378oau1190oDP+iF3jiqqs45tTMpMwZzUSoROtUnV3KyUg45dcN/S8eQf90UunnFY6Pr5kcBF4McTVO5GWbeksFfGWhrT7Efi511n919NB7xrOB/UfbFD8iX8yrCV1fkZQXPqh/YNwOspdJYVVp2hkvFDDR8vt4OzHCI9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD/y4WVK; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ddf26eba3cso1124241a34.0;
        Thu, 15 Feb 2024 23:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708070281; x=1708675081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POEMjz3b23hmzDB0K4YDGFpioaBiZroVLqRFNjzcDCE=;
        b=kD/y4WVK9ylVyz1furNOKehjozRZrNNfS5/OxsdV0vg2obC30Hd/OG0OW5FkgUJBQa
         xI6OeoCyF5xEeNgLpzTPJt5AqBKLmJLVdjNR3Ox/8MwsmjtryC0N4wOMnzyoFsv93fnE
         dUGKSfTGVU7cpmjcED4ZYt6aWwRsa8GmMGZLiijUnVpgBH6wZVbfhTZoH1Sjr6V7g32P
         IqdNHE0GMsilsYn+V117vSXwR+npbAOvJTi/whPQqEC+tazJz+xzsFoEIPJRA0Y4lPtN
         FZNG2Mpvfc07VH/VsvFZuMW9muFIJ1F77LVS81X1yuJKEc5v/zpvbqlFVBKez0OJfgZz
         BclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708070281; x=1708675081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POEMjz3b23hmzDB0K4YDGFpioaBiZroVLqRFNjzcDCE=;
        b=qPwKMC8iBYdBQP/eAPVq8a/1dyzPL29C/mUKabZ0tWz7S9HMOzVTYFkvb0SgPZrhtU
         GBoKNKc9JqLftaTnWgvP8wblo/YeL1SPF+VjIrYZH1U0iNH0bUhDOcTf2L/yRLUu85wg
         hV9QkndjOwhBhnOhDEA16C4PsHrABnZinlPe7MxiqEdNBYaIjM6bj8mmxLhV4hcB6HcV
         U0nSP+p9BfII9NkYJA8+J7iDLDsjXQXLhdPptrbdeLgGeEMi4nLJkbl8b9bqd8jx0Irw
         PxzaA6rRgRFqo2xsdVWTUSufFlAjm1Usg9d8LkpWfCEwGWEXC+mlet+uiOpJul+mqhy5
         BGYw==
X-Forwarded-Encrypted: i=1; AJvYcCUliQ9wA/l0cJa7YLABZynfq/mIfep2RqF8myZ1B+qEbKBeGRf2xqdG176vCTzhy6Xw+Z9fvENEjvwepoUsQEzUYO9XfvWcDGF8
X-Gm-Message-State: AOJu0Ywhkg/ORKdRSlMfInqFd0sShwNpXiDHQr97Zy+UaY8nvvrB1rQM
	2PIFSNAg7vLJqTcN8ZQw0ouG6jSqR70a3mytkwhvUXCq7pxM/bdN
X-Google-Smtp-Source: AGHT+IGI3wUngQXwNdiSmgffYSbfgMKumVuF3hLEQl6ycD6iocCVev/hkGJ35EWLeBJMpxsYkrIYSA==
X-Received: by 2002:a05:6358:5e86:b0:179:2d7b:26f3 with SMTP id z6-20020a0563585e8600b001792d7b26f3mr4922653rwn.3.1708070281329;
        Thu, 15 Feb 2024 23:58:01 -0800 (PST)
Received: from pairface.. ([111.18.146.226])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b006e0a304609dsm2586694pfh.179.2024.02.15.23.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 23:58:00 -0800 (PST)
From: Pairman Guo <pairmanxlr@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pairmanxlr@gmail.com,
	shuah@kernel.org,
	valentina.manea.m@gmail.com
Subject: Re: Re: [PATCH] USBIP: Use fallthrough pseudo-keyword
Date: Fri, 16 Feb 2024 15:55:23 +0800
Message-ID: <20240216075711.6752-2-pairmanxlr@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <2024021516-chapter-willed-ccf3@gregkh>
References: <2024021516-chapter-willed-ccf3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Feb 15, 2024 at 11:14:49 +0800, Greg KH wrote:
> This is not needed in a changelog text.

Thanks for telling. I'm new to lkml and still learning about the format.

> >  tools/usb/usbip/src/usbip.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/usb/usbip/src/usbip.c b/tools/usb/usbip/src/usbip.c
> > index f7c7220d9..ddcafb5c7 100644
> > --- a/tools/usb/usbip/src/usbip.c
> > +++ b/tools/usb/usbip/src/usbip.c
> > @@ -165,7 +165,7 @@ int main(int argc, char *argv[])
> >  		case '?':
> >  			printf("usbip: invalid option\n");
> >  			/* Terminate after printing error */
> > -			/* FALLTHRU */
> > +			fallthrough;
> 
> Did you compile this?  This is userspace code, and as-such, I don't
> think it has this keyword, does it?

I'm sorry for my hurrying. I ran ``make tools/usb`` with no warning or error,
so I sent this patch. Now it turns out ``make tools/usb`` doesn't cover
tools/usb/usbip. I tried again with ``./autogen.sh && ./configure && make``
and it indeed failed. Since usbip.c doesn't have any reference to
include/linux/compiler.h, it cannot use ``fallthrough``. Thanks again for
pointing out this error.

Thanks,

Pairman

