Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C297AA62B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 02:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjIVAlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 20:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjIVAlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 20:41:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78929F5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 17:41:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EAAC433CA;
        Fri, 22 Sep 2023 00:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695342773;
        bh=A+v01Q6QfPOT5GvSCgfxalz/bjawMm8CUUKFpuPhXtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IL14HIDWESUt2Qml3tdEpv1jobiReIc/d141sl+CBb8zQTIbl7HHTNqjzPfdxee+f
         NF08oFI5iX6RcYrE9P7RJh82ZHqVEpaiVKB2SiriNUv8x7ouLx8JKf+10wErg7tc21
         CFdltrsAfsxsSVFZ+OvmbaNl9WrAOcKCT3ORXwFY=
Date:   Thu, 21 Sep 2023 17:32:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, david@redhat.com, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/2] mm/ksm: add fork-exec support for prctl
Message-Id: <20230921173251.54b854fb0ec7af2bf3e3ec3b@linux-foundation.org>
In-Reply-To: <20230921164709.3627565-1-shr@devkernel.io>
References: <20230921164709.3627565-1-shr@devkernel.io>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 09:47:07 -0700 Stefan Roesch <shr@devkernel.io> wrote:

> A process can enable KSM with the prctl system call. When the process is
> forked the KSM flag is inherited by the child process.

I guess that's logical, as it's still the same program.

> However if the
> process is executing an exec system call directly after the fork, the
> KSM setting is cleared. This patch series addresses this problem.

Well...  who said it's a problem?  There's nothing in our documentation
about this(?).  Why is the current behavior wrong?  If the new program
wants KSM, it can turn on KSM.

This significant change in user-visible behavior deserves much more
explanation and justification, please.  Including an explanation of why
it's OK to change kernel behavior under existing users' feet like this,

