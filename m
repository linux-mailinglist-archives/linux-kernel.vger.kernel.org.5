Return-Path: <linux-kernel+bounces-125369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41088924AC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72CE28502E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2731D13AA3C;
	Fri, 29 Mar 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DxqF0inF"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C4B12FB12
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742151; cv=none; b=HkJTUiZo4QSLQ18U8c4EHqpMPTySgOxFkaGQKSfTfDnTU4GNeZvqnND75HTkLKU1UI1R1H7V4eqeNVtdDiFkMDa8xcz10p7Ogsgd6gKeaCcGc9lDF0xkemb22yN1TfHDKYzARoys9NCz0leZ8Eux9k8p4vHZLC+Ox2979qUXIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742151; c=relaxed/simple;
	bh=LkAx5cpqKJA/f7RawwxSb4SGqCnIjolDiMqhEFnnFAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9Fi0S3zCSjIugHf0y1wBqks3/riEDBoGvX8RtPEJMebU9iTVmwqOArKnxu7cnk3KYY/7b8uc5hfb+C/ZgDTRoA0GqwulwwMFH3OhU5sfKIj0iNQlcQ2AnzCF3ToYpzpbtN6ugsyE9pHVDGLICGiUdjpOCgjoLX7XVFHnTfbkWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DxqF0inF; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-368539ef3dfso1905315ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711742149; x=1712346949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PschPcZk1PmI1OFMglYy1kMU6CIeKkX26n3x+fr0kKs=;
        b=DxqF0inFbwxFMkFSl/K4WTaVh4yy7eaErcEMg1bL2NDXM3A/f4Xl3XQqdvhQ1N9J/e
         z6mdMmqtZ8P3/bQp3QsA4Stv8n+SfzhzPnDusII68nir3eV7wvRvWbpSIGuvArI39OUf
         ufD5KVItRkHDMY3hY2I8I/hJmVU0mk7kWNU/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742149; x=1712346949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PschPcZk1PmI1OFMglYy1kMU6CIeKkX26n3x+fr0kKs=;
        b=c8t/0B11xnWsJRbOiM3BN2srQ+JpR/Kvf4obGr5JR5aJRmFDcazne8g3GqMHwsXeNW
         xZXRBsW3s3s3NfZv955ngOChntrD46GdWCwGhA1HRmjg/rrsUf9YWyZjKO3vtrQKRREk
         7fCAO8szrkZTezOaoSYN7LSKKxZdT8U9kfUQsnokgLFWpCR85jKr6X+atScGyOfRt7LY
         0QMcXNwoScOn/+Dtm/C6K7fAZSKVP/QfZ0m/Abm8UR//ZRudKifqB+s3Ka+hmZijsXf0
         q35bUBi/mB9ZIOvwur8Ise1eQUAM3bC3PgVm0ac+zzi4Bd/87duLEOrw3dkYpELdMlRb
         kWXg==
X-Forwarded-Encrypted: i=1; AJvYcCWIm5Vf6qFRYz36QGIAKAhmxPzGw7jlQXEp1rmhkfaysGOWEBWp2fu/65Ckm/KsncjS6JjZj9Ui0SorlPSPRQaakRJJuyxh0uoQn+jG
X-Gm-Message-State: AOJu0Yw5zLzH6FWVX/e4BmZjG0R3hrThaCdEG2uUyG8LW61I9mq67o7u
	4wYiRCv4Jvb05fT3sWWqlK2WmeeIS81vd/7l7SAOM8LHe18Dn9f5HLpjh53IGasEgFxGrQzTLs2
	c
X-Google-Smtp-Source: AGHT+IGRWxtPEMClc3GD1YuiNVAMyflNpK+NgYEs3OLFay8hBgdipqgLNnAM+SDhRKGAlp6PSPSKNw==
X-Received: by 2002:a5e:8a47:0:b0:7d0:a740:a9b8 with SMTP id o7-20020a5e8a47000000b007d0a740a9b8mr1156254iom.2.1711742148910;
        Fri, 29 Mar 2024 12:55:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id gs20-20020a0566382d9400b00476cca7d5b9sm1143917jab.166.2024.03.29.12.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 12:55:48 -0700 (PDT)
Message-ID: <1aba5312-6ff0-4497-b633-8d6edbef5c3b@linuxfoundation.org>
Date: Fri, 29 Mar 2024 13:55:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kselftest/clone3: Make test names for set_tid test
 stable
To: Mark Brown <broonie@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240325-kselftest-clone3-set-tid-v3-1-6fdd91506e53@kernel.org>
 <0cee99af-f058-47a0-9119-94cc9a37e88b@linuxfoundation.org>
 <91f2e916-2f90-4970-9448-09f821597083@linuxfoundation.org>
 <ce20762a-9ab4-49d4-adc5-e8eb5e5ac848@sirena.org.uk>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ce20762a-9ab4-49d4-adc5-e8eb5e5ac848@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/24 14:27, Mark Brown wrote:
> On Tue, Mar 26, 2024 at 02:20:08PM -0600, Shuah Khan wrote:
> 
>> I am seeing the following compile warnings. Please fix and send patch
>> on top pf linux-kselftest fixes.
> 
> Which toolchain and architecture are you using?  These compile cleanly
> for me.

This is what I have:
  
gcc version 13.2.0 (Ubuntu 13.2.0-4ubuntu3)

I am seeing warnings with this patch. No warnings without
the patch.

thanks,
-- Shuah

