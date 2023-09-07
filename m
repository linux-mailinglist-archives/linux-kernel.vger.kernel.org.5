Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97480797977
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjIGRP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjIGRPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:15:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7E8B2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694106895; x=1725642895;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=9ZZkTEqlH0Qw0Ksag2UQ8FZGRyx63ReWeP4PizplmOQ=;
  b=bUtmZMGKVhyKsl0XHymIe/qan6f/77+feMiA0VhnH6/HEFv/c9TFoAs9
   E6zFmnm5YVHzzWvI1OwwVxz9uN5zvl0uDiolE68ckTSETg/WPzbC2uDH7
   gjXoS/zkPgWYD1E86Iy51PJQO4l6o4Ne2nnBor2B1XqE8mc0773Fp08HX
   Xvun9HhQ70zr3eXK2C0Q366X/HaC0ugSHJhjIZbUC1H3myo8oo8/k78pu
   LTejCE7/dlETMbJEp39h87RH5PoGZ8vyAg8UbH8SP8/TdOGg4P83ekyMK
   zmUGx0Z7hrIYNvEtcApKh86TeA9wG/3VdrTRtXr3dfnoMq/FKKE5WwGYp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="376321868"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="376321868"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 10:04:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="885285316"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="885285316"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 10:04:02 -0700
Content-Type: multipart/mixed; boundary="------------Y9D6LFKBxPpGhCqj5khk0TSE"
Message-ID: <cb958f57-6a3a-d626-da51-53ad0e61870c@intel.com>
Date:   Thu, 7 Sep 2023 10:04:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] x86/sev-es: Do not use copy_from_kernel_nofault in early
 #VC handler
Content-Language: en-US
To:     Adam Dunlap <acdunlap@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, Jacob Xu <jacobhxu@google.com>
References: <20230906224541.2778523-1-acdunlap@google.com>
 <e037f1c0-aaf6-7951-04ea-6d27e557b61b@intel.com>
 <CAMBK9=b9V6WxYZNrVPNV5vzBZ-mT_noBAxod=ijqrV3bUXAUyA@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAMBK9=b9V6WxYZNrVPNV5vzBZ-mT_noBAxod=ijqrV3bUXAUyA@mail.gmail.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------Y9D6LFKBxPpGhCqj5khk0TSE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/23 16:25, Adam Dunlap wrote:
>> Usually, we'll add some gunk in arch/x86/boot/compressed/misc.h to
>> override the troublesome implementation.  In this case, it would make a
>> lot of sense to somehow avoid touching boot_cpu_data.x86_virt_bits in
>> the first place.
> Thanks for the comment. I realize this patch is doing something a bit misleading
> here. In this case, "early" does not refer to the compressed kernel, but
> actually the regular kernel but in the stage with this early #VC handler
> vc_boot_ghcb (instead of the usual vc_raw_handle_exception). This #VC handler
> triggers for the first time on a cpuid instruction in secondary_startup_64, but
> boot_cpu_data.x86_virt_bits is not initialized until setup_arch inside of
> start_kernel, which is at the end of secondary_startup_64.

How about something like the attached patch?

It avoids passing around 'is_early' everywhere, which I'm sure we'll get
wrong at some point.  If we get it wrong, we lose *ALL* the checking
that copy_from_kernel*() does in addition to the canonical checks.

The attached patch at least preserves the userspace address checks.

This also makes me wonder how much other code is called via the early
exception handlers that's subtly broken.  I scanned a function or two
deep and the instruction decoding was the most guilty looking thing.
But a closer look would be appreciated.

Also, what's the root cause here?  What's causing the early exception?
It is some silly CPUID leaf?  Should we be more careful to just avoid
these exceptions?
--------------Y9D6LFKBxPpGhCqj5khk0TSE
Content-Type: text/x-patch; charset=UTF-8; name="xvb.patch"
Content-Disposition: attachment; filename="xvb.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL21hY2Nlc3MuYyBiL2FyY2gveDg2L21tL21hY2Nl
c3MuYwppbmRleCA1YTUzYzJjYzE2OWMuLjRmNzZjMzRkNzBhMiAxMDA2NDQKLS0tIGEvYXJj
aC94ODYvbW0vbWFjY2Vzcy5jCisrKyBiL2FyY2gveDg2L21tL21hY2Nlc3MuYwpAQCAtNywx
NCArNywyNCBAQAogYm9vbCBjb3B5X2Zyb21fa2VybmVsX25vZmF1bHRfYWxsb3dlZChjb25z
dCB2b2lkICp1bnNhZmVfc3JjLCBzaXplX3Qgc2l6ZSkKIHsKIAl1bnNpZ25lZCBsb25nIHZh
ZGRyID0gKHVuc2lnbmVkIGxvbmcpdW5zYWZlX3NyYzsKKwlib29sIHJldDsKIAogCS8qCi0J
ICogUmFuZ2UgY292ZXJpbmcgdGhlIGhpZ2hlc3QgcG9zc2libGUgY2Fub25pY2FsIHVzZXJz
cGFjZSBhZGRyZXNzCi0JICogYXMgd2VsbCBhcyBub24tY2Fub25pY2FsIGFkZHJlc3MgcmFu
Z2UuIEZvciB0aGUgY2Fub25pY2FsIHJhbmdlCi0JICogd2UgYWxzbyBuZWVkIHRvIGluY2x1
ZGUgdGhlIHVzZXJzcGFjZSBndWFyZCBwYWdlLgorCSAqIERvIG5vdCBhbGxvdyB1c2Vyc3Bh
Y2UgYWRkcmVzc2VzLiAgVGhpcyBkaXNhbGxvd3MKKwkgKiBub3JtYWwgdXNlcnNwYWNlIGFu
ZCB0aGUgdXNlcnNwYWNlIGd1YXJkIHBhZ2U6CiAJICovCi0JcmV0dXJuIHZhZGRyID49IFRB
U0tfU0laRV9NQVggKyBQQUdFX1NJWkUgJiYKLQkgICAgICAgX19pc19jYW5vbmljYWxfYWRk
cmVzcyh2YWRkciwgYm9vdF9jcHVfZGF0YS54ODZfdmlydF9iaXRzKTsKKwlpZiAodmFkZHIg
PCBUQVNLX1NJWkVfTUFYICsgUEFHRV9TSVpFKQorCQlyZXR1cm4gZmFsc2U7CisKKwkvKgor
CSAqIEFsbG93IGV2ZXJ5dGhpbmcgZHVyaW5nIGVhcmx5IGJvb3QgYmVmb3JlICd4ODZfdmly
dF9iaXRzJworCSAqIGlzIGluaXRpYWxpemVkLiAgTmVlZGVkIGZvciBpbnN0cnVjdGlvbiBk
ZWNvZGluZyBpbiBlYXJseQorCSAqIGV4Y2VwdGlvbiBoYW5kbGVycy4KKwkgKi8KKwlpZiAo
IWJvb3RfY3B1X2RhdGEueDg2X3ZpcnRfYml0cykKKwkJcmV0dXJuIHRydWU7CisKKwlyZXR1
cm4gX19pc19jYW5vbmljYWxfYWRkcmVzcyh2YWRkciwgYm9vdF9jcHVfZGF0YS54ODZfdmly
dF9iaXRzKTsKIH0KICNlbHNlCiBib29sIGNvcHlfZnJvbV9rZXJuZWxfbm9mYXVsdF9hbGxv
d2VkKGNvbnN0IHZvaWQgKnVuc2FmZV9zcmMsIHNpemVfdCBzaXplKQo=

--------------Y9D6LFKBxPpGhCqj5khk0TSE--
