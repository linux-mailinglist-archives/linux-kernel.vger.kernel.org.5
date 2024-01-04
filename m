Return-Path: <linux-kernel+bounces-17068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ECA8247D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67AA285832
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E7A28DC1;
	Thu,  4 Jan 2024 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1xGtIhZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF128DAB;
	Thu,  4 Jan 2024 17:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6501DC433C7;
	Thu,  4 Jan 2024 17:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704390782;
	bh=wKYftDd3FW5eeDWnzupfy2i9v4YDDNe798XkVIlpntA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1xGtIhZLKg/DWo5tFxE72e0gxuhkDIKV4oTNFvWvLqyDfrPQlNjK41WMhUYcJ1Hy
	 7l4MiWr16D03U44+WfsgK+XEiKYsL32Ukwtb+j/zownEYSCDtIc4jIudL8FCPlztJa
	 wa3BjGjg6ADD5tLTRzht7v5o/AtHz6wJOmu6cGaHjdJhk2IFea8qY2lPnxJ6cm1Qjh
	 xd0qOT1j7Yhp3oL6StLi286l42ZzdauAuy+Mqtq4fkVcX1zQ/VIPPAK5WbYmULuKja
	 UuqG0mCKG/yDEgIxi9pDNgNiLE0gWveCqOYbIqd2Tk7qom5amXmA6wKNlSJKE3rHuA
	 pKoSbTQBou1NQ==
Date: Thu, 4 Jan 2024 17:52:53 +0000
From: Simon Horman <horms@kernel.org>
To: Yi-De Wu <yi-de.wu@mediatek.com>
Cc: Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
	Ze-Yu Wang <ze-yu.wang@mediatek.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Wihl Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	David Bradil <dbrazdil@google.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Jade Shih <jades.shih@mediatek.com>,
	Ivan Tseng <ivan.tseng@mediatek.com>,
	My Chuang <my.chuang@mediatek.com>,
	Shawn Hsiao <shawn.hsiao@mediatek.com>,
	PeiLun Suei <peilun.suei@mediatek.com>,
	Liju Chen <liju-clr.chen@mediatek.com>,
	Willix Yeh <chi-shen.yeh@mediatek.com>,
	Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: Re: [PATCH v8 08/20] virt: geniezone: Add vcpu support
Message-ID: <20240104175253.GK31813@kernel.org>
References: <20231228105147.13752-1-yi-de.wu@mediatek.com>
 <20231228105147.13752-9-yi-de.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228105147.13752-9-yi-de.wu@mediatek.com>

On Thu, Dec 28, 2023 at 06:51:35PM +0800, Yi-De Wu wrote:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> VMM use this interface to create vcpu instance which is a fd, and this
> fd will be for any vcpu operations, such as setting vcpu registers and
> accepts the most important ioctl GZVM_VCPU_RUN which requests GenieZone
> hypervisor to do context switch to execute VM's vcpu context.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
> Signed-off-by: kevenny hsieh <kevenny.hsieh@mediatek.com>
> Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>

Hi Yi-De Wu,

some minor feedback from my side.

...

> diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
> index 77a58ee085df..bdf277fa248a 100644
> --- a/include/uapi/linux/gzvm.h
> +++ b/include/uapi/linux/gzvm.h
> @@ -25,6 +25,34 @@
>  /* GZVM_CAP_PVM_SET_PROTECTED_VM only sets protected but not load pvmfw */
>  #define GZVM_CAP_PVM_SET_PROTECTED_VM		2
>  
> +/*
> + * Architecture specific registers are to be defined and ORed with
> + * the arch identifier.
> + */
> +#define GZVM_REG_ARCH_ARM64	0x6000000000000000ULL
> +#define GZVM_REG_ARCH_MASK	0xff00000000000000ULL

nit: using GENMASK_ULL and FIELD_PREP seems appropriate here.

> +
> +/*
> + * Reg size = BIT((reg.id & GZVM_REG_SIZE_MASK) >> GZVM_REG_SIZE_SHIFT) bytes
> + */
> +#define GZVM_REG_SIZE_SHIFT	52
> +#define GZVM_REG_SIZE_MASK	0x00f0000000000000ULL
> +
> +#define GZVM_REG_SIZE_U8	0x0000000000000000ULL
> +#define GZVM_REG_SIZE_U16	0x0010000000000000ULL
> +#define GZVM_REG_SIZE_U32	0x0020000000000000ULL
> +#define GZVM_REG_SIZE_U64	0x0030000000000000ULL
> +#define GZVM_REG_SIZE_U128	0x0040000000000000ULL
> +#define GZVM_REG_SIZE_U256	0x0050000000000000ULL
> +#define GZVM_REG_SIZE_U512	0x0060000000000000ULL
> +#define GZVM_REG_SIZE_U1024	0x0070000000000000ULL
> +#define GZVM_REG_SIZE_U2048	0x0080000000000000ULL

