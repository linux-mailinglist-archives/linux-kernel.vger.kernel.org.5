Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA5279802E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 03:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbjIHBar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 21:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjIHBaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 21:30:46 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E511BD7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 18:30:40 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-64c5f5d6f04so8486216d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 18:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694136638; x=1694741438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/64bU2tokttUzxagBhnSp4adgvc+GQBLhUKHEU2rZw=;
        b=46hAI0bzv2VEYiZMbixFQU+a6WbzQzRLIJgs73sreoFhRjpidUJXlqwA7Hh4+kAJ8t
         v3W0fT2c+fjGZvUTenifsz5dE+xcxS0H6gVOL3VhO0oehkswnH+rRXwKojtyU628SQLd
         moZIlD9NYH4bzrpaIv7ZCQF2WrkFHxhDb7Tev3qTbHJ+U55AQsK4uxd73gcHSuFfnJvq
         RhPp6sj7is4h9wRMM889Z8HH93zjUHyczhoqKjucNDWiPpy2Hh1URVu5OCfUBkbbItSU
         nvt8jUEwCmvYOHWgC3w1O4Lvr9Ghc6WIJiKN0TknyjaXesT317lOCp+ZWLu7PmwA4dnq
         XcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694136638; x=1694741438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/64bU2tokttUzxagBhnSp4adgvc+GQBLhUKHEU2rZw=;
        b=F3fFElcWI42HZl/3GoBQzeqRaS56JDEykXym8QMn24ln8TVDIfrgoWGcr9TJ0K7sc+
         DOZKGg+mWPbE/ti0reVYqRTocH9HFTV2DWQ2jA0vRSBuwgxn4jEoNXbHkoR5eXRUNvDw
         mPxvqrnXtqD/x4vYm/FGAf1CXqZagyIs7ZLd6BUr7sIPLRkhAuj2jnTiXB2fUjugma/F
         vs6eb+F2lvgjFy6cRlL5v/4+55GQGOOaQO0qmgBKNDtnJxuIN+8qN1H5JkHihSgaN1JO
         BP7aqjtU4DewICS/qPLU/tj1MSeVzxhVcFFb660rCNg3t9rMODeQBIEmCMSewnH55qhD
         nB1g==
X-Gm-Message-State: AOJu0YzvH+n2g1kAkJj1yMDpb1XG4l3r7M4WWfzhNGwgwpDUqitLUNr+
        Ku58FcYOm1A02FRX2Hcj0bm6Yk+dTGb5kbI9NMv00w==
X-Google-Smtp-Source: AGHT+IH8FkAYZtTcb4KGQrNWCvzUtgYXVmio756Cyh8cKKTEE2nJbgEeikHjDUyu4+pMvZDVBdpEdyXZGrJ2DGdcCuo=
X-Received: by 2002:a0c:e483:0:b0:63c:fb61:a201 with SMTP id
 n3-20020a0ce483000000b0063cfb61a201mr986000qvl.35.1694136638400; Thu, 07 Sep
 2023 18:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230907025405.2310931-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230907025405.2310931-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Erdem Aktas <erdemaktas@google.com>
