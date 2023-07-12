Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E044F751287
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjGLVT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjGLVTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:19:23 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68711CF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:19:20 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CKebAI002374;
        Wed, 12 Jul 2023 21:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=iFIFwJmTbqjX3uTx9x/I+HeKVH3wXDb+FtT3qqp9Yls=;
 b=MX/ZkS/8EfCW3ItgKRxhMATRnyaFoxqtjtPwOwxWzKe/65evJxnjhNgaiNnxivbpjKft
 4oZeBt5ceV2ic4SKOG+Sfyz5DF2jbf+LcyArl/0Lrc9aMdBlFM87JaTUtbTgoGbN4PT1
 BEhADH8fQmAkg+toii3WvyR4lH/sS0HpCnS8ZRuBdaPAKZKmzo4V/8H9BHJ6FWnrrvdV
 LSchxXmtpMWuSAYs68ObEOx9LnPpTZNXGLxuW8q8cwL9tHIr7IlnYfXpCEve5KBPjaa7
 XoTck8bXnH6LX78Yg8XP7eDmq0nE7B555X4Pz0EpS26dAGNoOOLWEO6p3rp160f6jhJt 7Q== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3rsqw8du1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 21:18:47 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 38455804DE4;
        Wed, 12 Jul 2023 21:18:46 +0000 (UTC)
Received: from swahl-linux (unknown [16.231.227.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 34038803DA6;
        Wed, 12 Jul 2023 21:18:44 +0000 (UTC)
Date:   Wed, 12 Jul 2023 16:18:42 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: Abort UV initialization when reduced
 nr_cpus requires it
Message-ID: <ZK8YsuEBmkjv7sDv@swahl-linux>
References: <20230711202618.85562-1-steve.wahl@hpe.com>
 <7422da56-a5a1-d6b2-a2a0-fd4ee5dde5e0@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7422da56-a5a1-d6b2-a2a0-fd4ee5dde5e0@intel.com>
X-Proofpoint-GUID: s-qLXgI22WjNCNevJ-iOFBi8HfUBhmUX
X-Proofpoint-ORIG-GUID: s-qLXgI22WjNCNevJ-iOFBi8HfUBhmUX
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_15,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 malwarescore=0 mlxlogscore=739 phishscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 04:07:55PM -0700, Dave Hansen wrote:
> On 7/11/23 13:26, Steve Wahl wrote:
> > When nr_cpus is set to a smaller number than actually present, there
> > is some node-to-socket mapping info we won't get access to in
> 
> First of all, no "we's" in commit messages.
> 
> > https://www.kernel.org/doc/html/next/process/maintainer-tip.html#changelog

Ah, I was trying to be imperative in the description of what to do,
but didn't understand it applied as much to the description of what
happened in the past that needs to be fixed.  I will fix this.

> > build_socket_tables().  This could later result in using a -1 value
> > for some array indexing, and eventual kernel page faults.
> > 
> > To avoid this, if any unfilled table entries are found, print a
> > warning message, and resume initializing, acting as if this is not a
> > UV system.  UV features will be unavailable, but we will not cause
> > kernel dumps.
> > 
> > This is a condition we expect only in platform debugging situations,
> > not in day-to-day operation.
> 
> This seems like a hack.
> 
> The real problem is that you've got an online Linux NUMA node with no
> CPUs.  uv_system_init_hub() (probably) goes and does:
> 
> >         for_each_node(nodeid)
> >                 __uv_hub_info_list[nodeid] = uv_hub_info_list_blade[uv_node_to_blade_id(nodeid)];
> 
> But the node=>blade lookup uses socket numbers.  No CPUs means no socket
> numbers.  You _have_ the blade information _somewhere_.  Is there really
> no other way to map it to a NUMA node than using the CPU apicid?

I will see if I can find a better place to obtain this information.

Thank you.

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
