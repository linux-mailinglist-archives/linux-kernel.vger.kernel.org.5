Return-Path: <linux-kernel+bounces-87564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FC486D5F4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8480F28B8F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD03145677;
	Thu, 29 Feb 2024 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0N1jv0e"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5814566F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241009; cv=none; b=odBa9cCye0hBx6y/6hYE6UvNF7apFxxdm3KlmG4iVpuIxCSKE/D9j7pi2RD6HiEgfzD6BjQ98FvSZnD7yYpngeuokUvA4UXMIrfNLY2bbRBps+cjBt8PIPo8LxZ+J3T361D/I+FtQjTsX4irLtpzINvjv0EBbx9cU+6BnxV/Fs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241009; c=relaxed/simple;
	bh=S8fZ6oYozb5nHV8nQRv8KctbzAfbnxof3VtKQDRYRaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2sK7+GbZQhFHrpWxccoG5YiR+PMYCXeEGAi6rNFrZmggJp7JfvdmdecORWDUyBhYl55SGaFzuc50RNx3KFhKzm6rdzOw9oGp9Zj1Ms2f4n3cjJxXcC3jHQnu+3xtdJHlC4pgv0ZNoAqFUfvI94eCYEZ6diFhfiDOAKzeqb9Pq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d0N1jv0e; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbed0710c74so1346849276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709241006; x=1709845806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8fZ6oYozb5nHV8nQRv8KctbzAfbnxof3VtKQDRYRaA=;
        b=d0N1jv0ecE497SIdHY1a0HCti2dEtiEy95GKD6/ZSYIRxqE2CubgluTDIa0hm4ScFQ
         Pa9i3kXtrf2sU8cUdQzxmHsrJpUCJlVxiEtaetaZT+FGb6WCrZEypaM3amhqu8abO62Z
         dFVyfhaGTo+3D/1YFH0G+y7SdNlpDI1SK2tYrIAsELS6Y7B+qDL4odKyrLFPvG3IgwJ8
         nwQQBkm/3KGg1PlfwC1Fk6+8DuQLF29x/LRS7yT0sENWp2U4NMz0rfxTPRpYwyj7sCPi
         aP75dC3/mJKsK8noytXh6w9j6yMmxfRkwpa6tMGGbb1L1CVylTnShJ8Gyox5sbS6kfCS
         oAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709241006; x=1709845806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8fZ6oYozb5nHV8nQRv8KctbzAfbnxof3VtKQDRYRaA=;
        b=vdPIqYPVrczkskeWVu7xeT/+np9SLSmep7BX/gUNVrnteVKDSUkEgmYg6h8j5wq7gR
         PVriOxbVm3H0LMPOH6/70H9EZShCnU9RqgeOdTXeXu4s1X4cb9ioWC+//vDTKqpMns41
         SHMr6Lslf6hU29Q9DNVYpXSH5t3S2fhnuCsXzwKFroIRkvc3wASjXVv/3unLJ9V9s6NC
         QGbCFuQx6z8q33jxpzWsfLEFRywalpJFBHpKIp8X8FoU1/abM7CQXfV74LMtSsqO/C1U
         b8J5ghDwGFsBsuAfJBvwme1V7TENOVVRA0GkWGRqmTLXUGx3hyaMFvhjfMkOsp9JBSeb
         /zOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBVNS5+y85s0h7Ff50CDkG0XuT1RngcaKzRCfg/9zoiQptG887K6XvPnRfJxJ1/UK61B1+K5XTMIo5R/Dht8lFOwScgRuzBkbUzyk2
X-Gm-Message-State: AOJu0YxQqTPgLklK1KPoscpjZXDXAv+3+6kR252LxfAZBCDyhcQi3qk5
	fn3BH3Lc006fLoXth6f/O1ONzJUCwDfZxwH8jlyJFeX2EppgWFTf9iYqQuqb3JgmOrQBgpIfQvI
	Ujy2mlk7HCSHRUjl5xBF9FeuX4DJg/qf0iwTwfw==
X-Google-Smtp-Source: AGHT+IHpqt7WVprMdgDUXDj2HfXpkMExj7EZqboVSsy0vCvMNy6esVauMuDWv/acQi58TDCcoWCPbUaQEY1kCjx06I4=
X-Received: by 2002:a25:2f45:0:b0:dcc:8f97:9744 with SMTP id
 v66-20020a252f45000000b00dcc8f979744mr3219750ybv.43.1709241006597; Thu, 29
 Feb 2024 13:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-mbly-i2c-v2-0-b32ed18c098c@bootlin.com> <20240229-mbly-i2c-v2-11-b32ed18c098c@bootlin.com>
In-Reply-To: <20240229-mbly-i2c-v2-11-b32ed18c098c@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 22:09:55 +0100
Message-ID: <CACRpkdai_-FyXc6+oxLK00Esdw+akg0==YEUv+B5nBcWafN6qQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] MIPS: mobileye: eyeq5: add evaluation board I2C
 temp sensor
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 7:11=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Declare the temperature sensor on I2C bus 2. Its label is the schematics
> identifier.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

