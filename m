Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7608076070C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 06:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGYEMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 00:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjGYEL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 00:11:56 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E63B1BCB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 21:11:52 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d16889b3e93so614523276.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690258311; x=1690863111;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rfSKEIdvDiXChG/0o+OpKXSikThIqoBp12joH4KG6gw=;
        b=PoRX9G9bv/It87yTRwxcp+1MQ7my6zVHV3vuUyQqWN4vYiW6cjqpELrv+g31I9xeYY
         s8JyLSJeI7jjz1odHqK+LCotLiaJWi4EcmLgD4qAfhiFca9yHSkM9HDyDaCFClqtdX1c
         8SUC2Tkm9/h57Q208E+4fJ5xVL08YBIBZrgXCrst4bQ9ZJLcmrzusd2pOcNXuF7oPeIg
         v76Ts+Sh+8NS0oal/fzapicBG+bsKTOI5amgiOFQ3GGF+9DTwzgub8ctvPDz+w/PHiWe
         tnnjBGBOW7/byVAT9f81cbgkcI5YiUo0DCIe2+5q8sEWO1qYAuDmX/5WJEJzj3t2XS3g
         9oXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258311; x=1690863111;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfSKEIdvDiXChG/0o+OpKXSikThIqoBp12joH4KG6gw=;
        b=curoiLQ7uuw6V9K3d8s36OsTHrbVkhf6poW8Uwd/nwnpXRTPQ0id8mjM8tsz9MSnY9
         VmbhDl8GFay/EuKnlev7Xcz3OsfhM50uc0eJtYIIujgNTX4l3mzHE+ibYTitUeejvawD
         /mTgxSCaAUqOy1LNrqQOwwlRXJ8PZlcNqPD3tF4qu2ip+f/umcOtGCsN5fSnAmL7DAK7
         YUWFbG4o7OwAY68BOwHk2plMBLnUVekPEhgbr1tXD4xJr5pnSCeUVqKzcQvhZLu10nvu
         hov32Wbdtd+WwzZ0jj4z9bekY1UeZlAWHQi0ckivR+Y16zVyNpIv3neN6McBZcHL+H3e
         ppRg==
X-Gm-Message-State: ABy/qLbV6ppyVn+r6NkvrrMCSIvO027H0Bn0xum1qr2lzPQKilonU16z
        Q+xT/oyzJeNg/LLmvUZk/uuwyg==
X-Google-Smtp-Source: APBJJlEyAzXnvxyVs+M9uV3cC0NGEPwn1O5Jm9w54HLMJ1fOwrkySCg7J1mN7bZqr33RcepW15GYFA==
X-Received: by 2002:a25:2983:0:b0:d07:f1ed:51f7 with SMTP id p125-20020a252983000000b00d07f1ed51f7mr8005481ybp.43.1690258311474;
        Mon, 24 Jul 2023 21:11:51 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u35-20020a25f823000000b00d07a7bbe4acsm1811961ybd.19.2023.07.24.21.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:11:51 -0700 (PDT)
Date:   Mon, 24 Jul 2023 21:10:59 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm-hotfixes tree
In-Reply-To: <20230725135546.28334fe4@canb.auug.org.au>
Message-ID: <3084e97c-3a7d-ace8-2e9c-31642fd663df@google.com>
References: <20230725135546.28334fe4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023, Stephen Rothwell wrote:

> Hi all,
> 
> After merging the mm-hotfixes tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/filesystems/tmpfs.rst:116: ERROR: Malformed table.
> Text in column margin in table line 4.
> 
> ===========  ==============================================================
> huge=never   Do not allocate huge pages.  This is the default.
> huge=always  Attempt to allocate huge page every time a new page is needed.
> huge=within_size Only allocate huge page if it will be fully within i_size.
>              Also respect madvise(2) hints.
> huge=advise  Only allocate huge page if requested with madvise(2).
> ===========  ==============================================================
> 
> Introduced by commit
> 
>   a0ebb5aa2de3 ("tmpfs: fix Documentation of noswap and huge mount options")

Sorry about that, Stephen: thanks for the report.

Randy, you're always my goto guy for how to get these Doc things right,
I hope you don't mind.  I just write the text as I want it to appear,
then get caught out by unfamiliar rules.

Please suggest a fixup to the fix patch if you can - thanks!

Hugh
