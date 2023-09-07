Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B432C797C94
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbjIGTM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjIGTM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:12:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAA6A8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 12:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694113942; x=1725649942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=SnpOrZYtNTuIzL0vjhBljjPjR2PBd8AYSA4oouBsW8I=;
  b=PRyVj9tCRdABFbwz1njy4VnSuSx2rNU2lfGbucfzjfcyw39Uu92EX8Sl
   QA9hII/kn5vc5R+zYRUm+u6OeTpLR5xP+Y0+6N/000yh2FHIuskRyqUcx
   qtmeL8Sfjwsp5ZE8AETqKi4HeafwiUZap52JNbCGrSZh/wDSKJs4/GNW0
   /Vumq7le33lLd4lqqe4txgkBBlKLmR1wCoSw5FNm8P8eyj58Pnx8HxsyY
   cyCdYu6P6GMpiLHtq7RFzWx2Uht1cJ+9r2yfz7+ZrkzaWYklIUjBkHEJF
   3V03dARrb9zhxtCr3IUnt6wiUwMrz1cUGTPwKXNhblcdS5m27KlC/E+I9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="377359446"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="377359446"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 12:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="857003727"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="857003727"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 12:12:20 -0700
Content-Type: multipart/mixed; boundary="------------8RxoqCAmxZQQ6xc1jMVQL6HF"
Message-ID: <ac2f3bfc-9177-abc9-d4d7-69b1fba943a6@intel.com>
Date:   Thu, 7 Sep 2023 12:12:20 -0700
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
 <cb958f57-6a3a-d626-da51-53ad0e61870c@intel.com>
 <CAMBK9=bk715TjXhzwss+wFqpafKganGhZ=WKWPvEuJyM5M2MCQ@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAMBK9=bk715TjXhzwss+wFqpafKganGhZ=WKWPvEuJyM5M2MCQ@mail.gmail.com>
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
--------------8RxoqCAmxZQQ6xc1jMVQL6HF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/7/23 11:03, Adam Dunlap wrote:
> On Thu, Sep 7, 2023 at 10:06 AM Dave Hansen <dave.hansen@intel.com> wrote:
>> How about something like the attached patch?
> 
> I think that's a much better idea, but unfortunately we can't rely on
> boot_cpu_data being 0'd out. While it is a static global variable that C says
> should be 0'd, the early interrupt happens before .bss is cleared (Note if it
> happens to be 0, then the __is_canonical_address check succeeds anyway -- the
> boot failure only happens when that variable happens to be other random values).
> If there's another check we could do, I'd agree that'd end up being a much
> better patch. For example, maybe we could add a field to cpuinfo_x86 is_valid
> that is manually (i.e. not part of the regular .bss clearing) set to false and
> is only set to true after early_identify_cpu is finished. Or the
> simplest thing would  be to just manually set x86_virt_bits to 0 somewhere super early.

Gah, what a mess.  So the guilty CPUID in question is this:

>         /* Setup and Load IDT */
>         call    early_setup_idt
> 
>         /* Check if nx is implemented */
>         movl    $0x80000001, %eax
>         cpuid
>         movl    %edx,%edi

which is _barely_ after we have an IDT with which to generate
exceptions.  What happens before this?  This isn't the first CPUID
invocation.  Does this one just happen to #VC and all the others before
don't?

In any case, the most straightforward way out of this mess is to just
move boot_cpu_data out of .bss and explicitly initialize it along with
some documentation explaining the situation.

>> Also, what's the root cause here?  What's causing the early exception?
>> It is some silly CPUID leaf?  Should we be more careful to just avoid
>> these exceptions?
> 
> Yes, it is a CPUID instruction in secondary_startup_64 with the comment /* Check
> if nx is implemented */. It appears to be pretty important. Potentially we could
> paravirtualize the CPUID direclty (i.e. mess with the GHCB and make the vmgexit)
> instead of taking the #VC, but I'm not sure that's a great idea.

What TDX does here is actually pretty nice.  It doesn't generate a #VE
for these.

But seriously, is it even *possible* to spin up a SEV-SNP VM what
doesn't have NX?

> There's a couple of other CPUIDs that are called in early_identify_cpu between
> when x86_virt_bits is set to 48 and when it is set to its real value (IIUC, it
> may be set to 57 if 5 level paging is enabled), which could potentially cause
> spurious failures in those later calls.

That should be easy enough to fix.

These things where we initialize a value and then write over it are
always fragile.  Let's just make one function that does it right and
does it once.

