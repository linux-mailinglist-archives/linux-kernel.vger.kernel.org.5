Return-Path: <linux-kernel+bounces-64046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD09853959
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04C41C265B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB5960DC3;
	Tue, 13 Feb 2024 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZAhYeeK3"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E73A60BA8
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847245; cv=none; b=M1GJCzRSkN9UXdmSwXZH2oM8gSgEfvjxipR8zUHkpKNmznB/MG8rlGvwLoIpYp5EAdMYcJWL5LDh3Ym+C/Rc8GfoJpU+ogg1oGwh6IBhnutYCyUGdLFEKmaj2ImIM+WJA2YpaW8xbpQ9X176UeZklcWMPynKgYxs6MCP7UfBEu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847245; c=relaxed/simple;
	bh=Xyy8adepsdz9TsKE+m7XXPgnl+mY/oayNk2u6dSCKIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMmBaLINz1FOEASpjEDHm4SJnWJTf4p1NHc2qxjqVwPHNOSVCdeCFHaZz9qA+V5OWI/O0T0k2LzTPABJ20Z29YmbIEfn56URsBQ4EtXFY07461cE5RWE7Lx1zQT3GU5cuGjn9qkP+Kt2kOwvQUH7nh7l9dHzVRPPhqYFlfHkMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZAhYeeK3; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7872614af89so58885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707847242; x=1708452042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=atTRAR3WiDZllnXca94/PS9XVGRFpcFq4mQfGVPnvIs=;
        b=ZAhYeeK3XrZF+sA9UtyQ/Ekm/aegt88AdTQrfunNXJYHP9QI+SSgBy8nrdHOS0kgY7
         dolxuKhoBKkjWI4CzWuQCt2Liik1PvNHMVBAkqqgs7pGEHKBhNT7NT0E5JRuE5EZ9vw4
         OrDJUKIXAJ8Xx/zqeEbFxsxViyQ761DmuH0K/yRhvN5PHc2YlYxwrR4PhXCkyiLkr6D7
         NsZEGxnFSq9cOvox4CMYp9JTzc2zA5Kq6MM7+RjltvtysyC/dFTkcsdqA/KHKcNUUdlx
         oasOyEQKgsyRI1uyEWBxcinTu4sByB5BHxTG5jhdR1ZgI6+joxXwog0aianaKqKCRaH8
         XJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847242; x=1708452042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atTRAR3WiDZllnXca94/PS9XVGRFpcFq4mQfGVPnvIs=;
        b=ahfy6L7kgjq0+3SEQkJeAzbCmUumlG3y/Yq1+Ba5SMvcQPpOTkw6wV+9/lxnEjG3bt
         rLbyHvMVfyZb7v3o4WDHU4Nzx1m16mnPdZP0PVOKgvFiPYSDFFziDPgGuEHav+rTEtVm
         4SFk/kDm2qO8/fTSGupztaYlCQhpCEokzUPVEqtqkX4DnugAtbHYk8SAyrmq21eFFvqJ
         wY1KmMv2pfSPkC2LPJ+Oa2my1WCxyXICl/vIjh6QK6drUEniZkqGtJLdYCpUwrY1j9uo
         Y24rJE9fpbFBaGoLvKfgO9NNSAgHTlEEEUMBm1Mr+f+Ek6Kp/l7EfMo75oNeWV6tfvl+
         MvCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSr6TxZmmvi2YX5Vz0qEZQNUsIQdtpnYoRuqLjYjaKU72sV+weN5/Mu4wMeXyHnHgyb7xU37hiDz/vdf4002KJiwkXARssh5/11HV6
X-Gm-Message-State: AOJu0YwqC44MTWFhKtbOmNATwlMUv1F+7DQ7CAXv4wAcl0XFxXmRCoLG
	WEOwtuOaOd6Ew/MbtBy7EMezhZoL/jaV8yRBAaERpTSpbsCv7lTUrLzC3nMWujw=
