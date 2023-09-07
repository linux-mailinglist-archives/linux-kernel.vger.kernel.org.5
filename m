Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B290A797E0E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbjIGVoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjIGVoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:44:08 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFB3B4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:44:04 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387I26vh028336;
        Thu, 7 Sep 2023 21:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=27z9CO0TAAHwoVpMMRxHN9rHFIsRgljI9vEhcjq75Mc=;
 b=R9Q9kze55TjbBqhsWSMP1TSXLB+ozL5LIt0QgBUUJPyQ7SLO7SP4aRWyKAsIyIZ148UU
 g7YGkwmbK+oMqkJrjUeOS9zrEX2MwM//BXDcoIZ8xzYKkeewmziO3rlTu3MaQ9rGy5V2
 8croUyMx+VwK9FTJN48NqjYKLDj4i1qUOlFfRSCyWoPhEPX3zNk5jry+AyQV+B7ti8yr
 pyK1BN6f564rakDMEFJsexxpkEyggUl1JyWvN9lpIvtJIpPnp2AAQblIA1n24933ySlM
 6qIGdMuuidSwT9U2KZkIUhJ7GUROCpTvCNw5wr38/DysuzyUQ2uN5GQhGmBoNmsHcFzJ QA== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3sy901g4bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 21:43:38 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 672A9805E4F;
        Thu,  7 Sep 2023 21:43:37 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 0FDCC815C20;
        Thu,  7 Sep 2023 21:43:35 +0000 (UTC)
Date:   Thu, 7 Sep 2023 16:43:34 -0500
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
Message-ID: <ZPpEBlAhAEpchxur@swahl-home.5wahls.com>
References: <20230807141730.1117278-1-steve.wahl@hpe.com>
 <ad1ff365-4160-87b9-4199-ace5ff1250e1@intel.com>
 <ZPI1IP38l/X7K/k9@swahl-home.5wahls.com>
 <ZPdC2OxhPznQuYk8@swahl-home.5wahls.com>
 <29cd0ee1-c638-9d8e-8a1c-8c2aa2e167e7@intel.com>
 <ZPo/z0TaWahjgglT@swahl-home.5wahls.com>
 <81ee91fa-5546-4ca8-e8bc-765174938fc5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ee91fa-5546-4ca8-e8bc-765174938fc5@intel.com>
X-Proofpoint-ORIG-GUID: jBH6YRY5JzLmpmcs4uZkQ7VzOVYXNp7N
X-Proofpoint-GUID: jBH6YRY5JzLmpmcs4uZkQ7VzOVYXNp7N
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 mlxlogscore=684 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070192
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 02:32:11PM -0700, Dave Hansen wrote:
> On 9/7/23 14:25, Steve Wahl wrote:
> >> Does this need a stable@ tag when it gets applied?
> > I hadn't thought about that.  I think it meets the requirements in
> > stable-kernel-rules.rst.  And it looks like it should apply without
> > conflicts or prerequisites.  So it probably should.  Is there a way to
> > add a cc:stable tag at this point?
> 
> I can do it when I apply it.  I just wanted to make sure there wasn't a
> good reason you left off the cc:stable.

No reason, it was an oversight.

Thanks, Dave.

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
