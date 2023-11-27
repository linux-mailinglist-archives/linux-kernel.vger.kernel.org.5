Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E353A7F9D72
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjK0K1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjK0K1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:27:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31C2E1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:27:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F719C433C7;
        Mon, 27 Nov 2023 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701080870;
        bh=mqtFeeqGki//5Nb3R143+AqRimwbXXJttWageC3NiuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFFL9zxnJAnhIv2QZsihLuUq6mKSrEU3HutEewWqBmC8wj4Ey9kZH08HHHrY0s6OK
         zJZxiyeDHaSXmt6RujDPBPT7LJnhuRH9OJliQMqLiUJp4RCXcxAYeyVDXQO0JCd49W
         1/eL8pYNWxbPBunN/ikK7aPYUr/nI0d2EHTOaXGxw2yoz6PMFwt1FvDvVsUmkD09L5
         u2TWtfr0bZ6oFm5a37f1YH5il4ot9Gs6cja1OS1Y66a9X9mqmQfbz9s3dTyGaD1cz1
         MOYYUotox20liwe8wOlhOdEtPTGsk7EHvqPuaSiHrypK3q+f/CrUaOAa1Ia9Vk/I6a
         nuBmvgv0yHIYQ==
Date:   Mon, 27 Nov 2023 11:27:43 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, intel-gfx@lists.freedesktop.org,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        bpf@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com,
        fengwei.yin@intel.com
Subject: Re: [linus:master] [file] 0ede61d858: will-it-scale.per_thread_ops
 -2.9% regression
Message-ID: <20231127-kirschen-dissens-b511900fa85a@brauner>
References: <202311201406.2022ca3f-oliver.sang@intel.com>
 <CAHk-=wjMKONPsXAJ=yJuPBEAx6HdYRkYE8TdYVBvpm3=x_EnCw@mail.gmail.com>
 <CAHk-=wiCJtLbFWNURB34b9a_R_unaH3CiMRXfkR0-iihB_z68A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiCJtLbFWNURB34b9a_R_unaH3CiMRXfkR0-iihB_z68A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So that nobody else would waste any time on this, attached is a new
> attempt. This time actually tested *after* the changes.

So I've picked up your patch (vfs.misc). It's clever alright so thanks
for the comments in there otherwise I would've stared at this for far
too long.

It's a little unpleasant because of the cast-orama going on before we
check the file pointer but I don't see that it's in any way wrong. And
given how focussed people are with __fget_* performance I think it might
even be the right thing to do.

But the cleverness means we have the same logic slightly differently
twice. Not too bad ofc but not too nice either especially because that
rcu lookup is pretty complicated already.

A few days ago I did just write a long explanatory off-list email to
someone who had questions about this and who is fairly experienced so
we're not making it easy on people. But performance or simplicity; one
can't necessarily always have both.
