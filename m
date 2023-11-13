Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D717EA3A5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjKMTSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjKMTSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:18:22 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAEF1BE1;
        Mon, 13 Nov 2023 11:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SMqd4EqjIcBWaNJEJy3kwHzwVKqwQ0bk4Awnjz3pJgY=; b=lVt4SgLr063TeN8XyblCcp4C0i
        OeBGqN0AScamXEG5FlRkrb4uHFcaZfguSGkgXkVYxxlhdj5j8cPjWbPXjIdGStGwTNO3jmFLdyEVa
        mzTlBshUCglfjrfzOjPJ6XJpwj3+D7eNBT3r2AVfL87Dv756dYcYzW4rXDDVcGRdd9am+bYdx9DJx
        pirfn0BmJdAH6qaxfwYkdkbqLTdJMbfjz6odx8+ngbkG/WeSwT0xaF++KkWZnXll+cJ2gL+5Vb4tU
        QBVAj0MlIuyoK/jNBNF0QgZlVdj32fRbhathNAhoNcKfnmRF5wuT0LN84hazXm4cFVu5j153D3hAa
        qcIfOVJw==;
Received: from 189-68-155-43.dsl.telesp.net.br ([189.68.155.43] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1r2cR2-002qRU-OW; Mon, 13 Nov 2023 20:17:25 +0100
Message-ID: <eb176852-2912-1813-bcca-a7d1fe34f270@igalia.com>
Date:   Mon, 13 Nov 2023 16:17:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 0/2] Introduce a way to expose the interpreted file
 with binfmt_misc
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        sonicadvance1@gmail.com
Cc:     Kees Cook <keescook@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        oleg@redhat.com, yzaikin@google.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, willy@infradead.org, dave@stgolabs.net,
        joshua@froggi.es
References: <20230907204256.3700336-1-gpiccoli@igalia.com>
 <e673d8d6-bfa8-be30-d1c1-fe09b5f811e3@redhat.com>
 <202310091034.4F58841@keescook>
 <8dc5069f-5642-cc5b-60e0-0ed3789c780b@igalia.com>
 <871qctwlpx.fsf@email.froward.int.ebiederm.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <871qctwlpx.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2023 15:29, Eric W. Biederman wrote:
> [...]
> Currently there is a mechanism in the kernel for changing
> /proc/self/exe.  Would that be reasonable to use in this case?
> 
> It came from the checkpoint/restart work, but given that it is already
> implemented it seems like the path of least resistance to get your
> binfmt_misc that wants to look like binfmt_elf to use that mechanism.
> 
> Eric
> 

Thanks Eric! I'm curious on how that would work: we'd change the symlink
of the emulator? So, the *emulated* software, when reading that, would
see the correct symlink?

Also, just to fully clarify: are you suggesting we hook the new
binfmt_misc flag proposed here to the internal kernel way of changing
the proc/self/exe symlink, or are you suggesting we use the prctl() tune
from the emulator, like the userspace changing its own symlink?

One of the biggest concerns I have with this kind of approach is that
changing the symlink actually...changes it - the binary mapping itself,
I mean.
Whereas my way was a "fake" change, just expose one thing for the
emulated app, but changes nothing else...

Cheers,


Guilherme
