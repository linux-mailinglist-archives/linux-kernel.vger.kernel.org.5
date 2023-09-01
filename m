Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23213790074
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343548AbjIAQEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242494AbjIAQEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:04:10 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD150CF3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 09:04:07 -0700 (PDT)
Received: from [192.168.2.39] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3ECDA212A79E;
        Fri,  1 Sep 2023 09:04:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3ECDA212A79E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1693584247;
        bh=HCLb/r8G15l69UtkY9A0GdCozM0QWFvhf+XFz2JUC6o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lTP9nmjW/tII60Lymj4CSPVO753gcAa9/yLHC5kihKMTDA84igTFwnyMpJZAWmHG4
         B+5jeBb5JJt3/qp2KEci2X1lCqtJLU2FlAaIaLQnHq4m7VcDCnqihq4/N2ByPAS7fH
         /n8Gvkvanasznf2lrQIKGhbmvPjQBE2d0d3ey3RI=
Message-ID: <080d834d-9ca0-437f-8f18-b7a311af0060@linux.microsoft.com>
Date:   Fri, 1 Sep 2023 18:04:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] configfs-tsm: Attestation Report ABI
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/2023 9:33 PM, Dan Williams wrote:
> Note that I am sending this during the merge window due to the high
> level of interest. My current expectation, barring major review
> concerns, is that this intercepts Linux-next soon after v6.6-rc1 for a
> v6.7 merge. Given the switch to configfs I did not carry forward
> Reviewed-by's from v2.
> 
> Changes since v2 [1]:
> - Switch from sysfs to configfs to scale the interface for containers
>   (Jeremi)
> - Fix locking in outblob_read() to avoid racing freeing and generation
>   of ->outblob (Jeremi)
> - Add missing mutex to sev_report_new() (Jeremi)
> - Fix incorrect usage of no_free_ptr(), switch to return_ptr() (Peter)
> - Drop hex input parsing (configfs bin attributes are not seekable which
>   eliminates the concern) (Greg)
> - Note why DEFINE_FREE() for kvfree() includes a NULL check (Greg)
> - Document the permissible values of privlevel in the ABI documentation
>   (Greg)
> - Bump column limit to 100 for sev-guest changes, since that's existing
>   code, for tsm.c use the .clang_format default. (Tom)
> - Drop report buffer size to 4K (Tom)
> - Fix uninitialized variable @rc in register_tsm() (Tom)
> - Fix collision detection confusion, always increment write_generation
>   on successful write regardless if old data is being re-written (Tom)
> - Switch to sockptr_t for sharing {get,get_ext}_report() between the
>   ioctl and configfs paths (Andy)
> 
> [1]: http://lore.kernel.org/r/169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com
> 
> An attestation report is signed evidence of how a Trusted Virtual
> Machine (TVM) was launched and its current state. A verifying party uses
> the report to make judgements of the confidentiality and integrity of
> that execution environment. Upon successful attestation the verifying
> party may, for example, proceed to deploy secrets to the TVM to carry
> out a workload. Multiple confidential computing platforms share this
> similar flow.

Besides the platform (cpu) attestation report, there are also attestation
reports from individual secure PCIe devices that we'd want to fetch. This
uses the SPDM protocol[1]. There is a CHALLENGE command which (too me)
roughly maps to an attestation request, but also separate interfaces to
fetch individual measurements and certificates (like the SNP extended
report interface allows).

If this is to become the one attestation interface then we'll need to
consider that. That will probably require adding a second level
directory: /sys/kernel/config/tsm/<device path>.

[1]: https://www.dmtf.org/sites/default/files/standards/documents/DSP2058_1.0.0_1.pdf
