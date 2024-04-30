Return-Path: <linux-kernel+bounces-163967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73E78B76A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF991F22F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BDD171E48;
	Tue, 30 Apr 2024 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XmxrL3A6"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373F171672
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482785; cv=none; b=GZLxyWS3ltJkHE1WZpfa1pHDbHj6FIWpztSLihK5a4H/7Qx0LgA35+NxcarQwLhCT5Pb9wzux1ggEZdzSnCmjAXkNF+8V/SnJBxkBRTASYa3od/fWqeFAD4j/W5/4u2sEt0/fyqz2gadaw6HU85wW/vC01tN2R8v1bSGHv3913I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482785; c=relaxed/simple;
	bh=Ne5Bi0B5WsvRNZIhSyh9MsEOS7OU9xMrt51TWhQWQEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWbWJtE5mLkn+3p0KndnAB9i51HNTMG9gMsTXY3EUOB4wRbUWl4FfaWzt0KKJerQippRrBi3NfLUN380an6tUagmuNr5nxqhdwtD0EknJDTH2a3dWm23FxkBwzl1hy7+kHB+4E9SmaHCigD7mfuQpf1QFAqET0RE3IBybQ77LUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XmxrL3A6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2abae23d682so1507545a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714482782; x=1715087582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VDzIEg1ZVe1cydRAdGBXm27kG5sPMrbA3OUBoEoLQc=;
        b=XmxrL3A6oICABtpPFxzl11w8qSQMnRAftlc9Lo5C7n6qbt/BCRTzMnOiceYfMdEHK+
         o2wXDD6spapLO0rAApTH5nbUHH2xPQVF3BP6rQfyjDrNv7Zyd6FLhhzFr6J0VMPqvcuj
         aF4190UdjrmnmvvLbs1byW1TLxwqHM/PxVtQKtTTpTcDM6cZnFUkHtxov1JEDUb1Sluw
         Vrrkp8wUTbNZBEbTguo/uLufZqNtm4Ti70czSLAtINEe3XXvCWKSHB9/ZbBe1O7GXZsn
         NJtuuENKl6DUX7ujgT++OjeHld0q2LzcyZwD8HLMbAR7oiXlMQXACyUQGnDP2oW7inlM
         gl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714482782; x=1715087582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VDzIEg1ZVe1cydRAdGBXm27kG5sPMrbA3OUBoEoLQc=;
        b=hGX7kOImhUYyv3hkKN/4vSrejQLVMPZaUulfW04hYpPdeEv3icOQnD6s7aATUv6VuC
         zIJzbKqTPp3ssL9d7MtoiPUsFcBJLesCjj+zeRo05iqDTEE33LKlsE/T/fJMulpSDj93
         FfeeLMookRZkO5XgkWQZrrdPpe1zeXhlqN75/UVnmvnd9inA17Hx4eFwlwfeFAz/utuJ
         HVnlbyRz/W6W48nM8diXP0NPv0YDtP6fh2kRrIysFfEnapkKCxGy60WPeocdDs+t2smC
         MYBOfHUWym6zn23K7TJG0I5zY9T0w9rc5Pwlb8TghYbJppmtMA+Ukc65um8wJ4htNzxM
         qLgg==
X-Forwarded-Encrypted: i=1; AJvYcCXWIyqRZHjqCTKJNzrUGoYXMKZJQf2bU9F77UpvDDlxcmUJcgxoARUXZAPgCDkBxj16PNC0bau9peoHia6egeryIPB5nsmsJPS7dVb0
X-Gm-Message-State: AOJu0YyUMBXyqjE9N/ncZHx3f3BIUcVtYgGJGp+ft9E61irxQr2gyP1i
	GCE6goYBXu44SGQv0Lkvda2ADtw8TkmUmHKP72rLg2iL9xeUO1JoyiRDykaxDwk=
X-Google-Smtp-Source: AGHT+IFy60/C+LkKXI0Q9u1ZeprTkPYIrBZ7ByLHCGACNHhu+cMg8tw56ckMqc/nBJwbtqHIKu083Q==
X-Received: by 2002:a17:902:e892:b0:1ea:95f4:579c with SMTP id w18-20020a170902e89200b001ea95f4579cmr15567894plg.1.1714482782471;
        Tue, 30 Apr 2024 06:13:02 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ec8600b001e446490072sm16656742plg.25.2024.04.30.06.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 06:13:01 -0700 (PDT)
Message-ID: <8e1bbc90-c094-4562-b563-dfea59dd5a20@kernel.dk>
Date: Tue, 30 Apr 2024 07:13:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING: modpost: vmlinux: section mismatch in reference:
 psmouse_resync+0xa4 (section: .text) -> .LBB102 (section: .init.text)
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <202404300842.JYA2baD8-lkp@intel.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <202404300842.JYA2baD8-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/24 6:25 PM, kernel test robot wrote:
> Hi Jens,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   98369dccd2f8e16bf4c6621053af7aa4821dcf8e
> commit: 6b69c4ab4f685327d9e10caf0d84217ba23a8c4b io_uring/kbuf: protect io_buffer_list teardown with a reference

Same as that other one, not related.

-- 
Jens Axboe



