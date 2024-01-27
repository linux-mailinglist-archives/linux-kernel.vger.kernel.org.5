Return-Path: <linux-kernel+bounces-40949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1393D83E8B0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6DF32842C0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616F4259D;
	Sat, 27 Jan 2024 00:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xwEgdEtX"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B9C1FAF
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316366; cv=none; b=e0vHLq/skBaRDIDYets8EdANxBvIFaypSSmY86Rorge4krjFMqTLAq16XJihi0/Mw+wqSzlpHyghPsQ/3aCFUmpkRsxYtZ2EbvnaK76n/7dR8FJmWk51M3s0rmBWlQcKgFzqBdgpyZgJX5nOxmK0yz0yYZV2HtiKaJA0uwGlIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316366; c=relaxed/simple;
	bh=07AjgJn9WrMyOrjy4hnkOLJQArVjMFMLEJ3pHy+rmmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhReG37Oi4p1y+cX2R5xzziyIDvbt5vPcatgb/wHerYgCSB3gXC6keXMkqSyQxIHdxNlNQQ1JMfKdwii7l1N/nlMSCcxlmcyHG2VwC0PZwVcoDmMeo1zmd8PIB1dO455T0Tzez4ryNW+dnuDXt7T1KH8VO54X7AS6IHdPSuebdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xwEgdEtX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55c89dbef80so1616a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706316361; x=1706921161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bo9KrQHSyZdfK49WjJyMaqh0CnVrI8rMO6L8vI4JGlw=;
        b=xwEgdEtXekvDeNC6J7LFLLPhNFhM5XeEVKq1Pwa7NngHirQd1qCVmVU57spQgeeoOF
         Bu/VJhXLkqhx+T5vpx5WGakTQ6CKdSvIMF7V1d9lvaVTtHPSsJxQwFswkWBrYgXJMM0n
         Q9p9z9NlPWtqFq5tC6hV7UHFsu02iaQfra3tqgmrD4u8XKNbiXXiGumsokQTgaBVZXUi
         txQDam22kEfkHpkd6aSH0opQbF8CbpPX5wWB10ibCd+uZ72YFERp5HxJWRrc5oyhW2sm
         jEfT7nMWr5zg+4zzqhElQc2kPzBioY9O22babmFbNzaoWzhXaEdW/PSuhLNr5teCANr3
         SS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706316361; x=1706921161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bo9KrQHSyZdfK49WjJyMaqh0CnVrI8rMO6L8vI4JGlw=;
        b=CHmu6L1wEt935w8xwD22udIpjoP9qWR3y469jCW01+bjpXkDB+nYAM5Pd5AZ67N5ms
         eok8DGlWgzHZ9kSLrr369d8rKJnjbgiOVbv+pe9L7z7Orf7XseLZSIyPzpG1gc5DB9/J
         wF2JWOzshWDviyA93MbzfO9Y2gMedylZaarH0/b8xpFeeucU0oqSu50XTgZYDpbasyeq
         iB58pS/TuSwPzf/JyTmrXnVLio/2eOr/jPz7yGtWT0fGTs/RrEx/0Hq7UxZgdqmngGMU
         4cy5VAcGqkEpPT8f6Ri+tR0ROUaUX1a4QAHrAeu6QZn2G2N9vOaagSmtJxccp4LcBRc8
         bcug==
X-Gm-Message-State: AOJu0YwVJpwVgU8XhVn1yIUyFWY1FiTTE5+b/z6ShL0wDVKmFzEOtWN9
	IlP/1iti3tB20LsTUlZzVqnHaQdbWjOZB3ucmEf7GQgNozaUY+M15H6T5rfkGq8ywdXR2wcBEQS
	X5sPKcB5TqdErwqevqz2Dk7Gd34te6dM3HWVo
