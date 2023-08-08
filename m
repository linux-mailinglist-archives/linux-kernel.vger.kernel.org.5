Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5890774BE0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjHHU67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbjHHUme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:42:34 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FCB1258E;
        Tue,  8 Aug 2023 13:16:02 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DSu0T015121;
        Tue, 8 Aug 2023 20:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=9vJT8bKhEAnOfhS+ZgqFuvvCuPXRd+QjwmyH8Jc1q3g=;
 b=n7mYzI93w3IbvBYaqPT9utujnGzVbDQiEuAaCcow6nI2dWHOKFjDaoNR6MRlVAtr7D5Y
 +LaGUV0DIIWLZM7A1sFtzpxNG8meumV3fOheO4ubsuNI8GLfUXBlSOAGsljLULPdMtWq
 MTX4abNXnYkghRTncpnoXai7ivzP0hw/4UU0O0x9Nlsda9DX+gW4ZgbzVIJf32FNJxu+
 9y/gGg8nAX8ODih8a5vjlclRAhAUf7tuko/elstIxVxmrMaxLp24XWYCOhfy9HJjjYpQ
 0pw/yuL9yYa57a9IZfFffwgS1L+c7kAPh0sIixgJFgrmnGInBQfRIwTmgdmQt2Nf9KKq xQ== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3sbpmfucm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 20:14:55 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id CEFBDD2E4;
        Tue,  8 Aug 2023 20:14:53 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 67AF4810631;
        Tue,  8 Aug 2023 20:14:51 +0000 (UTC)
