Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104EA781CBE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 09:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjHTHAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 03:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjHTHAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 03:00:38 -0400
X-Greylist: delayed 521 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Aug 2023 23:34:34 PDT
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B7A903C;
        Sat, 19 Aug 2023 23:34:34 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 0548340733; Sun, 20 Aug 2023 07:25:49 +0100 (BST)
Date:   Sun, 20 Aug 2023 07:25:48 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_crb: Fix an error handling path in crb_acpi_add()
Message-ID: <ZOGx7F/3fTXaj8oI@srcf.ucam.org>
References: <a820eaf8c77ca4fde50fc170f535de4b28c82a2d.1677322706.git.christophe.jaillet@wanadoo.fr>
 <c2263ee0-2133-6f89-3f16-2ae1129a20df@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2263ee0-2133-6f89-3f16-2ae1129a20df@wanadoo.fr>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 08:21:47AM +0200, Christophe JAILLET wrote:
> Le 25/02/2023 à 11:58, Christophe JAILLET a écrit :
> > Some error paths don't call acpi_put_table() before returning.
> > Branch to the correct place instead of doing some direct return.
> > 
> > Fixes: 4d2732882703 ("tpm_crb: Add support for CRB devices based on Pluton")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >   drivers/char/tpm/tpm_crb.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > index 99698ee1a744..f7068bd8b3d0 100644
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -771,12 +771,13 @@ static int crb_acpi_add(struct acpi_device *device)
> >   				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
> >   				buf->header.length,
> >   				ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON);
> > -			return -EINVAL;
> > +			rc = -EINVAL;
> > +			goto out;
> >   		}
> >   		crb_pluton = ACPI_ADD_PTR(struct tpm2_crb_pluton, buf, sizeof(*buf));
> >   		rc = crb_map_pluton(dev, priv, buf, crb_pluton);
> >   		if (rc)
> > -			return rc;
> > +			goto out;
> >   	}
> >   	priv->sm = sm;
> 
> Hi,
> 
> polite reminder.
> 
> While re-looking at it, the 3rd parameter of crb_map_pluton() (i.e. buf)
> looks unused and could be removed if it makes sense to you.

For the original patch:

ACKed-by: Matthew Garrett <mgarrett@aurora.tech>

I'm actually re-working the pluton mapping code because right now it's 
impossible to use localities because the ACPI table is unhelpful and I 
think that can be worked around.
