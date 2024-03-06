Return-Path: <linux-kernel+bounces-93667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD987330E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5526BB260A3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE7D5D903;
	Wed,  6 Mar 2024 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="bXPN6EEK"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD315DF17
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718616; cv=none; b=OAxlHNp2+SXopDNI3zgAMxl0SX27kmA2KpsyksTDUxGgh3H08sfz76dOdEs4xkfsyNZ7da68GOEQBgXO/w+uzZ/hjV2NefbJszTabs+wRMap8V7sardWfXK3UyXT4DHjGyVdI/R9OlqiB8yFoJPRjSdtBzgnd8+kxe/4ub4KfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718616; c=relaxed/simple;
	bh=5wTDv8Pow3ls0hAeMHjkJghWq0FXCqANDCJJgNSwvho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceANhjdDOjCdFAmlHkLewrXLlO88TEk28DGKWqlJo3yaV7dv0VKXJGk+sBvV9IxtVFrXhChJywiCxjNxddFIwVPsHhnnAgqwgTbgUbaWTLp5v5yPpFPeFHi4pOJFGifK68OLPdFX9MlaF9vw7x/gzvNQ7lLlKh/2769URlipoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=bXPN6EEK; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-299a2456948so524607a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 01:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1709718614; x=1710323414; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5wTDv8Pow3ls0hAeMHjkJghWq0FXCqANDCJJgNSwvho=;
        b=bXPN6EEK8ROtqPXnYOisP9OZv3wXjLA9VoezLbW3CpaUU1dDVxypTELbSobzh3ISeO
         xeeF+K748SPIMCXb59dhOMK8AOcrwAYrBhvPq0myPnega+hV0+Ig/sQcg8N030py06sk
         uE049MOvk3W3SPtXR4IO/0+Hj631mWd8R1z3r/9ZfaUaNRgiXWbf+jjzAi09jCuQSX9k
         4fIyoX1knONzgrM09k7oeU+5dvnWApdAWQjeiDOfqEOPsM2ZwZXs4XiEcPdbj0TeJn+i
         fGZguCMDj+GG181gxMU3Sznje5Qmiz/t4XbK975eZUMhtA8ATFIqV/rRnjsGnaLNvqPQ
         db2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709718614; x=1710323414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wTDv8Pow3ls0hAeMHjkJghWq0FXCqANDCJJgNSwvho=;
        b=dWO4ZvOGu64Vo8WxggWqh9wYEuiE5BU3KJ5u3TFpJCeQJWbm/HcusG5FrkXKzmTprP
         NTjeiuRlu30qvMVFLcjuwMF/6PpMcSY3lbGL41PCMMDKHFJ5zoHs7ugbndvcxM7pTCqn
         y8lWmjoDYvOeZHZSMD0Gz8nYHlI9qL39p/34sFCAi/zqsAB4mMms5T5Q3wyclJJAXXuR
         blDlDcT7tQNae9MVmW5vH4XASlViI1FFR4R5eA4igbLJqJe4lgMcGCenhbzMBDkVnV0i
         SMYbdViMTxkbSeeTnpPBYbPek0QhNiUPsNoPVFdQ//c7xHfJzeunoaClBi0kD+LIiudx
         qJ8w==
X-Forwarded-Encrypted: i=1; AJvYcCU9NFfFqnw9SgbNJZGnMA1PJ5NEOFVbD3k9LO1RB6yCMArKgiDl28XfbTKAz6lC4NfS8FT8FqGZQyZ5CmArTD8ziedBFGP0A4DOWX2m
X-Gm-Message-State: AOJu0Yw/C1ubQZev0OWDg9dhgWrXxiCbS4V0SOihjH+YiRJgFFB+ENGa
	Y/SVqtVHvv0fcikYAX2NXc/+2to/u39Uk6YmnEtl7pCuwFaeTTbBnCC0cvRJ+1Sg/6jYWjwfmm3
	KMCTLoq371BHhJI725RxaYQFDIkZcpOcPo7FS0Q==
X-Google-Smtp-Source: AGHT+IEe5ARYEUNZCsr+iHrFPzLLIKN3FTqKMUPA5r/pRjcydibLKmQbYN0Ni7yeDM2vxSQwE6cGRdoCFy2gruuS/H0=
X-Received: by 2002:a17:90a:f490:b0:29a:6b5c:33ba with SMTP id
 bx16-20020a17090af49000b0029a6b5c33bamr12644943pjb.5.1709718614426; Wed, 06
 Mar 2024 01:50:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305210747.1377506-1-naresh.solanki@9elements.com> <a32a2655-7561-4339-8521-bc2558e0bdb1@linaro.org>
In-Reply-To: <a32a2655-7561-4339-8521-bc2558e0bdb1@linaro.org>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Wed, 6 Mar 2024 15:20:02 +0530
Message-ID: <CABqG17hYK8MFMPVNXxZ6JT4TW00PPt48q1qZBzS=gJrpC--iTg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: hwmon: tda38640: Add interrupt &
 regulator properties
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	mazziesaccount@gmail.com, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,


On Wed, 6 Mar 2024 at 12:44, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/03/2024 22:07, Naresh Solanki wrote:
> > Add properties for interrupt & regulator.
> > Also update example.
>
> Nothing improved.
Yes, Just aligned the regulator node name in this revision.
I missed aligning the commit message.

I'll fix in next revision & update commit message as:

tda38640 has a single regulator output along with
CAT_FAULT# pin to report internal events.
Hence add properties for regulator & interrupt.

Let me know if any others changes needed.

Regards,
Naresh

>
> Broken record. You got the same comment 3rd or 4th time!
>
> NAK
>
> Best regards,
> Krzysztof
>

