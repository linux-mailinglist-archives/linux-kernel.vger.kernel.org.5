Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB81E7AF844
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 04:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjI0Cmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 22:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjI0Ckr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 22:40:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31584659D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 19:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695780626; x=1727316626;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kveecs4ZZUkL6sCj9WNdfm8RwNUO+atIIsQCXtuPCCM=;
  b=Gy7jDIH3c9Z+NOLw86kz93TUKBmZuDTZfFC7CMd/z4NsslG2MQG6viOK
   OZn1e4hP/ukWuia6diI/+8s6c6h/1AfypJBedtUmENQHc8hLePbEX7U4m
   vKYXEq46Dx46K8TIEuu3qWP0iJRu6K33rIkvjx7S++719zzIR6CFHtQMB
   iBL2K7LQnXXDug4dshaoU9o2RT8DumyEC35+TVvHmmLoNUHTz6VZkQr67
   Oku6Ts2wDqLoMCYWk33JNMa81CKyGYUqgxb7ma2+uw2O6wR7+74QGrOJp
   N62iQ6+v6mRqkqoZYlCB3tSgvGfljS7riumi3PH3amIKoKAVhVzLv7qE9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385566324"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="385566324"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 19:10:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="742545288"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="742545288"
Received: from cchiu4-mobl.gar.corp.intel.com (HELO [10.212.145.91]) ([10.212.145.91])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 19:10:21 -0700
Message-ID: <c33e03c7-a03a-47fb-bcf3-31fdb041a9df@linux.intel.com>
Date:   Tue, 26 Sep 2023 19:10:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] configfs-tsm: Introduce a shared ABI for
 attestation reports
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570182987.596431.14062417344858914481.stgit@dwillia2-xfh.jf.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <169570182987.596431.14062417344858914481.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_NONE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/2023 9:17 PM, Dan Williams wrote:
> One of the common operations of a TSM (Trusted Security Module) is to
> provide a way for a TVM (confidential computing guest execution
> environment) to take a measurement of its launch state, sign it and
> submit it to a verifying party. Upon successful attestation that
> verifies the integrity of the TVM additional secrets may be deployed.
> The concept is common across TSMs, but the implementations are
> unfortunately vendor specific. While the industry grapples with a common
> definition of this attestation format [1], Linux need not make this
> problem worse by defining a new ABI per TSM that wants to perform a
> similar operation. The current momentum has been to invent new ioctl-ABI
> per TSM per function which at best is an abdication of the kernel's
> responsibility to make common infrastructure concepts share common ABI.
> 
> The proposal, targeted to conceptually work with TDX, SEV-SNP, COVE if
> not more, is to define a configfs interface to retrieve the TSM-specific
> blob.
> 
>     report=/sys/kernel/config/tsm/report/report0
>     mkdir $report
>     dd if=binary_userdata_plus_nonce > $report/inblob
>     hexdump $report/outblob
> 
> This approach later allows for the standardization of the attestation
> blob format without needing to invent a new ABI. Once standardization
> happens the standard format can be emitted by $report/outblob and
> indicated by $report/provider, or a new attribute like
> "$report/tcg_coco_report" can emit the standard format alongside the
> vendor format.
> 
> Review of previous iterations of this interface identified that there is
> a need to scale report generation for multiple container environments
> [2]. Configfs enables a model where each container can bind mount one or
> more report generation item instances. Still, within a container only a
> single thread can be manipulating a given configuration instance at a
> time. A 'generation' count is provided to detect conflicts between
> multiple threads racing to configure a report instance.
> 
> The SEV-SNP concepts of "extended reports" and "privilege levels" are
> optionally enabled by selecting 'tsm_report_ext_type' at register_tsm()
> time. The expectation is that those concepts are generic enough that
> they may be adopted by other TSM implementations. In other words,
> configfs-tsm aims to address a superset of TSM specific functionality
> with a common ABI where attributes may appear, or not appear, based on the set
> of concepts the implementation supports.
> 
> Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> Link: http://lore.kernel.org/r/57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com [2]
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/configfs-tsm |   67 +++++
>  MAINTAINERS                            |    8 +
>  drivers/virt/coco/Kconfig              |    5 
>  drivers/virt/coco/Makefile             |    1 
>  drivers/virt/coco/tsm.c                |  411 ++++++++++++++++++++++++++++++++
>  include/linux/tsm.h                    |   63 +++++
>  6 files changed, 555 insertions(+)
>  create mode 100644 Documentation/ABI/testing/configfs-tsm
>  create mode 100644 drivers/virt/coco/tsm.c
>  create mode 100644 include/linux/tsm.h
> 

[...]

> +
> +static ssize_t __read_report(struct tsm_report *report, void *buf, size_t count,
> +			     enum tsm_data_select select)
> +{
> +	loff_t offset = 0;
> +	u8 *out, len;

When testing I noticed that it reports incorrect buf len. After debugging, noticed
that using u8 for len is incorrect. It should be size_t.

> +
> +	if (select == TSM_REPORT) {
> +		out = report->outblob;
> +		len = report->outblob_len;
> +	} else {
> +		out = report->certs;
> +		len = report->certs_len;
> +	}
> +
> +	if (!buf)
> +		return len;
> +	return memory_read_from_buffer(buf, count, &offset, out, len);
> +}
> +

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