Date:   Thu, 7 Sep 2023 18:30:26 -0700
Message-ID: <CAAYXXYzWMaruiTm84d=djM1Jekk-Ua9cEEZWWuZ-mh6knsCvTg@mail.gmail.com>
Subject: Re: [PATCH v1] virt: tdx-guest: Add Quote generation support using TSM_REPORTS
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        linux-coco@lists.linux.dev, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 7:54=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> In TDX guest, the attestation process is used to verify the TDX guest
> trustworthiness to other entities before provisioning secrets to the
> guest. The First step in the attestation process is TDREPORT
> generation, which involves getting the guest measurement data in the
> format of TDREPORT, which is further used to validate the authenticity
> of the TDX guest. TDREPORT by design is integrity-protected and can
> only be verified on the local machine.
>
> To support remote verification of the TDREPORT (in a SGX-based
> attestation), the TDREPORT needs to be sent to the SGX Quoting Enclave
> (QE) to convert it to a remote verifiable Quote. SGX QE by design can
s/remote/remotely ?
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
>   report=3D/sys/kernel/config/tsm/report/report0
>   mkdir $report
>   dd if=3D/dev/urandom bs=3D64 count=3D1 > $report/inblob
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
> Link: https://lore.kernel.org/lkml/169342399185.3934343.30358453483269445=
19.stgit@dwillia2-xfh.jf.intel.com/ [1]
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> ---
>
> Hi All,
>
> The previous version of this patch series [1] added support for TDX
> Guest Quote generation via an IOCTL interface. Since we have multiple
> vendors implementing such interface, to avoid ABI proliferation, Dan
> proposed using a common ABI for it and submitted the Trusted Secure
> module (TSM) report ABI support [2]. This patchset extends the
> TSM REPORTS to implement the TDX Quote generation support. Since there
> is a change in interface type, I have dropped the previous Acks.
>
> [1] https://lore.kernel.org/lkml/3c57deb0-a311-2aad-c06b-4938e33491b5@lin=
ux.intel.com/
> [2] https://lore.kernel.org/lkml/169342399185.3934343.3035845348326944519=
.stgit@dwillia2-xfh.jf.intel.com/
>
> Changes since previous version:
> * Used ConfigFS interface instead of IOCTL interface.
> * Used polling model for Quote generation and dropped the event notificat=
ion IRQ support.
>
>  arch/x86/coco/tdx/tdx.c                 |  21 +++
>  arch/x86/include/asm/shared/tdx.h       |   1 +
>  arch/x86/include/asm/tdx.h              |   2 +
>  drivers/virt/coco/tdx-guest/Kconfig     |   1 +
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 205 +++++++++++++++++++++++-
>  5 files changed, 229 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 1d6b863c42b0..20414ed82fc5 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -104,6 +104,27 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdrepo=
rt)
>  }
>  EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
>
> +/**
> + * tdx_hcall_get_quote() - Wrapper to request TD Quote using GetQuote
> + *                         hypercall.
> + * @buf: Address of the directly mapped shared kernel buffer which
> + *      contains TDREPORT data. The same buffer will be used by
> + *      VMM to store the generated TD Quote output.
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
> +       /* Since buf is a shared memory, set the shared (decrypted) bits =
*/
> +       return _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(b=
uf)), size, 0, 0);
> +}
> +EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
> +
>  static void __noreturn tdx_panic(const char *msg)
>  {
>         struct tdx_hypercall_args args =3D {
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/sha=
red/tdx.h
> index 7513b3bb69b7..9eab19950f39 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -22,6 +22,7 @@
>
>  /* TDX hypercall Leaf IDs */
>  #define TDVMCALL_MAP_GPA               0x10001
> +#define TDVMCALL_GET_QUOTE             0x10002
>  #define TDVMCALL_REPORT_FATAL_ERROR    0x10003
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
> diff --git a/drivers/virt/coco/tdx-guest/Kconfig b/drivers/virt/coco/tdx-=
guest/Kconfig
> index 14246fc2fb02..22dd59e19431 100644
> --- a/drivers/virt/coco/tdx-guest/Kconfig
> +++ b/drivers/virt/coco/tdx-guest/Kconfig
> @@ -1,6 +1,7 @@
>  config TDX_GUEST_DRIVER
>         tristate "TDX Guest driver"
>         depends on INTEL_TDX_GUEST
> +       select TSM_REPORTS
>         help
>           The driver provides userspace interface to communicate with
>           the TDX module to request the TDX guest details like attestatio=
n
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/=
tdx-guest/tdx-guest.c
> index 5e44a0fa69bd..135d89a7e418 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -12,12 +12,59 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> +#include <linux/set_memory.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/tsm.h>
>
>  #include <uapi/linux/tdx-guest.h>
>
>  #include <asm/cpu_device_id.h>
>  #include <asm/tdx.h>
>
> +/*
> + * Intel's SGX QE implementation generally uses Quote size less
> + * than 8K (2K Quote data + ~5K of ceritificate blob).
s/ceritificate/certificate
> + */
> +#define GET_QUOTE_BUF_SIZE             SZ_8K
> +
> +#define GET_QUOTE_CMD_VER              1
> +
> +/* TDX GetQuote status codes */
> +#define GET_QUOTE_SUCCESS              0
> +#define GET_QUOTE_IN_FLIGHT            0xffffffffffffffff
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
> +       u64 version;
> +       u64 status;
> +       u32 in_len;
> +       u32 out_len;
> +       u8 data[];
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
> +static u32 getquote_timeout =3D 30;
> +
>  static long tdx_get_report0(struct tdx_report_req __user *req)
>  {
>         u8 *reportdata, *tdreport;
> @@ -53,6 +100,131 @@ static long tdx_get_report0(struct tdx_report_req __=
user *req)
>         return ret;
>  }
>
> +static void free_quote_buf(void *buf)
> +{
> +       size_t len =3D PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
> +       unsigned int count =3D len >> PAGE_SHIFT;
> +
> +       set_memory_encrypted((unsigned long)buf, count);
Why not check the return error? if conversion fails (even though
unlikely), we should at least print an error message.
> +
> +       free_pages_exact(buf, len);
> +}
> +
> +static void *alloc_quote_buf(void)
> +{
> +       size_t len =3D PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
> +       unsigned int count =3D len >> PAGE_SHIFT;
> +       void *addr;
> +       int ret;
> +
> +       addr =3D alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
> +       if (!addr)
> +               return NULL;
> +
> +       ret =3D set_memory_decrypted((unsigned long)addr, count);
> +       if (ret) {
> +               free_pages_exact(addr, len);
> +               return NULL;
> +       }
> +
> +       return addr;
> +}
> +
> +/*
> + * wait_for_quote_completion() - Wait for Quote request completion
> + * @quote_buf: Address of Quote buffer.
> + * @timeout: Timeout in seconds to wait for the Quote generation.
> + *
> + * As per TDX GHCI v1.0 specification, sec titled "TDG.VP.VMCALL<GetQuot=
e>",
> + * the status field in the Quote buffer will be set to GET_QUOTE_IN_FLIG=
HT
> + * while VMM processes the GetQuote request, and will change it to succe=
ss
> + * or error code after processing is complete. So wait till the status
> + * changes from GET_QUOTE_IN_FLIGHT or the request timedout.
s/timedout/being timed out?
> + */
> +static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u3=
2 timeout)
> +{
> +       int i =3D 0;
> +
> +       /*
> +        * Quote requests usually take a few seconds to complete, so waki=
ng up
> +        * once per second to recheck the status is fine for this use cas=
e.
> +        */
> +       while (quote_buf->status =3D=3D GET_QUOTE_IN_FLIGHT && i++ < time=
out)
> +               ssleep(1);
Would not this loop cause soft lock (or even panic) if getquote waits
for 30s? Should we not yield?
> +
> +       return (i =3D=3D timeout) ? -ETIMEDOUT : 0;
> +}
> +
> +static u8 *tdx_report_new(const struct tsm_desc *desc, void *data, size_=
t *outblob_len)
> +{
> +       struct tdx_quote_buf *quote_buf =3D quote_data;
> +       int ret;
> +       u8 *buf;
> +       u64 err;
> +
> +       guard(mutex)(&quote_lock);
I understand that this does not support parallel getQuote requests but
if the user space for some reason makes multiple requests, each
request will finish until the previous ones are completed in kernel
scope which might cause soft lockups. Should now we return  EBUSY if
the lock is already taken?
> +
> +       /*
> +        * If the previous request is timedout and Quote buf status is
> +        * still in GET_QUOTE_IN_FLIGHT (owned by VMM), don't permit any
> +        * new request.
> +        */
> +       if (quote_buf->status =3D=3D GET_QUOTE_IN_FLIGHT)
> +               return ERR_PTR(-EBUSY);
> +
> +       if (desc->inblob_len !=3D TDX_REPORTDATA_LEN)
> +               return ERR_PTR(-EINVAL);
> +
> +       /* TDX attestation does not support multiple formats */
> +       if (desc->outblob_format !=3D TSM_FORMAT_DEFAULT)
> +               return ERR_PTR(-EINVAL);
> +
> +       u8 *reportdata __free(kfree) =3D kmalloc(TDX_REPORTDATA_LEN, GFP_=
KERNEL);
> +       if (!reportdata)
> +               return ERR_PTR(-ENOMEM);
> +
> +       u8 *tdreport __free(kfree) =3D kzalloc(TDX_REPORT_LEN, GFP_KERNEL=
);
> +       if (!tdreport)
> +               return ERR_PTR(-ENOMEM);
> +
> +       memcpy(reportdata, desc->inblob, desc->inblob_len);
> +
> +       /* Generate TDREPORT0 using "TDG.MR.REPORT" TDCALL */
> +       ret =3D tdx_mcall_get_report0(reportdata, tdreport);
> +       if (ret) {
> +               pr_err("GetReport call failed\n");
> +               return ERR_PTR(ret);
> +       }
> +
> +       memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
> +
> +       /* Update Quote buffer header */
> +       quote_buf->version =3D GET_QUOTE_CMD_VER;
> +       quote_buf->in_len =3D TDX_REPORT_LEN;
> +
> +       memcpy(quote_buf->data, tdreport, TDX_REPORT_LEN);
> +
> +       err =3D tdx_hcall_get_quote(quote_data, GET_QUOTE_BUF_SIZE);
> +       if (err) {
> +               pr_err("GetQuote hypercall failed, status:%llx\n", err);
> +               return ERR_PTR(-EIO);
> +       }
> +
Should not we set the quote_bud->status =3D GET_QUOTE_IN_FLIGHT in somewher=
e here?
> +       ret =3D wait_for_quote_completion(quote_buf, getquote_timeout);
> +       if (ret) {
> +               pr_err("GetQuote request timedout\n");
> +               return ERR_PTR(ret);
> +       }
> +
> +       buf =3D kvmemdup(quote_buf->data, quote_buf->out_len, GFP_KERNEL)=
;
> +       if (!buf)
> +               return ERR_PTR(-ENOMEM);
> +
> +       *outblob_len =3D quote_buf->out_len;
> +
> +       return buf;
> +}
> +
>  static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
>                             unsigned long arg)
>  {
> @@ -82,17 +254,48 @@ static const struct x86_cpu_id tdx_guest_ids[] =3D {
>  };
>  MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
>
> +static const struct tsm_ops tdx_tsm_ops =3D {
> +       .name =3D KBUILD_MODNAME,
> +       .report_new =3D tdx_report_new,
> +};
> +
>  static int __init tdx_guest_init(void)
>  {
> +       int ret;
> +
>         if (!x86_match_cpu(tdx_guest_ids))
>                 return -ENODEV;
>
> -       return misc_register(&tdx_misc_dev);
> +       ret =3D misc_register(&tdx_misc_dev);
> +       if (ret)
> +               return ret;
> +
> +       quote_data =3D alloc_quote_buf();
> +       if (!quote_data) {
> +               pr_err("Failed to allocate Quote buffer\n");
> +               ret =3D -ENOMEM;
> +               goto free_misc;
> +       }
> +
> +       ret =3D register_tsm(&tdx_tsm_ops, NULL, NULL);
> +       if (ret)
> +               goto free_quote;
> +
> +       return 0;
> +
> +free_quote:
> +       free_quote_buf(quote_data);
> +free_misc:
> +       misc_deregister(&tdx_misc_dev);
> +
> +       return ret;
>  }
>  module_init(tdx_guest_init);
>
>  static void __exit tdx_guest_exit(void)
>  {
> +       unregister_tsm(&tdx_tsm_ops);
> +       free_quote_buf(quote_data);
>         misc_deregister(&tdx_misc_dev);
>  }
>  module_exit(tdx_guest_exit);
> --
> 2.25.1
>
