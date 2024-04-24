Return-Path: <linux-kernel+bounces-157669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F72F8B144C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1FE61C2222E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5721442EF;
	Wed, 24 Apr 2024 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9kDUEVk"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC9143C7B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989638; cv=none; b=LL3kHQ5DtU6oeA2RdaVjPFF1sPzvGQgiimOWER62/Y5wxsjT9p2tTc8cBNDZD0Y+LDRzIYlJ8ZTaSqT7v5aT2u44NuIcFS6D4n28ksuPAg8QN1wN+ov8dU+jlqYiHZ7850fvUg+BK0NI5faVYprqPU4MwX2JtqK2IGM6143QNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989638; c=relaxed/simple;
	bh=5juKDdGEYxNl2ENPjsF/4a/Y2iZb9ON1oaGj0sw8O/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3pswsSeeoPKUavZwpYU5LL98hntEK1gsnzEVfghgfF9U5pAMbqAxl2Hm0gXsDVb8PPLA5txSzF0NbNAX+MPEZkwGG8c24F5bVwl0Ls9IrV4PnMh8lVKrBsjaMyRv7khxzbNzxjJMnSZAnrUrv26et8OhqwnuQGuwB+3ZYXRZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R9kDUEVk; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51bafbe7509so270622e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713989634; x=1714594434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rcWOpWv1JwDPxWKBqvGmsKPJY5XCaFq86YjpwkCYxAM=;
        b=R9kDUEVkJAXt7js53ztZzpdcSlPkXE7YXL7Ntwgu5dQ7kWUe/PmwOycvS4nHUvtlNU
         bppMnyuHiqDb/52FLuyhLB/GGLj+gTN//NsOeV24A6gya465W+4YxtgNBx6XfpSUdtKZ
         YiL3HWyJPAxU741fhDqcnLW6+hDPttfbsMrSu0EtvepSG0YggJHR9IwDa84XPW26ZiZu
         siOq1ufnReWDB1FJKPuiAoWsUqgWf2vt4j6Jx0DsC28e5ol7ANRJ82sc3mGYB5qdpt/w
         il4sy1jJiogV0c9y0mRcitZHoCNaOy4U9G+GUzdNhGbpKVS7GyOeSSz7MG7CWcwZhpKp
         IErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713989634; x=1714594434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcWOpWv1JwDPxWKBqvGmsKPJY5XCaFq86YjpwkCYxAM=;
        b=OZMCDeRaO58WWWLZtvJhx8lJysS7it7BlOs6bAIR4GBCl/zC/GA7Z0CcqkTl9ws7eJ
         WapvIo4mf/DkzRSKf5PT1Yosu4+VJGQ1a0yJqolar9s4U3siAYY5vfppcHt/7qJCFGcB
         vnlGTrDuMjiq1wPms3fC5hhnIm3/C48cxnJC4W/lHuG4k2vF2KN10M0BxCPRerQCZgZO
         hf8UV56JXjxc4jIMqg0oUvZ9I8shV0YRr6/YlN9JLhh/B35TKjxLKYq8ysPHtmHDmuLh
         Ct7L6rMmBV947jCG6bciYtlkJ3FpD/XnG769GpHij5XrYOVaDdl0jV2uwhTAnh2h8lbz
         XNlA==
X-Forwarded-Encrypted: i=1; AJvYcCXzDJ/BB7zbobEiraifqwt55yZhywBtveqqYrLvx51QcUblJelToJ0XxjdgerYIRCz3n8GR9HvqUIu1meh1aFingtF0IA6YaW1Ms4Hy
X-Gm-Message-State: AOJu0YxuS4M/IZ4vh6VqLMvsPg2xwl1nFmXH7mS+hgnA2Ad5Z2oogFSw
	SlGrTIm/fqA1at9iA8tVxqt49MbtLTO2RUnhgfDO00t9kiNQUKzbNh+jMovrX1I=
X-Google-Smtp-Source: AGHT+IHbBMck575yTo+0QV891RtpsbHelGrtzt6MSOzg4v88bBDA7+36rpuohXNTJekQxEkxDwi1ZQ==
X-Received: by 2002:a19:e057:0:b0:518:c69b:3a04 with SMTP id g23-20020a19e057000000b00518c69b3a04mr3170938lfj.0.1713989634521;
        Wed, 24 Apr 2024 13:13:54 -0700 (PDT)
Received: from [172.30.204.223] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u15-20020a05651220cf00b0051b88cfa076sm762823lfr.237.2024.04.24.13.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 13:13:54 -0700 (PDT)
Message-ID: <71346ffc-c07f-43cc-9d0a-40c7f6406a95@linaro.org>
Date: Wed, 24 Apr 2024 22:13:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] ARM: dts: qcom: msm8974: Use mboxes properties for
 APCS
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
 <20240424-apcs-mboxes-v1-2-6556c47cb501@z3ntu.xyz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240424-apcs-mboxes-v1-2-6556c47cb501@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/24/24 18:23, Luca Weiss wrote:
> Instead of passing the syscon to the various nodes, use the mbox
> interface using the mboxes property.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

