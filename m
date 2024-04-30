Return-Path: <linux-kernel+bounces-163934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0B68B764B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4730A28537F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A705B17109D;
	Tue, 30 Apr 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0LvlAvXc"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459BA17109E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481535; cv=none; b=F5ECijeJdJFhaZD6wn+Ke0kjPNykZG04SjLB4yr8t8Z0LDvPPhzhO40c7nHeJ9U7VmuDiB2gSIq89N1I76XQJXX6Z/bVVO4sAAaTrPmVw48rWxvGvDkvYOvfnbRrhpx8urlb+AheS8N1RHmcPxXXd0XEdvMC3PwxTK9qFc47TrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481535; c=relaxed/simple;
	bh=AHyYFem93a94lPDvaCLaH9SJvb6gomkmsRMs19Vqr/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p33Ix+0gKVFhqDyHmLOJzY2vk5J9q5yAcI5pRoOsGi2OtAkoNoFHfv8cJAAk9c4KRHHIUl6ActXntoYFaArrhv48nx64q/rfFv12MDPmHKH7uQU34gnd3HGqzeiwOAicQRNjNMBX6ChG+CwCan/C0sBZNYlrGr8O3NqTsjHN7dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0LvlAvXc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ab48c11534so1427667a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714481532; x=1715086332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vv51ze7Ec3px/NDAkDJ0Mo8NY87K5dXMejfH21FYqBE=;
        b=0LvlAvXcvLIpmwMpB2KHsVL6E5JiVdgAw/gFc3xaFsbWyBr8bdR1f80uRUnHQuHN/k
         kwojJjhyz5n/FUeSk71DfeqtCnOcC+UAVFNdcmYLtlUucoBVqDf8aFWIA9uR6+mN2IJV
         CKqG4pRp0dTgp9ziCGR29yX+VNfDMDy7RBrPV23qZ43DDQl11DvJlFhXic5mdAmiy8HT
         /1+b+TF+g7WdwRxhGaq10LplNnogt+5PJBwCIyEIGd6662852RfqstPY2Ls48iJk4b46
         23g9p21PqffhlwasR6Qe8wzu3P99ZJQM7c/IwRIHdJQuwETURFnE4LM8EVm0tQQdra/D
         R1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481532; x=1715086332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vv51ze7Ec3px/NDAkDJ0Mo8NY87K5dXMejfH21FYqBE=;
        b=CHodtHhGhmxzyD/Qk2951i9Oobwouany+koQR8ptmjpwa3sOVFjUKp0iNr46N+gRGt
         b9oW+BiZ6Sf1c+MR9ejKsSbU1lZ0faVEa9ov9PIhQqHZWjZ7Kt7mPBQRfm8394L/TxDk
         1KLAw8MUxwHxftsVItyfvttutEfhWm9SysumqcRYwbRyOPa/Do2W9G53iV5YxvGMadTl
         pQsHtzFfUIgyjNEo0Tt+YHKeFdsepFyqhqdicyeM2AUJ8IKegTflwmmWGSaBz1jdyYAJ
         E4kvlrEzbp3mqEOLNRuQBcSOW6Hve/BGqFTFb19Yb3lwxvQ65lxmobrz7MV8kLaqKAXh
         UsXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEENljWUt+2H1sV1HkKRjYrkSqvKLTeMbc10jYTQiewXTO0wDt9El4nrhQbL6wOjPRWVDR3pAHrS17i9FJHCZaCfRt0Hz9uhKY3C2i
X-Gm-Message-State: AOJu0Yx3Z2jWqDbaCMvDtxL6By4kH+L2CTYQugjTl1Tl6MjBPnrr5wXN
	fgmgIDeVkoFLI0YxTAPq5/tO0IvyUOo+lKfHi8ZUaykyiV1umL3syayNUoPOsUY=
X-Google-Smtp-Source: AGHT+IEnSdhHApuZiot8T+5IlekQAtFkxU75C9+fUyV9oPMXzZSucxUgZa2l6UoQFNQRcKmy4ftbfQ==
X-Received: by 2002:a17:902:d50a:b0:1eb:50eb:c07d with SMTP id b10-20020a170902d50a00b001eb50ebc07dmr11408766plg.4.1714481532292;
        Tue, 30 Apr 2024 05:52:12 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id iw6-20020a170903044600b001ead2c5ef12sm1007354plb.210.2024.04.30.05.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 05:52:11 -0700 (PDT)
Message-ID: <78ae53dd-f927-43ce-8370-a437a9d0fdbe@kernel.dk>
Date: Tue, 30 Apr 2024 06:52:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING: modpost: vmlinux: section mismatch in reference:
 ipc_imem_handle_irq+0x292 (section: .text) -> .L0 (section: .init.text)
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <202404301338.VtPxCQfW-lkp@intel.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <202404301338.VtPxCQfW-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/24 11:13 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   98369dccd2f8e16bf4c6621053af7aa4821dcf8e
> commit: 561e4f9451d65fc2f7eef564e0064373e3019793 io_uring/kbuf: hold io_buffer_list reference over mmap

Definitely not related at all.

-- 
Jens Axboe