Date:   Tue, 8 Aug 2023 15:14:49 -0500
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
Subject: Re: [patch v2 15/38] x86/apic: Use u32 for phys_pkg_id()
Message-ID: <ZNKiKPHhcyHxlXnf@swahl-home.5wahls.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.507111034@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728120930.507111034@linutronix.de>
X-Proofpoint-GUID: ySsGeZcIcooai50K8DVW75TnHWC7cPWo
X-Proofpoint-ORIG-GUID: ySsGeZcIcooai50K8DVW75TnHWC7cPWo
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_18,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On Fri, Jul 28, 2023 at 02:13:01PM +0200, Thomas Gleixner wrote:
> APIC IDs are used with random data types u16, u32, int, unsigned int,
> unsigned long.
> 
> Make it all consistently use u32 because that reflects the hardware
> register width even if that callback going to be removed soonish.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/apic.h          |    2 +-
>  arch/x86/kernel/apic/apic_flat_64.c  |    2 +-
>  arch/x86/kernel/apic/apic_noop.c     |    2 +-
>  arch/x86/kernel/apic/apic_numachip.c |    2 +-
>  arch/x86/kernel/apic/bigsmp_32.c     |    2 +-
>  arch/x86/kernel/apic/local.h         |    2 +-
>  arch/x86/kernel/apic/probe_32.c      |    2 +-
>  arch/x86/kernel/apic/x2apic_phys.c   |    2 +-
>  arch/x86/kernel/apic/x2apic_uv_x.c   |    2 +-
>  arch/x86/kernel/vsmp_64.c            |    2 +-
>  arch/x86/xen/apic.c                  |    2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)
> 
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -296,7 +296,7 @@ struct apic {
>  	void	(*init_apic_ldr)(void);
>  	void	(*ioapic_phys_id_map)(physid_mask_t *phys_map, physid_mask_t *retmap);
>  	u32	(*cpu_present_to_apicid)(int mps_cpu);
> -	int	(*phys_pkg_id)(int cpuid_apic, int index_msb);
> +	u32	(*phys_pkg_id)(u32 cpuid_apic, int index_msb);
>  
>  	u32	(*get_apic_id)(unsigned long x);
>  	u32	(*set_apic_id)(unsigned int id);
> --- a/arch/x86/kernel/apic/apic_flat_64.c
> +++ b/arch/x86/kernel/apic/apic_flat_64.c
> @@ -66,7 +66,7 @@ static u32 set_apic_id(unsigned int id)
>  	return (id & 0xFF) << 24;
>  }
>  
> -static int flat_phys_pkg_id(int initial_apic_id, int index_msb)
> +static u32 flat_phys_pkg_id(u32 initial_apic_id, int index_msb)
>  {
>  	return initial_apic_id >> index_msb;
>  }
> --- a/arch/x86/kernel/apic/apic_noop.c
> +++ b/arch/x86/kernel/apic/apic_noop.c
> @@ -29,7 +29,7 @@ static void noop_send_IPI_self(int vecto
>  static void noop_apic_icr_write(u32 low, u32 id) { }
>  static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip) { return -1; }
>  static u64 noop_apic_icr_read(void) { return 0; }
> -static int noop_phys_pkg_id(int cpuid_apic, int index_msb) { return 0; }
> +static u32 noop_phys_pkg_id(u32 cpuid_apic, int index_msb) { return 0; }
>  static unsigned int noop_get_apic_id(unsigned long x) { return 0; }
>  static void noop_apic_eoi(void) { }
>  
> --- a/arch/x86/kernel/apic/apic_numachip.c
> +++ b/arch/x86/kernel/apic/apic_numachip.c
> @@ -56,7 +56,7 @@ static u32 numachip2_set_apic_id(unsigne
>  	return id << 24;
>  }
>  
> -static int numachip_phys_pkg_id(int initial_apic_id, int index_msb)
> +static u32 numachip_phys_pkg_id(u32 initial_apic_id, int index_msb)
>  {
>  	return initial_apic_id >> index_msb;
>  }
> --- a/arch/x86/kernel/apic/bigsmp_32.c
> +++ b/arch/x86/kernel/apic/bigsmp_32.c
> @@ -29,7 +29,7 @@ static void bigsmp_ioapic_phys_id_map(ph
>  	physids_promote(0xFFL, retmap);
>  }
>  
> -static int bigsmp_phys_pkg_id(int cpuid_apic, int index_msb)
> +static u32 bigsmp_phys_pkg_id(u32 cpuid_apic, int index_msb)
>  {
>  	return cpuid_apic >> index_msb;
>  }
> --- a/arch/x86/kernel/apic/local.h
> +++ b/arch/x86/kernel/apic/local.h
> @@ -17,7 +17,7 @@
>  void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
>  unsigned int x2apic_get_apic_id(unsigned long id);
>  u32 x2apic_set_apic_id(unsigned int id);
> -int x2apic_phys_pkg_id(int initial_apicid, int index_msb);
> +u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb);
>  
>  void x2apic_send_IPI_all(int vector);
>  void x2apic_send_IPI_allbutself(int vector);
> --- a/arch/x86/kernel/apic/probe_32.c
> +++ b/arch/x86/kernel/apic/probe_32.c
> @@ -18,7 +18,7 @@
>  
>  #include "local.h"
>  
> -static int default_phys_pkg_id(int cpuid_apic, int index_msb)
> +static u32 default_phys_pkg_id(u32 cpuid_apic, int index_msb)
>  {
>  	return cpuid_apic >> index_msb;
>  }
> --- a/arch/x86/kernel/apic/x2apic_phys.c
> +++ b/arch/x86/kernel/apic/x2apic_phys.c
> @@ -134,7 +134,7 @@ u32 x2apic_set_apic_id(unsigned int id)
>  	return id;
>  }
>  
> -int x2apic_phys_pkg_id(int initial_apicid, int index_msb)
> +u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb)
>  {
>  	return initial_apicid >> index_msb;
>  }
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -790,7 +790,7 @@ static unsigned int uv_read_apic_id(void
>  	return x2apic_get_apic_id(apic_read(APIC_ID));
>  }
>  
> -static int uv_phys_pkg_id(int initial_apicid, int index_msb)
> +static u32 uv_phys_pkg_id(u32 initial_apicid, int index_msb)
>  {
>  	return uv_read_apic_id() >> index_msb;
>  }
> --- a/arch/x86/kernel/vsmp_64.c
> +++ b/arch/x86/kernel/vsmp_64.c
> @@ -127,7 +127,7 @@ static void __init vsmp_cap_cpus(void)
>  #endif
>  }
>  
> -static int apicid_phys_pkg_id(int initial_apic_id, int index_msb)
> +static u32 apicid_phys_pkg_id(u32 initial_apic_id, int index_msb)
>  {
>  	return read_apic_id() >> index_msb;
>  }
> --- a/arch/x86/xen/apic.c
> +++ b/arch/x86/xen/apic.c
> @@ -110,7 +110,7 @@ static int xen_madt_oem_check(char *oem_
>  	return xen_pv_domain();
>  }
>  
> -static int xen_phys_pkg_id(int initial_apic_id, int index_msb)
> +static u32 xen_phys_pkg_id(u32 initial_apic_id, int index_msb)
>  {
>  	return initial_apic_id >> index_msb;
>  }
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
