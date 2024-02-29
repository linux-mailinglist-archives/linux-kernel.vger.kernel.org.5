Return-Path: <linux-kernel+bounces-86019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C757486BE9C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831ED28896B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63107364D8;
	Thu, 29 Feb 2024 01:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="ZkdWAzyI"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC136113
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171745; cv=none; b=Pas7Vw4GaQDDakoKzOYmfx5FSiRcsQ/BRLTGDOCqewE86Ij5RYuRu2ApeRRC8jR/YqO979iEYHCNJ9AElKX2hWtbrTvDzMHQpNVoyGP5RlHG+P5HOYNfWCh7+oZ3DoHcHXCfvywsva4LVXxrOb7sKeIY9o+isfSd6pdv9XXuolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171745; c=relaxed/simple;
	bh=0FKuZF+/77UvZJj7Dp1T/f7NHzts2GeP2TB5tPoHcEM=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=bv+ldLO11txugGNtcZG/dBVfACGImld6ISAnxJa+yq33cxuPq+jzba6iNs/PGgiiPtbwTpqM6RM1U2n29UxjgVLT3sbg7uqLhue++5Fc2+yNFi1XXOhgL3U3HXH+ZF9p5PFnPDpjBEWAOAIzoC8StfetvaL8NxegtgnyRREToY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=ZkdWAzyI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d94b222a3aso4755395ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1709171743; x=1709776543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmZRYNFXLdB3MKaMf6C9tFz3DUlJN/FztTh6G+qTvXk=;
        b=ZkdWAzyItg8Kbf6Iv3/muYd7RCPofvAAcMoawj1R9DSg78lVpwC50ZHjjEq/JRlhy5
         TSl+mJDB0p06l9I7iZ4fPqCkon4s+zvLEJUy7WWUIVAmFzdGynXuM629yQrL7uXoq6zJ
         jo8Gz8+pA9iKKN4NeUgaCQdQ1Ws0QvrL4Ha80ASHH44u51IHUyQrjHUTdP7ABVYVxjT+
         T8IGLliML5wIjGZFW4SAsKqmcp1Pt9uBAAJCaexIbg+fDCJMeTESgMyfDzOv6PE1u50I
         eR3ZsI0Zdfmy+ONhcx5kEUIpu7LOMDbqzE/+NmqXk2MSCjMhjR5qDJ1RVZSfxds1+qWP
         18Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709171743; x=1709776543;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmZRYNFXLdB3MKaMf6C9tFz3DUlJN/FztTh6G+qTvXk=;
        b=IbfTJ/1r+tB2QRCz4JViHUBlaiPjqN2NKtZDDAK0uZCR349jNygxCGr/ulirzB5N6N
         e6Yrqbdl6UV4V8wI4wo8xbjVIgmdTbzNcHkoxDe9t26T1PJTosTk3QuM65Gul4IB3GrG
         UuLIcQSfSKnP1e0Tv8l2eTw6s//EAKXCqmq+FOJ3k8zjIjVFVRTxQvU6FVMzqkVVSlSm
         go8mY1vqn/vAtfPR8CTTZZHQ138Q77P1YR1r//CPyYt/6g6B6trfD3XlpcxQyA79hZpQ
         ewhtNQvsaq5OegaUCSpJ6MhOiT7oyY1G2qD2XgUF0x91f47khEWDBerEnvv/zywehcUz
         cjWg==
X-Forwarded-Encrypted: i=1; AJvYcCUXjv8hHH8eTkwWwjLRWdlBC49XhN+zxR3xAnGvwec+zc3iorWYuqxrCkUQj9GMyoSOKLh1tDk/4eY91cQJlPNeJi3vSN0wKXfySsIT
X-Gm-Message-State: AOJu0YwbGa+4lupkfNeQK+4XnJYv0TI6jWljOWUbxJbIJFZQp6Z9kKPD
	uzy+PfLWcycl8cDWZNjcjnUTqwhHrQbikzR9YzMs5QP2F5X5Qqlk4whwvNiTIlw=
X-Google-Smtp-Source: AGHT+IEmnsU3kp+yYe1Yihv9VCe8npCOzmNk5mfnEqfwRyUxQTafz5aYSz9k52ESxS1jdQxPRDGK0w==
X-Received: by 2002:a17:902:da8e:b0:1dc:d4f9:fd16 with SMTP id j14-20020a170902da8e00b001dcd4f9fd16mr1090967plx.10.1709171742967;
        Wed, 28 Feb 2024 17:55:42 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e5c500b001dcc158df20sm124729plf.97.2024.02.28.17.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:55:42 -0800 (PST)
Date: Wed, 28 Feb 2024 17:55:42 -0800 (PST)
X-Google-Original-Date: Wed, 28 Feb 2024 17:55:19 PST (-0800)
Subject:     Re: [PATCH net] kunit: Fix again checksum tests on big endian CPUs
In-Reply-To: <20240228175158.04c0aa1b@kernel.org>
CC: akpm@linux-foundation.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, erhard_f@mailbox.org,
  christophe.leroy@csgroup.eu, davem@davemloft.net
From: Palmer Dabbelt <palmer@dabbelt.com>
To: kuba@kernel.org
Message-ID: <mhng-27f419e8-9551-4a63-a74a-cede3f9d2614@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 28 Feb 2024 17:51:58 PST (-0800), kuba@kernel.org wrote:
> On Tue, 27 Feb 2024 10:06:41 +0100 Paolo Abeni wrote:
>> On Sat, 2024-02-24 at 07:44 +0000, Christophe Leroy wrote:
>> > Hi,
>> > 
>> > Le 23/02/2024 à 11:41, Christophe Leroy a écrit :  
>> > > Commit b38460bc463c ("kunit: Fix checksum tests on big endian CPUs")
>> > > fixed endianness issues with kunit checksum tests, but then
>> > > commit 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and
>> > > ip_fast_csum") introduced new issues on big endian CPUs. Those issues
>> > > are once again reflected by the warnings reported by sparse.
>> > > 
>> > > So, fix them with the same approach, perform proper conversion in
>> > > order to support both little and big endian CPUs. Once the conversions
>> > > are properly done and the right types used, the sparse warnings are
>> > > cleared as well.
>> > > 
>> > > Reported-by: Erhard Furtner <erhard_f@mailbox.org>
>> > > Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
>> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>  
>> > 
>> > netdev checkpatch complains about "1 blamed authors not CCed: 
>> > palmer@rivosinc.com; 1 maintainers not CCed: palmer@rivosinc.com "
>> > 
>> > Palmer was copied but as Palmer Dabbelt <palmer@dabbelt.com>. Hope it is 
>> > not a show stopper.  
>> 
>> No, it's not.
>> 
>> Acked-by: Paolo Abeni <pabeni@redhat.com>
>> 
>> I *think* this, despite the subject prefix, should go via Andrew's tree
>> to avoid conflicts.
>> 
>> @Andrew does the above fits you?
>
> I don't see this in linux-next, so unless told otherwise I'll merge it
> and ship to Linus tomorrow.

Sorry, I thought I'd Ack'd this at some point -- I might have just 
gotten lost, though, as IIRC there were a few of these floating around.

I'm fine with anyone taking it, so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!

