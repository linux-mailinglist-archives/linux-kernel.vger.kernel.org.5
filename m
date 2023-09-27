Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EE37AF7DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 03:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjI0B4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 21:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbjI0ByD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 21:54:03 -0400
X-Greylist: delayed 392 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 18:00:44 PDT
Received: from o-chul.darkrain42.org (o-chul.darkrain42.org [74.207.241.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83E616E81;
        Tue, 26 Sep 2023 18:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=darkrain42.org; i=@darkrain42.org; q=dns/txt; s=ed25519-2022-03;
 t=1695776052; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : content-transfer-encoding :
 in-reply-to : from; bh=bVtmHHpgJCvGOFI6j4m1G3ZAqun1acSnHjfkUYd7U/I=;
 b=9CNMYB3TlWXem1lRqknxmOBYkF+aJVQ/zUy4wfeS5FtjpV50zJv4hKs6uPjnk+l7o7TFY
 vRQhlrEG+oguS1pBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=darkrain42.org;
 i=@darkrain42.org; q=dns/txt; s=rsa-2022-03; t=1695776052; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : content-transfer-encoding : in-reply-to : from;
 bh=bVtmHHpgJCvGOFI6j4m1G3ZAqun1acSnHjfkUYd7U/I=;
 b=W9a9iBrXr2byHDgqBLXaHtOItJyJQ/wrXhNEfrls49oh93nGVDFbCnwo18KdU1lhyYgeR
 wE4syUf8u6MD7hQmm2Qtix/rsrqGJ2/TPqohtkz2HSH6si6f50Ml96bvcjdtum8NuvYcCgY
 sFKj1GQUW+CcEyGqwo7ZOx/xghZzrz62LyghWF7vZeQc8W4v4kumfB9qwU6mkaIciIU4Sij
 dAhherZwqLUtl3DuxF+yWF4YZ0bcGHLV6KBwI6G0oRYItqMrXROxfVC3l7k8Vd4t1x2bRgI
 RnvW6EpERdjYfnSMPXTzxKfqTbtSceFm1jGa9SMx/1LevQ2WwjBpQytF9g0Q==
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature ED25519)
        (Client CN "otters", Issuer "otters" (not verified))
        by o-chul.darkrain42.org (Postfix) with ESMTPS id 049828162;
        Tue, 26 Sep 2023 17:54:12 -0700 (PDT)
Received: by vaarsuvius.localdomain (Postfix, from userid 1000)
        id 96EC58C247B; Tue, 26 Sep 2023 17:54:10 -0700 (PDT)
Date:   Tue, 26 Sep 2023 17:54:10 -0700
From:   Paul Aurich <paul@darkrain42.org>
To:     Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>
Cc:     Brian Pardy <brian.pardy@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Paulo Alcantara <pc@manguebit.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Bharath S M <bharathsm@microsoft.com>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS
 share is mounted (cifsd-cfid-laundromat in"D" state)
Message-ID: <ZRN9MtBqYnT6oX60@vaarsuvius>
Mail-Followup-To: Steve French <smfrench@gmail.com>,
        Tom Talpey <tom@talpey.com>, Brian Pardy <brian.pardy@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Paulo Alcantara <pc@manguebit.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Bharath S M <bharathsm@microsoft.com>
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me>
 <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
 <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
 <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com>
 <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com>
 <CAO+kfxQtOKoKdb+LtMeFxgu8VXa73nbmTPSfscbdwjUXM7ME_A@mail.gmail.com>
 <CAH2r5msNf9WDHrBZSi5FhHDSewSNxMAuXTetMJDnoNh3CF_oMA@mail.gmail.com>
 <a895f860-11fa-e6d9-d042-a32bd08f9e9d@talpey.com>
 <CAH2r5mszCxPtdURenMVgeVDX5zc8knumH=ASXyUufPa7SxbJBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5mszCxPtdURenMVgeVDX5zc8knumH=ASXyUufPa7SxbJBw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-19 13:23:44 -0500, Steve French wrote:
>On Tue, Sep 19, 2023 at 1:07 PM Tom Talpey <tom@talpey.com> wrote:
>> These changes are good, but I'm skeptical they will reduce the load
>> when the laundromat thread is actually running. All these do is avoid
>> creating it when not necessary, right?
>
>It does create half as many laundromat threads (we don't need
>laundromat on connection to IPC$) even for the Windows server target
>example, but helps more for cases where server doesn't support
>directory leases.

Perhaps the laundromat thread should be using msleep_interruptible()?

Using an interruptible sleep appears to prevent the thread from contributing 
to the load average, and has the happy side-effect of removing the up-to-1s delay 
when tearing down the tcon (since a7c01fa93ae, kthread_stop() will return 
early triggered by kthread_stop).

~Paul

