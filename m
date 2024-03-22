Return-Path: <linux-kernel+bounces-112018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D388743B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466901C21A52
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715657FBB1;
	Fri, 22 Mar 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGtQv85Y"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9B69D0A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711140248; cv=none; b=TSjbTcpQbxpgVFoenxLSF2zFaXgApCDY1LcKz9N8sSkDniVyXfS8S3O5tmk6R5fbCBxgRHCKAAtfbVAoTw4FE2PyQQTpKHG/ya0DkY+YgQbd/V3E9NhI4GwCVM2/fwrulgOgafTvLbDRJI1pDpSRV4VCR21czFfOOceS1//CyhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711140248; c=relaxed/simple;
	bh=cdtFl6iLAHk1Vr+6jkOspmAMmf94CBqvn+kJl1AgPRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxOS3BaHokTE3LlpESz/h0F1pw7PqvZl1xVR6adOd9rsMQF+ziL/XPqjmb4eprvZWprDgxetmP46yLXYprviFvzb4n8Gz5ujxFa3+ILKxqcFTR5qxku/1R7j/aP32vSXLg0/sujobkgkP3sqYtzVAMfaoaJsLb5bB7u7slRY0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dGtQv85Y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e17342ea7so1206853f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711140245; x=1711745045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjlcpy9oH2RphOesJNzXB8pL3ummy1CxCHShx47lx50=;
        b=dGtQv85Y4vstzxhT1ylF0vEmVzPyKPoJf6QKysD/EfAsYSFhX1Qxj7/rJs/CSR2P07
         dQo1t4td7i3CO7o7iBluqZG6pcHK/avGu9iEJeKF39XtEOlXJZgoQh/M6MEKp1baPOUp
         +7za5E0NO9JZCyv8GB03hSM3RfgqJGAe0qs/x87FHXLeAKDPD6NUENxULLSv48zHtiRO
         oCpgnkeJY9FYjujldUkf7HadFcxTkyrjilReV6WzbF9EVrmGmsQylc7Hv9Y54toAI35q
         fpLruE+EGVdOtip4yTGddOhZtdpZdKmmdCBGJ6QvdRTfMTUcH7KIcvLXiQo+LmHLLi5y
         kBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711140245; x=1711745045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjlcpy9oH2RphOesJNzXB8pL3ummy1CxCHShx47lx50=;
        b=Uf0HQ02WE68YllmvAztkc8/ZoHJ7yfDIQkt4JQCzctraYkeibtgVSzx3Mq8uYD52oB
         hxTTrdtmNcgQZRZqKwJqTVXJevbyG7jECgtNVw6W2+FKI7MH4ROrVtL2b2qz5WYq9Ae7
         ZZ6b6WlqPCakfIKauWYlzHEAYTmzUjXiQM3yWvqBRxCSPEIfXzcV2VVQh4DVK2Yn7Syw
         CVG8278R5bx9ypTw1qaLwngZE4kpYNWh27QZHcSPLa0HHT85kIL/sWBvQcbb5KiwDUmF
         O1INrGDJRlUVkMPqLTA2/G1ObMsVSKjS+SDICl3XYKnai8cmJFL5RT2MiGiGLFntgHJs
         nzBg==
X-Forwarded-Encrypted: i=1; AJvYcCX0ty5D7I1BbpL1QbLSj7mzXp9QOO5GbUFAFVoUW7rwYYgp9+CJz0Zyb9mrFruAVEmRvSe/kXUYXGmit041hl0z8r35YMiQvQd7CH5t
X-Gm-Message-State: AOJu0Yx2BXqezUreykvoQYSH4uBdlhL7ut5lHVFO1AIvhjhdPiTMFOws
	9Ak7eIPxba41jO/aXTDQYs6Fz7SETrkDG+Fbm4fWPbwrkFnJeDaBu/pKy32tess=
X-Google-Smtp-Source: AGHT+IFSBv8mmfWNJQGZ+o4H7aPA+E9nwD0XtouiZeMdGlUjzuXBbSISqCQZgJ3dZHa+ntlt1/m/Vg==
X-Received: by 2002:a5d:4002:0:b0:33e:1c40:4f18 with SMTP id n2-20020a5d4002000000b0033e1c404f18mr358630wrp.4.1711140245049;
        Fri, 22 Mar 2024 13:44:05 -0700 (PDT)
Received: from [192.168.0.253] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id cr8-20020a05600004e800b0033e7715bafasm2837046wrb.59.2024.03.22.13.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 13:44:04 -0700 (PDT)
Message-ID: <7cd6768d-780c-4cdb-8091-c7a161eab23e@linaro.org>
Date: Fri, 22 Mar 2024 20:44:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: usb: qcom,pmic-typec: drop port
 description
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: neil.armstrong@linaro.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240322-typec-fix-example-v1-0-6b01c347419e@linaro.org>
 <20240322-typec-fix-example-v1-1-6b01c347419e@linaro.org>
 <230eab52-9751-43fd-8e47-fbfe12410e44@linaro.org>
 <CAA8EJprD3fM966pLV4QXPUu=bFTn24fvPMKOaGqtqkAbdz7sOQ@mail.gmail.com>
 <5ea4a187-1971-4970-a289-826d96c0351a@linaro.org>
 <c0f1e898-7638-4b7b-a938-9e31e5b57e57@linaro.org>
 <0b091595-1587-421d-bb00-c00ef729d143@linaro.org>
 <CAA8EJpqvwhafFoD_=GO4E93JBQA2A+xY0rG14pgPm=xgJ9Yz_Q@mail.gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAA8EJpqvwhafFoD_=GO4E93JBQA2A+xY0rG14pgPm=xgJ9Yz_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/03/2024 15:49, Dmitry Baryshkov wrote:
> It's true that we don't describe CC lines. However In most of the
> cases CC lines are handled by the Type-C port manager directly. So
> there will be a connection from usb-c-connector to the pmic-typec
> itself (which looks pretty redundant).

I think it more logical to associate the role-switch event with the CC 
lines which actually handle the messaging than the HS PHY which does not 
to be honest.

If we predicate a name change on fixing the namespace then we should fix 
the namespace instead of reuse existing for expediency.

$0.02

---
bod

