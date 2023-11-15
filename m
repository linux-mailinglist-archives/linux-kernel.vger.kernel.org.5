Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6CF7EC905
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjKOQxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKOQxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:53:32 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABB4196
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:53:29 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9f2a53704aaso130693666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700067207; x=1700672007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1sF8rVm6qSPjNpZ4MRVa5Fv/0C/XbN0BqIbvH3bfCTs=;
        b=CittDcDJ1wVtSCjyL5fWXInFxIdKqCscNgE6EYK44k4QZ/ipZHrR3qytruJT0WAETo
         dMBZfxKsMhHxi9tztR4OF5e3hjUf3/G9tQPal0JOVDVKngpibDTamOnqHictQpYmuw8O
         fzNqjrg+oYXVnis1XPxyCNTyMY0opFFdZP1kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067207; x=1700672007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1sF8rVm6qSPjNpZ4MRVa5Fv/0C/XbN0BqIbvH3bfCTs=;
        b=bspEO+BnREi8+k7B6zALKeY1boOwBLTG1ca3pJoeCs50Id8EcE3Xy4rKWIgYUinuML
         6adPNpUTDoR5f9RECvhSCQc1Sbf7B4seiYmz4VmF+56ZoeUes02kxzAKj7xF6A8rNPSr
         HrlaVqdEHxIlQPcTpAuzCmoTNjd8nob8WQ0iXgeFYF6xS86Vi9hUNyuES2LCCPFYzIkh
         /W9VNN3RVOXcSioAiqCs9FJGsjllVvw6/ktNG8Nk+BAAeHcNix2n6PjxEZCLoJ2Ezmc7
         vDoH1P8jcKsChft/yv7LZe2p9axIr4WymeBKVPa9N9K/jhzItnUOj0hdUiwgUUnrFZiv
         Fwxg==
X-Gm-Message-State: AOJu0YzgS+6WRsUIkk6X22mreced9hNL11fGw0PFloN2lA7lgiSOOtmM
        T1ZDTyaGky6ctfgrUWjPv8tlyLZBnU+Gg2kLz1GnagbF
X-Google-Smtp-Source: AGHT+IGWCa13hpHFy/o8hN8xeuMjS0+P4Toqm3Ei1NOAj2IVMRtqzFvkQ+v8Cfh3LEBXqSMYF9y36Q==
X-Received: by 2002:a17:906:d9b:b0:9e5:d268:d750 with SMTP id m27-20020a1709060d9b00b009e5d268d750mr9536577eji.60.1700067207347;
        Wed, 15 Nov 2023 08:53:27 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id l4-20020a1709066b8400b00988e953a586sm7248886ejr.61.2023.11.15.08.53.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:53:26 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so10878391a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:53:25 -0800 (PST)
X-Received: by 2002:a05:6402:1052:b0:542:d69d:d075 with SMTP id
 e18-20020a056402105200b00542d69dd075mr8367028edu.6.1700067205341; Wed, 15 Nov
 2023 08:53:25 -0800 (PST)
MIME-Version: 1.0
References: <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
In-Reply-To: <3865842.1700061614@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 11:53:08 -0500
X-Gmail-Original-Message-ID: <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
Message-ID: <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
To:     David Howells <dhowells@redhat.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 10:28, David Howells <dhowells@redhat.com> wrote:
>
> But the outcome is a bit variable and the result spaces overlap considerably.
> I certainly don't see a 17% performance reduction.  Now, this may be due to
> hardware differences.  The CPU I'm using is an Intel i3-4170 - which is a few
> years old at this point.

I tried to look at the perf profile changes in the original report,
and very little of it makes sense to me.

Having looked at quite a lot of those in the past (although certainly
less than Oliver) hat's *usually* a result of a test that is unstable.

In this case, though, I think the big difference is

  -11.0  perf-profile.self.cycles-pp.memcpy_orig
  +14.7  perf-profile.self.cycles-pp.copy_page_from_iter_atomic

which is a bit odd. It looks like the old code used to use a regular
out-of-line memcpy (and that machine doesn't have FSRM), and the new
code for some reason does it inline.

I wonder if gcc somehow decided to inline "memcpy()" in
memcpy_from_iter() as a "rep movsb" because of other inlining changes?

[ Goes out to look ]

Yup, I think that's exactly what happened. Gcc seems to decide that it
might be a small memcpy(), and seems to do at least part of it
directly.

So I *think* this all is mainly an artifact of gcc having changed code
generation due to the code re-organization.

         Linus
