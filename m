Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54E3797DE9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjIGV01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjIGV00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:26:26 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73F9B4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:26:21 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387KXi63011851;
        Thu, 7 Sep 2023 21:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=Gw2Iox6OnwCegnV7a8roAHvWg68M10HO+zn9hkvI+zM=;
 b=L9+lFd504catNEZT1L8TBrMi+5fi4w60Eu3mdIVtQi2lRwCJlUzCz6PSpgDRTzanNaO3
 q3EhxViMHOl71PXo5zbymYxOl6gb7fQMyx/G+gkDsi1FZ0FoMNmPBmjhWcCaX6NFlR5j
 HnA5Hw6eAifB386dSnmptHZ/mtoAi1tQTJsC1C4ffBKWz1egtdobhEYqXjLmSI57JabH
 TvMqVHr+YVXyG9wiNxBgoA2y6r9EHeEFIEHhmrRrcpdrZZbmVmGlxQB9YjaZy3e/Lgs2
 YJhpssqTtE1T0WlKLRpO1ttt/U+avqjvDlODwLkYEa1yFsX+SPpRsZ+0Uxk3lmh8nqYH JQ== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3sy5wm14n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 21:25:39 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id C60FD805E48;
        Thu,  7 Sep 2023 21:25:38 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id C4B3680CE74;
        Thu,  7 Sep 2023 21:25:36 +0000 (UTC)
Date:   Thu, 7 Sep 2023 16:25:35 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: Use alternate source for socket to node
 data
Message-ID: <ZPo/z0TaWahjgglT@swahl-home.5wahls.com>
References: <20230807141730.1117278-1-steve.wahl@hpe.com>
 <ad1ff365-4160-87b9-4199-ace5ff1250e1@intel.com>
 <ZPI1IP38l/X7K/k9@swahl-home.5wahls.com>
 <ZPdC2OxhPznQuYk8@swahl-home.5wahls.com>
 <29cd0ee1-c638-9d8e-8a1c-8c2aa2e167e7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29cd0ee1-c638-9d8e-8a1c-8c2aa2e167e7@intel.com>
X-Proofpoint-ORIG-GUID: v3YLW1u11QWC_ZPq3ElKlYnkG3l9DC3U
X-Proofpoint-GUID: v3YLW1u11QWC_ZPq3ElKlYnkG3l9DC3U
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=650 suspectscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 01:57:16PM -0700, Dave Hansen wrote:
> On 9/5/23 08:01, Steve Wahl wrote:
> > On Fri, Sep 01, 2023 at 02:01:52PM -0500, Steve Wahl wrote:
> >> On Fri, Sep 01, 2023 at 10:18:20AM -0700, Dave Hansen wrote:
> >>> On 8/7/23 07:17, Steve Wahl wrote:
> >>>> When nr_cpus is set to a smaller number than actually present, the
> >>>> cpu_to_node() mapping information for unused CPUs is not available to
> >>>> build_socket_tables().  This results in an incomplete table and will
> >>>> later cause use of a -1 value for some array indexing, and eventual
> >>>> kernel page faults.
> >>>>
> >>>> Switch to using the __apicid_to_node array, which still contains all
> >>>> the information mapping apicids to nodes, even for CPUs disabled with
> >>>> a reduced nr_cpus setting.
> >>> Before, the lookup went:
> >>>
> >>> 	CPU => APICID => SOCKET
> >>>
> >>> But when the CPU wasn't present, there wasn't a way to start this lookup.
> >>>
> >>> So, instead of looping over all CPUs, looking up their APICIDs and
> >>> mapping those to sockets, just take CPUs out of the equation entirely.
> >>>
> >>> Loop over all APICIDs which are mapped to a valid NUMA node.  Then just
> >>> extract the socket-id from the APICID.
> >>>
> >>> Right?
> >>>
> >>> That seems sane enough.  It's also way less code than the previous approach.
> >> Yes.  That's it precisely.  And, yes, way less code.
> > Are you willling to give a "Reviewed-by:"?
> 
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Does this need a stable@ tag when it gets applied?

I hadn't thought about that.  I think it meets the requirements in
stable-kernel-rules.rst.  And it looks like it should apply without
conflicts or prerequisites.  So it probably should.  Is there a way to
add a cc:stable tag at this point?

Thank you, 

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
