Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20878790251
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 21:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350664AbjIATCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 15:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjIATCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 15:02:34 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBAFE56
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 12:02:29 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381GVtp1002618;
        Fri, 1 Sep 2023 19:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=IdsB7OuIkvtBeXdifb1Z6gwmMcYDxDAjBAOqQ9blRvI=;
 b=gsxeJY6QGaBpNN3HCobErXbTdw81DzmVAAMl35bEyDAZMrDsW5DBeUMPOP0W71iiSsSf
 UPOoXbuaDIMDIG4Pq++hpPBlbuC4MP+ZDrH9fG7duuPkRaq1PZVa0OyL+ICOTtrgj8aa
 MC8sPl8+yLOdVgWerawJ86KO6Un4S8U7IMdjjQuqy5P380zDSWNIUvmlyljxcV2r8OUl
 K6GQdFMfXBGmhJLwoj+gEOChA16Eqv+JpSwx+nWpgFmb4W7kgzrwIA8ijOTnd60qRWTR
 pz58TK3YGtOK0jLKMTYLJo6L0VPnB8XCWSgMuDBMlCuzMlG/khcO2EAjfgdo+rSjACpu hg== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3su8pw6jxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 19:01:58 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 6AA29D2A3;
        Fri,  1 Sep 2023 19:01:56 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 6038180E4CD;
        Fri,  1 Sep 2023 19:01:54 +0000 (UTC)
Date:   Fri, 1 Sep 2023 14:01:52 -0500
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
Message-ID: <ZPI1IP38l/X7K/k9@swahl-home.5wahls.com>
References: <20230807141730.1117278-1-steve.wahl@hpe.com>
 <ad1ff365-4160-87b9-4199-ace5ff1250e1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad1ff365-4160-87b9-4199-ace5ff1250e1@intel.com>
X-Proofpoint-GUID: Y4Vp4BflyxXDtC1_PEki908IseCRjnx7
X-Proofpoint-ORIG-GUID: Y4Vp4BflyxXDtC1_PEki908IseCRjnx7
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_16,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=562 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 10:18:20AM -0700, Dave Hansen wrote:
> On 8/7/23 07:17, Steve Wahl wrote:
> > When nr_cpus is set to a smaller number than actually present, the
> > cpu_to_node() mapping information for unused CPUs is not available to
> > build_socket_tables().  This results in an incomplete table and will
> > later cause use of a -1 value for some array indexing, and eventual
> > kernel page faults.
> > 
> > Switch to using the __apicid_to_node array, which still contains all
> > the information mapping apicids to nodes, even for CPUs disabled with
> > a reduced nr_cpus setting.
> 
> Before, the lookup went:
> 
> 	CPU => APICID => SOCKET
> 
> But when the CPU wasn't present, there wasn't a way to start this lookup.
> 
> So, instead of looping over all CPUs, looking up their APICIDs and
> mapping those to sockets, just take CPUs out of the equation entirely.
> 
> Loop over all APICIDs which are mapped to a valid NUMA node.  Then just
> extract the socket-id from the APICID.
> 
> Right?
> 
> That seems sane enough.  It's also way less code than the previous approach.

Yes.  That's it precisely.  And, yes, way less code.

Thanks.

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
