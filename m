Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFA8774CC4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbjHHVQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbjHHVQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:16:29 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD94212587;
        Tue,  8 Aug 2023 13:15:53 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378HsB2N004465;
        Tue, 8 Aug 2023 20:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=uJ7RzQT3zXD+UEmtt+D+6A5jLOijAAO8k6MEF+PEAxs=;
 b=Lgi+MEnUMxSTHZ4SDD++JNJMFz9GccbLG5s2LvkccmX54/FEojk8ivUUhdKNgwDPXxn2
 y6GtlIIc3mVs1WsrAaCnet3lAEBtsbh6YNjudoDPaqXDgE2nnl0Nz5OtDCL9AZOMukq4
 1gIOtiYWegW1Be1aXPfeLGAjpPu27ERwf3pPcbnO9jADcHv0ppdfDuc7zADiXcHSbYmt
 TegKxIAn6pkwYsTiMUgO1pW40DSDuNkr1hLlH0zh2yCDTkBTp62uXmE2S23FAye4e59R
 1L+GfuUlU28JzTbiF34dO4qKA1Ro6zz136hLJ5M4m1gN+sQ89A2tcWt+dDrA5hAnMeDG Xg== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3sbtgvh1g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 20:15:14 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 91050D2D3;
        Tue,  8 Aug 2023 20:15:13 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 71002810615;
        Tue,  8 Aug 2023 20:15:11 +0000 (UTC)
Date:   Tue, 8 Aug 2023 15:15:09 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [patch v2 16/38] x86/apic: Use u32 for [gs]et_apic_id()
Message-ID: <ZNKiTR5eytSLFN28@swahl-home.5wahls.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.562193563@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728120930.562193563@linutronix.de>
X-Proofpoint-GUID: k0Ciz9iHQQC9SP3ewSrVEYKpz_fV04Zi
X-Proofpoint-ORIG-GUID: k0Ciz9iHQQC9SP3ewSrVEYKpz_fV04Zi
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_18,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

