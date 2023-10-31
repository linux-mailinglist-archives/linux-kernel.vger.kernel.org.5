Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F8D7DD8AF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjJaW7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbjJaW6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:58:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25219F3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:58:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9d2c54482fbso492506366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698793088; x=1699397888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cFlFdFyuZUTwVztV7JYMt/a8X940EneiCRrMOYKDV4E=;
        b=XsiCjnwCF1KvcLp+iTsVBdm4shw3Sl4ZdEgCyyQQRt5W3HtXu3mwTqP1Ohw+h3QLkz
         kuRUyf3LX1pxXZoGXk0MzFHPY5NYvo2tlQit3Heoyh4WJ4nYW6Gk3r6aDXjkZC+n6rw5
         LCSFRddTi5wBmjZS5ExEQ58+oTlDbnhO90K9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698793088; x=1699397888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFlFdFyuZUTwVztV7JYMt/a8X940EneiCRrMOYKDV4E=;
        b=g4foJKuoGWU82kcFmapKKASc+YhnwScID9nQrCcicCnoTuJhWeEosbjD8n32Hfy4ve
         0Jd0h4NetYo6FrZFkTD57xBkXf/u+1q6SWQqq6mD3rMNEIK5+3MPCvg1eSo8rqzIjqRn
         n8xeX0PKwRkJwJC8OUfxm6vQZW0XrHbCX3Y75L1Ge5LV8hUXzzQUTfNNsdrCRya1EEOV
         tCkgUKEUOOnPX8PF5Etuo3txQschsHpEbItu9D5j59UQ2q0vYvbfNq4+ZnG1eIlJZMpC
         VTkfAWK0b86zjXnphzPhRWIOXCJGlD4o73Z/dsLM2zOtonGnXcwHE5MeImGai6m7ktJI
         bCiQ==
X-Gm-Message-State: AOJu0YxjOvturv8HGIm2bnIFoMlbhKdJMz8tqR0gfcvL9nbBW2swuc4d
        K8N+w9KI81V2qoeObwKiFxUpY8xUF4k5VYN3re51DN0B
X-Google-Smtp-Source: AGHT+IE/nzsEt7WAEXruhAv5p1a07TjYvUeSAv8A5mu3kQoo8I7fc/6R8Z0ko8yUn/+nKhCZWIx9aQ==
X-Received: by 2002:a17:906:c14f:b0:9bd:f155:eb54 with SMTP id dp15-20020a170906c14f00b009bdf155eb54mr589450ejc.6.1698793088436;
        Tue, 31 Oct 2023 15:58:08 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170906c35200b009887f4e0291sm1600295ejb.27.2023.10.31.15.58.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 15:58:08 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9d23be183c6so534271866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:58:07 -0700 (PDT)
X-Received: by 2002:a17:907:74d:b0:9a9:e4ba:2da7 with SMTP id
 xc13-20020a170907074d00b009a9e4ba2da7mr483778ejb.49.1698793087553; Tue, 31
 Oct 2023 15:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231028011741.2400327-1-kuba@kernel.org> <20231031210948.2651866-1-kuba@kernel.org>
In-Reply-To: <20231031210948.2651866-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Oct 2023 12:57:50 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjTWHVjEA2wfU+eHMXygyuh4Jf_tqXRxv8VnzqAPB4htg@mail.gmail.com>
Message-ID: <CAHk-=wjTWHVjEA2wfU+eHMXygyuh4Jf_tqXRxv8VnzqAPB4htg@mail.gmail.com>
Subject: Re: [GIT PULL v2] Networking for 6.7
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 at 11:09, Jakub Kicinski <kuba@kernel.org> wrote:
>
> We ended up with some patches pushed on top of the previous tag over
> the weekend. So I threw in one well-validated PR from IPsec and
> the crypto build fix. Crypto people say the removed code was questionable
> in the first place.

Well, I had actually already merged the original pull request, and
then started a full allmodconfig build.

And because I'm off gallivanting and traveling, that takes 2h on this
poor little laptop, so I had left to do more fun things than watch
paint dry.

I pushed out my original merge. I'll pull the updates later.

Thanks,

              Linus
