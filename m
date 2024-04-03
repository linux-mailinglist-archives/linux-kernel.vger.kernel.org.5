Return-Path: <linux-kernel+bounces-129216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B4389671C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51DD8B28D65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E560A60BB7;
	Wed,  3 Apr 2024 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VFy4ZSEC"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6C5EE80
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130449; cv=none; b=QU9zD68CghUrhaX51yIBBVQMsZbyYu4ghGmjazkF8pYP/AulYxzKspOlHr2EaCIHV/nIBMfOpJAZcFPRTzNpxPxeeGmtEbknL5gRlxxm/+BGxFTd/Jfc0icHbHwwxgYYcuVC66Vfvo4xI1Wa2P7JmkddiGFD+Xp4wukXWtuq92k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130449; c=relaxed/simple;
	bh=RKlf/aXBQSz4C5u/DS1c43o9FTCo579xxiqOL6jSNKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNx2xoNI8gsfqMWVOVm4qt53sD9ABXnqJtxnPAnED2mrFHpX6IojLkVHDZd5zeUrYr3zHn9ANltTegkcQl15hTnsnMnaCUP0uojohR0mzqT1Ckgj5EZjPvdRNpUkmjQKyU87NSfSk7gg/Y7YmeT3JUwiB4ojCX9Ow8hmsE6IFs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VFy4ZSEC; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513e134f73aso7960194e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712130445; x=1712735245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cheZvOcC88OGFbj70O09gAsWEwU7K3V+qd/tt+SD81A=;
        b=VFy4ZSECXxyd97ehUwk/nS0/q6C9mlFPZB3f7pI0N0xo8Jmw4E1YbB7m0aW1djqloe
         g09ytQVqjaZZmmm32EqUMCi8ZoEiJnRn/14jz+HmUgQMxKr9sB82iPt2XvjVDvlLAT7v
         /BFM18+Qo8WV930k71uZStsrjewGxFSyW45mOCQxxjIuaJtjcQs8dK7Ho70q9kBDm16Q
         4CcvCS5KwclPCFrjgvyO4OkhreVz1j/k0QXpSvmqTsn3Tpvp3VBpg6k13fbE13UrRKY9
         CVK9Dl/lMn8uhOkCP705N85nUZFduKhnUBS/6eFf/kQxYcZuGyGcJ0FxD/ZJs8mYEcv3
         Iq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712130445; x=1712735245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cheZvOcC88OGFbj70O09gAsWEwU7K3V+qd/tt+SD81A=;
        b=Y/0j3le7lHJCwenNMUR7G5GiOORhY33FSieJGOlUSEWOu/qLdQFFxyOmyNwRBPRD2M
         9WI7mvSeQusAOCRGYeHJdHN+UF4ptiE/E8PNPk3v+VutJY1wrpaJtFXtAZOr8EvjPb8t
         4M8/xnBk5C+/UYU0SzPLoedGX/4CykXvjGYu8Kjk48FWXjGr3P/f3hfXkIC++jaCLtR9
         evts0QCCOiUEVlILyAQjLinFYldAeBTAk6B0fiAG/zSxs51VyIcZq4nSMFC7hEZvX+g6
         NzJLD8mz4n9/1uLi8qOX+7Kmar634kzGIUr7YSIKW3L7Hz0IvLuLpic+JcGcPk0cBGic
         WZIw==
X-Forwarded-Encrypted: i=1; AJvYcCWBWlIWji4jt3Aq0qdxIvBr/qPKbF2TYz5vhkjtammttOv9L/7lJ0WAFvDWeoTkNFcT8xfvpswROcX3UgKQ9ZMCPewlVvwUCynN3Qi9
X-Gm-Message-State: AOJu0YzBKUQXncoAmbfHr5TQ3lv7VoEQzYOZz92vxsX7+RlDCizkiSuK
	o7TGYmHDc0S93v6YJu10k7HrSlFZwQkj9MH1oE+iXqiiN4Z+zkwsIqNJXrC3H6ETyj2HZ/xCD/x
	y4WVZiHNLUJUfNUYu98CNGeMfg8Sw5e1TL6N4hg==
X-Google-Smtp-Source: AGHT+IG5LvgOQGpY0trGQtWaTz+lv+ktFre9zbGKvzioVYu4AqCouNJCtNokmpW3qynaS7emWAxWzVE85+WNKemU6dY=
X-Received: by 2002:ac2:5d44:0:b0:515:d445:6c13 with SMTP id
 w4-20020ac25d44000000b00515d4456c13mr8905032lfd.32.1712130445446; Wed, 03 Apr
 2024 00:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325100359.17001-1-brgl@bgdev.pl> <56e1c63a-4c09-4d92-9ef2-aad5390879cc@gmail.com>
 <CAMRc=Mf_pvrh2VMfTVE-ZTypyO010p=to-cd8Q745DzSDXLGFw@mail.gmail.com>
 <CAMRc=MfsVWcoMC-dB-fdxy332h-ucUPTfEUMAnCt5L-q3zJxWg@mail.gmail.com>
 <82f94b54-82d1-49b9-badf-63d948b347fc@gmail.com> <97e1f121-9e84-4e63-9c9c-57e2de0b29d7@gmail.com>
 <CAMRc=McLJFGcy-A6PZNmjgDXnvx8z0J4k-Dbak-txvWnycHG2A@mail.gmail.com>
 <2b1dc031-d645-494c-9103-a2bb422ea60b@gmail.com> <CAMRc=MdoSPuedbGhy4toDEkw0vSzESDz2bXGpyt_=R4hqXW+Uw@mail.gmail.com>
 <9b1e5ea0-bb32-4c42-b2e9-204bde31b905@gmail.com> <CACMJSesvM6_PhhR_2sP4JX6bR4ytVVg=MwWBEVrCHf5FNp2JXw@mail.gmail.com>
 <9db0fc7b-f24a-4d76-b8bd-ec577ecba0c6@gmail.com> <CAMRc=Me9x1OXKXXxyhzZ6mxffmaoq=4QhMXCL6L71_xso2epWA@mail.gmail.com>
 <CAMRc=Me0MamtJoPtQnucKyZx9pfkEPDAAZqWFWRU0CBcj+P50A@mail.gmail.com>
