Return-Path: <linux-kernel+bounces-59374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B0D84F60B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C32A1C20DFC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E0938DC3;
	Fri,  9 Feb 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLHIyyE1"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5683717A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485542; cv=none; b=dTtTPOAP3ztHkLfgLIUyzDhZ3Zj0Fdgk7uQBp2PmWDz8GEaaVWq93jpqX7CcLdylJCQk7WtBPgO0VQNSDM+a5qsxqeq1N9+agKzHT4xbxPW4NCd07LzVFNljscN/8EXz58j0h+qmGOky3SmCLBcdw912w1dbeU6uv0lx+xYhgew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485542; c=relaxed/simple;
	bh=cfZar783bIO5OOtHylGck7kBUlRsDOqUiNuW+HJlEnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/P7DrfipOMOrnhs6oRgdjM31+qEWsO8Jp6L3T3eHUXx/8HJM9gUC5OkxIU5ppRxRBrE/gNoiqS9wqby0VVFRsh3XIZ26mmxxDVZkA4XqbL915D9fOO2k3TED/bxuvImOrxp8LVW5Zz/GtjckKqmvHAGVfY/6Jv2VjIePmb3KCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pLHIyyE1; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-604b23d91afso11841117b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707485540; x=1708090340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfZar783bIO5OOtHylGck7kBUlRsDOqUiNuW+HJlEnU=;
        b=pLHIyyE1aCXdyNGtZb6IT8WyfPApFKYm/xSyGkOjxMMOR3G2gaXwUvtIM/dQmPxyB8
         fqrslgI1yt99YDImaJvv5VErO7ecZBbjmS2D5osmzmUFmPQaHvx9AboUNt3qEvYKmFL+
         Jm6cuY3CjALE77jIW0FIFR7tTSB2B4hy+VufoNS6pbAVCFVFVYEOOfdoPp9e+obcUHy0
         GiJ3aO8bg+FOWeZrQ3kQkaNrX1kGhA+6S5tVsocu5830QpcYuj4wkdRREGuw9u3Wg94Q
         z1ZiiewaSS99M0yDzaq2mx8Zbht4BSLZcQANC6hAMPZKU6VVLD1nrfOy4sJAigTdrABA
         lbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707485540; x=1708090340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfZar783bIO5OOtHylGck7kBUlRsDOqUiNuW+HJlEnU=;
        b=B4QEjN5NP/ls/rNOlGtyx0iWmqR+fYGH8LrKHgPXsSyNSN+e1d7tWBLMecCD6dZ4uP
         LLovm/tAx9VxSd3PAM/gluMwlHWewvdgt84W5HQnq/obVw2YuIhO9UfHK+utZY3ROlkO
         NnanICtz33oPdFmjdamE2xUE0YoGzUKUPByKNa10KaxCHRwT2NYcP0ReK7iiwJy5CcTW
         5ZYxm5tFaULSkAHlqs0nJJ4uwgxv07fYFW0ISGK4PLSenOqDg1kh9f7xCPfQdmzDv9qE
         yKWlJEOf4uwnrnF2/gN0aeahCJ9bGUApFX1+qx/FUyowAdYbHhQQcTb7Lrg7tthWfEbk
         hGzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWw9Po7W1igTCONF6A3Off2hftx0xBy65qaj7Wayg+INzmb6KzyB0JlvW25gATBBE7ecqcnX6UhkJ8TsmsDHnvSTsxruSHEwCpemE9
X-Gm-Message-State: AOJu0YxH7P0/Bz5d8eI0gsEf9cKfV38orbLnOuIFaqUX1yHSfHWJfKBu
	ZILRoyhhT7J1aNBed97taOsFCQ0WciVn9MTUncZ7kTZZMgJ1kHiQ/hLXP2O84uqm7FZQoZ25RdA
	nU6c/tykx7Lu021m49prBRFqEWOrwYTez3cnxqQ==
X-Google-Smtp-Source: AGHT+IERf3uf+9XqlHzF2oaWkcRal3264kKvnbkM2LVU6kgNrlwktr//S7HwnRLMhN4oi2hPAU15mz7H7m6uztYHtUY=
X-Received: by 2002:a81:4ed5:0:b0:5f6:4f5a:8bd2 with SMTP id
 c204-20020a814ed5000000b005f64f5a8bd2mr1656804ywb.0.1707485540107; Fri, 09
 Feb 2024 05:32:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202105854.26446-1-quic_aiquny@quicinc.com> <8376074.NyiUUSuA9g@steina-w>
In-Reply-To: <8376074.NyiUUSuA9g@steina-w>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:32:09 +0100
Message-ID: <CACRpkdZAU-H7tmacaOFJGhDGbyzfuYCG2k2B4YDVs-ZgNjDKFA@mail.gmail.com>
Subject: Re: [PATCH v4] pinctrl: Add lock to ensure the state atomization
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: andersson@kernel.org, Maria Yu <quic_aiquny@quicinc.com>, kernel@quicinc.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 9:37=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:

> This breaks pinctrl-imx on imx8qxp:
(...)
> With this commit pin_config_set callbacks need to be atomic suddenly whic=
h is
> a no-go for any device attached to i2c or spi and in this case IPC RPC.
> Once reverted systems start normally again.

OK I backed out the patch for now, let's see if this can be solved.

Yours,
Linus Walleij

