Return-Path: <linux-kernel+bounces-109482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB71881A19
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC001C21172
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831408613B;
	Wed, 20 Mar 2024 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wtnlTsix"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB86BFDB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710976141; cv=none; b=WYScDjMM8PWC7Vc8u30+0mzkm1NBHVt9HPUSg3onw9KPT2/3zLB8VydWw+8ynzQ4+/NCJDbgNmR0Hw7dtbaqrBkxvfO4J7+5JHWE/XXadAGhSoVcx8v7yUXIXk4mu8uMdxJ+kWKeJcGOiT653coeYpt0dXsk3EaiAt3Wn26SniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710976141; c=relaxed/simple;
	bh=wEitcMtU69ELTQ6HFUAJtJm8A18kUQS1wB/GUBQBwI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GvRARxV8vdo1usii4LF60NxtaktaI3LpZ33GRIx9q/eCwK3/7Ze9Id6wRye0Qu91JL/EtCcv/4wk/Ne5WZehJVNDO9aR0ILrwhx+R/FnO5gLcQYxglWCdtBf54dkuReR0rNKD0GzrAtdUM/ahv+NzlMeP0nM0ZHB7vHwjyKJTfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wtnlTsix; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d49871732fso991671fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710976137; x=1711580937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkXn2l9aQZGCQHALJx17Ml36xPwVxX2TSWrjLHWJzFk=;
        b=wtnlTsixQ64fAnB5ADKJxhH89+rsYZIPpYp9XtwjJ6FRckH39iNaShQD9RbsqAvcbX
         +qAMDGacbSSriXNZ1zT0XFptmilwmlhpn37OX8ZUU57+een8eqBu943FFmczZaw45Iub
         sqSvQFgs98JrLma8+UCiZzOvwTnG9Dug1qh8tNT8e1MSptv+AMrUMZwyyGCXO6xPJ2tG
         QL5AvWqX3oKaFKw7Z3ARA+Z9H94d4L/lgH8802OBhl87piOIu8XF+K/n1lTXUutBPzYg
         f7W00tD3icjlCjwyGsmbaImqU35yuXbriuspn+i+QgsclTzhabB18cv01Xq8AqEfWpYK
         SrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710976137; x=1711580937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkXn2l9aQZGCQHALJx17Ml36xPwVxX2TSWrjLHWJzFk=;
        b=rjPO2l4cyOz0HiNUrkd7Y0y/xgoGMA1VJR3O5YZhlkZ5ImJ56M/s0YL7S7Ybzp1LgF
         cHhdjFKYlvF/wGM9J3TYP2UJL9HeFuhODN7JAOAeCGHu3NTZdwQc6bxtYEs4cfux59pl
         MuErPNiXIugw9UJdSeki4zwaJIHW1zydNpODrtBUs1LJEE1DMO9FYL5hYeYhrF0FGAZW
         tjdOwuC7UebFXLcSNtR3w9TRf56Do5tUtQMPI0GnRbiPaEjxlHcVmYtdvS0PPPZplecC
         G4uo9YNtcsY3SoZVqbkoQco/CSNT8SQ3deggx/GEXpe20L+YT5/TyM+e6wKYTYuo+c65
         f+hw==
X-Forwarded-Encrypted: i=1; AJvYcCVXa2XK2H8ivGnpxjxhUYaYJCNB2o3XuiPVdABuWtiUkL57z2ItqaErXAf4Oa/Qfia6weltWn+QGZal+Sho6i2cHDPLGqa9kNUni9sK
X-Gm-Message-State: AOJu0YxA1ZNNCFUhJAlW7/nwKHOLL3+/bTVLQT9EIFzYW5xGsyhmnlh2
	whymSMKca0HvZOM86qdkaJcJ8054C78p6+km+WS0Vo0XYh96ctwpyhQk0pVB5NY=
X-Google-Smtp-Source: AGHT+IH4oiswGEj49f2wWDyVtL3HMN3AVR4jZcyvrpnyiJp+ismyJGeVgL2Opz5yeSH2QEe/aSfmeQ==
X-Received: by 2002:a05:651c:1068:b0:2d6:93fa:ce20 with SMTP id y8-20020a05651c106800b002d693face20mr1646812ljm.0.1710976136987;
        Wed, 20 Mar 2024 16:08:56 -0700 (PDT)
Received: from [192.168.1.102] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id e7-20020a05651c038700b002d4aa0bcf15sm1181328ljp.71.2024.03.20.16.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 16:08:55 -0700 (PDT)
Message-ID: <65c8614e-d54a-42bb-923c-1c2bfc1d3bc1@linaro.org>
Date: Thu, 21 Mar 2024 01:08:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arch: arm64: dts: sm8650-hdk: add support for the
 Display Card overlay
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240318-topic-sm8650-upstream-hdk-v2-0-b63a5d45a784@linaro.org>
 <20240318-topic-sm8650-upstream-hdk-v2-3-b63a5d45a784@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240318-topic-sm8650-upstream-hdk-v2-3-b63a5d45a784@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Neil,

On 3/18/24 11:51, Neil Armstrong wrote:
> With the SM8650-HDK, a Display Card kit can be connected to provide
> a VTDR6130 display with Goodix Berlin Touch controller.
> 
> In order to route the DSI lanes to the connector for the Display
> Card kit, a switch must be changed on the board.
> 
> The HDMI nodes are disabled since the DSI lanes are shared with
> the DSI to HDMI transceiver.
> 
> Add support for this card as an overlay and apply it it at
> build-time to the sm8650-hdk dtb.
> 
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Now I've successfully tested the change on v6.8 with commit 0581bcc48048
("drm/panel: visionox-vtdr6130: Set prepare_prev_first flag") applied.

Please feel free to add my tag:

Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

