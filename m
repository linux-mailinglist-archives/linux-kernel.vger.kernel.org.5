Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAE07BB2D9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjJFIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjJFIMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:12:42 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A30CA;
        Fri,  6 Oct 2023 01:12:41 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6c4d625da40so1285594a34.1;
        Fri, 06 Oct 2023 01:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696579961; x=1697184761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hyLdf50+C5Lil6duzGMlwDMWfIf9auOEScFOtrq4MU=;
        b=CxP59uTMOQzOHOhZBoR0wNDYy3ozLtGZg9EJ5TjLVDB0nGu16g2LB9vz34z82/CY4V
         CkjYgATyMNRljtcfGVQHvRgMmrQ8W8UN+pjWJi4hEhuff2xRRA2iOa5IXQoIriAxaew4
         GNDU0NaD7v05ID5eL0dEMk4qypcd912fo1as9EVe4UhovM/HYgmwpKGahIbu5k2A1YK3
         Y49ztYDCBH3Wi+orcndwJTHw3rFylxn7/qcxFBgoQVHSyFHN14ztpDDtEF+ecIHZFUNY
         nrcOipD/YIK5QNZ1YHoNgy/AIP1BIKs8WEOWgdQR+x59PKWZZjKR2+9tKnQBVlBYiDnd
         PyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696579961; x=1697184761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hyLdf50+C5Lil6duzGMlwDMWfIf9auOEScFOtrq4MU=;
        b=r3XeDn5peDp+/7CcxClFY2ahjBg7tfN8YgbURYln1F6aCC/035TwPLbT5Y3dQkvwRU
         jMRrbhI+utrTi2e/ylETzSkU1yEl6f0hkDkyftIfM2Tv2DqsF0/7Ldn5XXx7US7CRVdm
         tYMRCBwal2HBps2icGgX77l0UFY7YHQ9sT2UWPcoFXeYKHz4txibPkHnNmHYIkvgCX8N
         bsWc9xN89wNyYp2sGIIWPm7AHDWBuVdgMTYknFwtvmq+7ETT4jda42TAO6h/Qw0xclVO
         k3fP05ckGu8GBXUrg1IBQVVzZxxRm8FN2bs2Owz4DPRPDg9yX7/yo3BvftX7HKGEnsSN
         lc4w==
X-Gm-Message-State: AOJu0YyGLU8FF0J/xLtVTC46vw0Fqe+GRJYR2loHULOrjtGaQcJb2SSl
        /l8Y2mehaYwXLpIyabkbjnrULvgH7Z/7QjNA0zw=
X-Google-Smtp-Source: AGHT+IEZD11joQZPyC+dYLswYlEZKv6Tnutn7rnepP4xQQ2Yzm0uPtBTx21p3sEctjHFxZLl2uBPw5IHWm1lUcffUXc=
X-Received: by 2002:a05:6870:9712:b0:1db:71b9:419c with SMTP id
 n18-20020a056870971200b001db71b9419cmr8459956oaq.58.1696579960814; Fri, 06
 Oct 2023 01:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231003083836.100706-1-hengqi.chen@gmail.com> <14c52402-ebc8-4425-9871-1663a87182ef@sdfg.com.ar>
In-Reply-To: <14c52402-ebc8-4425-9871-1663a87182ef@sdfg.com.ar>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Date:   Fri, 6 Oct 2023 16:12:29 +0800
Message-ID: <CAEyhmHSJga3NMtZDy4CzM6fQcc5-LVGouprd7N8Gd8EH2Nqpqg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] seccomp: Split set filter into two steps
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        alexyonghe@tencent.com,
        Alban Crequy <albancrequy@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 10:03=E2=80=AFPM Rodrigo Campos <rodrigo@sdfg.com.ar=
> wrote:
>
> On 10/3/23 10:38, Hengqi Chen wrote:
> > This patchset introduces two new operations which essentially
> > splits the SECCOMP_SET_MODE_FILTER process into two steps:
> > SECCOMP_LOAD_FILTER and SECCOMP_ATTACH_FILTER.
> >
> > The SECCOMP_LOAD_FILTER loads the filter and returns a fd
> > which can be pinned to bpffs. This extends the lifetime of the
> > filter and thus can be reused by different processes.
>
> A quick question to see if handling something else too is
> possible/reasonable to do here too.
>
> Let me explain our use case first.
>
> For us (Alban in cc) it would be great if we can extend the lifetime of
> the fd returned, so the process managing a seccomp notification in
> userspace can easly crash or be updated. Today, if the agent that got
> the fd crashes, all the "notify-syscalls" return ENOSYS in the target
> process.
>
> Our use case is we created a seccomp agent to use in Kubernetes
> (github.com/kinvolk/seccompagent) and we need to handle either the agent
> crashing or upgrading it. We were thinking tricks to have another
> container that just stores fds and make sure that never crashes, but it
> is not ideal (we checked tricks to use systemd to store our fds, but it
> is not simpler either to use from containers).
>
> If the agent crashes today, all the syscalls return ENOSYS. It will be
> great if we can make the process doing the syscall just wait until a new
> process to handle the notifications is up and the syscalls done in the
> meantime are just queued. A mode of saying "if the agent crashes, just
> queue notifications, one agent to pick them up will come back soon" (we
> can of course limit reasonably the notification queue).
>
> It seems the split here would not just work for that use case. I think
> we would need to pin the attachment.
>
> Do you think handling that is something reasonable to do in this series t=
oo?
>

I am not familiar with this notification mechanism, but it seems unrelated.
This patchset is trying to reuse the seccomp filter itself.

> I'll be afk until end next week. I'll catch up as soon as I'm back with
> internet :)
>
>
>
> Best,
> Rodrigo

--
Hengqi
