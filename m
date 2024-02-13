Return-Path: <linux-kernel+bounces-63852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B61853583
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391A11C24ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824CE5F564;
	Tue, 13 Feb 2024 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dpxQDKQg"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D758108;
	Tue, 13 Feb 2024 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840083; cv=none; b=J3ndUyggoRnkG+1z9HVRJKAfM8/6udirL9Y7lbxraoJ40SEFXbFr4b2YxYGXYXso5gbBc+meHbLmnIhO8uP/JvlZLAGVZOI+nK1/Uq4KBiMdckWOYSXhK8we/s9Dh7c+dGuUCppEAoDeM1ctMN+j2vudL5h3trJg99sHSx3150I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840083; c=relaxed/simple;
	bh=Rmmr5ve2QPJb9LsgoZooJA8bclacYw+Kli7QPTZIrwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VkGHwEIzS+UWLbOuTDd40DSiUiNbMLeo2Sra4ZYDJspTV+9jLZEaxRFEfYFveWBfzboK++yy4oE0WFouxL9ebcOcZWmEHHw1D4HpH7mdvYxG3t7jFVCfHU1YJNMAFTV4WTaNra0UncP2YDWmoOk27WClBhywHR+UhvoILVfrxEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dpxQDKQg; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41DG0qO7018324;
	Tue, 13 Feb 2024 10:00:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707840052;
	bh=4A6mcITJSv/WywOIQJrp5wMO3GTMsH5C1aAFPUy40jA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dpxQDKQgs/LQNe3rKX922HO/KiwWoy9vxkPHl1WIb/Qq/bA2iu/+ZDuU5zvWb0JRE
	 q4GPX2x/EInhN40kOmctGcvi1mGQdwoxbZKl8Ce/X+c8oV2pvMTH5YoMZMRifL2OSV
	 R77xfAm61noBrO0tt02tuYEPGI+9OecRq1BKKnx4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41DG0qAW011385
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 10:00:52 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Feb 2024 10:00:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Feb 2024 10:00:51 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41DG0pnV070046;
	Tue, 13 Feb 2024 10:00:51 -0600
Message-ID: <ec079a72-adc7-4a33-8486-e3b624ef6ba5@ti.com>
Date: Tue, 13 Feb 2024 10:00:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: dt: Update overlay file extension
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet
	<corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si
	<siyanteng@loongson.cn>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <5ac79104822cdce7a4caab87f14ce02477f85820.1707819511.git.geert+renesas@glider.be>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <5ac79104822cdce7a4caab87f14ce02477f85820.1707819511.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/13/24 4:24 AM, Geert Uytterhoeven wrote:
> Building DTB overlays from .dts files is no longer supported.
> Update the documentation to reflect this.
> 
> Fixes: 81d362732bac05f6 ("kbuild: Disallow DTB overlays to built from .dts named source files")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Andrew Davis <afd@ti.com>

>   Documentation/devicetree/overlay-notes.rst           | 12 ++++++------
>   .../translations/zh_CN/devicetree/overlay-notes.rst  | 12 ++++++------
>   2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/overlay-notes.rst b/Documentation/devicetree/overlay-notes.rst
> index e139f22b363e9f36..35e79242af9a928d 100644
> --- a/Documentation/devicetree/overlay-notes.rst
> +++ b/Documentation/devicetree/overlay-notes.rst
> @@ -38,10 +38,10 @@ Lets take an example where we have a foo board with the following base tree::
>   	};
>       ---- foo.dts ---------------------------------------------------------------
>   
> -The overlay bar.dts,
> +The overlay bar.dtso,
>   ::
>   
> -    ---- bar.dts - overlay target location by label ----------------------------
> +    ---- bar.dtso - overlay target location by label ---------------------------
>   	/dts-v1/;
>   	/plugin/;
>   	&ocp {
> @@ -51,7 +51,7 @@ The overlay bar.dts,
>   			... /* various properties and child nodes */
>   		};
>   	};
> -    ---- bar.dts ---------------------------------------------------------------
> +    ---- bar.dtso --------------------------------------------------------------
>   
>   when loaded (and resolved as described in [1]) should result in foo+bar.dts::
>   
> @@ -88,9 +88,9 @@ in the base DT. In this case, the target path can be provided. The target
>   location by label syntax is preferred because the overlay can be applied to
>   any base DT containing the label, no matter where the label occurs in the DT.
>   
> -The above bar.dts example modified to use target path syntax is::
> +The above bar.dtso example modified to use target path syntax is::
>   
> -    ---- bar.dts - overlay target location by explicit path --------------------
> +    ---- bar.dtso - overlay target location by explicit path -------------------
>   	/dts-v1/;
>   	/plugin/;
>   	&{/ocp} {
> @@ -100,7 +100,7 @@ The above bar.dts example modified to use target path syntax is::
>   			... /* various properties and child nodes */
>   		}
>   	};
> -    ---- bar.dts ---------------------------------------------------------------
> +    ---- bar.dtso --------------------------------------------------------------
>   
>   
>   Overlay in-kernel API
> diff --git a/Documentation/translations/zh_CN/devicetree/overlay-notes.rst b/Documentation/translations/zh_CN/devicetree/overlay-notes.rst
> index 43e3c0bc5a9f8235..ba5edd05dc1e7fd2 100644
> --- a/Documentation/translations/zh_CN/devicetree/overlay-notes.rst
> +++ b/Documentation/translations/zh_CN/devicetree/overlay-notes.rst
> @@ -43,10 +43,10 @@ Documentation/devicetree/dynamic-resolution-notes.rst[1]的配套文档。
>   	};
>       ---- foo.dts ---------------------------------------------------------------
>   
> -覆盖bar.dts,
> +覆盖bar.dtso,
>   ::
>   
> -    ---- bar.dts - 按标签覆盖目标位置 ----------------------------
> +    ---- bar.dtso - 按标签覆盖目标位置 ---------------------------
>   	/dts-v1/;
>   	/插件/;
>   	&ocp {
> @@ -56,7 +56,7 @@ Documentation/devicetree/dynamic-resolution-notes.rst[1]的配套文档。
>   			... /* 各种属性和子节点 */
>   		};
>   	};
> -    ---- bar.dts ---------------------------------------------------------------
> +    ---- bar.dtso --------------------------------------------------------------
>   
>   当加载（并按照[1]中描述的方式解决）时，应该产生foo+bar.dts::
>   
> @@ -90,9 +90,9 @@ Documentation/devicetree/dynamic-resolution-notes.rst[1]的配套文档。
>   DT中的适当位置。在这种情况下，可以提供目标路径。通过标签的目标位置的语法是比
>   较好的，因为不管标签在DT中出现在哪里，覆盖都可以被应用到任何包含标签的基础DT上。
>   
> -上面的bar.dts例子被修改为使用目标路径语法，即为::
> +上面的bar.dtso例子被修改为使用目标路径语法，即为::
>   
> -    ---- bar.dts - 通过明确的路径覆盖目标位置 --------------------
> +    ---- bar.dtso - 通过明确的路径覆盖目标位置 -------------------
>   	/dts-v1/;
>   	/插件/;
>   	&{/ocp} {
> @@ -102,7 +102,7 @@ DT中的适当位置。在这种情况下，可以提供目标路径。通过标
>   			... /* 各种外围设备和子节点 */
>   		}
>   	};
> -    ---- bar.dts ---------------------------------------------------------------
> +    ---- bar.dtso --------------------------------------------------------------
>   
>   
>   内核中关于覆盖的API

