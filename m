Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBA17A2BEB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbjIPAYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238212AbjIPAX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:23:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018D83AAC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:18:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-500913779f5so4362764e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694823371; x=1695428171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zporDHrE3+uyIwe+VfbiYR93jfa43r8rLTR9B3l5F9o=;
        b=FGtUYMjDUo/vxqvnL/p+dNQbjJOsMfDK3U2ckYlvp+9DYiXRDoWIjEBXh6VR3StVHn
         G4FTwxGQZ5GWYbDk+lk+BbGQ21FXo///kUv29067Gbg334dPOnB7HfYS70gnDDIfTnmO
         JJ7WKakV/+f4qF+M7EWaRFP+WW16+8Z+GnYEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694823371; x=1695428171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zporDHrE3+uyIwe+VfbiYR93jfa43r8rLTR9B3l5F9o=;
        b=ijcGqahXq9l1nwZlg0RG/YNKMw85wmCmMShqx0RTTX/T+I/X0j88yTL84phc7Iqrwt
         DRI/pfTyOD2aQICv7IMj9fYX0tIsYMWtqixRqQeVYYPV9WdAZPMBgS+ThzZogJMLjYfA
         8hZD3eweC2a98/I0FWGQYUApIeRCz9eifBJXl+d8EzNb6Q7S6NFLBhQpS3wg3gN6e+Lp
         FqzkYlg5+f5FZTCZwE26L43a8gsr8fFM7HtO7p40VDtUDYVttZSC/Fa3E9nO9t99/lfK
         6XtUEx3P8DBku0yHJYAeVBva3bFCy9lmKK9syWEdy7wdcOhQH88lyMuedZ0EDF20H0VN
         MJ2A==
X-Gm-Message-State: AOJu0Yw3rugsFs8TmwNM3OZYvDiekcMAFef28+k7ZSR25QHSF21s2Y5f
        Z0LBRiwSM56s+ScLPTrANEkS5RL9BlP7kSzQK2NWS/q/
X-Google-Smtp-Source: AGHT+IFh0nh63BTwu/MTERQMlTx2bHXs44guxY0gEA76k9Wfopf4LlPitAKyc1i0u/H9Yu9iTQ/meA==
X-Received: by 2002:ac2:4db3:0:b0:502:9bd7:ec79 with SMTP id h19-20020ac24db3000000b005029bd7ec79mr2629473lfe.29.1694823371091;
        Fri, 15 Sep 2023 17:16:11 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id b17-20020ac25e91000000b004fb7848bacbsm800625lfq.46.2023.09.15.17.16.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 17:16:10 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-500913779f5so4362748e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:16:10 -0700 (PDT)
X-Received: by 2002:a05:6512:3113:b0:500:bc14:3e06 with SMTP id
 n19-20020a056512311300b00500bc143e06mr2583654lfb.44.1694823369876; Fri, 15
 Sep 2023 17:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-3-willy@infradead.org>
 <CAHk-=wh4=cYh5OC5PiiX_nAQkyViXL21bpmaARduGOLiOOgTyw@mail.gmail.com>
In-Reply-To: <CAHk-=wh4=cYh5OC5PiiX_nAQkyViXL21bpmaARduGOLiOOgTyw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 17:15:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqZqTYunL-0tn2-khCU1rcZDrTvY4cdFsx_b_bF=xbGw@mail.gmail.com>
Message-ID: <CAHk-=whqZqTYunL-0tn2-khCU1rcZDrTvY4cdFsx_b_bF=xbGw@mail.gmail.com>
Subject: Re: [PATCH 02/17] iomap: Protect read_bytes_pending with the state_lock
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 17:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
[...]
>         if (unlikely(error))
>                 folio_set_error(folio);
>         else if (uptodate)
>                 folio_mark_uptodate(folio);
>         if (finished)
>                 folio_unlock(folio);
>   }

Note that this then becomes

        if (unlikely(error))
                folio_set_error(folio);
        if (finished)
                folio_unlock(folio, uptodate && !error);
  }

but that change would happen later, in patch 6/17.

             Linus
