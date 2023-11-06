Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787BD7E2F04
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjKFVfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjKFVfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:35:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCFED6E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:35:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DBBC433C8;
        Mon,  6 Nov 2023 21:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699306541;
        bh=lTIM326A7Yokevf2PJD10uUF9e1Zw3cztxxrSrh7tZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M5UZkVKYxz+TPfHd6fnfWKrRIhczvcLqPBbG2OJfZtHgf1fjYCEDGoiGOJdqiGA/S
         fm62Hoe9EvT9DOzQdg69ymdBh5KDAzbERqYx8QmPd+aO/HWrne241gotVaFrc6UW1P
         cG9tHbIh7bcHeMf25Ga8uI3AqHcdTTlrisz/poGs=
Date:   Mon, 6 Nov 2023 13:35:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhiguo Jiang <justinjiang@vivo.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2 1/2] mm:vmscan: the dirty folio in folio list skip
 unmap
Message-Id: <20231106133540.0d985052fa9137136593cbde@linux-foundation.org>
In-Reply-To: <20231019134211.329-2-justinjiang@vivo.com>
References: <20231019134211.329-1-justinjiang@vivo.com>
        <20231019134211.329-2-justinjiang@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 21:42:10 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:

> In the shrink_folio_list() the sources of the file dirty folio include
> two ways below:
> 1. The dirty folio is from the incoming parameter folio_list,
>    which is the inactive file lru.
> 2. The dirty folio is from the PTE dirty bit transferred by
>    the try_to_unmap().
> 
> For the first source of the dirty folio, if the dirty folio does not
> support pageout, the dirty folio can skip unmap in advance to reduce
> recyling time.
> 

This patch does an amount of code movement and it implements a
functional change.

Is it possible to split these?  The first patch moves code around but
has no runtime effect, the second patch implements the functional
change.

Also, the patch doesn't apply to current code so please redo it against
Linus's latest tree?

Thanks.

