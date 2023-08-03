Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B5B76F460
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjHCVAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjHCVAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:00:30 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D9B1AB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:00:29 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40fc654bea1so9904641cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691096428; x=1691701228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QuYitPJZqMO1br4FQSyqi//ppdhPI+NAR1KWcWA6710=;
        b=gs0xR52ZjdCvuFTwrpGe2Hferm5v3XQEZVvpsyDiKFWkASHv9XT1wstoTnEmVPTceU
         HIvA62wJaNYL4R5ZVKOPdmg1/irCFyXEeyWNdqwji2wYZkkeLuMVyk7Sk3nsu56Znp3a
         1QOBVdF3FH0vXdnA9Qvoq4KSR0DruXQOmV0X55BFmsZrINuvbqHmlmKCGPAcuj6H44fG
         JmsY0Se94Ure36WyDpTVwGNfaWQuaKLEG3h5QfhG7wtk6nNZ7VWfxpT4bZu/iftNyE9l
         52LX89W4PvME1n4Y9o0NusD5zJBO/aTRZL4P7sBEkNUx2LPojjb9/juXBxvHnYAyGHxQ
         zi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691096428; x=1691701228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuYitPJZqMO1br4FQSyqi//ppdhPI+NAR1KWcWA6710=;
        b=QOfS9CC6yV3R+OCEDYP7fscvj/fe4Q9kXohb7cQTr27ewa6ZO+PuFVgFidozOwDzQe
         QtJwkkClyrF66gSamLhuRWGi3z/9j06FNTDAEhdYNmkACn18zXESEpclMQK8Dx8Dt690
         VO8PZil4xYGnyq1k1mFA9hf0SlbKPs0ykOzyRLA016h0yKAPFY2dQUYjfQd7RdR1G2YT
         6kzZkk3d0en4sNAYudjd2gC7S4bDKhBGYgwad/vTupD2/ASOkMj0Cfl1VpSTN8GjGLIN
         ICJ+vyaMCTxnWjDdh34BfseR31BCOd7CI0YsWmkRMCopVuBI+YPJcRVJIE91X0YBUkxd
         08Tg==
X-Gm-Message-State: ABy/qLb+4Cz9ucjvkSYpzGJivb6z64C+KX6MPgDOl68FqqnPc7CXIPcz
        HH0DyK2QFHjq1qEGrtTmRdHOFhj5mJ8=
X-Google-Smtp-Source: APBJJlGr+LkTYffTZjsB4B1e2iFyJt/S4Es0pSTq8xjeuH9kP8L7uZali5AbwiRWzLyQcPfbVcJalQ==
X-Received: by 2002:ac8:7d90:0:b0:403:eb3c:1fed with SMTP id c16-20020ac87d90000000b00403eb3c1fedmr24878626qtd.35.1691096428036;
        Thu, 03 Aug 2023 14:00:28 -0700 (PDT)
Received: from localhost ([50.217.79.158])
        by smtp.gmail.com with ESMTPSA id e21-20020ac85995000000b003fde3d63d22sm189653qte.69.2023.08.03.14.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 14:00:27 -0700 (PDT)
Date:   Thu, 3 Aug 2023 14:00:26 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, rppt@kernel.org
Subject: Re: [PATCH v2 2/2] mm,nodemask: Use nr_node_ids
Message-ID: <ZMwVanb0nTbOiWyn@yury-ThinkPad>
References: <20230802112458.230221601@infradead.org>
 <20230802112525.633758009@infradead.org>
 <20230802193616.GC231007@hirez.programming.kicks-ass.net>
 <ZMr4uBfjKY9dERl2@yury-ThinkPad>
 <20230803084125.GE212435@hirez.programming.kicks-ass.net>
 <ZMwRBqTgkvA7o9x3@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMwRBqTgkvA7o9x3@yury-ThinkPad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Consider MAX_NUMNODES == 64 and nr_node_ids == 4. Then
> small_nodemask_bits == 64.
> 
> The nodes_full() will set all 64 bits:
> 
>   #define nodes_full(nodemask) __nodes_full(&(nodemask), small_nodemask_bits)
>   static inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
>   {
>           return bitmap_full(srcp->bits, nbits);
>   }

Damn, copied the wrong function. This should be nodes_setall() of
course:

  #define nodes_setall(dst) __nodes_setall(&(dst), large_nodemask_bits)
  static inline void __nodes_setall(nodemask_t *dstp, unsigned int nbits)
  {
          bitmap_fill(dstp->bits, nbits);
  }

 
> And the following nodes_weight() will return 64:
> 
>   #define nodes_weight(nodemask) __nodes_weight(&(nodemask), small_nodemask_bits)
>   static inline int __nodes_weight(const nodemask_t *srcp, unsigned int nbits)
>   {
>           return bitmap_weight(srcp->bits, nbits);
>   }
> 
> Which is definitely wrong because there's 4 nodes at max. To solve
> this problem, both cpumask and nodemask implementations share the same
> rule: all bits beyond nr_{node,cpumask}_bits must be always cleared.
> 
> See how cpumask_setall() implements that:
> 
>   static inline void cpumask_setall(struct cpumask *dstp)
>   {
>           // Make sure we don't break the optimization
>           if (small_const_nbits(small_cpumask_bits)) {
>                   cpumask_bits(dstp)[0] = BITMAP_LAST_WORD_MASK(nr_cpumask_bits);
>                   return;
>           }
> 
>           // Pass the exact (runtime) number of bits
>           bitmap_fill(cpumask_bits(dstp), nr_cpumask_bits);
>   }
> 
> Hope that makes sense.
> 
> Thanks,
> Yury
