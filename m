Return-Path: <linux-kernel+bounces-76871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3DE85FDF3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092751C24B63
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5F8153509;
	Thu, 22 Feb 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PYcpE/Dg"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C01534F5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619074; cv=none; b=NWxx7ElMYb/SSqpUeqALE/XtlFp51RqrWKprZQhNr7G6THEhUTmOxgp0mMndiGmQfznM4qSkuhbyiMddfAIzDnT6JLv2tjrPt7C4CB3MfgBs+yx75CdUqkTaYbtvNB+vIiAw19ScDVLIWKfyLk2DKaJEWJ4pv3MAA17t0QV4GIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619074; c=relaxed/simple;
	bh=O1kCwimtBhHwx5ieCprlpCnPISoK/7BjHdqpNvWzRM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFa6+ft2SeHko4KDopf9GSGkpp6r44dsBnI3hgPvu6CyGFPOp4Pzvef3bVOfwp+/nnoviHPHfXKbkAkCopZvSrTACNQAOtUddKThOTeNq13h2H3lZHwg4gzydTj7MnLi6RMpJgnRChZXKzqUSzjSljaXAxMQPvFCcvhr71TeDpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PYcpE/Dg; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7ce3c7566e0so3758068241.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708619071; x=1709223871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHZNKNWPjrBTR9qsh5AP/XHTKz3QTL5wx4YnCqn5+DU=;
        b=PYcpE/DgCwu+2rPaVfFCbRKG71tw7dsQi3mw+eOC5DQy5+PFYHrCGjalqQcI0M6AE/
         z+JmQ4IuS2qjItdvf6zhM3hORQdbO8UMSGDiHbY+dpX+rFKA6BdXEkQA2YEWxd3/XTFC
         aGPttOeStYVmRcmaDLmAM0cEqyKUvCMBehTZZzhsZVBFk//21MPvjIjC0RvFQvz5sqsH
         mIN8hz+Yg87lSMbUWkSjy5T+uii3gO1D141PukAdYAKF5gslBoKIeipXthdHk+rLoUHp
         A1pVryHDJvAnkCDRW+ZPq8edlR3RWvWpHxvj3Hr18POFPufRWctY2PBOAcx+09mEmskF
         RI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619071; x=1709223871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHZNKNWPjrBTR9qsh5AP/XHTKz3QTL5wx4YnCqn5+DU=;
        b=gIt0Z02zLbH2xOftb/kyYWWD+GVByZlDAAWxFPSF7ZBEaRpcuMJDOf7/LCgDB9NW3X
         gvEgVw+vXGWgt+y2/CXj5dFYL8/aBYPd/+K5pKoXCTLQFjgVfbGLq6hILxsUY2AJ5ACq
         1eAALb/XVE6f0hzr6yzIrw5I53cWpUAIIGfHrq1dWByX3AdPQfg87KarY8ce57JUrT/q
         2ar1SZivaU93T1kQ9NM+GphMAGYJsOGe8oIpZQ5b7Nsoiyzr8YZquAsnE+1yXNnZkgXf
         KQ8oc1UFWIoZN98kTpW4NiZ8gs7Zrlp9SonWppqGptSVvQGMVbp7ZF1CFaTHLNRqk3CS
         C5CA==
X-Forwarded-Encrypted: i=1; AJvYcCXAL5/NsrrJ6WccjKHm/deNRNYa/oQGowdnYTEPJG3aM1dJsKsrt5vabHIskoH8Cp56Ii6VMa2B8D2USoKGgkiHFnDFadTHn5eRKy0v
X-Gm-Message-State: AOJu0YwDHrQqlCozHa9128tpkHD0KlguDvdCC7lyTU54V50We7qgAvUQ
	e3eWtHuxRh1cBXtKwy4QBEPLT9qkkUa9FF3eVFW7E7w58YgoxXn/igToSFP4W3OH2HdKC5OIpr5
	7THdfvpU22x4IjTxmW0zriX0WD4sYb+dpxeTjzw==
X-Google-Smtp-Source: AGHT+IGeaspCgzjbUwj3FoFwwf7WGgO/W5/UCbD80OaNKQrnQ8ODblyGeN6u6mk7wsAhkH8Gwd9ebjnda9w0Nc+xXXQ=
X-Received: by 2002:a1f:4f02:0:b0:4c0:2d32:612f with SMTP id
 d2-20020a1f4f02000000b004c02d32612fmr14254274vkb.15.1708619070874; Thu, 22
 Feb 2024 08:24:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182810.58382-1-brgl@bgdev.pl> <20240205182810.58382-11-brgl@bgdev.pl>
 <7pybw4wxlzxfl65yuqxzks5w7uq52hosyq53etlzas6i6o5l6d@vxd4sykcxora>
In-Reply-To: <7pybw4wxlzxfl65yuqxzks5w7uq52hosyq53etlzas6i6o5l6d@vxd4sykcxora>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 17:24:19 +0100
Message-ID: <CAMRc=MfTtcFb=7vDfkFiaPYvb+o6o4zd_RnYd2om+cAiaKY2dQ@mail.gmail.com>
Subject: Re: [PATCH v7 10/12] firmware: qcom: tzmem: enable SHM Bridge support
To: Bjorn Andersson <andersson@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Guru Das Srinagesh <quic_gurus@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Deepti Jaggi <quic_djaggi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 4:41=E2=80=AFAM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Mon, Feb 05, 2024 at 07:28:08PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >

[snip]

> >
> > +config QCOM_TZMEM_MODE_SHMBRIDGE
> > +     bool "SHM Bridge"
> > +     help
> > +       Use Qualcomm Shared Memory Bridge. The memory has the same alig=
nment as
> > +       in the 'Default' allocator but is also explicitly marked as an =
SHM Bridge
> > +       buffer.
> > +
> > +       With this selected, all buffers passed to the TrustZone must be=
 allocated
> > +       using the TZMem allocator or else the TrustZone will refuse to =
use them.
>
> It's funny how this is the only place in the whole series I can find
> this mentioned. One could from this statement guess that the eluding
> scminvoke requires shmbridge and that this patch series exists solely
> to facilitate the requirement stated in this paragraph.
>

Yes, scminvoke *requires* SHM bridge. So does the wrapped key support.
No, this is not the only reason as - as stated by Srini - it improves
overall safety of the system for all users.

> Either this guess is correct and this should have been made clear in
> the commit messages, or I'm guessing wrong here, in which case I need
> some help to figure out why this series exists.
>

This series exists and IMO should get upstream soon to facilitate
adding new security features (in addition to improving existing ones).
As there are at least two such features in development (mentioned
above) pushing this series upstream will make it easier to develop
them independently.

Bart

[snip]

