Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075C77A3DB7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbjIQVB1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Sep 2023 17:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239717AbjIQVBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:01:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFE6B6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 14:01:03 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-173-5VIfJed7MXGh7MjJ3HyGRg-1; Sun, 17 Sep 2023 22:00:50 +0100
X-MC-Unique: 5VIfJed7MXGh7MjJ3HyGRg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 17 Sep
 2023 22:00:40 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 17 Sep 2023 22:00:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'James Morse' <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "dfustini@baylibre.com" <dfustini@baylibre.com>,
        "amitsinght@marvell.com" <amitsinght@marvell.com>
Subject: RE: [PATCH v6 09/24] x86/resctrl: Use set_bit()/clear_bit() instead
 of open coding
Thread-Topic: [PATCH v6 09/24] x86/resctrl: Use set_bit()/clear_bit() instead
 of open coding
Thread-Index: AQHZ5zAaDgmrK1w/n0WuE13QIAvATLAfhSSQ
Date:   Sun, 17 Sep 2023 21:00:40 +0000
Message-ID: <6f7b411db77846b2a305b93d0cf0ee7b@AcuMS.aculab.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-10-james.morse@arm.com>
In-Reply-To: <20230914172138.11977-10-james.morse@arm.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse
> Sent: 14 September 2023 18:21
> 
> The resctrl CLOSID allocator uses a single 32bit word to track which
> CLOSID are free. The setting and clearing of bits is open coded.
> 
> A subsequent patch adds resctrl_closid_is_free(), which adds more open
> coded bitmaps operations. These will eventually need changing to use
> the bitops helpers so that a CLOSID bitmap of the correct size can be
> allocated dynamically.
> 
> Convert the existing open coded bit manipulations of closid_free_map
> to use set_bit() and friends.
> 
>  int closids_supported(void)
> @@ -126,7 +126,7 @@ static void closid_init(void)
>  	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
> 
>  	/* CLOSID 0 is always reserved for the default group */
> -	closid_free_map &= ~1;
> +	clear_bit(0, &closid_free_map);

Don't the clear_bit() etc functions use locked accesses?
These are always measurably more expensive than the C operators.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

