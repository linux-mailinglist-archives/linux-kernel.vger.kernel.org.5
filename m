Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D9B789BAA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjH0HG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjH0HG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:06:29 -0400
Received: from so254-32.mailgun.net (so254-32.mailgun.net [198.61.254.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D37018F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 00:06:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1693119984; x=1693127184; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=a2QNVHpCy69phGF1UsAYo4X/AG2eDB3F/Vurqfii8Wo=;
 b=XoLrmrvvUEMbf1dzDmEFxWOfhNfO+VVJIak4YGVIXVwsqOqVwm+MVfnlUj2zZhVoEYB/iy1tLE6Tm896zz+Z5c79bW1tl5OBFL2H/7TvWVa5uUmOe+Mqc+JHd80F/w7dykkyqr3RB7lLWYw01B4IIH7nu1MBsQ5RinPBSlOB36jBYhxK95CxCwuQ+ciVvxZJCOup3/9zklPvzTugULv9zV8cw8v7HC7ii53VJQW0swniiIMD49u6Aa5ILJVuBReUOoTYZTFyg4dLKABCZBgdeEobaCZX2v+DIMpv5mgvpvwV0sWtmwJ3WhVMeRCuA3wuF4aGxKRJY4BFzmExSUcvDQ==
X-Mailgun-Sending-Ip: 198.61.254.32
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 6fa3ba917c3f with SMTP id
 64eaf5f0cd2de71bad0a6c9f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 27 Aug 2023 07:06:24 GMT
Sender: james@equiv.tech
Date:   Sun, 27 Aug 2023 00:06:23 -0700
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
Subject: Re: [PATCH v2 03/12] scsi: mpt3sas: Make
 MPI2_CONFIG_PAGE_RAID_VOL_0::PhysDisk[] a flexible array
Message-ID: <ZOr175KsKEoCss8U@equiv.tech>
References: <20230806170604.16143-1-james@equiv.tech>
 <20230806170604.16143-4-james@equiv.tech>
 <202308251357.38AF364@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202308251357.38AF364@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 02:03:23PM -0700, Kees Cook wrote:
> On Sun, Aug 06, 2023 at 10:05:55AM -0700, James Seo wrote:
>> This terminal 1-length variable array can be directly converted into
>> a C99 flexible array member.
>> 
>> As all users of MPI2_CONFIG_PAGE_RAID_VOL_0 (Mpi2RaidVolPage0_t)
>> either calculate its size without depending on its sizeof() or do not
>> use PhysDisk[], no further source changes are required:
> 
> Tons of binary changes in this file too. I see this:
> 
>         Mpi2RaidVolPage0_t config_page;
> 	...
>         r = _config_request(ioc, &mpi_request, &mpi_reply,
>             MPT3_CONFIG_PAGE_DEFAULT_TIMEOUT, &config_page,
>             sizeof(Mpi2RaidVolPage0_t));
> 
> So it's already changing this size (and possibly under-allocating now).

Yes. I didn't explicitly identify _config_request() as a user of the
five structs for which I parted out changes into their own commits,
as it's a generalized helper indirectly called when working with
other config page structs as well. Rest assured that I took it into
account, and that the reduced struct sizes don't represent
under-allocations (see below).

>> - mpt3sas_config.c:mpt3sas_config_get_number_pds() fetches a
>>   Mpi2RaidVolPage0_t for itself, but does not use PhysDisk[].
> 
> Is it certain that _config_request()'s use of mpt3sas_wait_for_ioc()
> won't result in the hardware being upset that config_page_sz shrank?
 
Sorry if I missed it, but I don't see what config_page_sz has to do
with _config_request()'s use of mpt3sas_wait_for_ioc(). Could you
explain what you meant?

More generally, changes in config_page_sz shouldn't faze the hardware
because all usages of _config_request() occur in pairs - a
preparatory call that returns the actual size of a given config page
in mpi_reply, then a follow-up call during which a temporary
DMA-capable buffer is allocated per the size in mpi_reply and the
hardware reads/writes the entirety of this buffer. config_page_sz
just determines the number of bytes copied between config_page and
the temp buffer after a hardware read/before a hardware write.

Well, as far I can tell, anyway. Maybe Broadcom knows otherwise.

>> @@ -1826,8 +1823,7 @@ typedef struct _MPI2_CONFIG_PAGE_RAID_VOL_0 {
>>  	U8                      Reserved2;         /*0x25 */
>>  	U8                      Reserved3;         /*0x26 */
>>  	U8                      InactiveStatus;    /*0x27 */
>> -	MPI2_RAIDVOL0_PHYS_DISK
>> -	PhysDisk[MPI2_RAID_VOL_PAGE_0_PHYSDISK_MAX]; /*0x28 */
>> +	MPI2_RAIDVOL0_PHYS_DISK PhysDisk[];        /*0x28 */
>>  } MPI2_CONFIG_PAGE_RAID_VOL_0,
> 
> Without the mpt3sas maintainers chiming in on this, I think the only
> safe changes to make here are those with 0 binary differences. So for
> things like this, it'll need to be:
> 
> -	MPI2_RAIDVOL0_PHYS_DISK
> -	PhysDisk[MPI2_RAID_VOL_PAGE_0_PHYSDISK_MAX]; /*0x28 */
> +	union {
> +		MPI2_RAIDVOL0_PHYS_DISK legacy_padding;        /*0x28 */
> +		DECLARE_FLEX_ARRAY(MPI2_RAIDVOL0_PHYS_DISK, PhysDisk);
> +	};
> 
> -- 
> Kees Cook

Thanks for clearing that up. Here's hoping those mpt3sas maintainers
do chime in. I'll go with the union workaround if they don't.

James
