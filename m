Return-Path: <linux-kernel+bounces-38350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9DB83BE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE1228BBDD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345091C6A1;
	Thu, 25 Jan 2024 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTRTDKBo"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B48E1C69E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176794; cv=none; b=h/CDQ4IDTd7a6GOcdYKZaYra7xBAh2yMigLYvdayKiZqo1JekdNAAu7ysqvyjut2G48qRopOtgv+ETI3DeSB92wR7qODF2ZN23VIF7ziqMkegqab1chEleBkP3O2sC+S3e7/DsjQI6TBgOe93YSXhHDrEkJh6Laji/+OFDIRScY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176794; c=relaxed/simple;
	bh=ApUQmlkxa81ceXyof4WusvA21E0Fg32BgwslQHx9PRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMrbs1T6DCmIwy8o0+I6z7DAlGn3WW/8yBD1B0G+Sfyeu+1w8TDvWMK8TGljbvdRvgeoqgScC+LCsvqgIK591u5b+V4Knc3cN55S/mRwejwuiHnvIuFB4MQDkp88suFLPHsxA3vWiW9lS/lkMiwJ1J5wihbgHP7Xq/a5/tFZVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qTRTDKBo; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-46afb6536d1so829338137.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706176791; x=1706781591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejpu0N1U5cHhvf5maKcL218cl9a8A4V67n7tDOsobsg=;
        b=qTRTDKBoYEnBJVmGeAriqheOMCFgxFbGYja3wAvgRE5HN8iuDw8iMUAZAFgk1THjY8
         v8mseMujNwe4eKVXEMjrvoQ739+R0eooTNGGKDH3FViaoFRohnqL9iUif7FG5XaiVL0k
         hun1E7xOdKoUVkHnVKBeCV9KxqYVSQTLe3jGzBRCHM5mqifbTS5YestLbj4T5nKFufYy
         gadrWmmzpvSLjC8DeI7D9ZpcLwYmSUhpY2hSjZud5wUvLDCXDby9tX5oACrifV07jyBt
         C4S8ildnTdqMAVAaMHlA/mI4HMollFf0aClTVjxgkmei6GeCIamHJz0NQGOpmORq9ihD
         spXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176791; x=1706781591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejpu0N1U5cHhvf5maKcL218cl9a8A4V67n7tDOsobsg=;
        b=FQEy3TlnQkeP765xsB3XxU12DlJzK4Xedif7C8SJi9ZINgi6+pQaIM0hxNw7IiAK7r
         GOOsxd6Hi5n70l97IThoFw3v5SKXX4C1The+a9WbYZ9TBwrzQ9lZVpGUAPTw1qLw7Zom
         RvUkvqZhC8gDx3zMS9PzGGV+jF3bBw2QWq2RA2x4cJpx4efytJODKvFakbD8d4SY7U82
         zfXiOJo1uMURKoePAReMPxIkAHrjRBC6HW/v/j5+xR8FYhWR3M5dg0nSzTGJl6u0fKCB
         M2eEzDvTPfQDre07OakyVbiJBj2WWqPXZTxSqmVnLh41q/as5DiM6q0g7mQDCFiX+lz1
         +hIA==
X-Gm-Message-State: AOJu0YzMZBJTfjMrngb1IvSHrD9BZ0hvE6ttSSaiy69+6uDlJ++4iHlf
	ia3eu2ILq2VqCpOT/csv9c/72nI3qavgdoZFVSspmhESmf414Bh/ml4os/dlGN0=
X-Google-Smtp-Source: AGHT+IGcTSAtyt5YyT/kCBTYuBr4kS+3tQLcpFk3BxLBOchKz3KQftdbjqQ7cAMcDL/VuYKBY/YQQQ==
X-Received: by 2002:a05:6102:3c96:b0:46b:1013:16d7 with SMTP id c22-20020a0561023c9600b0046b101316d7mr607038vsv.12.1706176791010;
        Thu, 25 Jan 2024 01:59:51 -0800 (PST)
Received: from [172.30.205.155] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id qm17-20020a056214569100b006879b82e6f0sm375625qvb.38.2024.01.25.01.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 01:59:50 -0800 (PST)
Message-ID: <d1cde782-c223-4400-a129-18e63a10a415@linaro.org>
Date: Thu, 25 Jan 2024 10:59:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm8550-mtp: correct WCD9385 TX port
 mapping
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240124164505.293202-1-krzysztof.kozlowski@linaro.org>
 <20240124164505.293202-2-krzysztof.kozlowski@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240124164505.293202-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/24/24 17:45, Krzysztof Kozlowski wrote:
> WCD9385 audio codec TX port mapping was copied form HDK8450, but in fact
> it is offset by one.  Correct it to fix recording via analogue
> microphones.
> 
> The change is based on QRD8550 and should be correct here as well, but
> was not tested on MTP8550.

Would this not be codec-and-not-board-specific, anyway?

> 
> Cc: <stable@vger.kernel.org>
> Fixes: a541667c86a9 ("arm64: dts: qcom: sm8550-mtp: add WCD9385 audio-codec")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

