Return-Path: <linux-kernel+bounces-168395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E56B18BB809
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B57FB232E0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD83583CA6;
	Fri,  3 May 2024 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2rG8bn6l"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E0A839F5
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778039; cv=none; b=V34rDGM6rqLaP96wVUlsLUJDVQLqgx8Bky9jHtNSJqSRuh0fEoO44ZrlPT7JMouqaUAeeydg/m0JOPamGCxdTIRzBImZaMFSuXdtLC5iBkqtpr0FXjmSzxGDLCRgBsEA+pw9sBL84mjuwY53/1GzIvch9SyDf9GR9XTdrt905Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778039; c=relaxed/simple;
	bh=UaoPzNVUXZBeYCI4Q6Lj3hWqihBcIYlP6ERc/5nAvKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkDyAaLKtPPnFLkanYFiNJwLJz28nBs49dE8veAc2BOLHxPecm0nkkVhY1Svy5pZsZdjNv9uVrlwKQkepVnknyiHgtqH9I9jn3OxP6JnX3LHWD/x4eAZ34Vr7aDSmgULOPc5ay0gzlQOjuAjAgo+in8loynXlE1cLD7fsVPypWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2rG8bn6l; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de54b28c3b7so197188276.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 16:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714778037; x=1715382837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx7eA7+wetLZJ6nYBQUWynRRLR0EZ2R8LfNtwQgm3Q8=;
        b=2rG8bn6lhO1TMp8ByZGrDR05RMUa7rSS4DKWBIdkZl42po5cEnWTtBYAa4VuWdJkSl
         j8EaB9PbJA98Afh5RoUOLTueDA+7EX/JYtYgfCRuoRS2Gu23ubpD37bjUevC1CE8BPcb
         yFtB7IpbwnxG+BEHqM7hbZ+pvCMDc8C4ddQ2q7vT4MauIq4DptHhLsQ/srtVJO6FW30A
         0f0u6WwNYUkkvVCChfyHYTkNB9mjNMTUI5SRjmSy1BatHpFNpg7546lgs0kQoxatFwIr
         ho8uGrROvNHqVwQbsbEvF9Td1LBky6ZlCUZKhFImXQwIOoDlShEuqC8lBpwZFryaUmxF
         I/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714778037; x=1715382837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx7eA7+wetLZJ6nYBQUWynRRLR0EZ2R8LfNtwQgm3Q8=;
        b=smOmzsO/tX3xdaNnLZ4Z7eq3VZX8uulDv+C6xvkvVUCyiJq/jROLWiots/euxXToG4
         VuWTu3yjqrtcYyQ3GUYuCY+iKfplJdpBbJn2fnFPY0bKrOVUjYeg//eeWXUpYNZwRnIj
         PWMlDWnrfoCvp4mMR7atFvLroM62y8UYKAkdVSTa5dmHPqzqiGXpFQ7w6L0Et+Zl7YHV
         D1JUzwwzIjY51fs2mGZHyhoqeaEnCAfc7P4HYJzPIWSS7miYgt96qxQ5ytMT7a0YB9yR
         7yNq5COMl6E92cTw0jsHamWmr8LEG2WpL2BhrsMzuwRm+TymkWwa9lcEp5FCNfzqD4ZW
         tR9w==
X-Forwarded-Encrypted: i=1; AJvYcCXo7TPgdQb+XiDFcfLZdO53rD55uGMHDFTMfyckT5jrrdrLPxm9mzgzdik4LoK0R71jxcHt2Wiz1F5/e0PEamwXTUto/q/XlPGk4xUG
X-Gm-Message-State: AOJu0Ywbam2+CiA9dkX7ElATHUqictDdq716EP9zlVb8Abn8jGcXEL30
	OccnZjuXbGfR8Soa5IkQPVbfwqLtC50wXrXptHwM28oYC0Q3Ny7z4CEott+FIJuCUJPJ0zAhwCy
	VEzo/a+Aq85vD/Plm7kWrevfhBbbCtQrLES3v
