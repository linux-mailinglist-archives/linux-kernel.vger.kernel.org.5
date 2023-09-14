Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AE87A08CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbjINPQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjINPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:16:26 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67631FCC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:16:22 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EAWa8v010180;
        Thu, 14 Sep 2023 15:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=S6CdTbOb5SJDWVQ4uuGpl9JAAhxvt26QIKEA+nu+wro=;
 b=Yecca53xeJCOVvJvh97sElDM2woE16IZml8+RYWRP4VN23ZwKAtb7GiCIs6zTYWVFrvo
 3mWZdkT1JWflidF9A80gAbHefAqp+fvrSG/7uf57fQS0PDX/xZJB8iROxLjmMWgx5g+R
 5cq5X4DQS6cjUaWVCqqtTTRbkvaxKTmGJEgfovk7jSSM2oJLB4mRXBAXXv89c4vNj7B4
 7KF/WG5u3WEdI8tfF2RV6ew/Kh5LWvACJ0QVbOYdhDHYCvrmjWzB5o1tsf5T18ve7vtj
 C9tZPVH8BPxKoEIF6Be1Pk8sbEu8f+bhsawEcBpIZgxq585XKl+FHmKJbEVpJgstylc8 Pw== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3t3rkd6ff5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 15:15:52 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 42BF6805E4C;
        Thu, 14 Sep 2023 15:15:51 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 53F7080AEA9;
        Thu, 14 Sep 2023 15:15:48 +0000 (UTC)
Date:   Thu, 14 Sep 2023 10:15:46 -0500
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
Subject: Re: [PATCH v2] x86/platform/uv: Rework NMI "action" modparam handling
Message-ID: <ZQMjouJ+TpuEHtIW@swahl-home.5wahls.com>
References: <20230913180111.85397-1-hdegoede@redhat.com>
 <ZQIka+OM1+2M3CsU@swahl-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQIka+OM1+2M3CsU@swahl-linux>
X-Proofpoint-GUID: fFta-GvXh94nAe86I_WOBKbAPx2YLlgK
X-Proofpoint-ORIG-GUID: fFta-GvXh94nAe86I_WOBKbAPx2YLlgK
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 mlxlogscore=745 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 04:06:51PM -0500, Steve Wahl wrote:
> On Wed, Sep 13, 2023 at 08:01:11PM +0200, Hans de Goede wrote:

> Maybe rework the message so a possible newline doesn't look so
> awkward, by removing the comma?
> 
> > +	pr_err("UV: Invalid NMI action:%s Valid actions are:\n", val);

It occurred to me overnight that leaving val out completely is an
option, as printing it adds very little value.  So a reasonable option
would be:

+	pr_err("UV: Invalid NMI action. Valid actions are:\n");

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise
