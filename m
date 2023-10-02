Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7E67B4FCE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbjJBKAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjJBJ7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:59:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947E41BEE;
        Mon,  2 Oct 2023 02:59:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85311C433C7;
        Mon,  2 Oct 2023 09:59:18 +0000 (UTC)
Message-ID: <49b1fe75-529d-4663-9e83-b9463d45b0a3@xs4all.nl>
Date:   Mon, 2 Oct 2023 11:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] media: platform: cros-ec: Add Taranza to the match table
Content-Language: en-US, nl
To:     Ken Lin <ken_lin5@hotmail.com>, LKML <linux-kernel@vger.kernel.org>
Cc:     groeck@chromium.org, Benson Leung <bleung@chromium.org>,
        Kevin Chiu <kevin.chiu.17802@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Reka Norman <rekanorman@chromium.org>,
        Rory Liu <hellojacky0226@hotmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Zoey Wu <zoey_wu@wistron.corp-partner.google.com>,
        chrome-platform@lists.linux.dev, linux-media@vger.kernel.org
References: <KL1PR01MB380907A7B0AD8A53727F87E2AEF7A@KL1PR01MB3809.apcprd01.prod.exchangelabs.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <KL1PR01MB380907A7B0AD8A53727F87E2AEF7A@KL1PR01MB3809.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 13:30, Ken Lin wrote:
> Taranza has two HDMI ports which support CEC:
> Port D is EC port 0
> Port B is EC port 1
> 
> Signed-off-by: Ken Lin <ken_lin5@hotmail.com>
> ---
> 
> Changes in v2:
>  Use a NULL-terminated conns array for the match table entry
> ---
>  drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> index 920aed0d1929..66e96abc9abf 100644
> --- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> +++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> @@ -298,6 +298,7 @@ static const char *const fizz_conns[] = { "Port B", NULL };
>  static const char *const dibbi_conns[] = { "Port D", "Port B", NULL };
>  static const char *const constitution_conns[] = { "Port B", "Port A", NULL };
>  static const char *const boxy_conns[] = { "Port D", NULL };
> +static const char *const taranza_conns[] = { "Port D", "Port B", NULL };

Just reuse dibbi_conns, just as is done with fizz_conns.

Actually, what would be better is to rename these _conns arrays to something
like:

static const char *const port_db_conns[] = { "Port D", "Port B", NULL };

That's much cleaner IMHO.

Can you post a small patch series? The first renames these conns arrays,
the second adds Taranza support.

Thank you!

	Hans

>  
>  static const struct cec_dmi_match cec_dmi_match_table[] = {
>  	/* Google Fizz */
> @@ -322,6 +323,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
>  	{ "Google", "Constitution", "0000:00:02.0", constitution_conns },
>  	/* Google Boxy */
>  	{ "Google", "Boxy", "0000:00:02.0", boxy_conns },
> +	/* Google Taranza */
> +	{ "Google", "Taranza", "0000:00:02.0", taranza_conns },
>  };
>  
>  static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,