In-Reply-To: <CAMRc=Me0MamtJoPtQnucKyZx9pfkEPDAAZqWFWRU0CBcj+P50A@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Apr 2024 09:47:14 +0200
Message-ID: <CAMRc=McZ9dpD7Ws0vq-eYCN3smA6dHOLu_i1BL=x+CAaYr9S2w@mail.gmail.com>
Subject: Re: [PATCH v9 00/13] firmware: qcom: qseecom: convert to using the TZ allocator
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Guru Das Srinagesh <quic_gurus@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 10:44=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Sat, Mar 30, 2024 at 8:16=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > On Fri, 29 Mar 2024 20:57:52 +0100, Maximilian Luz <luzmaximilian@gmail=
com> said:
> > > On 3/29/24 8:46 PM, Bartosz Golaszewski wrote:
> > >> On Fri, 29 Mar 2024 at 20:39, Maximilian Luz <luzmaximilian@gmail.co=
m> wrote:
> > >>>
> > >>> On 3/29/24 8:26 PM, Bartosz Golaszewski wrote:
> > >>>> On Fri, 29 Mar 2024 at 20:22, Maximilian Luz <luzmaximilian@gmail.=
com> wrote:
> > >>>>>
> > >>>>> On 3/29/24 8:07 PM, Bartosz Golaszewski wrote:
> > >>>>>>
> > >>>>>> Both with and without SHM bridge?
> > >>>>>
> > >>>>> With CONFIG_QCOM_TZMEM_MODE_GENERIC=3Dy (and the upcoming fix) ev=
erything
> > >>>>> works. With CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=3Dy things unfortuna=
tely
> > >>>>> still get stuck at boot (regardless of the fix). I think that's
> > >>>>> happening even before anything efivar related should come up.
> > >>>>>
> > >>>>
> > >>>> This is on X13s? I will get one in 3 weeks. Can you get the bootlo=
g
> > >>>> somehow? Does the laptop have any serial console?
> > >>>
> > >>> Surface Pro X (sc8180x), but it should be similar enough to the X13=
s in
> > >>> that regard. At least from what people with access to the X13s told=
 me,
> > >>> the qseecom stuff seems to behave the same.
> > >>>
> > >>> Unfortunately I don't have a direct serial console. Best I have is
> > >>> USB-serial, but it's not even getting there. I'll have to try and s=
ee if
> > >>> I can get some more info on the screen.
> > >>>
> > >>
> > >> I have access to a sc8180x-primus board, does it make sense to test
> > >> with this one? If so, could you give me instructions on how to do it=
?
> > >
> > > I guess it's worth a shot.
> > >
> > >  From what I can tell, there shouldn't be any patches in my tree that
> > > would conflict with it. So I guess it should just be building it with
> > > CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=3Dy and booting.
> > >
> > > I am currently testing it on top of a patched v6.8 tree though (but t=
hat
> > > should just contain patches to get the Pro X running). You can find t=
he
> > > full tree at
> > >
> > >      https://github.com/linux-surface/kernel/tree/spx/v6.8
> > >
> > > The last commit is the fix I mentioned, so you might want to revert
> > > that, since the shmem issue triggers regardless of that and it preven=
ts
> > > your series from applying cleanly.
> > >
> > > Best regards,
> > > Max
> > >
> >
> > sc8180x-primus' support upstream is quite flaky. The board boots 50% of=
 time.
> > However it's true that with SHM bridge it gets to:
> >
> > mount: mounting efivarfs on /sys/firmware/efi/efivars failed: Operation=
 not supported
> >
> > and stops 100% of the time. Without SHM bridge I cannot boot it either =
because
> > I suppose I need the patch you sent yesterday. I haven't had the time t=
o
> > rebase it yet, it's quite intrusive to my series.
> >
> > I can confirm that with that patch the board still boots but still 50% =
of the
> > time.
> >
> > Bart
>
> Hi!
>
> I was under the impression that until v8, the series worked on sc8180x
> but I'm seeing that even v7 has the same issue with SHM Bridge on
> sc8180x-primus. Could you confirm? Because I'm not sure if I should
> track the differences or the whole thing was broken for this platform
> from the beginning.
>
> Bart

Interestingly, it doesn't seem like a problem with qseecom - even if I
disable the driver, the board still freezes after the first SCM call
using SHM bridge. I suspect - and am trying to clarify that with qcom
- that this architecture doesn't support SHM bridge but doesn't report
it either unlike other older platforms. Or maybe there's some quirk
somewhere. Anyway, I'm on it.

Bart

