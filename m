Return-Path: <linux-kernel+bounces-44785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5B684275B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77C41F25952
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9553982D7B;
	Tue, 30 Jan 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdBK9YnV"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED7D823C8;
	Tue, 30 Jan 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626703; cv=none; b=MyY3Tcg22se0lYt1slElgTZZqRNEs0h5M4QNjxXdjm2dCcG/qFK897PzCxJk8DVwACNef+uMoMWnIXZKlVBwS17U26MN2EEwaq1yCCHbElCIrCmhffHzhfoXqyqerHiZxwTTHeHuEtYdA82JsM3SrE+vhRNQ0AuQHu4+JY4OjHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626703; c=relaxed/simple;
	bh=Cui/tO/13QImHPsCGYjMCPB1bovxuPUeQHekMvjoaCM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kCWDu/vK5UpcOIkeu3fH29m96w19dysAyOYFQjQy0uLbVJFO52DgWzqyjCoZLVyin2oG1WmKvOamhmYl22VYF5U9cmMxDfysQspzILb+xLBDTrxSJJ/1Iy3IjBAyXgE7K339zc9sKrFEjtaCYEeWXuMpj8oIT7Ty8iIW2EkqUqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdBK9YnV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so4094002a12.1;
        Tue, 30 Jan 2024 06:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706626697; x=1707231497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wDIfMQ4YppB4DGt1fhFV2sj3z9j8y70f63I+fQjYLro=;
        b=ZdBK9YnVvQhBf+3CvRzRM8lTnYsdv3cqq7Qfh2zcrapoymqY346VhQrmhtEeZnTyPI
         ESapl8X868mk637XGf8YmpO5PeMGwWlEyHwVwz1xE6vOnrMvNLQHr5skup37e0WaCMgd
         035u2BxlrW/TySBZ1xuk7M2HXR/36FOSuEvf3PjU7yHaaCf/Iznr8q298y7F0KkqxBAS
         PUnC312b+OKNZd+wupzWyVezTL7/zzSD8nnYwMrEwlLgw3g8uvsfnOlXkAXLHqeUlS0J
         zqbvo8SN3YTgEMu/oAfF8Jyx/qQ7g5Gbf4jp4hllWsDGhGdiaxIEf7marMG0dL0fCUFh
         aVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706626697; x=1707231497;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDIfMQ4YppB4DGt1fhFV2sj3z9j8y70f63I+fQjYLro=;
        b=mQXpdEjCys+sLto/S+DFGg4ifs4CbQlJYk9+ujkeUWFHmrROHWKpbQh9149jBGFgTv
         knBKdXIDLsdUVfLg17zL6xd4PIb4Cx2JEU2MYTU1ZCPxNjRjptv4OUy3xDo89S7QZNik
         6OFjXH6ZaS0nzkizsseEcMFkJhV7WIRMZvOdmP9NuaBwjOGSi7TBFv+j+tyZZExxPF3M
         nmYVprkKvXoAXjHHXc+WH1WXZ31cAGx8sp8R30omN7oYi5v6lbIhEqE91rPK4U4bpYij
         7P0yvm953IMSDLFyoxyINTvqqzX+pfpNQZ6KofAt+I6te6lGzEUKln0avBzbAIkRN3JM
         rh0A==
X-Gm-Message-State: AOJu0Yy0l54nUGg5QjKU/LtVfauBCIpSf1kJoy8HkqIJX882DgQpi4Xd
	dFj1/TXcbdwy6sdQY+tuc9EqHHNJOiOHso1gkOkaX9RbDruc76Ep
X-Google-Smtp-Source: AGHT+IHvJArqPJqZnH6euVbiof6RL1gXCHBYuSD6TyZvGNld40TRQAsIZ0dZSKcNjKL6L/R4KE/cHw==
X-Received: by 2002:a05:6402:5248:b0:55f:1a79:8b88 with SMTP id t8-20020a056402524800b0055f1a798b88mr3505590edd.8.1706626697028;
        Tue, 30 Jan 2024 06:58:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUv0zzlmDCmLM/C8Pog5kBc4B7TOhbegqNOybC25UNveppsRNbfGbmpkYOJ+AeIijxejLdpeAquEl81uTcvas8OKRqoB1wRBPz2yAvN+Mvl6TmmWHD3oCyzrtgHR6WBMoRhyjkj1ai7xb2WlZFNOmfQ66/C/1PPpjIYx0jAlt2sQJBIsxFloLhANWpKLhkKK3bZ86AvMFz+O2CbpiLb7UA7uolrrgwwdLb0xx3QHqsCHP+/eDm2vtrzUncfdGy98MqPEkv7l+AlfaQCov73u+twnInqBCVw3VakzFOzL4usSAmQnhsB0B0Kzs4ISKvSbjK8nZrbl8G/z7c4u/soKDEkUHt1qiCnP8rI9lkgUwjRa+Uzx+vLoN/s9Ty3gMPn+zHTax5DV/8U0bbxRK4oZ87lFeD5uy4ao2DdBeEvg+P8pZyjwHhTZt2V2rJMdtaeK714eCG8TKm+IKD17UK7h9WO7sy5spFExRjXRQIM9/21JEFKSjkQi8goCg3Ghd3p6wkbwTocaKTz9wLnMxsJO1cyLKpoGAk65cI=
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7da47000000b0055f0c027a3esm1879542eds.30.2024.01.30.06.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 06:58:16 -0800 (PST)
Message-ID: <e15c95b6-7981-4075-9f5c-44220822166b@gmail.com>
Date: Tue, 30 Jan 2024 15:58:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 6/6] arm64: dts: rockchip: fix rk3399 hdmi ports node
To: robh+dt@kernel.org
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 mripard@kernel.org, markyao0591@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <6626d288-ecf1-436b-b0a3-3417308a8633@gmail.com>
Content-Language: en-US
In-Reply-To: <6626d288-ecf1-436b-b0a3-3417308a8633@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fix rk3399 hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 0caa842bba0e..2c4924465aad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2036,7 +2036,11 @@ hdmi: hdmi@ff940000 {
 		status = "disabled";

 		ports {
-			hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;

@@ -2049,6 +2053,10 @@ hdmi_in_vopl: endpoint@1 {
 					remote-endpoint = <&vopl_out_hdmi>;
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


