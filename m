Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC467A8310
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjITNRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjITNRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:17:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA2AE9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695215801; x=1726751801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VW+drr/qZ2AoNRhcAeXnR+mPJJ3TgRmG1iYQDrJ62sM=;
  b=bQQ11YACprpV0QMB6X/PHgwhfGvtY3OPqefBKY6YB0z3+N1gMllMqKn4
   fDN3uOcy0b2/Qg2XNf/IwM5VWF5QX+c7TKLZil9u9VOyNJKBOEDgbFU6w
   giRn8kuVd+ZBqn6Np3joc+FPY6o//MdOA81qckPj5tQlbXYWmCfUiJZbT
   CRvJHPB/miJo72ZMmWDpMA7Olc7SwlY6v4OY+T+cOm2zbEFvjrw4JIlWa
   MXGtszLsaKdZJMXaVgo7qvGhjEWlIDtaxUXU923CtwuEsxfcpH/HXGr2s
   2r3dkG0I6cFgdzydnSRadMLkNw2r195gDUz179l/MBerLmjBh2X/JHoqd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="411162169"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="411162169"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="889922112"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="889922112"
Received: from zhijingf-mobl1.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.218.227])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:15:48 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C5B66109E26; Wed, 20 Sep 2023 16:16:33 +0300 (+03)
Date:   Wed, 20 Sep 2023 16:16:33 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        linux-coco@lists.linux.dev, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virt: tdx-guest: Add Quote generation support using
 TSM_REPORTS
Message-ID: <20230920131633.ig6ldmwavpu7uhss@box.shutemov.name>
References: <20230914031349.23516-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914031349.23516-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 03:13:49AM +0000, Kuppuswamy Sathyanarayanan wrote:
> In TDX guest, the attestation process is used to verify the TDX guest
> trustworthiness to other entities before provisioning secrets to the
> guest. The First step in the attestation process is TDREPORT

s/First/first/ ?

> generation, which involves getting the guest measurement data in the
> format of TDREPORT, which is further used to validate the authenticity
> of the TDX guest. TDREPORT by design is integrity-protected and can
> only be verified on the local machine.
> 
> To support remote verification of the TDREPORT (in a SGX-based
> attestation), the TDREPORT needs to be sent to the SGX Quoting Enclave

Parentheses can be dropped.

> (QE) to convert it to a remotely verifiable Quote. SGX QE by design can
> only run outside of the TDX guest (i.e. in a host process or in a
> normal VM) and guest can use communication channels like vsock or
> TCP/IP to send the TDREPORT to the QE. But for security concerns, the
> TDX guest may not support these communication channels. To handle such
> cases, TDX defines a GetQuote hypercall which can be used by the guest
> to request the host VMM to communicate with the SGX QE. More details
> about GetQuote hypercall can be found in TDX Guest-Host Communication
> Interface (GHCI) for Intel TDX 1.0, section titled
> "TDG.VP.VMCALL<GetQuote>".
> 
> Trusted Security Module (TSM) [1] exposes a common ABI for Confidential
> Computing Guest platforms to get the measurement data via ConfigFS.
> Extend the TSM framework and add support to allow an attestation agent
> to get the TDX Quote data (included usage example below).
> 
>   report=/sys/kernel/config/tsm/report/report0
>   mkdir $report
>   dd if=/dev/urandom bs=64 count=1 > $report/inblob
>   hexdump -C $report/outblob
>   rmdir $report
> 
> GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
> with TDREPORT data as input, which is further used by the VMM to copy
> the TD Quote result after successful Quote generation. To create the
> shared buffer, allocate a large enough memory and mark it shared using
> set_memory_decrypted() in tdx_guest_init(). This buffer will be re-used
> for GetQuote requests in the TDX TSM handler.
> 
> Although this method reserves a fixed chunk of memory for GetQuote
> requests, such one time allocation can help avoid memory fragmentation
> related allocation failures later in the uptime of the guest.
> 
> Since the Quote generation process is not time-critical or frequently
> used, the current version uses a polling model for Quote requests and
> it also does not support parallel GetQuote requests.
> 
> Link: https://lore.kernel.org/lkml/169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com/ [1]
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

The patch looks good to me. See one question below.

