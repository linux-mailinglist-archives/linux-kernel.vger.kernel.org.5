Return-Path: <linux-kernel+bounces-107117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E15B87F7A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42741F23540
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6381150A67;
	Tue, 19 Mar 2024 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3k5dCtu"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411614F8BD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830538; cv=none; b=dXkqeEbHFfogLJSW+lMktO4kpLGP0A7gYOw1KlNo51WlkVjGYVk7m2me/FD602PWayRzTQTT4unY4bN/TPVTdwZ1o9Eh+Rx19we0uX7fJzqnNze413raDH1x5xBfDrMDO71Ed0QVLCj9mZ2QKNMwHBERldD6khJFY1dRJqeAnu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830538; c=relaxed/simple;
	bh=NjCclsKgamBj/oumWQvsgzk6MPjbrWJp1JAZ1wSEgoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpkFu4ulmEh2btloq4lJcEl5/6v9HezIfKaDpM0bYDSc2FcbCVRhEgU4QNjpqV4EqQCpsWmi3j+AJH+Cx06hiwX9jkQcajU+cfUNG4BXOVh4pm5eGw3DRtqsE6SCHvY9dg0IBH+aJYlbzIlvZPwx1kY3OY9TXCTcWVXAdUBudcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3k5dCtu; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so5703942276.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710830536; x=1711435336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjCclsKgamBj/oumWQvsgzk6MPjbrWJp1JAZ1wSEgoo=;
        b=A3k5dCtuGSj3RyEcQ522UdAK4nF8REhlirBzx8l2g66OudYAlqUSEiY95YiFPJTrlf
         vAjfzJ8n1xbzKjeFg24ErxABe2kpjxIPxxsSmtAUMreMctucW7LZMciSrf2K5IxG2MyB
         y3XLgrIA9gVfenZlrTnQEoRa4QfQ3V6dw811sqpOu4f2ysIorI4OfA5ZlEZ8/SOaoYue
         mcb+yeM/aC7rheoMl0xKPPA5zvr8LTyfAn4XWvuxHS43ZFm9ngXhppFIpdHCTrDF6JVr
         XUDxgOOpM+QOgwbckvupxlwjUmQRH7RkrgF8Mw+OExSAf5fdN1s20BHPsLTow0HPuZjL
         yHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710830536; x=1711435336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjCclsKgamBj/oumWQvsgzk6MPjbrWJp1JAZ1wSEgoo=;
        b=aWBEZRHV9SyCYftcrfJnz9zrYIah0FxbMYf77jutJwrfVsqYb4t5aTKgiyMehxTGKl
         KeGoovsuhUi/C11UwXl3/Yxku3q4GbLJMEZRiXkX9HL0t4sQhW1ICeqCEPYI3DqnveFF
         n1W6upqFrecWyKHZ7dBw63xbfVw/h67zglQFIJHY7S6ioZY4/EPEkq//z3CybbgRHRwJ
         ijcqCXjJ7ruoXkvsC1OrqFCzcSQ+xRISJo7aKbFUcWAXhb3X9U/huawzWRhK1CO/wxlD
         gBl4yx16MODsMJZo5my4AvTQQ4uHP/w2In1wKTJpp+NI6q1TI0ombxIsFIE9DhI6lPJ+
         tt2g==
X-Forwarded-Encrypted: i=1; AJvYcCVhze1LFFTyeAMRV/HbRBgSUhXxHV0rFNCAySzUWe5u4nj8hsNQDaR0H05iQTv+pd11qcTGBquxURy1+HFbM6UXOH4vI71m2SqC4E2N
X-Gm-Message-State: AOJu0Yy6wc0eqDXQqHHgVlC7P+bZGYZg569JmBNzaFpZ7zdDikj6Mj1R
	ceIOwlzd0mrE7D5BZA4KlPtR/26CBODqO05TVEcSpnDi4b5LeMIvbT0IZKuMZZS4ISKyvuZ/jhm
	EBnxkftjXm1D5+81f4VPXI7z/OGY+5ekxs+fRvS1N
X-Google-Smtp-Source: AGHT+IFQkgQWLO4YyYxqJiKAXRUVNmi3CyAl2nb1/6YLgkoNvFwF7RFaW4p1IIDApOescDNaAFK05HSkWbZsjmemulA=
X-Received: by 2002:a25:ce02:0:b0:dcc:623e:1b5d with SMTP id
 x2-20020a25ce02000000b00dcc623e1b5dmr970546ybe.31.1710830536238; Mon, 18 Mar
 2024 23:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315075946.587679-1-dqfext@gmail.com> <ff19df82-3fd4-9098-667c-0502b2452334@huawei.com>
 <CALW65jbKBUDN8ybE1oqrNW5VK1QGpZ1RmnFCCzxjQCo4obaA4A@mail.gmail.com> <e5c2c285-0b10-0d23-2c02-7582c026dbfd@huawei.com>
In-Reply-To: <e5c2c285-0b10-0d23-2c02-7582c026dbfd@huawei.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Tue, 19 Mar 2024 14:41:59 +0800
Message-ID: <CALW65jbQCvkpeoOv275jgQAHf+Tk3QBR0HdwdGhK3s7gF+HVeg@mail.gmail.com>
Subject: Re: [RFC PATCH] jffs2: fix recursive fs_reclaim deadlock
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 9:00=E2=80=AFPM Zhihao Cheng <chengzhihao1@huawei.c=
om> wrote:
>
> =E5=9C=A8 2024/3/15 20:19, Qingfang Deng =E5=86=99=E9=81=93:
> > Hi Zhihao,
> >
> > On Fri, Mar 15, 2024 at 7:19=E2=80=AFPM Zhihao Cheng <chengzhihao1@huaw=
ei.com> wrote:
> >> I think it's a false positive warning. Jffs2 is trying to get root ino=
de
> >> in process '#1', which means that the filesystem is not mounted
> >> yet(Because d_make_root is after jffs2_iget(sb,1), there is no way to
> >> access other inodes.), so it is impossible that jffs2 inode is being
> >> evicted in '#0'.
> >>
> >
> > You're right that process '#1' is getting the root inode. However,
> > lockdep only records the stack of the first unique lock ordering (see
> > https://docs.kernel.org/locking/lockdep-design.html#performance ), and
> > there are many occasions where GFP_KERNEL is used inside a
> > jffs2_inode_info::sem 's critical section.
> > .
> >
> Allocating memory without GFP_NOFS flags under sleeping lock is a normal
> thing. The vfs_write is an example(eg. ext4), page is allocated with
> FGP_WRITEBEGIN flag(no FGP_NOFS) when holding inode lock.

If this is a false positive, is there a way to suppress the warning?