And here.

> +
> +/* Register type definitions */
> +#define GZVM_REG_TYPE_SHIFT	16
> +/* Register type: general purpose */
> +#define GZVM_REG_TYPE_GENERAL	(0x10 << GZVM_REG_TYPE_SHIFT)

And using FIELD_PREP seems appropriate here too.

...

> @@ -51,6 +79,11 @@ struct gzvm_memory_region {
>  
>  #define GZVM_SET_MEMORY_REGION     _IOW(GZVM_IOC_MAGIC,  0x40, \
>  					struct gzvm_memory_region)
> +/*
> + * GZVM_CREATE_VCPU receives as a parameter the vcpu slot,
> + * and returns a vcpu fd.
> + */
> +#define GZVM_CREATE_VCPU           _IO(GZVM_IOC_MAGIC,   0x41)
>  
>  /* for GZVM_SET_USER_MEMORY_REGION */
>  struct gzvm_userspace_memory_region {
> @@ -66,6 +99,124 @@ struct gzvm_userspace_memory_region {
>  #define GZVM_SET_USER_MEMORY_REGION _IOW(GZVM_IOC_MAGIC, 0x46, \
>  					 struct gzvm_userspace_memory_region)
>  
> +/*
> + * ioctls for vcpu fds
> + */
> +#define GZVM_RUN                   _IO(GZVM_IOC_MAGIC,   0x80)
> +
> +/* VM exit reason */
> +enum {
> +	GZVM_EXIT_UNKNOWN = 0x92920000,
> +	GZVM_EXIT_MMIO = 0x92920001,
> +	GZVM_EXIT_HYPERCALL = 0x92920002,
> +	GZVM_EXIT_IRQ = 0x92920003,
> +	GZVM_EXIT_EXCEPTION = 0x92920004,
> +	GZVM_EXIT_DEBUG = 0x92920005,
> +	GZVM_EXIT_FAIL_ENTRY = 0x92920006,
> +	GZVM_EXIT_INTERNAL_ERROR = 0x92920007,
> +	GZVM_EXIT_SYSTEM_EVENT = 0x92920008,
> +	GZVM_EXIT_SHUTDOWN = 0x92920009,
> +	GZVM_EXIT_GZ = 0x9292000a,
> +};
> +
> +/**
> + * struct gzvm_vcpu_run: Same purpose as kvm_run, this struct is
> + *			shared between userspace, kernel and
> + *			GenieZone hypervisor
> + * @exit_reason: The reason why gzvm_vcpu_run has stopped running the vCPU
> + * @immediate_exit: Polled when the vcpu is scheduled.
> + *                  If set, immediately returns -EINTR
> + * @padding1: Reserved for future-proof and must be zero filled
> + * @mmio: The nested struct in anonymous union. Handle mmio in host side
> + * @phys_addr: The address guest tries to access
> + * @data: The value to be written (is_write is 1) or
> + *        be filled by user for reads (is_write is 0)
> + * @size: The size of written data.
> + *        Only the first `size` bytes of `data` are handled
> + * @reg_nr: The register number where the data is stored
> + * @is_write: 1 for VM to perform a write or 0 for VM to perform a read
> + * @fail_entry: The nested struct in anonymous union.
> + *              Handle invalid entry address at the first run
> + * @hardware_entry_failure_reason: The reason codes about hardware entry failure
> + * @cpu: The current processor number via smp_processor_id()
> + * @exception: The nested struct in anonymous union.
> + *             Handle exception occurred in VM
> + * @exception: Which exception vector
> + * @error_code: Exception error codes
> + * @hypercall: The nested struct in anonymous union.
> + *             Some hypercalls issued from VM must be handled
> + * @args: The hypercall's arguments
> + * @internal: The nested struct in anonymous union. The errors from hypervisor
> + * @suberror: The errors codes about GZVM_EXIT_INTERNAL_ERROR
> + * @ndata: The number of elements used in data[]
> + * @data: Keep the detailed information about GZVM_EXIT_INTERNAL_ERROR
> + * @system_event: The nested struct in anonymous union.
> + *                VM's PSCI must be handled by host
> + * @type: System event type.
> + *        Ex. GZVM_SYSTEM_EVENT_SHUTDOWN or GZVM_SYSTEM_EVENT_RESET...etc.
> + * @ndata: The number of elements used in data[]
> + * @data: Keep the detailed information about GZVM_EXIT_SYSTEM_EVENT
> + * @padding: Fix it to a reasonable size future-proof for keeping the same
> + *           struct size when adding new variables in the union is needed
> + *
> + * Keep identical layout between the 3 modules
> + */

I am unsure how to address this, but ./scripts/kernel-doc seems confused
about the correlation between the fields documented above and the nested
structure below.

"./scripts/kernel-doc -none" says:

 .../gzvm.h:219: warning: Excess struct member 'phys_addr' description in 'gzvm_vcpu_run'
 .../gzvm.h:219: warning: Excess struct member 'data' description in 'gzvm_vcpu_run'
 .../gzvm.h:219: warning: Excess struct member 'size' description in 'gzvm_vcpu_run'
 .../gzvm.h:219: warning: Excess struct member 'reg_nr' description in 'gzvm_vcpu_run'
 .../gzvm.h:219: warning: Excess struct member 'is_write' description in 'gzvm_vcpu_run'
 .../gzvm.h:219: warning: Excess struct member 'hardware_entry_failure_reason' description in 'gzvm_vcpu_run'
 .../gzvm.h:219: warning: Excess struct member 'cpu' description in 'gzvm_vcpu_run'
 .../gzvm.h:219: warning: Excess struct member 'error_code' description in 'gzvm_vcpu_run'
 .../gzvm.h:219: warning: Excess struct member 'args' description in 'gzvm_vcpu_run'
 .../gzvm.h:219: warning: Excess struct member 'suberror' description in 'gzvm_vcpu_run'
 .../gzvm.h:219: warning: Excess struct member 'ndata' description in 'gzvm_vcpu_run'
 .../gzvm.h:219: warning: Excess struct member 'data' description in 'gzvm_vcpu_run'
 .../gzvm.h:219: warning: Excess struct member 'type' description in 'gzvm_vcpu_run'
 .../gzvm.h:219: warning: Excess struct member 'ndata' description in 'gzvm_vcpu_run'
 .../gzvm.h:219: warning: Excess struct member 'data' description in 'gzvm_vcpu_run'


> +struct gzvm_vcpu_run {
> +	/* to userspace */
> +	__u32 exit_reason;
> +	__u8 immediate_exit;
> +	__u8 padding1[3];
> +	/* union structure of collection of guest exit reason */
> +	union {
> +		/* GZVM_EXIT_MMIO */
> +		struct {
> +			/* from FAR_EL2 */
> +			__u64 phys_addr;
> +			__u8 data[8];
> +			/* from ESR_EL2 as */
> +			__u64 size;
> +			/* from ESR_EL2 */
> +			__u32 reg_nr;
> +			/* from ESR_EL2 */
> +			__u8 is_write;
> +		} mmio;
> +		/* GZVM_EXIT_FAIL_ENTRY */
> +		struct {
> +			__u64 hardware_entry_failure_reason;
> +			__u32 cpu;
> +		} fail_entry;
> +		/* GZVM_EXIT_EXCEPTION */
> +		struct {
> +			__u32 exception;
> +			__u32 error_code;
> +		} exception;
> +		/* GZVM_EXIT_HYPERCALL */
> +		struct {
> +			__u64 args[8];	/* in-out */
> +		} hypercall;
> +		/* GZVM_EXIT_INTERNAL_ERROR */
> +		struct {
> +			__u32 suberror;
> +			__u32 ndata;
> +			__u64 data[16];
> +		} internal;
> +		/* GZVM_EXIT_SYSTEM_EVENT */
> +		struct {
> +#define GZVM_SYSTEM_EVENT_SHUTDOWN       1
> +#define GZVM_SYSTEM_EVENT_RESET          2
> +#define GZVM_SYSTEM_EVENT_CRASH          3
> +#define GZVM_SYSTEM_EVENT_WAKEUP         4
> +#define GZVM_SYSTEM_EVENT_SUSPEND        5
> +#define GZVM_SYSTEM_EVENT_SEV_TERM       6
> +#define GZVM_SYSTEM_EVENT_S2IDLE         7
> +			__u32 type;
> +			__u32 ndata;
> +			__u64 data[16];
> +		} system_event;
> +		char padding[256];
> +	};
> +};

...

