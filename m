Return-Path: <linux-kernel+bounces-166252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316B18B981A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57FC1F24F04
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362BD56B6B;
	Thu,  2 May 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ov5vC8kL"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6BF56444
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643515; cv=none; b=T4u1sJrR3GjepgEVApwujF/tw9O1NNCt0DZUDmLejqlG4zIVjlF81HC59BfPqZWFRUuZOXpKbZVUrd3OkbiVtch+ABxBJiS9//NqqZ0Wf9icZ5Oj+bLxDx7LJG1MVInQXx61Cv37oT9AAW3/3+lcLA8yWpgXCzg6VEOV7tjuM5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643515; c=relaxed/simple;
	bh=/TCOrrZIziWIoZHm680VfmeZr4x/v7De8uT3VCYEd4w=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ItNVrAGlheiTW+UQqxo7iCzPiFdih5FL+6f8TRJdp4MpV7LE92oMDWqejToMw+sZO8JIaRu5J7zDiZNwpvJw1VzQ7cEn5u2kHbXBxfGGGMBUD3u3f5DgABMNHZJJnj92+4VZmg5W14lEHdYRt5QLDNH6F19yj8ouWZJ6dhO4ClM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ov5vC8kL; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so9658281e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714643511; x=1715248311; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwHJ9SUvvvu/eTS+n+2CuD+oluv5OCbi0dkOhie1vG0=;
        b=ov5vC8kLHU03jsPjcPGzh0PYkxy6g2a8BzI3o35ehUjpylQ7l+OeX1GCb7Nm7nVBy8
         MbNrEPopopm1QAq618+w6crjfAuZH4Fm1rtyzhfoCo9gU9MlI13M8OvADGtV9b4egWMm
         1hxyjc2Er/bOkHkTYwgh2wxOph5dqB9NMxG0fmpsaqSmpHXF+B22zsuXFD8NOUMj837d
         awo4egPiSXVWaTJr5QGdSxEYoLip+xSLvBDo4R+K+72h7SF0trOQZG7jKEAOaCFMCbgt
         w7lk0CHNK5y63ofGQ1PbnaooaNl/lv+wlKOwbQGOBJNXDM0nei2jBcH6Ru4yIi8YUK5M
         zIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714643511; x=1715248311;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cwHJ9SUvvvu/eTS+n+2CuD+oluv5OCbi0dkOhie1vG0=;
        b=hp6X3UjgHXSdj/Pzwlk2+M463mRYATpYd3ZiJNGhn11kHchzcam5qK2534RxVNJMXe
         ghdAewer9kZwpNi5CNx1e+yskbDI1DJJ/FFQFOTvifCaCZeUUDOwamtJgiLD8DA/USWL
         a8IbQlxcHi2jJSy0/qcSbcBAu7LOwIhTaE3uK+ERykUOIwveD3jcsevSGcwleXUDgB0Z
         8969a+/quOrjRCFEPEK4ZNkwe9yUDMnNwIB4IXKGc4rHED2ObB2kz8mw0NzuxjOQpTFG
         lFlNX+44ozVpSY/6/u/InOeRUIdyPG7D99KkoMarZVrzN0P84jYXTVQMjJQOfknRQSKV
         8iSw==
X-Gm-Message-State: AOJu0Yzx0zPrGZD/WQ8VEdLKD4nkeQLEe/0gqMmM3TxAPWMiaXW/WRwd
	jz0qFZVLUNPlfSEuPeiVFqC9uOGhjpH/pxm+Pv0SCxYIJ86BmSYtsUwEExIIYeQ=
X-Google-Smtp-Source: AGHT+IH2nAedYmYkm09WVVnEdOPLPX/GEHT4/F0CjpiidPPF5MGNtDslJvDE/ZPiN6HaEr0YLxtgEA==
X-Received: by 2002:a05:6512:3d24:b0:512:cc50:c3e0 with SMTP id d36-20020a0565123d2400b00512cc50c3e0mr4374971lfv.52.1714643509112;
        Thu, 02 May 2024 02:51:49 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id i14-20020a05600c354e00b004169836bf9asm5103376wmq.23.2024.05.02.02.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 02:51:48 -0700 (PDT)
Message-ID: <89a02410-87c8-47c6-aa50-04dad5b4e585@linaro.org>
Date: Thu, 2 May 2024 11:51:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 Lukasz Luba <Lukasz.Luba@arm.com>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Priyansh Jain <quic_priyjain@quicinc.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Hsin-Te Yuan <yuanhsinte@chromium.org>, Aleksandr Mishin
 <amishin@t-argos.ru>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 Binbin Zhou <zhoubinbin@loongson.cn>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal drivers for v6.10-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

please consider this pull request for v6.10-rc1

The following changes since commit 5c897a9a1237155822183b8979005d06c14a996a:

   Merge back earlier thermal control material for v6.10. (2024-04-19 
15:17:21 +0200)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.10-rc1

for you to fetch changes up to 734b5def91b594d3aa1147d60c45eded139ce2eb:

   thermal/drivers/loongson2: Add Loongson-2K2000 support (2024-04-23 
12:40:30 +0200)

----------------------------------------------------------------
- Add QCM2290 compatible DT bindings for Lmh and fix a null pointer
   dereference in the lmh driver in case the SCM is not present (Konrad
   Dybcio)

- Use the strreplace() function instead of doing it manually in the
   Armada driver (Rasmus Villemoes)

