Return-Path: <linux-kernel+bounces-147972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990C38A7BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21B91C2123B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCB0535C8;
	Wed, 17 Apr 2024 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oyQdX9OS"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22395537E5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713333460; cv=none; b=OVNkdRld2gGPAjlrEXPNtvxv3O64RAHNzjlrphRpjSXDj7ZZz1i0vXp8amoluAJaKVVp4MJaJ4dAEZyEEMyniMZPyPKYhVorlKp11a+fuIsyWKvLiAnuqPKyjB9/8bhPP0iBEhmytHgvV3mN1CKh+ysFT+LgRkeOPlUDGcDptd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713333460; c=relaxed/simple;
	bh=+37MR6MdJMZsDizwLtZ66hNEIJ8H6WWiH+pKyVxVm+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDIZ7kmxg34TItP3VdkPjxuNEj4hSV5ckyvfwd4AdXvLHxlcb0OZVMJ0I3eut5CJNdviVMEwfgTz60GabXJtImPIpchAe0zF3UDd/Sd4vh9+94fX8wT7oZ+purWt4mLCNEEQoHuz0lT2wCnJZvSbyEkKz+6dQXkczICE3T6kgWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oyQdX9OS; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso4555876276.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 22:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713333457; x=1713938257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rNcOWvfk3UIO9gpF1vedzWy9UX8ITuyEtwuAcYcPDTE=;
        b=oyQdX9OS3XwnqqvnV9Yo5QzeRKhxYMDPUxT8GAWmyl7Vow1SDMP3lKiOKPzpQmx7C+
         Ehkv+9pV8OUT82mLXxi2+8j/v4BwYw8NSv1zpMjzJiZkKhIf0vIRrtxPfouMvB3otU/D
         9ZgZiVh/yNkx6H4q5x3Ve8M/G8H48/lWzEIzWIg28P5H5dlyKmqOKsL5gKsQstQ3mF9z
         HjKa7XNBr9DpEtUfUazLaIJ+LMhSrDO0MO8GDeHZ4Wx2yTNXQ4VCvPJ0nbTs6a9MnvYG
         J3ITMn8MWPj/vaLGVmfpmnv9fSOGCBqOAaf3NsuH8T0+zRyo4BWKcLF1I0MEjIsTTRfc
         gg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713333457; x=1713938257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNcOWvfk3UIO9gpF1vedzWy9UX8ITuyEtwuAcYcPDTE=;
        b=rnUppEqjwElkc1ZZunTgL9bPiR400f3qoPkeB2lnCLgy9vD+Yha8NKZRV2XC3z0zMS
         vott36APPyGPmFE3WSFEKvD3dFowjWRyvAguaYLO1ra10YvydrlT020fsEKBGqvSW2t8
         ui1FZv5Kyqs+j3t+FaN32w5XNMkWlLsAGP7oP5BGZaCklLNq1BVSrrKZUF+x7l1Bwgkp
         fI7IRm/vWnHVHU3sfEgV5M0Sy6kLzAG+nITHyg/U/xaQ6d1Ym5prbXE0ejKwlSpYJlHu
         fnOliQAMg/TsjeQ873ZPDA0kqwMCIXRZRdPOmHFt83OeCFgxoTdFMiPPBzf2zSZjRfFb
         zEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnjBGQvwgpuHuriQ9wQt/oJOpJmYJsvG2E/hn7d6e6dVp4WH9EUeF55DlmKHQvoZJ+xVooxnCSTpAqMVZuuzl1I6JjChz/tSap6L5a
X-Gm-Message-State: AOJu0YyPCE9TYLhpD9fsjE0qygxXLqdtHB3EUCeXqWNuE6ASQ5bM0QjK
	wfnTRsnE+SPJQ5dyK2o/PpQQW9fHJAtD244jqLH0ztr/CC4prVRpkstXUTTwtTXlKM9WSlyRcuO
	MdberZqBFxTJqlORk2acGBBrAl36FQJbrTC2vrw==
X-Google-Smtp-Source: AGHT+IFvUyY4VR6NF7RdZCvXFlEENeC2C1SHZuye8tqXC6fIwkIUmwR3VOt9Upi8bmgYZVnv+2wX6k4TBDNDViUqr10=
X-Received: by 2002:a25:81ce:0:b0:dcc:245b:690e with SMTP id
 n14-20020a2581ce000000b00dcc245b690emr8017444ybm.40.1713333457167; Tue, 16
 Apr 2024 22:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415115603.1523974-1-github.com@herrie.org> <20240417045207.3594931-1-github.com@herrie.org>
In-Reply-To: <20240417045207.3594931-1-github.com@herrie.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Apr 2024 08:57:26 +0300
Message-ID: <CAA8EJpo=nd8ywUzz2e42p7WAyuFm439yvNf6H=MD63LCV0xTnw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: phy: qcom,usb-hs-phy: Add compatible
To: Herman van Hazendonk <github.com@herrie.org>
Cc: andersson@kernel.org, benwolsieffer@gmail.com, chris.chapuis@gmail.com, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, kishon@kernel.org, 
	konrad.dybcio@linaro.org, krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, me@herrie.org, 
	robh@kernel.org, vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 07:52, Herman van Hazendonk
<github.com@herrie.org> wrote:
>
> Adds qcom,usb-hs-phy-msm8660 compatible
>
> Used by HP Touchpad (tenderloin) for example.
>
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> index f042d6af1594..ccf23170cd17 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> @@ -15,6 +15,7 @@ if:
>        contains:
>          enum:
>            - qcom,usb-hs-phy-apq8064
> +          - qcom,usb-hs-phy-msm8660
>            - qcom,usb-hs-phy-msm8960
>  then:
>    properties:
> @@ -41,6 +42,7 @@ properties:
>        - enum:
>            - qcom,usb-hs-phy-apq8064
>            - qcom,usb-hs-phy-msm8226
> +          - qcom,usb-hs-phy-msm8960

This should probably be msm8660 rather than 8960

Note, nowadays the rule would be to use qcom,msm8660-usb-hs-phy
compatible, but I wonder if we should enforce this for such an old
platform or whether similarity wins.

>            - qcom,usb-hs-phy-msm8916
>            - qcom,usb-hs-phy-msm8960
>            - qcom,usb-hs-phy-msm8974
>


-- 
With best wishes
Dmitry

