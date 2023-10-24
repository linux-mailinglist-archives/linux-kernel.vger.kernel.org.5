Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7844E7D4E45
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjJXKw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJXKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:52:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DB5E5;
        Tue, 24 Oct 2023 03:52:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F39C433C7;
        Tue, 24 Oct 2023 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698144776;
        bh=6YSqBXV8Q6ZLxR+uekTkLRXBUqLPTfXD2GcE6JjAFts=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=CgX987re7ZS0qylHmqFYwlTHLEPwEfcyIsKycVyYYOm/Lt+9EuTTNsHODYTu1efDY
         ignd/9YFh4ugqsQpM0y8lMDwjgbInGmui0cp7F9EOeeS4KmlA8UraHNl0uzvT8OzW0
         Ipy1pTEsB5ut/XEkzJJ8fygxVtymVGmGcwvQoyCnRA68y8Qjw8lhnI7+z1V5OTvd2/
         +RYb7XZ2GortgvAPmq2si/N0JFJIymwAfkbz5My7vNCeGCoVVtgmS3SgrpKHCnTm+3
         ciCLOy8t5L9g7jzXYVgWqrkTjTJzRlxzWmTtOr5EEkBS4MpvSPe7TDCR2NaGJ66a48
         HBBsj0NLY2/+g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 24 Oct 2023 13:52:51 +0300
Message-Id: <CWGM2YH00DJ3.JKSYNNEWVRW4@suppilovahvero>
Cc:     <keyrings@vger.kernel.org>,
        "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        "William Roberts" <bill.c.roberts@gmail.com>,
        "Stefan Berger" <stefanb@linux.ibm.com>,
        "David Howells" <dhowells@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Julien Gomes" <julien@arista.com>,
        "Jerry Snitselaar" <jsnitsel@redhat.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] tpm: Add tpm_buf_read_{u8,u16,u32}
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mario Limonciello" <mario.limonciello@amd.com>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-6-jarkko@kernel.org>
 <3f9086f6-935f-48a7-889b-c71398422fa1@amd.com>
In-Reply-To: <3f9086f6-935f-48a7-889b-c71398422fa1@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Oct 24, 2023 at 4:38 AM EEST, Mario Limonciello wrote:
> On 10/23/2023 20:15, Jarkko Sakkinen wrote:
> > Add tpm_buf_read_u8(), tpm_buf_read_u16() and tpm_read_u32() for the sa=
ke
> > of more convenient parsing of TPM responses.
> >=20
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >   drivers/char/tpm/tpm-buf.c | 69 +++++++++++++++++++++++++++++++++++++=
+
> >   include/linux/tpm.h        |  3 ++
> >   2 files changed, 72 insertions(+)
> >=20
> > diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> > index f1d92d7e758d..bcd3cbcd9dd9 100644
> > --- a/drivers/char/tpm/tpm-buf.c
> > +++ b/drivers/char/tpm/tpm-buf.c
> > @@ -124,3 +124,72 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const=
 u32 value)
> >   	tpm_buf_append(buf, (u8 *)&value2, 4);
> >   }
> >   EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
> > +
> > +/**
> > + * tpm_buf_read() - Read from a TPM buffer
> > + * @buf:	&tpm_buf instance
> > + * @offset:	offset within the buffer
> > + * @count:	the number of bytes to read
> > + * @output:	the output buffer
> > + */
> > +static void tpm_buf_read(const struct tpm_buf *buf, off_t *offset, siz=
e_t count, void *output)
> > +{
> > +	if (*(offset + count) >=3D buf->length) {
> > +		WARN(1, "tpm_buf: overflow\n");
> > +		return;
> > +	}
>
> In the overflow case wouldn't you want to pass an error code up instead=
=20
> of just showing a WARN trace?
>
> The helper functions can't tell the difference, and the net outcome is=20
> going to be that if there is overflow you get a warning trace in the=20
> kernel log and whatever garbage "value" happened to have going to the=20
> caller.  It's a programmer error but it's also unpredictable what=20
> happens here.
>
> I think it's cleaner to have callers of=20
> tpm_buf_read_u8/tpm_buf_read_u16/tpm_buf_read_u32 to to be able to know=
=20
> something wrong happened.

I think you have a fair point here and I also think it is also a bigger
issue for the response parsing than programmer error. I.e. faulty or
malicious TPM could return corrupted data, which makes WARN() wrong
choice.

So, as a corrective measure I think it should be pr_warn() instead, and
instead of returning u8/u16/u32, all functions should return 'ssize_t'
and -EIO in the case of overflow.

Thank you, it was a really good catch.

BR, Jarkko

