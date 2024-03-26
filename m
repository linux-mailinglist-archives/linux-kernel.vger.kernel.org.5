Return-Path: <linux-kernel+bounces-118421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD14088BA80
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAF51F386AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C760E12DDBA;
	Tue, 26 Mar 2024 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiYxGeZU"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C698F66;
	Tue, 26 Mar 2024 06:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434894; cv=none; b=PfM/M8Mqu/63TPvx94SpZ6mx1nYMbeg6n/aIQ6jP9biIk112r7sv3+JX+ZzBIPRKWnAk+jOoobUljzIYyxmO7XuGZFTbD2ccZ6d7Jmig8PUIx9uOTUWA8xrhK/vXdvuS0YPeg4iN8agdQYsMYjgzqROxjfswM001P0I46R734No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434894; c=relaxed/simple;
	bh=bOy5evgU4v6yztqyxoe3sH61Bpt7cuDbwH1Lus3h1Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:In-Reply-To:
	 From:Content-Type; b=d+KBYw/m3rejUJcBgLQy39CJjkL8luK9qaqVEzYTuzXpZMasTa7KTZJzCMxKktwbqNBeT3rw4gBXnfNZ9dno7h+91al8GSWEv/f7cYYliin41jg1juVYwV+gkPag3I4YA/FWHTrDs85QCyyAO2J/N4Q58VIqDWGZu9t8Ay8ccL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiYxGeZU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6f69e850bso4545759b3a.0;
        Mon, 25 Mar 2024 23:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711434892; x=1712039692; darn=vger.kernel.org;
        h=content-transfer-encoding:from:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzdO8q/x8pJ5/At8ghTUTxm5rg91iM4qz0LztoKnHTQ=;
        b=NiYxGeZUKudBUr1Xp/0UtmLyVt3A6Din9nKst5vjyGys3FbmsSq+bKXumPTrpzCOHT
         DAl8iMGK0COoXyKGCBEvwYgyW6HfrAIrzoZEWTbeWoU1iXnUX7fsytxewRPmcs4ymtqq
         VwD5EUvX7ym3S/OJMqmYfYRb4+HVVKPycE+bOLyorCSWzC5f08PGwiPxf6i9CCUQJOnJ
         k32pVqIi0rR4m+3fsctFhzzM39cJmUfCPrxjqc6tGn2N0zp+I8Fu2rohbkYJ1nwxWiUu
         44PICJqINOWT9r/uUT7rBRv0bWmxeMJlthT6ar8LPh9t3Cf6pCCuylhTc8LQ4hx00uMj
         eMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711434892; x=1712039692;
        h=content-transfer-encoding:from:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzdO8q/x8pJ5/At8ghTUTxm5rg91iM4qz0LztoKnHTQ=;
        b=Hp4OeYv0w/2sXQa3ESQz2U6AKPJVIuimJi0EOcdzE6DrQgZUrOI+3z8d/U+TK9YNlw
         2OltVNCtaFmbfeSAQc4ppwgrdrBZX5xPVyo+urFbFO/7WCkS4PN4NB4p/PJiwXRlsEa4
         h5iIHB4RBgyNmLbHLctO6u73ZF7NEPfX64CAkSN61y9hiqSEo8+E6LaPHHNiWI/Ndw6g
         +OwpE6RDut/4pRZoJbIBmN1QB7bOTlwQJIOuNWlvdisei8xFn2c4kVTFYw+e+P+hJgI3
         ncvCO2qsCfhpfkV30RPb4zrezAf45wG3B8tEPXdRxof9yCzPrP3ecZLlRd+q6OXkSA/T
         lSuA==
X-Forwarded-Encrypted: i=1; AJvYcCXXqo/sJVwq1u5PGcp3iYWL9DsVVfxifPwwhSgAa9vLZd4zj1sdVYnfToGRh7HfJRv0X7KG+hhF8m1gEfjeJmIbWAmFEqOkDrXP2KlVOlv5wikThOOHalLc/FC32xv5XnpwxPW1fFQ2eZktsnyKJrR2+tA4m3mq14eO0gYVJ+3om+meV6aC
X-Gm-Message-State: AOJu0Yxj0FyAwZcQrwznlVO/R7PVJV2Mg1AkW5NPctl36SN9JeiUIqb9
	zuLoO6uZRmL8bwX6Cu+Go+oOiqH5DDVjH0GsInNTANzQeBt3maXZ
X-Google-Smtp-Source: AGHT+IHP7uX/0UbdnkVUeX+Ww/lhu+Gv3sYZNFk7vX47e45rNYpqsObUuYLxIzb/JAz8lk1DeTuWKA==
X-Received: by 2002:a05:6a20:914f:b0:1a3:c511:34cf with SMTP id x15-20020a056a20914f00b001a3c51134cfmr296578pzc.2.1711434891983;
        Mon, 25 Mar 2024 23:34:51 -0700 (PDT)
Received: from [10.7.27.90] ([117.239.226.201])
        by smtp.gmail.com with ESMTPSA id ka5-20020a056a00938500b006eab499fb50sm1329917pfb.128.2024.03.25.23.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 23:34:51 -0700 (PDT)
Message-ID: <00098337-39e5-4f33-8538-09c9da20022a@gmail.com>
Date: Tue, 26 Mar 2024 12:04:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dt-bindings: wm8974: Convert to dtschema
Content-Language: en-US, ar-LB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 javier.carrasco.cruz@gmail.com
References: <20240325181943.116733-1-agarwala.kartik@gmail.com>
 <02fc496c-caac-4434-8e18-229074733b1c@linaro.org>
In-Reply-To: <02fc496c-caac-4434-8e18-229074733b1c@linaro.org>
From: Kartik Agarwala <agarwala.kartik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/24 1:00 AM, Krzysztof Kozlowski wrote:
> On 25/03/2024 19:19, Kartik Agarwala wrote:
>> Convert WM8974 audio CODEC bindings from text to dtschema.
>>
>> Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>
> 
> Thank you for your patch. There are no DTS users of this binding, so
> while such conversions are useful, they have significantly smaller
> impact. In the future, please consider converting bindings from active
> platforms (arm64 defconfig, arm multi_v7). This would have significantly
> bigger impact.
> 
> See also:
> https://lore.kernel.org/all/6552bcb8-e046-4882-91da-1094fff3d239@linaro.org/

Noted, thanks for letting me know.

Regards,
Kartik Agarwala

