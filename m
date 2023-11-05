Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFAA7E1765
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjKEWmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjKEWmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:42:11 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CF4DD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 14:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1699224125;
        bh=8cXH1/Q4sHqWtgac+Sz4lIYk/+iiFfAcIe+nqos9YHE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=OtRNMGZpt8C0C3EbyXo9vhekL8eMI49tLrSWoDb73wavLUk2npuysDqf4RjM7Z5Gx
         Ot3/3yi/Cu0FonYecScCfyvRR4PW7LgXKu8U+jL5cP1YVIUVvHNcyM0T37V726F1Sx
         Gv9xkTJ2QvEcivs1lgz+2ai0ceMt3WVpzZjdzRmU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9B48E12810B5;
        Sun,  5 Nov 2023 17:42:05 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id LpbKEJnu54r0; Sun,  5 Nov 2023 17:42:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1699224125;
        bh=8cXH1/Q4sHqWtgac+Sz4lIYk/+iiFfAcIe+nqos9YHE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=OtRNMGZpt8C0C3EbyXo9vhekL8eMI49tLrSWoDb73wavLUk2npuysDqf4RjM7Z5Gx
         Ot3/3yi/Cu0FonYecScCfyvRR4PW7LgXKu8U+jL5cP1YVIUVvHNcyM0T37V726F1Sx
         Gv9xkTJ2QvEcivs1lgz+2ai0ceMt3WVpzZjdzRmU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 417611280143;
        Sun,  5 Nov 2023 17:42:04 -0500 (EST)
Message-ID: <2162ca751035b3ea8c5ce8409c17c1906951181d.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 1/6] tpm: Move buffer handling from static inlines to
 real functions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Julien Gomes <julien@arista.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Sun, 05 Nov 2023 17:42:02 -0500
In-Reply-To: <ac616f9f1eef89e9c202b43d2be5b3ccb6afd1dd.camel@kernel.org>
References: <20231024011531.442587-1-jarkko@kernel.org>
         <20231024011531.442587-2-jarkko@kernel.org>
         <qktrbbbqrz3z4jh4h7pz42leikmyg2mdevzl2brapn32kst55e@s5thpstdtlxp>
         <CWHPA3T3YIJT.148L3L98EXBXD@suppilovahvero>
         <g6grxamrilogiy4vjrvwwn6iz2xm26oeq2y7redbskvcreil6w@seavf5djd4ph>
         <d468a3f18e871f2af4db9c104d393866849ff2d0.camel@HansenPartnership.com>
         <3e69c10c5d03ab2ccf7bda82b7ed9991dbced523.camel@kernel.org>
         <ac616f9f1eef89e9c202b43d2be5b3ccb6afd1dd.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-06 at 00:01 +0200, Jarkko Sakkinen wrote:
> On Sun, 2023-11-05 at 23:59 +0200, Jarkko Sakkinen wrote:
> > On Thu, 2023-10-26 at 13:55 -0400, James Bottomley wrote:
> > > On Thu, 2023-10-26 at 10:10 -0700, Jerry Snitselaar wrote:
> > > > On Wed, Oct 25, 2023 at 08:35:55PM +0300, Jarkko Sakkinen
> > > > wrote:
> > > > > On Wed Oct 25, 2023 at 12:03 PM EEST, Jerry Snitselaar wrote:
> > > > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > > 
> > > > > On Wed, 2023-10-25 at 02:03 -0700, Jerry Snitselaar wrote:
> > > > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > > > 
> > > > > 
> > > > > Thanks I'll add it to the next round.
> > > > > 
> > > > > For the tpm_buf_read(), I was thinking along the lines of:
> > > > > 
> > > > > /**
> > > > >  * tpm_buf_read() - Read from a TPM buffer
> > > > >  * @buf:        &tpm_buf instance
> > > > >  * @pos:        position within the buffer
> > > > >  * @count:      the number of bytes to read
> > > > >  * @output:     the output buffer
> > > > >  *
> > > > >  * Read bytes from a TPM buffer, and update the position.
> > > > > Returns
> > > > > false when the
> > > > >  * amount of bytes requested would overflow the buffer, which
> > > > > is
> > > > > expected to
> > > > >  * only happen in the case of hardware failure.
> > > > >  */
> > > > > static bool tpm_buf_read(const struct tpm_buf *buf, off_t
> > > > > *pos,
> > > > > size_t count, void *output)
> > > > > {
> > > > >         off_t next = *pos + count;
> > > > > 
> > > > >         if (next >= buf->length) {
> > > > >                 pr_warn("%s: %lu >= %lu\n", __func__, next,
> > > > > *offset);
> > > > >                 return false;
> > > > >         }
> > > > > 
> > > > >         memcpy(output, &buf->data[*pos], count);
> > > > >         *offset = next;
> > > > >         return true;
> > > > > }
> > > > > 
> > > > > BR, Jarkko
> > > > > 
> > > > 
> > > > Then the callers will check, and return -EIO?
> > > 
> > > Really, no, why would we do that?
> > > 
> > > The initial buffer is a page and no TPM currently can have a
> > > command that big, so if the buffer overflows, it's likely a
> > > programming error (failure to terminate loop or something) rather
> > > than a runtime one (a user actually induced a command that big
> > > and wanted it to be sent to the TPM).  The only reason you might
> > > need to check is the no-alloc case and you passed in a much
> > > smaller buffer, but even there, I would guess it will come down
> > > to a coding fault not a possible runtime error.
> > 
> > 
> > Yeah, this was my thinking too. So in HMAC case you anyway would
> > not need to check it because crypto is destined to fail anyway.
> > 
> > Returning boolean here does no harm so I thought that this is
> > overally good compromise.
> 
> Or actually maybe we should go just with void, as it does have even
> then "return value", as it emits to klog, right?

Right, these functions are almost drop in replacements for the
get_inc_XX ones.  The latter were void returning because all the
knowledge of what is being looked for is in the calling routine,
because it knows at a macro level what structure the buffer should
have.

James

