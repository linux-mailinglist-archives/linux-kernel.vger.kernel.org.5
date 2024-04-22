Return-Path: <linux-kernel+bounces-153303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9E48ACC37
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4481C20FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BA514A0A3;
	Mon, 22 Apr 2024 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rh3Q8AbY"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D731A146D4E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713786037; cv=none; b=Ta04bYVR0r1kYhNbEjylrzhaX2XyWN/4YIQQJ+KwZyuZqhHhttAsy1ZPIXQwjRqGGRvZHM0a66fk2V9OHOFlIhCo+PXcCF5F7XMOyiu6O0tMgB0IFLPytnnAaHp0Qgyj/HpBgb9G8Uv34lNWFHjy8seN7u+aDHbqyPWTMrAPdlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713786037; c=relaxed/simple;
	bh=S2ElplkPZSfF2L7wz1LM5GrMF4tPupfPWF9zkAeRnkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKWAMW+5H6lOsQkqLhKk1Vnb3EfEgMO7MfwL5ML5UT2qkdxBYvSwRLUyggjLE95WLD/b8gFBBZ3bh98d/1GeqbPCnErEl6vOZzIvFHQWAaZXLns/+3uDV/ScwNlO3wZuhHWCnhtjPdhBHdhSEyRMrud/hP9RhgLXfMfI4GHrbxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rh3Q8AbY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34aa836b948so364505f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 04:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713786033; x=1714390833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JyXuxvG0jo0EeYgJFE9/eMqNg1Z05zXTsUVqLHCMuBs=;
        b=rh3Q8AbY6SxcFR4Iu9v713m/F+O4M2zPgGt6qMAK+CxcKDMUmOPKodJTjM/IZk31pL
         rtdnqzuY08hbG40+7T6eKxn1YbVFrMUYwHcYoxybIL9m66x/NSy6lDFK+cRO1D1l81cx
         6/LQ/G8hGcay5xcMvu87v6EQRw6DxHmjhxB8mBQ1Tl9QXfcytLJl+OLsb8k5MDmAnqxv
         GHiRABOe0n8a0WRlUVlBUCpMv7ceWtr3kjY973jRzNQ8HIhqtNw7C36SD1PiFTbQ43On
         LM5kBs2VGLpYfSDPJwyrWSNT3QBSvrFKYPeldGoo2ugQNYw3OaxO9YfzcEFNM9HiTRz3
         EYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713786033; x=1714390833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyXuxvG0jo0EeYgJFE9/eMqNg1Z05zXTsUVqLHCMuBs=;
        b=PqX+KBtVeKip49l0NWl2WyKKT/i+aRqb05taBl2MNeQ0fLxOXpsMXwmve4CjUFPlpm
         Rh8FK2Vb7jtsb5HUX8/xjtCEQkQrfg9Ym2BVkROhF860gLzZq0UgmOiP9l8xT/hzXLs9
         DdQfgw8iXr+DneeQyikFr5IAn63AEST+b/WPq4uOiGdRU3JsGmELVZES5x+jkm3eqkZ2
         KkZNhPf9Dv0Sg+hkTB6YGL4MRqBzvdDy4thhqFiFMgblVk51l9hNfKaNNvRqzeGwSnA+
         Xa7uK+lpCp7VmrHXqhkc9nXTGjHTS95QC2bwJG9sV/je0HrWyXvs2u1Pqe3aFYCV4F6M
         C0sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD5oUzHMyqz1sBYIIK1g5umkYy209hShr3N+K9Bmnmost9hdyoGYyRLJpOm+qIIMUK+P3NMS3031ByPwSCm/n40ZZh6ycsbPHA3gzl
X-Gm-Message-State: AOJu0Yxf3ycoFSjb1fAhHtnx085bR4lXEq2go5oc90u+2QtPlusvUBg8
	Ebsz/kGnJAIiNwDAZcXfv+Pks1rYE16c3Rfh/vCkS1S20kscw6WPO2dDdPEXxTo=
X-Google-Smtp-Source: AGHT+IEBsytwGUl5ywdsyAtA0Tb7Bwan6wxkhWaIQk4aXEJurWpLAppFPSp2ncjaO6l/2n4gpEGi6w==
X-Received: by 2002:a5d:6392:0:b0:346:500f:9297 with SMTP id p18-20020a5d6392000000b00346500f9297mr6203710wru.2.1713786033161;
        Mon, 22 Apr 2024 04:40:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:9f43:3ca4:162c:d540? ([2a01:e0a:999:a3a0:9f43:3ca4:162c:d540])
        by smtp.gmail.com with ESMTPSA id w17-20020a5d6811000000b0034a2ba13588sm10715492wru.42.2024.04.22.04.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 04:40:32 -0700 (PDT)
