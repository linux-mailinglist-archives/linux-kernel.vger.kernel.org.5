Return-Path: <linux-kernel+bounces-86788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A41B86CACA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1581C221D8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968397E0E7;
	Thu, 29 Feb 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+lwSG5j"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662DD12A17A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215017; cv=none; b=CJ54KLkSS31loIHrGWECXUxOmxRqrwRiBjA8WsJUbFoKuoog2+TOIj+TT4kM1rLH9Alrql0QykJPR+0LE5jYWPJvUu3U9cgLXKiQQp/jAvWj13dLyIrfWXwJHbSuCQPhfu1YXrqRukjYQWz+2Xs4MPOxZabcwfSgOof5JSZvFB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215017; c=relaxed/simple;
	bh=Wws5urlY/pHKb5nO9L6+YF0fIvf4wojKA9CEm5jbQIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owsyvRWneqhzpe8oMzAf9Zpm5kjTcNguQq1jtuFbSa16WvX9qhD1Hno8TPfbsSFJuymuRah03kCH7LbMyK8qRGAHPp5/mcMriU9Ue/+6DWWINw9oMVBNdODElD/XhYyhUasZK205op9/X/35aguYHZTQf/A6M4ORInEYGp/HlPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f+lwSG5j; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso965405276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709215015; x=1709819815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wws5urlY/pHKb5nO9L6+YF0fIvf4wojKA9CEm5jbQIw=;
        b=f+lwSG5jcLV6Jvh2VptIWbckKIq4g3bVLGsCTxwAmoB4r9wOm0qjHxsBW5YQHXD5Fq
         8MeswxbOLPdHna7vbcMjOQRo6PSium9RcWJbQp/Y0M9FKZE92sK5AzeAwUrxsh+vWq5C
         ejHf99vyHKL2EbnEfZoZnwyS3Jr9mbDFW0Fol20KdUfO6DXeN8sKENFGPsAq+JQsJV3e
         D1QfAL2pGW0tQSzTvnuHeTNs9CzRo6+I937nDNiizWP1bXE0Jp2uGNwa1X+z2T0yQDtF
         CwjAIJTFYiEgrQV+W2IV3DGoBqyBkxYMDkCollRyzlpuS744issI97QqwK64PAaagcqX
         7U5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709215015; x=1709819815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wws5urlY/pHKb5nO9L6+YF0fIvf4wojKA9CEm5jbQIw=;
        b=TPXDQLWnNdRsSOt7GH+kxBFcXtWrAvlxnLzeOcEwxdGIC/jgtEaQC+G/u9r9P+iHUS
         UYISOfBCYSRRXOUa8izNS7A8/4oiFzYVcpZEBWhbztjQN0fGeZ0ecG1vzcA74XfK2n9k
         RcIe1gRCgT8TUlQ9/h6LwGSq8ANbvQQMPQu/Fy/QsSKnlmeSctBW8GHZ7FTWgZaDWhoq
         P0aag6dDDeUwg92StOYzLAIz9swejk8XVCpbD3QpknA4Qeuo/9M4AzO06T/rGveZLpQr
         U0wCQQHPE3GWvrGcsZexhcHuJR51cr/m4oNZy3k5+W8vQDQ7UCzZdBXujqTiGMVmc3kf
         eabA==
X-Forwarded-Encrypted: i=1; AJvYcCXvBUbvzhwUvHHyITigWIg4k7es4F41XocPf9Kav6Bpf8HostQhfgLXuby/6EE0MV9tUnEWYd5ni1OYNgEWZLgk2hZc5/XwbzmfMS3b
X-Gm-Message-State: AOJu0YyaiCvGVVoCCGATtq9YeHyarP2T9E4CH8Fvm2hWzvy/mfUhgujw
	ruBsifNMD/tFXfnTh+9EaaLBuSn2ovng9/FwR6622c9U+U0HFiDL7X9hHbR+9jNPGAT2W9yynKu
	9YufNblT6GCVG0WEvh574D92E9m0Vuz5oWOkujPFOft3QqXE3
X-Google-Smtp-Source: AGHT+IGyYyjopk2S0BDW1Ghoa/7hBgl0rLX3ecHmVYFRGAMgeBOBqeibeDjXXuQsuPB0jGCrausTn0ucexpYoda4cP0=
X-Received: by 2002:a25:8249:0:b0:dc6:bcb3:5d8e with SMTP id
 d9-20020a258249000000b00dc6bcb35d8emr2335878ybn.20.1709215015418; Thu, 29 Feb
 2024 05:56:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227155308.18395-1-quic_mojha@quicinc.com> <20240227155308.18395-6-quic_mojha@quicinc.com>
In-Reply-To: <20240227155308.18395-6-quic_mojha@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 14:56:44 +0100
Message-ID: <CACRpkdaqf8niLVfT7i-x6gVda2nwy1A6akEEq+rYz+cEpg0DzQ@mail.gmail.com>
Subject: Re: [PATCH v12 5/9] pinctrl: qcom: Use qcom_scm_io_rmw() function
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:53=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:

> Use qcom_scm_io_rmw() exported function in pinctrl-msm
> driver.
>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> @Linus.Walleij,
>
> I have removed your Ack on this patch after your comment
> on https://lore.kernel.org/lkml/CACRpkdbnj3W3k=3DsnTx3iadHWU+RNv9GY4B3O4K=
0hu8TY+DrK=3DQ@mail.gmail.com/
>
> If you agree on the current solution, please ack this again.

It's fine, I trust you guys mostly :)
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

