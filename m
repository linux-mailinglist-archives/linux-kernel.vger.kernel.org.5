Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E4B77B7AC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjHNLeq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 07:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjHNLeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:34:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2498613E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:34:35 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-164-m6x-GUkbNESHdga_IVNJjQ-1; Mon, 14 Aug 2023 12:34:32 +0100
X-MC-Unique: m6x-GUkbNESHdga_IVNJjQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 14 Aug
 2023 12:34:20 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 14 Aug 2023 12:34:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] tracing/synthetic: use union instead of casts
Thread-Topic: [PATCH v2] tracing/synthetic: use union instead of casts
Thread-Index: AQHZysDIrcBNpR3A5UeFP15n0rMI4q/psB2g
Date:   Mon, 14 Aug 2023 11:34:20 +0000
Message-ID: <de9b98fe665f4062b5a7eeaa726c547d@AcuMS.aculab.com>
References: <20230809071459.2004931-1-svens@linux.ibm.com>
 <20230809085449.453b632a@gandalf.local.home>
In-Reply-To: <20230809085449.453b632a@gandalf.local.home>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt
> Sent: 09 August 2023 13:55
> On Wed,  9 Aug 2023 09:14:59 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
> 
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -1295,6 +1295,16 @@ static inline void trace_branch_disable(void)
> >  /* set ring buffers to default size if not already done so */
> >  int tracing_update_buffers(void);
> >
> > +struct trace_dynamic {
> > +	union {
> > +		u8				as_u8;
> > +		u16				as_u16;
> > +		u32				as_u32;
> > +		u64				as_u64;
> > +		struct trace_dynamic_info	as_dynamic;
> > +	};
> > +};
> > +
> 
> No need to create a structure around a single element union. Also, I would
> like to name it for what it is for.
> 
> union trace_synth_field {
> 	u8				as_u8;
> 	u16				as_u16;
> 	u32				as_u32;
> 	u64				as_u64;
> 	struct trace_dynamic_info	as_dynamic;
> };
> 
> Other than that, the patch looks good. Although I still need to test it.

I was wondering if you need the u8 and u16 members at all?
Can't the values just be treated as 32bit?
Both char and short aren't really 'proper' arithmetic types.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

