Return-Path: <linux-kernel+bounces-149881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6368A9756
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848DF2868A4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6121515CD47;
	Thu, 18 Apr 2024 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzBxXK0l"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0183015AAAD;
	Thu, 18 Apr 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435956; cv=none; b=qTkccm/e44a+Qp2lKN6OJXy7tNYuF83hdjw2R5oNCGjH6xA1gbux+xqEND70L2nYZcSdM58XDzBGuJKsOa0ziCXIn3WMYmW+vHvN0IF0E3VlL6f0cnvQC2wMvSKBuhD5tMrH6WAfbTF/0CB0I52HIF7kIufAeOgpkY2o6VGsTaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435956; c=relaxed/simple;
	bh=Il0xcH4eayVY+QK+wjCnPabCr8SYBb2diIuGENWPsXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFE/JOtvs3Kbf1Z0XaGmahX+BIF7fYBUpI5TaBDC9Id/jCd++wEWZpAD5TlXcj6Kbwwfmj8J+BjJtpihMS74YPvswRea1J7lyM0/8MpaSxTubnyvyyyvUnE/xsd3gbrZ2iylwbwpuQ+XO6cEvjx/JV/XF/Hce0kNnXic36WWdC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzBxXK0l; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so480194a12.0;
        Thu, 18 Apr 2024 03:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713435954; x=1714040754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzZgtCUTPjY2W+0TRdJ+vVl+P6oFUY7BJ5Vj111QbBg=;
        b=HzBxXK0lgpHCNpaGCwosEDrXhjtGCEzGxjDtpL6abaAby+Fnm17IBjZ0/saDcJ4JHI
         3Mmo1UbIVSGu3wUijuWI++IxFVLs2zzHz/uJKR0umu6IKHaeeeGuIEKWdtprska/UVo5
         295zxrqi9nEE8tmKui6+O/Vz2588rR2S+F6GIH1oTEmse5UiGHy+aL1DpSp1GU/o0qtp
         W9th2NSyerv9qOAqgWRDm6pp6d7iYsMdWDdq5AGs27NKPY8RKt+0YenxSaaTW43MXDcJ
         yVHJmWifdaP+ce9YofzzoFEgzg++ZQG5b29spVDA4gD4244VvxC9z9Vvd6NqKmhHJ+p7
         B3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713435954; x=1714040754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzZgtCUTPjY2W+0TRdJ+vVl+P6oFUY7BJ5Vj111QbBg=;
        b=t3r7fhxnVky2dWOghjzfp+KSMy86+DdFqBVsc1WDLOZWMDj7N36a3TBNNyvbRHEJxT
         k3VyxR+kcUbr6bEZHwLGSKgf+UMhz32zVORaPHJ794CEM31UcQY70ds72ccDjyFlUE4C
         NwOUFuX2YLoLQyQ4ua3LInWarFXcwFFkIRpUyWwiiXZVhHrENHinoy7L6sWXCvJb5F0O
         s+a3Feyn7+tbYEVOHhfiRmyt6bmDrAciIVPy99IlnDIvAKXhwlQrWckHB2TbdLkA8Xx7
         OYjrow43ne+gDI5clDa99wYycWfDVzyCo045RdiqC/r/5EqxeFRC0iX5R3K1DTeMQvYE
         5hag==
X-Forwarded-Encrypted: i=1; AJvYcCVvSZKwgYi1Mr4T9oRvc+FsVor6dqPgMSNLRe2SBQhuuuMRPd4dy/ZxKzIxzvalUvX87t3z9LDqeiiG/ckIyL+jUx7wRgB+seaZ2llDC7tjf9t9Mys69YcOevt6USzPnqZCHkuOyp5BPPx83yEH8cwtqcoKvm5bDCKuBG5SEOC0dA==
X-Gm-Message-State: AOJu0YyjCuI1zag2o/2Mk/amgTwvIziYZFOE8CVQWkCG0TQkpWPI1anh
	PaqTjWRkBFTvsHLMoRq+eg3oeNrad2MpIw7DRgAlic2mkBewljsv/O7wShqMeBlbZcdtODy2sNU
	+RzhHGG5A77y5yUVIbO/Y4PLYqHs=
X-Google-Smtp-Source: AGHT+IGM01K541EgnuYvh+w/GpIyFuX4z14UC0b5PyXo5WA2L+qrS1q+2v+9oEgc9/5RXOqD2qRGLCo8HhqXfbx/jfU=
X-Received: by 2002:a17:90a:3d4c:b0:2a4:892f:39b2 with SMTP id
 o12-20020a17090a3d4c00b002a4892f39b2mr2165830pjf.11.1713435954299; Thu, 18
 Apr 2024 03:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418091148.1968155-1-f.suligoi@asem.it> <20240418091148.1968155-2-f.suligoi@asem.it>
In-Reply-To: <20240418091148.1968155-2-f.suligoi@asem.it>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 18 Apr 2024 05:25:43 -0500
Message-ID: <CAHCN7xL-18xL04KCZUYfegBH0vWa8i5EEa8UkhoedbmrpOqyWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: net: snps,dwmac: remove tx-sched-sp property
To: Flavio Suligoi <f.suligoi@asem.it>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 4:12=E2=80=AFAM Flavio Suligoi <f.suligoi@asem.it> =
wrote:
>
> Strict priority for the tx scheduler is by default in Linux driver, so th=
e
> tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
> platform: Delete a redundant condition branch").
>
> This property is still in use in the following DT (and it will be removed
> in a separate patch series):
>
> - arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
> - arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> - arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
> - arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> - arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>
> There is no problem if that property is still used in the DTs above,
> since, as seen above, it is a default property of the driver.
>
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by:  Adam Ford <aford173@gmail.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml        | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index 15073627c53a..21cc27e75f50 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -328,9 +328,6 @@ properties:
>        snps,tx-sched-dwrr:
>          type: boolean
>          description: Deficit Weighted Round Robin
> -      snps,tx-sched-sp:
> -        type: boolean
> -        description: Strict priority
>      allOf:
>        - if:
>            required:
> @@ -339,7 +336,6 @@ properties:
>            properties:
>              snps,tx-sched-wfq: false
>              snps,tx-sched-dwrr: false
> -            snps,tx-sched-sp: false
>        - if:
>            required:
>              - snps,tx-sched-wfq
> @@ -347,7 +343,6 @@ properties:
>            properties:
>              snps,tx-sched-wrr: false
>              snps,tx-sched-dwrr: false
> -            snps,tx-sched-sp: false
>        - if:
>            required:
>              - snps,tx-sched-dwrr
> @@ -355,15 +350,6 @@ properties:
>            properties:
>              snps,tx-sched-wrr: false
>              snps,tx-sched-wfq: false
> -            snps,tx-sched-sp: false
> -      - if:
> -          required:
> -            - snps,tx-sched-sp
> -        then:
> -          properties:
> -            snps,tx-sched-wrr: false
> -            snps,tx-sched-wfq: false
> -            snps,tx-sched-dwrr: false
>      patternProperties:
>        "^queue[0-9]$":
>          description: Each subnode represents a queue.
> --
> 2.34.1
>
>

