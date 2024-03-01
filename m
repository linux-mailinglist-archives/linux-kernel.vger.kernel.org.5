Return-Path: <linux-kernel+bounces-88060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A405186DCE3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E672896C6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5284869D24;
	Fri,  1 Mar 2024 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pYcN9v2M"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B669D0B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281094; cv=none; b=Qq/PCYO+OO1tkKHZ/zXqxtgw3zXnElL4G0otyVvL6tCNBiQPPJG2QYCGitW6jE53ThNzjPFHxKRu0/mFLg4OWVSr49IJleGdfh3tAoj7kvcuRVulGYHpWYgbZJSQELCzG/a8TVGkVQ9DufOdgYNi00U70EYvtn8JVq66JFMx7xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281094; c=relaxed/simple;
	bh=yp68DEdZUIp6DbHm5jT7o9JF91i5ZA3+8zf7cCaGH40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCJc/vctkyt55IjW0rLNoOyH6+ndkRSCU13avneR9FGocMKV20fetmQ6EfI/GrXGMefWlBeuVbNHM7PU/T+8tgtdiisstSHtkeyV2jkqLDML2X9/ExemSODuVNcHtbl0YBO/YeGE/DOhguxQdw1ri/ah8yz0BhvSl5l36WpkJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pYcN9v2M; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4d331ba6078so424263e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 00:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709281092; x=1709885892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp68DEdZUIp6DbHm5jT7o9JF91i5ZA3+8zf7cCaGH40=;
        b=pYcN9v2MFnr+htNsmgg76MVJkUTQPC8qdovJrex9a8fus63Lm4KwlesmZH+WqfGoJZ
         E9c4HbZqv7hE9TtpuaiTVQkjLee5P3eH9bI+W364kdjl+144FclYhvtex6NGt7XDxIja
         qA0LcRsjeuElviSQt2y/1/4WSbjnbLKbPTAXjh0lJr8SFtqEAaxD6O8WAMDQUgFs1nGO
         N0BUEU97MlrfPW9aI6CIeBeaub3YyGQfXyVWxRORDi/hpeqlTVrF0i8Fh5QaOfqgXZj5
         TW7AKGtdo6nAoEgxL4lSz5b2VxV0i/qMygbk+WTuFMzOHFRTdJTfYaq6E2Gpn3YpHdA0
         yeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709281092; x=1709885892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp68DEdZUIp6DbHm5jT7o9JF91i5ZA3+8zf7cCaGH40=;
        b=MsXl5L2KdFbzPlO1yblg5MGGG3bZh8o2g+aJ7tW+16aSEnQqrR19RMuUji27iPEROF
         zYQkonh0vn1py0A4XvrZBgtQZp2w7rRdb5DGiztYksAliLMoVS8CXdEyoHbslwKlKUW2
         UAzcXjcLiAyoW9dFtiMcTzPKXFKgRKxYHqOdw7/bYSg/fUE/ie41jFg7r0FXsQRyZcCd
         o1HclJit6X/VrhylDjzdfcycvv0AQs2xLm9utwSNttxF48eAj9Q9lukcJFSA8vxfaTO9
         Lidh+QX+MQT9lEsH6s+umsvrujI/XDekflikcEA3wCO2fw0Y8+MaesKSTOFGbCvgj80l
         FIdw==
X-Forwarded-Encrypted: i=1; AJvYcCWXPEdI498ALnm2dg9Ema6BwI64PHXzH5tDvIIP3IBUN1l1yd5ypYmZeL8IcZZMGSvq5Vf1YK4TYg8fIotwsZ1stsN8GqBUJqXpK176
X-Gm-Message-State: AOJu0YztKoywVh/VarBvgmOyNb20/R85DUObTZEpupDbY6OdTeI72JmP
	vLGujFn4RaRc988g2a1fTwTXoGwQhsTscBJxIwN3asNz1yZSP3wxdcKq9jqSmN17A5fOTm/6+oQ
	hQlQnHKVV8383aoCLnXNgqvo/OlNgWgl80E4ljg==
X-Google-Smtp-Source: AGHT+IEhwqISmIJ5HCe1Nfu0Bnq1Pv29jU9DH3Pp2yv9SKTj1rghbwGyjrDqQbRbf0cdwpde2nH0FRgUZpSk6SGKDXU=
X-Received: by 2002:a05:6122:1aad:b0:4cd:b55a:bb0d with SMTP id
 dz13-20020a0561221aad00b004cdb55abb0dmr704388vkb.2.1709281092151; Fri, 01 Mar
 2024 00:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228003043.1167394-1-andrew@codeconstruct.com.au>
 <c2060450-4b76-4740-afe4-d14717245f01@linaro.org> <16ddd99007176da3f84462de217cb76c8fa4e1bd.camel@codeconstruct.com.au>
 <CAMRc=MeEyo7y-G1saydxtTRedNtHPaEeLANuzXt6KsiDU2jOWw@mail.gmail.com> <e55aa1321ccac8e6391ab65a5a439b49d265bfce.camel@codeconstruct.com.au>
In-Reply-To: <e55aa1321ccac8e6391ab65a5a439b49d265bfce.camel@codeconstruct.com.au>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 1 Mar 2024 09:18:01 +0100
Message-ID: <CAMRc=Mfa1uUhkPNpLdcMsGC4=G+_MGzaxXRL7UVdfKJD_zF0+w@mail.gmail.com>
Subject: Re: [PATCH v6] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to DT schema
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linus.walleij@linaro.org, 
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 12:23=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Thu, 2024-02-29 at 09:52 +0100, Bartosz Golaszewski wrote:
> > On Thu, Feb 29, 2024 at 4:21=E2=80=AFAM Andrew Jeffery
> > <andrew@codeconstruct.com.au> wrote:
> > >
> > > On Wed, 2024-02-28 at 08:47 +0100, Krzysztof Kozlowski wrote:
> > > >
> > > > You still have way too many examples. One is enough, two is still o=
kay.
> > > > We really do not want more of examples with minor differences.
> > >
> > > Noted, I'll keep them to a minimum in the future.
> > >
> >
> > As in: I'll still send a v7? I can trim the examples when applying,
> > just tell me which ones to drop.
>
> Ah, thanks. I wasn't planning to send a v7 given the R-b tag from
> Krzysztof for v6. I intended for "in the future" to mean for patches
> converting other bindings to DT schema. But if you're keen to trim some
> examples out I'd drop the aspeed,ast2400-gpio and aspeed,ast2500-gpio
> nodes, keeping just the aspeed,ast2600-gpio example.
>
> Andrew

It's ok, I applied it as is.

Bart

