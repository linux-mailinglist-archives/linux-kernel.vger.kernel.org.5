Return-Path: <linux-kernel+bounces-110473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5CA885F69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8FDB23355
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96E012B70;
	Thu, 21 Mar 2024 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iR0wpvSc"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9767D10782
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041312; cv=none; b=ghPTzzQqc/eMcRVTDCT4bP20G/gObxB4qzVaR8KMcTvudOrvn1uydCBpdTBZNsXvRvtTWc9ixuATMq0H/uLzUoUZjQnNJyRUNlrB7dfmuoP1UqgthmQytiXJI39UJmVWvBBrL3I6rqQuI8yLI+B/zwkI6qFQ26nq1HoCtsegsq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041312; c=relaxed/simple;
	bh=gGJ6SSH45M/+lXjkn47OeYs+ZagjzyoJYc2SbRaiP7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KX+sk1qpIKXhVzrcMvjBCbjdjgoWSvy6I1p7Sh+2m3isuIkXLhEYSgl4bHH3qIarZLLzYHS2klObl8Mdt9TN0sGjQp2a27yyBB4a/HFYjLtvmYjYv48c0M9qa11+uDRVQBv1julLKC5fOwd6OsPhLLkDaYMe9IHafGDpUxebyHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iR0wpvSc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4146f2bd5f1so10045475e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711041309; x=1711646109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOzZRaCrogblPXzpee5oY8K/vqc1yaczKqRuDk/vDlg=;
        b=iR0wpvScy5oaNcck0Gsp0ifmLPff2flfS9UhsTPbYGxMRyAB08/Ps3RfcBdn2wr12j
         ce5jSB3iFxxVMF8HLj+8/uilW3mAG24Vfida2RP73BgXZobVEUNbdPL769p7YZfc7VKy
         +8mwLHxnQD2FQrXofcOEQuDtEm/6RokrdB3swqzwBXRdo2QHEg4+zdyr5s2RQ1rLpBsV
         TDtNpScKHpil5SEKokWeV/ny/6qIyc4E0ml5YnBQbjnLDY/DVBMhHetl3FfUSQYtXMlu
         +mYaYUMQQEkB+7f+fVqLFbCTSujNyqIdubJW0rK45aKnVNHTjuYxNwROUNCVYWUszrNT
         BnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711041309; x=1711646109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOzZRaCrogblPXzpee5oY8K/vqc1yaczKqRuDk/vDlg=;
        b=ZS9dCV9NIHKClxGT1Hr/xnkMI/qmWBMclkvPO8WX+KOAOWnKGTBuZ3qsILpQzbBCko
         7XWsVjOW0QRAl0n0rCFzh94hMTKAh2TR3ltbXENmIVXd25MuNswR18ik3w6T6A+UM/80
         7COZ52SFwGiXqRs80EbFELCZJuXogC4msM474cEQHTuXOpO9m01CSGZJvVRpSogfKEZx
         bCqH/QJVBWNqM6Zf3CsYgeVNB5+rPFC88+JRSm0DQeppVRryzPf9g3V45fbN1uO2w4wG
         Mu1Gh3ndrqxf3Yebw1C38bqdhizBzKqMNSqqfNI1wiNkc5///f4YfWrMf+ujPmVy2tIe
         G4cw==
X-Forwarded-Encrypted: i=1; AJvYcCW9GCmI9p2nd8EfcFhro5SbVyGRoyVyc/f1FeQjeieHDEcnY5trhL5DchDVFkYRS72VLqvz2HImfaSQSgp890+qE9FKwEtMIDA0q0CL
X-Gm-Message-State: AOJu0YybU48deXenoNAu65vNROmZD+qKt9fS8HAGImzRGsxWTZuODycs
	dMlyoGhjC6rJSIafY5PqWFo+QsqeroBBqtVYjYXH2knmMjP/bw3f925B3Y+eMI5SenoKSlzD70I
	R
X-Google-Smtp-Source: AGHT+IElyRwKHADPA9aPBUDUYiKpD9hPEagD4HeSrIP8KMCXPccRXC9Qdu16YeLScyCjXhf+jHE/Nw==
X-Received: by 2002:a05:600c:470d:b0:413:ef8e:4cc with SMTP id v13-20020a05600c470d00b00413ef8e04ccmr4299331wmo.40.1711041309014;
        Thu, 21 Mar 2024 10:15:09 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v9-20020a05600c470900b0041409db0349sm333276wmo.48.2024.03.21.10.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 10:15:08 -0700 (PDT)
Message-ID: <5a788d57-4857-423d-a501-41a94488e9bb@linaro.org>
Date: Thu, 21 Mar 2024 18:15:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: armada: simplify name sanitization
Content-Language: en-US
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240320104940.65031-1-linux@rasmusvillemoes.dk>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240320104940.65031-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/03/2024 11:49, Rasmus Villemoes wrote:
> Simplify the code by using the helper we have for doing exactly this.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


