Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD97DBB69
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjJ3OJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJ3OJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:09:18 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D900FB7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:09:14 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id BA8DB185D54;
        Mon, 30 Oct 2023 15:09:10 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1698674951; bh=X2KI7oEKLIqc0u8nmDx82mYo2XMFiDV/mao3JheM3SY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1YGMmxiDLcAGYfs98smopJCc7B5o2SKaXNDMuMj9l54IVm9vt7RaLQja8dGn3eR+5
         JTsRBNvCG2kiTor2j9ZsGeKEkE2bN0YZA+lH0EWfzwSL90uxc3/KyiVXWTohTptx9i
         vZBN780yjyrpsOxWY/ryUPZsV4bgqTu19acXkCjsw+rkpFCKgvNDotN3qWa1H9ZFsF
         xkpd54Ojs8/+YRDFBgSo4T+UODHHtqP6T2dZuGRQLHedMddUCdzFeOK9G65j7V8k04
         RhhGyxBAdprUFQuXGYHh/XsacV74f36it07jI/j6RUmdnUZ7AGj1bfarS0vE1+qs5x
         6FtuIDQZfLDfw==
Date:   Mon, 30 Oct 2023 15:09:04 +0100
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Wangkefeng <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] swiotlb: check dynamically allocated TLB address before
 decrypting
Message-ID: <20231030150904.07a32eaa@meshulam.tesarici.cz>
In-Reply-To: <20231030133112.GA22143@lst.de>
References: <20231026095123.222-1-petrtesarik@huaweicloud.com>
        <20231028192414.637bf4fd@meshulam.tesarici.cz>
        <20231030133112.GA22143@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, 30 Oct 2023 14:31:12 +0100
Christoph Hellwig <hch@lst.de> wrote:

> I'm trying to review it properly this week.  It was defintively too big
> to just rush it into 6.6 in the last few days.

Thank you for the answer. This is OK. Let me give a bit of background.

The bug was reported by Michael Kelley to me, while I temporarily lost
access to my @huaweicloud.com mailbox. Then I was not able to add him
in a Reported-by: header, because this was a private email, which could
not be referred by a Closes: header.

Anyway, Michael explained in that private email that the threat is more
or less theoretical, because environments where set_memory_decrypted()
actually does something are unlikely to have physical address
constraints for the bounce buffer.

But maybe we should add a CC: stable@vger.kernel.org nevertheless.

Petr T
