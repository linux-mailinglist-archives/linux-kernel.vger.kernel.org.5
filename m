Return-Path: <linux-kernel+bounces-74410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC86585D3A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26B81C216B0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C356F3D572;
	Wed, 21 Feb 2024 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CeCAWyFr"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237445977
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507717; cv=none; b=HmJWcBuXwGyVM59xAxELDJLUmf2GvxpOWQ8dbJNJV0y2rnzX6TwJXd5M39gn6PSikT23l5h/XC06v6/apn1yRTcRQ9KyjlPkNh7WpqI9uwXY98GkPa1P/e7QF8sFbDT2MLtsL0ZvvK9LdnnpOsP0NR1XCylvjzLVip4BuI+HKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507717; c=relaxed/simple;
	bh=Hq8KJ6FUW+dUn5EF4x4k+Yc0eSHWRUNZYxQmVAAMYJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mo/XZQTQHiYSRLWeOMAnHoBCudeE134z05VwCPJsr9NVDC2h77pJ9Ryi8RME4HBMaYDEeZaRRTsNMtI3eC5bWg0s0QC7FRzIJ883uKK/vRPIGn5E9JaeY61Rnr+bwvUdDvQIuGKXiSuplkzml9bdo5BXWymNonGFd4YUhLbQXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CeCAWyFr; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60818d338bfso34852097b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708507715; x=1709112515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hq8KJ6FUW+dUn5EF4x4k+Yc0eSHWRUNZYxQmVAAMYJc=;
        b=CeCAWyFrEP23vabvzE9+4zzalLAR+p93QODZQ9HwjaqT451oHESJm3T3jyCJ3m5bOW
         mrbi3cbXF8JCNgEXFceTnb8MinIWXVWUPnSSoQMvEp/1YWTew6so6vjUubC12nzj4BXR
         3PWq1ulo7IBO3sTQ76GQeYG2gTJi2rmOuG1T3QLSJvmlErbBWEiJDc0foghpHrSDIFtu
         qjtPRfjKA+2CeXyrN+cmNPJRNnJOr3F24d1oXQRHfdZotXTnX4V/MMQQyWROklIBB7Oz
         Y4nRsvnAQD/dcvt6ac9OndehZLsxIEoxqDjMj25CAGxsQFRewZiJdYt6Pi1Vom7nHEDK
         jpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507715; x=1709112515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hq8KJ6FUW+dUn5EF4x4k+Yc0eSHWRUNZYxQmVAAMYJc=;
        b=iMFRSpkmQ4hJNoO11ZtKa2rDbJ2xQRmUZhboBaVhiEc6N3LIOJy5XqaeCfKEgM8fau
         YDYOr7jVATI49/i27Mf7R88fF75cg6KZ4nr7o0+3R6qSrKuwG1XVdPmU/dMbaJ4pR6xb
         HmTFUEEAqY6jeFr1x1KKLa3vU7WdBG/l6VHVJXgpIoQ0Bs0iYGvP19ZCxsKjKrHlqMAd
         5q2HPDOOzfvSpdV7TNd/W2aqmyE+DosXiupsqfr1EdraAZZCCgzqrbwCerMdpJHNDVh+
         Y/5EgRY5KhF1R/PC40cb4Zj0lJ9rzZubT4L5EakK7aFBkgrMBvDlBpAfA12XV8JOSHZh
         BMFg==
X-Forwarded-Encrypted: i=1; AJvYcCUyW9c6splakWR8UPU+rNwBj1UuB/am3W1EmcvKqhfGBcwQrZNBhOoKJVVrrd9iYKhLffJus3LgjmWF6GzEzUy1qtZuBg+HWYXl8azN
X-Gm-Message-State: AOJu0Yzrc57aG7UnYynWGOUlXF/HD0bGcbaIje/Q2/Mh5oBpe5ypu0RG
	VgcCslQAsq3DwjFjw2ft0QWca3TT1vHysY7X2b4fS3WNA42RNMNnsD49GvntB0nzrq+DobPcZIi
	lji28CpF2IymFFIwyXDqBG55gJZcTM1MS4jm8
X-Google-Smtp-Source: AGHT+IFVBpH9fLue/cQ4cgz0WNF2n+3fm/CyQ+oI4lMHOKKC2JD3RQlkGlCDrGZ/wN8PXmrbUnhNrhpJUikMVBqoPdc=
X-Received: by 2002:a0d:e8c7:0:b0:604:dd57:7845 with SMTP id
 r190-20020a0de8c7000000b00604dd577845mr17964155ywe.2.1708507715007; Wed, 21
 Feb 2024 01:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208152808.3712149-1-howardyen@google.com>
 <20240213055426.GA22451@lst.de> <CAJDAHvZGnzKPLaovRcq_Os1Fcixp2o1kY9GFV8VXztrmKahejQ@mail.gmail.com>
 <20240220055241.GA7554@lst.de>
In-Reply-To: <20240220055241.GA7554@lst.de>
From: Howard Yen <howardyen@google.com>
Date: Wed, 21 Feb 2024 17:27:58 +0800
Message-ID: <CAJDAHvbOnAvW5f6oJUnuy2_5-vS7uJc13GQSNX_Nc25GJXSp-Q@mail.gmail.com>
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems per dev
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org, 
	andriy.shevchenko@linux.intel.com, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 1:52=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Feb 19, 2024 at 07:12:18PM +0800, Howard Yen wrote:
> > I tried to upload the patch to support multiple coherent rmems per devi=
ce
> > because in some system, the primary memory space for the device might
> > be limited, so that add multiple coherent rmems support per device to s=
atisfy
> > the scenario.
>
> I'm not sure what the means.
>
> If you have non-trivial patches you really need to explain why you're
> doing in detail as you need to convince maintainers that it is useful.

Thanks for the response, let me explain more.

The reason why I tried to propose this patch is that in the system I'm
working on, where the driver utilizes the coherent reserved memory in
the subsystem for DMA, which has limited memory space as its primary
usage. During the execution of the driver, there is a possibility of
encountering memory depletion scenarios with the primary one.

To address this issue, I tried to create a patch that enables the
coherent reserved memory driver to support multiple coherent reserved
memory regions per device. This modification aims to provide the
driver with the ability to search for memory from a secondary region
if the primary memory is exhausted, and so on.

--
Regards,

Howard

