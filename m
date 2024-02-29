Return-Path: <linux-kernel+bounces-86559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B962F86C70E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4459A286566
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F2279DCD;
	Thu, 29 Feb 2024 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvCjNs+C"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D857995E;
	Thu, 29 Feb 2024 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203018; cv=none; b=FoyCb9BT6pRRcqfuMUniWmNx5W2lEtPiYzifamjaPag4qPQPoDSIzl56imp6pDcxRZyEg1yi7B7WS4qdaopxKrmGaj5R18maCWyYOfGwWUxphwD798LOkcsDKhM0AKwQgXAqio3y2DVgY06qxBgDUO8uJga/PASW9YVjzc0k33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203018; c=relaxed/simple;
	bh=Bsbvr0XH+zc8GCj+JI/JzIn86gN+UlJQiaX4Au6r7U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtDi2TpLhTVc3wVeN0M8C0hlKJMWqps42foff0gCLqN56rLg2ZqAf+qlxyEPmC58gRXn3j+OApBgO9X5oOvqJSNrYJ8O9ISi8LT7uROFsFtLWk6ulCAhpNnx8e6jhs959e2CIen1lS6kpHNgK13SVo/hcSK5V9nK1wVLpWBk1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvCjNs+C; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-565b434f90aso1128588a12.3;
        Thu, 29 Feb 2024 02:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709203015; x=1709807815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1NlY8tMN7P2Y6bWlORzMKpAclH/YyADf97OHECAI4Q=;
        b=TvCjNs+COqu/8jhd2Q+IWnTyg9nvyegB1GT8+SXzmiNcrNWjd8Z77pD/9sWB5WAYwd
         /cJ0VbdJaghZPWd0wNzojy7QsZxQagHTm9k5WcRZ9+631/ZsqQZRT7Yb0pdkaaV5y+xo
         QXeyLfvv6qhVFvg/0d7uRbI48C1yuKYLHWkPuDN/xw+kPsQTGprVJI7IyiYUU2r8xMtQ
         OniIsRoR8nBxAHhmvI1zpJmo7lMysNAAT/yoM5148ZjpVRIflvxRjZE/tNPPdLs6VRus
         3kprKC0rQvKUH3GV/TZJOR95aB3HIVxVQ78N1cqjBu/7A59wLkgME5yrYAI6bWwJcsUf
         xU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709203015; x=1709807815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1NlY8tMN7P2Y6bWlORzMKpAclH/YyADf97OHECAI4Q=;
        b=imEv6GcUKuru8htq1mX52G9TgECvK17/YgyOLB2L6lqkq2NLDYMOSBlX4Tjq30hY26
         A/P2IEVd0x35CZcZ/WOkDHXPJt1qjFeBSBd3PLBNTrykX65UYTanDXyQpxqOR7dFU7un
         M25anddkQrOTtosoG5kFrLufsivivLXHSpniWK+KFrfRVS6jtMl3Gz8pEdo54msxv26i
         9SFObTG70AtV98fDZsCXX9KjugiY+2EIHRS4sE11ZflNFAG8jt/yy8RKYKwPBRsZxKpI
         dXORoTF7EXU6+j0DlJ1PLqNqXc8fGfmk//QAaKF5cqWcJrJoaAugZvImpRUMuqvHEDwM
         O85g==
X-Forwarded-Encrypted: i=1; AJvYcCXV6B9yFUfZDGSnbSW+kWOTmPOJ2X6X99aBFZf7nUUqDlYO3szj4QniVHnGuJMSpaF4CdE+bceUnpPEBuNAWXpUgsE2kVphkwV6E/GOmFpHxr5ouU0xtlr3pPVxIAyN0B4WAXggBNAQNDbXjL+HRuria+jn+zS0fJV0sxtW0DWb/+m44ZZ/okLLsxCY1dETIjwlQY3dYqm5Wb2X8FNRZ2d5S/Tv
X-Gm-Message-State: AOJu0YzmX7FmQC71iN/Bs3y3RRAZppLmLADgAlNe12+54nwxLxpIP7O0
	LA6D7YbUhb0XYWBuYgS515cS/zckle04ok0tH19IKymqU+VBaF10vAgNVM9Rq6kgRcxxbaWn/ew
	sTpJOb0c5zwjM0xLhz/FMqGWHzMBcYdFp/No=
X-Google-Smtp-Source: AGHT+IGjKN7QsUcypeAA5SHqe0dGglsBIpMg+8XvC9BB3DHUw1Cx+eFzkMZiBo687XNl2n8mZmBho32y+QVbvKVpSLw=
X-Received: by 2002:a17:906:278e:b0:a3f:c4f9:eb16 with SMTP id
 j14-20020a170906278e00b00a3fc4f9eb16mr1185894ejc.20.1709203015072; Thu, 29
 Feb 2024 02:36:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229030743.9125-1-lukas.bulwahn@gmail.com> <87plwf8t3p.fsf@intel.com>
In-Reply-To: <87plwf8t3p.fsf@intel.com>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Thu, 29 Feb 2024 11:36:43 +0100
Message-ID: <CAKXUXMzySDQfuF7+AY77hXQbP0GuNMwdTrx6w_1ZP5R4O4kNqw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] docs: submit-checklist: structure by category
To: Jani Nikula <jani.nikula@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:25=E2=80=AFAM Jani Nikula <jani.nikula@intel.com=
> wrote:
>
> On Thu, 29 Feb 2024, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > from Jani Nikula:
> >   - turn categories into subheadings
> >   - use common heading adornment
> >   - change to bullet or autonumbered lists
> >   - propose those changes as separate additional patches
>
> I was hoping these cleanups would've come *first*, but up to Jon to
> decide if that really matters.
>

I see, changing to autonumbered lists could be done before, but the
subheadings only exist once reordered.

I am still in favor of the squashed commit: we are talking about a
very small document that central content has not been touched for a
long time. It is not code, where someone would bisect into. So, the
history does not need to carry every single stylistic change as yet
another commit.

Jani, I can do what you are asking for---but it is certainly going to
take yet a few hours to have the commits exactly into that form of
stylistic changes.

Let us see what Jon thinks.

Lukas

