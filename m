Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83DE79F166
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjIMSwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjIMSwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:52:16 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E60C1BC8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:52:12 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso2171591fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694631130; x=1695235930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Qj9Z1rQiOVRFuIxsKJDJyO2OoNyojeG35brwDaLZgQ=;
        b=d5QJbEoRWpQ2nEetGEM2hXNIrWKepyH9sc02Igli9Z4bvlcITQXh4jZwq3ino2bEJg
         J+2A7eiUQeTgEV72fi+ooGNvZsuGaAK3WI4ntzb/nIKbsPUcFDUAOS8tjQpG5BWuSZyt
         kEGtw8f1YzU8zbMIfmWGu/V/gf5tbsETnu3V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694631130; x=1695235930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Qj9Z1rQiOVRFuIxsKJDJyO2OoNyojeG35brwDaLZgQ=;
        b=mBGM0qF0AnpbeY6ULK6/jIxLVWN4rz6BniB8iEPjOlAu5LQx1XldpbyD+RHnNZQ8Hs
         Ez2UUacPZ7WK0/Jud0aEYlpMFLxj1JQleOI333pfd5lb9j2u2NC0NGSA98DC/83xpkDw
         +DQgBD38Buk/9aLygK+zKjLv4cfcP5DJ895YI1rbJwqQv3TnEE5IIYB/7gm82Nf1rkBU
         mf3fwfh0WaZ23OBKxwTfRCDZYF5LLH/N/ctYcdzCxUJUdPUqns4HRxmOVmDs3+ZJG0F7
         7MUgVgQwo7rdQOKQG495wTOY9Xi9N0lv3hXb++A4RP40iI7rDcT/tQBuxLz/aJ6iQkvZ
         jQXg==
X-Gm-Message-State: AOJu0YyTkXqUblHWSD57OFLpypBHO5rPGZL4laXlukWzdQ7NFOKW9eyU
        YdPPm6Cz3+HJ3IT+m813SZ1HpgePQigiHy66nrWpO5D1
X-Google-Smtp-Source: AGHT+IF2vihqdBDw/zZrmCbxwDmB6UizLA409OL3WPlALpqtVRbBwftaJBwRRCY4uontlQmJHsQBrw==
X-Received: by 2002:a2e:9253:0:b0:2bc:f41a:d9bc with SMTP id v19-20020a2e9253000000b002bcf41ad9bcmr2954256ljg.25.1694631130368;
        Wed, 13 Sep 2023 11:52:10 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b009a9f00bdf8dsm8820948ejb.191.2023.09.13.11.52.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 11:52:09 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso22358666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:52:09 -0700 (PDT)
X-Received: by 2002:a17:907:761a:b0:9a2:185b:5376 with SMTP id
 jx26-20020a170907761a00b009a2185b5376mr2470433ejc.49.1694631129472; Wed, 13
 Sep 2023 11:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230912201102.1012306-1-jarkko@kernel.org>
In-Reply-To: <20230912201102.1012306-1-jarkko@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Sep 2023 11:51:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLB9_z5TcvRKVsSk3BWPfkDeWN0pDMdEv=-hnrnTgX1Q@mail.gmail.com>
Message-ID: <CAHk-=wgLB9_z5TcvRKVsSk3BWPfkDeWN0pDMdEv=-hnrnTgX1Q@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.6-rc2
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sept 2023 at 13:11, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> This pull request contains a critical fix for my previous pull request.

Please, less sarcasm and more actual helpful merge commit fodder, ok?

              Linus
