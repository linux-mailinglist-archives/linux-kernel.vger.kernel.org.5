Return-Path: <linux-kernel+bounces-77593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AB08607DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C9B286ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57808831;
	Fri, 23 Feb 2024 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tlNeJLI5"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4D82F93
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708649180; cv=none; b=FjGeLU6Nel5uiSPArNYYvdypcUqNDZqJmyAj6hh5ilyMaZjx30kkrToH24xYFVl7vm40+q4cBv8TqDo9pJe68PGLlFGhlP/TB2iA3c153d+xuAwU5lhatrgqYNCKsG1CaGpG7uNqOX0XosVadKUCY92BDGqSUds+NOId+7KLKBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708649180; c=relaxed/simple;
	bh=C25cIhRPXZEop/idW0mv3T9lHSyIpdKsR2QRpm0mgDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFwm7ssYtZx1CHW9bVUCuVSHFJUPqCcHlX+zxdifGa6w4BT6V6TVaYmjee0wVwb/Eov0/zxmG09QPdMyDQs8Zhb73Zc3Q85Y466z3O9jvBxIzap7JNwYmL21ikxvhXLuLLNxm+kfjWr2kI9o1CY6EGg5H0RcgAJgAxqcju3KPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tlNeJLI5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso2748a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708649177; x=1709253977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C25cIhRPXZEop/idW0mv3T9lHSyIpdKsR2QRpm0mgDI=;
        b=tlNeJLI5xRsplB+orlFeqjUMNDb7SYmL9SMhtjZ0Dazx5mfebGNmf1fhCjYo7w9ecM
         at57Prjn12YcE42wJGyb2SXr5xLq6HwJZskut0oOdcRGLdGsr2lKGlHx8qhnrEJvqO+5
         GpKB0RebldT8OEMleKPSuHQT6cqUlvOzedJcVImMrOoI1pW2q+xZsmuT7DEd5/oUyVLg
         Um1DqwowfZVUAsOuhrjQsW48AJ3FD0L7/+HlB7JiWzV+RDX5uqxolcYMNQe9x63n5PLX
         0m3Kwz2hVs0LNChls0zMD8mV37MiwcdTtTBe2hJYc3XZtvrWtxaYrrXYy5UYt0ku9eF2
         7UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708649177; x=1709253977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C25cIhRPXZEop/idW0mv3T9lHSyIpdKsR2QRpm0mgDI=;
        b=jpNPMQX3yGo3XqA2aKr3uyx5bHj0lVkaQnGTeDlj5fWmfOb9VSnkep/3fIC7aL8AK+
         a8gVATuRQGI6NVMbgnA5fy26UTQyc0rfFxlSv3lyTZohw3a1KiFYn5mIVEqEZAJBLYg4
         xlGUrflvgc5jDgv63h2heDsP4W8qAZJGOPwbFlhUfczjdMiLBtAwMB2+Wd2i5vGgV48D
         ULzPfyNhmKnE4FZyphvWio0ESZXsfmdzFzjXCERwtJ6tsnMNbWyZv7OK+GRQ2TJqCXL5
         lMWU9c2x842A97Q5YljXBlflgJ5+pjf7oN3DA9pVXgFqpRb1VoNxXVs8wjhKGVj2vS5e
         4d0g==
X-Forwarded-Encrypted: i=1; AJvYcCX09UpR+nncauRNvpyy0jFa+MXer99iyNo52GckRjXyNnKE4+6jifub/5NnNsLX1sj6iYIe7OJSl6hZ1Yr8gH767Te6zLnBN7sFoPdZ
X-Gm-Message-State: AOJu0YyqbaLwPhcWSxxsIS2BmigTAKR74IcQqi8vDbM62lRY5200LuJp
	Jv8Yy6RGwAufASOkaxnpliaUF7g4rwf3BZRLXwha1p1aLT+D7R5VPADh1YcHYLFi6MxEUf8KUaj
	oXZJPGvpy3D2x1Z/Kp9wzY93KWseS2w03cLJr
X-Google-Smtp-Source: AGHT+IF06FfZjUhktgq4odIGoNq80wSSTkBZECuCa9hH47QEIXbjRhMD+suig1lBaI+yXzEDyb6YN0TaCTvsO4qYoLY=
X-Received: by 2002:a50:cdcc:0:b0:560:1a1:eb8d with SMTP id
 h12-20020a50cdcc000000b0056001a1eb8dmr505833edj.7.1708649176432; Thu, 22 Feb
 2024 16:46:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222051539.3001988-3-saravanak@google.com>
 <20240222051539.3001988-4-saravanak@google.com> <ffec7c7b8eb86f573e420e0582075ba1e75d0e54.camel@perches.com>
In-Reply-To: <ffec7c7b8eb86f573e420e0582075ba1e75d0e54.camel@perches.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 22 Feb 2024 16:45:36 -0800
Message-ID: <CAGETcx-mNt+_ST0opQ=_M1ZJK1acf8Rr0VqaAUskyig5YwL_dw@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkpatch: Don't check for unified diff format in
 git sendemail headers
To: Joe Perches <joe@perches.com>
Cc: Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:54=E2=80=AFAM Joe Perches <joe@perches.com> wrot=
e:
>
> On Wed, 2024-02-21 at 21:15 -0800, Saravana Kannan wrote:
> > When checkpatch is used as a git sendemail-validate hook, it's also pas=
sed
> > in the email header for sanity check.
>
> Why?
>
> If so, why not use a front-end script to stop/remove
> the file from being scanned by checkpatch?

Sure, I could do that. But this also makes it easier for people to
start using checkpatch. Or I can put up a git hook wrapper script in
here for people to symlink into their .git/hooks that does this.

I'd prefer the lazy route of not creating a 1 line wrapper script :)

-Saravana

>
> > These headers are, as expected, not
> > in unified diff format. So, don't complain about unified diff format fo=
r
> > these header files.
>

