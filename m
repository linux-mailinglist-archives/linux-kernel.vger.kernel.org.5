Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF6F7B5F37
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 05:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjJCDFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 23:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjJCDFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 23:05:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C455EAC;
        Mon,  2 Oct 2023 20:05:15 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3932VXoH011832;
        Tue, 3 Oct 2023 03:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=n22Dmg1v0Jra5JL01fd6MLj9xwWt7+gOHdMNq78tG+c=;
 b=RfLqB+5g/BAwF7tQEc4QCHZGMT/o+7I7svwHSp4cXYsFxQynF4fZ1az2QQJ/538+ZkYr
 auDlgY4vZmLNec4pza34lipwEph18x19gDOsdxFMjF1aklhXvhtN5OXCsh/rKSDtaGXF
 WpLf4WfpIfh+PRrAUH5AQLWtWxYK0Luue80fnKrikn6IqDKLEbqXZQRdLIpPmSCePl/b
 k5V0jRvRPa7AzZs0laoNIE0JlkYcIlomqHbMZH3yX20E/ht98ZnX+d+AiFeQhaaosVNo
 cqz9tKdhh14PUaMIpVzcIqI6+vtlSI2LLNcAadxHRw98z6qNW4mItkn3IQpo2R9SjMq4 pg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3teapevyvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 03:05:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393353hD013376
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 03:05:03 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 2 Oct 2023 20:04:57 -0700
Date:   Tue, 3 Oct 2023 08:34:54 +0530
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
Message-ID: <e75a57a9-c9df-4dd5-a109-9ae8c49fb3ae@quicinc.com>
References: <20230929-hib_zero_bitmap_fix-v1-1-6cfdcb785250@quicinc.com>
 <CADyq12znHG_VPLVxSe+2ofX-WR1Uha2hu1MhoUAquMnoD_oP0w@mail.gmail.com>
 <CADyq12x1wZb0Yt3sXR21pQSagT7tGvFmXTBaoeNXkOjPi5-Rnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADyq12x1wZb0Yt3sXR21pQSagT7tGvFmXTBaoeNXkOjPi5-Rnw@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ij9qXGmE5XJZbj09OkVOIXV4-4cntzRh
X-Proofpoint-GUID: ij9qXGmE5XJZbj09OkVOIXV4-4cntzRh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_16,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1015 mlxlogscore=470 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 02:34:20PM -0400, Brian Geffon wrote:
> On Mon, Oct 2, 2023 at 1:56 PM Brian Geffon <bgeffon@google.com> wrote:
> >
> > On Fri, Sep 29, 2023 at 1:31 PM Pavankumar Kondeti
> > <quic_pkondeti@quicinc.com> wrote:
> > >
> > > The following crash is observed 100% of the time during resume from
> > > the hibernation on a x86 QEMU system.
> > >
> > > [   12.931887]  ? __die_body+0x1a/0x60
> > > [   12.932324]  ? page_fault_oops+0x156/0x420
> > > [   12.932824]  ? search_exception_tables+0x37/0x50
> > > [   12.933389]  ? fixup_exception+0x21/0x300
> > > [   12.933889]  ? exc_page_fault+0x69/0x150
> > > [   12.934371]  ? asm_exc_page_fault+0x26/0x30
> > > [   12.934869]  ? get_buffer.constprop.0+0xac/0x100
> > > [   12.935428]  snapshot_write_next+0x7c/0x9f0
> > > [   12.935929]  ? submit_bio_noacct_nocheck+0x2c2/0x370
> > > [   12.936530]  ? submit_bio_noacct+0x44/0x2c0
> > > [   12.937035]  ? hib_submit_io+0xa5/0x110
> > > [   12.937501]  load_image+0x83/0x1a0
> > > [   12.937919]  swsusp_read+0x17f/0x1d0
> > > [   12.938355]  ? create_basic_memory_bitmaps+0x1b7/0x240
> > > [   12.938967]  load_image_and_restore+0x45/0xc0
> > > [   12.939494]  software_resume+0x13c/0x180
> > > [   12.939994]  resume_store+0xa3/0x1d0
> > >
> > > The commit being fixed introduced a bug in copying the zero bitmap
> > > to safe pages. A temporary bitmap is allocated in prepare_image()
> > > to make a copy of zero bitmap after the unsafe pages are marked.
> > > Freeing this temporary bitmap later results in an inconsistent state
> > > of unsafe pages. Since free bit is left as is for this temporary bitmap
> > > after free, these pages are treated as unsafe pages when they are
> > > allocated again. This results in incorrect calculation of the number
> > > of pages pre-allocated for the image.
> > >
> > > nr_pages = (nr_zero_pages + nr_copy_pages) - nr_highmem - allocated_unsafe_pages;
> > >
> > > The allocate_unsafe_pages is estimated to be higher than the actual
> > > which results in running short of pages in safe_pages_list. Hence the
> > > crash is observed in get_buffer() due to NULL pointer access of
> > > safe_pages_list.
> >
> > After reading through the code, perhaps I'm missing something, I'm not
> > sure that this is really fixing the problem.
> >
> > It seems like the problem would be that memory_bm_create() results in
> > calls to get_image_page() w/ safe_needed = PG_ANY == 0, meaning that
> > get_image_page() will not touch allocated_unsafe_pages and instead
> > will mark the page as in use by setting it in the forbidden_pages_map
> > and the free_pages_map simultaneously. The problem is that the
> > free_pages_map was already populated by the call to mark_unsafe_pages,
> > meaning that if we allocated a safe page in get_image_page() we just
> > set the free bit when it otherwise should not be set.
> >
> > When the page is later free'd via the call to memory_bm_free(&tmp,
> > PG_UNSAFE_KEEP), it results in calls to free_image_page() w/
> > clear_page_nosave = PG_UNSAFE_KEEP == 0. This means that we do not
> > touch the free_pages_map because we don't call
> > swsusp_unset_page_free().
> >
> > With all that being said it seems like the correct way to deal with
> > that would be to do:
> >    error = memory_bm_create(&tmp, GFP_ATOMIC, PG_SAFE);
> > Here we know that the pages were not in the free_pages_map initially.
> >
> > Followed by freeing it as:
> >     memory_bm_free(&tmp, PG_UNSAFE_CLEAR);
> > And here we know that swsusp_unset_page_free() will be called making
> > sure the page is not in the free_pages_map afterwards.
> >
> > And that should result in an unchanged free_pages_map. Does that make
> > sense? Please correct me if I'm misunderstanding something.
> >

Thanks for your review. Appreciate the detailed summary.

> 
> To restate this another way, if I'm reading it correctly, I think the
> outcome is actually nearly the same, the difference is, when
> allocating the bitmap before w/ PG_ANY we're setting bits in the
> free_page_list which will be unset a few lines later in the call to
> mark_unsafe_pages(), and then we won't touch the free_pages_list
> during the memory_bm_free() because it's called with PG_UNSAFE_KEEP.
> 

The current patch and your suggestion both gives the same effect like
you said. Since it is a temporary buffer to hold the zero bit map page, I
did not allocate safe pages. Allocating safe pages means a bit more
work. In this case this it is not completely throw away work but
re-ordering the call seems to be simple here. Pls let me know if you
want to me incorporate your suggestion.

Thanks,
Pavan
