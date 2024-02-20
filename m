Return-Path: <linux-kernel+bounces-73476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013D785C31A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E02DB24C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E451E7866C;
	Tue, 20 Feb 2024 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ab81jJE7"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE8177637
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451751; cv=none; b=dZuxcf/H2B1JOpY040gs2IXCIoX2NTbohU65irPWOKuPUc1BkPb6akI2JqjHAvfoR55FbweIsLvNm1PbLvmUgzqGeK1zrubZrH+ogWXB71nvoPzGDqD3rRyUN/+9IwwiqHscdjtka293hR6FELOzwnYlIcZCEFgEf4HLwRlqi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451751; c=relaxed/simple;
	bh=hqb1KpK8idTkVHw05D9DaOecFdA77V8n0hYYGqZ4o2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qsUQN1CTyB76sfwuVnsClpyfwuq3bxvBdZAu2LMlbLLv1lH8sO7+je3eXjw3R3syBl502OcfdeRJhThz+IHbaJMagjB58082FMOl8caPHyXQ+4v3CWSFGcg8pR0yBOckCJl+zGqTv8YSETXlJqyiQD5YWmI0CCL2pTl0fvJYPY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ab81jJE7; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so7735350a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708451747; x=1709056547; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cs7a6JxSri8UPMBfIFAC6zzBgd9E4B30piovcQly+DY=;
        b=Ab81jJE7kpciDnJ5EwJA/C9473hy/PJMieFJXVoELmOQlHN1kdZlXBvBYeg2yMEo52
         g+epCK1CX+nDxaDfjoUwaKrsYvPUvFx4APPM2hylpTX4ZmOcQrSh+a49/xP4JllLSA48
         zGk7z6o9SYtKONS0sKuhAc8IB/5+tLtazoVno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708451747; x=1709056547;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cs7a6JxSri8UPMBfIFAC6zzBgd9E4B30piovcQly+DY=;
        b=GCr1CVmMJHom9HMv6T8qHSiU8lwfvYTyWfeQr0AtnY1hFohKCt9xeqDPHuS1jf6Wt0
         XUlyGoZsfrungLExZRAlzj2itnXGgBOq4b4rqdmA4c8z2VxPHhcfw5LaCxNU8CLwme57
         +41kOGEWj0S3iq8iimQnhwRph+nrmPoFCRY9QWQ2CYcib/57a5QQaRHfQUBkEHp61m9q
         rzfCQipIjgT84jtN1+1207+p8rDdGZC62SjdUWN7By4ezzJa5e6o9Aeim7qLHNBuGP6Y
         1cUv8M/HnSKPwKRhaTM8kv7uhCIwtkdb4EkpRITm/2pY9qUwmcmisG24FadhV5qsXBM3
         IYpg==
X-Forwarded-Encrypted: i=1; AJvYcCVjp2bsQiqQ7gfQV+vkESlixFC/IPSckn/Y06DN1FCSTAltok4+U1RH2MjpkF1zlLohaxBs1QkgPpLT5y3ho81dK82B7ze8AVV1x+3D
X-Gm-Message-State: AOJu0YyB0LvRbB7iU4KQ33M7RgNekaQM9FyBy3xdogAI83uSR+Ly2bcy
	i36pgIG6+YPi4/4QIBtfOwixDf9auCvjGdLdARp3XLY4zpnnIBXxExSwe8RBj91e4wM0/E7OeE5
	pxauNuw==
X-Google-Smtp-Source: AGHT+IFcBhlYs5guky53suKM++T6S5sbw8fD5UQpAzhpVJPFnFEMD9t6P3PMSV6ehzfXwSEvTJIrhQ==
X-Received: by 2002:aa7:d595:0:b0:564:405c:dfa with SMTP id r21-20020aa7d595000000b00564405c0dfamr6347428edq.17.1708451747689;
        Tue, 20 Feb 2024 09:55:47 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id e14-20020a50fb8e000000b00564e1b7754asm227238edq.31.2024.02.20.09.55.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 09:55:46 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563e6131140so5488458a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:55:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQzHGE2+RfAjdSCg6xvybw1yJ20WkLqMaeBz4FJXGZXRaYZEDD2ZLmyjOj0WZ9ZI4xC8jabf84+ZnTJabMVGC8XsIdmEEm8b6iGEn2
X-Received: by 2002:aa7:d393:0:b0:564:3d68:55f5 with SMTP id
 x19-20020aa7d393000000b005643d6855f5mr5518556edq.5.1708451746591; Tue, 20 Feb
 2024 09:55:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-6-tj@kernel.org>
 <bckroyio6l2nt54refuord4pm6mqylt3adx6z2bg6iczxkbnyk@bb5447rqahj5>
In-Reply-To: <bckroyio6l2nt54refuord4pm6mqylt3adx6z2bg6iczxkbnyk@bb5447rqahj5>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Feb 2024 09:55:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=whqae-+7Q7wbtnEj7YmR8vsx6skTj6j-srV2Fz7cBZ2ag@mail.gmail.com>
Message-ID: <CAHk-=whqae-+7Q7wbtnEj7YmR8vsx6skTj6j-srV2Fz7cBZ2ag@mail.gmail.com>
Subject: Re: [PATCH 5/8] usb: core: hcd: Convert from tasklet to BH workqueue
To: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org, mpatocka@redhat.com, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, msnitzer@redhat.com, 
	ignat@cloudflare.com, damien.lemoal@wdc.com, bob.liu@oracle.com, 
	houtao1@huawei.com, peterz@infradead.org, mingo@kernel.org, 
	netdev@vger.kernel.org, allen.lkml@gmail.com, kernel-team@meta.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, 
	linux-usb@vger.kernel.org, mchehab@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 09:25, Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> In the past this tasklet removal was held up by Mauro's device not properly
> streaming - hopefully this no longer the case. Cc'ing.
>
> https://lore.kernel.org/all/20180216170450.yl5owfphuvltstnt@breakpoint.cc/

Oh, lovely - an actual use-case where the old tasklet code has known
requirements.

Mauro - the BH workqueue should provide the same kind of latency as
the tasklets, and it would be good to validate early that yes, this
workqueue conversion works well in practice. Since you have an actual
real-life test-case, could you give it a try?

You can find the work in

   git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
refs/heads/for-6.9-bh-conversions

although it's possible that Tejun has a newer version in some other
branch. Tejun - maybe point Mauro at something he can try out if you
have updated the conversion since?

                Linus

