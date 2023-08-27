Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC31789BA5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjH0HFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjH0HFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:05:48 -0400
Received: from rs227.mailgun.us (rs227.mailgun.us [209.61.151.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F54E120
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 00:05:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1693119943; x=1693127143; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=UjuesKPnJwRzVtkwhdjgtAQ4JQBOmAT2m5YexU2KHy4=;
 b=WzWm1RfxieQRoXsfZXL8ruaE9goRYXMUmdgYFz9otJBkDmqi+dCjb+m6MCjSFRuENqe+NjaswHApS7WztwD7BPGDivkAlvmgL/x1jJEa/IQ+dgo1v/KOUNB2wbt82HNnzJ4Ygc4yQm8qKZAg6Tn2FRwbt0Ku4lAWV9xRWyWoB9jqu+iPgFqqNBA0+wTivKngZyYLLD1eTBNfctDlNgvMJGHCHCo1kCKVvMMrh/0UfibSfZfQIXR2W54A2/MuSwo1Bk/5f1qhlh2N4sQ5ozJe/yRUfbUt+KznxQ4iBvuWVXrBllo7NQpP85NY869myBWezyeQiFgpSwK/VRFAtFScRg==
X-Mailgun-Sending-Ip: 209.61.151.227
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 83b843cc0f41 with SMTP id
 64eaf5c7cb0a642b60bfb239 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 27 Aug 2023 07:05:43 GMT
Sender: james@equiv.tech
Date:   Sun, 27 Aug 2023 00:05:42 -0700
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
Subject: Re: [PATCH v2 02/12] scsi: mpt3sas: Make
 MPI2_CONFIG_PAGE_IO_UNIT_8::Sensor[] a flexible array
Message-ID: <ZOr1xqqM2GTK8K3X@equiv.tech>
References: <20230806170604.16143-1-james@equiv.tech>
 <20230806170604.16143-3-james@equiv.tech>
 <202308251334.A4A10C2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202308251334.A4A10C2@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 01:37:09PM -0700, Kees Cook wrote:
> On Sun, Aug 06, 2023 at 10:05:54AM -0700, James Seo wrote:
>>     Note that iounit_pg8 occurs in the middle of the per-adapter
>>     struct, not at the end. The per-adapter struct is extensively
> 
> This is especially bad/weird. Flex arrays aren't supposed to live there,
> so I think it'd be best to avoid this conversion (see below).
>
>>     used throughout mpt3sas even if its iounit_pg8 member isn't,
>>     resulting in an especially large amount of noise when comparing
>>     binary changes attributable to this commit.
> 
> Since the size reduction makes it hard to validate, how about just
> leaving it alone? Since nothing is using Sensor[], you could just make
> it a single instance:
> 
> -     MPI2_IOUNIT8_SENSOR
> -             Sensor[MPI2_IOUNITPAGE8_SENSOR_ENTRIES];/*0x10 */
> +     MPI2_IOUNIT8_SENSOR     Sensor;                 /*0x10 */
> 
> 
> or leave it as-is (i.e. drop this patch).
> 

I'd prefer not to paper it over by just up and pretending it's not a
flex array at all, but leaving things as-is feels like a waste, and I
understand the need to be conservative with storage drivers.

How do you feel about removing the struct containing the flex array
from the middle of the per-adapter struct, as per patch 8 in this
series? Moving that patch before this one in the ordering would
cleanly fix the misplaced flex array, but I imagine you'd be
especially keen on seeing Broadcom's approval for that one.

In any case, I'm fine with turning this into a single instance if it
comes down to it.

