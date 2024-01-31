Return-Path: <linux-kernel+bounces-47148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A28449D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629001C23955
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7533A1BE;
	Wed, 31 Jan 2024 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr2S9NsE"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D871039ADD;
	Wed, 31 Jan 2024 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735833; cv=none; b=rL/UHSbt5+qW+x+wxPslaWTbGkZbOCwirEFJnQdKHv+X6QDompZtUG37H6dqjeHLX577WBL6eGIg07yxNZ/IRQ764bgMGE8Cxhdk5tdQbu2j1A0bY2UqZ1n20Sv4C5ZZ1/BP1RYJM+lbvwc+ivS4eUe/5KQVdQoXzzijVWkOM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735833; c=relaxed/simple;
	bh=WRd2BWX2pBuO3cZGeM+m5uzScqG6kgM6Mp9Vdn9E4W4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=psWy3me6rJebkL9h94JOqMTeqy4+iaeElbw+W6RZ00+mh1b0ulFXUQLQke+mHws5HBq4xO8FCCg0pm2ewi6cze+0Yz2mO30UuBgKEuheqSSWjJuU88m5BPlOZ8ERiyaTlDePiOjqQwUHWOrQd4xg9lkEehBMWeL/462i5w4BgUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr2S9NsE; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso276302a12.0;
        Wed, 31 Jan 2024 13:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706735830; x=1707340630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m809IEfmsOt69Mzj+ewn9rd/I21cqoMQF9Z+13+EcwY=;
        b=Lr2S9NsEuvTZml5aEqUfNsl0y7o1e2dl61oNSYDkjZD2dWlwZIvqiOSrH4DfmvX/ls
         zH7CJnRGQJJu+tng+S3Dmfh07Z4K7KSaq5OmJ8nR9e0zYTko3tMJbA1C/dT6qzKrLEzH
         0HVEOfqYgVBqofTK5iicny3iUpastR3Q66vavttqCfVWwps+TvAeoBDZZE2KEsTm5p12
         1dDDuRkw5o/Xmw1KnaWB5IzkPByhJA+suo4xQTU33/3ugZU/as3OsRm1vADJ1OsvOdvj
         ekiSxhAREcXYiYwERvPzkHAs+IlGESFd2Oyzx2cZORFZTdM97yjTM/mjN6awKC9iGh3L
         AHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706735830; x=1707340630;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m809IEfmsOt69Mzj+ewn9rd/I21cqoMQF9Z+13+EcwY=;
        b=OgeYTOznbzoWnshI/DWnhlb//cLC5kL25m6KhjZDTruN778/racrCib4OAaa37Zogt
         g+9ORkW2EsCloqc+mRC50ZCi84is8LubDn5S+wlr2lIIGElDYNPdRP1jVxNGuxq7b1Mr
         YsxNAp9mwaoCd73JzhAQ3C7DMHSYpLwYNBJqPWap8gR2pJUSE2VHRTAayMeSqhK8LQ/e
         B7id0TZAPVDCz70L+vB725qLho/3vpfnYoZBxgx6lAmuClqgSUXfJKs90cbz/iG8B2UP
         AtnGn5PPsc4p/KPvxjV9lWrERRt8L/PMq19rGqEUaeFlkPmzEFV/Sfgc9mPFDaHrsmDI
         qMkA==
X-Gm-Message-State: AOJu0Yy5O6l4ioj+C9zqjRyXes+mtl98JtgX41blC38MQCddqNjEb+d/
	76fd233k1zFEnI4pFa0vJ75fBBRQWCwKL8J5leTCp5iyDm9uMl4q
X-Google-Smtp-Source: AGHT+IErUVMAdxFTL73O0fpk+TAYJywDN+0bWX9BrjrCHQ2aPbxJ4ulDwCy4QPkkxKUz88lXPQE+LQ==
X-Received: by 2002:a17:906:b892:b0:a35:6667:b3ed with SMTP id hb18-20020a170906b89200b00a356667b3edmr2101448ejb.8.1706735829899;
        Wed, 31 Jan 2024 13:17:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX4l5u5Ajq9ylzzqYpkqzDFhuvJh6UcTWtUwBEF20/WVE5VlfDsUyor+mEeZhXLOS2GpQoSC9Sgo88wnvbODLkZGVeRbj9lG+gIRVnZP1vsjzbL2G8/xcZUxrmCYT/qtoTMBprmmHqnJqwDTkJA6vZ4g7eo79nvaQ66KWmrR12G4BSEOCMzNZrUO9uruaVQ2jISuTjR/x2xCoc8q0EPUi6S56Wz20U+XQ3GfsmmRq76t4ptsu1HiXh5tOOx1FYeVAxL13LZXKK9mYPpqxSJDV5ZWWsk772icN/1jsPaFih0xzaiBrBt2kULGo7L2yPgsPLl+OdrHDPs0ox70Acg3WsG0ti+vTFkGDdmwZ3Y9PnSqYrRJWmFOIeXvc9C0V9Jfha+QpQMuU/QN92BLmS1l9P5mUcVvIljvPlocx6TTEE9Q/+ZenkbwsEVGHVFh2goYy1Exqm/CcsgmuejRhklC2OVO/VN88jzLu6+Pd1YFVQkX1nH2durRSTdTfWH4FlTdugj1dxzEc8uY3FWDM2/82OoNk4Q6AF9Wv2kcYESlYNmyNni00kfClh7JtANd897aYugEORlc76hXEgrq1Y=
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ty5-20020a170907c70500b00a35a8571419sm4040634ejc.135.2024.01.31.13.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 13:17:09 -0800 (PST)
Message-ID: <e5dea3b7-bf84-4474-9530-cc2da3c41104@gmail.com>
Date: Wed, 31 Jan 2024 22:17:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 5/6] arm64: dts: rockchip: fix rk3328 hdmi ports node
To: robh+dt@kernel.org
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 mripard@kernel.org, markyao0591@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <a493c65e-7cf9-455f-95d5-8c98cad35710@gmail.com>
Content-Language: en-US
In-Reply-To: <a493c65e-7cf9-455f-95d5-8c98cad35710@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fix rk3328 hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V2:
  keep reg-io-width together with reg
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index fb5dcf6e9327..a73234b11ff1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -745,11 +745,20 @@ hdmi: hdmi@ff3c0000 {
 		status = "disabled";

 		ports {
-			hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
+
 				hdmi_in_vop: endpoint {
 					remote-endpoint = <&vop_out_hdmi>;
 				};
 			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};

--
2.39.2


