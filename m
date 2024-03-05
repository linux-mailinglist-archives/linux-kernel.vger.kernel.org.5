Return-Path: <linux-kernel+bounces-92993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8441687292F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA12DB2A649
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36DA12B17E;
	Tue,  5 Mar 2024 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zV7ArLKA"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7661B809
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672963; cv=none; b=CTS789+9r6dKqJdMZvu/lF7Qp7YA1pBIB0/0JwVW7lsuzGpNa8XdjAnq/SRVIsI8oNu0/ffHAG7X0WOmnXRJJkCkyJRdZ5l3n1kFxO91+9a8p2XHd/GUvQCwYBso1wF3W+ByrLlH9D/TPpFIpJrBg7mAQ+0QwF5K9VZLR5Y84HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672963; c=relaxed/simple;
	bh=jJZTR3ZQLE6TxtB1On0qTLLClIpP1eKZkTdZYogVliU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SNTJHwvfcCWZqVKxiGxEvSKDXW4RW5SKAqHx1RV9u0QV65hN6a1NTKwqyYLqACNGU3M04/ZyLjRIMUhKNvNokuGGynKh58WBoGyy4nwV8WdKVRW4ZQ+epbrkhDPcP05K4obrKq2vZLG2UZ/Li3FW4aMaTYmPJb00x/Rw9ZHhWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zV7ArLKA; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5133d276cbaso5272471e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 13:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709672960; x=1710277760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJZTR3ZQLE6TxtB1On0qTLLClIpP1eKZkTdZYogVliU=;
        b=zV7ArLKAoCh5MB0KLgHepIpJFsdn8mIHnoOQ40I7AzejVd4ym49pD9XQ7Fc3mHqGOS
         +1wzK+OqvCGQiioY4RvV9Je5IZkKD2dxV6F+8RPKrE/PiEX4fad5OZ/OBAaL0KW6e/Ob
         o5xXo4lRrdNc5vEvXYK/242jcqiM3A3C6pK/mItwibqcy/L1OcCgtLU/pBUKiXKLGxdB
         KMqoE7Mwo+Gl2mvKuVz1J2no/McpmM+Y70BvqBtJnjfOKgFCOSJaQfybA7XbZyT8PdFD
         /xy0/3/6C9H7NzVReln8j//BTeNXjfp32pXRsetvZ+9Sfz+9AN/SWfLwvTJqe8yeTi0a
         3Kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709672960; x=1710277760;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJZTR3ZQLE6TxtB1On0qTLLClIpP1eKZkTdZYogVliU=;
        b=UjtzE7WOjD14CetGAYabrD26tjfUjUWJhPaYdTt6VeuVey09tvqrI1zGd15Cr/5ULJ
         UVhTXl1mSzuEt+hTRy4tN8ngKsCrbfPfB+NrPcN2y7BDRvWUPMDmS7ApqxiWyQojVA5b
         pu8f1XcZ7NXCjBZZBQA5Ra7KDWdrs0dsXDrAl00I8sY6uf9Vdp1db7VKtMv9sMDLX5Ha
         kn8ffIAmk0fp3DYhuFyLPMjrynV6T4DGDRuD44CtkMfvofunj0h5Mz0oI39/xlpBbbdI
         DHZyG6yCLFww4bmwiwC2yU6D7jcg2e0WSf6aSSk4jyOx9ZDnBZMtKjMK94am4oHfy6fZ
         xuBg==
X-Forwarded-Encrypted: i=1; AJvYcCWMAJZJ/nHcdq13fbltoHahj9gb3CkihBqUwrgqTuxJUloaARD27e9l01vE3dJ7eKxvRKSp+S9/x/uXbQH2HflnIADD2Jx07KMlSaLJ
X-Gm-Message-State: AOJu0YyGdOTFpZLXdkoI2oSW1jmO1ltcBC3FErHOa8kS/uCBej8q6xyx
	XW+lKjvFAx3G7qkeWp94Su+QneqD7CQDQJsWdiq9BsLyxgIlFA4C57LlElN+1VU=
X-Google-Smtp-Source: AGHT+IE8CGigUxA1HCYfZiHbYBgeAldb7dQWGONv4ACnT65GTfW31N+bM8GawaFuCe4uzmmOQ4YDwg==
X-Received: by 2002:a19:f803:0:b0:513:3fa4:3f22 with SMTP id a3-20020a19f803000000b005133fa43f22mr2145235lff.35.1709672959846;
        Tue, 05 Mar 2024 13:09:19 -0800 (PST)
Received: from [172.30.204.154] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id g13-20020ac24d8d000000b0051316ccc5besm2300433lfe.269.2024.03.05.13.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 13:09:19 -0800 (PST)
Message-ID: <1697b03c-56ab-4e8b-a268-f9ceeed91c31@linaro.org>
Date: Tue, 5 Mar 2024 22:09:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Enable firmware-managed USB resources on Qcom targets
Content-Language: en-US
To: Sriram Dash <quic_sriramd@quicinc.com>, andersson@kernel.org,
 vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 gregkh@linuxfoundation.org, quic_wcheng@quicinc.com,
 Thinh.Nguyen@synopsys.com, p.zabel@pengutronix.de,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, quic_psodagud@quicinc.com,
 quic_nkela@quicinc.com, manivannan.sadhasivam@linaro.org,
 ulf.hansson@linaro.org, sudeep.holla@arm.com, quic_shazhuss@quicinc.com
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/5/24 17:57, Sriram Dash wrote:
> Some target systems allow multiple resources to be managed by firmware.
> On these targets, tasks related to clocks, regulators, resets, and
> interconnects can be delegated to the firmware, while the remaining
> responsibilities are handled by Linux.

Aside from the comments you already got from others, please change
[RFC m/n] to [PATCH RFC m/n] so that your series isn't filtered out
out maintainers' inboxes due to the missing PATCH keyword..

Konrad

