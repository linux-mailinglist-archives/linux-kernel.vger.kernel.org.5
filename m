Return-Path: <linux-kernel+bounces-43609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF77F8416A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB3A1C22FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A7351C51;
	Mon, 29 Jan 2024 23:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbCv98Vr"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA2D51C4B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570097; cv=none; b=q0D+m8WfoXPZazZJQ8PmBd2d2fkDrN52nN2ymy4dwVhiBME3bToOpnx0DUjCrAY+vcBJs3yW5ep+ghbGUBZEmKQ47+n5q+m+aXBiacN03XlWh2LdyvaM83biuJuGsKsM/McVq7s5Qm7bU+NEhSIUGwT2W+r4fmTSzx8Ef5KF8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570097; c=relaxed/simple;
	bh=kwQ3aN+3Bvl6HbvqiNJ4pNF4yuV+MV+MiX/7hXJLLWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCuTdW5IJa0PYfpKLDPBVbqIeDuazrMueZjwOLpzRJs8HLxGJfhyIW7crVj4bnXm2hteeLM/rlwzstc8j48HivQbAPIIE8rNX1PwsTE4v9UYUu7gRT19ZvVBhQ1u3EUczWMu98gFf23iaTTz0MrAf2ra3Fc8EtgRney2mVGOAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbCv98Vr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so38806955e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706570094; x=1707174894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euDgJGURADDh7dDWQWAdTAbkdywH3tYL6DwuVRdpF50=;
        b=HbCv98VrzCY5rhS94Es8zEsr00+PRWRwGS1AXX+0PdYd2lremTKroSiI37EqUdyf6N
         WM/yUWFju3s1M9VVGSV+ALP+9fgWuxw+s7tw5+6Hv9Rq2Xvw6DzPauB3zvISAkmNkdYo
         rEfniS6Aj6DbX35i2D518Nq8g1n0r/w0e0ZrGkS7WUdJ/R3+CRaf9ohgc1eRTQMWzobs
         DWu4YFESIgAhIxsU8i4yLaL7wzpXyPV3BKZWcMfPEceUCV9L8N2gJiotaiMeK9qjOHFJ
         usBYNHGGj2VripeLdlVHYWaSvgr3hpuPTvzV9zbqj6u1m+LaIBktiVWXmBA+SVA6tXSj
         xQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706570094; x=1707174894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euDgJGURADDh7dDWQWAdTAbkdywH3tYL6DwuVRdpF50=;
        b=wHw0fEi9dP6t8n4ba0eL6Qc8J5D1vqV3gC8MGcLyQZtTnzNuY/2TCnFE/sRI1ny3Yx
         56aeip/IvQ9blXai6btYTmK1OddEH7PJ7ZpL+C8iWrO4WjUzRTAxu/0KHps5UKKb7VbD
         WEJaBfKIqpB3ft9i12381jtljyfUz68X+1LE0hMHak1O27SyFgfxpoxRmpxNxqS7n8q2
         rHRENVuMySDnSaSYPIZBFnZIJWHV2vyE7t5KF1IymljM/EOdHoB5K+rIslpZ0vS7bX1a
         FI1pZHfeKv73ipLdf6BUuM0QixU+6G0VGl547N36Of24hlIt16GuEZzekKDj4y32C4HU
         mn9A==
X-Gm-Message-State: AOJu0Yz5lFDzzc1PGQyh7m8kMuvbFhgorwhibv5mBa945VfguCK7BHVf
	kJX5gSnqMv6m6mgwMl9pSAyja1EU7Z4imH6t32W1I5NMIWEKv85SFF4zm65dpfaxVwBCRHrHBKB
	t5qg0QMpf7EEblf8Yu5ivY0Jayos=
X-Google-Smtp-Source: AGHT+IE8fVQL+SzImzxJCeIUBW+35CbYmxrBmBeFRECdjelPh9miMHuLJZkOJbyOQ0+t8TK0jKCTfK+yHONDGUZEPow=
X-Received: by 2002:a5d:5185:0:b0:336:dddc:3969 with SMTP id
 k5-20020a5d5185000000b00336dddc3969mr4908962wrv.52.1706570093545; Mon, 29 Jan
 2024 15:14:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
 <CANpmjNN-5PpSQ1A_9aM3u4ei74HuvCoThiLAHi=reXXQwer67A@mail.gmail.com>
 <CANpmjNM=92PcmODNPB4DrAhfLY=0mePCbyG9=8BGrQ4MC0xZ6w@mail.gmail.com>
 <CABXGCsM+9TxxY-bOUw6MyRV7CSZsyQpfDgvwgaBBKk9UONJkBw@mail.gmail.com> <CABXGCsOp3Djn5uQYb3f=4k1m9rY9y3Ext9SMavWAFRTcKwtNMA@mail.gmail.com>
In-Reply-To: <CABXGCsOp3Djn5uQYb3f=4k1m9rY9y3Ext9SMavWAFRTcKwtNMA@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 30 Jan 2024 00:14:38 +0100
Message-ID: <CA+fCnZeNsUV4_92A9DMg=yqyS_y_JTABguyQyNMpm6JPKVxruw@mail.gmail.com>
Subject: Re: regression/bisected commit 773688a6cb24b0b3c2ba40354d883348a2befa38
 make my system completely unusable under high load
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Marco Elver <elver@google.com>, glider@google.com, dvyukov@google.com, 
	eugenis@google.com, Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:25=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Fri, Jan 19, 2024 at 10:54=E2=80=AFPM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> I continued to search regressions in 6.8 kernel.
> And found another one.
>
> cc478e0b6bdffd20561e1a07941a65f6c8962cab is the first bad commit
> commit cc478e0b6bdffd20561e1a07941a65f6c8962cab
> Author: Andrey Konovalov <andreyknvl@gmail.com>
> Date:   Tue Jan 9 23:12:34 2024 +0100
>
>     kasan: avoid resetting aux_lock
>
> Here I spotted a dropped FPS in the game "Shadow of the Tomb Raider".
> For measuring performance I used an internal benchmark.
> Before commit cc478e0b6bdffd20561e1a07941a65f6c8962cab was 111FPS on
> commit aaa2c9a97c22af5bf011f6dd8e0538219b45af88 [1].
> On commit cc478e0b6bdffd20561e1a07941a65f6c8962cab I has only 63FPS [2]
> And unfortunately the stackdepot patchset which I applied on top of
> 6.8-rc2 didn't restore initial performance [3].
>
> [1] https://i.postimg.cc/tgvwPTkz/c11-aaa2c9a97c22af5bf011f6dd8e0538219b4=
5af88.png
> [2] https://i.postimg.cc/pX8vHDCM/c10-cc478e0b6bdffd20561e1a07941a65f6c89=
62cab.png
> [3] https://i.postimg.cc/hvWCb7dV/6-8-0-0-rc2-with-stackdepot.png

Hi Mikhail,

Please try to apply these two patches on top:
https://lore.kernel.org/linux-mm/20240129100708.39460-1-elver@google.com/

They effectively revert the change you mentioned.

Thank you for testing!

