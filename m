Return-Path: <linux-kernel+bounces-35421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761EF8390CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DC628DA44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672925FB83;
	Tue, 23 Jan 2024 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="0AMbeG7F"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F715FB84
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018639; cv=none; b=nAFeHuiWO4WVzm011K6R1v7VXYmOibBbUr6ZUXoWDKcsTXYeDPgNNDAOzP80N/Y+E+7ip3rdbakok/FyBcHoEUndXBoQkQsb6xMoqbKGgmX+EDFWIByvGvGjaQk8KDIWRso+2AlJGvHKMWv/1YosLmcuL3xCqTk90pbK1wtxJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018639; c=relaxed/simple;
	bh=WiDhZydkUg7/c4vU+lUs9zcwwnC3I1JZWZ/N5KklzHY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=gqYDRux6CZRI7e/Z44aCONAjZn5mgde8yrQUHZQgSmqGbPntzQ5/GEWEiZhZQIgalY04813FP268dceZE84brzAF4eqnU3UeCoWQYbggn7B9PcS875McAELy0uYkywlTyTRiF5oPXnqFnD3U6JPWYJ8yrHHJzgHAwZEPObMMwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=0AMbeG7F; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so406252466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 06:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1706018636; x=1706623436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGn9arawL6VXVy2ok8i84OPEddY9NvmiVo7v4viWUQ0=;
        b=0AMbeG7FhdvKz9UIvSM6fcwHyFIkyGctil7EBzNxvP0a9rExe3chpF9wvHSIQhnvkK
         fWBK7L/GcKtNke8aQqpDG7kgYOlpwINaM40MvEEgWVOvug89DEToMhCTG5fiIyIKYcT3
         ByII4Ov0hpUfq66mhJhUNdt/IzlPPWbfj5HBLJp24ZeBIPCdbOVP6k8zuDrP3gfoGDHl
         13m2G/6kKCU1RsklCFc1UoFkaDGBZVJhXFo2/IaqQsDhVl6oqAZ2hh8qsHDRAbZgLdU6
         1gTHZksqo8B6p4C9zYl7qiH86J8gF0X70z6+R8y92iACejygaebx8QLx/zovPfPHugB3
         4SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706018636; x=1706623436;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rGn9arawL6VXVy2ok8i84OPEddY9NvmiVo7v4viWUQ0=;
        b=XTysTT80IHxHcvmmioR052Qs6ljXiiVYi1COZlFk2mFvIWyWgVX0/Y86vBidQ9MvZB
         Nh1KisW5niJ/vzkOK4I03ZeF0+RWtdfMyfcK+BDfw5cqseAhRZWdcLxpuO3y4AlVxAEv
         mFzCHFgefm70TkdPfga3JASx4or1OfP0LxuD5ZG/Nwh4fc8eINBuJAbBScj3emoHUYRF
         fiuProvpmvpV8rpAOKB2ibkYPVR4xSJqgUaIVWxug/4d2avodCkATziH10nDwsMvCt/t
         Gg39PSoJHyB513Fh1YXY/prHbUNbvtNpcWmjgJjJi6WuHv306q+UgA9ENG3An/ECUbDZ
         NERA==
X-Gm-Message-State: AOJu0YzSVK9OJF7EzYuazn7SCUa+/fPEYkVNwvZKPlJ2lqgRPeTPTyne
	FegVyxn5nDK2mMNpfJnJWnze/Ut5zA8N/XIujtGeFbhDtipW22EJb0QJcIJeDsA=
X-Google-Smtp-Source: AGHT+IFSzTFRrplwglge0jr3yuPQ6ilgY0lWVkp2GUdWMnTQ89MS9dRfMtnpFMw+ZJfe/H3GMbkkWQ==
X-Received: by 2002:a17:907:3f20:b0:a28:a7b0:b46f with SMTP id hq32-20020a1709073f2000b00a28a7b0b46fmr3812814ejc.5.1706018636616;
        Tue, 23 Jan 2024 06:03:56 -0800 (PST)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id w4-20020a170906130400b00a26f1e3093asm14415484ejb.49.2024.01.23.06.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:03:56 -0800 (PST)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <20230503090708.2524310-4-nmi@metaspace.dk>
 <iL2M45BoRlK6yS9y8uo0A5yUXcZWMkdk3vtH3LRFSWXfvPVagVZ-0YC7taIKOBFUcjJYA_2xNNFPoC4WL-_ulCHOLkbqvsZlIshE_LEeYtU=@proton.me>
 <CAA76j92c1e9E7ik_k_8gqfrAczdReKwH0ZvviFMv+7rr1_GoNA@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le
 Moal <Damien.LeMoal@wdc.com>, Hannes Reinecke <hare@suse.de>,
 lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson
 Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 linux-kernel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC PATCH 03/11] rust: block: introduce `kernel::block::mq`
 module
Date: Tue, 23 Jan 2024 15:03:09 +0100
In-reply-to: <CAA76j92c1e9E7ik_k_8gqfrAczdReKwH0ZvviFMv+7rr1_GoNA@mail.gmail.com>
Message-ID: <87ede8jgeq.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com> writes:

> +    /// Call to tell the block layer the capcacity of the device
> +    pub fn set_capacity(&self, sectors: u64) {
> +        unsafe { bindings::set_capacity(self.gendisk, sectors) };
> +    }
>
> Nit in the comment: capcacity -> capacity

Thanks!

BR Andreas


