Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1257BFB68
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjJJM1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjJJM1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:27:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383AAC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QqtFP4AnazNzdbPfmHwCNPWa5514KWnpnQevKgu7Ie0=; b=q7a5l0pS32MVrOxgHE3VPNyiHW
        g3To4SpGohUEIWFWIpbCM55wYeWEpjo9KZ6AuS+A3u8k4PkmwmIcvIevsQ4A/CeFuY92kV0aXw+UA
        i4/H7Dd6ssaitk3xydL/4GmKFDrf4ljfSSVpvlDt6tWI5UHywEzNSBoCInE6TaFkRdLkZtJyKbIPr
        bdkDYgXUCTrmINQ5Rfoav5KTPKGYFmRD+Wk7IoIETWbFy5TfnVnm0SXq2HmsjJYYe3bBCCn7UJRM/
        xq1dM1wodXboJ+PnQmcR41eEJKNx2uWjOU9yABHyNaMwVEj510X9NtREAxJHYSyPg+gCIwHWNE44p
        +kka9kYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqBpU-004ZaS-9Q; Tue, 10 Oct 2023 12:27:16 +0000
Date:   Tue, 10 Oct 2023 13:27:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        david@redhat.com, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH -next 4/7] mm: convert xchg_page_access_time to
 xchg_folio_access_time()
Message-ID: <ZSVDJPbt7Nz1xg7+@casper.infradead.org>
References: <20231010064544.4162286-1-wangkefeng.wang@huawei.com>
 <20231010064544.4162286-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010064544.4162286-5-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 02:45:41PM +0800, Kefeng Wang wrote:
> Make xchg_page_access_time to take a folio, and rename it to
> xchg_folio_access_time() since all callers with a folio.

You're doing this the hard way, which makes life hard for the reviewrs.

patch 1. Introduce folio->_last_cpupid
patch 2: Add

static inline int folio_xchg_access_time(struct folio *folio, int time)
{
	return xchg_page_access_time(&folio->page, time);
}

patch 3-n: Convert callers
Patch n+1: Remove xchg_page_access_time(), folding it into
folio_xchg_access_time().

Similarly for page_cpupid_xchg_last / folio_cpupid_xchg_last().
(why is this not called folio_xchg_last_cpupid?)

