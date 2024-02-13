Return-Path: <linux-kernel+bounces-64339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC222853D43
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E8F28EE32
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD7A61681;
	Tue, 13 Feb 2024 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPLvwzG+"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB63612F9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860232; cv=none; b=cGeHFLSs+FbBCEWoO4ohnezZ1ZT+vkfHKbjR3s8qPlXFCJOmVuZg7EAvaRDO7ewcSvRPY+NtEUvZZCJpgkhcoI0wzQqSu1urWny7P1Cek4uoJYBUzedPpXQ5ZENgy6S80SGPb4izrk8jej/hPT/PItGt1OhpTjVz3ttQHVdmmvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860232; c=relaxed/simple;
	bh=hPKvVthMBWAzdAWbIPUJR/Iy8plEfEcAcGfAR1gE6mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXcuoTEPPDswCHhAhmaXt2749KGcBmHw4yh2ds50O8nFvtJss1K1n18qghZqqmgfUTUBafZH26Io1nMI4nfllsv78NnUopIzeWHbtveeAp6NmjG6rm07HFqL8J0/QGNB/zJB9Nt5EA/9969f04zkoV77zFRQ4P1i+bFKyKL91kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mPLvwzG+; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso1322202276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707860230; x=1708465030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPKvVthMBWAzdAWbIPUJR/Iy8plEfEcAcGfAR1gE6mA=;
        b=mPLvwzG+dAg/ZrBSskb2yaAqP1pj/EP61lY1fsx/EM7lL4aK4EbFHBRiFliToUaK1h
         QhVPYIXILxhPmDWiibFPnqRczQrNzyZbUfpYpIhnQnBiEPqHk7UAbNh+JEY1I8CCAYe0
         sbs5fMT29hx1ng9/0rstitr6Xi451W7KSWg8gc2ac4MlSdINbROvsKZKHh0YAOgmn3i4
         hqIlb9EpBkFgP34FOF17rRMhpYHDKyYl276TledgapAs/3KuZkhnxMdOPkxLWx8oHqB0
         ib1dWPIFRVrRxnpcIY7rWH+/O8CvgCKU6Dbz9mPTDxf/XDvax6y/OJ7gNfDwWHszZRrJ
         HKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860230; x=1708465030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPKvVthMBWAzdAWbIPUJR/Iy8plEfEcAcGfAR1gE6mA=;
        b=YyZ6iSahJaf7WNxJ/risoQ6DOHgv7wq3JC6Ag0cI3ilSHDpLbo1pIW+L5uCuCiQPh4
         rHGpitnaeAkjl6Jio1kuqm1WzddSjo3dGlOEfqW+9Glk9445/bJM1Y4GSTdP191mdil+
         ZkEgfhKkQLH7d3bxadcwI0FMYV/Z1aSUMVfxCgvmbWVs8vNP0olnzYwe+b36UxvOl7pK
         DegHs7fEem5j0FZNnDL00KpDf5cxP6KQDrbkYGS1aP8HEagpxPJeYJGeDc6yrNwQr5HE
         3ZPJBpJMxX7F9vYqkclfLm9gbNV7piVAvq1JurabsnmXX6cyfALwQlLqzBUKn863DF+1
         vdaA==
X-Gm-Message-State: AOJu0Yx+AzT7JuAVNbkiefN/dKBsEp5+mp7LCmUG+O5LxeS8z3ZRbkXV
	16SXZSrxtRxaoUAnk1DxBjUdDwFV5frIP86K59h9vDWQQu/bz3c+4EZIrik5qrCc0+24b3AAOBv
	v3l1RGm5nHR85tSeVcSu3wfSOd/aJegbWvoQzrw==
X-Google-Smtp-Source: AGHT+IGvYycVOdI6CpAMfmqVx3TyTpHq47iLCCyvfSu+9n4B1EJovMa/1p5n1RWt0xmytAfy456aC9UfVc+QwLV2GdY=
X-Received: by 2002:a25:210:0:b0:dcd:65fa:ea06 with SMTP id
 16-20020a250210000000b00dcd65faea06mr383635ybc.24.1707860229766; Tue, 13 Feb
 2024 13:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240211101421.166779-1-warthog618@gmail.com>
In-Reply-To: <20240211101421.166779-1-warthog618@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Feb 2024 22:36:58 +0100
Message-ID: <CACRpkdYYyBTmiYF16NF3+nFDsqyqXcXBU=AvrxDy+h32eB-0hg@mail.gmail.com>
Subject: Re: [PATCH] gpio: uapi: clarify default_values being logical
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl, 
	andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 11:14=E2=80=AFAM Kent Gibson <warthog618@gmail.com>=
 wrote:

> The documentation for default_values mentions high/low which can be
> confusing, particularly when the ACTIVE_LOW flag is set.
>
> Replace high/low with active/inactive to clarify that the values are
> logical not physical.
>
> Similarly, clarify the interpretation of values in struct gpiohandle_data=
.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>

After the fixes pointed out by others:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

