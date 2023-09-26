Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F867AF90E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjI0ELr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjI0EKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:10:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570C41E3CC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 15:27:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA64C433B8;
        Tue, 26 Sep 2023 21:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695762596;
        bh=wC0dTpJgWtaku1+4SDaNJIe+CBwFB1hfHT9wzrkh5Gw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vX0KbVB0hpSZUkMK5QugE4qB2ANXXob7PmAOhter8MsdV+VgxJtUKpxCGz8nt4dA9
         MpPV07PcCNeJgPRGlCFw76/2qQMNkK9jXx5OJsx3j1X4T6XfzKIFgxAc/S4MiTImcU
         4RudDUmLe47HNNaHG3EuhLA76aW+LGbTeoMoQ9C0=
Date:   Tue, 26 Sep 2023 14:09:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     David Hildenbrand <david@redhat.com>, kernel-team@fb.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 1/4] mm/ksm: add "smart" page scanning mode
Message-Id: <20230926140955.8b2627711116339af80731f2@linux-foundation.org>
In-Reply-To: <qvqwmsx83o68.fsf@devbig1114.prn1.facebook.com>
References: <20230926040939.516161-1-shr@devkernel.io>
        <20230926040939.516161-2-shr@devkernel.io>
        <ae2be79c-a030-a4d2-0d89-15efa17fe77c@redhat.com>
        <qvqwmsx83o68.fsf@devbig1114.prn1.facebook.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 09:13:31 -0700 Stefan Roesch <shr@devkernel.io> wrote:

> > Thinking about it, what are the cons of just enabling this always and not
> > exposing new toggles? Alternatively, we could make this a compile-time option.
> >
> > In general, LGTM, just curious if we really have to make this configurable.
> >
> 
> The only downside I can see is that it might take a longer time for some
> pages to be de-duplicated (a new candidate page is added, but its
> duplicate is skipped in this round). So it will take longer to
> de-duplicate this page.
> 
> I tested with more than one workload, but it might be useful to get some
> data with additional workloads. I was thinking of enabling it after one or
> two releases.

We could keep the tunable and make it default "on"?
