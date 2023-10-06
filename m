Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6377BB2D3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjJFIKH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 04:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjJFIKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:10:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53173E4;
        Fri,  6 Oct 2023 01:10:02 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S21Jb2RL7z6K5yx;
        Fri,  6 Oct 2023 16:08:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 6 Oct
 2023 09:09:59 +0100
Date:   Fri, 6 Oct 2023 09:09:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Kuan-Wei Chiu <visitorckw@gmail.com>, <yangyicong@hisilicon.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        "Ian Rogers" <irogers@google.com>
Subject: Re: [PATCH] perf hisi-ptt: Fix memory leak in lseek failure
 handling
Message-ID: <20231006090959.00005787@Huawei.com>
In-Reply-To: <CAM9d7ciJZsCaVo6m_VtJ=QKNGAtBkAncidQjHzwexd3H8+3Usw@mail.gmail.com>
References: <20230930072719.1267784-1-visitorckw@gmail.com>
        <CAM9d7ciJZsCaVo6m_VtJ=QKNGAtBkAncidQjHzwexd3H8+3Usw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2023 21:48:14 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> Hello,
> 
> On Sat, Sep 30, 2023 at 12:27 AM Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > In the previous code, there was a memory leak issue where the previously
> > allocated memory was not freed upon a failed lseek operation. This patch
> > addresses the problem by releasing the old memory before returning -errno
> > in case of a lseek failure. This ensures that memory is properly managed
> > and avoids potential memory leaks.
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>  
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
FYI, Ian Rogers has a series with a similar fix that goes a little further
and drops the assignment of data_offset seen just at the top of the context
below as it is unused.

https://lore.kernel.org/all/20231005230851.3666908-5-irogers@google.com/

I haven't replied to this yet as want to check some related handling
with one of my China based colleagues and it's a festival this week.

One of us will get back on this next week,

Jonathan

> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/perf/util/hisi-ptt.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
> > index 45b614bb73bf..43bd1ca62d58 100644
> > --- a/tools/perf/util/hisi-ptt.c
> > +++ b/tools/perf/util/hisi-ptt.c
> > @@ -108,8 +108,10 @@ static int hisi_ptt_process_auxtrace_event(struct perf_session *session,
> >                 data_offset = 0;
> >         } else {
> >                 data_offset = lseek(fd, 0, SEEK_CUR);
> > -               if (data_offset == -1)
> > +               if (data_offset == -1) {
> > +                       free(data);
> >                         return -errno;
> > +               }
> >         }
> >
> >         err = readn(fd, data, size);
> > --
> > 2.25.1
> >  
> 

