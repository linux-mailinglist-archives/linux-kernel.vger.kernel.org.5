Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88CA7B2EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjI2JLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjI2JLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:11:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60A4180
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 02:11:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-533d9925094so13948295a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695978695; x=1696583495; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgI7F1QkcpF3fuH0PAJshIndxiEkzxNkTkXPcD8K4PM=;
        b=jyBdkwo+8PpHD+2XyZzUiYsQrQPM2a/3KmTpSgebVTYKo+cwDK57BTnAdn40sL3GXx
         Ou1ONt2KmIMi1xUOpTS5YA6kuo68UTVoCxR+23ZI0awutpLpzD/JRuK3U7Hwn1ep8t/u
         GSwksY5IFoqb0UHu4VsXyfsanm1pYWkfEjIH0XI02Qbp8IHWVZJUS8HOeU5EpN6fuqGk
         /20jCkvnojbh5UCD4LOGzlUA50yqBugFwdgKLFVVSt7QIfbSqAad0gFAjg5KFnMdJHnV
         2fgPHWGGUm3w75zEc3wsH3pwr+ZHyfVjrxiGQcyXKonpeQCaqlGMHxjfDNBTiFw8xQTX
         c/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695978695; x=1696583495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgI7F1QkcpF3fuH0PAJshIndxiEkzxNkTkXPcD8K4PM=;
        b=sV/4aSiYoVNSXFE5x3RdjJ4fj3IFMU4ThNwB8YLH7gJB1VrFkebA1JlpfXrU/fEMrp
         jw51PXDbWv4gBipyB1k2s5QHKikoBovKTn6ZmlJAq6Y66MGNi58bXarzz4fehz2NsdR1
         W7qAR9BfKU5mZoZLvagKjWV1v7JQDEf3FAjlCQLsvCw6JF5QmW5+4fT61xUyZ9MGC+79
         LGDRe2f3WqKKfsDSbUJ8CSLYGdhM6uGq9tPKqotKYV8Yq9tXqYMDUvThAumn0uUk19Hr
         gNCLAQkBTHJZZAWHmk9AgALMAk7vAGZ2uLWwQYzaj5Tud5JeVTKBLoZAq2h0tNbSSfWa
         Apuw==
X-Gm-Message-State: AOJu0YzluOJgaVz0a+L41iIEs9a989+rLgSz2rGkjAYybFOSu7fStevq
        CAU6TOKKoIaLKi1H80BEXs8=
X-Google-Smtp-Source: AGHT+IGUpgzpwOKPFY2JKtFJ+l50wMSXQjDknrZIh6/H04ein1uwwg8hHFjV/xjPNl8zx50IhY885A==
X-Received: by 2002:a17:907:78da:b0:9ae:3d56:1ef1 with SMTP id kv26-20020a17090778da00b009ae3d561ef1mr3617835ejc.8.1695978695077;
        Fri, 29 Sep 2023 02:11:35 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id ck17-20020a170906c45100b00982a92a849asm12028566ejb.91.2023.09.29.02.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 02:11:34 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 29 Sep 2023 11:11:32 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RESEND PATCH 2/2] locking/x86: Wire up sync_try_cmpxchg
Message-ID: <ZRaUxDeQAuMy8UY0@gmail.com>
References: <20230925150905.54842-1-ubizjak@gmail.com>
 <20230925150905.54842-2-ubizjak@gmail.com>
 <ZRXnu+8gQGVZVA79@gmail.com>
 <CAFULd4Y6OUvscbDwBL2itM89pNbo3_Q2_mKR2G4DSSbyTdD1cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4Y6OUvscbDwBL2itM89pNbo3_Q2_mKR2G4DSSbyTdD1cQ@mail.gmail.com>
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Thu, Sep 28, 2023 at 10:53 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > Implement target specific support for sync_try_cmpxchg.
> >
> > Could you please provide a before/after description of how
> > this improves things exactly?
> 
> The improvement [1] was demonstrated in the original patch submission.

What I'm saying: please integrate the required context & arguments into the 
changelogs of the patches you submit.

Patches that change code generation should demonstrate what they achieve.

 - If existing code changes, then describe/demonstrate it with disassembly.

 - If existing code generation is unchanged, then *declare that property in 
   the changelog*, and mention that a future patch relies those changes.

You can either include that future patch in this series, or you can 
describe/demonstrate the benefits in the changelog while noting that those 
changes will come in future patches.

Your submission, as-is, provided no context whatsoever, it described only 
the 'how', not the 'why'.

Thanks,

	Ingo