Totally untested patch attached.
--------------8RxoqCAmxZQQ6xc1jMVQL6HF
Content-Type: text/x-patch; charset=UTF-8; name="vpbits.patch"
Content-Disposition: attachment; filename="vpbits.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMgYi9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L2NvbW1vbi5jCmluZGV4IDBiYTEwNjdmNGU1ZjEuLjZkYWZlMDUyZDE3NTYg
MTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMKKysrIGIvYXJjaC94
ODYva2VybmVsL2NwdS9jb21tb24uYwpAQCAtMTA5OSwxNyArMTA5OSwzMiBAQCB2b2lkIGdl
dF9jcHVfY2FwKHN0cnVjdCBjcHVpbmZvX3g4NiAqYykKIHZvaWQgZ2V0X2NwdV9hZGRyZXNz
X3NpemVzKHN0cnVjdCBjcHVpbmZvX3g4NiAqYykKIHsKIAl1MzIgZWF4LCBlYngsIGVjeCwg
ZWR4OworCWJvb2wgdnBfYml0c19mcm9tX2NwdWlkID0gdHJ1ZTsKIAotCWlmIChjLT5leHRl
bmRlZF9jcHVpZF9sZXZlbCA+PSAweDgwMDAwMDA4KSB7CisJaWYgKCFjcHVfaGFzKGMsIFg4
Nl9GRUFUVVJFX0NQVUlEKSB8fAorCSAgICAoYy0+ZXh0ZW5kZWRfY3B1aWRfbGV2ZWwgPCAw
eDgwMDAwMDA4KSkKKwkJdnBfYml0c19mcm9tX2NwdWlkID0gZmFsc2U7CisKKwlpZiAodnBf
Yml0c19mcm9tX2NwdWlkKSB7CiAJCWNwdWlkKDB4ODAwMDAwMDgsICZlYXgsICZlYngsICZl
Y3gsICZlZHgpOwogCiAJCWMtPng4Nl92aXJ0X2JpdHMgPSAoZWF4ID4+IDgpICYgMHhmZjsK
IAkJYy0+eDg2X3BoeXNfYml0cyA9IGVheCAmIDB4ZmY7CisJfSBlbHNlIHsKKwkJaWYgKElT
X0VOQUJMRUQoQ09ORklHX1g4Nl82NCkpIHsKKwkJCWMtPng4Nl9jbGZsdXNoX3NpemUgPSA2
NDsKKwkJCWMtPng4Nl9waHlzX2JpdHMgPSAzNjsKKwkJCWMtPng4Nl92aXJ0X2JpdHMgPSA0
ODsKKwkJfSBlbHNlIHsKKwkJCWMtPng4Nl9jbGZsdXNoX3NpemUgPSAzMjsKKwkJCWMtPng4
Nl92aXJ0X2JpdHMgPSAzMjsKKwkJCWMtPng4Nl9waHlzX2JpdHMgPSAzMjsKKworCQkJaWYg
KGNwdV9oYXMoYywgWDg2X0ZFQVRVUkVfUEFFKSB8fAorCQkJICAgIGNwdV9oYXMoYywgWDg2
X0ZFQVRVUkVfUFNFMzYpKQorCQkJCWMtPng4Nl9waHlzX2JpdHMgPSAzNjsKKwkJfQogCX0K
LSNpZmRlZiBDT05GSUdfWDg2XzMyCi0JZWxzZSBpZiAoY3B1X2hhcyhjLCBYODZfRkVBVFVS
RV9QQUUpIHx8IGNwdV9oYXMoYywgWDg2X0ZFQVRVUkVfUFNFMzYpKQotCQljLT54ODZfcGh5
c19iaXRzID0gMzY7Ci0jZW5kaWYKIAljLT54ODZfY2FjaGVfYml0cyA9IGMtPng4Nl9waHlz
X2JpdHM7CiB9CiAKQEAgLTE1MzksMTUgKzE1NTQsNiBAQCBzdGF0aWMgdm9pZCBfX2luaXQg
Y3B1X3BhcnNlX2Vhcmx5X3BhcmFtKHZvaWQpCiAgKi8KIHN0YXRpYyB2b2lkIF9faW5pdCBl
YXJseV9pZGVudGlmeV9jcHUoc3RydWN0IGNwdWluZm9feDg2ICpjKQogewotI2lmZGVmIENP
TkZJR19YODZfNjQKLQljLT54ODZfY2xmbHVzaF9zaXplID0gNjQ7Ci0JYy0+eDg2X3BoeXNf
Yml0cyA9IDM2OwotCWMtPng4Nl92aXJ0X2JpdHMgPSA0ODsKLSNlbHNlCi0JYy0+eDg2X2Ns
Zmx1c2hfc2l6ZSA9IDMyOwotCWMtPng4Nl9waHlzX2JpdHMgPSAzMjsKLQljLT54ODZfdmly
dF9iaXRzID0gMzI7Ci0jZW5kaWYKIAljLT54ODZfY2FjaGVfYWxpZ25tZW50ID0gYy0+eDg2
X2NsZmx1c2hfc2l6ZTsKIAogCW1lbXNldCgmYy0+eDg2X2NhcGFiaWxpdHksIDAsIHNpemVv
ZihjLT54ODZfY2FwYWJpbGl0eSkpOwpAQCAtMTU2MSw3ICsxNTY3LDYgQEAgc3RhdGljIHZv
aWQgX19pbml0IGVhcmx5X2lkZW50aWZ5X2NwdShzdHJ1Y3QgY3B1aW5mb194ODYgKmMpCiAJ
CWNwdV9kZXRlY3QoYyk7CiAJCWdldF9jcHVfdmVuZG9yKGMpOwogCQlnZXRfY3B1X2NhcChj
KTsKLQkJZ2V0X2NwdV9hZGRyZXNzX3NpemVzKGMpOwogCQlzZXR1cF9mb3JjZV9jcHVfY2Fw
KFg4Nl9GRUFUVVJFX0NQVUlEKTsKIAkJY3B1X3BhcnNlX2Vhcmx5X3BhcmFtKCk7CiAKQEAg
LTE1NzcsNiArMTU4Miw4IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBlYXJseV9pZGVudGlmeV9j
cHUoc3RydWN0IGNwdWluZm9feDg2ICpjKQogCQlzZXR1cF9jbGVhcl9jcHVfY2FwKFg4Nl9G
RUFUVVJFX0NQVUlEKTsKIAl9CiAKKwlnZXRfY3B1X2FkZHJlc3Nfc2l6ZXMoYyk7CisKIAlz
ZXR1cF9mb3JjZV9jcHVfY2FwKFg4Nl9GRUFUVVJFX0FMV0FZUyk7CiAKIAljcHVfc2V0X2J1
Z19iaXRzKGMpOwo=

--------------8RxoqCAmxZQQ6xc1jMVQL6HF--
