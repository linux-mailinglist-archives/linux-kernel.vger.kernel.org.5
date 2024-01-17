Return-Path: <linux-kernel+bounces-29214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5271A830B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59411F282E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB522233E;
	Wed, 17 Jan 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="laKmSzOC"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3B022325
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508864; cv=none; b=TEkvU+uDWiG6+OwteAW8dQ33FcLYklg8tjZ128eximtob+MrWASHEpgPza1JnvQeXl9UGYz8DGVhBwrZXnjnDQNFlj/mGFLSt9PFb1jYTE+LMAaAJNr67EpQUnxn4pITngeWmt5k8xbflZ3WvTIUmgUfWUrz8ZHikuwGrxlSNr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508864; c=relaxed/simple;
	bh=x86NWqdks6zwTuT2tte0SAr59t1LG4uqkDpYG3GImHc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Rm2a2He+inRkDsD/fJczuMIQjnFQbUq0tzCmLbDHduVXa6M/HJrxPbNIkBgwYuGcTZH2MUgHydbE0wpYc4zmT6n3mqw+QMcXzCCo/qx8RrSv5ncesqKfwvSeiSnhsADlcOAbgZW/w1iq3xX3Tdf0JHq9m5Wj19IEoBiFFz2Lm+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=laKmSzOC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28feede2624so1072597a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705508862; x=1706113662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksZCgmtZ+uYq06W17SlEi7GeCSqCqSUiALZdlInZSQ8=;
        b=laKmSzOCKuRfkoJ/cstwYQ3uDXyg9pDm6EJ2nyPCKezkGUMEC5gKYx5RpcnTptdKxj
         QOwLhjSP9KTiqsblF9qyaTfqKNrDYv6Bf63dDv8S2+9DElrX00K9GXH9MR4apQGsDsph
         lAGTsoHhTM+Wat+s07ftufWJQmPGyCeK2Sb+d3F4s94XL+ZHFSN3ZjqWL/dCygo3+8wx
         1YI9Eia8RJk+hfEb5VC3m5YjysK1T+kYC/HTiLrku5KS97tZ3KElFOMQLovGEoXZiKZf
         2vw2PyMsgdRP0eOX/ckpkWtLymCRA5MWeNlxhZ/jtVPuXkPOimrWMYU12rrg9f+ySfxp
         oV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705508862; x=1706113662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksZCgmtZ+uYq06W17SlEi7GeCSqCqSUiALZdlInZSQ8=;
        b=JGC2LQ7fD5GJqc65MZ9RjZr1flIW8GF06Fj4pFP25Z30mY3oTVLBqeGcTfyDBLz0f+
         rVfUhSspqByXUll7PfDxM4MkDtn2ID+rYqkYLKcbY94A/MO8Atu78yy1Nv+5xryiqg7i
         oDN4zaQcKPC7QjM5bM8+brfrCBWWHV3eOhlFZhZ7LQdmN2z9cL3Y+8CWR0iN+sW82MGn
         5LeA1Reoi6nS5ZwVF7XEXWb6q5RoJ31LwiJfiNC+ml2cjJzRtDzlmgUxJZFk6GFQgrN+
         R4rhSL94cWKp5P53JzRkwEBe9og7WUQErqWqkN5XC8RsRF2pmxflNJrXm8+QBAVhkJOy
         H3/Q==
X-Gm-Message-State: AOJu0YxTfjXOrwRk4o8qvUrKP75vqZHyVHcknFwal16xgap31aH7/CwM
	vJPNJPaTnSm4pWTFqTtAh0onrfSoFeC8BqxFZrxYIv1wHhlqPA==
X-Google-Smtp-Source: AGHT+IG3Wxp0vQ4MxKK/BQ6afjVSc7Ch9N0YW5QeNus26UnIwTMSBGUD4DplaD4th94B7Z+Ny1N7vvCJRL3CKnemZ4Y=
X-Received: by 2002:a17:90a:a782:b0:28b:fe06:5dfc with SMTP id
 f2-20020a17090aa78200b0028bfe065dfcmr6387501pjq.29.1705508862366; Wed, 17 Jan
 2024 08:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
 <20240110102102.61587-11-tudor.ambarus@linaro.org> <CAPLW+4=YYdUSaaLcsdEyPswC4s6onxuSh24vSfw4xys=sPZG_Q@mail.gmail.com>
 <b21a54a7-fe13-4a29-8e7e-6b653d5c24ef@linaro.org> <026bdf502c0af8260c67a7a851562633a6976031.camel@linaro.org>
 <97c3579d-d6e3-475f-9f90-d4a2b3e25e86@linaro.org>
In-Reply-To: <97c3579d-d6e3-475f-9f90-d4a2b3e25e86@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 17 Jan 2024 10:27:31 -0600
Message-ID: <CAPLW+4nZtb8JBRe6GE0mGJj9-4uLPVryh_=8VHbCUAVVagy10w@mail.gmail.com>
Subject: Re: [PATCH 10/18] tty: serial: samsung: make max_count unsigned int
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 9:54=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
>
>
> On 1/17/24 15:38, Andr=C3=A9 Draszik wrote:
> >>>> +       unsigned int max_count =3D port->fifosize;
> >>> What if port->fifosize is 0? Then this code below:
> >>>
> >>>     while (max_count-- > 0) {
> >>>
> >>> would cause int overflow, if max_count is unsigned?
> >>>
> >> good catch, Sam!
> > Does it matter, though? As this is a post-decrement, the test is done f=
irst, and the
> > decrement after. Therefore, it'll still bail out as expected.
>
> Indeed, it doesn't. This reminds me of stop replying to emails at the
> end of the day :)
>

And it reminds me to drink some coffee in the morning before doing any
reviews :) With above condition sorted, feel free to add:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> Cheers Andre'!
> ta

