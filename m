Return-Path: <linux-kernel+bounces-31339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3E8832CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB571F2265F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2832154BF8;
	Fri, 19 Jan 2024 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+U0Ms0d"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C453A52F61;
	Fri, 19 Jan 2024 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680359; cv=none; b=gkixqheqZLGbQ+acXfPSMWzYsFRqo15sbUFSN10n02oviVsJzMl8YYLSf+gs/ZoMqQQbXZvuOCkLH6FeNC1w1nGuQRmkE3NklNNFSsDepMAYzNc+nevgUNv9EeFxrbj/dNYPdD3OgD17PmmIKJ8RNMnMWQ9hpeehOS6EalCPKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680359; c=relaxed/simple;
	bh=StoFIFphMjA+zLLOVlZeLPt3n3gO7so6YhvB6psnJb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raVu9Qt0hTS+uJG9Ber1vlyemVEbKKAZPJUCQpRami3x6KR4sG3AHTnU1SdfgaOBHDHWPWOAcpzhrzdacsOx/ZCihk/pZW8ECmR18QiRVlKdkBNzsKHwp+TFeq721/WGDduJHEqbK9er+Ny2mCtbYytKSVYAhakBtV0MD19cEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+U0Ms0d; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e7b273352so1037103e87.1;
        Fri, 19 Jan 2024 08:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705680356; x=1706285156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWFRTt9OPmzJxJm1lMS0J5Y2ypp6VhC0+EToiRmq/uU=;
        b=Y+U0Ms0d2dZFOtcv+hqKNS0jueyZBv4jmf0Ipk0qmzWLk+Z0A782m2mLZ0kyzztaD5
         5Mhr2IRjAJfumnyNKmeHsm1brrw6qJHnHdXA+P6ju5lHYJm5evYRNMw3+hMAuTjakehq
         ovFdtSuadfJXOatLm2saQjCas2O0PHSPq4xGlNpZgjvcNw0/ddk7VdnVPGTvRf4aIzaJ
         7aP9KCW5XjpNbaNfkvWZmxpbWA6cPMZ6wzzZdLUsIZajHCFNBZZUjN3Rc+JR4j+oprio
         KwOzG+F/uFvPhq6YmsLf/W8SmexMx7q1uPuXU9qFx5hgwuIBt5MtT4j4E7YbVPSXTBSt
         apAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705680356; x=1706285156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWFRTt9OPmzJxJm1lMS0J5Y2ypp6VhC0+EToiRmq/uU=;
        b=dL2TfXdgGJOSDjBi0csjFJ6wLUSj8ATwKxb7X4JOFOY5Nr8cPLA09njg4Uek3q+bXJ
         S1NjU4O6AmXFPVwhUj2eLG0e367RP4hLBq7u7TA92dvLuy3AH2T4wkeU0/pbOPWYpjeM
         d5cmUL1lqGMIqofIMh7sW8l3utKNd1zEYycKF1wR2sdWAlazS8mg6gZHcQ22VfWHklwF
         WJnS9zxRbLpUsLaLFKeYh04D1o/u5HSh9g+O31JrOMu69rKJ81/dd+te8AZ0PlBUBHph
         JfWEo7tTyIXVa7sUbnydOlLEssHnNibghO3ri90Yj6zZJ7dXZ8dATDQkNzoBiJ9yIdNY
         xemA==
X-Gm-Message-State: AOJu0Yz3FhiXCKhBUh46RVQdtt9E/w1jNv5tyL9D+uMk4+5iGGg2jN4L
	/QJja7zm0msGv+pHIDMhPcc/WeGr9Nxuc5jo4XSZy+fcymdIHPM6q5Dh3vBra4xirvRhSjLq44/
	BOqVQEcoOc/heAfUE2PRVBOGOlLcot3t4O2M=
X-Google-Smtp-Source: AGHT+IFpBsYY27JHGd7MZRAC2YvfPc5SljnKIAj/NynW2aqyFT08f/rCCGp/5/Pt87W2icvC/3/VP5zxRrWHsXRi9Xc=
X-Received: by 2002:a05:6512:1116:b0:50e:649e:1e42 with SMTP id
 l22-20020a056512111600b0050e649e1e42mr891199lfg.100.1705680355624; Fri, 19
 Jan 2024 08:05:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118223301.work.079-kees@kernel.org>
In-Reply-To: <20240118223301.work.079-kees@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 19 Jan 2024 18:05:19 +0200
Message-ID: <CAHp75VerSqay6cxRQOihC321BbpAWd_TB6aPigN8XZZ=KPXtHA@mail.gmail.com>
Subject: Re: [PATCH] string: Remove strlcpy()
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, Azeem Shaikh <azeemshaikh38@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@canonical.com>, 
	Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 12:33=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> With all the users of strlcpy() removed[1] from the kernel, remove the
> API, self-tests, and other references. Leave mentions in Documentation
> (about its deprecation), and in checkpatch.pl (to help migrate host-only
> tools/ usage). Long live strscpy().

..

>   * Copies at most dstsize - 1 bytes into the destination buffer.
> - * Unlike strlcpy the destination buffer is always padded out.
> + * Unlike strscpy the destination buffer is always padded out.

While at it, please use the strscpy() form to refer to the function.

With that,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko

