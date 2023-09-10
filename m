Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BC579A017
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 23:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjIJV0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 17:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjIJV0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 17:26:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847C0B9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 14:26:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB55C433C9;
        Sun, 10 Sep 2023 21:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694381189;
        bh=a33KfcWJuQGo7k3UmN/sX7vPvQjyF64qX/+x3+bVGlk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dW46YccVrszgrK7dBtj1+T49aiYMkU43M/tcSJ9AF+Vkj1lyD69Oqm/kd72YYYUkc
         Eex+gVGfawd1vjprWPmV/L+c7krku458Ro3RXGmS4c0oC9o5RYqX/LnhTdAhbfbySJ
         sY1nP8NjW7NTm5QElsSitBNSYs92+QrP0VSwJVEk=
Date:   Sun, 10 Sep 2023 14:26:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc:     Liam.Howlett@oracle.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xiujianfeng@huawei.com
Subject: Re: [PATCH] mm: remove duplicated vma->vm_flags check when
 expanding stack
Message-Id: <20230910142627.0dce42578bfaab7c4c67e316@linux-foundation.org>
In-Reply-To: <20230906103312.645712-1-xiujianfeng@huaweicloud.com>
References: <20230906103312.645712-1-xiujianfeng@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Sep 2023 10:33:12 +0000 Xiu Jianfeng <xiujianfeng@huaweicloud.com> wrote:

> expand_upwards() and expand_downwards() will return -EFAULT if VM_GROWSUP
> or VM_GROWSDOWN is not correctly set in vma->vm_flags, however in
> !CONFIG_STACK_GROWSUP case, expand_stack_locked() returns -EINVAL first
> if !(vma->vm_flags & VM_GROWSDOWN) before calling expand_downwards(), to
> keep the consistency with CONFIG_STACK_GROWSUP case, remove this check.

What are the user-visible effects of this change?

Do you believe this fix should be backported into earlier kernel versions?