X-Google-Smtp-Source: AGHT+IEs7oOCdBwjSrckkdk5ke5Sbh3Li4ral7+Wxq1yd2IFmVkyGkWEZTAmKm+Qy4XRPd/wxXjPvJxVkWCooTOeuN0=
X-Received: by 2002:a05:6902:248a:b0:dd0:76e:d630 with SMTP id
 ds10-20020a056902248a00b00dd0076ed630mr5363668ybb.53.1714778036906; Fri, 03
 May 2024 16:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327022903.776-1-justinjiang@vivo.com> <5cf29162-a29d-4af7-b68e-aac5c862d20e@amd.com>
 <cc7defae-60c1-4cc8-aee5-475d4460e574@vivo.com> <23375ba8-9558-4886-9c65-af9fe8e8e8b6@amd.com>
 <CABdmKX2Kf4ZmVzv3LGTz2GyP-9+rAtFY9hSAxdkrwK8mG0gDvQ@mail.gmail.com>
 <e55cad9b-a361-4d27-a351-f6a4f5b8b734@vivo.com> <40ac02bb-efe2-4f52-a4f2-7b56d9b93d2c@amd.com>
 <4fedd80c-d5b6-4478-bfd3-02d1ee1a26e5@vivo.com> <aab5ec51-fcff-44f2-a4f5-2979bd776a03@amd.com>
 <2ebca2fd-9465-4e64-b3cc-ffb88ef87800@vivo.com> <d4209754-5f26-422d-aca0-45cccbc44ad0@amd.com>
 <289b9ad6-58a3-aa39-48ae-a244fe108354@quicinc.com>
In-Reply-To: <289b9ad6-58a3-aa39-48ae-a244fe108354@quicinc.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 3 May 2024 16:13:44 -0700
Message-ID: <CABdmKX3Zu8LihAFjMuUHx4xzZoqgmY7OKdyVz-D26gM-LECn6A@mail.gmail.com>
Subject: Re: [PATCH] dmabuf: fix dmabuf file poll uaf issue
To: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	zhiguojiang <justinjiang@vivo.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 6:40=E2=80=AFAM Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> Thanks Christian/TJ for the inputs!!
>
> On 4/18/2024 12:16 PM, Christian K=C3=B6nig wrote:
> > As far as I can see the EPOLL holds a reference to the files it
> > contains. So it is perfectly valid to add the file descriptor to EPOLL
> > and then close it.
> >
> > In this case the file won't be closed, but be kept alive by it's
> > reference in the EPOLL file descriptor.
>
> I am not seeing that adding a 'fd' into the epoll monitoring list will
> increase its refcount.  Confirmed by writing a testcase that just do
> open + EPOLL_CTL_ADD and see the /proc/../fdinfo of epoll fd(Added
> file_count() info to the output)
> # cat /proc/136/fdinfo/3
> pos:    0
> flags:  02
> mnt_id: 14
> ino:    1041
> tfd:        4 events:       19 data:                4  pos:0 ino:81 sdev:=
5
> refcount: 1<-- The fd added to the epoll monitoring is still 1(same as
> open file refcount)
>
> From the code too, I don't see a file added in the epoll monitoring list
> will have an extra refcount but momentarily (where it increases the
> refcount of target file, add it to the rbtree of the epoll context and
> then decreasing the file refcount):
> do_epoll_ctl():
>         f =3D fdget(epfd);
>         tf =3D fdget(fd);
>         epoll_mutex_lock(&ep->mtx)
>         EPOLL_CTL_ADD:
>                 ep_insert(ep, epds, tf.file, fd, full_check); // Added to=
 the epoll
