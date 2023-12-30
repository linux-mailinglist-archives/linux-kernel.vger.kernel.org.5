Return-Path: <linux-kernel+bounces-13375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A90182042A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4569282214
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5445423AF;
	Sat, 30 Dec 2023 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS6vBKp8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315877481;
	Sat, 30 Dec 2023 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-336990fb8fbso5495329f8f.1;
        Sat, 30 Dec 2023 01:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703929604; x=1704534404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KcIgIsj01sfpjFRquhulh/IanhBls2XFsraUoERkxCs=;
        b=MS6vBKp8HqZv59GYesUXKr133KhKV70TDGlZRxNNV+Kjwa3dNu/v89gruWef00PK1b
         QfgskflhhqrwgtC0t89bdKqO2Us5opVo7pjt7KhewCsPm0k/XJxyz5leAm2u6ktJY2PA
         fCilVP9V+jzh5ccU5tQAqD211I+zhEUH1++liYiZ2DNy1jWR0o+wJByw9HXKQmxiuSX1
         GPIKxt2X88NX435QSakiBRD/LQ6NzCwJpBLIFjc2GGhscETNNigpzoK3NbfmEHgoG/d6
         2Z3LSl/fR8gW8XCHY49eyvDJeVH6TNOrRc8nBNqaPGLY4E3gSnTYzT2PgF5nT/t4pwui
         2qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703929604; x=1704534404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcIgIsj01sfpjFRquhulh/IanhBls2XFsraUoERkxCs=;
        b=HrLtgp2L1H6tKURg3Kfo7hogOb/74HD0jYJLTt/AcOKtDSgCzYYK2bhzqlDI9cJ3Jf
         zxttgd5y+RyZTgiI+GQ9o7OtAmTAEriBjHGDfzEc0Y3qLurWngEXy25tZmenveYVxdWF
         Be+lzt1P9Nr4zeTQjdloZWPzDqDhfQOaTSFd5DF3tPvaOTYHlaLt3GJ+DL59es2mIHVg
         5fjH6b5dP9+aX4N7AamVyOP+opIhKPbk/snasCR+B7cgtpJPUqtmC/DHbT9kaE1tuu7n
         mz0T3JtCTD+aAlHUtBpOXcVjRqLZ6GKlfSydAAdVi+41EaA8KqGRtPDJ1HEkfrcwbOFQ
         31lQ==
X-Gm-Message-State: AOJu0YzWN9qYRdJ2Vm3nOtsD4aaJZdit57k+Ww5+vCmHbe7upiyROo4f
	WnwuFUv6LDjX4WXBLwyegsCOpygBMQ==
X-Google-Smtp-Source: AGHT+IFHjVI4HXWdQwlGa3DbmbNjqiZW1HpjbV8+bibBI296VYU1udwPscg4qW0FUPVSkm3UCaEiPQ==
X-Received: by 2002:a05:6000:c4:b0:336:8085:3bac with SMTP id q4-20020a05600000c400b0033680853bacmr7150627wrx.77.1703929604115;
        Sat, 30 Dec 2023 01:46:44 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:eee3:932b:58d4:3518? ([2a02:810b:f40:4300:eee3:932b:58d4:3518])
        by smtp.gmail.com with ESMTPSA id t12-20020adfe10c000000b00336f43fa654sm8149059wrz.22.2023.12.30.01.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 01:46:43 -0800 (PST)
Message-ID: <35df6456-2bc2-415d-bc61-09e4b440e2ac@gmail.com>
Date: Sat, 30 Dec 2023 10:46:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add hantro g1 video decoder support for RK3588
Content-Language: en-US, de-DE
To: Jianfeng Liu <liujianfeng1994@gmail.com>, ezequiel@vanguardiasur.com.ar,
 p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, heiko@sntech.de,
 sfr@canb.auug.org.au
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20231228131617.3411561-1-liujianfeng1994@gmail.com>
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20231228131617.3411561-1-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Jianfeng
Am 28.12.23 um 14:16 schrieb Jianfeng Liu:
> This is the v2 version of this series adding hantro g1 video decoder
> support for rk3588.
> 
> Changes in v2:
> - Fix alphabetical order in patch1 and patch3
> - Sort device tree node by bus-address
> - Drop rk3588_vpu_variant fron v1 because that is exactly the same as rk3568_vpu_variant
if the RK3568 and RK3588 variants match, patch [1/3] is not necessary. Just
document a additional compatible in a similar way it's being done for
rk3188/rk3066 or rk3228/rk3399.
If there are ever differences we don't know about yet, a additional variant
can still be added in the driver.

Alex


> - Link to v1: https://lore.kernel.org/all/20231227173911.3295410-1-liujianfeng1994@gmail.com
> 
> Jianfeng Liu (3):
>    media: verisilicon: Add support for Hantro G1 on RK3588
>    arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
>    dt-bindings: media: rockchip-vpu: Add RK3588 compatible
> 
>   .../bindings/media/rockchip-vpu.yaml          |  1 +
>   arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 20 +++++++++++++++++++
>   .../media/platform/verisilicon/hantro_drv.c   |  1 +
>   3 files changed, 22 insertions(+)
> 


