Return-Path: <linux-kernel+bounces-34221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983CD8375CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508CF28CB92
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452C34878A;
	Mon, 22 Jan 2024 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Oiigjfjh"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86F482E3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960970; cv=none; b=YXsbD3sOFgDjGcTT7XvyTq7MLx15mal/LX61vEEzEcu83RO+yyaWPM+aBMz6fiMbg1G0p8SZifCMosw2ny6ocvaPLPnnbQsiT1jEjeZpBUYo9g1s8/DJinT/j6R2uzkrMvM1cEAGCUkVRiLoV5BDbqSKZZ4dZlxJcK48cXFdWaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960970; c=relaxed/simple;
	bh=0hp4qAvrOKY8LC7aAKY29ksp0u/TQ0p/ryQA8d1FRbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBazDBIQYZIqospg8TR5LUwkNNp5P2jg+mX96f2JfAIASa5mqpLeyxzkRimQF54Vo4mKNEi8lEtYx5qocNn40W8KOdD7TqqSZn0/a2gkBHzgRulOPKgRx3SnBreisbWUvu1Ih+dzZl6gxcQ5cmyPX5btUf3+Ie7+oeAftjgqxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Oiigjfjh; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd0f4797aaso35794511fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705960967; x=1706565767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jOSAIaGnjvf6CCjF3fmWDAvl/DrTsNgSFwohRJOla+4=;
        b=Oiigjfjh1FOT3dWADyiBvbCTmFIDuugvEH3QUxZafJns3L11Pt46kookMLfcfehMvY
         IRympvnxlfV6KykDmEKM5TfLsQrCvFcbhsOTugbQJQLo3gL2zc39zwFew3mQjtNwZuRZ
         xqMoofL4CzT+40rOdRkxhv9CY05jeScesslU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705960967; x=1706565767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOSAIaGnjvf6CCjF3fmWDAvl/DrTsNgSFwohRJOla+4=;
        b=qCiUWKaI6zB+sCHYDFCxscZiL9l/7H/CAUZUyXLRxjuvQDLkS8TE8DiIi4t1vp+Y/S
         PzMq1M6sC2q4DLyC6PtcypYxDQJP+0rjbWoFOm1cuVox18LFLFakye4QgNDOGmbYL0zN
         PYo/C7GIl8INE25UxoLwlxcqT9ubZF/cva6YL412FU+6GL9vJFgoZxyBxCPrGbaGAOd5
         LwiyZFYUhk2J+n0+Z+8g8PByHqD7ncRQNm/ii/7ZiXkn+EM2RmXy9ALVEM4lct+nZyu8
         hNMQhKaakdhHtp3IyyEQK32vpnaoiMcayniQrH3mtpDYECbsFcckO+67eLdHX7hYwC1g
         RMlQ==
X-Gm-Message-State: AOJu0Ywf15vI0aEcjdW3cULw+4zN+5ZTksZJ9wpX9p6Wn0ndL/k51eTt
	5Hpmpw8OrQlj0we8kUIAQCxIMwqTnQQQvbQiX30aYTjA1aC/bmVYXVZ9kn/Ti3i8klm/PFvjd6m
	gnwLXhA==
X-Google-Smtp-Source: AGHT+IE3Y32Ba34SO23/kUAS19JbowT0PKmhvG6M3tIiPmZWFfRenWo7Ht++krOgKnytE56s2VPVyA==
X-Received: by 2002:a2e:860a:0:b0:2cc:eae3:2bcb with SMTP id a10-20020a2e860a000000b002cceae32bcbmr1896320lji.40.1705960966789;
        Mon, 22 Jan 2024 14:02:46 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id x31-20020a2ea99f000000b002ce0393f6aasm998670ljq.50.2024.01.22.14.02.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 14:02:45 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd0f4797aaso35794281fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:02:45 -0800 (PST)
X-Received: by 2002:a05:651c:1a25:b0:2cd:f914:bba7 with SMTP id
 by37-20020a05651c1a2500b002cdf914bba7mr2536886ljb.34.1705960965293; Mon, 22
 Jan 2024 14:02:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116225531.681181743@goodmis.org> <20240116234014.459886712@goodmis.org>
 <20240122215930.GA6184@frogsfrogsfrogs>
In-Reply-To: <20240122215930.GA6184@frogsfrogsfrogs>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 14:02:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiODW+oNdoF4nMqG3Th7HhPGQNQekDvw16CvgKvaZArRg@mail.gmail.com>
Message-ID: <CAHk-=wiODW+oNdoF4nMqG3Th7HhPGQNQekDvw16CvgKvaZArRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] eventfs: Have the inodes all for files and
 directories all be the same
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 13:59, Darrick J. Wong <djwong@kernel.org> wrote:
>
>          though I don't think
> leaking raw kernel pointers is an awesome idea.

Yeah, I wasn't all that comfortable even with trying to hash it
(because I think the number of source bits is small enough that even
with a crypto hash, it's trivially brute-forceable).

See

   https://lore.kernel.org/all/20240122152748.46897388@gandalf.local.home/

for the current patch under discussion (and it contains a link _to_
said discussion).

           Linus

