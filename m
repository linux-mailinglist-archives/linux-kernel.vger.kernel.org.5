Return-Path: <linux-kernel+bounces-142500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9648A2C59
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2338B21041
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9518D32C60;
	Fri, 12 Apr 2024 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWThPDfJ"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795502C9D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917855; cv=none; b=PpyC7PGqdMfhlj3XEAGozU0plWjSE5oJGka5bnRoru2aW/wVE5xeb6HC0EtRWOw+eTB4MukgLkO3G6LOg/F4M75HW3VLBtDMXq+RtMrrXhQ2bldPMV72Kr6LAvEVTuvsRa9bDXXPqKVGT5ppVAVAhvJd5mmavz8oJoC95Rsw1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917855; c=relaxed/simple;
	bh=aWgSYuHiSKkt8/FrA60b89r2S20h+141kNRDHyQe6XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRWaGwfHF2OM8ngn9viPJ3PaEUOFfFad6RfhSVaMmE9TBWns+I7zC/KyOErqV42+pE+Ckf72W8T9GvLFEg8e8aMMltv+ksnBb7uLuyOVOHKx2+Q3/pnBOeT4Lo5MTDpaT8hyuTwGVOcxhaIl0ukZFNyAaoPHgHNihLbf7Nm6bSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iWThPDfJ; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso789869276.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712917852; x=1713522652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWgSYuHiSKkt8/FrA60b89r2S20h+141kNRDHyQe6XI=;
        b=iWThPDfJQNFzy1rgeUuRZpmgA63t3mzkeAaI0BoXHKCAG/N5h0CXZePcE78uL1dAJ3
         B2kIEemYzjwuLGECvF2ozErqU/Eor5se6H16DfoII55EEY9vjoDbdoWgyKRXfWzYzvq6
         WSE/oeEGEihcYnXKO6+xq/tOb2lS8+aT/u27T2QxUyanVBuWwsOt5h39fAeTuj5/+kbi
         p0XPgDoLQ3CZ8Rn1e4UReU1GVWzB75FxgDEL9ris1GcPawfEBePLBJLJFInVadZVLvMx
         kmtqeuDUquI1bYvn2XampBCi8QIY3aG3WH1wU02yKn0chFswD52fPb+TYrrL62GrpeIB
         1cXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712917852; x=1713522652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWgSYuHiSKkt8/FrA60b89r2S20h+141kNRDHyQe6XI=;
        b=U1KYXNnZtFDMKavrXyCNgZFPRrmTa47ixklk6meDUG9kN0yyXn0IcewGk51c5kO16P
         +doyB1lEUWGGjWR+NDf3jjVzrpcIrzUwOx9bj4DWPGhdTMC0fGBIEJu3QFADmdpwNqAQ
         WwvyRZzMg0n1A6EZvZTFOFhFPtEjXRCBTgRoxqU9A0xo0prT9jAmX7OEYZWG95CPutLu
         qLLHDRuIWb0yxzQNTjcs9ryoVoSjSGrRvc8CWOuwfHg8xIKk0LolcZGahUEeXlxu2InD
         scBYfBwJoPAq1eI2JukgsAH/yvMaaR5P2eHk+LkhBYZRvHMOTxUlNNXxK6hMbTlMDCNj
         +AcA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ23VKX4fpDmcVTDXN/21ArdnmhQ+472n+T7JdRRghQZci92RrpZr0Mtqrs/2icqDuxNjfsxKiQt2YtGLebcBnCWa8ETikAsNUICfV
X-Gm-Message-State: AOJu0Yy0PcDvrNo78up6ZtxuZAar6yUbAl5QeoH7JVe9y8z1rH0Szm01
	GJxjNmiaf9h8FENkkhTcVtJ+jrS6KYGngz00G5L6bQJvjdh+RU2xhfISL6wR1hN5/YNYIjZlqWV
	cAzY5i/8yWx2xJLbm7asPNul3TFMETQqwM0Baaw==
X-Google-Smtp-Source: AGHT+IH7IfR+AHNm+mTQKByEr+kP4aKWQ3cNsgDIL9B44QfZfFiqgK1haazNAAs02JEfChdOGSOi/DWlIoNoT2wDS+A=
X-Received: by 2002:a25:f44d:0:b0:dd0:76e:d630 with SMTP id
 p13-20020a25f44d000000b00dd0076ed630mr1880213ybe.53.1712917852463; Fri, 12
 Apr 2024 03:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410063930.1199355-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240410063930.1199355-1-andy.shevchenko@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Apr 2024 12:30:41 +0200
Message-ID: <CACRpkdZdV2G69q3=_HRE3LWhin5MOyGtwfCOOEHWGvchoTVMPA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: regmap: Use -ENOTSUPP consistently
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Walle <mwalle@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 8:39=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> The GPIO library expects the drivers to return -ENOTSUPP in some cases
> and not using analogue POSIX code. Make the driver to follow this.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

