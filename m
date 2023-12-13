Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6F4810D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 10:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjLMJYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjLMJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:24:35 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD4FE3;
        Wed, 13 Dec 2023 01:24:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54c64316a22so8538857a12.0;
        Wed, 13 Dec 2023 01:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702459480; x=1703064280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vzSd8LynZJ//PvTW6T62UCX5dG9fVJhHRlr23lSsXQ=;
        b=Otj7UF3TuwfBvVCosdl/HyhbxnR8cIejxrmGIy4WZU1hb98r3RMMcGEYC7WV3ynbYT
         5fTyJFidfWxp9cX375jr7s/csia6dyy99Fttfplez1KL3zbeGpedJg5l8/Qy96S7N0uh
         M0k3ZfQFb3EsFeunUJS6wdsX0T1XzGYMjrcR7RAqIAheQXWAJkUJlJGBwKVds02PBWVt
         ODAHQOnBQTiCKHBhiWSW4q9olnH9yb+WHeTG1L91jpXTyXO6yq4eyEeZsloQW0X9dVf3
         zW9wWV/e9IwKGME/JO5dI/3OkwJV9Y14CB7Q12jw42YhQBvQi4OhTxgxHuK3W0mEWAMA
         ALmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702459480; x=1703064280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vzSd8LynZJ//PvTW6T62UCX5dG9fVJhHRlr23lSsXQ=;
        b=VA2jz3dEBGKGrS0E8ME+4tn+4BZ7FovKUykNxNV6zpUytUFW0T7gVjsIyo04vBPgF7
         +l9c1DdZhzCFZh9D4+CJRlpdgvgC6hQdbtLyqoRBFCUjlpKUSLSOHyvwcuB6mVOgjevu
         wh1WEi8rvfVIfFusD4V/7CYaO5xsapvEdo1Wa+qrtjUxHaMgNqtOEXXgfo4EAWyl0/WX
         uGlhO4aEFCHw+OW4uADHrUsDAG1buGN6tlHz8OP6gTAYILgfNay+FjQ7oYy9b2IJSv/0
         dbvQrt457anSde5IU1gzunrezaHBNx/FXNuQUzbTOOsXW6URe6v0dWEeOPiIC61M4T4q
         Or8w==
X-Gm-Message-State: AOJu0Yz99FrF4zaAF7+TzRNaAsLNDHDmTXW8oSsjuD38qHi7uMDkUMzD
        9lYOVOhP/XlrjGI/avcK2xcN6GEyDtp1CoNRrWSYaJ6eL0c=
X-Google-Smtp-Source: AGHT+IHcfe/Yy5REgZDPMT/EQF4CdZzG5fkb9Ye0aKAvhtqq/Z+jC6Bly5Iskt6NjOOnjgZT7EnMoKsksMmyhIZTmbE=
X-Received: by 2002:a50:cd16:0:b0:552:2ad3:5d2b with SMTP id
 z22-20020a50cd16000000b005522ad35d2bmr193694edi.44.1702459480340; Wed, 13 Dec
 2023 01:24:40 -0800 (PST)
MIME-Version: 1.0
References: <ZXeJ9jAKEQ31OXLP@redhat.com> <20231212111150.18155-1-hongyu.jin.cn@gmail.com>
 <20231213044530.GB1127@sol.localdomain>
In-Reply-To: <20231213044530.GB1127@sol.localdomain>
From:   Henry King <hongyu.jin.cn@gmail.com>
Date:   Wed, 13 Dec 2023 17:24:18 +0800
Message-ID: <CAMQnb4MQUJ0VnA5XO-enrXTJvHbo6FJCVPGszGaq-R34hfbeeg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Fix I/O priority lost in device-mapper
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        axboe@kernel.dk, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
        yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
        linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=B8=89 12:45=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Dec 12, 2023 at 07:11:45PM +0800, Hongyu Jin wrote:
> > From: Hongyu Jin <hongyu.jin@unisoc.com>
> >
> > A high-priority task obtains data from the dm-verity device using the
> > RT IO priority, during the verification, the IO reading FEC and hash
> > by kworker loses the RT priority and is blocked by the low-priority IO.
> > dm-crypt has the same problem in the process of writing data.
> >
> > This is because io_context and blkcg are missing.
> >
> > Move bio_set_ioprio() into submit_bio():
> > 1. Only call bio_set_ioprio() once to set the priority of original bio,
> >    the bio that cloned and splited from original bio will auto inherit
> >    the priority of original bio in clone process.
> >
> > 2. Make the IO priority of the original bio to be passed to dm,
> >    and the dm target inherits the IO priority as needed.
> >
>
> What commit does this patch series apply to?
>
> - Eric

Changes are based on the master branch
commit 9bacdd8996c7 (origin/master, origin/HEAD) Merge tag
'for-6.7-rc1-tag' of
git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
