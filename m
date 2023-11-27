Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA4A7F97E0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 04:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjK0DQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 22:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0DQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 22:16:49 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF08B8F;
        Sun, 26 Nov 2023 19:16:54 -0800 (PST)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR3ChHq032419;
        Mon, 27 Nov 2023 03:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pps0720; bh=yciHcAiftOcRr1ySq/QGngV039j46vkGQN6g9LT5awA=;
 b=V94KWZqJbQ7Aypz9cepuigfE93djZB/2ccqcAff2n1boSjYlCo69fGCs19JxDsxBWR+p
 hBkjAjC+tedRcUWVUQCztMtiH9KUm5nt3buHUo0MHJlm+taT53uJH61rV/Ph5ryCSyjX
 O4408Yyb7g0uLgSJPgo2JgL88/pmDSW6EiOlfX8wLp6hDlhhC0879xZyx1AMADQyyAiE
 tFs39LM4P1hQ55mlooaAdYYcpaDTW0UndU46SgzVBj9jvi2RWPvuuGr+YPBx4wL2G8St
 N6DChayrMUHxvEihgnOKp73hS1852Nf6tY28mjVt4D3XN1rDN6WF97sotBcE1Bz3Iry1 5Q== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3uk6ea5p92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 03:16:40 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id CD028800461;
        Mon, 27 Nov 2023 03:16:39 +0000 (UTC)
Received: from perchik (unknown [16.231.227.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 19F0680A0F7;
        Mon, 27 Nov 2023 03:16:38 +0000 (UTC)
Date:   Sun, 26 Nov 2023 20:16:37 -0700
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] watchdog/hpwdt: Cleanup Claiming NMI
Message-ID: <20231127031637.GA1267@perchik>
Reply-To: Jerry.Hoemann@hpe.com
References: <20231109024407.120856-1-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109024407.120856-1-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-GUID: ke6WRTkPJMpB3eNfeh1b-QYZ-I_Al_Jx
X-Proofpoint-ORIG-GUID: ke6WRTkPJMpB3eNfeh1b-QYZ-I_Al_Jx
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_25,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 adultscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270023
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 07:44:05PM -0700, Jerry Hoemann wrote:
> In addition to being a watchdog, hpwdt participates in error
> containmnet on ProLiant systems.
> 
> On legacy platforms (Gen 8/Gen 9 and earlier) Fatal IO errors would be
> signaled as an IO CHECK NMI with expectation that hpwdt would be present
> to receive the NMI and crash the systems thus containing the error.
> 
> A problem was that hwpdt did not discriminate enough in accepting NMIs.
> This could lead to problems if an NMI generated for another subsystems
> was not claimed by that subsystem and became UNKNOWN and was claimed
> by hpwdt.  Application profiling was such an example.  While, profiling
> issue was fixed, hpwdt should avoid claiming NMI not intended for it.
> 
> In iLO 5 time frame, checks were added to make hpwdt more selective
> in claiming NMI.  This patchset cleans up the checks and enables it
> for future versions of iLO.
> 

Hi Guenter,

Was there a problem with this patch set?

Thanks

Jerry


> 
> Jerry Hoemann (2):
>   watchdog/hpwdt: Only claim UNKNOWN NMI if from iLO
>   watchdog/hpwdt: Remove checks on ilo5
> 
>  drivers/watchdog/hpwdt.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> -- 
> 2.41.0

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
