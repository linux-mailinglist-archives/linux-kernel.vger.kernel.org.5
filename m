Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF057C41BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjJJUnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjJJUnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:43:51 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54A28E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:43:49 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c012232792so75978401fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696970628; x=1697575428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81cjp26ZLCRfVdmuI0tOydwXQofr1yefS0BzwFdHnbc=;
        b=nKvdWABEN2E/p+8e6xdih23nMkhHt/EEho9DFMoMngoY6PT3yU2veyMKdaSh8Ow8Gb
         T6Aot2iThVy86Y17cM8Ugu3fv38HrwbNYLIHTNgWqYTbXMJIyxQWUE+0zXPiBSI+Ys4I
         /ETGlpyJV+KiXSKmhjS0MeIZRnrj6mkoXLMx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970628; x=1697575428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81cjp26ZLCRfVdmuI0tOydwXQofr1yefS0BzwFdHnbc=;
        b=lFvWOGOru53FSY9N1y+vedqVfHYytn8SBY5C3r8dsKKIA7sdA8AzcMAoiMhnZcaNtM
         J8IBMAFQfIytt79nj6UBaJgEPHi6iAc1LXUcyyyppgvhK2gZFUS7/+40kroK9yC/nprc
         ndBCxLMjXLH7MkFxxhD3scNt3cCedyl+O9rz3q+b/o5dk1xLwljEkKOnUC4tQ3YBRGSY
         bI/xL4whQNPaUujwODFNhX9wLjPBYfkIWYkI10H95piudVlcziVywBBFf5LFEi5aoVEY
         nn7tKk72ztLmqwvt3lbd/vx2liRYuOSLGee4cnPToGRG9tGOii8daXujXE1Y1mulaZwu
         XzWg==
X-Gm-Message-State: AOJu0YxHw+9M3ktmxRLtRYN+coeq5r8eNhi0Q2j+Lhy7pbFG1OTGApE8
        pdI12Fv78RC9PEXGsR9Ugii3/qr1q4zRiGYZx0J1vw==
X-Google-Smtp-Source: AGHT+IFbF9MZZKolGHZgDB2/ps8Ewh63dhGzwhUtUzbFrQtTYTg7F/nmufWO2JTcxu1WgI2EKXLI67E6W2ZwWnGL2LE=
X-Received: by 2002:a2e:9d0e:0:b0:2c2:966f:8cc with SMTP id
 t14-20020a2e9d0e000000b002c2966f08ccmr13106920lji.0.1696970627979; Tue, 10
 Oct 2023 13:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230929021213.2364883-1-joel@joelfernandes.org>
 <87bkdl55qm.fsf@email.froward.int.ebiederm.org> <CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
 <CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com> <20231009100155.6d71490f@gandalf.local.home>
In-Reply-To: <20231009100155.6d71490f@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 10 Oct 2023 16:43:37 -0400
Message-ID: <CAEXW_YQzf9=90Y4Q6RrVZHPkdAB+0ht94LdPMCozN4JBkjXacw@mail.gmail.com>
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Rob Clark <robdclark@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 10:00=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sat, 7 Oct 2023 21:30:42 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > Just checking how we want to proceed, is the consensus that we should
> > prevent kernel crashes without relying on userspace stopping all
> > processes? Should we fix regular reboot syscall as well and not just
> > kexec reboot?
>
> If you can show that we can trigger the crash on normal reboot, then I
> don't see why not. That is, if you have a program that does the reboot
> (without the SIGSTOP/SIGKILL calls) and triggers this crash, I think that=
's
> a legitimate reason to fix it on normal reboot too.

Ok, Sounds good, thanks for sharing your thoughts.

 - Joel
