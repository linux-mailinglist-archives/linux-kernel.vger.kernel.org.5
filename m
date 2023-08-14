Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6694E77B8C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjHNMhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjHNMhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:37:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D203E4A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=VmbUR9tUP0TcTP+lPR92EBnfGUDP6/2qUwJVhdNUHNs=; b=rHFIPdQCNKT6dKcmT7hnfDKxtb
        sPjTomS5yXHNPdbBfSsv5p8eanIcFFMpdZq7KX3YDJ59RXoZnrzTIGxaMA9ANElpW8vXRKMlIVoAa
        XbOhpWp3ahvz2WGghZT8eOGC9Q+8Jj/rmIddaEoVUAa9ZlU+mmDKWxqCJ/VEc3VB9X6FxdoxVUrqF
        ELBfU9SvyTd5PxUEyJfLDlIFys74+ljtqn/vSPAe6iZPSMMBkoQjr6iFyBZbK1F1656opUQ+YQqBa
        uo9QnijZnqZsDjDKt3a2FDlh6448YhQiXYhToSI8in7gOdWOVL2tNDbGKLRMB9stgVdCYuZZTzChu
        2Ep/8muA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVWor-00Aac3-2R;
        Mon, 14 Aug 2023 12:37:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6946F300137;
        Mon, 14 Aug 2023 14:37:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51F0420C1700F; Mon, 14 Aug 2023 14:37:13 +0200 (CEST)
Date:   Mon, 14 Aug 2023 14:37:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: [regression/bisected] Add IBPB decreases performance in two times
Message-ID: <20230814123713.GI776869@hirez.programming.kicks-ass.net>
References: <CABXGCsNTaNw3q1OciYq111vdr+-ouaRVmwVqVJH4iT0NqxFAcQ@mail.gmail.com>
 <20230813082413.GAZNiTLaOxUNUHPvlf@fat_crate.local>
 <CABXGCsNoNaGLsuvHLRA7aG9FCckQpnXaXWoUGvRwzfRKNB4xzA@mail.gmail.com>
 <20230813093502.GBZNijxgueFxBTxWwG@fat_crate.local>
 <CABXGCsMrNz2SPYN=zLZTT7jU4axSi-XLm4bTm7K3NuWnc=yr9g@mail.gmail.com>
 <20230813111425.GEZNi7EXyHOLQTNzFg@fat_crate.local>
 <CABXGCsO5=tEB29apcnPRF92yLQR-LD--vSGYPfLWAm0Z+++HRw@mail.gmail.com>
 <20230813141945.GFZNjmgZbHvMhLYtJl@fat_crate.local>
 <CABXGCsNSZD8GG1ZbpeNg54rjnsa9HQ3MumTgprLo8n5WE2VCoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsNSZD8GG1ZbpeNg54rjnsa9HQ3MumTgprLo8n5WE2VCoQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 03:30:51AM +0500, Mikhail Gavrilov wrote:
> On Sun, Aug 13, 2023 at 7:19 PM Borislav Petkov <bp@alien8.de> wrote:
> > Nah, most people search the net and usually find the documentation, as
> > past experience shows. In this case, they will find:
> >
> > https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html
> >
> > It will be there next week but here's the source:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/hw-vuln/srso.rst
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > https://people.kernel.org/tglx/notes-about-netiquette
> 
> I am figure out why I noticed lage impact of safe RET on my system.
> safe-ret + KASAN = decrease performance for 50% in all scenarios
> I use KASAN on a daily basis to catch bugs.
> Is it possible for systems with KASAN to make a more optimal approach of SRSO?

Why do you care about speculation things on a dev box?
