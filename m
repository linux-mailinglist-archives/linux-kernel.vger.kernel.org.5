Return-Path: <linux-kernel+bounces-80204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F37862BD0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CCB1F219FB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D49217BB3;
	Sun, 25 Feb 2024 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcQ/8Wf9"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B012E71;
	Sun, 25 Feb 2024 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708879479; cv=none; b=k304Ds4/Ee/zy1yW3ko9jtfY71OHGdLfU7+puY0qYwnad0EN7itjgzA78od8TNxNlbH4NzqbnaLugRfXH9r/QIRUZd1BcalCVoMCjW5PC10JiYnrnsFDLZGO6a+ZN3D86xmFpezNja1rCIVXLvDz+jxFn6HNxG3xGYFpu0/VwK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708879479; c=relaxed/simple;
	bh=x2LR7m57gltzERdPSagukEx7QYq4BUtqRMwywoeDves=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzIUad2hjkU9Jd1wubDpD4kXDUl/06rY2KOaeIHvOXEeZTzX43AXQIPjtgPmg52DJD+HerUJrUGvw30abO/eZFcUdWeW+BMNgB+dOERgJ48vKSzrUj6CeSJARb3Kr6lXIavNjOBNRdSjJz2r9004YGpQMTXwLJcdEwYiPJ0dQlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcQ/8Wf9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-565b434f90aso1029434a12.3;
        Sun, 25 Feb 2024 08:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708879476; x=1709484276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x2LR7m57gltzERdPSagukEx7QYq4BUtqRMwywoeDves=;
        b=hcQ/8Wf9F/dEGOoe+pJngOr1JeMbWYHolxL4DA5MxFjekgQz1DGJakf/eFz8RdfR6J
         1mmxtFZOCHNUlaWWVL7yLAbDJs5+rvMuP5ARtElR9Bn1D6+5xoJpxmgx9eruwet3E6/y
         0xDi+FpBmhPcd13XR175aGZaVXkWY6Anj7ThH0631IefKXGaQkPSQ9reIdoheV5dONau
         A2xCd8/HGVVmlOcaAQDoalHrGUB5a3wykdH1uL6RKY8hRTQdGePlQyT+w4/hI/Xsf+2d
         SEWcImFlk50zGSfWvogGz4RdzNvPK30tRii3NkUy9YaSA5p6/WmXXvdf2zwXN3PhmkdD
         u8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708879476; x=1709484276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2LR7m57gltzERdPSagukEx7QYq4BUtqRMwywoeDves=;
        b=KUAiDNWS2QzDsRLGECHoB3DNPqaoBql0xtDKCS0f0g+2BGq1QEzN+QLjogPZ1yEmGR
         298WwfseXcI28Vlmf5acb47oXKqMWirkgDpsSAAiaBoCMitg0qFqZiJf+J7V12nc83Yh
         uk4EuFoaKnWBhxOSRQe0wpDwghcjqNEMjCFj0DCa/ip3swFvvhPilPnp9hn5ZeRqxxSd
         T74ac+0z/ZSFaY/84Scd4er37jK31GnyzzNIxpyERBfiUoTTzKzF7F0BNbdyyuH1Gzgx
         G2NZ16nQj8UfS181rQ3+EMHPoJgdkzxJKVtNfSL9T/zffAQW5zcgHfT7OWRjG/fsa9p7
         8BdA==
X-Forwarded-Encrypted: i=1; AJvYcCXf7tTXOcrEBZ6NgRvxbV1XDhVjbdnWz9khawh6RqokfIu6ZmpWLiKtdl7SdtrZ1jOLmRe0Bwjbw9KBs1u5+EWwUwizZSnHo/FvtPW0Nt8Ax2PpSXuSZVW0AWxrGlWNVR7opnTfgOfWYxnchQ==
X-Gm-Message-State: AOJu0Yzy8kDkk+BTOB7u6HRFWznO+RCcN+U4oB3XvfGvC74sbFybGeBn
	atu1SEOd3jW8QBg+WYVgmEMvhXDNVfp6LedKau7ed4Hsbt7AARza
X-Google-Smtp-Source: AGHT+IE6CDIehKL7+CVs5s2qsBHULZbUv6aeQGB26C2IM3i1REtVjhwoyj4s1QPfqrxh3062yElbtg==
X-Received: by 2002:a05:6402:340d:b0:565:7b62:9eac with SMTP id k13-20020a056402340d00b005657b629eacmr2897273edc.22.1708879476102;
        Sun, 25 Feb 2024 08:44:36 -0800 (PST)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id fd13-20020a056402388d00b00562d908daf4sm1537101edb.84.2024.02.25.08.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 08:44:35 -0800 (PST)
Message-ID: <fba360e1-6111-4208-890c-f86b671a5b7c@gmail.com>
Date: Sun, 25 Feb 2024 17:44:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom: m31: match requested regulator name with dt
 schema
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240220-phy-qcom-m31-regulator-fix-v1-1-7675b4a916b3@gmail.com>
 <ZdiGL/TryPVrbDWp@hu-varada-blr.qualcomm.com>
Content-Language: hu
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <ZdiGL/TryPVrbDWp@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024. 02. 23. 12:49 keltezéssel, Varadarajan Narayanan írta:
> On Tue, Feb 20, 2024 at 08:13:47PM +0100, Gabor Juhos wrote:
>> According to the 'qcom,ipq5332-usb-hsphy.yaml' schema, the 5V
>> supply regulator must be defined via the 'vdd-supply' property.
>> The driver however requests for the 'vdda-phy' regulator which
>> results in the following message when the driver is probed on
>> a IPQ5018 based board with a device tree matching to the schema:
>>

<snip>

> Reviewed-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Thank you for the review!

Regards,
Gabor

