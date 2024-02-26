Return-Path: <linux-kernel+bounces-82377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECB1868376
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18560B2143E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A312131E3A;
	Mon, 26 Feb 2024 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WAOAtxwr"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E7131750;
	Mon, 26 Feb 2024 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985118; cv=none; b=JoC4omrZF/s8cmiznFgN+zCwcKaEM32Svv+j4FcI+gY+wwpPcMUdTSRSet/tEh0Y1vtxyBVhZDNwMGmDWW1ztGLxD5IPg9kWrkRnrPUBG7wjqg6RxkvwjY8ZKNzsW31ZBlaGI/P0WNMEHxk4E7mQU9rJKSpTh2EXAenabwkTiwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985118; c=relaxed/simple;
	bh=p/3wyl8Jo2S9QJLB6T+6NCzPxPyNA7mOUdaRW8YuZWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzTBmYLNZbfQpPcI6AgZJ7sWr7zgma6qrq6PGw+mZjN6uLaklznBOjUAbhSI4H5mfes33xdOj1xHc4kttoZjx+BHBPCvLur6XT6Dz0qeeYit6P76JPeAg8fweq99cCebgce3G3ONhRpZ+tNP3qXqWAupYfAYRa5IA293bbcCXqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WAOAtxwr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc0e5b223eso30079575ad.1;
        Mon, 26 Feb 2024 14:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708985116; x=1709589916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/3wyl8Jo2S9QJLB6T+6NCzPxPyNA7mOUdaRW8YuZWw=;
        b=WAOAtxwr1TMCWC/ibqjgpAobRjQUwP8jClDyALdoPMFqUXqyDo4rYFmTb2s7dTuILB
         j81PKUJYiDH/ILJspfU0GZrj1dGXSErINkFVscAkRRfBnWa6NQ55a4GyiW/faV5TW4cb
         5Fa7gUhPSSXYlU0suYNBnhTwXEGqU1n6QtL0v6M4XZp7vkt67PjcmNxdA3ohCR6gq0Ve
         yWTV0lvHuqTiYpIxEhnBiCvoWsReAqBDUQa3RhNsvkWJZF/E24TpoP157xbN3rhbvRcd
         SnulNUEwVylV4wC322/4qXQFeXjUebrLg8359Qrhr4XmvZp4qFGVCi+vnsnDYE+Z1vvF
         MWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708985116; x=1709589916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/3wyl8Jo2S9QJLB6T+6NCzPxPyNA7mOUdaRW8YuZWw=;
        b=SKRklSOttPYq9KA/hILxi7xAUDzyw+qTgDWzIljU9FEFg8nFS28PbDbe6F39YFvfCQ
         RbhxOITePEkXuotUnIieS9MPKEYWc5FEnTdETu6vfHMYNjLlhICGXgSqOw5rF3UvXwRr
         AiH1tne8leMullCtBk6OjwCJtH96wiq1wtyinz8MZPDfoRAgzUcHEgJGs3QNq5itbfr5
         f/dovsL2Uc1JhIWpitx3ls+/++riMIbxeHEi0gvxNd9W1Fr6jch6OQXD1haemBCKQn0s
         JFe/3Eb1lufqXfPgVqXdCl5f8Lr9PevYiK7Ayusi8v3+iG6br0jiwvK3lnfoWYkhnImi
         o4oA==
X-Forwarded-Encrypted: i=1; AJvYcCX9TsACsjnH1Fv9APlOwNpgVrkbb1+4nAkrRE4AcwGZtUGPuduGpxUWwhclUAhDSxKMe9SKAxHH2V1ANJTe4Ecp6C6FPibZw3LryT3fN1CWLaZbS+1tkYjT97VtHuqTkx0DJyirDRC/7Q==
X-Gm-Message-State: AOJu0YzfJJMNEXPA6+x0eHikRMrXdfJFdkriK72lZ0zj9x8ClyxqzZxi
	ez0ZHxBwgrZuYkR40EG5Q6FyFKyBGvgahn5JkToxXARr8dQTfGJFCCwuqHgdmf/Xafdijh34gXp
	hfgvaBPb0g2N2W2Z1eOGjffwp/kU=
X-Google-Smtp-Source: AGHT+IF/GAOdaVYQdXJhgPE9e+g37fsL94g20U51TnMoE/5craeH10xNbQkGDkY7uYATSqOuqeXz+FrRGZ5PzyVFXo8=
X-Received: by 2002:a17:902:ea08:b0:1dc:1ff2:c6d6 with SMTP id
 s8-20020a170902ea0800b001dc1ff2c6d6mr8707132plg.22.1708985116478; Mon, 26 Feb
 2024 14:05:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224084030.5867-1-krzysztof.kozlowski@linaro.org>
 <20240224084030.5867-2-krzysztof.kozlowski@linaro.org> <e2cda8f8-4250-4ac5-b7ba-6069f37c1b98@linaro.org>
In-Reply-To: <e2cda8f8-4250-4ac5-b7ba-6069f37c1b98@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 26 Feb 2024 23:05:05 +0100
Message-ID: <CAFBinCAymkEJycdvBeumMVL04_7mNCdr7yGz9pKxh__-Uo3rrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm: amlogic: add Neil, Martin and
 Jerome as maintainers
To: neil.armstrong@linaro.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 9:21=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> + linux-amlogic@lists.infradead.org
>
> On 24/02/2024 09:40, Krzysztof Kozlowski wrote:
> > Add rest of Linux Amlogic Meson SoC maintainers and reviewers to the
> > Amlogic board/SoC binding maintainers.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

