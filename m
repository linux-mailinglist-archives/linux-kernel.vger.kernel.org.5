Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58B67C6B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377883AbjJLK1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377747AbjJLK1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:27:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C710FBA;
        Thu, 12 Oct 2023 03:27:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CBAC43391;
        Thu, 12 Oct 2023 10:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697106421;
        bh=GoK9J2GZ+U+c0uf62aOQkibvMW3DB2yaN21pbjSxWcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QDZ99nT7+siBhEJ5mZtF9L943zqYQLF2ybIeyIv3bnRh1tOUSx/SaiBx0AJUO9/0M
         oZGEqVAkOYbI9cS6xt0FTs4jfIk84HzbR1GHxI64cyzbTkW9jWmIL89TGHbwI7kBQ4
         VVYpCIZhd2k8t8BjjR2PdgbvB6UtBsv8QMUhPL5Q=
Date:   Thu, 12 Oct 2023 12:26:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        Xiaoke Wang <xkernel.wang@foxmail.com>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] lib/test_meminit: fix off-by-one error in test_pages()
Message-ID: <2023101201-grasp-smartly-2085@gregkh>
References: <2023101238-greasily-reiterate-aafc@gregkh>
 <CAG_fn=X-dnc06r0Yik24jBaL-f7ZzrUQiUJmMHeN9CaSa3ZveQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=X-dnc06r0Yik24jBaL-f7ZzrUQiUJmMHeN9CaSa3ZveQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:40:14AM +0200, Alexander Potapenko wrote:
> On Thu, Oct 12, 2023 at 10:17 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > In commit efb78fa86e95 ("lib/test_meminit: allocate pages up to order
> > MAX_ORDER"), the loop for testing pages is set to "<= MAX_ORDER" which
> > causes crashes in systems when run.  Fix this to "< MAX_ORDER" to fix
> > the test to work properly.
> 
> What are the crashes you are seeing? Are those OOMs?

They are WARN_ON() triggers.  They are burried in the Android build
system, let me see if I can uncover them.

> IIUC it should be valid to allocate with MAX_ORDER.

"should", but I no longer get runtime warnings with this patch applied,
so something is wrong :)

Let me go dig for the logs again...
