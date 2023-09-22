Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573BD7AB71C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjIVRU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjIVRUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:20:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593E1F1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:20:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC67C433C7;
        Fri, 22 Sep 2023 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695403218;
        bh=IRau8b5XGe3qEYgJQvRo4yzSY5zEVQssEPPROArtjug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SdX6tRI4jMHI7b7K67i9g314zNNszN6vEJLecg9UFiF+cebpsKDyHIsQrhvfjBQX0
         ky6HdGeB74v+yS+mYqEe0HJyTJzY6Imvxt3ZexpbbSQPfZowZhxVOVf7tquOmjTbgJ
         tQ8PkASq2Vb+F0t7Nm0KIO9RjyGhZBmZkYaCaObQ=
Date:   Fri, 22 Sep 2023 10:20:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [EXTERNAL] Re: [PATCH v3] mm/thp: fix
 "mm: thp: kill __transhuge_page_enabled()"
Message-Id: <20230922102016.95cab3640b17155a846874d9@linux-foundation.org>
In-Reply-To: <CAAa6QmTnx=kEijosNfq0DEPz4TeHFeOrgtwO0wfEeFUS5hgROw@mail.gmail.com>
References: <37c2b525-5c2c-d400-552c-9ccb91f4d7bf@redhat.com>
        <CAAa6QmSHF6-9aFa68WDcb+WATh2Yz=wXyp8VBLDNv6yPp2SS5Q@mail.gmail.com>
        <3e08d48b-7b70-cc7f-0ec1-12ad9b1a33db@redhat.com>
        <CAAa6QmSNvx7wbZzfhFOyhODTMoBbf6PimnOf2xeAw5NkD1eXVg@mail.gmail.com>
        <PUZP153MB06350A5DC9CCB8448C98E4EEBE1DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
        <3408ff54-f353-0334-0d66-c808389d2f01@redhat.com>
        <ZOijSwCa9NFD6DZI@casper.infradead.org>
        <9f967665-2cbd-f80b-404e-ac741eab1ced@redhat.com>
        <CAAa6QmQRFwzXWHEL2d74sX6JuciJeBzprk1NxCWKB6i53gmt6Q@mail.gmail.com>
        <20230906065817.GA27879@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
        <20230920054454.GA26860@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
        <CAHbLzkouAZg5BSvnwv_EN6G3qV-nzeX2ced1GRqQDf2rkm992w@mail.gmail.com>
        <CAAa6QmTnx=kEijosNfq0DEPz4TeHFeOrgtwO0wfEeFUS5hgROw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 09:56:21 -0700 "Zach O'Keefe" <zokeefe@google.com> wrote:

> >From this back/forth with David/Matthew, seems like we're OK saying,
> "this was a mistake", and that we can take the patch (need some form
> of Ack or Reviewed-by from them first, to confirm)

Yup.  And please let's update the changelog to reflect the details
which have been discussed thus far.

If the change *makes sense* for the current kernel then let's proceed,
regardless of the broken driver issue.

But adding a cc:stable would require extra argumentation, which I will
be interested to read ;)

