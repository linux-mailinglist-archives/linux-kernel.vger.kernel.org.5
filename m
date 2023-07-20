Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECA275B6BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjGTS1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjGTS1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:27:35 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB5B186
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:27:33 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id MYN6qe0Rt0OAIMYN6qkOaB; Thu, 20 Jul 2023 20:27:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689877651;
        bh=UVg6F1y2Q2FFEhRMC2xd/+XsbKnoIhgMbd1GyecoDlM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=U7wK9LvGTP2opWVebdBt+WXqwKGWNTD4uyb0v9jcyLDSbG1BYcsW1j2RfH8QQ4U6m
         uCorT1iLC/po/N0CH9dQJvv+NvfCgccrXMsg211C2stZ74ZYxJGe3zHaH3xeK2juRM
         Ya8qpuYq5EViqODYOmv8fd0TTZIsQg50TSzpzTaN27qQ5wj4Zqgtt7Pkguj3Ewn0Rp
         YPTjdEu3oKUf/9F0nsSeUXGjD9Esiwtq4/0kKFQVTn2bXP0OvBrmABaBNTCI7lwNM0
         6cZJJW1wD6VqxiC7cinhYe/Rr3Jb6+4aUaFMnLzZgKLPQ4YTAQt1J+y8ZsZfvUBzpY
         ErWyE8SYqzwHg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 20 Jul 2023 20:27:31 +0200
X-ME-IP: 86.243.2.178
Message-ID: <03c69172-b85f-d9c2-6fd4-33f3ad149142@wanadoo.fr>
Date:   Thu, 20 Jul 2023 20:27:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mtd: rawnand: fsl_upm: Fix an off-by one test in
 fun_exec_op()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mtd@lists.infradead.org, Julia Lawall <Julia.Lawall@lip6.fr>
References: <cd01cba1c7eda58bdabaae174c78c067325803d2.1689803636.git.christophe.jaillet@wanadoo.fr>
 <6f3c9139-cf68-4761-af06-462a72bda978@kadam.mountain>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <6f3c9139-cf68-4761-af06-462a72bda978@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20/07/2023 à 09:04, Dan Carpenter a écrit :
> On Wed, Jul 19, 2023 at 11:55:01PM +0200, Christophe JAILLET wrote:
>> 'op-cs' is copied in 'fun->mchip_number' which is used to access the
>> 'mchip_offsets' and the 'rnb_gpio' arrays.
>> These arrays have NAND_MAX_CHIPS elements, so the index must be below this
>> limit.
>>
>> Fix the sanity check in order to avoid the NAND_MAX_CHIPS value. This
>> would lead to out-of-bound accesses.
>>
>> Fixes: 54309d657767 ("mtd: rawnand: fsl_upm: Implement exec_op()")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Good eye.  I'm assuming you did something like this:
> 
> #!/bin/bash
> 
> FILE=$1
> WORDS=$(cat $FILE | perl -ne 'if ($_ =~ /\[([\w_]+)\];/) { print "$1\n" }' | sort -u)
> for i in $WORDS ; do
>      grep -Hn " > $i" $FILE
> done
> 
> regards,
> dan carpenter
> 

I did with the help of a coccinelle script.
(which can certainly be improved, so adding Julia in cc: :) )

This gives decent results. I only post patches for what I confirm as an 
issue. So it is likely that some good candidates will be left as-is.

So if anyone wants to give it a try, you are welcomed :)

CJ


cocci:
=====
@rule1@
identifier C =~ "[A-Z]+";
expression e;
statement S;
@@
	if (e < C)
		S

@ok1 depends on rule1@
identifier C = rule1.C;
expression e;
statement S;
@@
*	if (e <= C)
		S



@rule2@
identifier C =~ "[A-Z]+";
expression e;
statement S;
@@
	if (e <= C)
		S

@ok2 depends on rule2@
identifier C = rule2.C;
expression e;
statement S;
@@
*	if (e < C)
		S



@rule3@
identifier C =~ "[A-Z]+";
expression e;
statement S;
@@
	if (e > C)
		S

@ok3 depends on rule3@
identifier C = rule3.C;
expression e;
statement S;
@@
*	if (e >= C)
		S



@rule4@
identifier C =~ "[A-Z]+";
expression e;
statement S;
@@
	if (e >= C)
		S

@ok4 depends on rule4@
identifier C = rule4.C;
expression e;
statement S;
@@
*	if (e > C)
		S


CJ
