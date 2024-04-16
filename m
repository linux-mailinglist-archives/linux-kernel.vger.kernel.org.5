Return-Path: <linux-kernel+bounces-147032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6FC8A6E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB3D1F2347F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ED712CD8C;
	Tue, 16 Apr 2024 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aj1AmpYE"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764B12D75D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278097; cv=none; b=bCNkTI3uhL8B1sjUIcSvD/vpo7c/2o9S9AaunPB2uycaiRSpoAVnoN31fdH12DRT2FSUWmV+4G6M+AmNx1tIuqjlJYB9Zx9iSjEe0ti0KzBYXIIM4EyrTc5pWR4pLtfLM1IMCAxRj95ZZQUzgk2bXyJtqZHKcuITPVmfRAe3xiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278097; c=relaxed/simple;
	bh=9gWEqpeQ44KAT26aG8dQwX9JQ/Rx+NiPE+QCZt7ZX80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnCsA412xrTRr+IK9Z6nd92zOdpuDqOA9xPtcvot6vpf22F7YhwRQT/NS3lFSqJ2lq7J8xMfE3rIdtbtX6e+dsTxsdzS/iwRxAjZ11pasoQL4JIJDc60DnLRupxJX9secx6Ppfq9IYRibo2rjTXTNnFoeulMgLAgw65Tho+swj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Aj1AmpYE; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d094bc2244so51810261fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713278093; x=1713882893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UsftWv75jPp8q+uPwfqAdrYpSmyrP3n9PngY1U3XH1s=;
        b=Aj1AmpYErLKiIiVuMej+Ahfwd0EQnGloXGdLTPx9s5aDFZnL6zPuVXuf5gqG/U30yZ
         InctDQSJCGLYsOiimH0jtJfFNvxrR8EtVT8TvVh7OV9572RFoK6LHUXKYsknRNaUKEeP
         7lqFSit+aBIC7qfQTgpCoYiDQDkBF0WOk6A/gpJ+d8mKn94l5/5eR3Ydvq0WFUyTKcLn
         NogyJZ3FMl7tGIEemvzUHi75qEWIb3yQjAB13P1mmUDyq4UytjL3RNBzvGjXk5Svpa5R
         r/mzF1f3XqY4jqWTsMnCF+gFPCmgKrPSqT0Ob1krIxWkxWdkF9Mii4NWwylFyrEIXC1A
         mpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713278093; x=1713882893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsftWv75jPp8q+uPwfqAdrYpSmyrP3n9PngY1U3XH1s=;
        b=wQIOuMImHADNUW2+ZEk+DVsBa2mdK4UC+mqREziYo4AMnI7bOoohBZyG3QZaUpn5p7
         1Tq0Tv8RAuV9yGsUhbFQ/SDmcfTFLPcfx6ffUCIVpc+5h7sJjd4lgtggoOVi31B6UOY6
         +eDOM3UQOjxRR1BTjqNtEB4YW7ixrnJ4NemSleHe513rhoEhUDH6J6VTjg5q1aFULqzR
         +AJkUhHHVngAQF7AEByZY9hgvMOtKUIDMs2+cGp0Pv/2zid3fJR81O+7YA8aGeRAfI+R
         YlDjbWGsey9cL2u8XLVHdsW5sqWu/2gxGKoQ/SQ9lpsoQc+9GECtXs4MEyjLh+n2zh//
         mtQA==
X-Forwarded-Encrypted: i=1; AJvYcCUJoAnTscouiw7vwTl+Fvgb4IiGiJC+0wJkF7v6o32dboVCXWNLpmJ1DxsGa138B4on1f7akY1Z35DGhlufHjZhqGH54hUXdeN2V0bw
X-Gm-Message-State: AOJu0Yw/dkxtwr/z5Qejrb5raslt4bCQ6W31jMuvuS9hJNzAR4EobF+J
	2Ztiee7EnI76VJ8FNZqspZIWoyXdwzwycLkoSEtpxbKE+BQ/4iUwD7FWI3+FeCA=
X-Google-Smtp-Source: AGHT+IFchFdCnQlrtXB4f/SFQaCb1JAvuZa4jE2HDMoyWfZXlpIWyk3eg9eZ4xr4mPAhjC7hOBDeTA==
X-Received: by 2002:a2e:9b49:0:b0:2d8:df61:9c6c with SMTP id o9-20020a2e9b49000000b002d8df619c6cmr8444196ljj.20.1713278093557;
        Tue, 16 Apr 2024 07:34:53 -0700 (PDT)
Received: from [172.30.205.49] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u12-20020a2e2e0c000000b002d9f87402e3sm1426372lju.51.2024.04.16.07.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 07:34:53 -0700 (PDT)
Message-ID: <b26d5942-6085-445a-bf17-068f1fbcfe71@linaro.org>
Date: Tue, 16 Apr 2024 16:34:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] usb: typec: ucsi: glink: use le32 for message data
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
 <20240416-ucsi-glink-altmode-v1-4-890db00877ac@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240416-ucsi-glink-altmode-v1-4-890db00877ac@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/16/24 04:20, Dmitry Baryshkov wrote:
> The message structures as transferred by the PMIC_GLINK use le32 for
> data encoding. Correct struct accessors to follow the lead of the main
> pmic_glink.c driver.
> 
> Fixes: 62b5412b1f4a ("usb: typec: ucsi: add PMIC Glink UCSI driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

There are a couple of if (resp->ret_code) occurences, but zero is zero
no matter the bit order, so that works out

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