X-Google-Smtp-Source: AGHT+IEuhaT72IG835llMD/1/t/sMRDkS0sr+Eu5TU7+8QNYXaKbEy5MOdx/S0MFnQTfp7O2A0G+T/iEPFdVuH8bQ9s=
X-Received: by 2002:a50:ed1a:0:b0:55d:2dda:f331 with SMTP id
 j26-20020a50ed1a000000b0055d2ddaf331mr235333eds.7.1706316361137; Fri, 26 Jan
 2024 16:46:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706307364.git.thomas.lendacky@amd.com> <8de29476ed1fcfeae79cbe43ee6dbbfecf7e86ea.1706307364.git.thomas.lendacky@amd.com>
In-Reply-To: <8de29476ed1fcfeae79cbe43ee6dbbfecf7e86ea.1706307364.git.thomas.lendacky@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Fri, 26 Jan 2024 16:45:46 -0800
Message-ID: <CAAH4kHZh1AdjLBNZ-=R6MK3OUmaSSFPWi==C0KVnTOCfVJkYBA@mail.gmail.com>
Subject: Re: [PATCH 04/11] x86/sev: Use kernel provided SVSM Calling Areas
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dan Williams <dan.j.williams@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 2:17=E2=80=AFPM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> The SVSM Calling Area (CA) is used to communicate between Linux and the
> SVSM. Since the firmware supplied CA for the BSP is likely to be in
> reserved memory, switch off that CA to a kernel provided CA so that acces=
s
> and use of the CA is available during boot. The CA switch is done using
> the SVSM core protocol SVSM_CORE_REMAP_CAA call.

REMAP_CA, not CAA.

>
> An SVSM call is executed by filling out the SVSM CA and setting the prope=
r
> register state as documented by the SVSM protocol. The SVSM is invoked by
> by requesting the hypervisor to run VMPL0.
>
> Once it is safe to allocate/reserve memory, allocate a CA for each CPU.
> After allocating the new CAs, the BSP will switch from the boot CA to the
> per-CPU CA. The CA for an AP is identified to the SVSM when creating the
> VMSA in preparation for booting the AP.
>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/sev-common.h |  13 ++
>  arch/x86/include/asm/sev.h        |  32 +++++
>  arch/x86/include/uapi/asm/svm.h   |   1 +
>  arch/x86/kernel/sev-shared.c      |  94 +++++++++++++-
>  arch/x86/kernel/sev.c             | 207 +++++++++++++++++++++++++-----
>  arch/x86/mm/mem_encrypt_amd.c     |   8 +-
>  6 files changed, 320 insertions(+), 35 deletions(-)
>
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev=
-common.h
> index 68a8cdf6fd6a..71db5ba020b9 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -96,6 +96,19 @@ enum psc_op {
>         /* GHCBData[63:32] */                           \
>         (((u64)(val) & GENMASK_ULL(63, 32)) >> 32)
>
> +/* GHCB Run at VMPL Request/Response */
> +#define GHCB_MSR_VMPL_REQ              0x016
> +#define GHCB_MSR_VMPL_REQ_LEVEL(v)                     \
> +       /* GHCBData[39:32] */                           \
> +       (((u64)(v) & GENMASK_ULL(7, 0) << 32) |         \
> +       /* GHCBDdata[11:0] */                           \
> +       GHCB_MSR_VMPL_REQ)
> +
> +#define GHCB_MSR_VMPL_RESP             0x017
> +#define GHCB_MSR_VMPL_RESP_VAL(v)                      \
> +       /* GHCBData[63:32] */                           \
> +       (((u64)(v) & GENMASK_ULL(63, 32)) >> 32)
> +
>  /* GHCB Hypervisor Feature Request/Response */
>  #define GHCB_MSR_HV_FT_REQ             0x080
>  #define GHCB_MSR_HV_FT_RESP            0x081
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 207c315041ba..2f1e583769fc 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -163,6 +163,36 @@ struct svsm_ca {
>         u8 svsm_buffer[PAGE_SIZE - 8];
>  };
>
> +#define SVSM_SUCCESS                           0
> +#define SVSM_ERR_INCOMPLETE                    0x80000000
> +#define SVSM_ERR_UNSUPPORTED_PROTOCOL          0x80000001
> +#define SVSM_ERR_UNSUPPORTED_CALL              0x80000002
> +#define SVSM_ERR_INVALID_ADDRESS               0x80000003
> +#define SVSM_ERR_INVALID_FORMAT                        0x80000004
> +#define SVSM_ERR_INVALID_PARAMETER             0x80000005
> +#define SVSM_ERR_INVALID_REQUEST               0x80000006
> +#define SVSM_ERR_BUSY                          0x80000007
> +
> +/*
> + * SVSM protocol structure
> + */
> +struct svsm_call {
> +       struct svsm_ca *caa;
> +       u64 rax;
> +       u64 rcx;
> +       u64 rdx;
> +       u64 r8;
> +       u64 r9;
> +       u64 rax_out;
> +       u64 rcx_out;
> +       u64 rdx_out;
> +       u64 r8_out;
> +       u64 r9_out;
> +};
> +
> +#define SVSM_CORE_CALL(x)              ((0ULL << 32) | (x))

Given that we should expect to see other SVSM protocols used in the
kernel, should we not have

#define SVSM_PROTOCOL_CALL(protocol, call) (((unsigned long)(protocol)
<< 32) | (call))
#define SVSM_CORE_PROTOCOL 0
#define SVSM_ATTESTATION_PROTOCOL 1
#define SVSM_VTPM_PROTOCOL 2

