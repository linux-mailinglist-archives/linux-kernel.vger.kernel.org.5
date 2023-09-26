Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623707AEFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbjIZPjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjIZPju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:39:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C783CEB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:39:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5334d78c5f6so10314362a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695742782; x=1696347582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9n/nLQKp+eqOy9dIbrRAN+znmrFw3M5Q6PTNFf2Vphk=;
        b=fMAjOOHi6C72qOYtqTKrV2413SgggEeJrr2KSTlaIpEtFicnfQBt9Yk6YPsRrJqv6z
         urRkhE1lTovowF32341YC+fdOX2/GboCfylpsa/G+9124xicuS//0V7/BKzOAL+8tOqv
         h5ywGMBXfPyh36V/TLIT5OOJ53VdGpMprmcfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695742782; x=1696347582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9n/nLQKp+eqOy9dIbrRAN+znmrFw3M5Q6PTNFf2Vphk=;
        b=Sc6edyLIdBCXDcNiz0XsEycudrIsqPVonEZhe8nMaQXt6Nq3XU6LpahDBmQm8iT+M3
         6kwtEdVPVfsK8bxbkQTVHK/qCpEC4nAsEBE6BhF0yJcymfwPhaX0d6VsfW+rO8OKvenC
         XEhmMmfg9ylD4EwOra7Qt0FhNFP5ABo7YSp1j618fAKZxnPTyVdyVsof4FWe/wvs1BmR
         YQHG/4w02k1CGmm54hsWXnY8cMZAkJSn/8QJMks6eq90Kyh6/p4RvkAViJP3++LSX5wu
         zcF038IIfx5mn9//xvvfmDJgH84+0074zL4ndxGFpGWQU1ILiNoE3hyqcxgicrzJ12I4
         2sMQ==
X-Gm-Message-State: AOJu0Yxz4tBIxTScq1Qzjl7Vuzw/TkVbJ0aB2j7BuMJq+TtWj6OyAW+u
        Vsfaaa7/UmyySMXLZCzAuSW5YSQBGirYy6wMgDpKZndx
X-Google-Smtp-Source: AGHT+IFZfLxRVQoD/e7Ih9fkSn06wlC6Qiy0sEUhwulHz9Y4ZbSJa5WGc8/RCqxQMrIhPVL9IFfGJg==
X-Received: by 2002:a17:907:3f21:b0:9ae:546f:d9ad with SMTP id hq33-20020a1709073f2100b009ae546fd9admr12609930ejc.18.1695742782030;
        Tue, 26 Sep 2023 08:39:42 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id gq23-20020a170906e25700b009ad75d318ffsm8026476ejb.17.2023.09.26.08.39.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 08:39:41 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-98377c5d53eso1102666466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:39:41 -0700 (PDT)
X-Received: by 2002:a17:906:1097:b0:9b2:948f:369e with SMTP id
 u23-20020a170906109700b009b2948f369emr3540008eju.13.1695742780884; Tue, 26
 Sep 2023 08:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <ZRHTb8ctzeRq0-a6@slm.duckdns.org>
In-Reply-To: <ZRHTb8ctzeRq0-a6@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Sep 2023 08:39:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiH+mdeH3M6C1+5gZxoeR4f=Fi20TF8Zo_BEo70p1Ndnw@mail.gmail.com>
Message-ID: <CAHk-=wiH+mdeH3M6C1+5gZxoeR4f=Fi20TF8Zo_BEo70p1Ndnw@mail.gmail.com>
Subject: Re: [GIT PULL] Workqueue fixes for v6.6-rc3
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sept 2023 at 11:37, Tejun Heo <tj@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ wq-for-6.6-rc3-fixes

-ENOSUCHTAG.

Did you forget to push out?

                Linus
