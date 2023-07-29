Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF364767D13
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 10:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjG2IJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 04:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjG2IJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:09:07 -0400
Received: from so254-32.mailgun.net (so254-32.mailgun.net [198.61.254.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C958D1AB
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 01:09:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1690618142; x=1690625342; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=CozDmRp1bkHwGB5inh5kVVb5HQMFeVPssjH7f8Z8xA4=;
 b=kk3swVL/l0Lw/AEpHNjjSxaaGjsIo7yq2oqP+b6+UqyTljPcXJnBbuqFBbNwJZSipV2rVnDPWJ5MTfFiWgyIJYfekCGDUYfQ+5bTf4im0nxHzfOZbyrlGJZNSo8qoJtH+10kLU4rcD1PzoVdz3MRHw+6l2kbQZSxkW6PUyapRmFF6cI7ZNM5I6c3hjOz3cCSCwYbjvdfM49FzDd6lzL1Pwp8ih2sG5tzzBAj9cJlX1Vx3q6w3gcJOfrHbLQ3c40021uWlM+1NPHhqjlenSgVlH9zE/hJ9AkUwY6S9oD6coR4le0IYCuxtoMi9jJTYSWUWHeNLzdqkwINLnHVljxpRQ==
X-Mailgun-Sending-Ip: 198.61.254.32
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by dab6b325100a with SMTP id
 64c4c91e13929ab6cba6da2f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 29 Jul 2023 08:09:02 GMT
Sender: james@equiv.tech
Date:   Sat, 29 Jul 2023 01:09:01 -0700
From:   James Seo <james@equiv.tech>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] scsi: mpt3sas: Use flexible arrays when less
 obviously possible
Message-ID: <ZMTJHZLu7szzsx1s@equiv.tech>
References: <20230725161331.27481-1-james@equiv.tech>
 <20230725161331.27481-3-james@equiv.tech>
 <202307281508.32604C856@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202307281508.32604C856@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks for reviewing.

On Fri, Jul 28, 2023 at 03:26:57PM -0700, Kees Cook wrote:
> Doing build comparisons here, I see a lot of binary changes. They may
> be, as you say, harmless, and since you've actually got hardware then
> this is a good verification of the changes, but I do wonder if this
> needs more detailed commit log (or split up patches).
> 
> However, the problem I see is that this code was already doing weird
> stuff with structs that appear to not have been using flex arrays
> actually. With "pahole" I can see struct MPT3SAS_ADAPTER changes:
> 
> -       Mpi2IOUnitPage8_t          iounit_pg8;           /*  3668    40 */
> -       Mpi2IOCPage1_t             ioc_pg1_copy;         /*  3708    24 */
> +       Mpi2IOUnitPage8_t          iounit_pg8;           /*  3668    16 */
> +       Mpi2IOCPage1_t             ioc_pg1_copy;         /*  3684    24 */
> 
> struct _MPI2_CONFIG_PAGE_IO_UNIT_8 (Mpi2IOUnitPage8_t) is in the
> _middle_ of struct MPT3SAS_ADAPTER.... :|

In this particular case, the flex array member of iounit_pg8 is never
used, and iounit_pg8 itself is never used outside of the function
that fetches and sets it on the per-adapter struct MPT3SAS_ADAPTER.

iounit_pg8 could probably be removed, now that I think about it.
Maybe I will.

> In the earlier attempts at this conversion, it seemed that some of these
> are actually fixed-size:
> 
> https://lore.kernel.org/lkml/20210202235118.GA314410@embeddedor/

Yes, I tried to leave such terminal arrays alone. But I'll revisit
each change in this commit.

> I think this patch needs to be broken up into per-struct changes, so
> they can be reviewed individually.

Sure, I can do that. I'll resubmit this commit and the one following
(which depends on this commit) as a new series with more details.
Hopefully this will encourage the Broadcom folks who know this driver
best to chime in as well.

By the way, I noticed you've done something like this in the past to
preserve struct size for userspace, just in case:

	/* MPI2_IOUNIT8_SENSOR		Sensor[1]; */
	union {
		MPI2_IOUNIT8_SENSOR	_LegacyPadding;
		__DECLARE_FLEX_ARRAY(MPI2_IOUNIT8_SENSOR, Sensor);
	};

I don't think userspace is a concern for us here, but would you be
more comfortable if I did this too/instead?

James