On Fri, Jul 28, 2023 at 02:13:02PM +0200, Thomas Gleixner wrote:
> APIC IDs are used with random data types u16, u32, int, unsigned int,
> unsigned long.
> 
> Make it all consistently use u32 because that reflects the hardware
> register width.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/apic.h          |   14 ++------------
>  arch/x86/kernel/apic/apic_flat_64.c  |    4 ++--
>  arch/x86/kernel/apic/apic_noop.c     |    2 +-
>  arch/x86/kernel/apic/apic_numachip.c |    8 ++++----
>  arch/x86/kernel/apic/bigsmp_32.c     |    2 +-
>  arch/x86/kernel/apic/local.h         |    4 ++--
>  arch/x86/kernel/apic/probe_32.c      |   10 ++++++++++
>  arch/x86/kernel/apic/x2apic_phys.c   |    4 ++--
>  arch/x86/kernel/apic/x2apic_uv_x.c   |    2 +-
>  arch/x86/xen/apic.c                  |    4 ++--
>  10 files changed, 27 insertions(+), 27 deletions(-)
> 
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -298,8 +298,8 @@ struct apic {
>  	u32	(*cpu_present_to_apicid)(int mps_cpu);
>  	u32	(*phys_pkg_id)(u32 cpuid_apic, int index_msb);
>  
> -	u32	(*get_apic_id)(unsigned long x);
> -	u32	(*set_apic_id)(unsigned int id);
> +	u32	(*get_apic_id)(u32 id);
> +	u32	(*set_apic_id)(u32 apicid);
>  
>  	/* wakeup_secondary_cpu */
>  	int	(*wakeup_secondary_cpu)(int apicid, unsigned long start_eip);
> @@ -493,16 +493,6 @@ static inline bool lapic_vector_set_in_i
>  	return !!(irr & (1U << (vector % 32)));
>  }
>  
> -static inline unsigned default_get_apic_id(unsigned long x)
> -{
> -	unsigned int ver = GET_APIC_VERSION(apic_read(APIC_LVR));
> -
> -	if (APIC_XAPIC(ver) || boot_cpu_has(X86_FEATURE_EXTD_APICID))
> -		return (x >> 24) & 0xFF;
> -	else
> -		return (x >> 24) & 0x0F;
> -}
> -
>  /*
>   * Warm reset vector position:
>   */
> --- a/arch/x86/kernel/apic/apic_flat_64.c
> +++ b/arch/x86/kernel/apic/apic_flat_64.c
> @@ -56,12 +56,12 @@ flat_send_IPI_mask_allbutself(const stru
>  	_flat_send_IPI_mask(mask, vector);
>  }
>  
> -static unsigned int flat_get_apic_id(unsigned long x)
> +static u32 flat_get_apic_id(u32 x)
>  {
>  	return (x >> 24) & 0xFF;
>  }
>  
> -static u32 set_apic_id(unsigned int id)
> +static u32 set_apic_id(u32 id)
>  {
>  	return (id & 0xFF) << 24;
>  }
> --- a/arch/x86/kernel/apic/apic_noop.c
> +++ b/arch/x86/kernel/apic/apic_noop.c
> @@ -30,7 +30,7 @@ static void noop_apic_icr_write(u32 low,
>  static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip) { return -1; }
>  static u64 noop_apic_icr_read(void) { return 0; }
>  static u32 noop_phys_pkg_id(u32 cpuid_apic, int index_msb) { return 0; }
> -static unsigned int noop_get_apic_id(unsigned long x) { return 0; }
> +static u32 noop_get_apic_id(u32 apicid) { return 0; }
>  static void noop_apic_eoi(void) { }
>  
>  static u32 noop_apic_read(u32 reg)
> --- a/arch/x86/kernel/apic/apic_numachip.c
> +++ b/arch/x86/kernel/apic/apic_numachip.c
> @@ -25,7 +25,7 @@ static const struct apic apic_numachip1;
>  static const struct apic apic_numachip2;
>  static void (*numachip_apic_icr_write)(int apicid, unsigned int val) __read_mostly;
>  
> -static unsigned int numachip1_get_apic_id(unsigned long x)
> +static u32 numachip1_get_apic_id(u32 x)
>  {
>  	unsigned long value;
>  	unsigned int id = (x >> 24) & 0xff;
> @@ -38,12 +38,12 @@ static unsigned int numachip1_get_apic_i
>  	return id;
>  }
>  
> -static u32 numachip1_set_apic_id(unsigned int id)
> +static u32 numachip1_set_apic_id(u32 id)
>  {
>  	return (id & 0xff) << 24;
>  }
>  
> -static unsigned int numachip2_get_apic_id(unsigned long x)
> +static u32 numachip2_get_apic_id(u32 x)
>  {
>  	u64 mcfg;
>  
> @@ -51,7 +51,7 @@ static unsigned int numachip2_get_apic_i
>  	return ((mcfg >> (28 - 8)) & 0xfff00) | (x >> 24);
>  }
>  
> -static u32 numachip2_set_apic_id(unsigned int id)
> +static u32 numachip2_set_apic_id(u32 id)
>  {
>  	return id << 24;
>  }
> --- a/arch/x86/kernel/apic/bigsmp_32.c
> +++ b/arch/x86/kernel/apic/bigsmp_32.c
> @@ -13,7 +13,7 @@
>  
>  #include "local.h"
>  
> -static unsigned bigsmp_get_apic_id(unsigned long x)
> +static u32 bigsmp_get_apic_id(u32 x)
>  {
>  	return (x >> 24) & 0xFF;
>  }
> --- a/arch/x86/kernel/apic/local.h
> +++ b/arch/x86/kernel/apic/local.h
> @@ -15,8 +15,8 @@
>  
>  /* X2APIC */
>  void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
> -unsigned int x2apic_get_apic_id(unsigned long id);
> -u32 x2apic_set_apic_id(unsigned int id);
> +u32 x2apic_get_apic_id(u32 id);
> +u32 x2apic_set_apic_id(u32 id);
>  u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb);
>  
>  void x2apic_send_IPI_all(int vector);
> --- a/arch/x86/kernel/apic/probe_32.c
> +++ b/arch/x86/kernel/apic/probe_32.c
> @@ -23,6 +23,16 @@ static u32 default_phys_pkg_id(u32 cpuid
>  	return cpuid_apic >> index_msb;
>  }
>  
> +static u32 default_get_apic_id(u32 x)
> +{
> +	unsigned int ver = GET_APIC_VERSION(apic_read(APIC_LVR));
> +
> +	if (APIC_XAPIC(ver) || boot_cpu_has(X86_FEATURE_EXTD_APICID))
> +		return (x >> 24) & 0xFF;
> +	else
> +		return (x >> 24) & 0x0F;
> +}
> +
>  /* should be called last. */
>  static int probe_default(void)
>  {
> --- a/arch/x86/kernel/apic/x2apic_phys.c
> +++ b/arch/x86/kernel/apic/x2apic_phys.c
> @@ -124,12 +124,12 @@ static int x2apic_phys_probe(void)
>  	return apic == &apic_x2apic_phys;
>  }
>  
> -unsigned int x2apic_get_apic_id(unsigned long id)
> +u32 x2apic_get_apic_id(u32 id)
>  {
>  	return id;
>  }
>  
> -u32 x2apic_set_apic_id(unsigned int id)
> +u32 x2apic_set_apic_id(u32 id)
>  {
>  	return id;
>  }
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -780,7 +780,7 @@ static void uv_send_IPI_all(int vector)
>  	uv_send_IPI_mask(cpu_online_mask, vector);
>  }
>  
> -static u32 set_apic_id(unsigned int id)
> +static u32 set_apic_id(u32 id)
>  {
>  	return id;
>  }
> --- a/arch/x86/xen/apic.c
> +++ b/arch/x86/xen/apic.c
> @@ -33,13 +33,13 @@ static unsigned int xen_io_apic_read(uns
>  	return 0xfd;
>  }
>  
> -static u32 xen_set_apic_id(unsigned int x)
> +static u32 xen_set_apic_id(u32 x)
>  {
>  	WARN_ON(1);
>  	return x;
>  }
>  
> -static unsigned int xen_get_apic_id(unsigned long x)
> +static u32 xen_get_apic_id(u32 x)
>  {
>  	return ((x)>>24) & 0xFFu;
>  }
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
