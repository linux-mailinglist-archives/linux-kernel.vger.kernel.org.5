Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE7277B513
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjHNJFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbjHNJE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:04:58 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B36C10F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:04:57 -0700 (PDT)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3BBD02100EDE;
        Mon, 14 Aug 2023 02:04:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BBD02100EDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692003896;
        bh=Hdv0TV7IK5EijrOqDm5tLbEXTg6srsWaFaDw+fUVPxg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m7EMhRo/a55p4EjUMggu4NIf79girf/NR3+g9eY+gA8uikwrHk8AsmruKMG8sdhIk
         uJWJIC7lW6LdzuBuaxp5zXbPNaPd72XFYXDsIoGDXBMQbPWAZ06j4lAaN7VKxLk4bi
         +Q2aHfYkSDUYZC0HjO1chi9jEQyhVNpW0IMeYCbg=
Message-ID: <57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com>
Date:   Mon, 14 Aug 2023 11:04:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] tsm: Attestation Report ABI
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
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/2023 9:43 AM, Dan Williams wrote:
> Changes since v1:
> - Switch from Keyring to sysfs (James)
> 
> An attestation report is signed evidence of how a Trusted Virtual
> Machine (TVM) was launched and its current state. A verifying party uses
> the report to make judgements of the confidentiality and integrity of
> that execution environment. Upon successful attestation the verifying
> party may, for example, proceed to deploy secrets to the TVM to carry
> out a workload. Multiple confidential computing platforms share this
> similar flow.
> 
> The approach of adding adding new char devs and new ioctls, for what
> amounts to the same logical functionality with minor formatting
> differences across vendors [1], is untenable. Common concepts and the
> community benefit from common infrastructure.
> 
> Use sysfs for this facility for maintainability compared to ioctl(). The
> expectation is that this interface is a boot time, configure once, get
> report, and done flow. I.e. not something that receives ongoing
> transactions at runtime. However, runtime retrieval is not precluded and
> a mechanism to detect potential configuration conflicts from
> multiple-threads using this interface is included.
> 

I wanted to speak up to say that this does not align with the needs we have
in the Confidential Containers project. We want to be able to perform attestation
not just once during boot but during the lifecycle of the confidential VM. We
may need to fetch a fresh attestation report from a trusted agent but also from
arbitrary applications running in containers.

The trusted agent might need attestation when launching a new container from an
encrypted container image or when a new secret is being added to the VM - both
of these events may happen at any time (also when containerized applications
are already executing).

Container applications have their own uses for attestation, such as when they need
to fetch keys required to decrypt payloads. We also have things like performing
attestation when establishing a TLS or ssh connection to provide an attested e2e
encrypted communication channel.

I don't think sysfs is suitable for such concurrent transactions. Also if you think
about exposing the sysfs interface to an application in a container, this requires
bind mounting rw part of the sysfs tree into the mount namespace - not ideal.

Jeremi

> The keyring@ list is dropped on this posting since a new key-type is no
> longer being pursued.
> 
> Link: http://lore.kernel.org/r/cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com
> 
> ---
> 
> Dan Williams (5):
>       virt: coco: Add a coco/Makefile and coco/Kconfig
>       tsm: Introduce a shared ABI for attestation reports
>       virt: sevguest: Prep for kernel internal {get,get_ext}_report()
>       mm/slab: Add __free() support for kvfree
>       virt: sevguest: Add TSM_REPORTS support for SNP_{GET,GET_EXT}_REPORT
> 
> 
>  Documentation/ABI/testing/sysfs-class-tsm |   47 +++++
>  MAINTAINERS                               |    8 +
>  drivers/virt/Kconfig                      |    6 -
>  drivers/virt/Makefile                     |    4 
>  drivers/virt/coco/Kconfig                 |   13 +
>  drivers/virt/coco/Makefile                |    8 +
>  drivers/virt/coco/sev-guest/Kconfig       |    1 
>  drivers/virt/coco/sev-guest/sev-guest.c   |  129 ++++++++++++-
>  drivers/virt/coco/tdx-guest/Kconfig       |    1 
>  drivers/virt/coco/tsm.c                   |  290 +++++++++++++++++++++++++++++
>  include/linux/slab.h                      |    2 
>  include/linux/tsm.h                       |   45 +++++
>  12 files changed, 535 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
>  create mode 100644 drivers/virt/coco/Kconfig
>  create mode 100644 drivers/virt/coco/Makefile
>  create mode 100644 drivers/virt/coco/tsm.c
>  create mode 100644 include/linux/tsm.h
> 
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5

