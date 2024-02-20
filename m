Return-Path: <linux-kernel+bounces-73734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8579885CA2F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E86B282BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3F4152DF6;
	Tue, 20 Feb 2024 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ggk/O8Es"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2173151CF9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465511; cv=none; b=cktdpRDllVckVnM7YUkPHujnNdHesd62SJdGcENEbR1zGV4DlgBR9aDnbVtaofIaeIKTd8axamCqCmcT93h0b4a4gCTp1Fb7RKSUlWLYeXZSCG9BViReGOnZAoQOzTnstySYX0+zPhf9jLH40Ns5Ng6rEasqKaais6HncLAy3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465511; c=relaxed/simple;
	bh=UEui0s6V28sWMfEUHl6LqMaOVpgoXIEPXXvPPkx8reM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihFG8cchPYS+abogNCIqveyK4GSzuToCT2cY0Ypbtk5+aS0VBB0py4ycXULdFx7+P8nMzCl/nvnkK2YyRB/M218GgrsVWJHcyvRjg6H9z/1h1AShoEixnwOITvtp3x45F04x1g9PVJuyLTqVC5rB6z2HYfLJV7XnBoX1MzLwYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ggk/O8Es; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-363acc3bbd8so5519315ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708465509; x=1709070309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEui0s6V28sWMfEUHl6LqMaOVpgoXIEPXXvPPkx8reM=;
        b=Ggk/O8EsqmjD8rehAeUDCfHRpdpF/h9el0RD39rocyV7hof7fa7tJ7Z3gQLUiSdkZR
         MMKU9MN9niMlaZhDr0KZEjN5tsOR6az9vFLfuH7UYpNccZKFkbsWQlRLLNarWOUfD+MB
         JMelWZUbKAcUE+/qEIDmbN+oJHkDN7+uE5Xl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708465509; x=1709070309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEui0s6V28sWMfEUHl6LqMaOVpgoXIEPXXvPPkx8reM=;
        b=DRa/5V86hdnpxLrX4WP/QMBFjyAZmR/S6YJ/L90+eB+qfVgOH4NpxStDaiubXkjVR2
         lvMzYQ0Z+ZC2625w4VoNPdWDykxZ/syMebldHn4yHxQxwH4/fzmK9Fcv6GA3gsUlendq
         VJenW6DBTANno3Zyu7X0ffotFQJwHxdel7hG4kSfpy1BSiHlLnFfe/jJ6zSt/mznR7Er
         qd/yzjxkx0Ix1geyXz9ek3IsDUsFe1ZykQqMCD5fXsFRbfqbkwANP3CfkBLMOorDlnOt
         byx0LkmevnaLDJMxnyjxxz3p4rTec7JWTL2TaHw8M4d6Hp3qvei95whuBkUfI7+jP8ML
         LqdA==
X-Forwarded-Encrypted: i=1; AJvYcCUyFwVMlG7nx+NfP352EWxe+R5VcuPRQSsmKiij9nVmBLXmiaE8VcQDONBNlsuIwnKH05j2RaNe+3ya9vVdrMTNnZBetuCalGQf4lTQ
X-Gm-Message-State: AOJu0YzHZAn6gB/hkIsa+gDH7gBLnRjvQK48Kn7ruaT08uBeRzZ7EsqA
	NSSk6XeLo8iRgkqYnXBh+Sd9YWAxZjliSbap+muOs/DWKB0rOi003bJViy6eclo=
X-Google-Smtp-Source: AGHT+IFOVgf4hVeQjVESSY+ggbpz68BsoWauoggn89sDMwFWL/rPxd3AtWFF6ezQRMu04/Di9Qho2w==
X-Received: by 2002:a6b:c844:0:b0:7c7:224e:ae90 with SMTP id y65-20020a6bc844000000b007c7224eae90mr12163072iof.0.1708465509026;
        Tue, 20 Feb 2024 13:45:09 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id i22-20020a02c616000000b00474415415a8sm94935jan.100.2024.02.20.13.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 13:45:08 -0800 (PST)
Message-ID: <663c539b-deb2-4cb0-8e9c-325bc841b9a1@linuxfoundation.org>
Date: Tue, 20 Feb 2024 14:45:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Spelling correction patch
Content-Language: en-US
To: prabhav kumar <pvkumar5749404@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240217074353.19445-1-pvkumar5749404@gmail.com>
 <e2b42c87-f87e-4d09-b17f-82ed4002e989@linuxfoundation.org>
 <CAH8oh8U84MGb+9g5013NHcBcO=9sQzpBFEm_-7sD1eu7JmTUbQ@mail.gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAH8oh8U84MGb+9g5013NHcBcO=9sQzpBFEm_-7sD1eu7JmTUbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 14:38, prabhav kumar wrote:
> I had missed some names from the get_maintainer.pl <http://get_maintainer.pl> , Will update and send a v2 with proper change log and a summary.
> Thanks,
> Prabhav


No top post please. Review kernel submission guidelines
on how to respond to review comments.

thanks,
-- Shuah

