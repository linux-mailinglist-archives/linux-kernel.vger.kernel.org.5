Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDBD7FD5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjK2LlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjK2LlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:41:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE484B5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701258083; x=1732794083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=531Qy67F7OZYH+kBShiz0InOyHCpXmDL2JT+KJogS2E=;
  b=W5TGZaCI0sXXImG7b3B1izJPngDcCFI9wDIq6h9mGJrRKisr2iZW9u+M
   L00bw/LrA1yeyGyU9uNCu/+5zRvsCIHGQXeD3vgfXZndR+NpDLb0wL7bY
   73Gj6F+bn5jt/Cos3rowxDNM7oEJOXOvw4Ua0zDxucHmmvCWnOOtpr/ND
   gvssBnEV/xx2OXklQoxzgXiitUtGo+Rq95Ahw5ZhNXjgd5Moeh0w950kg
   bOBbr25fxRhoJkwh4o0fs3iTAGtQz7QqqHeSS7uX3hR0w3FcGPh3VLqaE
   +MVGNviBrda/RMnCl0Su1nxjPOX4MD3Wuh5snMVgrzHGfOPAbjqpG3tN+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6414713"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="6414713"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 03:41:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="839385780"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="839385780"
Received: from ksandowi-mobl1.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.31.19])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 03:41:16 -0800
From:   "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To:     Chris Li <chrisl@kernel.org>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/zswap: Replace kmap_atomic() with kmap_local_page()
Date:   Wed, 29 Nov 2023 12:41:13 +0100
Message-ID: <2166103.irdbgypaU6@fdefranc-mobl3>
Organization: intel
In-Reply-To: <CAF8kJuMakA-UbHi4Z5uCtB+6S0vcZiULKXu6GQh+7KBHQSR6Bg@mail.gmail.com>
References: <20231127160058.586446-1-fabio.maria.de.francesco@linux.intel.com>
 <CAF8kJuMakA-UbHi4Z5uCtB+6S0vcZiULKXu6GQh+7KBHQSR6Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Monday, 27 November 2023 21:16:56 CET Chris Li wrote:
> Hi Fabio,
>=20
> On Mon, Nov 27, 2023 at 8:01=E2=80=AFAM Fabio M. De Francesco
>=20
> <fabio.maria.de.francesco@linux.intel.com> wrote:
> > kmap_atomic() has been deprecated in favor of kmap_local_page().
> >=20
> > Therefore, replace kmap_atomic() with kmap_local_page() in
> > zswap.c.
> >=20
> > kmap_atomic() is implemented like a kmap_local_page() which also
> > disables page-faults and preemption (the latter only in !PREEMPT_RT
> > kernels).=20

Please read again the sentence above.

> > The kernel virtual addresses returned by these two API are
> > only valid in the context of the callers (i.e., they cannot be handed to
> > other threads).
> >=20
> > With kmap_local_page() the mappings are per thread and CPU local like
> > in kmap_atomic(); however, they can handle page-faults and can be called
> > from any context (including interrupts). The tasks that call
> > kmap_local_page() can be preempted and, when they are scheduled to run
> > again, the kernel virtual addresses are restored and are still valid.
>=20
> As far as I can tell, the kmap_atomic() is the same as
> kmap_local_page() with the following additional code before calling to
> "__kmap_local_page_prot(page, prot)", which is common between these
> two functions.
>=20
>         if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                 migrate_disable();
>         else
>                 preempt_disable();
>=20
>         pagefault_disable();
>=20

This is what I tried to explain with that sentence. I think you overlooked =
it=20
:)

BTW, please have a look at the Highmem documentation. It has initially been=
=20
written by Peter Z. and I reworked and largely extended it authoring  the=20
patches with my gmail address (6 - 7 different patches, if I remember=20
correctly).

You will find there everything you may want to know about these API and how=
 to=20
do conversions from the older to the newer.

Thanks for acking this :)

> From the performance perspective, kmap_local_page() does less so it
> has some performance gain. I am trying to think would it have another
> unwanted side effect of enabling interrupt and page fault while zswap
> decompressing a page.
> The decompression should not generate page fault. The interrupt
> enabling might introduce extra latency, but most of the page fault was
> having interrupt enabled anyway. The time spent in decompression is
> relatively small compared to the whole duration of the page fault. So
> the interrupt enabling during those short windows should be fine.
> "Should" is the famous last word.

Here, Matthew chimed in to clarify. Thanks Matthew.
=20
> I am tempted to Ack on it. Let me sleep on it a before more. BTW,
> thanks for the patch.
>=20
> Chris




