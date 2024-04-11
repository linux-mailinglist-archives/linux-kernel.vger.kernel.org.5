Return-Path: <linux-kernel+bounces-141555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1571A8A1FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C613A28B2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF111947D;
	Thu, 11 Apr 2024 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rfoSI3MU"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9318037
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865585; cv=none; b=P6B8yYY7OIfx7yTtI7BtTJOFO6oytVou4q3qVn/r94w3QmKE8yt4rWo2oo/jR+TqfYE22n6eN5uBatXsnztNw6l969Xth/TtTL1tsgd2ousMl+/litJnTs9mLlUZMvpCo6kEmT0c1IupD7/XZmxtZDTPAJDlFnP4f3v+6ebtnlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865585; c=relaxed/simple;
	bh=dW8XAmqM7eeyW4vgfPztKLtEUda+8GEk7kYd6Pd6ni8=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=F0FPPtG+hz4sSJ8RZ2VOnP5FsXX0/gUK3LUqV7r8dMOE3lWosrx+5DxnEfKjYu+903lIvQd8PqwMSG0BuzXa/QKFGJnVcL3MO79INhJ1jbM5vEqRYMfrJLC6dQgOc0JiO/Qi72atN5/DNnwqCDaDXAOfJ+mKsFfSCmpg0ugCSHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rfoSI3MU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ecf8ebff50so145134b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712865583; x=1713470383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjT+6o0lq0aPcW1oUwnjeSeQ1BXltNR4mobET1Ks5iw=;
        b=rfoSI3MU9PoLxX3Xl0qnpQORHr/yIeoBU7PnqNW6Yzef92nCw81UmEth8M8EJbrbrS
         VxdvZ1yxEw1Py9eRkeSbhfro0sglx45suuGPP0zY7gVLrSx/pSLdJ3Jzuv9cbhNOq/Q3
         Swl3RxVgPt3ZpESg1hYiBbxTmSi5HWll2ySVF5xq+kFB0uNQLIyJG3cnuuXirlxDlIlv
         twh5Vx3a0bkau2OqfkMDS1ghTY0z+dBqGBXFSjv9TmNvFMF5TpgAsPGRZHhxUqOTzCgZ
         NTDeO6mtilg+eg46982T5TXHUaqG+9M0No6llDMRmxHdM05eZk9uhkasHes3NZSVvQSW
         u5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712865583; x=1713470383;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjT+6o0lq0aPcW1oUwnjeSeQ1BXltNR4mobET1Ks5iw=;
        b=k3JywDYGQQNWiCRuAgvR/ciJmQqIDobaatDf6vOKMnbdHmLzy2EvaPSPEDqkffEJEw
         LTH4PpBL/zYaRy0tvV/Wz8IqY2Iam+6u8StwOx+3KBcGjbv/UeRJ19AHFtFmdClFwo3D
         mlZKZtSWPoys5PUD6SCa2Vk0GFXVroHPIS4CgUesD7YBJXanrbZ3LJHv7yrQqHzXBFdP
         v33itHhrgCKiSoxmnxlT7vLhjbytyKXvbWnSYWMbTCl+7bauj9gq+W3I678nwLteEZYD
         EDEYmueDFXLMYZ4o18c2scoXZ1cOPm9ZMfhFpXV6nLH9z9Ps5q1b37A270LPlxU02w62
         rRdw==
X-Forwarded-Encrypted: i=1; AJvYcCXAtkC+JC7BPTN1Wrqk0NhmEhX9HSCiiAvomBftdUh3mqlu0qruSATQK+i4j3aEvvEM9o8zGAhWAlqDja3kddA5vQWdJ+AWhmGPlV07
X-Gm-Message-State: AOJu0YzXBvzMzeGk4+2EeXxRLAUet+oJUGXTfFU+JCVxjdFCrxtPO8DP
	HhNDyv7B2TxkEGErDf5cCZo1wBZ2VelTzbKM9OsJmUAYY8MdnghXJV8QgCN1VmA=
X-Google-Smtp-Source: AGHT+IHx+CIoxL14UTCSROAp5Y5aR0T5W2Mz/yPhBy5R39P5WnajKLD/VsBki0J7hnVrX6QyZDI6tg==
X-Received: by 2002:aa7:888b:0:b0:6ec:fa34:34ab with SMTP id z11-20020aa7888b000000b006ecfa3434abmr844703pfe.9.1712865582845;
        Thu, 11 Apr 2024 12:59:42 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id b12-20020a056a000a8c00b006ed64f4767asm1538680pfl.112.2024.04.11.12.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 12:59:42 -0700 (PDT)
Date: Thu, 11 Apr 2024 12:59:42 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Apr 2024 12:58:54 PDT (-0700)
Subject:     Re: linux-next: manual merge of the risc-v tree with the rust-fixes tree
In-Reply-To: <CANiq72mdRgMuQVD53Kp=hqaoiSNwPVZVSrbbMxRYehi73FZf9A@mail.gmail.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Walmsley <paul@pwsan.com>,
  ojeda@kernel.org, tim.chenbw@gmail.com, Conor Dooley <conor.dooley@microchip.com>,
  gary@garyguo.net, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: miguel.ojeda.sandonis@gmail.com
Message-ID: <mhng-7603cdcc-24ee-4b19-b049-64d1bd4151b9@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 11 Apr 2024 03:47:43 PDT (-0700), miguel.ojeda.sandonis@gmail.com wrote:
> On Thu, Apr 11, 2024 at 1:43 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>>   =============  ================  ==============================================
>>   ``arm64``      Maintained        Little Endian only.
>>  -``loongarch``  Maintained        -
>>  +``loongarch``  Maintained        \-
>> + ``riscv``      Maintained        ``riscv64`` only.
>>   ``um``         Maintained        ``x86_64`` only.
>>   ``x86``        Maintained        ``x86_64`` only.
>>   =============  ================  ==============================================
> 
> Looks good, of course, thanks!

Ya, and I think there's not a ton we can do about this one.  Just two 
in-flight features colliding in the docs, some sort of shared tag seems 
overkill.

I'm assuming rust-fixes will make it up to Linus well before I send the RISC-V
for-next (ie, next merge window).  So I'll just call this one out when I send
it up.

Thanks!

> 
> Cheers,
> Miguel

