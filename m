Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CCC79EFC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjIMREc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIMREb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:04:31 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCAECE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:04:27 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DAcB0g016759;
        Wed, 13 Sep 2023 17:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=AlDDlB01SiTBasPbc9DUiDivgebSGgeD2l8rr6NGVYw=;
 b=f2U023wQxTTk1eYb2V5VDF5MDHAr1A+bJCjEUWvudnhtOpKqIsZfquvmW1vONf2WWpby
 LYsen7zXNfBKhYa0Ma0EDZDXcDgbFY4mpwBVrAPGSN4NSAn1Gpnx++XBlmWmfkCglXbT
 K3fV4YVqy1/DbZc2fMrTHcpgc5c2T3Rc9hg3oDQMczmWKotFx99nE/nMSHm26WFXBAiA
 /oKRqM9YyHyEqdUnws+pAho1o08p3aU1xOeppGoRKvJSCJJvnxAllqrDfStuZqxsYWy9
 heHZU+2hef7ez0AK0AG8+7+J4ga3t8mQf4devBzd9IANA0ph9B8yRg0wUPKORXH+H34X TQ== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3t349tfn7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 17:03:43 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 9FA20805E57;
        Wed, 13 Sep 2023 17:03:42 +0000 (UTC)
Received: from swahl-linux (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 25FCE80362F;
        Wed, 13 Sep 2023 17:03:41 +0000 (UTC)
Date:   Wed, 13 Sep 2023 12:03:39 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH] x86/platform/uv: Use sysfs_match_string() for string
 parsing in param_set_action()
Message-ID: <ZQHray72BRX+mSrL@swahl-linux>
References: <20230913151656.52792-1-hdegoede@redhat.com>
 <ZQHpC/oKLwfJuvRu@swahl-linux>
 <4f41e78e-5e47-0726-c64a-82559d1f799b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f41e78e-5e47-0726-c64a-82559d1f799b@redhat.com>
X-Proofpoint-ORIG-GUID: XzImk9e6nKuvDvn2EHaFXruU_Qo993hk
X-Proofpoint-GUID: XzImk9e6nKuvDvn2EHaFXruU_Qo993hk
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_11,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 07:01:31PM +0200, Hans de Goede wrote:
> Hi Steve,
> 
> On 9/13/23 18:56, Steve Wahl wrote:
> > On Wed, Sep 13, 2023 at 05:16:56PM +0200, Hans de Goede wrote:
> >> Remove the custom, hard to read code to:
> >>
> >> 1. Make a copy of "val" with any potential '\n' at the end stripped
> >> 2. Compare the copy against an array of allowed string values
> >>
> >> Linux has the sysfs_match_string() helper exactly for cases like this,
> >> switch to this.
> > 
> > Hans,
> > 
> > I like this patch, compiling and testing now.
> > 
> > I was wondering, as long as we're in the neighborhood, how you feel
> > about changing the stored variable uv_nmi_action to an int or enum
> > rather than a string, since it can only be one of 6 values, and the
> > string compare while processing an NMI strikes me as inefficent.
> > 
> > It could extend this patch, or be done as a follow on.  And I'm
> > willing to supply the effort if you want me to.
> 
> I must admit I did not look at the code consuming uv_nmi_action
> and I did wonder why this was not an enum from day 1.
> 
> I'll prepare a v2 of this patch which changes uv_nmi_action
> to an enum.
> 
> Note I can compile test this only, so I gope you will be able to
> test the v2 a bit more thoroughly :)

I will!

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
