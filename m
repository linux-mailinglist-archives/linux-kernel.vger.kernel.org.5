Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F56179EF74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjIMQ5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjIMQ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:57:13 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D401BE4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:57:09 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DGYwHK028385;
        Wed, 13 Sep 2023 16:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=pVECDLxvzfx4s7I/ZnWducAjxQ0HjHhAJL3zG/uCzm4=;
 b=UzbqRuJmipaj3TwFX9gAJPEC7clQAqsOL8hYY0MZcKjlEOYJ1d3Pl18Fi7tzuakeIlF7
 0DUMGxp36/jkqPCpt08u1IUbJt12ndRC5H7ofmXRjBzQMXaoCLzbaTHRLZFl8u9Ktd9D
 hUvt0OONbco0FAduLon/CH795Gd7c4WIPtwhrjKFPmr1EgOSJOTlA8v4NntOB9jTpFSi
 HwUe52KHKjb1r7akJ4FOjheh2oZqEYgwrYTaH0cd5MIazuP5ovx/tp6Mx1p3LBS/Mg6c
 U5L8TT5PCJZf9sBLYwSoVbqDBGWyzCw73KzOE55yZ7sVoYMSH3rnQR0Mw8LxBwriV1UX EA== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3t3gqq06ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 16:56:16 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id BE6781318C;
        Wed, 13 Sep 2023 16:56:15 +0000 (UTC)
Received: from swahl-linux (unknown [16.231.227.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 82F18804F51;
        Wed, 13 Sep 2023 16:56:13 +0000 (UTC)
Date:   Wed, 13 Sep 2023 11:56:11 -0500
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
Message-ID: <ZQHpC/oKLwfJuvRu@swahl-linux>
References: <20230913151656.52792-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913151656.52792-1-hdegoede@redhat.com>
X-Proofpoint-ORIG-GUID: a7cgYSSXsIntcacUm0yWmz98B41zcu13
X-Proofpoint-GUID: a7cgYSSXsIntcacUm0yWmz98B41zcu13
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_10,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=951
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 05:16:56PM +0200, Hans de Goede wrote:
> Remove the custom, hard to read code to:
> 
> 1. Make a copy of "val" with any potential '\n' at the end stripped
> 2. Compare the copy against an array of allowed string values
> 
> Linux has the sysfs_match_string() helper exactly for cases like this,
> switch to this.

Hans,

I like this patch, compiling and testing now.

I was wondering, as long as we're in the neighborhood, how you feel
about changing the stored variable uv_nmi_action to an int or enum
rather than a string, since it can only be one of 6 values, and the
string compare while processing an NMI strikes me as inefficent.

It could extend this patch, or be done as a follow on.  And I'm
willing to supply the effort if you want me to.

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
