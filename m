Return-Path: <linux-kernel+bounces-30114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29037831967
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9BB286545
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F3A24B4E;
	Thu, 18 Jan 2024 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bok4Q69+"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525D124B3A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582029; cv=none; b=PThlp9u7/168XBNtzYO9fkirrJkMPRDHlId6Uvvu33l5g1IbTDqcQFWyL3JYG2wUqBxOOs6j/i984TPNrsLdsJv2f/xmT24jmXHX4+80vcIxeX4WhTtKKZJXBI5wdbsNnugLvUT6wE8HpvKvMiIIPlQ+RLa8Lo/s31A7tY3jMA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582029; c=relaxed/simple;
	bh=7hzv9Q2RyFYsBMK7cp2sHJQU4W1HVKR0nok44qQw548=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=b4oOYu9JG/g0Ac6/XJjhjlTKmoYte5VOCFRjY9M4uf3ZgDESBqHGXfioCZa4MzRpfxkeNSSenl3J0MTCdK8wAriQuAmvaPez7f2gitWWmqKBy+OzEe5kt2QPMQKGSpZ0YNQBVK8t4jjcdbdrKqdJtavdOxkQlUrIS16H8S7RLiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bok4Q69+; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7831ed13d39so968075185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 04:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705582027; x=1706186827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hzv9Q2RyFYsBMK7cp2sHJQU4W1HVKR0nok44qQw548=;
        b=Bok4Q69+HhXa8aXkt8tCjve0evBtlKS5Avm+SDiXbV2MZcwMoGEXAAYvW95sTJ6wra
         lQYYs4Mubuj9GLrfK+q1m87TB7IngUmlWs0PikpLblo8md+0B4c1n5j0bFa38nL/gKUk
         U0o4cMMLrN0dBlxzgUuZE59Wu5D73Hntp6XVMYwK5t0wJ5qFvn1JaGdpLDHt5I2iktJ0
         o5yhRbfi0ML7X70uoCdxMxQ3obaUBr+Lm+H/zZgVZj/0HzFE6Abd5s0hUlQE1k6ppF/v
         2OtYzpH9qNvhqL3XGjZMm2uUmpbwOVg++/4Z9Gk+aQN90NDnwbLEK/iZGFQ+/OtMReG5
         RtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705582027; x=1706186827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hzv9Q2RyFYsBMK7cp2sHJQU4W1HVKR0nok44qQw548=;
        b=iL42uAyqgpUb1TwE9Q/67GyTQrgT9s2DeULVycC8FzxwR2aNQdjpGCgV9hQpycRXM5
         ja61PRh+96U1me4s8BBROAEsxWfdhcoGZzlJeoMdo82Ltg1v3u/LXfMMsLedOlzkr+Hi
         vWFc6d9L1j4TMOTk3DynGwt6wrWW+9F0oWl6dgUngt+5QPKlRlv/JW/4b4bKCluWINek
         GCE0+SpcK3IlW3rBFNMaF13wOvmqVMdQmNyq6LfxIqpFEs+jub02ZpBtz8P03CZ47iYn
         ZQxQ3QB5cAKTrAFUv10AOXRScYe+ZnFFyH6GqPiCT7M+bAyAMoUGHWetpP91GR/AQXbn
         i0hw==
X-Gm-Message-State: AOJu0Yxgnjla/kyAho1VWVp6B8NHKPLh5xF2Gexb5UsQPbLo5pPRPbNz
	vPNPU7+EDIaPfj3P8rgNOTt5NZQ+Azpxn6YA0TWtaMHEqxPkv75/9juICvVJXWP8JQRPzj8fdGv
	nCmgquc6t+Los1IrKhw+4AZAHiUYcyf/wweyT
X-Google-Smtp-Source: AGHT+IGsc6OnJVHcfGaSFGChfKZlDVpuDJr0DO/x+dFmITX18h5L8MTKUba0d5F7q2XP/CeYGYm0PJbdBCiSQGqqXQI=
X-Received: by 2002:a0c:f2cf:0:b0:681:7867:fbb9 with SMTP id
 c15-20020a0cf2cf000000b006817867fbb9mr747219qvm.88.1705582027089; Thu, 18 Jan
 2024 04:47:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118110022.2538350-1-elver@google.com> <CANpmjNPx0j-x_SDu777gaV1oOFuPmHV3xFfru56UzBXHnZhYLg@mail.gmail.com>
 <cd742d1d-70a3-586b-4bf5-fcfc94c75b4a@quicinc.com>
In-Reply-To: <cd742d1d-70a3-586b-4bf5-fcfc94c75b4a@quicinc.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 18 Jan 2024 13:46:26 +0100
Message-ID: <CAG_fn=VMTOJn+wtg0NfE2bFtuh_OY1DQeMu0KB5u4sjS05sXgw@mail.gmail.com>
Subject: Re: [PATCH] mm, kmsan: fix infinite recursion due to RCU critical section
To: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: Marco Elver <elver@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 12:28=E2=80=AFPM Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> May I ask if KMSAN also instruments the access to the memory managed as
> ZONE_DEVICE. You know this is not the RAM and also these pages will
> never be onlined thus also not be available in buddy.

Is there a way to tell whether a memory chunk belongs to ZONE_DEVICE
by its address?
Won't such check involve calling pfn_valid() or a similar function
that would also require synchronization?

In general, if e.g. one can call memset() on ZONE_DEVICE memory, it is
already going to be instrumented by KMSAN.

