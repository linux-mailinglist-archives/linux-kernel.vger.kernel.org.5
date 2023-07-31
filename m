Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1DA76A0F3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjGaTOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGaTOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:14:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F300BE4B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:14:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-267f870e6ffso2844913a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690830873; x=1691435673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3KFf9AewUDstKJtKahowIoTFXcs3ACJtvJL1LnzLQE=;
        b=R4ECufchNtK/yhPlyf4sGYL8V5B+uXGSidl3ahjnSvpiPX3iU4WZA65G2qcOiFdOdi
         YRaz9KEl5H9NNtFdiGr3Ym71um3II5QBozgntrAwGtIwXjt0sPVmj8GeXi9yz2YMmPIF
         5jQqHKiuSN53YlnzoAqX7UIi8aRHw3rBgBcVaN0n/eSoRr3lJAKsDH/UK8z84zDVRhA/
         5ncgUbdzyeE3WZaReml9geU5ffHhAO9en6S1dDTA9t9iQXIrHuXdVRFcFRMT+7p+HJm0
         0T3ettaqC5QYeOyW961TZ5cPJV/k8TKmiMlRx3wpuGzX34GlujJaCVCCJXkOA+oZjwUE
         Eg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690830873; x=1691435673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3KFf9AewUDstKJtKahowIoTFXcs3ACJtvJL1LnzLQE=;
        b=GnHK+8ZB9kGtPCUKKPBOzV013rpnmlHZQNLd3Cx1clv16x8DspvIfoWWo/SAHoutNH
         J9ddZ0niBy2gol+DGoEk7a5pLeDMrv46fGADzICJ9YsQF6eA0eSI/q2OnCd+U5yRcuNx
         LdmXviKhr4ytvn1rWcNxiVBjlSz4pKurjYWwluXRi/KAWS+VOoOyteZQdM2OUGB5ZLd3
         89a5czk+tDeUvsv3v/t4IMmIkzQKkYmVB1REURMDho5fqvywpP4ZRycaH8AV0FsXLZ4S
         CrYaP7GQfKaFDLdVSb8yWI72S4XRy2tfXyKptq6EZpiPIH1Ex0Dt8Azw1RnYycG8DWEk
         74/Q==
X-Gm-Message-State: ABy/qLY909T/GwBP5IDH+q1x09GBxJmOATpee52j/BnYL9IuBFRWbuZM
        6CzgQY8hU3TY7vdc0slYA2TrrYzHhKk=
X-Google-Smtp-Source: APBJJlGpic85aZ6FAqeDMx+H5QOs+4tD2CfvaSFNWpXHz9uuMsoQeZZw0lPIau9SgZi73iZ7apZ15g==
X-Received: by 2002:a17:90a:3e4e:b0:268:29cb:f93a with SMTP id t14-20020a17090a3e4e00b0026829cbf93amr10384986pjm.1.1690830873110;
        Mon, 31 Jul 2023 12:14:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4a3a])
        by smtp.gmail.com with ESMTPSA id m8-20020a170902bb8800b001b8a3dd5a4asm8909383pls.283.2023.07.31.12.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 12:14:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Jul 2023 09:14:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, Dave Airlie <airlied@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: arm32 build warnings in workqueue.c
Message-ID: <ZMgIF_6zCqB0LfjN@slm.duckdns.org>
References: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
 <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
 <ZJX27JDyrgvdeCe4@slm.duckdns.org>
 <ZMdu1YqUI7VIEq1y@alley>
 <CAHk-=wiJSzSkF-FDcHydR61Q3_q4xCiqq37tfXdijaCxsDF86Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJSzSkF-FDcHydR61Q3_q4xCiqq37tfXdijaCxsDF86Q@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 31, 2023 at 11:40:04AM -0700, Linus Torvalds wrote:
> So I think the whole "gdb debug info" argument is complete garbage,
> and was never true at all. If you want gdb to know about these
> constants, you just do the same thing that gdb users already have to
> do for other things.

When manually debugging with gdb, figuring out these constants might not add
too much overhead on top but nowadays there are many other tools which can
benefit from having the source of truth available to them directly from the
kernel.

For example, it's a lot easier to write non-trivial debug scripts with drgn
(https://github.com/osandov/drgn) and it's not too unusual to have a
collection of bcc / bpftrace scripts for diagnosing common problems. They of
course don't have any interface stability expectations. However, there's no
reason to make using them unnecessarily painful given how useful they are.
Having constant values included in the kernel debug info makes it a lot
easier to use these tools and removes a silly source of subtle problems.

> And honestly, I don't understand why anybody seriously believes that
> those WORK_STRUCT constants are somehow very important. We have many
> *much* more fundamental constants that are #define's. Thinking that
> WORK_OFFQ_CANCELING needs special gdb understanding when we have
> PAGE_SIZE that does not seems entirely crazy to me.

PAGE_SIZE is easily available through _SC_PAGE_SIZE, so that particular one
is never a real problem (and a lot of tools have pre-defined helpers for it
and similarly important constants) but yeah there are other constants which
I sometimes wish were available through debug info.

It may be difficult to argue specifically for WORK_OFFQ_CANCELING in
isolation as it is directly derived from __WORK_OFFQ_CANCELNG, so no problem
there, but I hope you can see that having these constants available in debug
info in general is useful.

Even here, the value of __WORK_OFFQ_CANCELING is dependent on
CONFIG_DEBUG_OBJECTS_WORK. It's not a strong case as the option is pretty
specifically for debugging but if one is to actually debug or monitor
workqueue using external visibility tools, this can easily lead to mistakes.

Thanks.

-- 
tejun