> monitoring rb tree list as epitem.
>         mutex_unlock(&ep->mtx);
>         fdput(tf);
>         fdput(f);
>
>
> Not sure If i am completely mistaken what you're saying here.
>
> > The fs layer which calls dma_buf_poll() should make sure that the file
> > can't go away until the function returns.
> >
> > Then inside dma_buf_poll() we add another reference to the file while
> > installing the callback:
> >
> >                         /* Paired with fput in dma_buf_poll_cb */
> >                         get_file(dmabuf->file); No, exactly that can't
> > happen either.
> >
>
> I am not quite comfortable with epoll internals but I think below race
> is possible where "The 'file' passed to dma_buf_poll() is proper but
> ->f_count =3D=3D 0, which is indicating that a parallel freeing is
> happening". So, we should check the file->f_count value before taking
> the refcount.
>
> (A 'fd' registered for the epoll monitoring list is maintained as
> 'epitem(epi)' in the rbtree of 'eventpoll(ep, called as epoll context).
>
> epoll_wait()                                __fput()(as file->f_count=3D0=
)
> ------------------------------------------------------------------------
> a) ep_poll_callback():
>      Is the waitqueue function
>    called when signaled on the
>    wait_queue_head_t of the registered
>    poll() function.
>
>    1) It links the 'epi' to the ready list
>       of 'ep':
>        if (!ep_is_linked(epi))
>          list_add_tail_lockless(&epi->rdllink,
>                 &ep->rdllist)
>
>    2) wake_up(&ep->wq);
>         Wake up the process waiting
>         on epoll_wait() that endup
>         in ep_poll.
>
>
> b) ep_poll():
>     1) while (1) {
>         eavail =3D ep_events_available(ep);
>         (checks ep->rdlist)
>         ep_send_events(ep);
>         (notify the events to user)
>     }
>     (epoll_wait() calling process gets
>      woken up from a.2 and process the
>      events raised added to rdlist in a.1)
>
>    2) ep_send_events():
>         mutex_lock(&ep->mtx);
>         (** The sync lock is taken **)
>         list_for_each_entry_safe(epi, tmp,
>                         &txlist, rdllink) {
>             list_del_init(&epi->rdllink);
>             revents =3D ep_item_poll(epi, &pt, 1)
>             (vfs_poll()-->...f_op->poll(=3Ddma_buf_poll)
>         }
>         mutex_unlock(&ep->mtx)
>         (**release the lock.**)
>
>         (As part of procession of events,
>          each epitem is removed from rdlist
>          and call the f_op->poll() of a file
>          which will endup in dma_buf_poll())
>
>    3) dma_buf_poll():
>         get_file(dmabuf->file);
>         (** f_count changed from 0->1 **)
>         dma_buf_poll_add_cb(resv, true, dcb):
>         (registers dma_buf_poll_cb() against fence)
>
>
>                                 c) eventpoll_release_file():
>                                    mutex_lock(&ep->mtx);
>                                    __ep_remove(ep, epi, true):
>                                    mutex_unlock(&ep->mtx);
>                                   (__ep_remove() will remove the
>                                    'epi' from rbtree and if present
>                                    from rdlist as well)
>
>                                 d) file_free(file), free the 'file'.
>
> e) dma_buf_poll_cb:
>  /* Paired with get_file in dma_buf_poll */
>  fput(dmabuf->file);
>  (f_count changed from 1->0, where
>   we try to free the 'file' again
>   which is UAF/double free).
>
>
>
> In the above race, If c) gets called first, then the 'epi' is removed
> from both rbtree and 'rdlink' under ep->mtx lock thus b.2 don't end up
> in calling the ->poll() as it don't see this event in the rdlist.
>
> Race only exist If b.2 executes first, where it will call dma_buf_poll
> with __valid 'struct file' under ep->mtx but its refcount is already
> could have been zero__. Later When e) is executed, it turns into double
> free of the 'file' structure.
>
> If you're convinced with the above race, should the fix here will be
> this simple check:
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 8fe5aa67b167..e469dd9288cc
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -240,6 +240,10 @@ static __poll_t dma_buf_poll(struct file *file,
> poll_table *poll)
>         struct dma_resv *resv;
>         __poll_t events;
>
> +       /* Check parallel freeing of file */
> +       if (!file_count(file))
> +               return 0;
> +
>
> Thanks,
> Charan

Hi Charan,

It looks like a similar conclusion about epoll was reached at:
https://lore.kernel.org/all/a87d7ef8-2c59-4dc5-ba0a-b821d1effc72@amd.com/

I agree with Christian that it should not be possible for the file to
be freed while inside dma_buf_poll. Aside from causing problems in
dma_buf_poll, ep_item_poll itself would have issues dereferencing the
freed file pointer.

Christian's patch there makes me wonder about what the epoll man page
says about closing files.
"Will closing a file descriptor cause it to be removed from all epoll
interest lists?" Answer: Yes
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man/man7/e=
poll.7#n442

It looks like eventpoll_release_file is responsible for that, but if
the epitem is changed to hold a reference then that can't be true
anymore because __fput will never call eventpoll_release_file (until
EPOLL_CTL_DEL). But how do you call EPOLL_CTL_DEL if you've closed all
your references to the file in userspace? So I think epoll needs a
slightly more complicated fix.

