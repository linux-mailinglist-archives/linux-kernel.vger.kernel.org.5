Return-Path: <linux-kernel+bounces-144416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BE48A4627
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7752A1C20AF1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 23:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6EF137763;
	Sun, 14 Apr 2024 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rNS0PpVs"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A35E20B0E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713136423; cv=none; b=ZBueHryDsV+QlQhPM3hHOZ/00Hb0/bdIN8wYhPoBci4uNGrh2UkZkLZHlkp5fpX6WVxhkDaMdxyJXrfvLEETGIxVymJhfkwzBNMPqDCc3Rs11aFW0us+BT3kYHfbaWSzc8t6YcFRpokZoDv6c/HNZP2rOlXeFk2vYhP14IZEJDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713136423; c=relaxed/simple;
	bh=QMLfy/z4mNzK40DCutaIMBO2o0qIgTTudTT7w4FR7Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMn6U1uvgFQmetJZxjYgjcz7T30hNhHftlr8jzsguQJwLmMbH/XyosS9xPeefHB7ACXeELBAVvh9y2MrUkRxqorFj/mnGBBMF5rj+/GAjw0Jlg7+1OouQuwfiKTepA+21XGobhM0xcO2M/0ICI64v5HAe/9bH6HnwSf1L97SW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rNS0PpVs; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so3353861276.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 16:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713136420; x=1713741220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pc13QrE+mcMLNyC+/9mJ9l2G8Lqrng5Jebsz9BpHb4g=;
        b=rNS0PpVs8WSj+IJV9gGvkhKbkLA0mdhUyeCP6vA1+g2EZkph1h7Y5R+UeVPKuM0IyD
         0kd77m25UC4X38stNQAjV2kziMJ8r8GoMKU2JAuSX9Rtc3gzZBy7BS0yXaY80KDRdNjy
         /Xpp/r3Qi//KBXrXwENl7VF7IB7X8AgOo4zjZuOrRC7LNCR+DzF3MW+YPXB7Q64mWyzH
         2ri2Klkmlfq0YXV13m5f8fv/h6b8rNOVSQa3/Tc5iOXHHnkewASzCou+EqaA9bSgRDX4
         OlpiZMn1970hWMxZEapM77Ai4hk92wR1LN5ZJR5F3lwsJnzN65KEsMgYsRhWIsu67E85
         s5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713136420; x=1713741220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pc13QrE+mcMLNyC+/9mJ9l2G8Lqrng5Jebsz9BpHb4g=;
        b=AIHjxduEHxreZq8O44ZokJMnSsYEwgeQOukiFdMRjCGOCacG7dEKpFfCAfVBgN2nCz
         iXh/czrtDB+l/prbWwbu8XIDpBu54Q4wYZhCRr+ETOTSyZXUaA65XbEDH4KdTpWgU97I
         aR5+UnGsEMMylD7aKQQ++w5P1gEIFkh2uXjk9iqEzyD8d51q/VltOV8XW3PWzZNS4bWW
         OE049Fnp5nFsRE7u4Q2PwyI21YtOQXSljjTJ4nBoacZhC5p2IZ1QCy1K+QLFG0do8yna
         bhWJURH4m2aZ/ueFAmoMgpXzNlWnevTrmWc6fZ/StnXC5PdDBI5JY8bnTUHbBzz0nXfg
         /Dig==
X-Forwarded-Encrypted: i=1; AJvYcCUHFC0t2dAiAnonRhcdLB+9UKAUxt2TH39GKXdkTojgqyrTJIrsxYUihBW1TNX8U3Uz7HWVLK/LoSzYZ0M/gkqtmxDKhpdBlBAEXewx
X-Gm-Message-State: AOJu0YyPKLiLeKN9DkdNk2dzKx3m0an5bxqfzgVeTSSs7KumHlWe2M+O
	nl2qCJZlMPJleRiVCb6QZc/vTsJ6uVJ/V9hLv67ZVmwIq7ILh5UnUaP1ndZXvnWDA6lfvIR5szK
	QIwWPxH+Q9tPIMR8RvjIvEF3ZZI3PoJ2UrdOFDw==
X-Google-Smtp-Source: AGHT+IHMfnCixFavyGFnOFgqpnrQIq3w30uiJ2YS1tM9ZRsbn/sGrT2sUyDk/RDov0yEDrEAI1leaOZQraIrNUN8HWM=
X-Received: by 2002:a25:c83:0:b0:de1:5656:ba49 with SMTP id
 125-20020a250c83000000b00de15656ba49mr3740557ybm.16.1713136420215; Sun, 14
 Apr 2024 16:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
 <20240414-arm-psci-system_reset2-vendor-reboots-v2-4-da9a055a648f@quicinc.com>
In-Reply-To: <20240414-arm-psci-system_reset2-vendor-reboots-v2-4-da9a055a648f@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 15 Apr 2024 02:13:29 +0300
Message-ID: <CAA8EJpoXrbdD5xVmuo-2b4-WwpSachcJ-abDtu4BS_qa-2A+OA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: Add PSCI SYSTEM_RESET2 types for qcm6490-idp
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Melody Olvera <quic_molvera@quicinc.com>, 
	Shivendra Pratap <quic_spratap@quicinc.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Apr 2024 at 22:32, Elliot Berman <quic_eberman@quicinc.com> wrote:
>
> Add nodes for the vendor-defined system resets. "bootloader" will cause
> device to reboot and stop in the bootloader's fastboot mode. "edl" will
> cause device to reboot into "emergency download mode", which permits
> loading images via the Firehose protocol.
>
> Co-developed-by: Shivendra Pratap <quic_spratap@quicinc.com>
> Signed-off-by: Shivendra Pratap <quic_spratap@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> index e4bfad50a669..a966f6c8dd7c 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -126,6 +126,11 @@ debug_vm_mem: debug-vm@d0600000 {
>                 };
>         };
>
> +       psci {

Please use a label instead. Otherwise it looks as if you are adding
new device node.

> +               mode-bootloader = <0x10001 0x2>;
> +               mode-edl = <0 0x1>;
> +       };
> +
>         vph_pwr: vph-pwr-regulator {
>                 compatible = "regulator-fixed";
>                 regulator-name = "vph_pwr";
>
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry

