Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07EF7D87DF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjJZR4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZR4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:56:02 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BB11A2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1698342959;
        bh=AoxGJ+wBYwrKrdP9vB2wZ9O/z3R0MKu7k+bX0EK20fE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=XJoRIE5+yAGK/Q0gi9XmPd3BMMF0qnoW0dXzrr8Al9EPjhL22fFTei3Vt8lI+AnHC
         iyPxjppUrDbRPhVDPQbbPR0f3t131ZcTfycp64GEz9PmG3hTHVYqBUDlQUwHi7k+OG
         QvUR7S4Vz/0HNOljG0VAf+JfzpzIwp1TGGKbNP5U=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9A4251286BB1;
        Thu, 26 Oct 2023 13:55:59 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id WV6ZavWvzbtC; Thu, 26 Oct 2023 13:55:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1698342959;
        bh=AoxGJ+wBYwrKrdP9vB2wZ9O/z3R0MKu7k+bX0EK20fE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=XJoRIE5+yAGK/Q0gi9XmPd3BMMF0qnoW0dXzrr8Al9EPjhL22fFTei3Vt8lI+AnHC
         iyPxjppUrDbRPhVDPQbbPR0f3t131ZcTfycp64GEz9PmG3hTHVYqBUDlQUwHi7k+OG
         QvUR7S4Vz/0HNOljG0VAf+JfzpzIwp1TGGKbNP5U=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1181A1286B29;
        Thu, 26 Oct 2023 13:55:57 -0400 (EDT)
Message-ID: <d468a3f18e871f2af4db9c104d393866849ff2d0.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 1/6] tpm: Move buffer handling from static inlines to
 real functions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
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
Date:   Thu, 26 Oct 2023 13:55:55 -0400
In-Reply-To: <g6grxamrilogiy4vjrvwwn6iz2xm26oeq2y7redbskvcreil6w@seavf5djd4ph>
References: <20231024011531.442587-1-jarkko@kernel.org>
         <20231024011531.442587-2-jarkko@kernel.org>
         <qktrbbbqrz3z4jh4h7pz42leikmyg2mdevzl2brapn32kst55e@s5thpstdtlxp>
         <CWHPA3T3YIJT.148L3L98EXBXD@suppilovahvero>
         <g6grxamrilogiy4vjrvwwn6iz2xm26oeq2y7redbskvcreil6w@seavf5djd4ph>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-26 at 10:10 -0700, Jerry Snitselaar wrote:
> On Wed, Oct 25, 2023 at 08:35:55PM +0300, Jarkko Sakkinen wrote:
> > On Wed Oct 25, 2023 at 12:03 PM EEST, Jerry Snitselaar wrote:
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > 
> > On Wed, 2023-10-25 at 02:03 -0700, Jerry Snitselaar wrote:
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > 
> > 
> > Thanks I'll add it to the next round.
> > 
> > For the tpm_buf_read(), I was thinking along the lines of:
> > 
> > /**
> >  * tpm_buf_read() - Read from a TPM buffer
> >  * @buf:        &tpm_buf instance
> >  * @pos:        position within the buffer
> >  * @count:      the number of bytes to read
> >  * @output:     the output buffer
> >  *
> >  * Read bytes from a TPM buffer, and update the position. Returns
> > false when the
> >  * amount of bytes requested would overflow the buffer, which is
> > expected to
> >  * only happen in the case of hardware failure.
> >  */
> > static bool tpm_buf_read(const struct tpm_buf *buf, off_t *pos,
> > size_t count, void *output)
> > {
> >         off_t next = *pos + count;
> > 
> >         if (next >= buf->length) {
> >                 pr_warn("%s: %lu >= %lu\n", __func__, next,
> > *offset);
> >                 return false;
> >         }
> > 
> >         memcpy(output, &buf->data[*pos], count);
> >         *offset = next;
> >         return true;
> > }
> > 
> > BR, Jarkko
> > 
> 
> Then the callers will check, and return -EIO?

Really, no, why would we do that?

The initial buffer is a page and no TPM currently can have a command
that big, so if the buffer overflows, it's likely a programming error
(failure to terminate loop or something) rather than a runtime one (a
user actually induced a command that big and wanted it to be sent to
the TPM).  The only reason you might need to check is the no-alloc case
and you passed in a much smaller buffer, but even there, I would guess
it will come down to a coding fault not a possible runtime error.

James

