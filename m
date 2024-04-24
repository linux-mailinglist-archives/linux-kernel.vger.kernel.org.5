Return-Path: <linux-kernel+bounces-157204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830D88B0E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237281F2518B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3B615B97E;
	Wed, 24 Apr 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="a8qYTfmX"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B9A15EFDB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972625; cv=none; b=kKYycrCFf3jdP7t+SwuMKTDHzoFto8eN640fcTt22RovZWfvk5cjfWY15rHn+5m/iDFOPRnoE0yGRlinobrZSwiDrxWlv1SF8pb/yP2CzMmoyCJcZfgaLqW3JIr22cIip3WcIbt8Ebm+Vd4c5Pi2a6EXWcu4ab6yA0RQ8xHlZeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972625; c=relaxed/simple;
	bh=WrxU+iK2u+Wu8wwi+GibzMLwpaSndL/Suh4PRa2Redw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFFaYGB4oeTjN+1eGpu84xobl32IcqgpLnZqnzsbqEOV21o5/ksra/vAFOApzegu13DrdcxUBZGTBc2gFKwUF9NteSHdUne1nJ/TzZBr58Pr78+Ss8/he9BLltrq35hYDecVG4KPGcZibiIlcs+K4RZD6XEQW0zAO82I/Af/y90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=a8qYTfmX; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51abf1a9332so7481050e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713972621; x=1714577421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kN0hHEeupGSSgCE7fWY20jL26gsYlFQ3vjjtg0lU+j8=;
        b=a8qYTfmXzFdX9chUZKS0GFutyxQUkwaOQe6UtpXzDk6CDXoDnOJ10Ao5XsA15vL8UE
         JLD2oSv3RkajURDTH6HrMNZPgRIgScZaLyW/4rKMAlIVESjMDJEwEJnb6EUX/c3x4J2W
         eQYqRBmKgC9yZuwhH+EpqU9jNp7G3T7odjIs63yNmtJE+pICNvzScGNR72qbcwiAnWIO
         Uf9JPkYlQmpbNNVshUxP3GqHfaTRIQei5FabfbNqStblqfrLb8AtyZIfTQUCH9HyyMC3
         qCODIre+yssNeKv1mY+LbsvYV11bHg7ExEtATNtEMd74T5uW2vGcPdzys0wv5rPB4nDG
         jvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713972621; x=1714577421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kN0hHEeupGSSgCE7fWY20jL26gsYlFQ3vjjtg0lU+j8=;
        b=ovaafhRun3YHdiPsV8jQlGcK2x9f2IeQKyo4bjGRUI2ryMmBz9PbpCN0x4bu7fyr2d
         /ciiihiONZdqYSDAYmvDCIF6zK2CQEiM4JcMCjkmFl4D7jzUNjtqQsKEdmTiepI0PR4y
         dXhxkoUkcv4EDEV1XleiGi7HljvgcmAoXM4kRDOZYSybt8+Yhh/LRNT19xqEDUBfqfsj
         5jIEux4m8FdqR1ysCD4qVaE5bGGdTR6Bq0Fq/QNTCL9THNIuI5HvOnssm1bskBeWeOjP
         w/pCuQo4LccEtrqb8EiWmxC1ft4X8p3lwCj15W4GExrv4+Czaq9QWfFQKdkdVRtzwbhv
         BHoA==
X-Forwarded-Encrypted: i=1; AJvYcCVNeWh8aTuVe7EPaXMST477w3jLMAfq7wzfd9cJ7LqLLjnEioVRHq6dTyof46pP8Bo5DRlmlLFu0sVqOYJzBrio+lF7BHyvmrqXQmdf
X-Gm-Message-State: AOJu0Yyzhn7Bld1GAHE+rNk13Z+0bLd9R8Tz63+VAm4ULu/zFndH6RV8
	3I8+DufFEztRjIHmi1NM3anrnyROGdKETFp0TMWRBSesNtnqeDNZnQnsmQi6wboFj4Cm55f/mog
	NS2DHMxMt3A1DKw5P0O3FmClVEIDo1a8HmfKreQ==
X-Google-Smtp-Source: AGHT+IGn7KAqu+nR5bhFS2Z9m9gErGRNbgsG77V5JtQm/T9HJ5ODX/t/kTmqfxILFhpnt0Rc/sZLPz6eLDRVfdL0fe8=
X-Received: by 2002:a05:6512:287:b0:516:cd83:a96a with SMTP id
 j7-20020a056512028700b00516cd83a96amr2069705lfp.37.1713972621326; Wed, 24 Apr
 2024 08:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424122932.79120-1-brgl@bgdev.pl> <0f8ba1b5-490e-4961-80e2-7942f66730ec@linaro.org>
 <CACMJSeuBCkNyaD60qGVpAq91DqD_OA=tCVEY0t+JNK2vcWBc+Q@mail.gmail.com> <d82c2e39-d2b8-4de0-a11a-6ab2420f8f95@quicinc.com>
In-Reply-To: <d82c2e39-d2b8-4de0-a11a-6ab2420f8f95@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Apr 2024 17:30:10 +0200
Message-ID: <CAMRc=Md6yJ+ZMd7PD6ifQW4me1JLg3m6ZiVAMvbo9QaOH_jmaQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, quic_zijuhu <quic_zijuhu@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wren Turkal <wt@penguintechs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 5:24=E2=80=AFPM quic_zijuhu <quic_zijuhu@quicinc.co=
m> wrote:
>
> On 4/24/2024 10:52 PM, Bartosz Golaszewski wrote:
> > On Wed, 24 Apr 2024 at 16:46, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 24/04/2024 14:29, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>
> >>
> >>>               qcadev->susclk =3D devm_clk_get_optional(&serdev->dev, =
NULL);
> >>>               if (IS_ERR(qcadev->susclk)) {
> >>> @@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct serdev_dev=
ice *serdev)
> >>>               qcadev->bt_en =3D devm_gpiod_get_optional(&serdev->dev,=
 "enable",
> >>>                                              GPIOD_OUT_LOW);
> >>>               if (IS_ERR(qcadev->bt_en)) {
> >>> -                     dev_warn(&serdev->dev, "failed to acquire enabl=
e gpio\n");
> >>> -                     power_ctrl_enabled =3D false;
> >>> +                     dev_err(&serdev->dev, "failed to acquire enable=
 gpio\n");
> >>> +                     return PTR_ERR(qcadev->bt_en);
> please think about for QCA2066. if it is returned from here.  BT will
> not working at all.  if you don't return here. i will be working fine
> for every BT functionality.
> NAK again by me.
>

Luiz,

This in turn is an example of Zijun making a claim that looks like a
legitimate review but is simply untrue. He's done it several times.
I'm afraid that it may affect your judgment due to the confidence the
claims are made with. As Krzysztof said multiple times: the
device-tree bindings for QCA2066 are very clear: the enable-gpios
property is *required* and so returning an error on failure here is
correct. Even changing gpiod_get_optional() to just gpiod_get() would
be in line with what the contract in the binding document says. Even
if we relaxed the bindings, returning here stil *IS CORRECT* as if the
enable-gpios is not defined, GPIOLIB will return NULL and we will NOT
return.

Bartosz

> >>>               }
> >>>
> >>> +             if (!qcadev->bt_en)
> >>> +                     power_ctrl_enabled =3D false;
> >>
> >> This looks duplicated - you already have such check earlier.
> >>
> >
> > It's under a different switch case!
> >
> > Bartosz
>

