Return-Path: <linux-kernel+bounces-92378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78827871F3B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8A31F268C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4323F5BAC7;
	Tue,  5 Mar 2024 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J650lcTV"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE35B68A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641791; cv=none; b=TsIm/APCGCNVExfNY7GhFkKM2ZklepibeY4ZYhQ5YcRWJK9j6S4jpDY0wvKSHFXKgyFMBzCt2c/m24XszfmIDz05d5Bey+nZb929+vucQpa0FMWb5sPJAtZWGdc2CzXlj4LLUjTxxm3TlmRYINAHuz8TtL7Nd8F4SAre1VePr0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641791; c=relaxed/simple;
	bh=ayZBI8lVp/BWzkFGNvW228CHOibWeTInhSFUMyfIloA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Twu2PpcREVZKKHku2kND4cPVkJ4Ob0SOSX9uci/pTnkVhrcXDn0XDilnCqL80s5QhNnCNMlxhk/cLClbl+OXPKZ6eRnSaR+TfhemaqaHNiKur6x6T6FJZGfLII/hdRVcFkVY2BB308iQFWNV1yCOKT1pkDGi8Wz5+nr2IIHZpFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J650lcTV; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-608959cfcbfso6807847b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 04:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709641789; x=1710246589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yO3n6KYXo33Xsc4SiWnMfOg3kui2ahdzf5GeukwEkgI=;
        b=J650lcTVlIeVhgUhJI/JBPMK+n0QTKo3PLXOqYptaAO/Tj//CwEWpGDgvDSlrs4OFl
         qeOWRzumc4qQv6V+K9vbQJsjPh+OcBmpXMASYYubkZpEUz0RBV4xC4LUPcgnI8gGvNPK
         U3Tg7zUvg8UuH8H7I2VXnrm0kn9Vy+PhYLMr2tlWG2FbmdPpANjiGZvLTINuchdsd2q+
         JZeXJTxpoxkT14/lKSCIkwSwb+EA2lg/bjLr7L5YIJXN6DZyE//v/CRUuZ18cxigHEcq
         Tj1T8XS5b1CUAHfmBZFYR2aqFKYbTZ4TiZJzTsaByE1HzO0PtJ2sRqjCrK0ic4VkJsBL
         uf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709641789; x=1710246589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yO3n6KYXo33Xsc4SiWnMfOg3kui2ahdzf5GeukwEkgI=;
        b=J3Jr2/5gOWEn0CGpjT5x2sBsenPGsa6q2HorO7BYO68RCQf5e1xVgMcqjKPenDYjCP
         vekDjiYFdRDYH7Hk8EiRmdEvadS52EmjnF2xRR8RRAkyh862vObuzWDyMefOWXiSNVM3
         PfcRP8BmNnwYHScWmyFyV+wAvsCAgtRPl1Uvugd/pRBzO+wUqDKISHK5ssEimNuNGNZB
         7F8EUUXko4Ym1x/O/oZ65iRLuu5zHhM3lwHe0cEYsuKo38POL4p7jKEOVsPmihn7mp8m
         6UeMuXPzDCwJlLtUkJ+RLx8laFXUMFxkGH+ANHKmSzudscaBiG9wZkXZ5ESTUESICdH0
         ohIw==
X-Gm-Message-State: AOJu0YwyvDl7zmLo4q6AZu06qiCKkIdjQu4/PnSXRVt81u9qLTxDD4CQ
	HbpRz1tggZ4yYfd1z2ZOYtm5QPgYt7MeijBcK3mGpprVgMU5dKL9wOakfXBWRLmwK86x/hrjC7M
	Xl2ickV4Yf/7R/k/nGumHAO/EPeBrovI1vEUPhA==
X-Google-Smtp-Source: AGHT+IES79nKtjDjJy0DwVl+WQtVsPxU80jy4bvuMiIhxKvWN0DlT/brykHbuV+yjoP8FSDcXh2IbYP96l8rw9Enznk=
X-Received: by 2002:a81:6c92:0:b0:609:b582:bb24 with SMTP id
 h140-20020a816c92000000b00609b582bb24mr4517291ywc.26.1709641788976; Tue, 05
 Mar 2024 04:29:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org> <20240227153132.2611499-2-jens.wiklander@linaro.org>
In-Reply-To: <20240227153132.2611499-2-jens.wiklander@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Mar 2024 13:29:38 +0100
Message-ID: <CACRpkdbhhZ9+Jy_tvWy1RSnyZMjqUhh0ARpS+WRtgWTH3AYCPw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

I realized there is one thing I wonder about:

On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander
<jens.wiklander@linaro.org> wrote:

> +struct rpmb_frame {
> +       u8     stuff[196];
> +       u8     key_mac[32];
> +       u8     data[256];
> +       u8     nonce[16];
> +       __be32 write_counter;
> +       __be16 addr;
> +       __be16 block_count;
> +       __be16 result;
> +       __be16 req_resp;
> +} __packed;

I didn't quite get why these things are encoded big-endian?

As on the producer side (the eMMC backend) it seems we are anyway
calling cpu_to_be* to convert them into this format.

If this is a requirement on the consumer side (such as TEE) I think
the consumer should swap the bytes rather than the producer,
but I guess that kind of assumes that we foresee there will be other
consumers in the first place.

Yours,
Linus Walleij

