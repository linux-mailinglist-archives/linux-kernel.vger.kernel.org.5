Return-Path: <linux-kernel+bounces-163865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86818B74C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699DA1F2264B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB57134411;
	Tue, 30 Apr 2024 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiPVix9N"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C3212CD90;
	Tue, 30 Apr 2024 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477539; cv=none; b=eXyYl6whfNIPnLkmG3VjEHS1GRNAxEh1pZF2zKcDdFxYz7Bw4HVOSfJhiVcKvazp+IucetBVcUalvqi10xy7/vzxVoYdjNDgN4erVIidYP123PrxsiEAkC5Jjdk5RuDbVgrxTEIAEcUrZcEHjEVgKOD/nG53dljRhDbsOCRRHqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477539; c=relaxed/simple;
	bh=LMWMwIrhoja/mjJ97z4DdQVv6xt1vL+14RxvDcfeu+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6CyYpeqUx+RLwb4MN9WlaMem9mtmy6H4mBPUBsSCYaMgm1W+B6iEcJmYxZonqB/6kqAj+mfkEVOlyK6xR9j8Q0Fkqo3EqM06R0yrs3poXwpUOb9s/V52ZlXqbL65YLIwKOc12vumtAm+PA79cp1iuJGusp47tQcpkMN6mg0ReA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiPVix9N; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6181d032bf9so52865407b3.3;
        Tue, 30 Apr 2024 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714477537; x=1715082337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMWMwIrhoja/mjJ97z4DdQVv6xt1vL+14RxvDcfeu+U=;
        b=PiPVix9N1yb10opGXeYCroy7n8EgyaLrdYQeB0gjD0uLq4maw3uMzBkT2SfW6xiuI0
         E1iDbeaaOZaNDN18RpITglH8fQtraPjjc5frwA1XO29QAGuxPg8iV/2dKkRXX2nSKo6Z
         NZgbksvxUrSPVv1TNvlfMGUAoCqWqWUBKmJDQtNUMi4IYbpOWccbnZOZVyJh8e0dd4V8
         b9ltfQLnrhl6h27IwRSOCN110VZYiynb3r8ZCKpv9xkkPk4OhjS8ty0mU7h1EXNpoGUZ
         j5VSNSEApw7xYF3YqgIa5ZG/wdFdBXP2wqQWZzQj2Pfty0j1tbsgLHYTq8famibG9ikx
         3NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714477537; x=1715082337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMWMwIrhoja/mjJ97z4DdQVv6xt1vL+14RxvDcfeu+U=;
        b=wPqJMUT/eZFvlZDFQSLY8kttlqGHtK+5l3Bz8O4Qpjyn7YQNeaoE+V30GWcjH9jlhI
         t35LXoZO/oAzKQgBxJxXLW11iqppkltes1hbEUts/M+jcoZkig0gMs4Ftp6vR0ItAO0S
         eWpD4SnM7dDENn+O/si7qJm/cjGtTKFcWFHPeB44rn12v2PRC3019DSUe0ey9BbHOh1d
         7BK2hd4lBVHZtrxPxh4GXb8oj0j+nC9oVpgPygRlXkRT4d/RlA0f89DI+4P0lmyJ6QwW
         GocN6exZ6JUn7m6//39hXwqX5PDGGkl3sFvT0uusPd+zL98YbA6zPRhIIZgGQG/bFPbp
         vvoA==
X-Forwarded-Encrypted: i=1; AJvYcCU8zKjoOoJLCNyvYOuhpbrFTycGOese8oMVZp/iZRkw8R2JR9Qg0k4ZLywok1h2/SZy78cFLQZi9DmW/3l4xvWWBh/AKjScKQw/H9GDDrxQRe3tqS92wv4UzZlzBGeukfSn6Xo9K5P87rU=
X-Gm-Message-State: AOJu0YxkQ/ngkrVKk6ATdeNOOZW2Uf9SP18vAjjYDow6kANGoBNKQHe7
	uAT7vUVDh5+ynhr5+OwOeYsmbB4FPVyTfMCTeC3KChIVHu/RWlnZ5rW3MUjfkm1+CKWaySdPbWe
	KGab9abK5I0alwZMWMtfv4avXJNQ=
X-Google-Smtp-Source: AGHT+IFWLTsceRYhi9/QmpyJz0woosjkTHL1KGvFF1YijYKO8GYKfCOxMxGlv6J7qjRlI6WEtNMdz4TuS1BN+EvgbfE=
X-Received: by 2002:a05:6902:2304:b0:dcc:693e:b396 with SMTP id
 do4-20020a056902230400b00dcc693eb396mr14627529ybb.2.1714477537033; Tue, 30
 Apr 2024 04:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com>
 <20240418160652.68df1a86@namcao> <87ttjywxv5.wl-tiwai@suse.de>
 <a7843657-c3f6-4d2e-8c36-5541d4c52956@gmx.de> <878r19voks.wl-tiwai@suse.de>
 <5febb249-1d4d-4ea7-b031-1df4d14620d2@oracle.com> <8734rhvlr2.wl-tiwai@suse.de>
 <CAMeQTsbEjUyOYDAF-kFwTcovLr+8gHQGa27jPkeeJqmLhwbTag@mail.gmail.com> <20240419173443.6c49706e@namcao>
In-Reply-To: <20240419173443.6c49706e@namcao>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Tue, 30 Apr 2024 13:45:25 +0200
Message-ID: <CAMeQTsZJdiyLZvY07gup0ib4SvTQ83p36mLDMRv4C6BH5M69XA@mail.gmail.com>
Subject: Re: [bug-report] task info hung problem in fb_deferred_io_work()
To: Nam Cao <namcao@linutronix.de>
Cc: Takashi Iwai <tiwai@suse.de>, Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
	Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	bigeasy@linutronix.de, LKML <linux-kernel@vger.kernel.org>, 
	Vegard Nossum <vegard.nossum@oracle.com>, George Kennedy <george.kennedy@oracle.com>, 
	Darren Kenny <darren.kenny@oracle.com>, chuansheng.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 5:34=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrot=
e:
>
> On 2024-04-19 Patrik Jakobsson wrote:
> > Neither cancel_delayed_work_sync() or flush_delayed_work() prevent new
> > work from being scheduled after they return.
>
> flush_delayed_work() is called during device closing. And because no
> writes are performed after the device has been closed, no new work
> should be queued after flush_delayed_work().

Yes, nothing should write after the device is closed but the events
are asynchronous so in theory the order is not guaranteed. I also find
it unlikely but I have no other theory at this point.

>
> > But
> > cancel_delayed_work_sync() at least makes sure the queue is empty so
> > the problem becomes less apparent.
> >
> > Could this explain what we're seeing?
>
> I suspect that cancel_delayed_work_sync() is only treating the symptoms
> by preventing the deferred work from running. The real bug is "someone"
> giving fb_deferred_io_work() invalid pages to work with. But that's
> just a blind guess.

Trying to figure out when the page goes away in relation to when the
work is triggered might be a good place to start.

>
> Best regards,
> Nam

