Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B3A7A09C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbjINPv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbjINPv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:51:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5C41BDC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694706712; x=1726242712;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=osGMSR+/Sl/IIMT4WBHGk2JmyeEImW8mWC+HknDgaww=;
  b=CpFWpQJHtIfWmNRvverXWn6JXmuYBNdA+oQqsUr+Elhr1qLWEFD5j6VE
   gsRkHPu03yS4mfGRvYnDwNU8zOFfWzLOf5/luhlPYPBJxAaThXinrNDs/
   bXV3j4X4yh3Yrt/Fy3jC7fCg1lgOPQZt2Hdw2DQ38b520XIEAS7O3hGe8
   jpR3R9Ct2nF5J7MHwkE5SahCdCVyXgdcilvuSpdSWWSMKrH47iShdL3rK
   ab8Mts7srHsbI0ZjlLTRSbRflgWtTNDS5TLvGxmeZZoG41XXVoiKgpkt5
   /LkU8+NUlLPr3j5bxS6CJ61jZ23y4PHfErwm8mJwU/XQuPU5dCJ8E/Qev
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="364040309"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="364040309"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 08:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="694354783"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="694354783"
Received: from spswartz-mobl.amr.corp.intel.com (HELO [10.209.21.97]) ([10.209.21.97])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 08:51:51 -0700
Content-Type: multipart/mixed; boundary="------------s3GVNQ58hbmXD3GP00R55XLl"
Message-ID: <45cdb5ae-986e-d186-f0fd-a308f946ce8d@intel.com>
Date:   Thu, 14 Sep 2023 08:51:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] x86/boot/compressed: Reserve more memory for page tables
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Ard Biesheuvel <ardb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aaron Lu <aaron.lu@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.de
References: <20230914123001.27659-1-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230914123001.27659-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------s3GVNQ58hbmXD3GP00R55XLl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/14/23 05:30, Kirill A. Shutemov wrote:
> +/*
> + * Total number of page table kernel_add_identity_map() can allocate,
> + * including page tables consumed by startup_32().
> + */
> +# define BOOT_PGT_SIZE		(32*4096)

I agree that needing to know this in advance *exactly* is troublesome.

But I do think that we should preserve the comment about the worst-case
scenario.  Also, I thought this was triggered by unaccepted memory.  Am
I remembering it wrong?  How was it in play?

Either way, I think your general approach here is sound.  But let's add
one little tweak to at least warn when we're getting close to the limit.
 Now that nobody has to worry about the limit for the immediate future
it's a guarantee that in the long term someone will plow through it
accidentally.

Let's add a soft warning when we're nearing the limit so that there's a
chance to catch these things in the future.
--------------s3GVNQ58hbmXD3GP00R55XLl
Content-Type: text/x-patch; charset=UTF-8; name="pgtbuf.patch"
Content-Disposition: attachment; filename="pgtbuf.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9pZGVudF9tYXBfNjQuYyBi
L2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9pZGVudF9tYXBfNjQuYwppbmRleCBiY2M5NTZj
MTc4NzIuLjVkZmI2YTMxYmJiMSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvYm9vdC9jb21wcmVz
c2VkL2lkZW50X21hcF82NC5jCisrKyBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9pZGVu
dF9tYXBfNjQuYwpAQCAtNTksNiArNTksMTMgQEAgc3RhdGljIHZvaWQgKmFsbG9jX3BndF9w
YWdlKHZvaWQgKmNvbnRleHQpCiAJCXJldHVybiBOVUxMOwogCX0KIAorCWlmIChwYWdlcy0+
cGd0X2J1Zl9vZmZzZXQgPj0gcGFnZXMtPnBndF9idWZfc2l6ZSAqIDMgLyA0KSB7CisJCWRl
YnVnX3B1dHN0cigicGd0X2J1ZiBydW5uaW5nIGxvdyBpbiAiIF9fRklMRV9fICJcbiIpOwor
CQlkZWJ1Z19wdXRzdHIoIk5lZWQgdG8gcmFpc2UgQk9PVF9QR1RfU0laRT8/XG4iKTsKKwkJ
ZGVidWdfcHV0YWRkcihwYWdlcy0+cGd0X2J1Zl9vZmZzZXQpOworCQlkZWJ1Z19wdXRhZGRy
KHBhZ2VzLT5wZ3RfYnVmX3NpemUpOworCX0KKwogCWVudHJ5ID0gcGFnZXMtPnBndF9idWYg
KyBwYWdlcy0+cGd0X2J1Zl9vZmZzZXQ7CiAJcGFnZXMtPnBndF9idWZfb2Zmc2V0ICs9IFBB
R0VfU0laRTsKIAo=

--------------s3GVNQ58hbmXD3GP00R55XLl--
