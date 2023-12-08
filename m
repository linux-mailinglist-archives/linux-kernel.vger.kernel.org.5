Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D5880AC18
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjLHSeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjLHSeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:34:16 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D81A3;
        Fri,  8 Dec 2023 10:34:22 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db539ab8e02so2729376276.0;
        Fri, 08 Dec 2023 10:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702060461; x=1702665261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejXhmdckIcdGK+pLdIJWhvkjFAhDWBpYsBAzxp0p6Sk=;
        b=luSeH7dfYpc+aRNooJ4mZKwo+hBFMPZnrwEXVyyWBZ6JU3xkDwYct7YIOgy5TqYseF
         vU+iAFSRSlJe0lZa+aiX+mgTkSc1N5aRAatG+8LX0PoeSmIOEqHNUG3GrghB/S2Mwy5y
         mX5AsF2TvmCLwqnPTrfgQ6OK7XDLNCw29gp52ChONPbJEYxYj00aEDB+SE5RidQJRcj3
         IwGYtbjLL6YD6oOCUOJwd4D9oxihiBssjLXtwN19asJsSB49WcztZgLx1Qrd+Jo33miz
         x6qhlrrP5xLyPgXYcqCaD0mryKDnJb93C49f/TsZluLCbpBqEwczC6vidoRQEujXT7B/
         cGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702060461; x=1702665261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejXhmdckIcdGK+pLdIJWhvkjFAhDWBpYsBAzxp0p6Sk=;
        b=QPP4C8QEJ2U7uOreGmB39YNDxE7xv0uVskPrGM2flm117ifqK8cTxLi76TygKz5sv3
         krAwNXhS7eIcuewxpQw2o+JzHlQFbrM/q8ROV46/Y1kCFajzr/DIjj6favNmB0ivXpja
         Dvy+a8bdnQsFSAaMk/qc8alBPCu/MJuGyNfcg9EJecp+gg4mCStGT8/+qwGb5ERd3ndr
         H1TMCaCpzBQwlDJLSlOLykGQIyAPF0XTpcpi7/1TDwnh/PdQhBp6B0zHE+OaLdU9pT5H
         +QPRAQG4M5ishSEbnFhDGmrd7+bMlKpgcBnBhqJ3mJKGhWObcaUXz6Qi7nTsmoOj9bTw
         4qEA==
X-Gm-Message-State: AOJu0Yy4DKFXrT4aQM2CNnzZZj6O09oU0e8E+E1Fne+uoFvnn+cakXHl
        ubIMMcOrAD9qQKTDh6xdk2E=
X-Google-Smtp-Source: AGHT+IEo4kabG9Kr8bM11ACqdXlyVWy2Ht8cWzY6VZk7DZnzbZ273qR/eHeRAbXyGbTiJm9T0P8ioQ==
X-Received: by 2002:a25:c3:0:b0:db7:dacf:ed98 with SMTP id 186-20020a2500c3000000b00db7dacfed98mr361626yba.121.1702060461588;
        Fri, 08 Dec 2023 10:34:21 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cd3e:7dc3:93ad:7de2])
        by smtp.gmail.com with ESMTPSA id i20-20020a25bc14000000b00d995a8b956csm767232ybh.51.2023.12.08.10.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:34:21 -0800 (PST)
Date:   Fri, 8 Dec 2023 10:34:20 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v2 14/35] PCI: hv: switch hv_get_dom_num() to use atomic
 find_bit()
Message-ID: <ZXNhrHWLu6LydQvp@yury-ThinkPad>
References: <20231203193307.542794-13-yury.norov@gmail.com>
 <20231204191427.GA623236@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204191427.GA623236@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 01:14:27PM -0600, Bjorn Helgaas wrote:
> On Sun, Dec 03, 2023 at 11:32:46AM -0800, Yury Norov wrote:
> > The function traverses bitmap with for_each_clear_bit() just to allocate
> > a bit atomically. We can do it better with a dedicated find_and_set_bit().
> 
> No objection from me, but please tweak the subject line to match
> previous hv history, i.e., capitalize the first word after the prefix:
> 
>   PCI: hv: Use atomic find_and_set_bit()
> 
> I think there's value in using similar phrasing across the whole
> series.  Some subjects say "optimize xyz()", some say "rework xyz()",
> some "rework xyz()", etc.  I think it's more informative to include
> the "atomic" and "find_bit()" ideas in the subject than the specific
> functions that *use* it.
> 
> I also like how some of the other commit logs clearly say what the
> patch does, e.g., "Simplify by using dedicated find_and_set_bit()", as
> opposed to just "We can do it better ..." which technically doesn't
> say what the patch does.
> 
> Very nice simplification in all these users, thanks for doing it!
> 
> I assume you'll merge these all together since they depend on [01/35],
> so:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thank you Bjorn!

Now as many people asked to move their subsystems patch together with
#1, I think, if no objections, it's simpler to pull all the series in
bitmap-for-next.

I'm going to align commit messages wording, as you suggested, address
some other comments, and will send v3 this weekend.

Thanks,
Yury
