Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015157AD318
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjIYIPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjIYIPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:15:17 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACECE6B;
        Mon, 25 Sep 2023 01:14:43 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 78D0013C5;
        Mon, 25 Sep 2023 10:13:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695629581;
        bh=UayU5lkKf30RwZHdj36MVC/jnuYHI1+ittUZYokTGlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpIdGXb5Nz4TdNxofbbT8FN6Jtz+yOCoi/j+Js7k7YjqS3LXuzZxG5hUrSj/QpjNr
         YQyDuokVLHdMpBXcPrY9SMjvrqxoNOoS0hqdfkotQv1NwhUbwL2hmY8IvJ3T1Jb55P
         J5vcoOPtDQuFO5D5Nz4koSR1yaIG7PZSxOJioyOg=
Date:   Mon, 25 Sep 2023 11:14:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 17/17] media: qcom: camss: Comment CSID dt_id field
Message-ID: <20230925081452.GA8583@pendragon.ideasonboard.com>
References: <20230911131411.196033-1-bryan.odonoghue@linaro.org>
 <20230911131411.196033-18-bryan.odonoghue@linaro.org>
 <1e815d41-719a-4ca1-98e3-872f882ed03e@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e815d41-719a-4ca1-98e3-872f882ed03e@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 09:11:52AM +0200, Hans Verkuil wrote:
> On 11/09/2023 15:14, Bryan O'Donoghue wrote:
> > Digging into the documentation we find that the DT_ID bitfield is used to
> > map the six bit DT to a two bit ID code. This value is concatenated to the
> > VC bitfield to create a CID value. DT_ID is the two least significant bits
> > of CID and VC the most significant bits.
> > 
> > Originally we set dt_id = vc * 4 in and then subsequently set dt_id = vc.
> > 
> > commit 3c4ed72a16bc ("media: camss: sm8250: Virtual channels for CSID")
> > silently fixed the multiplication by four which would give a better
> > value for the generated CID without mentioning what was being done or why.
> > 
> > Next up I haplessly changed the value back to "dt_id = vc * 4" since there
> > didn't appear to be any logic behind it.
> > 
> > Hans asked what the change was for and I honestly couldn't remember the
> > provenance of it, so I dug in.
> > 
> > Link: https://lore.kernel.org/linux-arm-msm/edd4bf9b-0e1b-883c-1a4d-50f4102c3924@xs4all.nl/
> > 
> > Add a comment so the next hapless programmer doesn't make this same
> > mistake.
> > 
> > Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > ---
> >  drivers/media/platform/qcom/camss/camss-csid-gen2.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> > index 6ba2b10326444..cee50fc87e9de 100644
> > --- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> > +++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> > @@ -352,6 +352,11 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
> >  		phy_sel = csid->phy.csiphy_id;
> >  
> >  	if (enable) {
> > +		/*
> > +		 * A value caled 'CID' gets generated internal to CAMSS logic
> 
> caled -> called
> 
> > +		 * which is a concatenation of [vc:6 | dt_id:2] hence we reuse
> 
> vc:6? Do you mean bit 6 or do you mean the least significant 6 bits?
> 
> Regardless, since the vc variable <= 3 (since MSM_CSID_MAX_SRC_STREAMS is 4),
> either interpretation makes little sense.

More recent versions of CSI-2 support up to 6 bits of VC (or possibly
even more in versions I may not know about). It would probably make
sense to write vc[5:0] | dt_id[1:0] or something similar.

> And what does "DT" stand for?

Data Type.

> > +		 * the least significant two bits of the VC to 'stuff' the CID value.
> > +		 */
> >  		u8 dt_id = vc;
> 
> If dt_id should be the least significant two bits of vc, shouldn't
> this say: "= vc & 3;"? Or, alternatively, have a comment that vc <= 3?
> 
> >  
> >  		if (tg->enabled) {

-- 
Regards,

Laurent Pinchart
