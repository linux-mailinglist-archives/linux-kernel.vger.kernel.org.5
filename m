Return-Path: <linux-kernel+bounces-126917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1961889446F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADACBB21957
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43374D59F;
	Mon,  1 Apr 2024 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kO3c1NpT"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877714AEE4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993486; cv=none; b=a1Q+hiluVRSDBUmSpztgmLFryxDtjvSRE3f/1GCGU6vclbjJVcgaOOCXZd/5OVeUh+z3XH9vAd/WffRK7MCdVdSwsk2lps7qJa4F86KljNoXVb1kJtC6TMOWf5vSU9P/7+wCsZ4S/7VOv7WE8u35/vEpaSy+mjkJCYnQESBYxwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993486; c=relaxed/simple;
	bh=3xndIO7+K5+Uh1AGq7cKmGxfRRQe6X9sunsqeDf86Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNTQxg+iFRN6WXqmtkBORm1cY031vw0O4+yt/p/rP6d3ii/HbYwoeybZhOG/qHAXqEBJYypSooBTCeKL/g/SzOdDFxG2jJi60ep2+FqHgNynN6KF1ym5xR3fAwIb34S+mXLAQ5gZFDHws0/sTsqfLGsF1qWyVk182uYp6jwWrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kO3c1NpT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-413f8c8192eso213615e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711993483; x=1712598283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xndIO7+K5+Uh1AGq7cKmGxfRRQe6X9sunsqeDf86Eg=;
        b=kO3c1NpTKKSmvYocsfuZBMzFASOUQCCPO3fFnD3k2IpXC38VohUKD9OyDN+5ekSDRI
         /F9QAgQXq6RzfcGV+teI5Yi4GjWYYoDefaVf+gkCfOKgPW4IwfH0k5mrtDCin5DroT2Z
         c3Gmkhf1JwhtNiPhny00zfihpMd9oSJFLocgxtWYsQiFKf4ltpLuo2P/i1gsNd74shJo
         1YwUZ6u1KSinz5BxnJDf9RmVMBs/S/sGQXLO72GtS0DcSJpI6TrojERyODeee30VcKCE
         P+J9ua3+3K+9dBGbInp0sueaYc/If0V/wJYZ8CaXnn+8ofpggPqA6yoiAvVK+ebTpewe
         wdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711993483; x=1712598283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xndIO7+K5+Uh1AGq7cKmGxfRRQe6X9sunsqeDf86Eg=;
        b=V+DRiDi+mIZAN1sbJ0EpSDEcXZUpe1wcrus7oPFrFDsSSyGOY1xIhro5wJZ+6vj0/T
         bzpShGs9sOebvrIVeYwizqKyBQh6szuCbHfbhdjuKpwAyyAJ6jtsf24vtKP2Dp/A/J3E
         SFsRfv9WPEOJJ1ou/rKoimlD4geupczRND45lZnYA9SIaFiK/UmdaXcsi0SAZsKvx32y
         rjlG5fEb4bZw5+nRS4i0TTI3of026vVfuusj80OVbCS7zx4ulsp9xgFTa6O1rOGPPt0E
         bJmfuaf2PdkXMMHdW8pjL5XW37fMgsrRW3SG3fCBmWkLS8R5NOeH2ZHyCOVLfkKDBuH2
         /Mjw==
X-Gm-Message-State: AOJu0YztFHoAONmXcrOM1OudEGNOogJhlFHy4QykZbAhLrw0Fo3iu6nO
	iTAVnU+OxUjmOQ/poz+p+7ofriPdZDfMhYZouyX6VijxCoNZn71MFu87YGTiKVRdMt9EstPVnph
	aJpUvBhOqvJFXUnuWcYspihueMs/ssX/ccUo=
X-Google-Smtp-Source: AGHT+IGQf2ZHTu7DF1dpWUQrMpek18uz/AVJ1fHwD1J0ivYe1gZJYjyUVK9UCuj8xeJ1ZLktD/bx7UwRJiy7yT9jImY=
X-Received: by 2002:a05:600c:1c20:b0:413:f41a:ed1b with SMTP id
 j32-20020a05600c1c2000b00413f41aed1bmr564009wms.3.1711993482559; Mon, 01 Apr
 2024 10:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240331172652.14086-1-rdunlap@infradead.org> <20240331172652.14086-3-rdunlap@infradead.org>
In-Reply-To: <20240331172652.14086-3-rdunlap@infradead.org>
From: John Stultz <jstultz@google.com>
Date: Mon, 1 Apr 2024 10:44:29 -0700
Message-ID: <CANDhNCokU4p_t_WrE+efsLx8q2xjFPBGaZP4Pc8viLXM435m4g@mail.gmail.com>
Subject: Re: [PATCH 2/6] time/timekeeping: fix kernel-doc warnings and typos
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 10:26=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Fix punctuation, spellos, and kernel-doc warnings:
>
> timekeeping.h:79: warning: No description found for return value of 'ktim=
e_get_real'
> timekeeping.h:95: warning: No description found for return value of 'ktim=
e_get_boottime'
> timekeeping.h:108: warning: No description found for return value of 'kti=
me_get_clocktai'
> timekeeping.h:149: warning: Function parameter or struct member 'mono' no=
t described in 'ktime_mono_to_real'
> timekeeping.h:149: warning: No description found for return value of 'kti=
me_mono_to_real'
> timekeeping.h:255: warning: Function parameter or struct member 'cs_id' n=
ot described in 'system_time_snapshot'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: John Stultz <jstultz@google.com>

Thanks for these!
-john

