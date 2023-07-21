Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9750175BDCB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGUFhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGUFhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:37:12 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517FB1BC1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 22:37:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbca8935bfso12978435e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 22:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689917830; x=1690522630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vX/JkYsTJ988R/jCJEP3BfL7G/1slMZU41YSurteI2o=;
        b=cRa+TxE5YsEqvBdKD5o7cITaabLFv6sjdy6P6XfGu8K/hmOCOfl70qGcRIwYPv5c7Q
         t8k+5TNSqPwr5k0C4Kq7aF6a3XvJ24z1Eh8s0wo/HpkRQf3xO58UqcJD1mn3XM6QZFGR
         u+W/lqKUM+ne+jyeXsBHnnf8qWpgFgoxo4trX85idDJ+j/MtiA60gevN4ajdbHSXBBp3
         nOMsDtAm/npF8oqBGE4SHQDIQeHkxicP3tnUmGk5Mb3J+1kbEaYWJBSj2EJpIoRppjPr
         rIfDnSqmtOD+YFuxLOYfhJ1st5S3wOX8RqWHa0BcSxhpNcSO/vYJqhraZeT8Yri3yn+u
         TJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689917830; x=1690522630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vX/JkYsTJ988R/jCJEP3BfL7G/1slMZU41YSurteI2o=;
        b=OCfyTLS6LJo7tVvgD3rCmtRszYZsYvDPoY/Bp2nIGver2nRfbQLMcuN5IAxmOkY4PF
         ioBT5By78G/nbzcJASw3OoKMFlls/ClUg4ElhyUwc2nxxNtrfk80HFmdiMjkmjW6kIAt
         Y0/3Nn5zIf1QFBdvtoz8JvemMM6Nh9IFIWIFFnLnpXA+aoHY4QKcp0fiETuLW3xV7J0X
         GqgAgk1bEGNYDf0/mp8AlnHv8WAX1HQOnqUViz7XUUBXxu7jhjzn3lXKWm85XvNjExpi
         bgAUVeMSirtetiN/zsGbVMFv0afEzioLWkRAaH8CmwiYzXKoLTlze0EKZ7cQ+iet8wK+
         DTtg==
X-Gm-Message-State: ABy/qLbFuhFw8pLdvnAmdKUPNcYKX7uuzpRzQVZWzqOaJas/e3Lt1c+o
        NKrmn+7EgBF/AOETJMi5XULSaw==
X-Google-Smtp-Source: APBJJlHuuEtVJXP90otgD42oqbE5kUntVWwp5lSVN+QyO4G3yrhO6MftAcWJefiLMXZjXf/Ea8z+Vg==
X-Received: by 2002:a7b:c401:0:b0:3fb:bc4a:46ad with SMTP id k1-20020a7bc401000000b003fbbc4a46admr497865wmi.9.1689917829691;
        Thu, 20 Jul 2023 22:37:09 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c229300b003fb40f5f553sm5409400wmf.31.2023.07.20.22.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 22:37:06 -0700 (PDT)
Date:   Fri, 21 Jul 2023 08:37:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mtd@lists.infradead.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: fsl_upm: Fix an off-by one test in
 fun_exec_op()
Message-ID: <604b0c70-01cf-4cbc-b387-8c709c972fef@kadam.mountain>
References: <cd01cba1c7eda58bdabaae174c78c067325803d2.1689803636.git.christophe.jaillet@wanadoo.fr>
 <6f3c9139-cf68-4761-af06-462a72bda978@kadam.mountain>
 <03c69172-b85f-d9c2-6fd4-33f3ad149142@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03c69172-b85f-d9c2-6fd4-33f3ad149142@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 08:27:28PM +0200, Christophe JAILLET wrote:
> Le 20/07/2023 à 09:04, Dan Carpenter a écrit :
> > On Wed, Jul 19, 2023 at 11:55:01PM +0200, Christophe JAILLET wrote:
> > > 'op-cs' is copied in 'fun->mchip_number' which is used to access the
> > > 'mchip_offsets' and the 'rnb_gpio' arrays.
> > > These arrays have NAND_MAX_CHIPS elements, so the index must be below this
> > > limit.
> > > 
> > > Fix the sanity check in order to avoid the NAND_MAX_CHIPS value. This
> > > would lead to out-of-bound accesses.
> > > 
> > > Fixes: 54309d657767 ("mtd: rawnand: fsl_upm: Implement exec_op()")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > 
> > Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> > 
> > Good eye.  I'm assuming you did something like this:
> > 
> > #!/bin/bash
> > 
> > FILE=$1
> > WORDS=$(cat $FILE | perl -ne 'if ($_ =~ /\[([\w_]+)\];/) { print "$1\n" }' | sort -u)
> > for i in $WORDS ; do
> >      grep -Hn " > $i" $FILE
> > done
> > 
> > regards,
> > dan carpenter
> > 
> 
> I did with the help of a coccinelle script.
> (which can certainly be improved, so adding Julia in cc: :) )

Harshit and I were mucking with this about yesterday.  He made
Coccinelle script as well.

We found three bugs in max9286_parse_dt(), hisi_inno_phy_probe() and
jent_testing_store().  Only the one in hisi_inno_phy_probe() is real
life bad because the others do an out of bounds check followed by a
mask.

regards,
dan carpenter

