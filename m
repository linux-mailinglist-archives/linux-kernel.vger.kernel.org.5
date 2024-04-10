Return-Path: <linux-kernel+bounces-138500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8E489F251
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456952868B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9E069DF4;
	Wed, 10 Apr 2024 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="my+Ci1EC"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683942BAFC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752421; cv=none; b=WRyLp0cmBCN699sxoloRFWbP3Lct1KNtGO/J/hNR8b1Ly5Jdf9gXTv3+6WstI5k/St1Xg1yGYHkA46JH0Ip5e9pgNxeQY8M9Mg1oR/sydwWL8EcblSrTaz1EFpVOgCFEBvZhMTEVNQuH4OZiHpCg/pne/oNg/0ZaiFD6BR5laaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752421; c=relaxed/simple;
	bh=kc0dZ0e3JBP4lFFSI4x6NCpdXrRlKfuJR7I+rUGURhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHIKuqSZ4kWtbCcOsD0doWvHUmCDS08BOTv/hU7eGyaeRi4wUQ4cFyr9C5b4UAfjHxdyfE8Wc9zMNdBbQQAh6hakljH9/69dHimuePO4vFdtmKUUm4uIUtHtshA2UzGzAJOszGFonB5akwcOLGfbIrmU0q0rr87JQhWAZCcSxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=my+Ci1EC; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d727074eso6235971e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712752418; x=1713357218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDmd9nV27QdHdemsMkqkYQn+1GeM6AqMiOUOo3y6Fjw=;
        b=my+Ci1EC6LFP1uNlc+2L9Q7QG94FJ9VneXVizCT5QCKFlmuzMsiz/cSSHQ2qROw4X5
         z1YYWQz/bAJK+bbkmipK9Ry9eFIL9n+Cp7vWOfap5+W91fRBb9pfaxTsY6SGu0qJQfut
         GxItmnci9XDh1ug+p/VWWe8uM70NR9LG+IPtNIj7PvnaQQWf5b5B8MJOcsgImfzlGUK6
         p0LmjzUwotV864u5ItbNFNqVVp6CgeI+/5A3y0hOMEAhgHy02xQokRnO2NVC5a+limFW
         oZhqguAv4RhIKxwS2w7cOoJfQogMHZOhm6H4Nxz9RyObmdTTHGRRNZOMcVYz3310YHCl
         r5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712752418; x=1713357218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDmd9nV27QdHdemsMkqkYQn+1GeM6AqMiOUOo3y6Fjw=;
        b=V/ZisK05qtWjcnQMFoPZ5xshzGTGte1zazzF9KQ2X8dcFrU4sGW7bDV2bb22dKv5yY
         IgevaTpQwAg+crk1SjDlwXBYAo9JCXnH+VQhg0KARf+mk7xPqD/d9Ui6XopGeQAOFN17
         tph41MOv/B1wOJLvTCmVGAv/ctHh+GvILlqzk6ozHxbuY+Qfo6DN/vn53c2qv+8nX7yw
         IivUHG+2Ih6Q0ZZYPCN1ao2/4Z7jSf8B5sK4CTOVVg1yuEyM9261pYd8TdGZcwe5T9gW
         3Pibpf5SAW+SqX0dQ/nPOm7WpqQouqcinZyePs//hb3Q9YAkQcbM2J2JPHwYsPqShYFu
         C2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrTiy2pJ8Euuef532svJZACG44Uf58/eg8sxvLNUcQIuFv7HjdfhQuthO0wnOb2cOW0cMMdVH2E9q++ryUljIWKT5gCLToK9gl3HVz
X-Gm-Message-State: AOJu0Yw67ncbPh5WqmmYf4myHBmvFkSGkptHROPTMN4S+ZgoVXvk7Vsf
	DkLBqrCim1AW++98mqUyU/wFP9QDtOk8HJ9gWeMM8O0PftKpb0SS4t6SJ7PhhIE=
X-Google-Smtp-Source: AGHT+IFTii5izHkTaj9l6tWb307f9H7wWwEJ+dZ19x9pLNKHm+gaZZyS5VFsXUAMjzM4j2enKnHtww==
X-Received: by 2002:a05:6512:484d:b0:517:b2b:6ca7 with SMTP id ep13-20020a056512484d00b005170b2b6ca7mr1521768lfb.59.1712752417721;
        Wed, 10 Apr 2024 05:33:37 -0700 (PDT)
Received: from [172.30.204.89] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a3-20020a056512020300b00516d63a315bsm1737647lfo.104.2024.04.10.05.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 05:33:37 -0700 (PDT)
Message-ID: <17b279d9-e353-4d72-8606-0780ef7194cf@linaro.org>
Date: Wed, 10 Apr 2024 14:33:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] arm64: dts: qcom: sc8180x: switch USB+DP QMP PHYs
 to new bindings
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
References: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
 <20240401-typec-fix-sm8250-v3-5-604dce3ad103@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240401-typec-fix-sm8250-v3-5-604dce3ad103@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/1/24 22:33, Dmitry Baryshkov wrote:
> To follow other Qualcomm platforms, update QMP USB+DP PHYs to use newer
> bindings rather than old bindings which had PHYs as subdevices.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

[...]

>   		usb_sec_qmpphy: phy@88ee000 {

This unit address also needs to be updated

LGTM otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

