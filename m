Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D8678D28F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240768AbjH3Dd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbjH3DdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:33:18 -0400
Received: from out-246.mta1.migadu.com (out-246.mta1.migadu.com [IPv6:2001:41d0:203:375::f6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9861B0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:33:15 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693366393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S3uKzdW1DNd9/aFHR1lUQtctGFzoSLRbK9fu0L1Os2k=;
        b=pj2D9fQOHXhvz+JX8x0nxO5LoRax4q/hU79z5JxJhJX7GHE8kupeE5pRYDBqaIcyPW35Mw
        dDXCqFvquYBOCEjFkFNa3gAiElXhnIDe7m2hI2yavOWqkoqY34A9+SMRZNhvhWyiBC0sJ5
        OlxVut84SYpb/AiPB9CdT+1Gy8TwQns=
Mime-Version: 1.0
Subject: Re: [PATCH] hugetlb: set hugetlb page flag before optimizing vmemmap
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230829213734.69673-1-mike.kravetz@oracle.com>
Date:   Wed, 30 Aug 2023 11:32:27 +0800
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Usama Arif <usama.arif@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        James Houghton <jthoughton@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <00753B00-69DB-499E-8BC3-5DF42DC5936B@linux.dev>
References: <20230829213734.69673-1-mike.kravetz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 30, 2023, at 05:37, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> Currently, vmemmap optimization of hugetlb pages is performed before =
the
> hugetlb flag (previously hugetlb destructor) is set identifying it as =
a
> hugetlb folio.  This means there is a window of time where an ordinary
> folio does not have all associated vmemmap present.  The core mm only
> expects vmemmap to be potentially optimized for hugetlb  and device =
dax.
> This can cause problems in code such as memory error handling that may
> want to write to tail struct pages.
>=20
> There is only one call to perform hugetlb vmemmap optimization today.
> To fix this issue, simply set the hugetlb flag before that call.
>=20
> There was a similar issue in the free hugetlb path that was previously
> addressed.  The two routines that optimize or restore hugetlb vmemmap
> should only be passed hugetlb folios/pages.  To catch any callers not
> following this rule, add VM_WARN_ON calls to the routines.  In the
> hugetlb free code paths, some calls could be made to restore vmemmap
> after clearing the hugetlb flag.  This was 'safe' as in these cases
> vmemmap was already present and the call was a NOOP.  However, for
> consistency these calls where eliminated so that we can add the
> VM_WARN_ON checks.
>=20
> Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated =
with each HugeTLB page")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks for your fix.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>


