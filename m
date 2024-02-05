Return-Path: <linux-kernel+bounces-53173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C6584A1B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A8B28533F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462DB45C1C;
	Mon,  5 Feb 2024 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXVwPb+G"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15964481C4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156013; cv=none; b=UAvSbczQQ6rXT85fctQe1AxBtkPowZoeyfiAX50rKfSYHVFDZOufQnBlaXqVuAsdKGqiHUffslr9VUK/HU9Te0Zy5q46qFw07ewoz7fx8KLD4S1RylbTxtB7dN/36Kg+R/eJjwHFo443I1Rd+XZFEXVkh9l7W+o1QXCpvmGE+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156013; c=relaxed/simple;
	bh=kNVLmD+nntAII4cMKnywO33WfR/o8cc+6O9xDPD4+Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzY6++8qxtow43xUMgXSp7757dv5REXv/VKyKtwUhdfqZVIBKGGH0MQcq8IPvNp9rGMT3ZNgV/zNdIauOw9y/+3ii+IUGmBI3Rqgxgeyir4ElEcKblmnVpCPNt1HBhGDgcNW6UrpEzHYPYLBICM4OtJGf+Hadj2P9zYDXNHaAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kXVwPb+G; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40ef9382752so8395e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707156010; x=1707760810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNVLmD+nntAII4cMKnywO33WfR/o8cc+6O9xDPD4+Xo=;
        b=kXVwPb+GDE4+oAde6GqMHCc7D0kj4jGBzyCiMOE2uclSEC+6Ksw+cUIl+hpe7yMaob
         etkvzIK6jFRoc8pgGOuNqZwiyJB5eKq6wuB6MkWnauUaBolRBORpBIBrQLr2Q1xwER79
         fm2PsAadXJjQysxMGK+r6J8h7G+4BI0EsYWu8/a9Y7KPrx6BkjYAsyNn0vKHN0CQWeAt
         O23Vsqyxu1PWaUE/XSEt8cSgCKQTHJ16l18tUfQ4ieyas3Y4rwWBgk5lMOllam8mwJZ+
         g6RJp2kK94w6AQVQQp5YbQ/ljLN3Mro0yHGm404Fm5PLKcQadDKR7BSeDq6G/aNInln8
         IfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707156010; x=1707760810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNVLmD+nntAII4cMKnywO33WfR/o8cc+6O9xDPD4+Xo=;
        b=ecKMzsusYDSkOr8UCmatqP8bmKC73s3Qn6Fq914iTRXoXRHxO0DUUYd4f2x2P6oK8D
         SMtnM1I6wgxfH8yiML5CM3fSJ2aO9gNBc9xZzrDhJHPnS/KGeSIvHIgm5YsZyLFSGUCD
         kF6Bjh2LjW4VofwXEusyXdx9hoXRHV0mBQq+io/mKkzhPrrht+twNV/ofb6yyD5lnzdh
         k955iUEui63cvTlpgXZcxRMDb4vo0AE6fbyCAszYd7sU7nsILnmjP8aalCLlFCTMSxP0
         cbdfCTujlwxEAyIQmVdIpBTev7WnO1l2zl0S5a3/wG0Kj2kMn01hHuwb3EVaZYwQl0Jc
         KSLw==
X-Gm-Message-State: AOJu0Yyefy+YVmFeXJ4AsbPDD3gHvEnUFH/zOTm17Xjmg1BRi3SwJdJG
	pjLYbGJHW0XZAIuSFaIkGJODxVGjUTEBoZXpHnT62doGX10DIwV5O33T8YTHPz+BjX2PdOOvicD
	sTv7LM3JKaMFg/0MKaEZghtt/3D8WPPyvD7Q=
X-Google-Smtp-Source: AGHT+IEhxb82tzAwrYSTDxKMIjl01gzXjFRBczzjo0A59If9c2msCIu4Up8c6PsdAioTpB3O9oU4b76SLiGDiiALAbc=
X-Received: by 2002:a05:600c:4e47:b0:40f:df17:f3e0 with SMTP id
 e7-20020a05600c4e4700b0040fdf17f3e0mr13552wmq.7.1707156010351; Mon, 05 Feb
 2024 10:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204-bus_cleanup-time-v1-0-207ec18e24b8@marliere.net> <20240204-bus_cleanup-time-v1-1-207ec18e24b8@marliere.net>
In-Reply-To: <20240204-bus_cleanup-time-v1-1-207ec18e24b8@marliere.net>
From: John Stultz <jstultz@google.com>
Date: Mon, 5 Feb 2024 09:59:58 -0800
Message-ID: <CANDhNCq+BB7sAO4xcBzBbQr275cuE002f8RGY6U2XJBQQHHrYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] clocksource: make clocksource_subsys const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 5:39=E2=80=AFAM Ricardo B. Marliere <ricardo@marlier=
e.net> wrote:
>
> Now that the driver core can properly handle constant struct bus_type,
> move the clocksource_subsys variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>


Acked-by: John Stultz <jstultz@google.com>

