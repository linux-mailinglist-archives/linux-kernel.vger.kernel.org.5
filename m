Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B95771D21
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjHGJbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjHGJbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:31:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B4410C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:31:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe200f84d9so791799e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1691400678; x=1692005478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TP5k3hS88AalKYoKxR+/+0m9GrcoAUGsSTd3d/0sKq8=;
        b=jtLGcMsd3qFmiPnjrzr5RlX64Vb2iF+kEVzFGjWkz0zu58Yla47U7e1wz3/vr04i2N
         S9288LRD0od+7JWPqaoUnNzKGShDTLRRGl7T6xZ9XX/7dFjxdRMd7cqZ4XWh2eEgIj41
         Sqnn01gnc8psjoBxMWDw1afnWBXcc1BpmrePk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691400678; x=1692005478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TP5k3hS88AalKYoKxR+/+0m9GrcoAUGsSTd3d/0sKq8=;
        b=euZyL3qqB7/0vyM6P6jNmO3A9qBolqiSgbcmFXg7vLL3/GxVNjwOOfTxTv4XcPfujD
         eXZozKPT8I5N7W0M7hRItaY7IjSBxaozM2CxtK3Q4JhFenBvcShcp+CigCnK45XDvICm
         2J3e1JbVAU/Nx4EQYr75VpXwFDq3Ma2cjGC46femnjtD/dxsenvJNTltFV2jbxYtvIWk
         WYQNiKKvV2hqFBw7JPfiSmdaVb/vYku1x9NvKSU8tSD8VIJ87WzKI+COXBGjlbt1EdFu
         5URbHFfByD/A+HxMas9YbxJVZb6VdFg5rrYW1U53XhugkJPqlN8L56bPvT+GfG09f9Fn
         UI1w==
X-Gm-Message-State: ABy/qLYbMgR4brDHuwD2fh0qQ6F0o6r/WJyw8iycyHagNjAy4d08GM32
        2VhiO0UOxW3Nf6eQ2E89743OzxG91z8K23/RXg43AA==
X-Google-Smtp-Source: APBJJlFpO89UQ2O38GbzQ5rLIx/Hlw2LhruoXBQoivB/nkFQvPdqyB3NZHJA2j3eHEQCfg+WSVecDp0ChsjrEzb6FlA=
X-Received: by 2002:ac2:44d2:0:b0:4fd:e252:ffcc with SMTP id
 d18-20020ac244d2000000b004fde252ffccmr12490673lfm.5.1691400677914; Mon, 07
 Aug 2023 02:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230807085203.819772-1-david@readahead.eu> <CAJqdLroQE1sU2uOG018Ezyome1sQb89c_mdSdvOCpM7=XNt+xg@mail.gmail.com>
 <24357f20-4354-4b44-b3f7-4cb29dcfb8b4@app.fastmail.com>
In-Reply-To: <24357f20-4354-4b44-b3f7-4cb29dcfb8b4@app.fastmail.com>
From:   Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date:   Mon, 7 Aug 2023 11:31:06 +0200
Message-ID: <CAJqdLrrD41chNmoWX5kqxYp=fVN3qgzeRb86NEFKhD0gSUtYJw@mail.gmail.com>
Subject: Re: [PATCH] pid: allow pidfds for reaped tasks
To:     David Rheinsberg <david@readahead.eu>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>,
        Luca Boccassi <bluca@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 11:12=E2=80=AFAM David Rheinsberg <david@readahead.e=
u> wrote:
>
> Hi
>
> On Mon, Aug 7, 2023, at 11:01 AM, Alexander Mikhalitsyn wrote:
> > On Mon, Aug 7, 2023 at 10:52=E2=80=AFAM David Rheinsberg <david@readahe=
ad.eu> wrote:
> [...]
> >>  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **=
ret)
> >>  {
> >> -       if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> >> +       if (!pid)
> >> +               return -EINVAL;
> >> +
> >> +       /*
> >> +        * Non thread-group leaders cannot have pidfds, but we allow t=
hem for
> >> +        * reaped thread-group leaders.
> >> +        */
> >> +       if (pid_has_task(pid, PIDTYPE_PID) && !pid_has_task(pid, PIDTY=
PE_TGID))
> >>                 return -EINVAL;
> >
> > Hi David!
> >
> > As far as I understand, __unhash_process is always called with a
> > tasklist_lock held for writing.
> > Don't we need to take tasklist_lock for reading here to guarantee
> > consistency between
> > pid_has_task(pid, PIDTYPE_PID) and pid_has_task(pid, PIDTYPE_TGID)
> > return values?
>
> You mean PIDTYPE_TGID being cleared before PIDTYPE_PID (at least from the=
 perspective of the unlocked reader)? I don't think it is a compatibility i=
ssue, because the same issue existed before the patch. But it might indeed =
be required to avoid spurious EINVAL _while_ the target process is reaped.

Yes, that was my thought. At the same time we can see that
__unhash_process() function at first detaches PIDTYPE_PID and then
PIDTYPE_TGID.
But without having any kind of memory barrier (and locks are also
implicit memory barriers) we can't be sure that inconsistency won't
happen here.

>
> It would be unfortunate if we need that. Because it is really not require=
d for AF_UNIX or fanotify (they guarantee that they always deal with TGIDs)=
. So maybe the correct call is to just drop pidfd_prepare() and always use =
__pidfd_prepare()? So far the safety-measures of pidfd_prepare() introduced=
 two races I already mentioned in the commit-message. So maybe it is just b=
etter to document that the caller of __pidfd_prepare() needs to ensure the =
source is/was a TGID?

Do you think that taking read_lock(&tasklist_lock) can cause any
issues with contention on it?
IMHO, read_lock should be safe as we are taking it for a short period of ti=
me.

But anyways, I'm not insisting on that. I've just wanted to point this
out to discuss with you and folks.

Kind regards,
Alex

>
> Thanks
> David
