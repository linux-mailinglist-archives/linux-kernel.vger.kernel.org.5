Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8197575439E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbjGNUQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjGNUQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:16:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C281330E3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:16:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51fdf291330so2805498a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689365764; x=1691957764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TCi4JKb/3T5Q8jv85vcDDFQkFfxKmRfuuTlKuPsFwKw=;
        b=DtHrILeEWOlfe+EiV+Vs3/AKv8rXChvrd7MN3TY+ZGT2KxR+a2V1nNxVACU/K8WzhN
         PiFvvyUcizPlAjTDPSdrRApY2OtxivlIjqb6Nb9fI95CjKO4qX+6284RcSaubL1wIQYO
         FNzMKF0uCyLUKzQJxspo8g+Q+m98DSQMDRa5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689365764; x=1691957764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCi4JKb/3T5Q8jv85vcDDFQkFfxKmRfuuTlKuPsFwKw=;
        b=hwTV1xqtUQK5QCZyCRuTbSFx3nRuipEMiVN4jW6lko61L3Phrpjbf4vMWY+Jh2Lepn
         DUxEwc7jUWVov0DrOHNLi1sGkvGMmuLIjtL6uHkExGHeF38QIUHF/e7g4a+5QGEBPLAx
         8VTrGzUl0eP0QRWka6XWW5uhdksP4whqrT9mhJw0rDWobME4zlqsXuKbtHVFbnxJqYFu
         TYJ62zxFx1uGijZb1O8rSP3lnGCltDkmfGUAs6eMXJmve9OoBUK4kGUOz8rK7UL1c1k4
         yj22hn/sVEQ3iuu2diqLtSTCoRCeRgWvorqTc2JWRzd3AY/Jo8qf1gESweWRo4AVMHEA
         pdNg==
X-Gm-Message-State: ABy/qLbHS6qpCNhNcKDWXYTxlwLC074KNe2jLKcy+Co61FBEpw0P4Lfw
        QebukFMBNOSt1YZkwOYFvCDa4r2YCwro2GKcpYVk41qw
X-Google-Smtp-Source: APBJJlFZuYWC1K76UoSxgHSnFNlIH+WTYfRVDkFKj9YlvNr+idoega3om+VhqWJfqvSFB5YfTitUYA==
X-Received: by 2002:a05:6402:b1a:b0:51b:fa0a:dc37 with SMTP id bm26-20020a0564020b1a00b0051bfa0adc37mr5596365edb.10.1689365764178;
        Fri, 14 Jul 2023 13:16:04 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id d10-20020a056402078a00b0051bfc7763c2sm6105675edy.25.2023.07.14.13.16.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 13:16:03 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51fdf291330so2805477a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:16:03 -0700 (PDT)
X-Received: by 2002:aa7:c6d3:0:b0:51d:9905:6f60 with SMTP id
 b19-20020aa7c6d3000000b0051d99056f60mr5040484eds.41.1689365762845; Fri, 14
 Jul 2023 13:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230714195551.894800-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230714195551.894800-1-Liam.Howlett@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Jul 2023 13:15:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wioXHeGOmMtLEAtx3enQ3TvtWudeAtK2bwoD0QyBN-GRw@mail.gmail.com>
Message-ID: <CAHk-=wioXHeGOmMtLEAtx3enQ3TvtWudeAtK2bwoD0QyBN-GRw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] More strict maple tree lockdep
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 at 12:56, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> This series of patches adds checks to ensure the lock is held in write
> mode during the write path of the maple tree instead of checking if it's
> held at all.

Ack, LGTM. I assume that there were no lockdep errors found by all this..

              Linus
