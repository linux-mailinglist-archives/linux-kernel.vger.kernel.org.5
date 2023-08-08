Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB42774C64
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbjHHVIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjHHVIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:08:02 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCB159C5;
        Tue,  8 Aug 2023 13:17:30 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378E2HPr005408;
        Tue, 8 Aug 2023 20:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=c5ibE8njd86Vq/2yaOuQ84ZUe6Q7bmDQ3pDpqWx8tTk=;
 b=cXe+B9GKoox6FYuEoqpmoZ9uUNxiIlPa5x8nVay72hc4BT6DUfVYIxqiz+bLchL47hWr
 M8Uc+An3HDbeBjA/h8tuDQ2qjSYpoesDBC6wGABY/e+kYfMJ1c20/Cz0pAhSE6kSy9i+
 HAKZUtXg5u0OgaSPAYzBp7kXahZ0IbZdXqwr/ZAtKeqtN5vL31/J+xFgoB+gWtgCCOCs
 xe0+gS1zvEw4uMOEEh8ZFgRELXrqg093C7lc4YXa0eH3yLXE0dBrXX9AsZVNfpRdZLBF
 5gBEMDbRzuVmnLXoe0gtagNgpbazg8OvpoAY9qjcM41/dlTh7DFRRY9wALQQfioULdIA oQ== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3sbnyakhwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 20:15:34 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id E5615D2F2;
        Tue,  8 Aug 2023 20:15:33 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id C7FF180DA8C;
        Tue,  8 Aug 2023 20:15:31 +0000 (UTC)
Date:   Tue, 8 Aug 2023 15:15:30 -0500
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
Subject: Re: [patch v2 17/38] x86/apic: Use u32 for
 wakeup_secondary_cpu[_64]()
Message-ID: <ZNKiYsNbPlGOm3bQ@swahl-home.5wahls.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.617454900@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728120930.617454900@linutronix.de>
X-Proofpoint-GUID: I_z8xNk3AAGY6zs3wVhqL0Mv5hq6bREe
X-Proofpoint-ORIG-GUID: I_z8xNk3AAGY6zs3wVhqL0Mv5hq6bREe
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_18,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On Fri, Jul 28, 2023 at 02:13:03PM +0200, Thomas Gleixner wrote:
> APIC IDs are used with random data types u16, u32, int, unsigned int,
> unsigned long.
> 
> Make it all consistently use u32 because that reflects the hardware
> register width.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/hyperv/hv_vtl.c             |    2 +-
>  arch/x86/include/asm/apic.h          |    8 ++++----
>  arch/x86/kernel/acpi/boot.c          |    2 +-
>  arch/x86/kernel/apic/apic_noop.c     |    2 +-
>  arch/x86/kernel/apic/apic_numachip.c |    2 +-
>  arch/x86/kernel/apic/x2apic_uv_x.c   |    2 +-
>  arch/x86/kernel/sev.c                |    2 +-
>  7 files changed, 10 insertions(+), 10 deletions(-)
> 
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -192,7 +192,7 @@ static int hv_vtl_apicid_to_vp_id(u32 ap
>  	return ret;
>  }
>  
> -static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
> +static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
>  {
>  	int vp_id;
>  
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -302,9 +302,9 @@ struct apic {
>  	u32	(*set_apic_id)(u32 apicid);
>  
>  	/* wakeup_secondary_cpu */
> -	int	(*wakeup_secondary_cpu)(int apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
>  	/* wakeup secondary CPU using 64-bit wakeup point */
> -	int	(*wakeup_secondary_cpu_64)(int apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
>  
>  	char	*name;
>  };
> @@ -322,8 +322,8 @@ struct apic_override {
>  	void	(*send_IPI_self)(int vector);
>  	u64	(*icr_read)(void);
>  	void	(*icr_write)(u32 low, u32 high);
> -	int	(*wakeup_secondary_cpu)(int apicid, unsigned long start_eip);
> -	int	(*wakeup_secondary_cpu_64)(int apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
>  };
>  
>  /*
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -358,7 +358,7 @@ acpi_parse_lapic_nmi(union acpi_subtable
>  }
>  
>  #ifdef CONFIG_X86_64
> -static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
> +static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
>  {
>  	/*
>  	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
> --- a/arch/x86/kernel/apic/apic_noop.c
> +++ b/arch/x86/kernel/apic/apic_noop.c
> @@ -27,7 +27,7 @@ static void noop_send_IPI_allbutself(int
>  static void noop_send_IPI_all(int vector) { }
>  static void noop_send_IPI_self(int vector) { }
>  static void noop_apic_icr_write(u32 low, u32 id) { }
> -static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip) { return -1; }
> +static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip) { return -1; }
>  static u64 noop_apic_icr_read(void) { return 0; }
>  static u32 noop_phys_pkg_id(u32 cpuid_apic, int index_msb) { return 0; }
>  static u32 noop_get_apic_id(u32 apicid) { return 0; }
> --- a/arch/x86/kernel/apic/apic_numachip.c
> +++ b/arch/x86/kernel/apic/apic_numachip.c
> @@ -71,7 +71,7 @@ static void numachip2_apic_icr_write(int
>  	numachip2_write32_lcsr(NUMACHIP2_APIC_ICR, (apicid << 12) | val);
>  }
>  
> -static int numachip_wakeup_secondary(int phys_apicid, unsigned long start_rip)
> +static int numachip_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
>  {
>  	numachip_apic_icr_write(phys_apicid, APIC_DM_INIT);
>  	numachip_apic_icr_write(phys_apicid, APIC_DM_STARTUP |
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -702,7 +702,7 @@ static __init void build_uv_gr_table(voi
>  	}
>  }
>  
> -static int uv_wakeup_secondary(int phys_apicid, unsigned long start_rip)
> +static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
>  {
>  	unsigned long val;
>  	int pnode;
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -940,7 +940,7 @@ static void snp_cleanup_vmsa(struct sev_
>  		free_page((unsigned long)vmsa);
>  }
>  
> -static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
> +static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>  {
>  	struct sev_es_save_area *cur_vmsa, *vmsa;
>  	struct ghcb_state state;
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
