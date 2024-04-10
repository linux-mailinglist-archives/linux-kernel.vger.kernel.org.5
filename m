Return-Path: <linux-kernel+bounces-139174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D7E89FF81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5584D1F227DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC031802A8;
	Wed, 10 Apr 2024 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yhXYTfDj"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7470317F365
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772862; cv=none; b=ZQsF7uU2SEHGTxp46X32GzxIpUPuAttUxXr/63xTqNlg7A57LLrBXrUMsQnO0X/1oghyOL41OGeSzPRyHAjoB9YfSLXBjlPdOTma73CvgxWyfSic4H1/eSb0cBC8k0dmqoo9Yk4lkRKzbKlTyKNehB7jVmdboduyAMc+mnyDccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772862; c=relaxed/simple;
	bh=Gy/xIIAV1IMY4gqYPnEYGC4AI4zv1opJbJknGzalJ+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufvgP6OUNeQ8XwOnU3++K7K95jCqEmWuqo8ZjrSbkrGilxSxKYmYJ168qZbufedYJ8xCCVMK515YFsfwK3lxDXysxfmRUBfXljIhMkWo98SxjeTYw5/HaOKlZFkJ5DyC1W/CRWi8uUSpLNcK6kDODjpSnG5KFo1/uyT3JjaFaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yhXYTfDj; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516dc51bb72so5653112e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712772858; x=1713377658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0xVS150YzL1/Xjxdbgyf+gnR1gySWkGWU4rQOhTUgs=;
        b=yhXYTfDjBJJGIYqYuMew6SxU49DvSPIgyAiz4S24PbRkKJavtNZVd5Vy8VM0UdCtuw
         MnZ/m3J1fOy9hLD1BsTjeyQOiQJafAnZYmrKWcn4xyedxwtUKspy0v2x+Px//VOBkyUu
         0PmidtRI/TORJQM4zK6GYmCdYz+nd3g24Sj95H/GxYeaMdJe8GHHf4gOTQj43FIiSjgp
         GOBEWEOFTl+uxqfl2W7YbqbJmTe37YTW02cWaTw3vQgdw4NiPNMXrzRFe2Ci+CRb3sOn
         9s05dvk0BwrfoCl0Rk4/t2i0LS5RElPbmqQhJjHBrRXdqy4++fL9g67SA5qKFnCmOGkC
         o4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712772858; x=1713377658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0xVS150YzL1/Xjxdbgyf+gnR1gySWkGWU4rQOhTUgs=;
        b=ET/3mQgsj2t12EOWzIpreDUde+AppwTb9eQn4yXZEZtbvFnWqm7tN7xlUQkCbWwhuN
         Pib+Eu0eyMxFF49BvuZivdbfbgRI3WjdLE/Nc/dQZZ+jmUO67eBdqo4M1Qgr37l+re3d
         bdS/ieDUpfPys4d9jEAiBKxjdSDetX/mQSYwnq2AKqUBq7BW/WIC1Q9orCluH6xfqWEX
         PWrn5D19UXOU40t7oQjN0imaGn0LooaRzUXk1nx9P9LCFARtLh6IIW/wBDKAbQjOMDlh
         09o+LTRM+qie1vON62YcWA53tlyTwNLlwHjUJaqQOhb9xapDeVIKqZekcRerccApcH04
         u8RA==
X-Forwarded-Encrypted: i=1; AJvYcCU90sYI/HpKOLZostsUormFejD/uQRK1y8py7hVMOP+POVICd+pJoZnGPNGHEMFNg/wCIy/yHSAe/aVhisDCRjqKj4Je6FH4V7TZ8wZ
X-Gm-Message-State: AOJu0YyRlKcFt3/d+DwzH+O490bykoG4h0cvk4su14xNKrKvzFE/kux9
	njfpnuewo2ZfRkJLs3dhNwKShV5+/hjJ67Zk1hVdRNZdy8FGelwC9oA6PYnFOZ8NJPJKhz+iFwJ
	lZaM=
X-Google-Smtp-Source: AGHT+IHJvdEctTXsMhmqjLzywAkmj1+HPln2kt1QjwJmq8JoSF9B969r0JTZpPS+58OEikc1Y2wPLQ==
X-Received: by 2002:ac2:59ce:0:b0:517:5fba:fb54 with SMTP id x14-20020ac259ce000000b005175fbafb54mr1995958lfn.3.1712772858487;
        Wed, 10 Apr 2024 11:14:18 -0700 (PDT)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d5-20020ac25ec5000000b00516d4c31ef4sm1874863lfq.248.2024.04.10.11.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 11:14:18 -0700 (PDT)
Message-ID: <92333536-7f43-4fa9-8d52-ae2ac50b76f6@linaro.org>
Date: Wed, 10 Apr 2024 20:14:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] leds: qcom-lpg: Add support for PMI8950 PWM
To: Gianluca Boiano <morf3089@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20240402-pmi8950-pwm-support-v1-0-1a66899eeeb3@gmail.com>
 <20240402-pmi8950-pwm-support-v1-1-1a66899eeeb3@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240402-pmi8950-pwm-support-v1-1-1a66899eeeb3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/2/24 14:35, Gianluca Boiano wrote:
> The PMI8950 PMIC contains 1 PWM channel
> 
> Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Oddly enough, there's also 1 LPG channel on the PM(not I)8950 @ 0xbc00

Konrad

