Return-Path: <linux-kernel+bounces-130110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B644897430
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9271C2469C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4114A4CA;
	Wed,  3 Apr 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j51gbiUb"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BD4148FE8;
	Wed,  3 Apr 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158837; cv=none; b=ar1lCuvfR9IbpgvN36uvEUzAfQSTFYE48pXS7+cLz9LkeFgTdwZGi+ZRvxRzYAOSLqWaZMduf1VH45ENZRzcnOMKEYyH5MINazXbc7b0vzCdfn2yOR4MCtWRsCb9nS4v7k0nnOJLBefoJ+ZVmOxeVeIQOacSvVfdJNy+ZVkXtbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158837; c=relaxed/simple;
	bh=iwmjTT/6rEUQaG5l9ogq24KennjjjlW/3aoTHTjys/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJakUkJ+vSKxvAhAW1vY0gmociF4buCdUSIKyn/J8aDFWOp0SPH08rKNgrHYhY/m6CsF293BFVyWWPJMTTBqHbqgOF3Y5Q2w6ajV3tNkwbf2kE4LWbL72vOfJwLZLe9ztG24J+i+OKgdBFEJpeSsWqwVHXgdlyzmUc5mkkyss1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j51gbiUb; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-476cec93716so1960937137.2;
        Wed, 03 Apr 2024 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712158835; x=1712763635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyFZ+qeRNtDYji6u+zsHWjmzts/cBXhgw6vv+4+a4/I=;
        b=j51gbiUbOdIsDiCnCS05iT6+MwQm0WUbCo7TEoVGn2CviSWnIqboWyjyoHH4zHKg+V
         OhbRt7qDmimepmAIKjoNLx2mI7WorF7H+ig2sMFNEZPZtiS2Ocanr5gnmcVX2lRn6AS+
         3VqhMi/v6beuAJazyS1meP+QdyzMN1vVWQ75zhsDyRjCO8n1wjdcgsolIjXtmzV+rRhf
         MScZjxNDxbf9x8z38Dn1VQJbxC9u2Exu2RmHww143h0x/OV58jqMK+G3AGbBfJrbVOSt
         HPKf6FeghND3SDCisKU/SgIqWrHuCI8JSHDnEhXWMvTCd6YXPSFFXpfzRgABoQuDYcFy
         ADew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712158835; x=1712763635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyFZ+qeRNtDYji6u+zsHWjmzts/cBXhgw6vv+4+a4/I=;
        b=gFezZ8omN4BNHzGevXQ+eQw4kd9lW8mtTkP6YhxswpJNFTodJXiSoNULJxFVKYckrd
         B+ZpVT5K2HC2f8iYgl4CkL+YRpA4P12XEzzjpX/X2XLZl9a7JoF+mosnr1iLKFwMGh1s
         vBom4tcV/f3eOFHzBPirllcGfk0lRpSn3vQg0NHHkAaB+NipIZgDziEzWEBbnrcyjfUW
         49vvoICBS0/RpnvNCiwnrYp0Cp4zNmAfBnTpJD1uUtrHTF9nfKlmKhQ8KPj0QLVlFRqZ
         lrksHv7fGM/kaijohTkJYAMGzzkE+QJW3KOb5/QFOcPenxLrc9xoQrc4TSMmXXpLwlPh
         OQEg==
X-Forwarded-Encrypted: i=1; AJvYcCX4LgWsLrXck1fCy81iDsuUBg0MIXIdc2YFGDo2pasL8VqdzxUYah7PMmelDisOzJnTyJnYmuVbuQN9YEc00v2WlIZQERBeERqOXBbhIvnViKKGcdNEQtPqQBaGJ02Ft4YxLwO7GXeo
X-Gm-Message-State: AOJu0YynCP+XMroFsQkM1phdIDRiqQJcIK66VSgSkFx9+AkPHXvl6iVL
	MfT1tr1aNn27uXKEKtIuHL4H8LswGbTUsqsi10pVcFDALHrHBmi1qJPqDQ6gzzKIh4FPPBAGXjs
	kc0TkgaSe7BLKDG3no0pKOJ6on/w=
X-Google-Smtp-Source: AGHT+IFFn7bvTeZOH9kjBg5JoFvzOQY0G6JUyk5XmsTPCIgTSDqlT4WG3B5RcLFYTdJxFWbOJpzWbXvBOh6LejVNhuA=
X-Received: by 2002:a05:6102:5124:b0:479:b553:ce16 with SMTP id
 bm36-20020a056102512400b00479b553ce16mr1935617vsb.20.1712158834832; Wed, 03
 Apr 2024 08:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403143852.13175-1-apais@linux.microsoft.com> <2024040314-unbuckled-botanist-1afc@gregkh>
In-Reply-To: <2024040314-unbuckled-botanist-1afc@gregkh>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 3 Apr 2024 08:40:23 -0700
Message-ID: <CAOMdWS+Z1ZS2VPBXiYbtOyYBuCCx1i8M1aVMYHGhMRTv259xaA@mail.gmail.com>
Subject: Re: [PATCH v2] USB: Convert from tasklet to BH workqueue
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-kernel@vger.kernel.org, tj@kernel.org, 
	keescook@chromium.org, duncan.sands@free.fr, stern@rowland.harvard.edu, 
	mathias.nyman@intel.com, oneukum@suse.com, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 8:02=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Apr 03, 2024 at 02:38:52PM +0000, Allen Pais wrote:
> > The only generic interface to execute asynchronously in the BH context =
is
> > tasklet; however, it's marked deprecated and has some design flaws. To
> > replace tasklets, BH workqueue support was recently added. A BH workque=
ue
> > behaves similarly to regular workqueues except that the queued work ite=
ms
> > are executed in the BH context.
> >
> > This patch converts drivers/usb/* from tasklet to BH workqueue.
> >
> > Based on the work done by Tejun Heo <tj@kernel.org>
> > Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6=
10
> >
> > Changes in v2:
> >  - Update code comments and commit message.
> >       Suggested by Greg K h
> >  - Retain local variable name(hcd.c).
> >       Suggested by Alan Stern
> >
> > Link to v1:https://lore.kernel.org/all/20240327160314.9982-1
> > -apais@linux.microsoft.com/T/#m2ec7868fbf102f1551ebe4c92d200848b94af3b1
>
> Why the line-wrap?
>
> And v2 info should all go below the --- line, right?
>
> v3 perhaps?

 I missed that bit. I will send out a v3.

Thank you.