> ---
> 
> Hi All,
> 
> The original version of this patch series [1] added support for TDX
> Guest Quote generation via an IOCTL interface. Since we have multiple
> vendors implementing such interface, to avoid ABI proliferation, Dan
> proposed using a common ABI for it and submitted the Trusted Secure
> module (TSM) report ABI support [2]. This patchset extends the
> TSM REPORTS to implement the TDX Quote generation support. Since there
> is a change in interface type, I have dropped the previous Acks.
> 
> [1] https://lore.kernel.org/lkml/3c57deb0-a311-2aad-c06b-4938e33491b5@linux.intel.com/
> [2] https://lore.kernel.org/lkml/169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com/
> 
> Changes since v1:
>  * Used mutext_lock_interruptible() for quote_lock to allow user
>    interruption.
>  * Used msleep_interruptible() instead of ssleep() to allow user
>    interruption.
>  * Added check for the set_memory_encrypted() return value.
>  * Fixed typos in comments and commit log.
> 
> Changes since previous version:
>  * Used ConfigFS interface instead of IOCTL interface.
>  * Used polling model for Quote generation and dropped the event notification IRQ support.
> 
>  arch/x86/coco/tdx/tdx.c                 |  21 +++
>  arch/x86/include/asm/shared/tdx.h       |   1 +
>  arch/x86/include/asm/tdx.h              |   2 +
>  drivers/virt/coco/tdx-guest/Kconfig     |   1 +
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 225 +++++++++++++++++++++++-
>  5 files changed, 249 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 1d6b863c42b0..752867b1d11b 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -104,6 +104,27 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
>  }
>  EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
>  
> +/**
> + * tdx_hcall_get_quote() - Wrapper to request TD Quote using GetQuote
> + *                         hypercall.
> + * @buf: Address of the directly mapped shared kernel buffer which
> + *       contains TDREPORT. The same buffer will be used by VMM to
> + *       store the generated TD Quote output.
> + * @size: size of the tdquote buffer (4KB-aligned).
> + *
> + * Refer to section titled "TDG.VP.VMCALL<GetQuote>" in the TDX GHCI
> + * v1.0 specification for more information on GetQuote hypercall.
> + * It is used in the TDX guest driver module to get the TD Quote.
> + *
> + * Return 0 on success or error code on failure.
> + */
> +u64 tdx_hcall_get_quote(u8 *buf, size_t size)
> +{
> +	/* Since buf is a shared memory, set the shared (decrypted) bits */
> +	return _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(buf)), size, 0, 0);
> +}
> +EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
> +
>  static void __noreturn tdx_panic(const char *msg)
>  {
>  	struct tdx_hypercall_args args = {
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index 7513b3bb69b7..9eab19950f39 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -22,6 +22,7 @@
>  
>  /* TDX hypercall Leaf IDs */
>  #define TDVMCALL_MAP_GPA		0x10001
> +#define TDVMCALL_GET_QUOTE		0x10002
>  #define TDVMCALL_REPORT_FATAL_ERROR	0x10003
>  
>  #ifndef __ASSEMBLY__
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 603e6d1e9d4a..ebd1cda4875f 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -52,6 +52,8 @@ bool tdx_early_handle_ve(struct pt_regs *regs);
>  
>  int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
>  
> +u64 tdx_hcall_get_quote(u8 *buf, size_t size);
> +
>  #else
>  
>  static inline void tdx_early_init(void) { };
> diff --git a/drivers/virt/coco/tdx-guest/Kconfig b/drivers/virt/coco/tdx-guest/Kconfig
> index 14246fc2fb02..22dd59e19431 100644
> --- a/drivers/virt/coco/tdx-guest/Kconfig
> +++ b/drivers/virt/coco/tdx-guest/Kconfig
> @@ -1,6 +1,7 @@
>  config TDX_GUEST_DRIVER
>  	tristate "TDX Guest driver"
>  	depends on INTEL_TDX_GUEST
> +	select TSM_REPORTS
>  	help
>  	  The driver provides userspace interface to communicate with
>  	  the TDX module to request the TDX guest details like attestation
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index 5e44a0fa69bd..9d9b92ca9b16 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -12,12 +12,60 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> +#include <linux/set_memory.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/tsm.h>
> +#include <linux/sizes.h>
>  
>  #include <uapi/linux/tdx-guest.h>
>  
>  #include <asm/cpu_device_id.h>
>  #include <asm/tdx.h>
>  
> +/*
> + * Intel's SGX QE implementation generally uses Quote size less
> + * than 8K (2K Quote data + ~5K of certificate blob).
> + */
> +#define GET_QUOTE_BUF_SIZE		SZ_8K
> +
> +#define GET_QUOTE_CMD_VER		1
> +
> +/* TDX GetQuote status codes */
> +#define GET_QUOTE_SUCCESS		0
> +#define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
> +
> +/* struct tdx_quote_buf: Format of Quote request buffer.
> + * @version: Quote format version, filled by TD.
> + * @status: Status code of Quote request, filled by VMM.
> + * @in_len: Length of TDREPORT, filled by TD.
> + * @out_len: Length of Quote data, filled by VMM.
> + * @data: Quote data on output or TDREPORT on input.
> + *
> + * More details of Quote request buffer can be found in TDX
> + * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
> + * section titled "TDG.VP.VMCALL<GetQuote>"
> + */
> +struct tdx_quote_buf {
> +	u64 version;
> +	u64 status;
> +	u32 in_len;
> +	u32 out_len;
> +	u8 data[];
> +};
> +
> +/* Quote data buffer */
> +static void *quote_data;
> +
> +/* Lock to streamline quote requests */
> +static DEFINE_MUTEX(quote_lock);
> +
> +/*
> + * GetQuote request timeout in seconds. Expect that 30 seconds
> + * is enough time for QE to respond to any Quote requests.
> + */
> +static u32 getquote_timeout = 30;
> +
>  static long tdx_get_report0(struct tdx_report_req __user *req)
>  {
>  	u8 *reportdata, *tdreport;
> @@ -53,6 +101,150 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
>  	return ret;
>  }
>  
> +static void free_quote_buf(void *buf)
> +{
> +	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
> +	unsigned int count = len >> PAGE_SHIFT;
> +
> +	if (set_memory_encrypted((unsigned long)buf, count)) {
> +		pr_err("Failed to restore encryption mask for Quote buffer, leak it\n");
> +		return;
> +	}
> +
> +	free_pages_exact(buf, len);
> +}
> +
> +static void *alloc_quote_buf(void)
> +{
> +	size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
> +	unsigned int count = len >> PAGE_SHIFT;
> +	void *addr;
> +
> +	addr = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
> +	if (!addr)
> +		return NULL;
> +
> +	if (set_memory_decrypted((unsigned long)addr, count)) {
> +		free_pages_exact(addr, len);
> +		return NULL;
> +	}
> +
> +	return addr;
> +}
> +
> +/*
> + * wait_for_quote_completion() - Wait for Quote request completion
> + * @quote_buf: Address of Quote buffer.
> + * @timeout: Timeout in seconds to wait for the Quote generation.
> + *
> + * As per TDX GHCI v1.0 specification, sec titled "TDG.VP.VMCALL<GetQuote>",
> + * the status field in the Quote buffer will be set to GET_QUOTE_IN_FLIGHT
> + * while VMM processes the GetQuote request, and will change it to success
> + * or error code after processing is complete. So wait till the status
> + * changes from GET_QUOTE_IN_FLIGHT or the request being timed out.
> + */
> +static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeout)
> +{
> +	int i = 0;
> +
> +	/*
> +	 * Quote requests usually take a few seconds to complete, so waking up
> +	 * once per second to recheck the status is fine for this use case.
> +	 */
> +	while (quote_buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout) {
> +		if (msleep_interruptible(MSEC_PER_SEC))
> +			return -EINTR;
> +	}
> +
> +	return (i == timeout) ? -ETIMEDOUT : 0;
> +}
> +
> +static u8 *tdx_report_new(const struct tsm_desc *desc, void *data, size_t *outblob_len)
> +{
> +	struct tdx_quote_buf *quote_buf = quote_data;
> +	int ret;
> +	u8 *buf;
> +	u64 err;
> +
> +	if (mutex_lock_interruptible(&quote_lock))
> +		return ERR_PTR(-EINTR);
> +
> +	/*
> +	 * If the previous request is timedout or interrupted, and the
> +	 * Quote buf status is still in GET_QUOTE_IN_FLIGHT (owned by
> +	 * VMM), don't permit any new request.
> +	 */
> +	if (quote_buf->status == GET_QUOTE_IN_FLIGHT) {
> +		ret = -EBUSY;
> +		goto done;
> +	}
> +
> +	if (desc->inblob_len != TDX_REPORTDATA_LEN) {
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	/* TDX attestation only supports default format request */
> +	if (desc->outblob_format != TSM_FORMAT_DEFAULT) {
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	u8 *reportdata __free(kfree) = kmalloc(TDX_REPORTDATA_LEN, GFP_KERNEL);

__free() is new to me. Good to know.

But are we okay now with declaring variables in the middle of the
function? Any reason we can't do at the top?

> +	if (!reportdata) {
> +		ret = -ENOMEM;
> +		goto done;
> +	}
> +
> +	u8 *tdreport __free(kfree) = kzalloc(TDX_REPORT_LEN, GFP_KERNEL);
> +	if (!tdreport) {
> +		ret = -ENOMEM;
> +		goto done;
> +	}
> +
> +	memcpy(reportdata, desc->inblob, desc->inblob_len);
> +
> +	/* Generate TDREPORT0 using "TDG.MR.REPORT" TDCALL */
> +	ret = tdx_mcall_get_report0(reportdata, tdreport);
> +	if (ret) {
> +		pr_err("GetReport call failed\n");
> +		goto done;
> +	}
> +
> +	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
> +
> +	/* Update Quote buffer header */
> +	quote_buf->version = GET_QUOTE_CMD_VER;
> +	quote_buf->in_len = TDX_REPORT_LEN;
> +
> +	memcpy(quote_buf->data, tdreport, TDX_REPORT_LEN);
> +
> +	err = tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
> +	if (err) {
> +		pr_err("GetQuote hypercall failed, status:%llx\n", err);
> +		ret = -EIO;
> +		goto done;
> +	}
> +
> +	ret = wait_for_quote_completion(quote_buf, getquote_timeout);
> +	if (ret) {
> +		pr_err("GetQuote request timedout\n");
> +		goto done;
> +	}
> +
> +	buf = kvmemdup(quote_buf->data, quote_buf->out_len, GFP_KERNEL);
> +	if (!buf) {
> +		ret = -ENOMEM;
> +		goto done;
> +	}
> +
> +	*outblob_len = quote_buf->out_len;
> +
> +done:
> +	mutex_unlock(&quote_lock);
> +	return ret ? ERR_PTR(ret) : buf;
> +}
> +
>  static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
>  			    unsigned long arg)
>  {
> @@ -82,17 +274,48 @@ static const struct x86_cpu_id tdx_guest_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
>  
> +static const struct tsm_ops tdx_tsm_ops = {
> +	.name = KBUILD_MODNAME,
> +	.report_new = tdx_report_new,
> +};
> +
>  static int __init tdx_guest_init(void)
>  {
> +	int ret;
> +
>  	if (!x86_match_cpu(tdx_guest_ids))
>  		return -ENODEV;
>  
> -	return misc_register(&tdx_misc_dev);
> +	ret = misc_register(&tdx_misc_dev);
> +	if (ret)
> +		return ret;
> +
> +	quote_data = alloc_quote_buf();
> +	if (!quote_data) {
> +		pr_err("Failed to allocate Quote buffer\n");
> +		ret = -ENOMEM;
> +		goto free_misc;
> +	}
> +
> +	ret = register_tsm(&tdx_tsm_ops, NULL, NULL);
> +	if (ret)
> +		goto free_quote;
> +
> +	return 0;
> +
> +free_quote:
> +	free_quote_buf(quote_data);
> +free_misc:
> +	misc_deregister(&tdx_misc_dev);
> +
> +	return ret;
>  }
>  module_init(tdx_guest_init);
>  
>  static void __exit tdx_guest_exit(void)
>  {
> +	unregister_tsm(&tdx_tsm_ops);
> +	free_quote_buf(quote_data);
>  	misc_deregister(&tdx_misc_dev);
>  }
>  module_exit(tdx_guest_exit);
> -- 
> 2.25.1
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
