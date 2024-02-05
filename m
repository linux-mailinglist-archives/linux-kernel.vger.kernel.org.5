Return-Path: <linux-kernel+bounces-53795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC3384A6AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308BA2895E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89E91AB027;
	Mon,  5 Feb 2024 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B44QJ8tC"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C711A6BB9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159904; cv=none; b=FQmDS+IY5drCA10mx5xvaPLEeHPGk/Z5i21slXzeFnKip3aHhYaVWes2N22FeQCep+4EQii8I5GDPDAR5BYWTZ0W6EaAzZJbjXwBwX3tHDlHnMvv06Ul9WCR1fnhhqoYpvQPCPrUVLs6NYYs0vBoQ5L+kXCEbQOs6NvKiCP6cyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159904; c=relaxed/simple;
	bh=wMerWchyBglTjYaCZJW9+4cKaKj+xDW9hzP6obVdoog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzzQIWrLOGxN9SyMVmPd3ssxqTv83KYb7541cr7ar1rHbQxAZD/t0+ctmD/LBXmkDFD1OiPSHfV3UkbhsStNMfMfmImK4yDRAhimjUbsTOn1Y5CuW5taSwLYMbzcTlaodgq1Yxr3OyQ2Gz8/TlL0cFcz0p7u+X51RiWPDISe4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B44QJ8tC; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5114b1e8819so2292762e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 11:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707159900; x=1707764700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMerWchyBglTjYaCZJW9+4cKaKj+xDW9hzP6obVdoog=;
        b=B44QJ8tC8Pq4VtK5t5HRqsqfAYaNo13DPAForyokAy5Te2Rjj+YS3zpYtyR10rwvht
         zkYwa761ReeH/nuct+xo5KoH+4W91IH8BDAlZR1lonc+qHe8ib+pfO5QMlUb/O0Scf/+
         WE4Ho4bn/SWHdPlsZScDcMknTu2DHoW8ToF+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159900; x=1707764700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMerWchyBglTjYaCZJW9+4cKaKj+xDW9hzP6obVdoog=;
        b=oaNuz8yw1u+pTsEyUsnWvfRkm1LlDmy5c72ahOSpwDe0yhcbhkMEat2Zmqt4brNLqn
         tAOT3jYljGzizYNF4OlLZQshnq+SOpgcFRSV3IYJmbtg0CeN5CBnxi24ufxtJvS5u7rm
         /RjeSWYtwX1M454We1vbXGO+HwVBlzz4NcuCMFaMOu7d10A/yDVbhN8aVapb3lRDFGGO
         A/r1/dBF1/pTkNQiglnHiT5zvaV72SnCAxR9J8FfnqTJaJgMWRLl9iAPUBj3IsDDHp9E
         mg0DVk0szg4NfV+NNQZspjFM/bGHcyAQmgbCkRs21uiYqRGhL5J1nMfX1DC0QKZg4YOq
         8PHA==
X-Gm-Message-State: AOJu0YyaphYsZc3Bqd8HhGsWMGet4zBip9LMWUQDEJFi2vSZNs/JDUS9
	d2Qbb26S9I/Q/+uHzbTfvI1x06sgrIaOqmrG9/+3P7/r/Qc9hdDFQvGSrw4qK1KUF7y0o5ECjVv
	Qi0pT7iBbUm6UO63L3zgZeRNS2Bzsh4UOsFfS
X-Google-Smtp-Source: AGHT+IEcHW/vOu1+KgLsWEuqn8Io9gHrYaSWNPFK5jkvm/DQsp3jCU/XfKZgWdu8K529ifOfonW3kj5xctfw62fdoaE=
X-Received: by 2002:ac2:58f9:0:b0:511:2f76:e093 with SMTP id
 v25-20020ac258f9000000b005112f76e093mr69835lfo.58.1707159900103; Mon, 05 Feb
 2024 11:05:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202182339.1725466-1-nadav.amit@gmail.com>
In-Reply-To: <20240202182339.1725466-1-nadav.amit@gmail.com>
From: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Date: Mon, 5 Feb 2024 11:04:49 -0800
Message-ID: <CACKNADUCcW-Mrkt14VeGHTKsZ9KHMt9h=hfcncmDGUCyVGZqaw@mail.gmail.com>
Subject: Re: [PATCH] vmw_balloon: change maintainership
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 10:24=E2=80=AFAM Nadav Amit <nadav.amit@gmail.com> w=
rote:
>
> Jerrin will be the new maintainer of the VMware balloon driver following
> Broadcom's acquisition and Nadav's departure.
>
> Update accordingly:
> 1. Update the maintainer name and email.
> 2. Update the reviewer list to Broadcom's, which acquired VMware.
> 3. Add .mailmap entries for Nadav.
>
> Cc: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
> Signed-off-by: Nadav Amit <nadav.amit@gmail.com>

Acked-by: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>

