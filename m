Return-Path: <linux-kernel+bounces-91810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BEF8716E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77AA71C22149
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED327F7C6;
	Tue,  5 Mar 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yXmXM8a/"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7617EEED
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623847; cv=none; b=UJlKtjyURCX7V9Ycwft+HBo1njQ2Lj3ClGfVGjiIijDVBtQ+ibuD1DH/8DP5/5oRyYxU2mQT+ye6YSk93iCf0I3bGdbl6nI+J+OgqIEnWCwz1ufqXpKM29DK6msozkst6Mr2yIumZwmKFlgDvQFdryKjkyOlYt1GyT1GT2GdMp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623847; c=relaxed/simple;
	bh=JxMJWefHrN2xWMKJVy6dbEDR3p279SBEqeGkUFqLaE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEvlUA3pVwEW7iVC2A9zJ3qGgJfVXpGqX+/cWoW0eDb3UQS3whuXUsO5RQH1fL8RsMdHB9p1aT72u6eP/2duYg6m0sXEkjFXhlu3EYnvq8cq/PjHwFrb0N81qhjj7+qGUqkwlxfJ3JcI65Wr2qDJABQRrvqlY9WTn8oL4/Gczpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yXmXM8a/; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-22008177fbeso3280863fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 23:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709623845; x=1710228645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Lqsx/Na/kS+EpQN17APKE3IWDFKUa3R8qNqcSW13CQ=;
        b=yXmXM8a/+VOCjpYePCP7CmitN/W5JbcYBhInwZH5VI15lQRgnt6x1pNt87zuknd2yb
         9c+yEGIjKg38djoaDcPbVjdnLy1KGTL/2eDtApw1l1QWe/O5qkVk9ZCtTBSZ7pLSaJmx
         iSrUNsuPlRrKBAPKQ+0lDIrY+cjyhCg8FWrE0BoLUx78hlip77pvA7pO6KLio2zDBjYJ
         diH6KNOMvc4U0L5pe/AKcwJlXpBmEUcGrx2/oWw5dXQXlBjR6V9ekQdyb6J7bAENq6Gb
         P727E3w0BUQEM5oJ6TQjkO2XfLpd4FswZ40uAUmxz69hZVI0DMFH2gD1wHywekKMv4zc
         RQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709623845; x=1710228645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Lqsx/Na/kS+EpQN17APKE3IWDFKUa3R8qNqcSW13CQ=;
        b=jZkPgVxQm/5BwvbVij7Hh5Pkv/kK5Sv8rVgF08e+v4lqwO3ke5SLSG7iLkbo4FsbXy
         dpFmq6febO7HIyJSh+yY4YkPXVLkigADvzPDj9+OZLwS8S5KKw2/Weq7M8vNHktiyeaR
         GCcn4PHmKbKbbAv0HMMjVCkpqpLlbhrjgBlSH135GNzj4QVHQxOo0AGcy3iipb/+NQJ0
         /Bs8guOo0NaG7df4hMd3sSxberDHxyROq0MaVUZdXjs+YsmR6OtXWy1o3WH5rtxYF1kc
         OwUdHorvnlz7nSKsHnFDnt3Ifn3x4QIBB1kF7QwZtX6AMSd4CC7iRxVqb2U4Kwln7zsq
         AP8g==
X-Forwarded-Encrypted: i=1; AJvYcCUWAnYqFWFzFM4+bwcqqD1XaFAVHDvpyBPE/c9YD/okZpBDq7roAJ/jMEKpZOGjr7e6whMrcfaz0FWyJ99Th9JZvqZfNmy3XLtdI1Up
X-Gm-Message-State: AOJu0YyiaRq1Scb7mSQaBwbwhlvlsE1ZJ88DxuqGmLQr3AD35nJvT84u
	vyEd57nib0P6svibT4WqYgoN1+3nac8haJwyOAljHQ/THxvLIN+1Xld24bsRtXg8SqUeyMbkfAM
	fASn3K5UuEENQJ7+hSJz5LHGdcizFySWK8IcAYg==
X-Google-Smtp-Source: AGHT+IEJtsflBX5yTywnnnWkm94+N3o/uTHl8/Onhn3k8/A44aKU5n7Iupnse7coXMHXndxpOp3bDLmrqALzP+xcd/I=
X-Received: by 2002:a05:6871:331e:b0:21f:d1e6:d8e8 with SMTP id
 nf30-20020a056871331e00b0021fd1e6d8e8mr1002794oac.39.1709623845033; Mon, 04
 Mar 2024 23:30:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305100727.004a6dcc@canb.auug.org.au> <154d19f0-1ed8-415c-8c3a-e15b9e7cd4a4@app.fastmail.com>
In-Reply-To: <154d19f0-1ed8-415c-8c3a-e15b9e7cd4a4@app.fastmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 5 Mar 2024 08:30:34 +0100
Message-ID: <CAHUa44H+u6E9EEyLGKK1wgoA0i1At6-VUacV=ovxjumsQos17Q@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the tee tree
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Olof Johansson <olof@lixom.net>, 
	ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 7:44=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Mar 5, 2024, at 00:07, Stephen Rothwell wrote:
> > Hi all,
> >
> > The following commit is also in the arm-soc tree as a different commit
> > (but the same patch):
> >
> >   1d044941d538 ("tee: make tee_bus_type const")
>
> Thanks, this was intentional as I ended up cherry-picking the commit
> instead of merging. I expect that Jens will drop this branch now.

Yes, I've reset my next branch now.

Cheers,
Jens

