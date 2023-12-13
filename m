Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6118118B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjLMQIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjLMQIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:08:04 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3039AB9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:08:10 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5906e03a7a4so4034706eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1702483689; x=1703088489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zx40J2tgT++jQyUHPjlcucWybX3M+OYwdkP2KsOFssw=;
        b=v6xRjipYNqny2t3PLnE9a/GANgh0nGHxwvnw1hGpNXXJSgPu0Qx3RvHSTyP2xh26eQ
         vwhodCOv+wJOwHlovI/Z3UaCbRGT6YhrdV4s8TqCnwSivxY1Pu5JxHi7//79avZrTjoL
         sTycrbYnyKINncXeoQtjoeiok1UA67J34rLWj+sYKKJlgKUP2SQCuJdvX9mmReMLDph+
         0rN/7JmeJ/omMwWAkLVrVozjl+esRVx587IlhAb6Z0FSEHhcZzkkGAe/ZXMXonZ1IAtX
         KZb3HLqc/bcKgM+OYFONFz9UDocN1xsuOawkuDjY0bIDv1jg8bhhd/kSWBnt1ve3iZo3
         L1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702483689; x=1703088489;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zx40J2tgT++jQyUHPjlcucWybX3M+OYwdkP2KsOFssw=;
        b=PB9fh05yS108K9bihhAa7DyCaTwrkc3d7RKrX2V4+GhMqU9WAqPVG2HzmDqckJpcGw
         FCTMgu3wi07YxKd2P+4d9E9Dj8nX4qGfDKn6o3mzl48PQf2YynAWQL3tA9fculM0jcnN
         Ojl02TvLDZB+dwxT4f/ACw+Tgdm7iGskj6FpZFJCl/TkMsjMTDazyK+YOwgQ8xidzyxS
         AvDTs8c7dnTBVBSkAihuOl2YTIEwRw7ztW38b/cNjDnL4f248Tv9mgogQ4TTs21/kcS9
         zdxYMC4Vwt51n8vmf1jkxhVvcmtKPhWOnVG7v3eWO9vNKJWvzsaEEMJ7bHYLTcxmpVMY
         L+2w==
X-Gm-Message-State: AOJu0YzHnNbMZ2Jsz1+cVzfLtH4Jv9oXSDrnPVRA1dYApPhjwYwkqRTH
        tNo+693kwDXbl7iVnQlXUf6REA==
X-Google-Smtp-Source: AGHT+IGITxIEovt83cuLdcufvp22b0EZLcRZg9QB7IG908WSa2cNw3Dz3M70QMDJmeNr8a0vmmx8vw==
X-Received: by 2002:a4a:d2d7:0:b0:58e:1c47:879e with SMTP id j23-20020a4ad2d7000000b0058e1c47879emr5926912oos.19.1702483689339;
        Wed, 13 Dec 2023 08:08:09 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id x6-20020a4aea06000000b0059030f95ebfsm3002852ood.41.2023.12.13.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:08:08 -0800 (PST)
Date:   Wed, 13 Dec 2023 08:08:08 -0800 (PST)
X-Google-Original-Date: Wed, 13 Dec 2023 08:08:06 PST (-0800)
Subject:     Re: [PATCH 0/3] Fix XIP boot and make XIP testable in QEMU
In-Reply-To: <20231212-crabmeat-flatness-3c0d02966551@spud>
CC:     vitaly.wool@konsulko.com,
        Conor Dooley <conor.dooley@microchip.com>,
        aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
        akpm@linux-foundation.org, andy.chiu@sifive.com,
        anup@brainfault.org, bhe@redhat.com,
        Bjorn Topel <bjorn@rivosinc.com>, chenjiahao16@huawei.com,
        cleger@rivosinc.com, haxel@fzi.de, greentime.hu@sifive.com,
        guoren@kernel.org, heiko@sntech.de, masahiroy@kernel.org,
        namcaov@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        samitolvanen@google.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-62fcfc9e-eb18-48b6-878e-839f28666560@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 07:14:54 PST (-0800), Conor Dooley wrote:
>
> Firstly, no html mails, they're rejected by the lists and break people's
> mail flows.
>
> On Tue, Dec 12, 2023 at 03:16:13PM +0100, Vitaly Wool wrote:
>> tis 12 dec. 2023 kl. 14:23 skrev Conor Dooley <conor.dooley@microchip.com<mailto:conor.dooley@microchip.com>>:
>> > On Tue, Dec 12, 2023 at 02:01:11PM +0100, Frederik Haxel wrote:
>> > > XIP boot seems to be broken for some time now. A likely reason why no one
>> > > seems to have noticed this is that XIP is more difficult to test, as it is
>> > > currently not easily testable with QEMU.
>> > >
>> > > These patches fix the XIP boot and allow an XIP build without BUILTIN_DTB,
>> > > which in turn makes it easier to test an image with the QEMU virt machine.
>> > 
>> > 
>> > Are you actually using XIP in something other than QEMU? The fact that
>> > some of the blamed fixes are over 18 months old suggests that you are
>> > not actively using XIP builds of the mainline kernel.
>> > There is a desire to remove XIP support (among other things), so if you
>> > do actually have a use case for it, speak up.
>> 
>> Yes, we surely do, on K210 for instance. It’s using an older kernel and
>
> The k210 and nommu are on the block for removal too :)
> Is your use case for either the k210 or XIP something other than
> "ooh this works"? 

Ya, if someone is actually using the XIP (and/or K210 or NOMMU) stuff 
then I'm fine keeping it.  We'd just figured it was probably broken 
because nobody'd been posting patches and we didn't have any automated 
tests.  Looks like it was broken, which is always a pretty strong sign 
it's not being used.

>> I haven’t checked the mainline status for a while
>
> I figured that when the request I sent asking if you could test XIP was
> ignored. We've been 50-50 on whether it has been broken since Alex put
> the dtb in the fixmap ~9 months ago.
>
>> but it is likely that I will come up with some XIP updates
>> before Christmas.
>
> May I ask what you intend updating?
>
> Cheers,
> Conor.