And then

#define SVSM_CORE_CALL(x) SVSM_PROTOCOL_CALL(SVSM_CORE_PROTOCOL, x)

or be cute and use symbol concatenation like

#define SVSM_PROTOCOL_ID(id) SVSM_##id##_PROTOCOL
#define SVSM_CALL(id, call) SVSM_PROTOCOL_CALL(SVSM_PROTOCOL_ID(id), call)

So you can just do SVSM_CALL(CORE, 0) ?

> +#define SVSM_CORE_REMAP_CA             0
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  extern void __sev_es_ist_enter(struct pt_regs *regs);
>  extern void __sev_es_ist_exit(void);
> @@ -236,6 +266,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp=
_req_data *input, struct sn
>  void snp_accept_memory(phys_addr_t start, phys_addr_t end);
>  u64 snp_get_unsupported_features(u64 status);
>  u64 sev_get_status(void);
> +void __init snp_remap_svsm_ca(void);
>  #else
>  static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>  static inline void sev_es_ist_exit(void) { }
> @@ -264,6 +295,7 @@ static inline int snp_issue_guest_request(u64 exit_co=
de, struct snp_req_data *in
>  static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end)=
 { }
>  static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
>  static inline u64 sev_get_status(void) { return 0; }
> +static inline void snp_remap_svsm_ca(void) { }
>  #endif
>
>  #endif
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/=
svm.h
> index 80e1df482337..1814b413fd57 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -115,6 +115,7 @@
>  #define SVM_VMGEXIT_AP_CREATE_ON_INIT          0
>  #define SVM_VMGEXIT_AP_CREATE                  1
>  #define SVM_VMGEXIT_AP_DESTROY                 2
> +#define SVM_VMGEXIT_SNP_RUN_VMPL               0x80000018
>  #define SVM_VMGEXIT_HV_FEATURES                        0x8000fffd
>  #define SVM_VMGEXIT_TERM_REQUEST               0x8000fffe
>  #define SVM_VMGEXIT_TERM_REASON(reason_set, reason_code)       \
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 99170f129eef..7e9fa5d8889b 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -14,7 +14,9 @@
>  #define has_cpuflag(f) boot_cpu_has(f)
>  #else
>  #undef WARN
> -#define WARN(condition, format...) (!!(condition))
> +#define WARN(condition, format...)     (!!(condition))
> +#undef vc_forward_exception
> +#define vc_forward_exception(c)                panic("SNP: Hypervisor re=
quested exception\n")
>  #endif
>
>  /* I/O parameters for CPUID-related helpers */
> @@ -240,6 +242,96 @@ static enum es_result verify_exception_info(struct g=
hcb *ghcb, struct es_em_ctxt
>         return ES_VMM_ERROR;
>  }
>
> +static __always_inline void issue_svsm_call(struct svsm_call *call, u8 *=
pending)
> +{
> +       /*
> +        * Issue the VMGEXIT to run the SVSM:
> +        *   - Load the SVSM register state (RAX, RCX, RDX, R8 and R9)
> +        *   - Set the CA call pending field to 1
> +        *   - Issue VMGEXIT
> +        *   - Save the SVSM return register state (RAX, RCX, RDX, R8 and=
 R9)
> +        *   - Perform atomic exchange of the CA call pending field
> +        */
> +       asm volatile("mov %9, %%r8\n\t"
> +                    "mov %10, %%r9\n\t"
> +                    "movb $1, %11\n\t"
> +                    "rep; vmmcall\n\t"
> +                    "mov %%r8, %3\n\t"
> +                    "mov %%r9, %4\n\t"
> +                    "xchgb %5, %11\n\t"
> +                    : "=3Da" (call->rax_out), "=3Dc" (call->rcx_out), "=
=3Dd" (call->rdx_out),
> +                      "=3Dm" (call->r8_out), "=3Dm" (call->r9_out),
> +                      "+r" (*pending)
> +                    : "a" (call->rax), "c" (call->rcx), "d" (call->rdx),
> +                      "r" (call->r8), "r" (call->r9),
> +                      "m" (call->caa->call_pending)
> +                    : "r8", "r9", "memory");
> +}
> +
> +static int __svsm_msr_protocol(struct svsm_call *call)
> +{
> +       u64 val, resp;
> +       u8 pending;
> +
> +       val =3D sev_es_rd_ghcb_msr();
> +
> +       sev_es_wr_ghcb_msr(GHCB_MSR_VMPL_REQ_LEVEL(0));
> +
> +       pending =3D 0;
> +       issue_svsm_call(call, &pending);
> +
> +       resp =3D sev_es_rd_ghcb_msr();
> +
> +       sev_es_wr_ghcb_msr(val);
> +
> +       if (pending)
> +               return -EINVAL;
> +
> +       if (GHCB_RESP_CODE(resp) !=3D GHCB_MSR_VMPL_RESP)
> +               return -EINVAL;
> +
> +       if (GHCB_MSR_VMPL_RESP_VAL(resp) !=3D 0)
> +               return -EINVAL;
> +
> +       return call->rax_out;
> +}
> +
> +static int __svsm_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *cal=
l)
> +{
> +       struct es_em_ctxt ctxt;
> +       u8 pending;
> +
> +       vc_ghcb_invalidate(ghcb);
> +
> +       /* Fill in protocol and format specifiers */
> +       ghcb->protocol_version =3D ghcb_version;
> +       ghcb->ghcb_usage       =3D GHCB_DEFAULT_USAGE;
> +
> +       ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
> +       ghcb_set_sw_exit_info_1(ghcb, 0);
> +       ghcb_set_sw_exit_info_2(ghcb, 0);
> +
> +       sev_es_wr_ghcb_msr(__pa(ghcb));
> +
> +       pending =3D 0;
> +       issue_svsm_call(call, &pending);
> +
> +       if (pending)
> +               return -EINVAL;
> +
> +       switch (verify_exception_info(ghcb, &ctxt)) {
> +       case ES_OK:
> +               break;
> +       case ES_EXCEPTION:
> +               vc_forward_exception(&ctxt);
> +               fallthrough;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return call->rax_out;
> +}
> +
>  static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
>                                           struct es_em_ctxt *ctxt,
>                                           u64 exit_code, u64 exit_info_1,
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 7066afaa8133..3bd7860fbfe1 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -114,6 +114,8 @@ struct ghcb_state {
>
>  static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>  static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
> +static DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
> +static DEFINE_PER_CPU(u64, svsm_caa_pa);
>
>  /*
>   * SVSM related information:
> @@ -121,6 +123,7 @@ static DEFINE_PER_CPU(struct sev_es_save_area *, sev_=
vmsa);
>   *   non-zero. The VMPL is therefore used to indicate the presence of an=
 SVSM.
>   */
>  static u8 vmpl __ro_after_init;
> +static struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
>  static struct svsm_ca *boot_svsm_caa __ro_after_init;
>  static u64 boot_svsm_caa_pa __ro_after_init;
>
> @@ -138,11 +141,26 @@ struct sev_config {
>                */
>               ghcbs_initialized : 1,
>
> +             /*
> +              * A flag used to indicate when the per-CPU SVSM CA is to b=
e
> +              * used instead of the boot SVSM CA.
> +              *
> +              * For APs, the per-CPU SVSM CA is created as part of the A=
P
> +              * bringup, so this flag can be used globally for the BSP a=
nd APs.
> +              */
> +             cas_initialized   : 1,
> +
>               __reserved        : 62;
>  };
>
>  static struct sev_config sev_cfg __read_mostly;
>
> +static struct svsm_ca *__svsm_get_caa(void)
> +{
> +       return sev_cfg.cas_initialized ? this_cpu_read(svsm_caa)
> +                                      : boot_svsm_caa;
> +}
> +
>  static __always_inline bool on_vc_stack(struct pt_regs *regs)
>  {
>         unsigned long sp =3D regs->sp;
> @@ -560,6 +578,33 @@ static enum es_result vc_ioio_check(struct es_em_ctx=
t *ctxt, u16 port, size_t si
>         return ES_EXCEPTION;
>  }
>
> +static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt=
)
> +{
> +       long error_code =3D ctxt->fi.error_code;
> +       int trapnr =3D ctxt->fi.vector;
> +
> +       ctxt->regs->orig_ax =3D ctxt->fi.error_code;
> +
> +       switch (trapnr) {
> +       case X86_TRAP_GP:
> +               exc_general_protection(ctxt->regs, error_code);
> +               break;
> +       case X86_TRAP_UD:
> +               exc_invalid_op(ctxt->regs);
> +               break;
> +       case X86_TRAP_PF:
> +               write_cr2(ctxt->fi.cr2);
> +               exc_page_fault(ctxt->regs, error_code);
> +               break;
> +       case X86_TRAP_AC:
> +               exc_alignment_check(ctxt->regs, error_code);
> +               break;
> +       default:
> +               pr_emerg("Unsupported exception in #VC instruction emulat=
ion - can't continue\n");
> +               BUG();
> +       }
> +}
> +
>  /* Include code shared with pre-decompression boot stage */
>  #include "sev-shared.c"
>
> @@ -588,6 +633,42 @@ static noinstr void __sev_put_ghcb(struct ghcb_state=
 *state)
>         }
>  }
>
> +static int svsm_protocol(struct svsm_call *call)
> +{
> +       struct ghcb_state state;
> +       unsigned long flags;
> +       struct ghcb *ghcb;
> +       int ret;
> +
> +       /*
> +        * This can be called very early in the boot, use native function=
s in
> +        * order to avoid paravirt issues.
> +        */
> +       flags =3D native_save_fl();
> +       if (flags & X86_EFLAGS_IF)
> +               native_irq_disable();
> +
> +       if (sev_cfg.ghcbs_initialized)
> +               ghcb =3D __sev_get_ghcb(&state);
> +       else if (boot_ghcb)
> +               ghcb =3D boot_ghcb;
> +       else
> +               ghcb =3D NULL;
> +
> +       do {
> +               ret =3D ghcb ? __svsm_ghcb_protocol(ghcb, call)
> +                          : __svsm_msr_protocol(call);
> +       } while (ret =3D=3D SVSM_ERR_BUSY);
> +
> +       if (sev_cfg.ghcbs_initialized)
> +               __sev_put_ghcb(&state);
> +
> +       if (flags & X86_EFLAGS_IF)
> +               native_irq_enable();
> +
> +       return ret;
> +}
> +
>  void noinstr __sev_es_nmi_complete(void)
>  {
>         struct ghcb_state state;
> @@ -1348,6 +1429,18 @@ static void __init alloc_runtime_data(int cpu)
>                 panic("Can't allocate SEV-ES runtime data");
>
>         per_cpu(runtime_data, cpu) =3D data;
> +
> +       if (vmpl) {
> +               struct svsm_ca *caa;
> +
> +               /* Allocate the SVSM CA page if an SVSM is present */
> +               caa =3D memblock_alloc(sizeof(*caa), PAGE_SIZE);
> +               if (!caa)
> +                       panic("Can't allocate SVSM CA page\n");
> +
> +               per_cpu(svsm_caa, cpu) =3D caa;
> +               per_cpu(svsm_caa_pa, cpu) =3D __pa(caa);
> +       }
>  }
>
>  static void __init init_ghcb(int cpu)
> @@ -1397,6 +1490,31 @@ void __init sev_es_init_vc_handling(void)
>                 init_ghcb(cpu);
>         }
>
> +       /* If running under an SVSM, switch to the per-cpu CA */
> +       if (vmpl) {
> +               struct svsm_call call =3D {};
> +               unsigned long flags;
> +               int ret;
> +
> +               local_irq_save(flags);
> +
> +               /*
> +                * SVSM_CORE_REMAP_CA call:
> +                *   RAX =3D 0 (Protocol=3D0, CallID=3D0)
> +                *   RCX =3D New CA GPA
> +                */
> +               call.caa =3D __svsm_get_caa();
> +               call.rax =3D SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
> +               call.rcx =3D this_cpu_read(svsm_caa_pa);
> +               ret =3D svsm_protocol(&call);
> +               if (ret !=3D SVSM_SUCCESS)
> +                       panic("Can't remap the SVSM CA, ret=3D%#x (%d)\n"=
, ret, ret);
> +
> +               sev_cfg.cas_initialized =3D true;
> +
> +               local_irq_restore(flags);
> +       }
> +
>         sev_es_setup_play_dead();
>
>         /* Secondary CPUs use the runtime #VC handler */
> @@ -1818,33 +1936,6 @@ static enum es_result vc_handle_exitcode(struct es=
_em_ctxt *ctxt,
>         return result;
>  }
>
> -static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt=
)
> -{
> -       long error_code =3D ctxt->fi.error_code;
> -       int trapnr =3D ctxt->fi.vector;
> -
> -       ctxt->regs->orig_ax =3D ctxt->fi.error_code;
> -
> -       switch (trapnr) {
> -       case X86_TRAP_GP:
> -               exc_general_protection(ctxt->regs, error_code);
> -               break;
> -       case X86_TRAP_UD:
> -               exc_invalid_op(ctxt->regs);
> -               break;
> -       case X86_TRAP_PF:
> -               write_cr2(ctxt->fi.cr2);
> -               exc_page_fault(ctxt->regs, error_code);
> -               break;
> -       case X86_TRAP_AC:
> -               exc_alignment_check(ctxt->regs, error_code);
> -               break;
> -       default:
> -               pr_emerg("Unsupported exception in #VC instruction emulat=
ion - can't continue\n");
> -               BUG();
> -       }
> -}
> -
>  static __always_inline bool is_vc2_stack(unsigned long sp)
>  {
>         return (sp >=3D __this_cpu_ist_bottom_va(VC2) && sp < __this_cpu_=
ist_top_va(VC2));
> @@ -2094,6 +2185,52 @@ static __init struct cc_blob_sev_info *find_cc_blo=
b(struct boot_params *bp)
>         return cc_info;
>  }
>
> +static __init void setup_svsm(struct cc_blob_sev_info *cc_info)
> +{
> +       struct svsm_call call =3D {};
> +       int ret;
> +       u64 pa;
> +
> +       /*
> +        * Record the SVSM Calling Area address (CAA) if the guest is not
> +        * running at VMPL0. The CA will be used to communicate with the
> +        * SVSM to perform the SVSM services.
> +        */
> +       setup_svsm_ca(cc_info);
> +
> +       /* Nothing to do if not running under an SVSM. */
> +       if (!vmpl)
> +               return;
> +
> +       /*
> +        * It is very early in the boot and the kernel is running identit=
y
> +        * mapped but without having adjusted the pagetables to where the
> +        * kernel was loaded (physbase), so the get the CA address using

the get the -> get the

> +        * RIP-relative addressing.
> +        */
> +       asm volatile ("lea boot_svsm_ca_page(%%rip), %0"
> +                     : "=3Dr" (pa)
> +                     : "p" (&boot_svsm_ca_page));
> +
> +       /*
> +        * Switch over to the boot SVSM CA while the current CA is still
> +        * addressable. There is no GHCB at this point so use the MSR pro=
tocol.
> +        *
> +        * SVSM_CORE_REMAP_CA call:
> +        *   RAX =3D 0 (Protocol=3D0, CallID=3D0)
> +        *   RCX =3D New CA GPA
> +        */
> +       call.caa =3D __svsm_get_caa();
> +       call.rax =3D SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
> +       call.rcx =3D pa;
> +       ret =3D svsm_protocol(&call);
> +       if (ret !=3D SVSM_SUCCESS)
> +               panic("Can't remap the SVSM CA, ret=3D%#x (%d)\n", ret, r=
et);
> +
> +       boot_svsm_caa =3D (struct svsm_ca *)pa;
> +       boot_svsm_caa_pa =3D pa;
> +}
> +
>  bool __init snp_init(struct boot_params *bp)
>  {
>         struct cc_blob_sev_info *cc_info;
> @@ -2107,12 +2244,7 @@ bool __init snp_init(struct boot_params *bp)
>
>         setup_cpuid_table(cc_info);
>
> -       /*
> -        * Record the SVSM Calling Area address (CAA) if the guest is not
> -        * running at VMPL0. The CA will be used to communicate with the
> -        * SVSM to perform the SVSM services.
> -        */
> -       setup_svsm_ca(cc_info);
> +       setup_svsm(cc_info);
>
>         /*
>          * The CC blob will be used later to access the secrets page. Cac=
he
> @@ -2278,3 +2410,12 @@ static int __init snp_init_platform_device(void)
>         return 0;
>  }
>  device_initcall(snp_init_platform_device);
> +
> +void __init snp_remap_svsm_ca(void)
> +{
> +       if (!vmpl)
> +               return;
> +
> +       /* Update the CAA to a proper kernel address */
> +       boot_svsm_caa =3D &boot_svsm_ca_page;
> +}
> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.=
c
> index 70b91de2e053..8943286f9fdc 100644
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -2,7 +2,7 @@
>  /*
>   * AMD Memory Encryption Support
>   *
> - * Copyright (C) 2016 Advanced Micro Devices, Inc.
> + * Copyright (C) 2016-2024 Advanced Micro Devices, Inc.
>   *
>   * Author: Tom Lendacky <thomas.lendacky@amd.com>
>   */
> @@ -492,6 +492,12 @@ void __init sme_early_init(void)
>          */
>         if (sev_status & MSR_AMD64_SEV_ENABLED)
>                 ia32_disable();
> +
> +       /*
> +        * Switch the SVSM CA mapping (if active) from identity mapped to
> +        * kernel mapped.
> +        */
> +       snp_remap_svsm_ca();
>  }
>
>  void __init mem_encrypt_free_decrypted_mem(void)
> --
> 2.42.0
>
>


--=20
-Dionna Glaze, PhD (she/her)

