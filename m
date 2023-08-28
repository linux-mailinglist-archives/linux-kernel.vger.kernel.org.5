Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA13A78BA34
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjH1VX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjH1VXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:23:34 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61A4E1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:23:29 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SEW6u9030599;
        Mon, 28 Aug 2023 21:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=RE5lJIOiz6aK1DwWwez3sfaKDAm6m/N2HPoBtVSVfr0=;
 b=b+eeY/EEh4GXupcn0cHjOtZcl2gMydLeaF/mTOm6ozHKEWC0oj+aCpHNNZJrz/03hdAn
 o6DP7O4lxrvH3TlTRSe7VG+YpwVcHZHIzm5oOA4NrbtoBBXWqloxOBqYqRoKigpNdR+v
 LpOjoJaf8WkKFO8ZTLpSH0qXKq9NiUEQZ7SGJQgAUG4dMzI8bDPv95i2gDYFWgWui88R
 GHhlGFEyTjS+XeGLdcnzl/Orpx7ZrLsiIjzH8ABvI6g27JFVFq6vMyfrNGwyB8vakyne
 66C3S3fz5HSwS8tQ24cnowNkDziDL0A6ZOAueKWJGP085F4TNMrynvuqg5a3EpqP/iFF Bg== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3srrevp9d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 21:23:00 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id D8A4F801734;
        Mon, 28 Aug 2023 21:22:59 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 448F98048E5;
        Mon, 28 Aug 2023 21:22:58 +0000 (UTC)
Date:   Mon, 28 Aug 2023 16:22:56 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: Use alternate source for socket to node
 data
Message-ID: <ZO0QMNcm0+V4eV34@swahl-home.5wahls.com>
References: <20230807141730.1117278-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807141730.1117278-1-steve.wahl@hpe.com>
X-Proofpoint-ORIG-GUID: 5sXb24AibLI9ZFY9j1VvxsG9LH4X98cG
X-Proofpoint-GUID: 5sXb24AibLI9ZFY9j1VvxsG9LH4X98cG
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 clxscore=1011 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280184
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 09:17:30AM -0500, Steve Wahl wrote:
> When nr_cpus is set to a smaller number than actually present, the
> cpu_to_node() mapping information for unused CPUs is not available to
> build_socket_tables().  This results in an incomplete table and will
> later cause use of a -1 value for some array indexing, and eventual
> kernel page faults.
> 
> Switch to using the __apicid_to_node array, which still contains all
> the information mapping apicids to nodes, even for CPUs disabled with
> a reduced nr_cpus setting.
> 
> Fixes: 8a50c5851927 ("x86/platform/uv: UV support for sub-NUMA clustering")
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>  arch/x86/kernel/apic/x2apic_uv_x.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> This is essentially version 2 of "[PATCH] x86/platform/uv: Abort UV
> initialization when reduced nr_cpus requires it".  However, the title
> was no longer accurate, aborting UV initialization is no longer needed.
> 
> Previous discussion can be found here:
> https://lore.kernel.org/lkml/20230711202618.85562-1-steve.wahl@hpe.com/
> 
> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
> index d9384d5b4b8e..35acc95c6dd5 100644
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -1571,7 +1571,7 @@ static void __init build_socket_tables(void)
>  {
>  	struct uv_gam_range_entry *gre = uv_gre_table;
>  	int nums, numn, nump;
> -	int cpu, i, lnid;
> +	int i, lnid, apicid;
>  	int minsock = _min_socket;
>  	int maxsock = _max_socket;
>  	int minpnode = _min_pnode;
> @@ -1622,15 +1622,14 @@ static void __init build_socket_tables(void)
>  
>  	/* Set socket -> node values: */
>  	lnid = NUMA_NO_NODE;
> -	for_each_possible_cpu(cpu) {
> -		int nid = cpu_to_node(cpu);
> -		int apicid, sockid;
> +	for (apicid = 0; apicid < ARRAY_SIZE(__apicid_to_node); apicid++) {
> +		int nid = __apicid_to_node[apicid];
> +		int sockid;
>  
> -		if (lnid == nid)
> +		if ((nid == NUMA_NO_NODE) || (lnid == nid))
>  			continue;
>  		lnid = nid;
>  
> -		apicid = per_cpu(x86_cpu_to_apicid, cpu);
>  		sockid = apicid >> uv_cpuid.socketid_shift;
>  
>  		if (_socket_to_node[sockid - minsock] == SOCK_EMPTY)
> -- 
> 2.26.2
> 

Gentle ping on this patch?  Thanks.

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