- Convert st,stih407-thermal to DT schema and fix up missing
   properties (Raphael Gallais-Pou)

- Add suspend/resume by restoring the context of the tsens sensor
   (Priyansh Jain)

- Support A1 SoC family Thermal Sensor controller and add the DT
   bindings (Dmitry Rokosov)

- Improve the temperature approximation calculation and consolidate
   the Tj constant into a shared area of the structure instead of
   duplicating it on the Rcar Gen3 (Niklas Söderlund)

- Fix the Mediatek LVTS sensor coefficient for the MT8192 in order to 
support
   it correctly (Hsin-Te Yuan)

- Fix a null pointer dereference on the tsens driver when the function
   compute_intercept_slope() is called with a null parameter (Aleksandr
   Mishin)

- Remove some unused fields in struct qpnp_tm_chip and k3_bandgap
   (Christophe Jaillet)

- Fixup calibration efuse data decoding, consolidate the code by
   checking boundaries and refactor some part of the LVTS Mediatek
   driver. After setting the scene, add MT8186 and MT8188 along with
   the DT bindings (Nicolas Pitre)

- Add Loongson-2K2000 support after some minor code adjustements and
   providing the DT bindings definition (Binbin Zhou)

----------------------------------------------------------------
Aleksandr Mishin (1):
       thermal/drivers/tsens: Fix null pointer dereference

Binbin Zhou (4):
       thermal/drivers/loongson2: Trivial code style adjustment
       dt-bindings: thermal: loongson,ls2k-thermal: Add Loongson-2K0500 
compatible
       dt-bindings: thermal: loongson,ls2k-thermal: Fix incorrect 
compatible definition
       thermal/drivers/loongson2: Add Loongson-2K2000 support

Christophe JAILLET (2):
       thermal/drivers/qcom: Remove some unused fields in struct 
qpnp_tm_chip
       thermal/drivers/k3_bandgap: Remove some unused fields in struct 
k3_bandgap

Dmitry Rokosov (2):
       dt-bindings: thermal: amlogic: add support for A1 thermal sensor
       thermal/drivers/amlogic: Support A1 SoC family Thermal Sensor 
controller

Hsin-Te Yuan (1):
       thermal/drivers/mediatek/lvts_thermal: Add coeff for mt8192

Konrad Dybcio (2):
       dt-bindings: thermal: lmh: Add QCM2290 compatible
       thermal/drivers/qcom/lmh: Check for SCM availability at probe

Nicolas Pitre (11):
       thermal/drivers/mediatek/lvts_thermal: Retrieve all calibration bytes
       thermal/drivers/mediatek/lvts_thermal: Move comment
       thermal/drivers/mediatek/lvts_thermal: Remove .hw_tshut_temp
       thermal/drivers/mediatek/lvts_thermal: Use offsets for every 
calibration byte
       thermal/drivers/mediatek/lvts_thermal: Guard against efuse data 
buffer overflow
       dt-bindings: thermal: mediatek: Add LVTS thermal controller 
definition for MT8186
       thermal/drivers/mediatek/lvts_thermal: Add MT8186 support
       thermal/drivers/mediatek/lvts_thermal: Provision for gt variable 
location
       thermal/drivers/mediatek/lvts_thermal: Allow early empty sensor slots
       dt-bindings: thermal: mediatek: Add LVTS thermal controller 
definition for MT8188
       thermal/drivers/mediatek/lvts_thermal: Add MT8188 support

Niklas Söderlund (2):
       thermal/drivers/rcar_gen3: Move Tj_T storage to shared private data
       thermal/drivers/rcar_gen3: Update temperature approximation 
calculation

Priyansh Jain (1):
       thermal/drivers/tsens: Add suspend to RAM support for tsens

Raphael Gallais-Pou (1):
       dt-bindings: thermal: convert st,stih407-thermal to DT schema

Rasmus Villemoes (1):
       thermal/drivers/armada: Simplify name sanitization

  .../bindings/thermal/amlogic,thermal.yaml          |  12 +-
  .../bindings/thermal/loongson,ls2k-thermal.yaml    |  24 +-
  .../bindings/thermal/mediatek,lvts-thermal.yaml    |   6 +
  .../devicetree/bindings/thermal/qcom-lmh.yaml      |  12 +-
  .../bindings/thermal/st,stih407-thermal.yaml       |  58 +++
  .../devicetree/bindings/thermal/st-thermal.txt     |  32 --
  drivers/thermal/amlogic_thermal.c                  |  10 +
  drivers/thermal/armada_thermal.c                   |   9 +-
  drivers/thermal/k3_bandgap.c                       |   1 -
  drivers/thermal/loongson2_thermal.c                | 117 ++++--
  drivers/thermal/mediatek/lvts_thermal.c            | 438 
+++++++++++++++------
  drivers/thermal/qcom/lmh.c                         |   3 +
  drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   1 -
  drivers/thermal/qcom/tsens-v2.c                    |   1 +
  drivers/thermal/qcom/tsens.c                       |  33 +-
  drivers/thermal/qcom/tsens.h                       |   5 +
  drivers/thermal/rcar_gen3_thermal.c                | 165 ++++----
  .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  26 ++
  18 files changed, 667 insertions(+), 286 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
  delete mode 100644 
Documentation/devicetree/bindings/thermal/st-thermal.txt

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

