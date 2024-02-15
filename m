Return-Path: <linux-kernel+bounces-67601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC70856DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A1FB241E0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AFF13A257;
	Thu, 15 Feb 2024 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WdBuzJY6"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38124369A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026080; cv=none; b=FHYlRFynVHCqTCcm534zmY3R5TypZ4iLwFno8AlVKqfT1+z22mn6TZ7PhoiwMvyQbjt/iULZ9myZurJzxsCe+Ylk7gRxzNYsmAzCYR+MxKtRxdtecShQR6a1LvmdfOSjCvEBRsRxF+R0uOLjPyb+ENjERvb005RNjgXGDK6D9IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026080; c=relaxed/simple;
	bh=js+qlWFrKknlzpSM/jHeumdYYFRrXXK6eHPX6OIlimw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5GIz9TmsQfTQ4FHhRPd2DsUnuoHhxWeLFht1ksRVK/K61xth48eUAE9J1lt7spKIqMKansRn57GosIUac5p4Bzf71C3r/n/BEnfcAo423zGf7CrOkLtc0wKlnVX5UhIVPUdz6nmVLlpa+AQRpR6ahMUuY/qWbJ0SVsXDNAKZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WdBuzJY6; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0fd07ba8bso258321fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708026076; x=1708630876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQxAkf7EqPypbKDt7TF564JQz3o1NG3h/y6tnCm919U=;
        b=WdBuzJY6F9RmTXl3ZWTFenhzz6iu7+kZ+funjhVkmerM3n8/yikd9CW4MJ82eFtNEf
         j9+Zgk6Alv6es4kW0Ei2i0CaSixr2HhRcpTB85RhZawZr9oWeweRR6jymNL7Qo9/Rplh
         JC+Q6QOFW7RE6XXsaEzhlZrQdJ3ZSHLkT/ep7zybD+Xps8P8s48/1BppONJtNAXe75D9
         1wY1JCCpIxZOuXyjqGHSWOSgoMU24yP0zt5+kf5GwQpmgr4MLdMIAE0BglRQoUVRfpCC
         VWQY2oRPd3OY6FJgrdS38qGc7LXkgsmNSR3g6jwtBug3/nLkcGZ0WQK8/32KRcSNUT01
         wAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708026076; x=1708630876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQxAkf7EqPypbKDt7TF564JQz3o1NG3h/y6tnCm919U=;
        b=E5TyhPhCfOyBYogSDxeYQZLWWcODAYns1uDVG8KBRqIUi2ZuA7dT67cx0E9TcuGUwP
         jCkfzJGK/DY3xW9QPe6GBe6eyp/+UCSJDWDenfImesnl/b4ztxYYcmIWOOyXlygOKECT
         ztUeAxlPyyfMIXFQHSZGlKuCFJNwG/1XTCWmSMyiLsmAyIzdUhIt7SbmTT9RnnnVx0aP
         cP28jSaktGqmZFGrMBXflOvW1xwP9BnPypV7E8QRrfuZj91lO6WIBIk1bJr4TUj0Og4A
         4s2Ee8EWe9fliF8dxn6s54F1y6nx6Eu5zQZ9iBqYTCU+tms8fW+dMVCQfiul2X6bSSmh
         ho7g==
X-Forwarded-Encrypted: i=1; AJvYcCV7k5UWXqvUf3h6Uw4vALaxaB3MRpt7weTXOTtzKeE+TzWYDxOi4dUyPFh1NJMLQKQvnYMPl+sAUKGk9lnFQYUGwx4Skv74TsokoERd
X-Gm-Message-State: AOJu0Yz6Wv+ThtKZV7n7H4ea8pZmmY7S/IQKwJmhBRNoh7Nt1geA4zEu
	diPAjT13BWD8i1LhhGur8FyQnCMGoyb7k+B4sE5YV0avpiesaSkxiflDo5B62HLPHe0XKzpT7+c
	sAbrRHS2jCKt1XOnP9fQTLy21HC6kCdRo+Cpczrjc7r6HV/1W
X-Google-Smtp-Source: AGHT+IGaLUecbQLl+A3MjPIa33yQd6792UQFHM7WieWYCW/N5Glhw64W5IKeX8TChIWL9iYW98ZO7IXec+SL3o5WvnI=
X-Received: by 2002:a2e:a4a7:0:b0:2d0:908e:d825 with SMTP id
 g7-20020a2ea4a7000000b002d0908ed825mr1938523ljm.21.1708026075691; Thu, 15 Feb
 2024 11:41:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215145602.1371274-1-max.kellermann@ionos.com>
 <20240215145602.1371274-8-max.kellermann@ionos.com> <Zc5lnHpYWmuX38_o@casper.infradead.org>
In-Reply-To: <Zc5lnHpYWmuX38_o@casper.infradead.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 15 Feb 2024 20:41:04 +0100
Message-ID: <CAKPOu+8-nbMpi0WKFUAp4eap1BNYnojcVcyNU1wug9ibxvOtqQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/14] linux/mm.h: move folio_next() to mm/folio_next.h
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 8:27=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> I feel there's a lot more you could say here.  Like "There are N files
> which only include mm.h in order to use folio_next()".

You can see this detail in the last patch (14/14), but if you prefer
to have this spelled out here, I'll amend the patch description.

Though I only worked on the headers, not the thousands of sources
which might also be able to reduce their header dependencies. Getting
the exact number of those is a huge effort, and it's worth it, but not
today. Once this patch series is merged, we can incrementally start
this, but these patches are the precondition.

> Otherwise ...
> why is this more than churn?

This is about code correctness and faster compile times. You may or
may not value that, much of this is really just opinion. Similar
efforts have been merged recently, which is why I thought this goal
was consensus among kernel people.