Message-ID: <5050cd12-45fd-4228-9d9f-ba70ab21f737@rivosinc.com>
Date: Mon, 22 Apr 2024 13:40:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] dt-bindings: riscv: add Zc* extension rules
 implied by C extension
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
 Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <20240418124300.1387978-1-cleger@rivosinc.com>
 <20240418124300.1387978-4-cleger@rivosinc.com>
 <20240419-blinked-timid-da722ec6ddc4@spud>
 <f89c79f7-a09e-4fcf-8e16-0875202ade4a@rivosinc.com>
 <20240422-stumbling-aliens-b408eebe1f32@wendy>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240422-stumbling-aliens-b408eebe1f32@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/04/2024 13:19, Conor Dooley wrote:
> On Mon, Apr 22, 2024 at 10:53:04AM +0200, Clément Léger wrote:
>> On 19/04/2024 17:49, Conor Dooley wrote:
>>> On Thu, Apr 18, 2024 at 02:42:26PM +0200, Clément Léger wrote:
>>>> As stated by Zc* spec:
>>>>
>>>> "As C defines the same instructions as Zca, Zcf and Zcd, the rule is that:
>>>>  - C always implies Zca
>>>>  - C+F implies Zcf (RV32 only)
>>>>  - C+D implies Zcd"
>>>>
>>>> Add additionnal validation rules to enforce this in dts.
>>>
>>> I'll get it out of the way: NAK, and the dts patch is the perfect
>>> example of why. I don't want us to have to continually update
>>> devicetrees. If these are implied due to being subsets of other
>>> extensions, then software should be able to enable them when that
>>> other extension is present.
>>
>> Acked.
>>
>>>
>>> My fear is that, and a quick look at the "add probing" commit seemed to
>>> confirm it, new subsets would require updates to the dts, even though
>>> the existing extension is perfectly sufficient to determine presence.
>>>
>>> I definitely want to avoid continual updates to the devicetree for churn
>>> reasons whenever subsets are added, but not turning on the likes of Zca
>>> when C is present because "the bindings were updated to enforce this"
>>> is a complete blocker. I do concede that having two parents makes that
>>> more difficult and will likely require some changes to how we probe - do
>>> we need to have a "second round" type thing?
>>
>> Yeah, I understand. At first, I actually did the modifications in the
>> ISA probing loop with some dependency probing (ie loop while we don't
>> have a stable extension state). But I thought that it was not actually
>> our problem but rather the ISA string provider. For instance, Qemu
>> provides them.
> 
> 
> A newer version of QEMU might, but not all do, so I'm not sure that using
> it is a good example. My expectations is that a devicetree will be written
> to the standards of the day and not be updated as subsets are released.
> 
> If this were the first instance of a superset/bundle I'd be prepared to
> accept an argument that we should not infer anything - but it's not and
> we'd be introducing inconsistency with the crypto stuff. I know that both
> scenarios are different in terms of extension history given that this is
> splitting things into a subset and that was a superset/bundle created at
> the same time, but they're not really that different in terms of the
> DT/ACPI to user "interface".
> 
>>> Taking Zcf as an example, maybe something like making both of C and F into
>>> "standard" supersets and adding a case to riscv_isa_extension_check()
>>> that would mandate that Zca and F are enabled before enabling it, and we
>>> would ensure that C implies Zca before it implies Zcf?
>>
>> I'm afraid that riscv_isa_extension_check() will become a rat nest so
>> rather than going that way, I would be in favor of adding a validation
>> callback for the extensions if needed.
> 
> IOW, extension check split out per extension moving to be a callback?
> 
>>> Given we'd be relying on ordering, we have to perform the same implication
>>> for both F and C and make sure that the "implies" struct has Zca before Zcf.
>>> I don't really like that suggestion, hopefully there's a nicer way of doing
>>> that, but I don't like the dt stuff here.
>>
>> I guess the "cleanest" way would be to have some "defered-like"
>> mechanism in ISA probing which would allow to handle ordering as well as
>> dependencies/implies for extensions. For Zca, Zcf, we actually do not
>> have ordering problems but I think it would be a bit broken not to
>> support that as well.
> 
> We could, I suppose, enable all detected extensions on a CPU and run the
> aforemention callback, disabling them if conditions are not met?
> 
> Is that something like what you're suggesting?

Yep, exactly. First parse the ISA blindly in a bitmap, (either from
riscv,isa string, riscv,isa-extensions, or ACPI). Then in a second time,
verify the ISA extensions by validating extension and looping until we
reach a stable set.

Clément


