Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA1F8076B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442593AbjLFRhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379706AbjLFRhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:37:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478BB135
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:37:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C073BC433C8;
        Wed,  6 Dec 2023 17:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701884226;
        bh=RwGl1RcbRMFQzj6CBreX5lxtcFVvuIjpzUngRG0hqos=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eR0IQyF+WPhSu4l5rp7kF48UTVIGmAiTFX/GMhnMPr0B0/ZVqF++kGvQNdoDpe+as
         zBJQw36pOwMnt9UxEvj74ihTS9/HKIhX1RIlEnF/TYlmqmDPXqtWmn68iYoYW2XL+w
         CvF6iT4uJmozZrYFNjHZc6IcH+t0PqmEl8A2hc+IPcLoINiAmobLlS/8+TOc7ZL7PW
         SWwf6qcGPKUNI+GKVDwsxdcew8exJFK4HP+qmiOteQRomkA0RYU3hSrqaamwrK4SrN
         DYWZ7b6bPIyIc4cNzl634W55cdqpIlKeYB1xBJfPNOF2VE10OCDoMHcbhqj4K97uXZ
         BHMccci2Ama6g==
Date:   Wed, 6 Dec 2023 17:36:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, conor+dt@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: temperature: Add support for AMS AS6200
Message-ID: <20231206173658.57b00a49@jic23-huawei>
In-Reply-To: <ZW6IArKhx4KvxyTD@abdel>
References: <20231202041651.719963-1-alkuor@gmail.com>
        <20231202041651.719963-2-alkuor@gmail.com>
        <20231204135014.15ea47b6@jic23-huawei>
        <ZW6IArKhx4KvxyTD@abdel>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 21:16:34 -0500
Abdel Alkuor <alkuor@gmail.com> wrote:

> On Mon, Dec 04, 2023 at 01:50:14PM +0000, Jonathan Cameron wrote:
> > On Fri,  1 Dec 2023 23:16:51 -0500
> > Abdel Alkuor <alkuor@gmail.com> wrote:
> >   
> > > as6200 is a high accuracy temperature sensor of 0.0625C with a range
> > > between -40 to 125 Celsius degrees.
> > > 
> > > The driver implements the alert trigger event in comparator mode where
> > > consecutive faults are converted into periods, high/low temperature
> > > thresholds require to be above/below the set limit for n seconds for
> > > the alert to be triggered/cleared. The alert is only cleared when the
> > > current temperature is below the low temperature threshold for n seconds.
> > > 
> > > The driver supports the following:
> > > - show available sampling frequencey
> > > - read/write sampling frequency
> > > - read raw temperature
> > > - read scaling factor
> > > - read/write temperature period that needs to be met for low/high
> > >   temperature thresholds to trigger an alert
> > > - show available temperature period thresholds
> > > - buffer trigger
> > > - temperature alert event trigger  
> > 
> > Hi Abdel,
> > 
> > A few comments inline. Looking good in general.
> >  
> Hi Jonathon,
> 
> Thank you for your time. I have a couple _silly_ questions about the tag
> and returning from if else. Other than that, your comments will be addressed
> in v3.
> > > 
> > > Datasheet: https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> > >   
> > 
> > No blank line here.  Tags block (and Datasheet is a tag) never has blank lines
> > as that breaks some existing tooling.
> >   
> Understood. 
> 
> P.S. when running checkpatch.pl on this patch, I get the following warning:
> 
> WARNING: Unknown link reference 'Datasheet:', use 'Link:' or 'Closes:' instead
> 
> should I use Link instead?

Nah. Just ignore checkpatch. :)

Also, if just accepting a comment, no need to say so.  Assumption of reviewer
is that if you keep quiet on a particular comment you will have it fixed in next
version.  Crop out that section of the email and only keep the bits that
you want the reviewer to see your comments on.

Hopefully I've cropped it appropriately!

> > > Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> > > +	if (info == IIO_EV_INFO_VALUE) {
> > > +		*val = sign_extend32(FIELD_GET(AS6200_TEMP_MASK, tmp), 11);
> > > +		ret = IIO_VAL_INT;  
> > return here.
> >   
> > > +	} else {
> > > +		cf = FIELD_GET(AS6200_CONFIG_CF, tmp);
> > > +		cr = FIELD_GET(AS6200_CONFIG_CR, tmp);
> > > +		*val = as6200_temp_thresh_periods[cr][cf][0];
> > > +		*val2 = as6200_temp_thresh_periods[cr][cf][1];
> > > +		ret = IIO_VAL_INT_PLUS_MICRO;  
> > 
> > and here.  If there is nothing more to be done, it simplifies the code
> > flow being read to just return as quick as possible.
> >  
> I did it as you mentioned, and when running check_patch.pl, it gives back a
> warning that else is not needed here because of the return in the if
> statement. So I opted into using ret instead, should I remove the else or ignore
> the warning?

Dropping the else is fine or take the view it's wrong and ignore it.
Checkpatch is providing hints and suggestions on where to double check.
There is no requirement to accept it's suggestions if you feel the
code ends up less readable.

> > > +	}
> > > +
> > > +	return ret;
