Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BA8791DBB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjIDTgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjIDTgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:36:36 -0400
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB701A7;
        Mon,  4 Sep 2023 12:36:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 6882820152;
        Mon,  4 Sep 2023 21:36:30 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hfugnFnfAGl4; Mon,  4 Sep 2023 21:36:30 +0200 (CEST)
Received: from begin (lfbn-bor-1-1163-184.w92-158.abo.wanadoo.fr [92.158.138.184])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id A62C120155;
        Mon,  4 Sep 2023 21:36:29 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1qdFN6-00D65a-2I;
        Mon, 04 Sep 2023 21:36:28 +0200
Date:   Mon, 4 Sep 2023 21:36:28 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        speakup@linux-speakup.org
Subject: Re: [PATCH] accessibility: speakup: Fix incorrect string length
 computation in report_char_chartab_status()
Message-ID: <20230904193628.movlpsvxnxre6vy3@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, Greg Kroah-Hartman <gregkh@suse.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        speakup@linux-speakup.org
References: <b388b088485aff5dc223f2723ee61e00e5cd3f7d.1693855874.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b388b088485aff5dc223f2723ee61e00e5cd3f7d.1693855874.git.christophe.jaillet@wanadoo.fr>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET, le lun. 04 sept. 2023 21:31:44 +0200, a ecrit:
> snprintf() returns the "number of characters which *would* be generated for
> the given input", not the size *really* generated.
> 
> In order to avoid too large values for 'len' (and potential negative
> values for "sizeof(buf) - (len - 1)") use scnprintf() instead of
> snprintf().
> 
> Fixes: c6e3fd22cd53 ("Staging: add speakup to the staging directory")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

> ---
> I guess that the -1 in the 2nd snprintf() call is here to overwrite the
> ending \n.
> ---
>  drivers/accessibility/speakup/kobjects.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility/speakup/kobjects.c
> index a7522d409802..1eea7c492875 100644
> --- a/drivers/accessibility/speakup/kobjects.c
> +++ b/drivers/accessibility/speakup/kobjects.c
> @@ -92,9 +92,9 @@ static void report_char_chartab_status(int reset, int received, int used,
>  	if (reset) {
>  		pr_info("%s reset to defaults\n", object_type[do_characters]);
>  	} else if (received) {
> -		len = snprintf(buf, sizeof(buf),
> -			       " updated %d of %d %s\n",
> -			       used, received, object_type[do_characters]);
> +		len = scnprintf(buf, sizeof(buf),
> +				" updated %d of %d %s\n",
> +				used, received, object_type[do_characters]);
>  		if (rejected)
>  			snprintf(buf + (len - 1), sizeof(buf) - (len - 1),
>  				 " with %d reject%s\n",
> -- 
> 2.34.1
