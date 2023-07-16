Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477B87550DC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjGPTLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPTLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:11:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C419F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:11:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e344efd75so7818178a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689534702; x=1692126702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0OyrnABpfGrBHIIzfnTugrqAUuXCez/5n+BWJ/56tEc=;
        b=A1YZA4EgsF+jlQLL/+OPICtgA4VitZn5GBPJUbO1XZZ4ttq1Yn2wNo1qz8T5ERoIZ9
         TTqOcviZd6lWgskRwzY1enpoOFQnL1jvdcYRimC00cO8+LmZlkp09gSWROI0qrjFKV7o
         BB43clWjMGhiMgrMdFuOuFn7/CKMcJ0djMSeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689534702; x=1692126702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OyrnABpfGrBHIIzfnTugrqAUuXCez/5n+BWJ/56tEc=;
        b=ALGyPmvEIJ3GYgzmu4ZH0u13bwh6oguq8UbSWE2xWiY2qJOj3OqCAhYmJcVyiFs+OJ
         WroLKOTdh02229dfcl9vAAmG74N+tR1KVQ6hluhlCeID4Wu2Lc+3zDXyKaAW2IGf/o6V
         Uj6Ah7bSTiMWP3JAtRzcdaoi26Ne1gDmJx447vnn3/9s/j2CgtgIW9VAiNWW+WcAdkOD
         Z+Ee74GaYbC3mO2IOxgekBdBH6vDUvzp4mr8c38AguDKvMWvbM8ll20Z6eeswrOTcU/U
         OeijNDBl192FKaHAOxVIVR9cmKA+lQUni0gQSinX5041zlasjuaeB8HZaKM2/Q9aVMym
         mMeA==
X-Gm-Message-State: ABy/qLbOIoLYl9hRumMVXqF94UPKZu7cjGHMkof+nfdahmp13320FBZP
        3DqjErYwJb9Tz8soh4Tv3aUMtDSoc9RMlDZcf4ayIg==
X-Google-Smtp-Source: APBJJlFv85hX5qRi2foVHwJ+lM1tWO4cDncR7hG5Xuso70pVD3VPkK63E/WEdMG5I9lJqFkTWfy0aw==
X-Received: by 2002:a05:6402:518f:b0:51e:4218:b91b with SMTP id q15-20020a056402518f00b0051e4218b91bmr9222716edd.1.1689534701840;
        Sun, 16 Jul 2023 12:11:41 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id u18-20020aa7d992000000b0050bc4eb9846sm8878828eds.1.2023.07.16.12.11.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 12:11:40 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so10413986a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:11:40 -0700 (PDT)
X-Received: by 2002:a17:906:5d16:b0:992:13c7:560 with SMTP id
 g22-20020a1709065d1600b0099213c70560mr9668575ejt.38.1689534700551; Sun, 16
 Jul 2023 12:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230714181325.3351-1-jarkko@kernel.org>
In-Reply-To: <20230714181325.3351-1-jarkko@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Jul 2023 12:11:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6Gv+zbBt7RLN43KD0BaegS=SYkwaHjd_YM5BDsvS08w@mail.gmail.com>
Message-ID: <CAHk-=wg6Gv+zbBt7RLN43KD0BaegS=SYkwaHjd_YM5BDsvS08w@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.5-rc2
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 at 11:14, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/jarkko/linux-tpmdd.git/ tpmdd-v6.5-rc2-fixed

No, that still isn't a valid git repo path.

This all also looks like it should have come in during the merge
window, so I'm just going to ignore it.

Feel free to send in actual fixes - not this massive update - once you
have fixed your workflow.

But don't even bother emailing me until you have actually *verified*
what the heck you are sending me.

No more broken script garbage. No more untested git pull requests that
don't actually work.

                Linus
