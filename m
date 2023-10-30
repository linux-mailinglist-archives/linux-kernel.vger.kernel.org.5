Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B297DB573
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjJ3Itw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJ3Itt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:49:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4F39D;
        Mon, 30 Oct 2023 01:49:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc0d0a0355so24667465ad.3;
        Mon, 30 Oct 2023 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698655787; x=1699260587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LTZiBHO/bcyQoF82GzeeiMxWv9nC9/4IT5S7HkUIiUE=;
        b=DFXLV3UYxVc7NG5BA5Ynl4LyUPNEJp6Bm300p53E87GnhHx8GdZ/T/BlvCnBdjlDBx
         WdTDBvbP2pWyxiEzcfsXevtI5fCCbxWH2rXcDtA9baTgsY42rN7BfoY6pHk/nHhOa1LW
         ySj3+E5yPIheXW+g6hX2LCv7iY5HTJauYNBHFNmTJx2nGlAddE5GBMFNkJ1kTmmTTAQC
         A9KypNtnCx52IdLa5YEtox2U6Lv29c13r5yPThlebmtWVMPNcdxJpsWWilG5S+SgL3Rx
         gW8XDBiczV5RZl2Y8FKHvxWFH50G0U6Szb8dfJ0wOqjKNVG00+nGrP39lKUGAnG5uPz4
         ISNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698655787; x=1699260587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTZiBHO/bcyQoF82GzeeiMxWv9nC9/4IT5S7HkUIiUE=;
        b=a+UfnHQ5iY6Ga013S+/Qx4rxvQdEWTl77HA2utDqTtGl1i2vIaMFUnHdZTyxMYkEv9
         rujGaxVwtFQpR+VNCxFSv9r3fCcvx95l5Pw6thARsJbg0OyBWnfJj2uz1jENcOD9E6fS
         AFjEVaGDCI8afysQh5u9j0NRKPyUJo0PMeu/dixTO6IxLrYcrSyTe21Bzct7qrZDShrs
         OYlPuUX26nOWPIvvH19ifTdFcdTxXzhkP+UAMq/3VEHcPMnfnwTC1HbKl7OaNT4ylA32
         haI4KX8/3z8Vz6U5xjqO8sCUZqscZLBpT5c2fmGx4QFYGhsb1qKCRfUsdCza67P1tgry
         xRRA==
X-Gm-Message-State: AOJu0Yx9IduPamuFuk8G7bvT9GcdBa4tfq3+W2Gkof+rhtgbXzARgcEW
        yLfh0z7Lb5NOKsL2/0xZzkM=
X-Google-Smtp-Source: AGHT+IGcyGfbxIKfrCw66ui0EgwGDUWqZJg6i/OKXwBfNICtZCy+YCkcfoGpSm01KhDRVWKdbmM1yA==
X-Received: by 2002:a17:902:6803:b0:1c9:ca02:645c with SMTP id h3-20020a170902680300b001c9ca02645cmr6399819plk.36.1698655786724;
        Mon, 30 Oct 2023 01:49:46 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:201:4be2:e81c:ea48:aaac])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902dacd00b001bc2831e1a8sm5808793plx.80.2023.10.30.01.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 01:49:46 -0700 (PDT)
Date:   Mon, 30 Oct 2023 08:49:40 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.satterthwaite@touchnetix.com,
        bartp@baasheep.co.uk, hannah.rossiter@touchnetix.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v3 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <ZT9uJMExvf7B0gtR@google.com>
References: <20231012074034.1090436-1-kamel.bouhara@bootlin.com>
 <20231012074034.1090436-4-kamel.bouhara@bootlin.com>
 <20231020120310.vrn6ew3fcg5e545w@pengutronix.de>
 <20231022193529.GC3072@kb-xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022193529.GC3072@kb-xps>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 09:35:29PM +0200, Kamel Bouhara wrote:
> On Fri, Oct 20, 2023 at 02:03:10PM +0200, Marco Felsch wrote:
> > > +
> > > +static int
> > > +axiom_i2c_write(struct i2c_client *client, u8 usage, u8 page, u8 *buf, u16 len)
> > > +{
> > > +	struct axiom_data *ts = i2c_get_clientdata(client);
> > > +	struct axiom_cmd_header cmd_header;
> > > +	struct i2c_msg msg[2];
> > > +	int ret;
> > > +
> > > +	cmd_header.target_address = cpu_to_le16(usage_to_target_address(ts, usage, page, 0));
> > > +	cmd_header.length = cpu_to_le16(len);
> > > +	cmd_header.read = 0;
> > > +
> > > +	msg[0].addr = client->addr;
> > > +	msg[0].flags = 0;
> > > +	msg[0].len = sizeof(cmd_header);
> > > +	msg[0].buf = (u8 *)&cmd_header;
> > > +
> > > +	msg[1].addr = client->addr;
> > > +	msg[1].flags = 0;
> > > +	msg[1].len = len;
> > > +	msg[1].buf = (char *)buf;
> >
> > Please check the "comms protocol app note", for write it is not allowed
> > to send a stop, so the whole data must be send in one i2c_msg.
> >
> 
> Well I only have the "Programmer's Guide", I'll have to check that as it
> really seems to works as it yet.

As far as I know we only send "stop" on the last message in a sequence
of messages in i2c_transfer() unless it is explicitly requested with
I2C_M_STOP flag.

...
> > > +
> > > +static void axiom_i2c_remove(struct i2c_client *client)
> > > +{
> > > +	struct axiom_data *ts = i2c_get_clientdata(client);
> > > +
> > > +	input_unregister_device(ts->input_dev);
> >
> > This can be part of devm_add_action_or_reset() and we could remove the
> > .remove() callback for this driver.
> >
> 
> Sure, thanks for the tips :)!

Actually input devices allocated with devm do not need to be explicitly
inregistered, so you do not need to bother with
devm_add_action_or_reset() and simply delete axiom_i2c_remove().

Thanks.

-- 
Dmitry
