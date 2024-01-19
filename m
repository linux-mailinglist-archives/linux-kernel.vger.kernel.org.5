Return-Path: <linux-kernel+bounces-30722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092BE832389
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385931C2262D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323A21870;
	Fri, 19 Jan 2024 03:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrB8UTV4"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F4138F;
	Fri, 19 Jan 2024 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705633344; cv=none; b=LVCoehVkq9q9bpKVd2vs7wzbS0A5KU2Q2cyPfAaI3g2mlacewT2Fs9YqmUzoHSYX0zFxqfZx7mYyPofOU5go+UaZtvECi6QEt+/lYvtKq0kOLLxvnfGXE9agEpVmP+zXPWcHQqdbe/mskF1ed1/4Yu9ufinRG5iZY+DByz+evEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705633344; c=relaxed/simple;
	bh=oUJxG83KMUbt4dCXkDxt7l4cI50LzKxgafl4u4YyKSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwKQp/Rd85E3NFpL0TjRbY/rjtaybVKI9AhdTca8OMg8FFRTrnZs4EKy1aCWz15wJW6xqo9muaVoUbFXTWn6qALq33wIpW6SuFXcheSlreZGAPioXvpmfUGRi+z0bRlD/fqjK/oCXwa2Wfct5bSYLdw3eFXX9C8K11NheWJAS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrB8UTV4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e7c6f0487so296373e87.3;
        Thu, 18 Jan 2024 19:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705633340; x=1706238140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q66bntN7QSO/os9dzasJoSSuv+HLCYEBJBs3UyFG0Ao=;
        b=QrB8UTV4cfHO1bllEUGXqPCqvcCW4mSd97ESPlSwZ+7kjfKT/iM3Xzd+ZlX0pjblVu
         UIN1olyVdl0/l1EUp/YUuOxJaS0jtlNY4vaNCgfvjPqvP9TrgbCIObgLsQCE3nBxTvex
         Q/WqCvCDV/15OOMfGqeU3mGL0qLZal8h3ZhXCDq5Atllb2Y3owhx7KdjJvw6KJFhms/0
         KXEH4cn7koV5mELosvrAciCGtS4eX5Can2n1O79zsHE5j0rXVuMxMLMvBqK4LCS6wpzQ
         v1y3Jj4muH1r3QxyrzCUnHaANU/zneW7xOaYOkGdTf3cGBkiIv4iCztVz2UkZIx25otD
         p4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705633340; x=1706238140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q66bntN7QSO/os9dzasJoSSuv+HLCYEBJBs3UyFG0Ao=;
        b=MTPSKiH9ssjQ/JPgVrJ+RDX1oSzkDxfBJazwz9rWzBwd2r6nOotzvsanvYJOCxAhCp
         FLU2OEFKp3WZAey4LN4VDXAjHjO0aE4K2T3Y4sC2wnEgCCAfcAztO5WblauYCAKxjIh7
         BYNRJwirdfovaSoOVdIa/mOqxU/gKiruQDGPOVAjma/ASo+h1fawz71PSceGU6FReIGX
         /6HRraow+9N7btsYoOC06uP6lmjeecuIRXeEZ5hxUZsh/TSEEM8gBsTEaUbb7t63iTKu
         AEqLGw7S4EfWxqocjGOHetAh1/KDvclGLkeXZt5GcIs8YlATMnHkkUJ9UabATIi+Qypm
         IYVg==
X-Gm-Message-State: AOJu0YwIPtDbJ9O7/4Vs202LwF1WySIz42jiLczq8CEY6V2bCwJXz5Bi
	uvfesaH6NVYNyX9CBYlFl/uh2wZ/LhainRiXSWCZTPw3maGhwVGHCtps4xTn7VFaXLMeKAITv3U
	H3qEibJSu9w6nWmT1qPDcrqJ/tnI=
X-Google-Smtp-Source: AGHT+IEd7MwUOENPLVCvF1ap8TBBFmbGRmlOWO1crHTJetcfbl7r8XHGJuGvyNHne7uciIfOWBUe2Mr4IwccyXG2gME=
X-Received: by 2002:ac2:5b5a:0:b0:50e:a9c0:70a6 with SMTP id
 i26-20020ac25b5a000000b0050ea9c070a6mr206568lfp.43.1705633340309; Thu, 18 Jan
 2024 19:02:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119124715.7be9a3d7@canb.auug.org.au>
In-Reply-To: <20240119124715.7be9a3d7@canb.auug.org.au>
From: Steve French <smfrench@gmail.com>
Date: Thu, 18 Jan 2024 21:02:09 -0600
Message-ID: <CAH2r5msKy0t-+s0c7HOxK2RzpSHE65itLH7YNhDFzZpRheAxZA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the cifs tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: CIFS <linux-cifs@vger.kernel.org>, Steve French <stfrench@microsoft.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

fixed

On Thu, Jan 18, 2024 at 7:47=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> After merging the cifs tree, today's linux-next build (htmldocs) produced
> this warning:
>
> Documentation/admin-guide/cifs/todo.rst:7: WARNING: Definition list ends =
without a blank line; unexpected unindent.
> Documentation/admin-guide/cifs/todo.rst:20: ERROR: Unexpected indentation=
.
> Documentation/admin-guide/cifs/todo.rst:21: WARNING: Block quote ends wit=
hout a blank line; unexpected unindent.
>
> Introduced by commit
>
>   e7dccb219fde ("smb3: minor documentation updates")
>
> --
> Cheers,
> Stephen Rothwell



--=20
Thanks,

Steve

