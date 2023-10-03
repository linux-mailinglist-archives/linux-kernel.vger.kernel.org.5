Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875E47B6D6D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjJCPwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjJCPww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:52:52 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62F99E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:52:49 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-577fff1cae6so785347a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696348369; x=1696953169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4dIAE6/KCMT7kD+RAOLr/gCL6H/77i626gUujqn5ZY=;
        b=J6bjCVUOH4nRZ6slBdB/sgi2yHxavvUzGvTLXboUId4C6KQCmeyustvU/bkIam+NNZ
         aSCvQUDuZWhKUjTGwiVBiLhHN/jfzXhS1uFdHcHeRY8uuXj1lV/GNPIPs/CEEh1av6ra
         6HoRav6heb3ESkdwrnmOQQXEscCRs0Zn2Y6JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348369; x=1696953169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4dIAE6/KCMT7kD+RAOLr/gCL6H/77i626gUujqn5ZY=;
        b=dweatHv7UJ+zz4wBV4onc0NxLtpB/7H88ELLyM8mFPs0PdhfFsYajtnfutVS8K8d6n
         BAe0g44MrdUblMH6WUvJ8oZflWaZ0tjNqaLvhzdJhPXK0FCyqNYzMyNXBBAqWd9TDUeM
         +ZB2puLTD+M+QPQnSsQgK7y7/Ug7LdBo855wRgslr/vWmfNSB89t7+RnIB1A0PU+e65j
         W0uHl1jE3o1mQwTkap8XlzD/kzww0AhusMbKvx1ndRUeblNG4Rlifws4XxQSYFLtyV4Q
         CBGzZHl6jwZjvGLpzCmaF/jDN3ir/KDYWeTSC11mUjrkqacLOSxQLPZUJg+8aHuZDUkk
         W1SA==
X-Gm-Message-State: AOJu0Yw6SNZMNZbfaVgDcmFjeIlt2T3Tiks1ODydq70ZJqDiBXJuk6/B
        Ia6HwMckeejdvJnPfkxeIA58GDF4uCsLteAvF5s1Yg==
X-Google-Smtp-Source: AGHT+IHVpYY7ntlOfmsLk8Uf0DGD/aXCIHXzxdLXCpuENeQFGrIbQGMgTgSsvGKaF4ZhSaelUT3c0WcNYRfBAS0Eo3A=
X-Received: by 2002:a05:6a20:a104:b0:15d:8366:65be with SMTP id
 q4-20020a056a20a10400b0015d836665bemr4913225pzk.9.1696348369415; Tue, 03 Oct
 2023 08:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230828150858.393570-1-revest@chromium.org> <20230828150858.393570-6-revest@chromium.org>
 <20230921183323.c990c57d0b43832b39d3e363@linux-foundation.org>
In-Reply-To: <20230921183323.c990c57d0b43832b39d3e363@linux-foundation.org>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 3 Oct 2023 17:52:38 +0200
Message-ID: <CABRcYmJpSAppk315vzitO9N-D=p7sJ+QiKWtA6w5mEven=Cm6A@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com, ayush.jain3@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 3:33=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 28 Aug 2023 17:08:57 +0200 Florent Revest <revest@chromium.org> w=
rote:
>
> > This extends the current PR_SET_MDWE prctl arg with a bit to indicate
> > that the process doesn't want MDWE protection to propagate to children.
> >
> > To implement this no-inherit mode, the tag in current->mm->flags must b=
e
> > absent from MMF_INIT_MASK. This means that the encoding for "MDWE but
> > without inherit" is different in the prctl than in the mm flags. This
> > leads to a bit of bit-mangling in the prctl implementation.
>
> Is a manpage update planned?

Ah that's a good point, I didn't think about it, thank you.

> And did we update the manpage for PR_SET_MDWE?

No we didn't but I sent a patch to man-pages here:
https://lore.kernel.org/linux-man/20231003155010.3651349-1-revest@chromium.=
org/
