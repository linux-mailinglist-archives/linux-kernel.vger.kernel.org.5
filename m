Return-Path: <linux-kernel+bounces-99498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ED087893C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A4F1F21D49
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7435676F;
	Mon, 11 Mar 2024 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BbJRN59W"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C2F54BCC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710187527; cv=none; b=XcvIP6CUOPltU5BCatR1hZF7GRXduOe8YIFHx8K7rA9/Af/J5CWwBTP9/7thLJpvj7s2C2MCbqYnSZhfSExwclwVrvIpV5DkKULkscvZytFcsyledEEQ7TrPGg9e/UrS/uG47lXsaFO+2UusnHIzH/4m57YDtsIvllpk4f66iZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710187527; c=relaxed/simple;
	bh=mpT1sl1F0yF+bunGOpA/ynNHa11gaq+11+ZvHS6RJUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3UlC9CbQG51Daht2Lh+Qfv7ncY8fS4rD74IaWYPpVZTueTLC1u0r30D4jSLXclhTfRQDzSNqebZEp6bGay/QJxTAp46pQK9r90vMZSwlGmJz8ZVzddPHJUUfgOrxcl8HsUv21KNsRoiGYd88kmBM6MOxkQ5x6OJaTK2aaAJ9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BbJRN59W; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a45c006ab82so560801266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710187524; x=1710792324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4eiTO72xToSXf7fJMM1Ipdwyb9aIIUVWhtnvnxbKSBw=;
        b=BbJRN59Wdeohaf6YrpklY7rI16pbNIMrqmAzlNaiGP5XyGbINr5ZlTEUMEfw1qjx3t
         vVyMbGYYTpszeOEuLLJ0CvuTZCYGyge1Qe4Pv4ji66fFxaZujckKwbh7Gv9KB2u7x+vv
         indxh/6dMWsg3uFB5oe7oWaXE938H3H6kLWws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710187524; x=1710792324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eiTO72xToSXf7fJMM1Ipdwyb9aIIUVWhtnvnxbKSBw=;
        b=b/bvNkyB31DKd/ICFNZYiSJERxQMj7E2xSlswOHSL/DorYCcqfWhXPlLRJvH0gW8Zy
         OWx5QRH+secGraB0C2aADOCQeuap5PKa9p4zdiZg/lhHO5jtPXW7WvBsyLBcEIjefok2
         WawuUSB2tsT/b/CzRlx0YS5V0XaTnyFYhjCxAnaSNiT4gMqIG1p+h8ntJxTALfQOvmkO
         JrYd4DXHCcjvzIz1DAnnKs34ig6Q1RufRRaUFsNc070viwGDFoAUewg8RiVcUKV6mSss
         tPKvlugWZmfrslMckDMINEwFJpISy3gtTHsUTB62n87VCEHuinqsEYKt1/r7lYPMkHK7
         4Mqg==
X-Forwarded-Encrypted: i=1; AJvYcCUpu+I5rgGq2JDgFuZ35seCqS1ePBmCs6G7tnqXj1At4G1otSCpocGfL0KRjVebiva6CIDaSoe5kNysRy3Nr1N7oKigMk5JaJzkP0ln
X-Gm-Message-State: AOJu0YwfYjRIErw1JDA5UKzoz03+pq0v4TqYHaFeYNdmYG8kg0FcPxNv
	sixHgf8iXpdkvxvh141wWeKSpmRQz87YNY3IRHNQ5QHfE22ASAwgCSKsKxA/D1QqAsI5iotV2nh
	EYt4=
X-Google-Smtp-Source: AGHT+IHZDjoVaRt+SrWP+pIqpvEYgmmIFuRmPc0wKNSCV9z47YfBfxzohcFzL3S5Jf3G2S5PMXzzaQ==
X-Received: by 2002:a17:906:447:b0:a46:2e4d:6ca0 with SMTP id e7-20020a170906044700b00a462e4d6ca0mr954328eja.31.1710187523851;
        Mon, 11 Mar 2024 13:05:23 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id be10-20020a1709070a4a00b00a461d2a3374sm1815779ejc.47.2024.03.11.13.05.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 13:05:23 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so672214666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:05:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/OfUKCXl/JcybHZkoUmVP4tMec/GugrBZS7EOchnB9t2Ewn9Ep8E1LLET36731BYGWEWZ5BG+E+UL/vYHcFdpEkL+GRObO0081YRj
X-Received: by 2002:a17:906:c34e:b0:a45:ab1a:4c31 with SMTP id
 ci14-20020a170906c34e00b00a45ab1a4c31mr991274ejb.56.1710187522843; Mon, 11
 Mar 2024 13:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308-vfs-pidfd-b106369f5406@brauner>
In-Reply-To: <20240308-vfs-pidfd-b106369f5406@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Mar 2024 13:05:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigcyOxVQuQrmk2Rgn_-B=1+oQhCnTTjynQs0CdYekEYg@mail.gmail.com>
Message-ID: <CAHk-=wigcyOxVQuQrmk2Rgn_-B=1+oQhCnTTjynQs0CdYekEYg@mail.gmail.com>
Subject: Re: [GIT PULL] vfs pidfd
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 02:14, Christian Brauner <brauner@kernel.org> wrote:
>
> * Move pidfds from the anonymous inode infrastructure to a tiny
>   pseudo filesystem. This will unblock further work that we weren't able
>   to do simply because of the very justified limitations of anonymous
>   inodes. Moving pidfds to a tiny pseudo filesystem allows for statx on
>   pidfds to become useful for the first time. They can now be compared
>   by inode number which are unique for the system lifetime.

So I obviously pulled this already, but I did have one question - we
don't make nsfs conditional, and I'm not convinced we should make
pidfs conditional either.

I think (and *hope*) all the semantic annoyances got sorted out, and I
don't think there are any realistic size advantages to not enabling
CONFIG_FS_PID.

Is there some fundamental reason for that config entry to exist?

            Linus

