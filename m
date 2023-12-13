Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64366811A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbjLMROC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379271AbjLMRNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:13:51 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DEB116;
        Wed, 13 Dec 2023 09:13:55 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sr28Y3J8Sz67QZL;
        Thu, 14 Dec 2023 01:11:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id 6A82F140595;
        Thu, 14 Dec 2023 01:13:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Dec
 2023 17:13:52 +0000
Date:   Wed, 13 Dec 2023 17:13:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ard Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC v4 5/6] firmware/efi: Process CXL Component Events
Message-ID: <20231213171351.00004579@Huawei.com>
In-Reply-To: <65674a71ef4d0_a1b25294e4@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v4-0-47bb901f135e@intel.com>
        <20230601-cxl-cper-v4-5-47bb901f135e@intel.com>
        <7ec6d2af-c860-9b05-7eaf-c82f50f8e66e@amd.com>
        <65674a71ef4d0_a1b25294e4@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 06:28:01 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Smita Koralahalli wrote:
> > Hi Ira,
> > 
> > I tested this out. Just one correction below to make it work.
> >   
> 
> [snip]
> 
> > > +
> > > +#define CPER_CXL_DEVICE_ID_VALID		BIT(0)
> > > +#define CPER_CXL_DEVICE_SN_VALID		BIT(1)
> > > +#define CPER_CXL_COMP_EVENT_LOG_VALID		BIT(2)
> > > +struct cper_cxl_event_rec {
> > > +	struct {
> > > +		u32 length;
> > > +		u64 validation_bits;
> > > +		struct cper_cxl_event_devid {
> > > +			u16 vendor_id;
> > > +			u16 device_id;
> > > +			u8 func_num;
> > > +			u8 device_num;
> > > +			u8 bus_num;
> > > +			u16 segment_num;
> > > +			u16 slot_num; /* bits 2:0 reserved */
> > > +			u8 reserved;
> > > +		} device_id;
> > > +		struct cper_cxl_event_sn {
> > > +			u32 lower_dw;
> > > +			u32 upper_dw;
> > > +		} dev_serial_num;
> > > +	} hdr;
> > > +
> > > +	union cxl_event event;
> > > +} __packed;  
> > 
> > __packed attribute just for cper_cxl_event_rec still fails to properly 
> > align structure elements. Looks like, __packed attribute is needed for 
> > all structs (cper_cxl_event_devid and cper_cxl_event_sn) inside 
> > cper_cxl_event_rec.
> > 
> > Seems easier to use global pragma instead.. I could test and obtain the 
> > output as expected using pragma..  
> 
> I did not know that was acceptable in the kernel but I see you used it in
> cper_cxl.h before...
> 
> Ok I'll do that and spin again.
> 
> Thanks so much for testing this!  I was out last week and still don't have
> a test environment.

Easy to hack into QEMU :)  Hmm. I have a CCIX patch set from years ago
somewhere that does similar. Would be easy to repurposed. Looks like
I never published them (just told people to ask if they wanted them :( ).

Anyhow, if useful I can dig them out.

> 
> Ira