X-Google-Smtp-Source: AGHT+IHjIJggQmfLYLCqtNotwhVFUSiFfAKVRQBvVL0CG8VCtYKuGX9E+ARrXv1Nsqcp//YqFjIviw==
X-Received: by 2002:a0c:db03:0:b0:68c:cd9c:2fa7 with SMTP id d3-20020a0cdb03000000b0068ccd9c2fa7mr348845qvk.5.1707847241984;
        Tue, 13 Feb 2024 10:00:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzlOhDjdNmp8wxOO2+Q3DAFt//V4xe71Ne7/dMq+bpaQ7ScJLfKHdkqMgFAk/3eERY23JJEw69hAB1gKl1E+WjY2hUfuXSCw11T/cgS+wkgqaeVkPhvVHacLlstElhHq22gOgPaMujSHbJ2r/EeBoLOJ9C3M+zZczBw1zf+VrlTP7xoziwsYfSC+P8s566p7oCw4nD/0OD0w==
Received: from [100.64.0.1] ([170.85.8.192])
        by smtp.gmail.com with ESMTPSA id mv5-20020a056214338500b0068e540c8ae9sm1214457qvb.59.2024.02.13.10.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 10:00:40 -0800 (PST)
Message-ID: <ac30412c-9eab-4014-b4f1-0844bdfeefc6@sifive.com>
Date: Tue, 13 Feb 2024 12:00:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes v2 2/4] dt-bindings: riscv: Add ratified privileged
 ISA versions
Content-Language: en-US
To: Stefan O'Rear <sorear@fastmail.com>, Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-3-samuel.holland@sifive.com>
 <20240213-limping-ether-adbdc205ebc6@spud>
 <31024f04-e3e0-4bf9-beca-ebcd4f6fe51b@app.fastmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <31024f04-e3e0-4bf9-beca-ebcd4f6fe51b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-13 11:42 AM, Stefan O'Rear wrote:
> On Tue, Feb 13, 2024, at 12:03 PM, Conor Dooley wrote:
>> On Mon, Feb 12, 2024 at 07:37:33PM -0800, Samuel Holland wrote:
>>> The baseline for the RISC-V privileged ISA is version 1.10. Using
>>> features from newer versions of the privileged ISA requires the
>>> supported version to be reported by platform firmware, either in the ISA
>>> string (where the binding already accepts version numbers) or in the
>>> riscv,isa-extensions property. So far two newer versions are ratified.
>>>
>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>>> ---
>>>
>>> Changes in v2:
>>>  - New patch for v2
>>>
>>>  .../devicetree/bindings/riscv/extensions.yaml | 20 +++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> index 63d81dc895e5..7faf22df01af 100644
>>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> @@ -121,6 +121,16 @@ properties:
>>>              version of the privileged ISA specification.
>>>  
>>>          # multi-letter extensions, sorted alphanumerically
>>
>>> +        - const: sm1p11
>>
>> Why are we beholden to this "1p11" format of RVI's? We have free choice
>> of characters here, what's stopping us using "machine-v1.11", for
>> example?
> 
> I'd prefer to use names that are at least somewhat recognizable, e.g. in
> the profiles spec, rather than making up something from whole cloth.

Right, exactly. My two immediate reasons for choosing this are:
1) this is the exact name used in the profiles[1][2], and
2) the same list of extensions is used for the riscv,isa-extensions property and
the ISA string, and this is the expected format for the ISA string.

If we want invent something brand new for the DT binding (which I'm not sure we
do), then I would recommend adding a property like riscv,privileged-isa-version,
because that removes the duplication between the Sm and Ss extensions (since
almost all implementations would have both).

On the other hand, there will likely be other extensions in the future that need
version numbers in riscv,isa-extensions. Adding a special case for the
privileged ISA doesn't help with this, whereas deciding on a syntax for version
numbers in the extension name does.

Regards,
Samuel

[1]:
https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc#rva20s64-mandatory-extensions
[2]:
https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc#rva22s64-mandatory-extensions


