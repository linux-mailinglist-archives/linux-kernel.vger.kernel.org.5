Return-Path: <linux-kernel+bounces-63997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424D085388C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C602838F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ED45FF19;
	Tue, 13 Feb 2024 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="UaTqpjr/"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D4A93C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845868; cv=none; b=jULjK/egnbicFBUgmUlFf58n7c7+Lz5YxJC7TnrNOqiIn1uenGeIC1+/GJIBTuLv7WiemVk85/8tVaLwseRFyrNYV/u0RkqTOyMD3j3XEUHE5bBe4tZH+7v9NTgZMi0QCtyH2FER6Bs3UOtiTf9JWBFrA3A5n4vf90Go1Da2fps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845868; c=relaxed/simple;
	bh=I8mDZVj6Lh3NqcfdRheicyl2vrErwPOLCoL9JFRpzQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQ2EP30ieROcM+gVu6LstQR5MGuvu2XxXaO0Ncjll09bmiHpMcTmDeW0k7O0qH2Sav/khEfXnl9nokg1BBIdOdP3kVpeBA7zf0wMRyt5HWGkQ7aLJOHHO68lu++9EklVkYiMJhkOU22khSCpJJvtJ+R55+jCNDuPLoQbjh2esy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=UaTqpjr/; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e0507eb60cso3000232b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1707845866; x=1708450666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I8mDZVj6Lh3NqcfdRheicyl2vrErwPOLCoL9JFRpzQ8=;
        b=UaTqpjr/E4D0CycohBjXqMI9W5bwX5ly+Wgy/QXqru+jL6fM4xB2mUqegJtz7YIzgO
         vPkM3WfWURZZTzw9JUi0mXlkIBp1q2XvQJJdqEovm0PP7ZZ4+MtdB5luvdrk5Wwcl4zQ
         3anZlQJLC1O7cmM26oFCMk19+lnuuWLDtfHhfKzm8VNcJKBCv4LTrPBFXt8LUG4711ro
         65q7k3IFFpvUMEa/JFSmzEFwKEpTVfxbd5nFMxfgzO3uD9RhStBZcdwBDJQK2WXYaL16
         db3ab13oH5//m7A2GY2XfeBKT9H3jDBOzXwhs1PePC+ykXGXefHrv9/zt3cAc2liSesR
         /Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707845866; x=1708450666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8mDZVj6Lh3NqcfdRheicyl2vrErwPOLCoL9JFRpzQ8=;
        b=KEBrSvirvW+AVW3calXCrYMDGXJypVU0+NYnbrLRPLBeGz4R8Qn5s9ausL3aCZUs8r
         0NZ6nRmJheZbz8hw8GSR4UfAbybfrrkud0HdMXp8if0u4bZxv5wa248YQcQwflfu7KAd
         zUGqK4nPCEjyqeUOgwjpldpslYGH+4REJ9ISyJpOiox/x3/cqlqqR9J9m05tQ0cwrVfD
         8+TbJCbNG0gnvwAsaCeTd7I/pY14sPtEATQ/it3zzNgUsMh649CtR+mY0oTGgLyhfRC4
         d5myezGEAdhjFTwoDynxFf7XiLIMQ2KpCKyb4yqEDaUgRywvHahnch18jI8QPWEVXn8Y
         UUOw==
X-Forwarded-Encrypted: i=1; AJvYcCXCoLKLi06mP4nt8XHNSPoNbo3NKn0cehz/2Z4gCGlvD6bAodzOuVCnxa+k8paquEolB4ne9k92LcRw5hLo6BtxMwpE3W+uSasQrC3j
X-Gm-Message-State: AOJu0Yz4uep0GJ9yNm+sGvy9kevHflfiOECMqxG6GKzBsbCFfmTgZwMz
	NXZGRfDTfRHIg9YSZMj7eL1d/aVJXV6xdit+pGHlsb8qirnZ5Bb36rTEhtChlb+4a1NNQQIXp4r
	4wx38160TK2Hvz4BCDDa9Luvbufc/Wsun0nx5MxkolMTD2vfNppA=
X-Google-Smtp-Source: AGHT+IGR9l1Bod7ozyRA9DgvlNkdzGA1VYqYrURigssymDliHRQjrvW1U1r6bS1AkgrgnRmDqNdcMtCOuIiDrMtJpWM=
X-Received: by 2002:a05:6a20:d04b:b0:19c:a934:a116 with SMTP id
 hv11-20020a056a20d04b00b0019ca934a116mr275041pzb.11.1707845866240; Tue, 13
 Feb 2024 09:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213145801.2564518-1-naresh.solanki@9elements.com> <7a687805-3c99-4e1e-bad7-f40ed06ea96e@sirena.org.uk>
In-Reply-To: <7a687805-3c99-4e1e-bad7-f40ed06ea96e@sirena.org.uk>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Tue, 13 Feb 2024 23:07:36 +0530
Message-ID: <CABqG17iDN4wtJddYOnCPYhoT0kVsTjZGEXKEzV9gSGbpu+r0Ew@mail.gmail.com>
Subject: Re: [PATCH] regulator (max5970): Fix regulator child node name
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, mazziesaccount@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,


On Tue, 13 Feb 2024 at 21:07, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Feb 13, 2024 at 08:28:00PM +0530, Naresh Solanki wrote:
> > Update regulator child node name to lower case i.e., sw0 & sw1 as
> > descibed in max5970 dt binding.
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
Ack.

Regards,
Naresh

