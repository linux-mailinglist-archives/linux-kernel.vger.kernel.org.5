Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80C27B5A31
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbjJBSTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbjJBSTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:19:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EC4D7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:19:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50585357903so1474620e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696270750; x=1696875550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmYFxSTwzJ+srWcIfoZo1SLlX6AH34QQsRUSP7AjE6E=;
        b=RwXb045EvGLvHsr1ITtqFoUVD/XH1oIx7dKCxsCZPIt5ezAnCR9jC0RtgCA5H/K8vr
         dPulO26L5aRCvR+SyzWjyGg/Ks7FMpyxwR1rqgMvYQqNpSIyZQdBMcOjPvuWgkmt95hk
         yie2yCI75RzHzBzLLhsh7MO1+j+Aaerxcwk+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696270750; x=1696875550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmYFxSTwzJ+srWcIfoZo1SLlX6AH34QQsRUSP7AjE6E=;
        b=SVovyNTxbIqN6hE69JroeXyUeps5Xb6J7AvE+VaqP0HyKT9cHG3oMjy10Skawjg8W4
         ZuYrFz42IbVevDE4OBeU70VBYfDzXZnLyeKC9VuQ8KF5p8SAfXEYX2KLoZ3LhxXtxsXZ
         +E3XpKQm2FVROO1UFz5c1OCuKPFMmnjr1YOB+3BF1L6jVmmaslAgck/0FbfuufhYOrq9
         cOZJxFmc0h5cb/1Wge2PbNzLUtTwdY1BJmkZZFzEujvb0UbCrxn0drFmB8Yb6wFUf2cM
         Hp8ClE+qiTGRPMq76zyzVU1aBBzoeINy4/tO1AuW96L2mvVtyGFkL3IL6oMNymk6c2w/
         wsBA==
X-Gm-Message-State: AOJu0Yw3aGQr6rkl6BzjWeg1mv/KMzx/+ieq0cM9DdF0I4B/TanDaN1I
        JjNwkGT1WTQJOpZYprUu/0f14ovXD3NdgXcQzvUuCQ==
X-Google-Smtp-Source: AGHT+IHbOd875gpdjPofvtrlgTr+wHiCla5vNQdnG5xXttbr+WjmmnUwdNy/rHwCgl58Mckl03RBmsvfu12qFYDSn08=
X-Received: by 2002:a05:6512:3c87:b0:4fd:fabf:b6ee with SMTP id
 h7-20020a0565123c8700b004fdfabfb6eemr12141694lfv.9.1696270749716; Mon, 02 Oct
 2023 11:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230929021213.2364883-1-joel@joelfernandes.org> <87bkdl55qm.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87bkdl55qm.fsf@email.froward.int.ebiederm.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 2 Oct 2023 14:18:58 -0400
Message-ID: <CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ricardo Ribalda <ribalda@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Rob Clark <robdclark@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kexec@lists.infradead.org
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

Hi Eric,

On Fri, Sep 29, 2023 at 12:01=E2=80=AFPM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> "Joel Fernandes (Google)" <joel@joelfernandes.org> writes:
>
> > During kexec reboot, it is possible for a race to occur between
> > device_shutdown() and userspace.  This causes accesses to GPU after pm_=
runtime
> > suspend has already happened. Fix this by calling freeze_processes() be=
fore
> > device_shutdown().
>
> Is there any reason why this same race with between sys_kexec and the
> adreno_ioctl can not happen during a normal reboot?

Thanks for the response. It can happen during a normal reboot. I think
the reason it does not show up in the wild is because the "reboot"
command implementation typically sends one of SIGSTOP or SIGKILL to
all processes which effectively prevents the race.

In any case, there is also a school of thought that says the kernel
should be resilient to crashes and a userspace workaround involving
sending signals could be looked at as papering over the real issue. I
do sympathize/agree with that school of thought as well.

> Is there any reason why there is not a .shutdown method to prevent the
> race?
> I would think the thing to do is to prevent this race in
> kernel_restart_prepare or in the GPUs .shutdown method.  As I don't see
> anything that would prevent this during a normal reboot.

What you're saying is essentially what I remember trying, the issue is
not in the GPU driver but rather there the interconnect in the SoC
shutdown and causes an "SError" exception if the CPU tries to access
the memory locations, as also seen in the stack. I was not able to
trace exactly when the interconnect becomes unavailable and perhaps
there is a possibility of a more intricate fix where we can signal the
GPU driver to not access the bus anymore, but my suspicion is that
will add a lot of complexity and perhaps leave the door open to
similar issues.

> > Such freezing is already being done if kernel supports KEXEC_JUMP and
> > kexec_image->preserve_context is true. However, doing it if either of t=
hese are
> > not true prevents crashes/races.
>
> The KEXEC_JUMP case is something else entirely.  It is supposed to work
> like suspend to RAM.  Maybe reboot should as well, but I am
> uncomfortable making a generic device fix kexec specific.

I see your point of view. I think regular reboot should also be fixed
to avoid similar crash possibilities. I am happy to make a change for
that similar to this patch if we want to proceed that way.

Thoughts?

thanks,

 - Joel
