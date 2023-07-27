Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A687A765CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjG0UMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjG0UMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:12:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879DBE47
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:12:00 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8ad356fe4so8770325ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690488720; x=1691093520;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wn8M5IW1Cx9z9W8X8Ql/iTEi3xFpPTK1V/bqvxk5oAA=;
        b=bbT99bJdu4sRjdxtAYwfODGngeD83nTVLOalwJyjsSVSlXP2u8fY/+zBMJbdP9va/V
         gWi4GyD0HeA+cuipXnXPpqXeFWYrwZni4kZtbbDtX2G2dqpveKf3eqVbzWJCbF9gsKje
         aublcSCyWE5d5wWbOddBF385cH/3VT8hx9dqMrof9e51gN574pctHjUYubsp+ajdWdyo
         1RodqQimE2n0j8NEKig/qI0DJgFxdVqf4fRBeexQLcmi1mqf7ihLcfssggzbEy8bn8Zk
         +GnpWr+asgcQ3TSF4ZcXig7wJQnewXfhaoBjmqDYqgCs1jPwQAZUELqamoE3XUqqRUVQ
         YZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488720; x=1691093520;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wn8M5IW1Cx9z9W8X8Ql/iTEi3xFpPTK1V/bqvxk5oAA=;
        b=FFs9cu6grjE0T8m9LafrF+mi9UxqsrEEkGGQx1k6PjogoexOOblIFlXiYBVFuJE108
         CcWquCA1ARbZeJET1Wp7n8m6M6ZAauegWjftcDi+R4ccCek8FARG+fIKh3Xa2HPRS4JK
         0gE3l8/E+MBmRTFKPQMtj5Bcq+0efROMXHr9LVlnzvrB7Iz/vR37OXS3uYeDfXiJd2BN
         4s53EiF/5tQIfL1wdReBy6qkGjgyzqUANVmk6HNO5qY5Xf3ft9YRMsURks2n2QNeKi0X
         xyAnznfoM1dTLoDWaNqa2GzhVHGIcfldu2HfV8zxKzYBfERtMd9/R5iyZp9J+ST5yefu
         TLPw==
X-Gm-Message-State: ABy/qLY3nPf8IvtuNINUhRqnVLh8peDJWElFHFsx51bTZ7XNV48+9/VC
        h3HhPHTX+hcNdJqZSb5vvu0=
X-Google-Smtp-Source: APBJJlH4tMZF9igEz61H7dr8xO9Mwrcfsn+GgzpF68QIJMZHlCr3vfp08IPuAM2YsE1Gqq9IwU52yQ==
X-Received: by 2002:a17:903:120e:b0:1b7:e646:4cc4 with SMTP id l14-20020a170903120e00b001b7e6464cc4mr442656plh.28.1690488719837;
        Thu, 27 Jul 2023 13:11:59 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902b7c500b001b891259eddsm2015611plz.197.2023.07.27.13.11.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jul 2023 13:11:59 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAHk-=wgeMOvL=ko_eruf5St7h0e9dVn4+GMKjcdshTJoxyD8tw@mail.gmail.com>
Date:   Thu, 27 Jul 2023 13:11:43 -0700
Cc:     Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2229115A-23F2-4B6B-800C-7182199DF79D@gmail.com>
References: <20230726214103.3261108-1-jannh@google.com>
 <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
 <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
 <20230727145747.GB19940@willie-the-truck>
 <8EA729DD-F1CE-4C6F-A074-147A6A1BBCE0@gmail.com>
 <CAHk-=wgeMOvL=ko_eruf5St7h0e9dVn4+GMKjcdshTJoxyD8tw@mail.gmail.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 27, 2023, at 12:39 PM, Linus Torvalds =
<torvalds@linuxfoundation.org> wrote:
>=20
> On Thu, 27 Jul 2023 at 12:10, Nadav Amit <nadav.amit@gmail.com> wrote:
>>=20
>> Interesting. I wonder if you considered adding to READ_ONCE() =
something
>> like:
>>=20
>>        asm volatile("" : "+g" (x) );
>>=20
>> So later loads (such as baz =3D *ptr) would reload the updated value.
>=20
> Not necessarily a bad idea.  Although I suspect you'd want to add
> *two* of them - on either side - to make sure any previous loads
> wouldn't be moved around it either.

You are right, two are needed.

I=E2=80=99ll give it a shot and see if I see changes to the binary.

