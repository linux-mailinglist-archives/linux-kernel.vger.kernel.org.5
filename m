Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B067B5F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 05:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjJCDIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 23:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjJCDIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 23:08:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA84BD;
        Mon,  2 Oct 2023 20:08:39 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3932iduH019401;
        Tue, 3 Oct 2023 03:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=+sWsm5qtm4vswHnIfyAJk3RpqFmAXoJi+tBhHkSooFE=;
 b=GdmZGGQhvhcXN7eBvCUUs0N0hmYy1NvPP2R3e7P5Wpjjgmx94GCtzPVzXkY8UBUCdYTv
 WIzeSwBzp27rN3JV8tcWI5PbRxLJg8F4x9NijBLTYzaPBUOFaUQ6fLX4v7zAYYBpVhjj
 OyJEAiLnwY11fY2lTaRoZgjY8GynpgfWlfRPG+lk5RbgntJ1xAyQdFu1SXkykl9WfSDD
 JsgLtnajXLnPX9k+71pVr3qTWRPL3nx50yLNE5QQk2bn26riwNiPx9Ob9xWo+ketjfrP
 voUDF0H1TV0SXovsstKYW+Bv/uGR5bdNE5DoLh71b9Lzrm/eErw0myazJ2tmhnAAapYC Vg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tg9hdr3sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 03:08:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39338PcM016133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 03:08:25 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 2 Oct 2023 20:08:20 -0700
Date:   Tue, 3 Oct 2023 08:38:17 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Brian Geffon <bgeffon@google.com>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        <kernel@quicinc.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM: hibernate: Fix a bug in copying the zero bitmap to
 safe pages
Message-ID: <990198cf-59bb-484d-9383-dd7d133c8105@quicinc.com>
References: <20230929-hib_zero_bitmap_fix-v1-1-6cfdcb785250@quicinc.com>
 <CADyq12wRVJURCuB0ZjL878J-U9kCxNE0pSoihRWBP8OJWk1M1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADyq12wRVJURCuB0ZjL878J-U9kCxNE0pSoihRWBP8OJWk1M1A@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xWW8-eUTp8WOrdZacg7tD8qMByB0i1l5
X-Proofpoint-GUID: xWW8-eUTp8WOrdZacg7tD8qMByB0i1l5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_16,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=574 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310030024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 07:37:13AM -0400, Brian Geffon wrote:
> On Fri, Sep 29, 2023 at 1:31 PM Pavankumar Kondeti
> <quic_pkondeti@quicinc.com> wrote:
> >
> Hi Pavankumar,
> 
> > The following crash is observed 100% of the time during resume from
> > the hibernation on a x86 QEMU system.
> >
> > [   12.931887]  ? __die_body+0x1a/0x60
> > [   12.932324]  ? page_fault_oops+0x156/0x420
> > [   12.932824]  ? search_exception_tables+0x37/0x50
> > [   12.933389]  ? fixup_exception+0x21/0x300
> > [   12.933889]  ? exc_page_fault+0x69/0x150
> > [   12.934371]  ? asm_exc_page_fault+0x26/0x30
> > [   12.934869]  ? get_buffer.constprop.0+0xac/0x100
> > [   12.935428]  snapshot_write_next+0x7c/0x9f0
> > [   12.935929]  ? submit_bio_noacct_nocheck+0x2c2/0x370
> > [   12.936530]  ? submit_bio_noacct+0x44/0x2c0
> > [   12.937035]  ? hib_submit_io+0xa5/0x110
> > [   12.937501]  load_image+0x83/0x1a0
> > [   12.937919]  swsusp_read+0x17f/0x1d0
> > [   12.938355]  ? create_basic_memory_bitmaps+0x1b7/0x240
> > [   12.938967]  load_image_and_restore+0x45/0xc0
> > [   12.939494]  software_resume+0x13c/0x180
> > [   12.939994]  resume_store+0xa3/0x1d0
> >
> > The commit being fixed introduced a bug in copying the zero bitmap
> > to safe pages. A temporary bitmap is allocated in prepare_image()
> > to make a copy of zero bitmap after the unsafe pages are marked.
> > Freeing this temporary bitmap later results in an inconsistent state
> > of unsafe pages. Since free bit is left as is for this temporary bitmap
> > after free, these pages are treated as unsafe pages when they are
> > allocated again. This results in incorrect calculation of the number
> > of pages pre-allocated for the image.
> >
> > nr_pages = (nr_zero_pages + nr_copy_pages) - nr_highmem - allocated_unsafe_pages;
> >
> > The allocate_unsafe_pages is estimated to be higher than the actual
> > which results in running short of pages in safe_pages_list. Hence the
> > crash is observed in get_buffer() due to NULL pointer access of
> > safe_pages_list.
> 
> Rafael pulled https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=f0c7183008b41e92fa676406d87f18773724b48b
> which addresses the null pointer dereference which regardless
> shouldn't be touching the list directly and should be using
> __get_safe_page().

Thanks for pointing me to this. I have verified hibernation by pulling this
commit to v6.6-rc3 and it works as expected.

This commit is currently queued for v6.7, can it be included in next -rc or 
we have to apply the patch I have sent to make sure that hibernation works on
v6.6 when it gets released.

> 
> >
> > Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the image file")
> > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>

Thanks,
Pavan
