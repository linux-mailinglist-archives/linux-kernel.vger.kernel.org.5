Return-Path: <linux-kernel+bounces-56765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E66084CED9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0055B22958
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BEA5A100;
	Wed,  7 Feb 2024 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tEn9GZR2"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA287811F6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323190; cv=none; b=NKS2hY+khZzW83llL82zq8ygPT8ndrY7ZVlG8HQ9UNCvILqkpoZQ4YIAIguHpR3xgtpCCpKIq9enSjW55fSt7clQhDU6rm3fD8w9F4Asw98/mmj9Ojq+YHhgUmbjiwibMC6ynpsfH34JAO5XZEKKkIj0ULCH9ORGtejcUWodWNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323190; c=relaxed/simple;
	bh=s/XBm+dZXo326rp4+k8nxRmZZap7vVe94gNKobiXRkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dey3T1GqjUwkpBepchP9MRr+7rgxQqokZ5Ccqk6Nx6iMO/KFEgSb/W7yLNa0KpWccHWepcBj+Woe9pY/m5zW9OkPeKCSsz+UcqH5wa9RFi8IPrQzi+8QFBOdNWxqy34ZiWtxc8a3fWucv7eNM84Pv+w2uP24OCVgq6D2BYP5ICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tEn9GZR2; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-46d1a0c3d3dso218605137.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 08:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707323188; x=1707927988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WitkzYepwCuA/S4ttZlXhAljZ+JINQO7bz0r64E60hU=;
        b=tEn9GZR2YW5QIUhpfy9WbjVoRZUSL8A4E2UxFn9joY8wr7taRtruBFS5ZDP8cbC/PE
         +rY/R+HXqckBU0/cXttDcGD8TCgthunpbB4V+xxuVs64YsAYfzGTEsPkWv0siLLFEIJt
         q3DRPVhLVBcUb5jBXacEuRnI5LYw3CQmqxcHc5jRCIqyXO9Rhtg1XmecZnDl43NRf/DZ
         Ma9XYvgXTZFHFCFw4JMHkOKYtcBvEqC1yVzvOe6OgZF3+3A36F8PJYG6fEx6CLDNeUpA
         GiD81yogPwnuljwzAB75RmxCo3njmj1PQmWCi6ASwK+B3pAMs3hRAFhoYC2KTb1nhvBd
         uLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707323188; x=1707927988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WitkzYepwCuA/S4ttZlXhAljZ+JINQO7bz0r64E60hU=;
        b=G7xGYsHKhwFcwyw9X+opVbfK0tszUYJaerb9iqrSPUIMYeUlE6vpy0EKr3oDoG/72a
         iVMaMvVnOpdjnERE7rk+s9YtOVOqrjMizfdAQp7UQv/HkjWhOUZ2Sph/hFLf3MKDuFXc
         Gmes/Fi8E9/Y1U9rsKLEOEkdxTRtDD2pz/XuRowbqvaHY+26w4GQAptVIZ7G5SLD3rP6
         mBb0W35GUpT8z7fYXYMBJcGjPHY23b4Go30FQjx/eLSg9tpPVDhKcjDFdKq6j5C/A/nN
         7PNdrAOB3UvvobUmsQF5mdEgabQ7mipGgrt8PW6xCXAVfexL33cqPcWmmPtBO3GNckgz
         TDVg==
X-Gm-Message-State: AOJu0YxNsyFsVB6g7ZM0y9dVfcb8J6XN6unojav2kPUuKTUVYyNCrSkr
	4AXz2g3H5JA9TXY1MLkj2vdUur6LTCd9NGYhjTN5xn5Ka5OveemAxQAMHEQvUwBibeoNORM2ZcX
	1SmV4LygP2LBoNVgUIPK7KmjX/seyKaTDEuMltw==
X-Google-Smtp-Source: AGHT+IGUHF6vzAm6fF7RlJC8wV7QGPTkkEw3A+jO1stlUQVB3BJSXCPScQIS002+UPorZpqyfxR0CW3Oxe6kmokSvso=
X-Received: by 2002:a67:f597:0:b0:46d:295d:1c5a with SMTP id
 i23-20020a67f597000000b0046d295d1c5amr3129996vso.30.1707323187759; Wed, 07
 Feb 2024 08:26:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201155532.49707-1-brgl@bgdev.pl> <20240201155532.49707-9-brgl@bgdev.pl>
 <7tbhdkqpl4iuaxmc73pje2nbbkarxxpgmabc7j4q26d2rhzrv5@ltu6niel5eb4>
 <CAMRc=Md1oTrVMjZRH+Ux3JJKYeficKMYh+8V7ZA=Xz_X1hNd1g@mail.gmail.com> <2q5vwm7tgmpgbrm4dxfhypbs5pdggprxouvzfcherqeevpjhrj@6wtkv4za2gg5>
In-Reply-To: <2q5vwm7tgmpgbrm4dxfhypbs5pdggprxouvzfcherqeevpjhrj@6wtkv4za2gg5>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 7 Feb 2024 17:26:16 +0100
Message-ID: <CAMRc=MfsdsD4f3sC-BnR_sqvaHNEKWCZ+Xe+-ZhLU8vFYA06=w@mail.gmail.com>
Subject: Re: Re: [RFC 8/9] PCI/pwrctl: add PCI power control core code
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:52=E2=80=AFPM Bjorn Andersson <andersson@kernel.or=
g> wrote:
>
> On Fri, Feb 02, 2024 at 10:11:42AM +0100, Bartosz Golaszewski wrote:
> > On Fri, Feb 2, 2024 at 4:53=E2=80=AFAM Bjorn Andersson <andersson@kerne=
l.org> wrote:
> [..]
> > > > +             break;
> > > > +     }
> > > > +
> > > > +     return NOTIFY_DONE;
> > > > +}
> > > > +
> > > > +int pci_pwrctl_device_enable(struct pci_pwrctl *pwrctl)
> > >
> > > This function doesn't really "enable the device", looking at the exam=
ple
> > > driver it's rather "device_enabled" than "device_enable"...
> > >
> >
> > I was also thinking about pci_pwrctl_device_ready() or
> > pci_pwrctl_device_prepared().
>
> I like both of these.
>
> I guess the bigger question is how the flow would look like in the event
> that we need to power-cycle the attached PCIe device, e.g. because
> firmware has gotten into a really bad state.
>
> Will we need an operation that removes the device first, and then cut
> the power, or do we cut the power and then call unprepared()?
>

How would the core be notified about this power-cycle from the PCI
subsystem? I honestly don't know. Is there a notifier we could
subscribe to? Is the device unbound and rebound in such case?

Bart

