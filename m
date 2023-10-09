Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8F7BDA32
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346236AbjJILmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjJILml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:42:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196B699
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:42:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so2582111f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696851758; x=1697456558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvJorMuFBXShUBAbYuXfd7JQ2grUfnhQ9ROdTAA57lQ=;
        b=KEI7b1APbjIoGBGmscv9ht2SGC/WFaS5PpStI9SXsEabrTYKDUBeTWsUhEFMs/MJnN
         BnfIEt3bYeXy7f0YGX49CNcO8hEVSnT2hqXqKR/Wk3wA8PYrOWlf4JQD2fdkDq3KdRFd
         XH47+zRNGqZi6B5u6oJvfA3t0la2Jx74OuKKVWQDWFgmRKbP7aZA4TXbnPyjqK9rygU1
         jqECAEp279PR8qOONhq11xkNA2kAsqP9OBE3QxvaT2uRmU0MgfW6KQE69l9gOHTBNaZp
         o4Oloaxt9t+swUiaBWDFcO3UbVDQZLxgto7FLmViM7VIXdiIfqI9u1yrVKP1dSdQtNeW
         2vRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696851758; x=1697456558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvJorMuFBXShUBAbYuXfd7JQ2grUfnhQ9ROdTAA57lQ=;
        b=t8XSyNrDPlOkBSsR+xXlGd9RejhEK3Z4pqh/ckVN2vvGSu+7olAz/sBSJusXY2EsOG
         vmYWiaQo6I3M0srE3iyp7luZXbK+HRgTUjK4MtoaFQaJ55ooej/tWYXWXR+xGUQNdFjK
         pQydea5donhpiftHVyxCvN22yKj7B3V+pnEMxf5pZxDWbrBQbsuSJly8VP4DK/Rbf+UZ
         kYb2lMujrGYu2LCWgVqAr8mnb2C2IaVLsfe5RUqfmLXWvdPryzJIQXF1q6MBSvkiTkL4
         FQPW4etuHH/BlZhokWaQErKNQVXS8C7ScwnaUCMUUktzMKCUNzu79javeqiM4S8tV8R1
         gEaQ==
X-Gm-Message-State: AOJu0YxR0u2SdGqaR4vGbyETXcOs8Fq6g9wMbpGsZX/ov2ZZvAzoas7a
        nmEVl6/ZDlFVowwvP7zwmUs=
X-Google-Smtp-Source: AGHT+IEC37Xha18STZ3mfexgQStjZoXsXpZAcA4ENZUNd1JUjTcurabED8P2/dUUQDcFpQsBtI5ZyQ==
X-Received: by 2002:a5d:4ace:0:b0:327:d08a:1fa2 with SMTP id y14-20020a5d4ace000000b00327d08a1fa2mr12722639wrs.36.1696851758256;
        Mon, 09 Oct 2023 04:42:38 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040535648639sm10946866wmm.36.2023.10.09.04.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:42:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Oct 2023 13:42:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
Message-ID: <ZSPnK8yi9mLdXwkl@gmail.com>
References: <20231004145137.86537-1-ubizjak@gmail.com>
 <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
 <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Uros Bizjak <ubizjak@gmail.com> wrote:

> I have tried the trick with all reads volatile (and writes as they were 
> before the patch), but it didn't make a difference. Also, the kernel from 
> the git/tip branch works OK for default config, so I think there is some 
> config option that somehow disturbs the named-as enabled kernel.

Yeah, I made sure tip:x86/percpu boots & works fine on a number of systems 
- but that testing wasn't comprehensive at all, and I didn't have KASAN 
enabled either, which generates pretty intrusive instrumentation.

Thanks,

	Ingo
