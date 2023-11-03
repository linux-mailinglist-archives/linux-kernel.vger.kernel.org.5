Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414517E0633
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344108AbjKCQPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjKCQPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:15:05 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998F2CA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 09:14:59 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3Co0k3024237;
        Fri, 3 Nov 2023 16:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=IL6ToELt3t30MpJlB2bhYklb1LAzX/W/HQmGYkn6Hy0=;
 b=B2YueJXmRMyzELMqpatT5lFGkOUrwe2AdZ14qil+SkEA+phwyj2PgrxUL+I70e9+yeZX
 TbMiCipIa+5VEZ4FCC/QevgN7t/lEnrzXuoNU4sNyBmyY7SLTaqXUuvw+qxDAYwSAuH7
 OG86k9HlC/pWfgsflpTOedKgprJ43hFkrmUJ2GfrQn9riVU8aCCdYhFNbDfjnbdb/hVR
 4i/ECB/5BRNA+Mg9059SSa5eZJ7k3+lwdojnoeCg8zeYK0UKcyWJSX4WUh4/ZjFkXxs1
 v/82FtTYH5m3Bno7jfVKpiSjby/Yqek6YKfYYop7K6XSPbedGculSA1HOSiDF2FGAk4v Jg== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3u5179tcr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 16:14:00 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 1401D131BE;
        Fri,  3 Nov 2023 16:13:57 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id C7C8E80B55B;
        Fri,  3 Nov 2023 16:13:55 +0000 (UTC)
Date:   Fri, 3 Nov 2023 11:13:53 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm/ident_map: Use gbpages only where full GB page
 should be mapped.
Message-ID: <ZUUcQexwj90u+Mll@swahl-home.5wahls.com>
References: <20231031195049.2075561-1-steve.wahl@hpe.com>
 <eae782dc-17da-4d2b-9840-f2b027d5b192@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae782dc-17da-4d2b-9840-f2b027d5b192@intel.com>
X-Proofpoint-GUID: 8a4oQ7vindXDFFIgR3tCxPS0BECIv83-
X-Proofpoint-ORIG-GUID: 8a4oQ7vindXDFFIgR3tCxPS0BECIv83-
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1011 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030137
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

Thank you for taking the time to review my patch.  (More below.)

On Thu, Nov 02, 2023 at 09:02:44AM -0700, Dave Hansen wrote:
> On 10/31/23 12:50, Steve Wahl wrote:
> > Instead of using gbpages for all memory regions, use them only when
> > map creation requests include the full GB page of space; descend to
> > using smaller 2M pages when only portions of a GB page are requested.
> ...
> 
> The logic here is sound: we obviously don't want systems rebooting
> because speculation went wonky.
> 
> > diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
> > index 968d7005f4a7..b63a1ffcfe9f 100644
> > --- a/arch/x86/mm/ident_map.c
> > +++ b/arch/x86/mm/ident_map.c
> > @@ -31,18 +31,26 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
> >  		if (next > end)
> >  			next = end;
> >  
> > -		if (info->direct_gbpages) {
> > +		/*
> > +		 * if gbpages allowed, this entry not yet present, and
> > +		 * the full gbpage range is requested (both ends are
> > +		 * correctly aligned), create a gbpage.
> > +		 */
> > +		if (info->direct_gbpages
> > +		    && !pud_present(*pud)
> > +		    && !(addr & ~PUD_MASK)
> > +		    && !(next & ~PUD_MASK)) {
> 
> This is a _bit_ too subtle for my taste.
> 
> Let's say someone asks for mapping of 2MB@5G, then later asks for 1G@5G.
>  The first call in here will do the 2MB mapping with small (pud)
> entries.  The second call will see the new pud_present() check and
> *also* skip large pud creation.
> 
> That's a regression.  It might not matter _much_, but it's a place where
> the old code creates large PUDs and the new code creates small ones.
> It's the kind of behavior change that at least needs to be noted in the
> changelog.

I will add a note that requests that create a small page mapping will
have that small mapping persist in this range, even if subsequent
requests enlarge the mapped area to cover the whole 1G segment.

> Off the top of my head, I can't think of why we'd get overlapping
> requests in here, though.  Did you think through that case?  Is it common?

Yes, I had thought about the overlaps. Of the choices I had here,
continuing to use the already allocated PMD page and fill the map in
with 2M pages seemed the best option.

Existing usage (the kernel decompression stub and kexec) start with
huge tracts of memory and then add smaller pieces that may or may not
already reside in the map created so far.  (See, for example, the
comment around line 231 in arch/x86/kernel/machine_kexec_64.c.)

My early private versions with printks reflected this, but this was
limited to testing on UV systems.

In short, with current usage overlap is expected, but it would be rare
for small pieces that requrie PMD mapping to be followed by large
pieces that include the whole PUD level region.

> >  			pud_t pudval;
> >  
> > -			if (pud_present(*pud))
> > -				continue;
> > -
> > -			addr &= PUD_MASK;
> >  			pudval = __pud((addr - info->offset) | info->page_flag);
> >  			set_pud(pud, pudval);
> >  			continue;
> >  		}
> >  
> > +		/* if this is already a gbpage, this portion is already mapped */
> > +		if (pud_large(*pud))
> > +			continue;
> 
> I'd probably move this check up to above the large PUD creation code.
> It would make it more obvious that any PUD that's encountered down below
> is a small PUD.

That makes sense.  I will change this.

> >  		if (pud_present(*pud)) {
> >  			pmd = pmd_offset(pud, 0);
> >  			ident_pmd_init(info, pmd, addr, next);
> 
> That would end up looking something like this:
> 
> 	bool do_gbpages = true;
> 	...
> 
> 	// Is the whole range already mapped?
> 	if (pud_large(*pud))
> 		continue;
> 
> 	/* PUD is either empty or small */
> 
> 	// GB pages allowed?
> 	do_gbpages &= info->direct_gbpages;
> 	// Addresses aligned for GB pages?
> 	do_gbpages &= ~(addr & ~PUD_MASK);
> 	do_gbpages &= ~(next & ~PUD_MASK);
> 	// Check for existing mapping using a small PUD
> 	do_gbpages &= !pud_present(*pud);
> 
> 	if (do_gbpages) {
> 		set_pud(pud, __pud((addr - info->offset) |
> 					info->page_flag));
> 		continue
> 	}

I tried coding it up with the bool instead of the single if statement,
and to me it did not look as easy to read and understand as the single
if statement version.  So unless you firmly object, I'm leaving it the
original way, but improving the comment above the if statement to have
one-for-one explanations for each condition.

Thanks,

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
