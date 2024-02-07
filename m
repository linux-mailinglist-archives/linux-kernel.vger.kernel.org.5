Return-Path: <linux-kernel+bounces-56091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F94E84C5D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A30B25E50
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37113200AB;
	Wed,  7 Feb 2024 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe63DBqg"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3271D557;
	Wed,  7 Feb 2024 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292417; cv=none; b=qNNdHyyn2mcG8HCp+5VSCgdZRN6z0xPkOZ9NkixT8Fpdn0uszDP5zT/ipF39FaEG8q0AOOkHuuXAdiHn2FjC+UDPV2pzGNgl2CiYlcSk02ZfzRk72QpsQZM8vLcpg1CGg5qVbsHk+jZifxafHa/c3izfAeRF+csMp+U0suFQnLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292417; c=relaxed/simple;
	bh=v65/JklQgSLzo3ITevRxa/JurcYK6rfeiPZMwug9Slw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7rtlzbFZL5pX9m7pc7oCqMIwyuMXCLPQAWe6Vk+UvP9zA7SX5WcyolF7vaOGqKYrxhF21xjxInavzcvjKYvCYA3sV+Cnr7ZwJb1zYta1ZIfulGra3eENrH0VJNBzOCbvBRKg7ZbEKJZjS9Bo+C5o+mlIkJUTf/KbiFx08NY7KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fe63DBqg; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59a8ecbadf7so113711eaf.0;
        Tue, 06 Feb 2024 23:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707292415; x=1707897215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgX5ExE3nJYcAguyTho/pDjzA5VrWtWbQB1ZBDtuJ5k=;
        b=Fe63DBqgRUA4dOhQG12E+UZWNsvoWkNVnRQQqLEZNBcOvyVauT2Vf7T1tbcLaO68N0
         yhqrQKMgEoRh+jh4cIjoZiaSmY7lKLyNBvInc4Srz6Hp4VcgizGnzNmU444eoq1nJZh4
         nX1oDfKExiDb/q1mVSxZmwayE/6Z4qCAw38IBNKAnsZAjoX/NoGUHpHCEsBZqBI3V4Fw
         vaGOB+j+1riydKZ96hxIvALT/EPpjTyBvw9j45MxDyMgJjYFbNODvc+Q0IoOcrp9GneV
         s03BtZGztogGpX+dgfet/wPpZL7jbxOgo+uB/m+4vifjGIafUpKBnTBsBTfwGU+9D4CZ
         OWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707292415; x=1707897215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgX5ExE3nJYcAguyTho/pDjzA5VrWtWbQB1ZBDtuJ5k=;
        b=WC66Ali4RubzZi4aZpdbnurCIFYKg/uAxirhlxIF9Y0wLx1PkYghJfeyWHcMzw7fvk
         wU0wSrMY3CmqVN2XMleacjA4cLHLZ0PP5CTPU2KpBgT3VpGGINHD9RdG05EZzPG9cq08
         /ljprvBpgkx3T1a6CcUMVjeIrJcBnrRZM5qb50G31mGFrKSCwkSr96ZyRlUBw8A4G1Ad
         rpxZx9Wsw+61j/zlscp43x1R7g8SGDlcpfd5oRbyFSJlp21tUHC1px4Kq0YhHhboPXUv
         kyaGij74TpJg0DFSrGX4Ujxewn6qiLjINP3N43XNyZL5yLS21Wo5AeyHMJwfduNO0bVc
         HNpA==
X-Gm-Message-State: AOJu0YzMEgiu5M6WP49CQ0kudyBR2o9sgluUNzf7HK2AfZBdl7atNDeq
	xYpNaeYi/UHBRFw12dM0G3ild9eDm7ZcNLNqHwHwT6uBm730wFCbeBu4aSK6JCKf350pS4WPsUT
	BHc64txvv+4AuNmbldKAesYizHAw=
X-Google-Smtp-Source: AGHT+IHcDukNiN88ITnMg3zYEptRe0xEyi0EmdPcpucd7Hhq7QFK1xmlcRZ5QJz+Lo1eAKT0fu+cDqYZteyjTCpArF4=
X-Received: by 2002:a4a:7452:0:b0:599:f42b:9f5d with SMTP id
 t18-20020a4a7452000000b00599f42b9f5dmr4953137ooe.2.1707292414606; Tue, 06 Feb
 2024 23:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207055856.672184-1-qiujingbao.dlmu@gmail.com>
 <20240207055856.672184-2-qiujingbao.dlmu@gmail.com> <1b0026ff-5334-4d3f-805e-d06926ca20f4@linaro.org>
In-Reply-To: <1b0026ff-5334-4d3f-805e-d06926ca20f4@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Wed, 7 Feb 2024 15:53:23 +0800
Message-ID: <CAJRtX8TFLZMTxPO2Qb18j0JY+nDS3Bep0YngEozzoW4tpQS+CQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: pwm: sophgo: add pwm for Sophgo
 CV1800 series SoC.
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: u.kleine-koenig@pengutronix.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 3:45=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/02/2024 06:58, Jingbao Qiu wrote:
> > Add devicetree binding to describe the PWM for Sophgo CV1800 SoC.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  .../bindings/pwm/sophgo,cv1800-pwm.yaml       | 45 +++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,cv1800=
-pwm.yaml
> >
>
> If there is going to be resend: drop full stop from subject and re-order
> maintainers and description to match convention (look at other schemas
> and example-schema).

Thank you for your suggestion. I will fix it.

Best regards,
Jingbao Qiu

