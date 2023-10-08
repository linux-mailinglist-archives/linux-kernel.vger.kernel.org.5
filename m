Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8E87BCB93
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 03:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344229AbjJHBa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 21:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjJHBa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 21:30:58 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0280B92
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 18:30:55 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c135cf2459so39100171fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 18:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696728653; x=1697333453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzfF/gGeCBC9V3v8liPcwyRygfYzpFCTXg7Z0Zkg6kM=;
        b=RN0MbzwhhEEP/zv52rtVdaZUI8DYHnPr05njSrgtQPr7Q36DE2zrEQVNZCxICfHVqI
         Ekc3kGVsTDvDvZkoGekbZ4j/gzhonuCGdtz18WxogXw7BYl9d52PbyFwmAxGdqKABL6u
         ZqlOXxFgNk8eGOE1sMSEsHjf6E+/LUq1oCgp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696728653; x=1697333453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzfF/gGeCBC9V3v8liPcwyRygfYzpFCTXg7Z0Zkg6kM=;
        b=i5KiuaLsH/fTv2LAv3typdlOGhcSW99/N+7cxy4ImHgr3tg4fg30l2IuBDhoMXmr8h
         dRPCPqxxu4qzn+aeYKrLGZfAnkNX40gz7DZi7yr9t+lOHKrAaSwNKUagicz5eJE+dVVN
         ZveKL/4bTk+Ta20EmgiSnZFKEhBgaqkxoRTqBRf4Jd1OfzDulNi+I7hSgTrfznGZcpTj
         qEhDXSGLFbm/eN2QCDxWuAg1mHTvRsAkVbY2kbX9PofIrAfnhQSd/PPIrFTcFVWGvJhu
         xWfv73+8WtFqUsLCpO5aM+ctiWU0/vSuOhtqzAoiBKaGc6uH7fBoNCDGD5U1EAlFsBzG
         lqDQ==
X-Gm-Message-State: AOJu0YyOZAFPs6hJy1JdJbkJ5jZKDwfU9JNwvu/G9/yH3zXf5+xXzVM2
        HfhapRICILPmPFBqPbRjLDonhrsvM7l7pQdCt2ZRYg==
X-Google-Smtp-Source: AGHT+IFN1xqQRQ+HT0bT9ifD2rfgW1rqc5g7tXGLjWLVl7dr7TJe7bThOu/yY/XNweHn8ACbixlwUe8dW5oUD4PtdTs=
X-Received: by 2002:a2e:9001:0:b0:2bf:aba1:d951 with SMTP id
 h1-20020a2e9001000000b002bfaba1d951mr10322222ljg.10.1696728653255; Sat, 07
 Oct 2023 18:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230929021213.2364883-1-joel@joelfernandes.org>
 <87bkdl55qm.fsf@email.froward.int.ebiederm.org> <CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
In-Reply-To: <CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 7 Oct 2023 21:30:42 -0400
Message-ID: <CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com>
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

On Mon, Oct 2, 2023 at 2:18=E2=80=AFPM Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
[..]
> > > Such freezing is already being done if kernel supports KEXEC_JUMP and
> > > kexec_image->preserve_context is true. However, doing it if either of=
 these are
> > > not true prevents crashes/races.
> >
> > The KEXEC_JUMP case is something else entirely.  It is supposed to work
> > like suspend to RAM.  Maybe reboot should as well, but I am
> > uncomfortable making a generic device fix kexec specific.
>
> I see your point of view. I think regular reboot should also be fixed
> to avoid similar crash possibilities. I am happy to make a change for
> that similar to this patch if we want to proceed that way.
>
> Thoughts?

Just checking how we want to proceed, is the consensus that we should
prevent kernel crashes without relying on userspace stopping all
processes? Should we fix regular reboot syscall as well and not just
kexec reboot?

thanks,

 - Joel
