Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021D57D7499
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjJYTnh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 15:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYTng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:43:36 -0400
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de [80.67.18.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B59C137;
        Wed, 25 Oct 2023 12:43:32 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qvjmp-00019n-1N;
        Wed, 25 Oct 2023 21:43:27 +0200
Message-ID: <fa4afea49b33fb20c1c6b46a65d73912c96fdaa7.camel@apitzsch.eu>
Subject: Re: [PATCH 2/4] media: i2c: imx214: Move controls init to separate
 function
From:   =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Date:   Wed, 25 Oct 2023 21:43:25 +0200
In-Reply-To: <kdp6brzqdllnyokwsalkpsbjl6cfnpv62gojfp3xoilsurphke@qqqa4gufb7xf>
References: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu>
         <20231023-imx214-v1-2-b33f1bbd1fcf@apitzsch.eu>
         <kdp6brzqdllnyokwsalkpsbjl6cfnpv62gojfp3xoilsurphke@qqqa4gufb7xf>
Autocrypt: addr=git@apitzsch.eu; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 24.10.2023 um 09:22 +0200 schrieb Jacopo Mondi:
> Hi Andre'
> 
> On Mon, Oct 23, 2023 at 11:47:51PM +0200, André Apitzsch wrote:
> > Code refinement, no functional changes.
> > 
> > Signed-off-by: André Apitzsch <git@apitzsch.eu>
> > ---
> >  drivers/media/i2c/imx214.c | 111 ++++++++++++++++++++++++++-------
> > ------------
> >  1 file changed, 64 insertions(+), 47 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/imx214.c
> > b/drivers/media/i2c/imx214.c
> > index 9218c149d4c8..554fc4733128 100644
> > --- a/drivers/media/i2c/imx214.c
> > +++ b/drivers/media/i2c/imx214.c
> > @@ -695,6 +695,68 @@ static const struct v4l2_ctrl_ops
> > imx214_ctrl_ops = {
> >  	.s_ctrl = imx214_set_ctrl,
> >  };
> > 
> > +static int imx214_ctrls_init(struct imx214 *imx214)
> > +{
> > +	static const s64 link_freq[] = {
> > +		IMX214_DEFAULT_LINK_FREQ
> > +	};
> > +	static const struct v4l2_area unit_size = {
> > +		.width = 1120,
> > +		.height = 1120,
> > +	};
> > +	struct v4l2_ctrl_handler *ctrl_hdlr;
> > +	int ret;
> > +
> > +	ctrl_hdlr = &imx214->ctrls;
> > +	ret = v4l2_ctrl_handler_init(&imx214->ctrls, 3);
> 
> I know it was already like this, but you could take occasion to
> pre-allocate enough control slots. I count 4 here, plus the 2 parsed
> from system firware in the next patch.
> 
> You can change this here and mention it in the commit message or with
> a separate patch on top. Up to you!
> 
I will add it to the next patch ("Read orientation and rotation from
system firmware"). As it should be increased there anyway. Hope that's
fine.

> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	imx214->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, NULL,
> > +					      
> > V4L2_CID_PIXEL_RATE, 0,
> > +					      
> > IMX214_DEFAULT_PIXEL_RATE, 1,
> > +					      
> > IMX214_DEFAULT_PIXEL_RATE);
> > +
> > +	imx214->link_freq = v4l2_ctrl_new_int_menu(ctrl_hdlr,
> > NULL,
> > +						  
> > V4L2_CID_LINK_FREQ,
> > +						  
> > ARRAY_SIZE(link_freq) - 1,
> > +						   0, link_freq);
> > +	if (imx214->link_freq)
> > +		imx214->link_freq->flags |=
> > V4L2_CTRL_FLAG_READ_ONLY;
> > +
> > +	/*
> > +	 * WARNING!
> > +	 * Values obtained reverse engineering blobs and/or
> > devices.
> > +	 * Ranges and functionality might be wrong.
> > +	 *
> > +	 * Sony, please release some register set documentation
> > for the
> > +	 * device.
> > +	 *
> > +	 * Yours sincerely, Ricardo.
> > +	 */
> > +	imx214->exposure = v4l2_ctrl_new_std(ctrl_hdlr,
> > &imx214_ctrl_ops,
> > +					     V4L2_CID_EXPOSURE,
> > +					     IMX214_EXPOSURE_MIN,
> > +					     IMX214_EXPOSURE_MAX,
> > +					     IMX214_EXPOSURE_STEP,
> > +					    
> > IMX214_EXPOSURE_DEFAULT);
> > +
> > +	imx214->unit_size = v4l2_ctrl_new_std_compound(ctrl_hdlr,
> > +				NULL,
> > +				V4L2_CID_UNIT_CELL_SIZE,
> > +				v4l2_ctrl_ptr_create((void
> > *)&unit_size));
> > +
> > +	ret = ctrl_hdlr->error;
> > +	if (ret) {
> > +		v4l2_ctrl_handler_free(ctrl_hdlr);
> > +		return dev_err_probe(imx214->dev, ret, "failed to
> > add controls\n");
> 
> dev_err_probe won't help I think, or could ctrl_hdr->error be
> -EPROBE_DEFER ? Not a big deal though!

dev_err_probe() is used by imx415 (the latest added imx* driver).
That's why I used it, too.

André
> 
> All minor comments, with these addressed
> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> 
> Thanks
>   j
> 
