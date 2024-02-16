Return-Path: <linux-kernel+bounces-69229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD48585F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1660B24DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703F8135A62;
	Fri, 16 Feb 2024 19:07:09 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB0149DF2;
	Fri, 16 Feb 2024 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708110429; cv=none; b=MKqfTGwzASYEuXyLSJIk4jbHIEISmSccnfvDwZhc2MINSXQbwtfeH/P2U3dINMKFI2HYt2CHlgFkre+nqt+i25vL6YiSnNDk9M+vrUAoJMAG59p7mS13hh5Wc4ujKjZhL8C/QmvFk3ItlMVEI5t1vsYSg8AI5Px3cysF7CBCAYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708110429; c=relaxed/simple;
	bh=vToHHzjDn90fAEz/2v34KzDyqAVS4sw64l6KeRXaQ14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQkt4TSrXskJBa7B6jcO5rCNrymZ4RV2W2jfGF110/IjUZkStX7Oq2nlki4oy9rD/v5eC2+RqwimmhxKTvCO+E2RQnksrEJHfIFhmqUFQNYD9/Zfj0M+yDTOd+rZ+VGIvk6Pw8PlS90TAqYJXaI4cfK0nWbXSJO1SPGVWHdsNPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e2f6c7e623so262820a34.1;
        Fri, 16 Feb 2024 11:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708110426; x=1708715226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITSkQGtIItNWv3iPts75vF8KJ/g/xv/TEw5wziQEpm4=;
        b=JiPLOqrfhWfNeRRZ07JTTe9j/bQBsxkINcTWy9QggBBXHjDeFpBC1t+apNyf1hx3OT
         a9umKpjbb1EEVJS6Lrwy2w09K9ehDHftSxJ4JPWL5iZH32I++KM3L8IkkAhvTapn+/Ci
         PQQdlSwA5MzPyG3e7/VO13ROAm3AMpDRczf5dQfNbOgqakoLAtMrSrokWEs9tIW4k8FO
         Tu+HO1cuB83qKEJmRAOMOCVT+8RcbMwrOcfzc8cntOSiyJiWO8zsCEHWKqQO0GRF5w2S
         TMhScGuRkKDC6yyE6xzDE4c5ID0/OaaORAwcFIa24F7oDQ4lOaNTdvhJ9hP9mR84RRr7
         ZITg==
X-Forwarded-Encrypted: i=1; AJvYcCXYqqfK9smp+PHw9sdWlBTWCm3aX7Ru7potV7663HiXw3EN3/25TTHhlfGT2VZDW4rhXNoeris7fgTzP4480DF/511FDw0R+gbfKyJMR3oWBhE77j/Iy6n50nFoZjWyvEP9XaUYo0g=
X-Gm-Message-State: AOJu0YwbhJlpeo6pyaZ0VBHKH47TQzFcwPMW9J3YcI6h18I2gJzieJMS
	K8CQJsnc2tWl2aUR843Xb0xSY4NLNh6fUVLeqOzAsvzbiV08Y1tSJjD1cisU0x3FElDohKhWAuG
	h/qtAIurcanQr05xNAjlVJZ+8TjI=
X-Google-Smtp-Source: AGHT+IFlXaXgQky5woQH7VdcOzGIp+7E68DM4G2sHdAhVob6mNdAIZlcZH5lxJuR/WY188u/gRV3gmCWxJIwzClMYAM=
X-Received: by 2002:a4a:3803:0:b0:59a:bfb:f556 with SMTP id
 c3-20020a4a3803000000b0059a0bfbf556mr3586264ooa.0.1708110426473; Fri, 16 Feb
 2024 11:07:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213223948.1865489-1-daniel.lezcano@linaro.org>
In-Reply-To: <20240213223948.1865489-1-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Feb 2024 20:06:55 +0100
Message-ID: <CAJZ5v0ho5jURiLqZ-sPFn1Vc0Wtz3Bd0C_-XV7d3HRzQ_Rw4Eg@mail.gmail.com>
Subject: Re: [PATCH] powercap: dtpm_cpu: Fix error check against freq_qos_add_request()
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:39=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The caller of the function freq_qos_add_request() checks again a non
> zero value but freq_qos_add_request() can return '1' if the request
> already exists. Therefore, the setup function fails while the QoS
> request actually did not failed.
>
> Fix that by changing the check against a negative value like all the
> other callers of the function.
>
> Fixes: 0e8f68d7f0485 ("Add CPU energy model based support")
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/dtpm_cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 9193c3b8edeb..ae7ee611978b 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -219,7 +219,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *par=
ent)
>         ret =3D freq_qos_add_request(&policy->constraints,
>                                    &dtpm_cpu->qos_req, FREQ_QOS_MAX,
>                                    pd->table[pd->nr_perf_states - 1].freq=
uency);
> -       if (ret)
> +       if (ret < 0)
>                 goto out_dtpm_unregister;
>
>         cpufreq_cpu_put(policy);
> --

Applied as 6.9 material, thanks!

