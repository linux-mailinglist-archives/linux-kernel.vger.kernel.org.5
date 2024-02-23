Return-Path: <linux-kernel+bounces-79142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC5C861E23
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5941C25190
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7458314CADF;
	Fri, 23 Feb 2024 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bLBv3fYJ"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1BE1448FD
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721293; cv=none; b=dg1+Igl6qPaSmlNO6CjXbMJasaWnnUI8EqGkYR9ldcDoJI5eEJyPY5Cj5FfJr4TapBJlNL1YvCGTZr8UJ5ArDyzJ7KWRnaWkb/Q0wfEwsp+Ynmi/31mMjn8SbPv4zAcQeAqshMWNS7hkMNWfS9Y+Nch7mxuduIeYQ5c3I7E1upE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721293; c=relaxed/simple;
	bh=XrIweBt1xAeTI+DcqMD36fsii+srzNHP7jHLCDfCPsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reTmpSjCRzY/VqTg0pOhMx10d1Yj5el0OtgzSckFgG3Gk1a1MUhn35TD5EqQ3/81ksk8SN58HjH+IczUgM+aN5swED530SFGD4fl0b4OWQ7UjaBzkI+cWFPG3S6BmRkSBRpXrhKT2wG05GwfNbGhT0KrXFImBumEePEbZ4rJs3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bLBv3fYJ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6087396e405so6789847b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708721290; x=1709326090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrIweBt1xAeTI+DcqMD36fsii+srzNHP7jHLCDfCPsk=;
        b=bLBv3fYJELOZ6nfGWoobO0anvO1jTjRBdTd2oTf/gIyOGKQst9Uq42SlO1Wu5izh8w
         5EazRfsfXx9H0Owe+vMv4NEDOMfS5SLY8Qik6ulvw4UyoYqGsJbnBcrzXVfH6ixuSAk3
         bhdbjzSt6P7jDIvPggMXzq9RFeD2i1ROAOmcZhTU0YZM8AqD80EO8M99nUzDdUsqJd1e
         RIAFE9CBKWelkK+Y9m+O19AOaqzdYzVyd0o+/u5aFKwnOpSCERJddy/pmhfLO0B8214t
         mEs2lyznZZZxzNf6CZq5X1XZzK1USZCCcVtQaJ7LRc0xS/RNAbn8KC0o5PXKStetuwR7
         Xf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708721290; x=1709326090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrIweBt1xAeTI+DcqMD36fsii+srzNHP7jHLCDfCPsk=;
        b=JoVhD1rjJHfcQoyxgqlylqKujPBLAT5KCuYxyMxaaxUUCiDlhtosxtsa464YNsMxYc
         We3xfcqk/iEhOa8JSHqniV9XjoM3TryyRnrYZ/ax+WRmZASG8guQCCfzeQmHP32drBxB
         EKy8PbUgC6WBxHTa+hGu7TNbTS84bxs9TvNbbN+I59ZVqR3FpXPYbZgLCvfiT1rLLeJB
         a4oEa/WuQQ5ER/ixCJxPa7QWFCgcwpI7/EpSagtEdJXphrvxTNjSP0qj3Fe6mM/NqnBp
         HY7wAdybwoOxYDACOCSGVq3rec0l63p/xA3O5i18ou2jCbVJGcfu7OnaR6yhQtuhrMXT
         2hWg==
X-Forwarded-Encrypted: i=1; AJvYcCXWSOOyNaEOVf+H53lpTmlhthu1m2qyOu1P+RYgaAIxa747NueIEfICLUvX3teMFkcuzy9FdwwM8/CdD9DBQlX2YrtUY9PujfrZ7s2g
X-Gm-Message-State: AOJu0YzJ8nJovZrWPnSwnMn9mIP9TXMoWMdcZscRQodM9hfylVcmPWdi
	PpiEn+CSvilzFKbYRPcInq0UE+2ihSC6hdWyHhpaqW20bVA1UtO4C5/jJ3m1EObHogQ2qvZoAKC
	OV3iz6kxUKmxT3MVmtofaTmAt1Ey3rfC5VhV5
X-Google-Smtp-Source: AGHT+IGupIAFw7nMLiV1//RpofK99g5hxlJIZq7LOh30Kty2WViyFfQDmsNjq2ePE9NcWOZZ8IBp5gns5fSynhBzG9c=
X-Received: by 2002:a25:6642:0:b0:dc2:4fff:75ee with SMTP id
 z2-20020a256642000000b00dc24fff75eemr837275ybm.3.1708721290133; Fri, 23 Feb
 2024 12:48:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223.iph9eew7pooX@digikod.net>
In-Reply-To: <20240223.iph9eew7pooX@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Feb 2024 15:47:59 -0500
Message-ID: <CAHC9VhRpE2rFya6t4p=sUUbpUzDw1cYWQq=UX4cYJQwNkNnvfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] SELinux: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:17=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> These bugs have been found with syzkaller. I just sent a PR to add
> support for the new LSM syscalls:
> https://github.com/google/syzkaller/pull/4524

Thanks :)

--=20
paul-moore.com

