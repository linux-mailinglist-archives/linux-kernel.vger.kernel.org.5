Return-Path: <linux-kernel+bounces-83310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10E08691B4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B651C2352E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB77013B2AC;
	Tue, 27 Feb 2024 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P41mkqlZ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244E54FA5;
	Tue, 27 Feb 2024 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040318; cv=none; b=uv0GMVAYRD9h9pC5V4w1PyP6UfA/dIR95/vCW0gfaAo6P3pGvsoWulmiT7fvS1SlWSI1k0nSmAQjowmpd4iF8LCjt308scCD4ajNinVLpx1RTN+poI3NMlZNOfgM0ioI03W64sfj8POrlNXTmNU/Qg/tVw+fCpYt6KrjvOK44nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040318; c=relaxed/simple;
	bh=5sj9NXTrAoUjaPMj/9h4zOUnoupcAA5GHb0+0GioHCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6Sd4d4UhDpLJy6/4L6CjQY9bQfLl/Ii86INS2xAH0jreYSPFNb4lbSJyXpNDde5uVLIl496SzT5ij4YyGA1R0LGk/FqwIHjZ7KIChqo2nQClB5cTUAfFGFsagqqTzHVwhMidzveyCogRtjISFj1+OL3lynp89gn2Oc38x7z3+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P41mkqlZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso757832666b.0;
        Tue, 27 Feb 2024 05:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709040314; x=1709645114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mfy+8kAD4Sg5cY1crfDT7qIqsKPJZTTBHdCAQaHu3Q=;
        b=P41mkqlZ+inwX5x4hn86zkOs1SUlx8S2XkeEtvxHHC7CES/72E6qUlIrV2/d4jxvhu
         nfT73dPMEZLcIw2B3kQeQzBvAB2mRQ8PJvULYL+g9uU/fv9/gLEA0MSI+PRQAuh9wSGM
         hc9p4vUu7UvDREh0MFvXuh1iRe+xG4LL6gX1s9UseUFyC0tqCKT5ZmmzUW4Y0LFh/GeQ
         qkF3ZKfYMB8kpaS0MXH99SUGadNimYccD+VzRKSm5BLtrfPT9Mubl/qmbZh5IyFhGhSn
         AKFMr72EGY/IF3xvG4/Y/ea5dLqKjMNimhZyuEsiYz2uPsRGI20cCC4Ct6dB9cppZGhg
         ojvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040314; x=1709645114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mfy+8kAD4Sg5cY1crfDT7qIqsKPJZTTBHdCAQaHu3Q=;
        b=RZoI8uhjF0f8tn3nC6b7TEFOP/r3VRrQK9ynWfNDTY4I3vtZc9PUR4fIWsWMlQob34
         MKmOPb3p1XGqs1vCDIXMApB+tEnMej2BWFxaI8vS8XPMe9OZsNx0QIsQtBSYuvqh2pSl
         QElF1B2R+t81z7m86ut0YGQXCLdPLkaZsZ8i2bA768EoSDCPpGRzj281N7BIDnXgdox4
         sSNWwrBxs5hMeI/sryK9sIjeLmsSL1o+tg/DRHf46ANM20CAd0nUua34eVef4i4EXHGW
         bnD96T6qkjm/xinbE83OKT7C/TAlt4z/F8VcHrUTPCdpQgfC/tTl9ORgDZ5amK7Hwllj
         0MVA==
X-Forwarded-Encrypted: i=1; AJvYcCXiRugcD8T6ep/VQWVczvlzoBa3uy9Bs5gYQWW2u8VwIF4ZU5P7T+xTnFkuW8TqOUKk4FDiTaDJfEtGTV+A0e42Ttd5qqhPaj6a
X-Gm-Message-State: AOJu0YzKopR3r3XVa+wl0xbwa/nA+Wgper/Rh+6K+jpf/8/rYHlhqQNF
	npOqAyAqijfYNXzMfDb7wA0zN4uwzVp98FM23jEFViOP6vnm/WDac3lZmu1BHSYsPHfC1MdK4ig
	HOYQwjOieGo4pliQ6SyuQ950hPqE=
X-Google-Smtp-Source: AGHT+IHE4znenK09HkV6uURTuS9RBcOY3Hyzi9IIvKhH5QUyp/hHFLNoRLipHmm9xrihLpAqOjyebro5LUqfP2wuiDA=
X-Received: by 2002:a17:906:2417:b0:a3e:ec63:8fa9 with SMTP id
 z23-20020a170906241700b00a3eec638fa9mr9324108eja.16.1709040314372; Tue, 27
 Feb 2024 05:25:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227131410.35269-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20240227131410.35269-1-lukas.bulwahn@gmail.com>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Tue, 27 Feb 2024 14:25:03 +0100
Message-ID: <CAKXUXMzejT7++UgpgE_eHbXTC+w0cz2-sPr3XawV6N2mCkupgw@mail.gmail.com>
Subject: Re: [PATCH] docs: drop the version constraints for sphinx and dependencies
To: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Akira Yokosawa <akiyks@gmail.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 2:14=E2=80=AFPM Lukas Bulwahn <lukas.bulwahn@gmail.=
com> wrote:
>
> As discussed (see Links), there is some inertia to move to the recent
> Sphinx versions for the doc build environment.
>
> As first step, drop the version constraints and the related comments.
> Then, the sphinx-pre-install script will fail though with:
>
>   Can't get default sphinx version from ./Documentation/sphinx/requiremen=
ts.txt at ./scripts/sphinx-pre-install line 305.
>
> The script simply expects to parse a version constraint with Sphinx in th=
e
> requirements.txt. That version is used in the script for suggesting the
> virtualenv directory name.
>
> To suggest a virtualenv directory name, when there is no version given in
> the requirements.txt, one could try to guess the version that would be
> downloaded with 'pip install -r Documentation/sphinx/requirements.txt'.
> However, there seems no simple way to get that version without actually
> setting up the venv and running pip. So, instead, name the directory with
> the fixed name 'sphinx_latest'.
>
> Finally update the Sphinx build documentation to reflect this directory
> name change.
>
> Link: https://lore.kernel.org/linux-doc/874jf4m384.fsf@meer.lwn.net/
> Link: https://lore.kernel.org/linux-doc/20240226093854.47830-1-lukas.bulw=
ahn@gmail.com/
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Oops, I was a bit quick on sending this out, I wanted to add those
remarks for the patch discussion:

This change seems to work for my setup, but I have really only dipped my
toes into the waters of this sphinx-pre-install script.

I only dropped the version constraints, but possibly one can even drop
some of the packages in the requirements.txt, as they are pulled in
automatically by Sphinx dependencies.

So, I am happy to get your feedback, but I am well aware about its
potential to be improved and the lack of my deep knowledge about the
script. I hope, though, you can test it in your setup and confirm if
it works as expected and then we can discuss the details (e.g.,
naming).

Lukas

